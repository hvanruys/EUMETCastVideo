QT += core gui network widgets printsupport

CONFIG += c++11 console
CONFIG -= app_bundle

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
unix:TARGET = ../deployEUMETCastView/EUMETCastVideo

SOURCES += main.cpp \
    generalverticalperspective.cpp \
    geoseglist.cpp \
    globals.cpp \
    rssvideo.cpp \
    msgdataaccess.cpp \
    msgfileaccess.cpp \
    gshhsdata.cpp \
    pixgeoconversion.cpp \
    QSgp4/Matrices.cpp \
    QSgp4/qeci.cpp \
    QSgp4/qobserver.cpp \
    QSgp4/qsgp4.cpp \
    QSgp4/qsgp4date.cpp \
    QSgp4/qtle.cpp \
    QSgp4/qsun.cpp \
    QSgp4/sgp_math.cpp \
    QSgp4/sgp_time.cpp \
    xmlvideoreader.cpp


DISTFILES += \
    example.xml \
    EUMETCastVideo.xml

HEADERS += \
    generalverticalperspective.h \
    geoseglist.h \
    rssvideo.h \
    msgdataaccess.h \
    msgfileaccess.h \
    gshhsdata.h \
    gshhs.h \
    pixgeoconversion.h \
    globals.h \
    QSgp4/Matrices.h \
    QSgp4/qeci.h \
    QSgp4/qgeocentric.h \
    QSgp4/qgeodetic.h \
    QSgp4/qobserver.h \
    QSgp4/qsgp4.h \
    QSgp4/qsgp4date.h \
    QSgp4/qsgp4globals.h \
    QSgp4/qsgp4utilities.h \
    QSgp4/qtle.h \
    QSgp4/qtopocentric.h \
    QSgp4/Vectors.h \
    QSgp4/qsun.h \
    xmlvideoreader.h



unix:INCLUDEPATH += ../EUMETCastView/meteosatlib
#unix:LIBS += -lpthread -lz -lfreeimage
unix:LIBS += -L$$_PRO_FILE_PWD_/../EUMETCastView/libs/linux_gplusplus/release -lmeteosat -lbz2 -lhdf5_serial -larchive
#unix:LIBS += -L/usr/lib/x86_64-linux-gnu/ -lnetcdf
unix:LIBS += -L$$_PRO_FILE_PWD_/../EUMETCastView/PublicDecompWT_2.7.2-master/DISE -lDISE
unix:LIBS += -L$$_PRO_FILE_PWD_/../EUMETCastView/PublicDecompWT_2.7.2-master/COMP/JPEG/Src -lJPEG
unix:LIBS += -L$$_PRO_FILE_PWD_/../EUMETCastView/PublicDecompWT_2.7.2-master/COMP/WT/Src -lWT
unix:LIBS += -L$$_PRO_FILE_PWD_/../EUMETCastView/PublicDecompWT_2.7.2-master/COMP/T4/Src -lT4
unix:LIBS += -L$$_PRO_FILE_PWD_/../EUMETCastView/PublicDecompWT_2.7.2-master/COMP/Src -lCOMP

RESOURCES += \
    xml.qrc
