#include "minigui.ch"
#include "ide.ch"

STATIC FUNCTION Upgrade()
#pragma __binarystreaminclude "\Restart\Restart.exe" | RETURN %s

*------------------------------------------------------------*
PROCEDURE Update()
*------------------------------------------------------------*
   LOCAL cPath AS STRING := GetStartupFolder()

   IF MsgYesNo( "You're going to download updates from www.hmgextended.com"    + CRLF +        ;
                "The new files will be placed into '\IDE\UPDATES' directory."  + CRLF + CRLF + ;
                "Please note that any newer source files with the same name, " + CRLF +        ;
                "already existing inside this folder will not be overwritten," + CRLF + CRLF + ;
                "Are you sure you want to proceed?", "UPDATE FROM WEB", .T., NIL, .T. )

      If IsActiveJobs()
         IF !MsgYesNo( "Your current job will been discarded!"+ CRLF + CRLF + ;
                       "Are you sure you want to proceed?", "Warning!", .T., NIL, .T. )
            Return
         Endif
      Endif

      DownloadFromWWW( "http://www.hmgextended.com/files/HMGS-IDE/ide.zip", cPath + "\ide.zip", NIL )

   ENDIF

RETURN


*------------------------------------------------------------*
FUNCTION IsActiveJobs() // 10/03/2018 Pierpaolo Martinello
*------------------------------------------------------------*
   lOCAL Rtv As LOGICAL := .F.
   lOCAL aj_1 AS NUMERIC
   lOCAL aj_2 AS NUMERIC
   lOCAL aj_3 AS NUMERIC
   lOCAL aj_4 AS NUMERIC
   lOCAL aj_5 AS NUMERIC

   aj_1 := GetProperty("ProjectBrowser","xlist_1","ItemCount")
   aj_2 := GetProperty("ProjectBrowser","xlist_2","ItemCount")
   aj_3 := GetProperty("ProjectBrowser","xlist_3","ItemCount")
   aj_4 := GetProperty("ProjectBrowser","xlist_4","ItemCount")
   aj_5 := GetProperty("ProjectBrowser","xlist_5","ItemCount")

   Rtv := (aj_1 + aj_2 + aj_3 + aj_4 + aj_5 ) > 0

RETURN Rtv


*------------------------------------------------------------*
PROCEDURE DownloadFromWWW( cURL AS STRING, cLocalFileName AS STRING )
*------------------------------------------------------------*
   LOCAL oCon  AS OBJECT
   LOCAL oUrl  AS OBJECT
   LOCAL nResp AS LOGICAL  //? Invalid Hungarian

   IF IsWindowDefined( "Form_Upd" )
      RETURN
   ENDIF

   cLocalFileName := AllTrim( cLocalFileName )
   nResp          := isInternet()

   IF nResp = .F.
      MsgBox( "Internet is not connected. Update is aborted" )
      RETURN
   ENDIF
   // 17/02/2018 Pierpaolo Martinello
   // is required urlmon.lib for compile (Borland) or liburlmon.a (Mingw)

   IF ! URLDownloadToFile(cUrl, cLocalFileName )
      MsgExclamation("Can not download:" + CRLF + cUrl)
      RETURN
   ENDIF

  /* 13/03/2018 Pierpaolo Martinello Renowned form_2 in form_upd for prevent conflicts
   and involuntary closures of the form that causes the crash of the ide */

  DEFINE WINDOW Form_Upd ;
         AT         0, 0 ;
         WIDTH      400 HEIGHT 215 ;
         TITLE      "Extracting sources of HMGS_IDE to \Updates folder" ;
         NOSYSMENU ;
         FONT       "Arial" SIZE 9;
         ON INIT    UNZIPFile()

     DEFINE PROGRESSBAR ProgressBar_1
        ROW        60
        COL        45
        WIDTH      310
        HEIGHT     30
        RANGEMIN   0
        RANGEMAX   10
        VALUE      0
        FORECOLOR  {0,130,0}
     END PROGRESSBAR

     DEFINE LABEL        Label_1
        ROW         100
        COL         25
        WIDTH       350
        HEIGHT      20
        VALUE       ""
        FONTNAME    "Arial"
        FONTSIZE    10
        TOOLTIP     ""
        FONTBOLD    .T.
        TRANSPARENT .T.
        CENTERALIGN .T.
     END LABEL

     ON KEY ESCAPE ACTION Form_Upd.Release

  END WINDOW

  CENTER   WINDOW Form_Upd

  ACTIVATE WINDOW Form_Upd

RETURN


*------------------------------------------------------------*
PROCEDURE UnzipFile()
*------------------------------------------------------------*
  LOCAL cCurDir  := GetStartupFolder()
  LOCAL cArchive := cCurDir + "\ide.zip"
  LOCAL dDate, cTime, lSuccess, cSubDir

   LOCAL aFiles := hb_GetFilesInZip( cArchive )
   LOCAL cExtractDir := "Updates\"

  Form_Upd.ProgressBar_1.RangeMin := 1
  Form_Upd.ProgressBar_1.RangeMax := Len( HB_GetFilesInZip( cArchive ) ) - 1
