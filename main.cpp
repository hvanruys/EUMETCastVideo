#include <QApplication>
#include <QDebug>
#include <QDir>
#include <QImage>
#include <QtConcurrent/QtConcurrent>
#include "rssvideo.h"
#include "QSgp4/qsun.h"
#include "QSgp4/qeci.h"
#include "QSgp4/qobserver.h"

void DeletePNGFiles()
{
    QDir workingdir(".");
    QStringList filters;
    filters << "*.png";
    workingdir.setNameFilters(filters);
    QFileInfoList fileinfolist;

    workingdir.setFilter(QDir::Files | QDir::NoSymLinks);
    workingdir.setSorting(QDir::Name);
    fileinfolist = workingdir.entryInfoList();
    for (int i = 0; i < fileinfolist.size(); ++i)
    {
        QFile pngfile(fileinfolist.at(i).fileName());
        if(pngfile.remove())
            qDebug() << QString("Deleting png files : %1").arg(fileinfolist.at(i).fileName());
    }

}

int main(int argc, char *argv[])
{

    QStringList datelist;
    QStringList pathlist;

    QApplication a(argc, argv);

    DeletePNGFiles();

    RSSVideo video(":/EUMETCastVideo.xml");

    if(video.reader->daykindofimage.length() == 0)
    {
        qDebug() << "Wrong parameters !";
        return 1;
    }

    video.getDatePathVectorFromDir(&datelist, &pathlist);

//        for(int i = 0; i < datelist.count(); i++)
//        {
//            qDebug() << datelist.at(i) << pathlist.at(i);
//        }


    int threadcount = QThread::idealThreadCount();

    qDebug() << "ideal threadcount = " << threadcount;
    qDebug() << "datelist count = " << datelist.count();

    if(datelist.count() == 0)
    {
        qDebug() << "No segments found !";
        return 0;
    }

    bool videofound = false;

    if(video.reader->singlefile.length() > 0)
    {
        for(int i = 0; i < datelist.count(); i++)
        {
            if(video.reader->singlefile == datelist.at(i))
            {
                video.compileImage(datelist.at(i), pathlist.at(i), i);
                videofound = true;
                break;
            }
        }
        if(!videofound)
            qDebug() << "singlefile " << video.reader->singlefile << " not found !";

    }
    else
    {
        QThreadPool::globalInstance()->setMaxThreadCount(video.reader->threadcount);
        QFuture<void> future[datelist.count()];
        for(int i = 0; i < datelist.count(); i++)
        {
            future[i] = QtConcurrent::run(&RSSVideo::doCompileImage, &video, datelist.at(i), pathlist.at(i), i);
        }
        for(int i = 0; i < datelist.count(); i++)
        {
            future[i].waitForFinished();
            qDebug() << "image " << i << " of " << datelist.count() << " is finished";
        }



        QProcess process;
        process.setProgram("ffmpeg");
        QString res = QString("%1x%2").arg(video.reader->videowidth).arg(video.reader->videoheight);
        QString videooutput = video.reader->videooutputname + ".mp4";
        process.setArguments({"-r", "10", "-f", "image2", "-i", "proj%04d.png", "-s" , res, "-vcodec", "libx264", "-crf", "10", "-pix_fmt", "yuv420p", "-y", videooutput});
        process.setStandardOutputFile("ouput.txt");
        process.setStandardErrorFile("outputerror.txt"); //QProcess::nullDevice());
        process.start();
        process.waitForFinished(-1);
    }

    qDebug() << "==============einde==================== ";


    return 0; //a.exec();
}

