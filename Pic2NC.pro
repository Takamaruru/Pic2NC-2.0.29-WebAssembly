QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++17

win32: CONFIG += static

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    src/cuttingpoint.cpp \
    src/drawingmousescene.cpp \
    src/imageprocessing.cpp \
    src/main.cpp \
    src/mainwindow.cpp \
    src/ncdata.cpp

HEADERS += \
    src/cuttingpoint.h \
    src/drawingmousescene.h \
    src/imageprocessing.h \
    src/mainwindow.h \
    src/ncdata.h

FORMS += \
    mainwindow.ui

win32 {
    # TWAINスキャナ (Windowsのみ)
    SOURCES += src/scannertwain.cpp
    HEADERS += src/scannertwain.h src/twain.h

    INCLUDEPATH += C:\OpenCV\opencv4.6.0\build_vs15\include
    #LIBS += C:\OpenCV\opencv4.6.0\release\lib\libopencv_calib3d460.dll.a
    LIBS += C:\OpenCV\opencv4.6.0\release\lib\libopencv_core460.dll.a
    #LIBS += C:\OpenCV\opencv4.6.0\release\lib\libopencv_dnn460.dll.a
    #LIBS += C:\OpenCV\opencv4.6.0\release\lib\libopencv_features2d460.dll.a
    #LIBS += C:\OpenCV\opencv4.6.0\release\lib\libopencv_flann460.dll.a
    #LIBS += C:\OpenCV\opencv4.6.0\release\lib\libopencv_highgui460.dll.a
    #LIBS += C:\OpenCV\opencv4.6.0\release\lib\libopencv_imgcodecs460.dll.a
    LIBS += C:\OpenCV\opencv4.6.0\release\lib\libopencv_imgproc460.dll.a
    #LIBS += C:\OpenCV\opencv4.6.0\release\lib\libopencv_ml460.dll.a
    #LIBS += C:\OpenCV\opencv4.6.0\release\lib\libopencv_objdetect460.dll.a
    #LIBS += C:\OpenCV\opencv4.6.0\release\lib\libopencv_photo460.dll.a
    #LIBS += C:\OpenCV\opencv4.6.0\release\lib\libopencv_stitching460.dll.a
    #LIBS += C:\OpenCV\opencv4.6.0\release\lib\libopencv_ts460.a
    #LIBS += C:\OpenCV\opencv4.6.0\release\lib\libopencv_video460.dll.a
    #LIBS += C:\OpenCV\opencv4.6.0\release\lib\libopencv_videoio460.dll.a
}

macx {
    # OpenCVはHomebrewでインストール: brew install opencv
    OPENCV_PREFIX = /opt/homebrew/opt/opencv
    !exists($$OPENCV_PREFIX): OPENCV_PREFIX = /usr/local/opt/opencv
    LIBS += -L$$OPENCV_PREFIX/lib -lopencv_core -lopencv_imgproc
    exists($$OPENCV_PREFIX/include/opencv5) {
        # OpenCV 5以降はSubdiv2Dがgeometryモジュールに移動した
        INCLUDEPATH += $$OPENCV_PREFIX/include/opencv5
        LIBS += -lopencv_geometry
    } else {
        INCLUDEPATH += $$OPENCV_PREFIX/include/opencv4
    }

    ICON = resource/pic2nc.icns
}

wasm {
    # OpenCVはEmscriptenでビルドしたものを使う (core, imgproc)
    OPENCV_WASM_PREFIX = $$(HOME)/opencv-wasm/install
    INCLUDEPATH += $$OPENCV_WASM_PREFIX/include/opencv4
    LIBS += -L$$OPENCV_WASM_PREFIX/lib -lopencv_imgproc -lopencv_core
    LIBS += -L$$OPENCV_WASM_PREFIX/lib/opencv4/3rdparty -lzlib

    # QMessageBox::exec() などのモーダルダイアログを動かすために必要
    QMAKE_LFLAGS += -sASYNCIFY -Os
}

RC_ICONS = resource/pic2nc.ico

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    CHANGELOG.md