/*
  UNCOMPRESS cArchive ;
      EXTRACTPATH cCurDir /*+ "\Updates"*/ /* ;
      BLOCK { | cFile, nPos | ProgressUpdate( nPos, cFile, .T. ) } ;
      RESULT lSuccess ;
      CREATEDIR
*/
   AEval( aFiles, { | e | cSubDir := hb_FNameDir( e ), hb_DirBuild( cCurDir + cSubDir ) } )

   lSuccess := hb_UnZipFile( cArchive , { | cFile, nPos | ProgressUpdate( nPos, cFile, .T. ) } , ;
                             .T. , , cCurDir , aFiles , )
  IF lSuccess

     IF ! hb_vfExists( "Restart.exe" )
        hb_MemoWrit( "Restart.exe", Upgrade() )     // give OS a little time to "see" the newly created file
        hb_IdleSleep( 0.5 )
     ENDIF
if hb_fileexists( cCurDir + 'idenew.exe' )
  if hb_fileexists( cCurDir + 'ideold.exe' ) ; hb_FileDelete( cCurDir + "\IDEOLD.EXE" ) ; endif
  hb_vfRename( cCurDir + "\IDEnew.EXE", cCurDir + "\IDEOLD.EXE" )
endif
     COPY FILE ( cCurDir + "\UPDATES\BIN\IDE.EXE" ) TO ( cCurDir + "\IDENEW.EXE" )

     hb_FGetDateTime( cCurDir + "\UPDATES\BIN\IDE.EXE", @dDate, @cTime )
     hb_FSetDateTime( cCurDir + "\IDENEW.EXE", @dDate, @cTime )

     RestartApp( "Ide.exe" )

     aData[ _DISABLEWARNINGS ] := ".T."
     EXIT()

  ELSE

     MsgStop( "Unzip Error!" )

  ENDIF

RETURN

// 08/03/2018 Pierpaolo Martinello
Function RestartApp( cAppName )

Return WinExec( "restart " + cAppName + " " + hb_ntos(Application.Handle) )


*------------------------------------------------------------*
FUNCTION ProgressUpdate( nPos          AS NUMERIC, ; // Progress Bar position
                         cFile         AS STRING,  ; // Extracted FileName
                         lShowFileName AS LOGICAL  ; // Show FileName flag
                       )
*------------------------------------------------------------*

   IF !IsWindowDefined( "Form_Upd" )
      RETURN( NIL )
   ENDIF

   Default lShowFileName := .F.

   Form_Upd.ProgressBar_1.Value := nPos
   Form_Upd.Label_1.Value       := cFileNoPath( cFile )

   DO EVENTS

   IF lShowFileName
      InKey( .1 )
   ENDIF

RETURN( NIL )


FUNCTION IsInternet( nTimeout )
*******************************************************************************
   LOCAL aAddress, hSocket, lCanConnect


   aAddress := hb_socketResolveINetAddr( "www.google.com", 80 )

   IF Empty( aAddress )
      RETURN .F.
   ENDIF

   hSocket := hb_socketOpen()
   lCanConnect := hb_socketConnect( hSocket, aAddress, hb_defaultValue( nTimeout, 2000 ) )
   hb_socketClose( hSocket )

   RETURN lCanConnect

/*
*------------------------------------------------------------*
FUNCTION IsInternet()
*------------------------------------------------------------*
  LOCAL nEstado   AS NUMERIC
  LOCAL cConexion AS STRING  := ""

  nEstado := InternetGetConnectedStateEx( 0, @cConexion, 0, 0 )

RETURN( nEstado == 1 )


*------------------------------------------------------------*
FUNCTION InternetGetConnectedStateEx( lpdwFlags, lpszConnectionName, dwNameLen, dwReserved )
*------------------------------------------------------------*
  LOCAL uResult
  LOCAL hInstDLL             := LoadLibrary( "WININET.DLL" )
  LOCAL nProcAddr AS NUMERIC := GetProcAddress( hInstDLL, "InternetGetConnectedStateEx" )

   uResult := CallDLL( hInstDLL, nProcAddr, NIL, 4, 4, lpdwFlags, 10, lpszConnectionName, 3, dwNameLen, 4, dwReserved )

   FreeLibrary( hInstDLL )

RETURN uResult

*/
#pragma BEGINDUMP

#include <mgdefs.h>
#include <urlmon.h>
#include <wininet.h>

HB_FUNC( URLDOWNLOADTOFILE )
{
  HRESULT hr = URLDownloadToFile( NULL, hb_parc(1), hb_parc(2), 0, NULL );

  hb_retl( hr == S_OK );
}
HB_FUNC( WINEXEC )
{
   int Mode = ( hb_pcount() > 1 ) ? hb_parni( 2 ) : SW_HIDE;

   hb_retni( WinExec( hb_parc( 1 ), Mode ) );
}

/*
 FUNCTION by Bernard Mouille
 ---------------------------------------------
 Retour : 0 si non connecte,
          1 si connecte.

 http://msdn.microsoft.com/en-us/library/aa384702(VS.85).aspx
 http://msdn.microsoft.com/en-us/library/ms918360.aspx
*/

HB_FUNC( ISWEBCONNECT )
{
   int nRetour = 0;
   DWORD state;

   if ( InternetGetConnectedState( &state, 0 ) != FALSE )
      nRetour = 1;
 
   if( HB_ISBYREF( 1 ) )      // pete.d. 23/04/2015
      hb_storni( state, 1 );

   hb_retni( nRetour );
}

#pragma ENDDUMP
