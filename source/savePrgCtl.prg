***********************************
FUNCTION SavePrgControls( Output ,Row ,Col ,Width ,Height ,nItem ,Indent ,lSaveAll )
*-----------------------------------------------------------------------------*
   LOCAL x ,nPos ,nValue ,aComma ,cWorkArea ,cCtrlName ,lcout ,llimg := .f.
   DEFAULT Indent TO 0

  // MsgBox("nItem= " + str(nItem) + " value = " + xArray[ nItem, 1 ] + " "+ xArray[ nItem, 3 ] )
   cCtrlName := xArray[ nItem, 1 ] ; lcout := ''
  //msgbox('controlname= ' + cCtrlName )
   *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   DO CASE

      CASE cCtrlName == "BUTTON"     // 1
        IF Upper( xArray[ nItem, 45 ] ) # "NIL" .or. Upper( xArray[ nItem, 49 ] ) # "NIL"
          llimg := .t. ; lcout := '_DefineImageButton( '
        else
          llimg := .f. ; lcout := '_DefineButton( '
        endif
           lcout += AllTrim( xArray[ nItem, 3 ] ) + ' ,' //control name 
           lcout += 'cform ,' // parent form name
           lcout += AllTrim( Str( Col ) ) + ' ,'
           lcout += AllTrim( Str( Row ) ) + ' ,'
        if llimg
           lcout += '"" ,' //caption
        else
           lcout += AllTrim( xArray[ nItem, 13 ] ) + ' ,' //caption
        endif
        lcout += xArray[ nItem, 15 ] + ' ,' //action         
        lcout += AllTrim( Str( Width ) ) + ' ,'
        lcout += AllTrim( Str( Height ) ) + ' ,'
        if llimg
          if Upper( xArray[ nItem, 45 ] ) # "NIL"
            lcout += AllTrim( xArray[ nItem, 45 ] ) + ' ,'  // picture
          else
            lcout += 'nil ,' //no picture
          endif
        else
          lcout += AllTrim( xArray[ nItem, 17 ] ) + ' ,' //font name
          lcout += xArray[ nItem, 19 ] + ' ,' //font size
        endif
        lcout += AllTrim( xArray[ nItem,21 ] ) + ' ,' // tooltip
        lcout += xArray[ nItem, 31 ] + ' ,' // got focus
        lcout += xArray[ nItem, 33 ] + ' ,' // lost focus 
        lcout += xArray[ nItem, 37 ] + ' ,' // flat
        if !llimg
          lcout += iif( xArray[ nItem, 39 ] = ".T." ,'.f.' ,".t." ) + ' ,' // tabstop
        else
          lcout += iif( xArray[ nItem, 43 ] = ".F." ,'.t. ,'.f.' ) + ' ,' // picture transparent 
        endif
        lcout += xArray[ nItem, 35 ] + ' ,' // helpid
        lcout += iif( xArray[ nItem, 41 ] = ".T." ,'.f.' ,'.t.' ) // invisible
        if !llimg
          lcout += xArray[ nItem, 23 ] + ' ,' // bold
          lcout += xArray[ nItem, 25 ] + ' ,' // italic
          lcout += xArray[ nItem, 27 ] + ' ,' // underline
          lcout += xArray[ nItem, 29 ] + ' ,' // font strickout
          lcout += xArray[ nItem, 51 ] + ' ,' // multiline
          lcout += xArray[ nItem, 47 ] + ' ,' // DEFAULT "
        else
          lcout += iif( xArray[ nItem, 39 ] = ".T." ,'.f.' ,".t." ) + ' ,' // tabstop
          lcout += xArray[ nItem, 47 ] + ' ,' // DEFAULT "
          if Upper( xArray[ nItem, 49 ] ) # "NIL"
           lcout += AllTrim( xArray[ nItem, 49 ] ) + ' ,' // icon
          else
            lcout += 'nil ,' //no icon
          endif
          lcout += '.f. ,' // extract
          lcout += 'nil ,' // extract icon index
          lcout += AllTrim( xArray[ nItem, 53 ] ) + ' ,' // NOXPSTYLE "
        endif
           lcout += 'nil ,' // hotkey
           lcout += 'nil )' // control id
           lcout += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "CHECKBOX"   // 2
        lcout := '_DefineCheckBox( ' + AllTrim( xArray[ nItem, 3 ] ) + ' ,' //control name
        lcout += 'cform ,' // parent form name
        lcout += AllTrim( Str( Col ) ) + ' ,'
        lcout += AllTrim( Str( Row ) ) + ' ,'
        lcout += AllTrim( xArray[ nItem, 13 ] ) + ' ,' //caption
        lcout += xArray[ nItem, 15 ] + ' ,' // value
        lcout += AllTrim( xArray[ nItem, 17 ] ) + ' ,' //font name
        lcout += xArray[ nItem, 19 ] + ' ,' //font size
        lcout += AllTrim( xArray[ nItem,21 ] ) + ' ,' // tooltip
        lcout += xArray[ nItem, 23 ] + ' ,' // onChange
        lcout += AllTrim( Str( Width ) ) + ' ,'
        lcout += AllTrim( Str( Height ) ) + ' ,'
        lcout += xArray[ nItem, 27 ] + ' ,'  // on LostFocus
        lcout += xArray[ nItem, 25 ] + ' ,'  // on GotFocus
        lcout += xArray[ nItem, 43 ] + ' ,'  // helpID
        lcout += iif( xArray[ nItem, 47 ] = ".T." ,".f." ,".t." ) + ' ,'  // Invisible
        lcout += iif( xArray[ nItem, 45 ] = ".T." ,".f." ,".t." ) + ' ,'  // no TabStop
        lcout += xArray[ nItem, 29 ] + ' ,'  // font Bold
        lcout += xArray[ nItem, 31 ] + ' ,'  // FONTITALIC
        lcout += xArray[ nItem, 33 ] + ' ,'  // FONTUNDERLINE
        lcout += xArray[ nItem, 35 ] + ' ,'  // FONTSTRIKEOUT
        lcout += 'nil ,'  // field
        lcout += xArray[ nItem, 39 ] + ' ,'  // backColor
        lcout += xArray[ nItem, 41 ] + ' ,'  // FONTColor
        lcout += xArray[ nItem, 49 ] + ' ,'  // TRANSPARENT
        lcout += xArray[ nItem, 51 ] + ' ,'  // LeftJustify
        lcout += xArray[ nItem, 53 ] + ' ,'  // threeState
        lcout += xArray[ nItem, 57 ] + ' ,'  // onEnter
        lcout += xArray[ nItem, 55 ] + ' ,'  // auto size
        lcout += '.f. ,'  // Border,multiline
        lcout += 'nil ,'  // control-ID
        lcout += 'nil )' + CRLF  // on-init


      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "LISTBOX"  // 3

        lcout := '_DefineListBox( ' + AllTrim( xArray[ nItem, 3 ] ) + ' ,' //control name
        lcout += 'cform ,' // parent form name
        lcout += AllTrim( Str( Col ) ) + ' ,'
        lcout += AllTrim( Str( Row ) ) + ' ,'
        lcout += AllTrim( Str( Width ) ) + ' ,'
        lcout += AllTrim( Str( Height ) ) + ' ,'
        lcout += xArray[ nItem, 13 ] + ' ,'  // items
        lcout += xArray[ nItem, 15 ] + ' ,' // value
        lcout += AllTrim( xArray[ nItem, 17 ] ) + ' ,' //font name
        lcout += xArray[ nItem, 19 ] + ' ,' //font size
        lcout += iif( xArray[ nItem, 21 ] = [""] ,"nil" ,AllTrim( xArray[ nItem,21 ] ) ) + ' ,' // tooltip
        lcout += xArray[ nItem, 23 ] + ' ,' // on Change
        lcout += xArray[ nItem, 41 ] + ' ,'  // On DblClick
        lcout += xArray[ nItem, 25 ] + ' ,'  // on GotFocus
        lcout += xArray[ nItem, 27 ] + ' ,'  // on LostFocus
        lcout += '.f. ,'  // break
        lcout += xArray[ nItem, 43 ] + ' ,'  // Help ID
        lcout += iif( xArray[ nItem, 47 ] = ".T." ,".f." ,".t." ) + ' ,'  // Invisible
        lcout += iif( xArray[ nItem, 45 ] = ".T." ,".f." ,".t." ) + ' ,'  // no TabStop
        lcout += xArray[ nItem, 49 ] + ' ,'  // sort
        lcout += xArray[ nItem, 29 ] + ' ,'  // font Bold
        lcout += xArray[ nItem, 31 ] + ' ,'  // FONTITALIC
        lcout += xArray[ nItem, 33 ] + ' ,'  // FONTUNDERLINE
        lcout += xArray[ nItem, 35 ] + ' ,'  // FONTSTRIKEOUT
        lcout += xArray[ nItem, 37 ] + ' ,'  // backColor
        lcout += xArray[ nItem, 39 ] + ' ,'  // FONTColor
        lcout += xArray[ nItem, 51 ] + ' ,'  // MULTISELECT
        lcout += xArray[ nItem, 53 ] + ' ,'  // DRAGITEMS
        lcout += xArray[ nItem, 57 ] + ' ,'  // MULTICOLUMN
        lcout += xArray[ nItem, 55 ] + ' ,'  // MULTITAB
        lcout += 'nil ,'  // TABSWIDTH
        lcout += 'nil )' + CRLF  // control-ID

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "COMBOBOX"   // 4

        lcout := '_DefineCombo( ' + AllTrim( xArray[ nItem, 3 ] ) + ' ,' //control name
        lcout += 'cform ,' // parent form name
        lcout += AllTrim( Str( Col ) ) + ' ,'
        lcout += AllTrim( Str( Row ) ) + ' ,'
        lcout += AllTrim( Str( Width ) ) + ' ,'
        lcout += xArray[ nItem, 13 ] + ' ,'  // items
        lcout += xArray[ nItem, 15 ] + ' ,' // value
        lcout += AllTrim( xArray[ nItem, 17 ] ) + ' ,' //font name
        lcout += xArray[ nItem, 19 ] + ' ,' //font size
        lcout += iif( xArray[ nItem, 21 ] = [""] ,"nil" ,AllTrim( xArray[ nItem,21 ] ) ) + ' ,' // tooltip
        lcout += xArray[ nItem, 23 ] + ' ,' // on Change
        lcout += AllTrim( xArray[ nItem, 11 ] ) + ' ,'  // ControlHeight
        lcout += xArray[ nItem, 25 ] + ' ,'  // on GotFocus
        lcout += xArray[ nItem, 27 ] + ' ,'  // on LostFocus
        lcout += xArray[ nItem, 45 ] + ' ,'  // onEnter
        lcout += xArray[ nItem, 37 ] + ' ,'  // help ID
        lcout += iif( xArray[ nItem, 41 ] = ".T." ,".f." ,".t." ) + ' ,'  // Invisible
        lcout += iif( xArray[ nItem, 39 ] = ".T." ,".f." ,".t." ) + ' ,'  // no TabStop
        lcout += xArray[ nItem, 43 ] + ' ,'  // sort
        lcout += xArray[ nItem, 29 ] + ' ,'  // font Bold
        lcout += xArray[ nItem, 31 ] + ' ,'  // FONTITALIC
        lcout += xArray[ nItem, 33 ] + ' ,'  // FONTUNDERLINE
        lcout += xArray[ nItem, 35 ] + ' ,'  // FONTSTRIKEOUT
        lcout += iif( xArray[ nItem, 51 ] # "NIL" .AND. Len( xArray[ nItem, 51 ] ) # 0 ,;
          AllTrim( xArray[ nItem,51 ] ) ,"nil" ) + ' ,' // ITEMSOURCE
        lcout += iif( xArray[ nItem, 53 ] # "NIL" .AND. Len( xArray[ nItem, 53 ] ) # 0 ,;
          AllTrim( xArray[ nItem,53 ] ) ,"nil" ) + ' ,' // VALUESOURCE
        lcout += xArray[ nItem, 49 ] + ' ,'  // DISPLAYEDIT
        lcout += xArray[ nItem, 47 ] + ' ,'  // ONDISPLAYCHANGE
        lcout += xArray[ nItem, 63 ] + ' ,'   // break
        lcout += iif( xArray[ nItem, 61 ] # "NIL" .AND. Len( xArray[ nItem, 61 ] ) # 0 ,;
          AllTrim( xArray[ nItem,61 ] ) ,"''" ) + ' ,' // GRIPPERTEXT
        lcout += iif( xArray[ nItem, 55 ] # "NIL" .AND. Len( xArray[ nItem, 55 ] ) # 0 ,;
          AllTrim( xArray[ nItem,55 ] ) ,"nil" ) + ' ,' // LISTWIDTH  DROPPEDWIDTH
        lcout += '0 ,' // 'nil ,'  // control-ID
        lcout += iif( xArray[ nItem, 57 ] # "NIL" ,xArray[ nItem, 57 ] ,'nil' ) + ' ,' // ONLISTDISPLAY ON LISTDISPLAY, ON DROPDOWN
        lcout += iif( xArray[ nItem, 59 ] # "NIL" ,xArray[ nItem, 59 ] ,'nil' ) + ' ,' // ONLISTCLOSE ON LISTCLOSE, ON CLOSEUP
        lcout += xArray[ nItem, 65 ] + ' ,'  // BACKCOLOR
        lcout += xArray[ nItem, 67 ] + ' ,'  // FONTColor
        lcout += xArray[ nItem, 69 ] + ' ,'  // UPPERCASE
        lcout += xArray[ nItem, 71 ] + ' ,'  // LOWERCASE
        lcout += 'nil ,'  // OPTIONS CUEBANNER, PLACEHOLDER
        lcout += 'nil ,'  // oncancel ON CANCEL
        lcout += '.f. ,'  // autocomplete
        lcout += '.f. ,'  // showdropdown
        lcout += 'nil ,'  // format ITEMHEIGHT
        lcout += 'nil )' + CRLF  // on-init ON INIT


      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "CHECKBUTTON"  // 5

      if Upper( xArray[ nItem, 43 ] ) = "NIL"
        lcout := '_DefineCheckButton( ' ; llimg := .f.
      else
        lcout := '_DefineImageCheckButton( ' ; llimg := .t.
      endif
        lcout += AllTrim( xArray[ nItem, 3 ] ) + ' ,' // control name
        lcout += 'cform ,' // parent form name
        lcout += AllTrim( Str( Col ) ) + ' ,'
        lcout += AllTrim( Str( Row ) ) + ' ,'
      if !llimg
        lcout += AllTrim( xArray[ nItem, 13 ] ) + ' ,' // caption
      else
        lcout += AllTrim( xArray[ nItem, 13 ] ) + ' ,' // picture
      endif
        lcout += xArray[ nItem, 15 ] + ' ,' // value
      if !llimg
        lcout += AllTrim( xArray[ nItem, 17 ] ) + ' ,' // font name
        lcout += xArray[ nItem, 19 ] + ' ,' //font size
      else
        lcout += '"" ,0 ,'
      endif
        lcout += AllTrim( xArray[ nItem,21 ] ) + ' ,' // tooltip
        lcout += xArray[ nItem, 23 ] + ' ,' // onChange
        lcout += AllTrim( Str( Width ) ) + ' ,'
        lcout += AllTrim( Str( Height ) ) + ' ,'
        lcout += xArray[ nItem, 27 ] + ' ,'  // on LostFocus
        lcout += xArray[ nItem, 25 ] + ' ,'  // on GotFocus
        lcout += xArray[ nItem, 37 ] + ' ,'  // helpID
        lcout += iif( xArray[ nItem, 41 ] = ".T." ,".f." ,".t." ) + ' ,'  // Invisible
      if !llimg
        lcout += iif( xArray[ nItem, 39 ] = ".T." ,".f." ,".t." ) + ' ,'  // no TabStop
        lcout += xArray[ nItem, 29 ] + ' ,'  // font Bold
        lcout += xArray[ nItem, 31 ] + ' ,'  // FONTITALIC
        lcout += xArray[ nItem, 33 ] + ' ,'  // FONTUNDERLINE
        lcout += xArray[ nItem, 35 ] + ' ,'  // FONTSTRIKEOUT
        lcout += 'nil )' + CRLF  // control-ID
      else
        lcout += 'nil ,.f. )' + CRLF  // control-ID Transparent
      endif


      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "GRID"     // 6

        lcout := '_DefineGrid( ' + AllTrim( xArray[ nItem, 3 ] ) + ' ,' //control name
        lcout += 'cform ,' // parent form name
        lcout += AllTrim( Str( Col ) ) + ' ,'
        lcout += AllTrim( Str( Row ) ) + ' ,'
        lcout += AllTrim( Str( Width ) ) + ' ,'
        lcout += AllTrim( Str( Height ) ) + ' ,'
        lcout += xArray[ nItem, 13 ] + ' ,'  // HEADERS
        lcout += xArray[ nItem, 15 ] + ' ,'  // WIDTHS
        lcout += xArray[ nItem, 17 ] + ' ,'  // items
        lcout += xArray[ nItem, 19 ] + ' ,'  // VALUE
        lcout += AllTrim( xArray[ nItem, 21 ] ) + ' ,' // font name
        lcout += xArray[ nItem, 23 ] + ' ,' //font size
        lcout += AllTrim( xArray[ nItem,33 ] ) + ' ,' // tooltip
        lcout += xArray[ nItem, 45 ] + ' ,' // onChange
        lcout += xArray[ nItem, 49 ] + ' ,' // DBLCLICK
        lcout += xArray[ nItem, 53 ] + ' ,' // HEADCLICK -a
        lcout += xArray[ nItem, 43 ] + ' ,'  // on GotFocus
        lcout += xArray[ nItem, 47 ] + ' ,'  // on LostFocus
        lcout += xArray[ nItem, 77 ] + ' ,'  // NoLines
        lcout += xArray[ nItem, 83 ] + ' ,'  // images -a
        lcout += xArray[ nItem, 85 ] + ' ,'  // Justify -a
        lcout += xArray[ nItem, 89 ] + ' ,'  // Break -l
        lcout += xArray[ nItem, 87 ] + ' ,'  // helpID
        lcout += xArray[ nItem, 25 ] + ' ,'  // font Bold -l
        lcout += xArray[ nItem, 27 ] + ' ,'  // FONTITALIC
        lcout += xArray[ nItem, 29 ] + ' ,'  // FONTUNDERLINE
        lcout += xArray[ nItem, 31 ] + ' ,'  // FONTSTRIKEOUT -l
        lcout += xArray[ nItem, 69 ] + ' ,'  // virtual -l
        lcout += xArray[ nItem, 73 ] + ' ,'  // ONQUERYDATA -b
        lcout += xArray[ nItem, 71 ] + ' ,'  // ITEMCOUNT
        lcout += xArray[ nItem, 51 ] + ' ,'  // ALLOWEDIT -l
        lcout += xArray[ nItem, 41 ] + ' ,'  // DYNAMICFORECOLOR -a
        lcout += xArray[ nItem, 39 ] + ' ,'  // DYNAMICBACKCOLOR -a
        lcout += xArray[ nItem, 75 ] + ' ,'  // MULTISELECT -l
        lcout += xArray[ nItem, 61 ] + ' ,'  // COLUMNCONTROLS inplace
        lcout += xArray[ nItem, 35 ] + ' ,'  // backColor
        lcout += xArray[ nItem, 37 ] + ' ,'  // FONTColor
        lcout += 'nil ,'  // control-ID
        lcout += xArray[ nItem, 63 ] + ' ,'  // COLUMNVALID
        lcout += xArray[ nItem, 65 ] + ' ,'  // COLUMNWHEN
        lcout += xArray[ nItem, 67 ] + ' ,'  // VALIDMESSAGES -a
        lcout += xArray[ nItem, 79 ] + ' ,'  // SHOWHEADERS -l
        lcout += iif( empty( xArray[ nItem, 91 ] ) ,'nil' ,xArray[ nItem, 57 ] ) + ' ,' // HEADERIMAGE -a
        lcout += iif( xArray[ nItem, 93 ] = ".T." ,".t." ,".f." ) + ' ,'  // no TabStop -l
        lcout += xArray[ nItem, 59 ] + ' ,'  // CELLNAVIGATION -l
        lcout += xArray[ nItem, 95 ] + ' ,'  // CHECKBOXES  -l
        lcout += xArray[ nItem, 97 ] + ' ,'  // LOCKCOLUMNS
        lcout += xArray[ nItem, 55 ] + ' ,'  // ONCHECKBOXCLICKED -b
        lcout += xArray[ nItem, 99 ] + ' ,'  // PAINTDOUBLEBUFFER
        lcout += xArray[ nItem, 81 ] + ' ,'  // NOSORTHEADERS
        lcout += xArray[ nItem, 101 ] + ' ,'  // COLUMNSORT ALLOWSORT
        lcout += 'nil ,'  // COLUMNWIDTHLIMITS
        lcout += 'nil ,'  // ONDRAGHEADERITEMS ON DRAGHEADERITEMS
        lcout += 'nil ,'  // ON INIT
        lcout += 'nil ,'  // AUTOSIZEHEIGHT
        lcout += 'nil )' + CRLF  // AUTOSIZEWIDTH

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "IMAGE"    // 9

        lcout := '_DefineImage( ' + AllTrim( xArray[ nItem, 3 ] ) + ' ,' //control name
        lcout += 'cform ,' // parent form name
        lcout += AllTrim( Str( Col ) ) + ' ,'
        lcout += AllTrim( Str( Row ) ) + ' ,'
        lcout += xArray[ nItem, 13 ] + ' ,'  // PICTURE
        lcout += AllTrim( Str( Width ) ) + ' ,'
        lcout += AllTrim( Str( Height ) ) + ' ,'
        lcout += xArray[ nItem, 21 ] + ' ,'  // ACTION
        lcout += iif( xArray[ nItem, 35 ] = [""] ,"nil" ,AllTrim( xArray[ nItem,35 ] ) ) + ' ,' // tooltip
        lcout += xArray[ nItem, 15 ] + ' ,'  // Help ID
        lcout += xArray[ nItem, 17 ] + ' ,' // VISIBLE
        lcout += xArray[ nItem, 19 ] + ' ,' // STRETCH
        lcout += iif( xArray[ nItem, 23 ] = ".T." ,{ 255 , 255 , 255 } ,"nil" ) + ' ,'  // WHITEBACKGROUND
        lcout += iif( xArray[ nItem, 29 ] = ".T." ,".f." ,".t." ) + ' ,'  // TRANSPARENT
        lcout += xArray[ nItem, 33 ] + ' ,' // ADJUSTIMAGE, ADJUST
        lcout += xArray[ nItem, 25 ] + ' ,' // ONMOUSEHOVER
        lcout += xArray[ nItem, 27 ] + ' ,' // ONMOUSELEAVE
        lcout += 'nil ,' // alphalevel Border
        lcout += 'nil ,'  // control-ID
        lcout += 'nil ,'  // on init oninit
        lcout += 'nil )' + CRLF  // onDblClick on DblClick


       CASE cCtrlName == "CHECKLISTBOX"  // 33

         lcout := '_DefineChkListBox(' + AllTrim( xArray[ nItem, 3 ] ) + ' ,' //control name
         lcout += 'cform ,' // parent form name
         lcout += AllTrim( Str( Col ) ) + ' ,' //   <col>,
         lcout += AllTrim( Str( Row ) ) + ' ,' //    <row>,
         lcout += AllTrim( Str( Width ) ) + ' ,' //    <w>,
         lcout += AllTrim( Str( Height ) ) + ' ,' //      <h>,
         lcout += xArray[ nItem, 13 ] + ' ,'  // items  <aRows>,
         lcout += xArray[ nItem, 15 ] + ' ,'  // <value>
         lcout += xArray[ nItem, 17 ] + ' ,' //<fontname>,
         lcout += xArray[ nItem, 19 ] + ' ,' // <fontsize>,
         lcout += xArray[ nItem, 21 ] + ' ,'  // <tooltip>,
         lcout += xArray[ nItem, 23 ] + ' ,'  //<{change}>,
         lcout += xArray[ nItem, 41 ] + ' ,' //  <{dblclick}>,
         lcout += xArray[ nItem, 25 ] + ' ,' //  <{gotfocus}>,
         lcout += xArray[ nItem, 27 ] + ' ,' //   <{lostfocus}>,
         lcout += '.f. ,' // break
         lcout += xArray[ nItem, 43 ] + ' ,'  //<helpid>,
         lcout += xArray[ nItem, 47 ] + ' ,'  // <.invisible.>,
         lcout += iif( xArray[ nItem, 45 ] = ".T." ,".f." ,".t." ) + ' ,'  // <.notabstop.>,
         lcout += xArray[ nItem, 49 ] + ' ,' //<.sort.> ,
         lcout += xArray[ nItem, 29 ] + ' ,'  // font Bold -l
         lcout += xArray[ nItem, 31 ] + ' ,'  // FONTITALIC
         lcout += xArray[ nItem, 33 ] + ' ,'  // FONTUNDERLINE
         lcout += xArray[ nItem, 35 ] + ' ,'  // FONTSTRIKEOUT -l
         lcout += xArray[ nItem, 37 ] + ' ,'  // backColor
         lcout += xArray[ nItem, 39 ] + ' ,'  // FONTColor
         lcout += xArray[ nItem, 51 ] + ' ,'  // <.multiselect.> ,
         lcout += xArray[ nItem, 53 ] + ' ,'  //  <aCheck>,
         lcout += xArray[ nItem, 53 ] + ' ,'  //  <nItemHeight>,
         lcout += 'nil )' + CRLF  //  <nId> )

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "TREE"   // 34
          lcout := '_DefineTree(' + AllTrim( xArray[ nItem, 3 ] ) + ' ,' //control name <(name)>
          lcout += 'cform ,' // <(parent)>
          lcout += AllTrim( Str( row ) ) + ' ,' //  <row> ,
          lcout += AllTrim( Str( col ) ) + ' ,' //  <col> ,
          lcout += AllTrim( Str( Width ) ) + ' ,' //  <width> ,
          lcout += AllTrim( Str( Height ) ) + ' ,' //  <height> ,
          lcout += xArray[ nItem, 23 ] + ' ,'  //  <{change}> ,
          lcout += xArray[ nItem, 19 ] + ' ,' //  <tooltip> ,
          lcout += xArray[ nItem, 15 ] + ' ,'  //  <fontname> ,
          lcout += xArray[ nItem, 17 ] + ' ,' //  <fontsize> ,
          lcout += xArray[ nItem, 21 ] + ' ,'  //  <{gotfocus}> ,
          lcout += xArray[ nItem, 25 ] + ' ,' //  <{lostfocus}> ,
          lcout += xArray[ nItem, 27 ] + ' ,' //  <{dblclick}> ,
          lcout += '.f. ,'  //  .f. ,
          lcout += xArray[ nItem, 13 ] + ' ,' //  <value>  ,
          lcout += xArray[ nItem, 35 ] + ' ,'  //  <helpid>,
          lcout += xArray[ nItem, 29 ] + ' ,'  //  <aImgNode>,
          lcout += xArray[ nItem, 31 ] + ' ,'  //  <aImgItem>,
          lcout += xArray[ nItem, 33 ] + ' ,'  // <.rootbutton.> ,
          lcout += xArray[ nItem, 47 ] + ' ,'  //  <.bold.>,
          lcout += xArray[ nItem, 49 ] + ' ,'  // <.italic.>,
          lcout += xArray[ nItem, 51 ] + ' ,'  // <.underline.>,
          lcout += xArray[ nItem, 53 ] + ' ,'  //  <.strikeout.>,
          lcout += xArray[ nItem, 57 ] + ' ,'  //  <.itemids.>,
          lcout += xArray[ nItem, 37 ] + ' ,'  //  <backcolor>,
          lcout += xArray[ nItem, 39 ] + ' ,'  //  <fontcolor>,
          lcout += xArray[ nItem, 41 ] + ' ,'  //  <linecolor>,
          lcout += xArray[ nItem, 43 ] + ' ,'  //  <indent>,    IF xArray[ nItem, 43 ] # "17"
          lcout += xArray[ nItem, 45 ] + ' ,'  //  <itemheight>,   IF xArray[ nItem, 45 ] # "18"
          lcout += 'nil ,'  //  <nId>,
          lcout += 'nil ,'  //  <bInit>, 
          lcout += '.f. )'  + CRLF  //  !<.Trans.> )

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "ANIMATEBOX"   // 17
          lcout := '_DefineAnimateBox(' + AllTrim( xArray[ nItem, 3 ] ) + ' ,' // <(name)>,
          lcout += 'cform ,' // <(parent)>,
          lcout += AllTrim( Str( col ) ) + ' ,' //<col>,
          lcout += AllTrim( Str( row ) ) + ' ,' //<row>,
          lcout += AllTrim( Str( Width ) ) + ' ,' //<w>,
          lcout += AllTrim( Str( Height ) ) + ' ,' //<h>,
          lcout += xArray[ nItem, 19 ] + ' ,'  //<.autoplay.>,
          lcout += xArray[ nItem, 21 ] + ' ,'  //<.center.>,
          lcout += xArray[ nItem, 17 ] + ' ,'  //<.transparent.>,
          lcout += xArray[ nItem, 13 ] + ' ,'  //<file>,
          lcout += xArray[ nItem, 15 ] + ' ,'  //<helpid>,
          lcout += xArray[ nItem, 23 ] + ' ,'  //!<.noborder.>,
          lcout += 'nil ,'  //<backcolor>,
          lcout += '.f. ,'  //<.invisible.>,
          lcout += 'nil '  //<nId> )
          lcout += ')'  + CRLF


      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "DATEPICKER"   // 10

           lcout += '_DefineDatePick(' + AllTrim( xArray[ nItem, 3 ] ) + ' ,' //<(name)> , ;
           lcout += 'cform ,' // <(parent)> , ;
           lcout += AllTrim( Str( col ) ) + ' ,' // <col> , ;
           lcout += AllTrim( Str( row ) ) + ' ,' // <row> , ;
           lcout += AllTrim( Str( Width ) ) + ' ,' // <w> , ;
           lcout += AllTrim( Str( Height ) ) + ' ,' // <h> , ;
           lcout += xArray[ nItem, 13 ] + ' ,' // <v> value
           lcout += xArray[ nItem, 15 ] + ' ,'  // <fontname> , ;
           lcout += xArray[ nItem, 17 ] + ' ,' // <fontsize> , ;
           lcout += xArray[ nItem, 19 ] + ' ,' // <tooltip> , ;
           lcout += xArray[ nItem, 21 ] + ' ,'  // <{change}> , ;
           lcout += xArray[ nItem, 25 ] + ' ,' // <{lostfocus}> , ;
           lcout += xArray[ nItem, 21 ] + ' ,'  // <{gotfocus}> , ;
           lcout += xArray[ nItem, 43 ] + ' ,'  // <.shownone.> , ;
           lcout += xArray[ nItem, 45 ] + ' ,'  // <.updown.> , ;
           lcout += xArray[ nItem, 47 ] + ' ,'  //  <.rightalign.>  ,
           lcout += xArray[ nItem, 37 ] + ' ,'  //  <helpid> ,
           lcout += iif( xArray[ nItem, 41 ] = ".T." ,".f." ,".t." ) + ' ,'  //   <.invisible.>,
           lcout += iif( xArray[ nItem, 39 ] = ".T." ,".f." ,".t." ) + ' ,'  //   <.notabstop.>, ;
           lcout += xArray[ nItem, 27 ] + ' ,' //  <.bold.>,
           lcout += xArray[ nItem, 29 ] + ' ,' //  <.italic.>,
           lcout += xArray[ nItem, 31 ] + ' ,' //  <.underline.>,
           lcout += xArray[ nItem, 33 ] + ' ,' //  <.strikeout.> , ;
           lcout += iif( !empty( xArray[ nItem, 49 ] ) ,xArray[ nItem, 49 ] ,"nil" ) + ' ,'  //  <(field)> ,
           lcout += xArray[ nItem, 35 ] + ' ,' //   <{enter}>, ;
           lcout += xArray[ nItem, 51 ] + ' ,' //  [ <backcolor> ], ;
           lcout += xArray[ nItem, 53 ] + ' ,' //  [ <fontcolor> ], ;
           lcout += xArray[ nItem, 57 ] + ' ,' //  [ <titlebkclr> ], ;
           lcout += xArray[ nItem, 59 ] + ' ,' //  [ <titlefrclr> ], ;
           lcout += 'nil ,'  // [ <trlfontclr> ], ;
           lcout += iif( !empty( xArray[ nItem, 55 ] ) ,xArray[ nItem, 55 ] ,"nil" ) + ' ,'  //  <cDateFormat>, ;
           lcout += 'nil ,'  // <lo> ,
           lcout += 'nil ,'  // <hi> , ;
           lcout += 'nil ,'  // <nId>,
           lcout += 'nil '  // <bInit> )
           lcout += ')'  + CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "TEXTBOX"    // 11

           lcout += '_DefineMaskedTextBox(' + AllTrim( xArray[ nItem, 3 ] ) + ' ,' //
           <(parent)>, 
           <col>, 
           <row>, 
           <width>, 
           <height>, 
           <value>, 
           <fontname>, 
           <fontsize>, 
           <tooltip>, 
           <maxlength>, ;
		<.upper.>, <.lower.>, <.numeric.>, <.password.>, <{lostfocus}>, <{gotfocus}>, <{change}>, <{enter}>, ;
		<.RightAlign.>, <helpid>, <.readonly.>, <.bold.>, <.italic.>, <.underline.>, <.strikeout.>, <(field)>, ;
		<backcolor> , <fontcolor> , <.invisible.> , <.notabstop.> , <.noborder.> , [<CueText>] , <nId> , <bInit> )


           Output += Space( Indent ) + "     DEFINE TEXTBOX "      + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent ) + "            ROW    "       + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent ) + "            COL    "       + AllTrim( Str( Col ) )          + CRLF
           Output += Space( Indent ) + "            WIDTH  "       + AllTrim( Str( Width ) )        + CRLF
           Output += Space( Indent ) + "            HEIGHT "       + AllTrim( Str( Height ) )       + CRLF
           Output += iif( xArray[ nItem, 13 ]          = '"Arial"' , iif( lSaveAll, Space( indent ) + "            FONTNAME "       + AllTrim( xArray[ nItem, 13 ] ) + CRLF, "" ), Space(indent ) + "            FONTNAME "      + AllTrim( xArray[ nItem, 13 ] ) + CRLF )
           Output += iif( xArray[ nItem, 15 ]          = "9"       , iif( lSaveAll, Space( indent ) + "            FONTSIZE "       + xArray[ nItem, 15 ]            + CRLF, "" ), Space(indent ) + "            FONTSIZE "      + xArray[ nItem, 15 ]            + CRLF )
           IF xArray[ nItem, 17 ] # "''"
           Output += iif( xArray[ nItem, 17 ]          = [""]      , iif( lSaveAll, Space( indent ) + "            TOOLTIP "        + AllTrim( xArray[ nItem, 17 ] ) + CRLF, "" ), Space(indent ) + "            TOOLTIP "       + AllTrim( xArray[ nItem, 17 ] ) + CRLF )
           ENDIF
           Output += iif( Upper( xArray[ nItem, 19 ] ) = "NIL"     , iif( lSaveAll, Space( indent ) + "            ONCHANGE "       + xArray[ nItem, 19 ]            + CRLF, "" ), Space(indent ) + "            ONCHANGE "      + xArray[ nItem, 19 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 21 ] ) = "NIL"     , iif( lSaveAll, Space( indent ) + "            ONGOTFOCUS "     + xArray[ nItem, 21 ]            + CRLF, "" ), Space(indent ) + "            ONGOTFOCUS "    + xArray[ nItem, 21 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 23 ] ) = "NIL"     , iif( lSaveAll, Space( indent ) + "            ONLOSTFOCUS "    + xArray[ nItem, 23 ]            + CRLF, "" ), Space(indent ) + "            ONLOSTFOCUS "   + xArray[ nItem, 23 ]            + CRLF )
           Output += iif( xArray[ nItem, 25 ]          = ".F."     , iif( lSaveAll, Space( indent ) + "            FONTBOLD "       + xArray[ nItem, 25 ]            + CRLF, "" ), Space(indent ) + "            FONTBOLD "      + xArray[ nItem, 25 ]            + CRLF )
           Output += iif( xArray[ nItem, 27 ]          = ".F."     , iif( lSaveAll, Space( indent ) + "            FONTITALIC "     + xArray[ nItem, 27 ]            + CRLF, "" ), Space(indent ) + "            FONTITALIC "    + xArray[ nItem, 27 ]            + CRLF )
           Output += iif( xArray[ nItem, 29 ]          = ".F."     , iif( lSaveAll, Space( indent ) + "            FONTUNDERLINE "  + xArray[ nItem, 29 ]            + CRLF, "" ), Space(indent ) + "            FONTUNDERLINE " + xArray[ nItem, 29 ]            + CRLF )
           Output += iif( xArray[ nItem, 31 ]          = ".F."     , iif( lSaveAll, Space( indent ) + "            FONTSTRIKEOUT "  + xArray[ nItem, 31 ]            + CRLF, "" ), Space(indent ) + "            FONTSTRIKEOUT " + xArray[ nItem, 31 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 33 ] ) = "NIL"     , iif( lSaveAll, Space( indent ) + "            ONENTER "        + xArray[ nItem, 33 ]            + CRLF, "" ), Space(indent ) + "            ONENTER "       + xArray[ nItem, 33 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 35 ] ) = "NIL"     , iif( lSaveAll, Space( indent ) + "            HELPID "         + xArray[ nItem, 35 ]            + CRLF, "" ), Space(indent ) + "            HELPID "        + xArray[ nItem, 35 ]            + CRLF )
           Output += iif( xArray[ nItem, 37 ]          = ".T."     , iif( lSaveAll, Space( indent ) + "            TABSTOP "        + xArray[ nItem, 37 ]            + CRLF, "" ), Space(indent ) + "            TABSTOP "       + xArray[ nItem, 37 ]            + CRLF )
           Output += iif( xArray[ nItem, 39 ]          = ".T."     , iif( lSaveAll, Space( indent ) + "            VISIBLE "        + xArray[ nItem, 39 ]            + CRLF, "" ), Space(indent ) + "            VISIBLE "       + xArray[ nItem, 39 ]            + CRLF )
           Output += iif( xArray[ nItem, 41 ]          = ".F."     , iif( lSaveAll, Space( indent ) + "            READONLY "       + xArray[ nItem, 41 ]            + CRLF, "" ), Space(indent ) + "            READONLY "      + xArray[ nItem, 41 ]            + CRLF )
           Output += iif( xArray[ nItem, 43 ]          = ".F."     , iif( lSaveAll, Space( indent ) + "            RIGHTALIGN "     + xArray[ nItem, 43 ]            + CRLF, "" ), Space(indent ) + "            RIGHTALIGN "    + xArray[ nItem, 43 ]            + CRLF )
           // DISABLEDBACKCOLOR Nil,DISABLEDFONTCOLOR Nil,CASECONVERT NONE for HMGo
           IF xArray[ nItem, 45 ] = ".T."
              Output += Space( Indent ) + "            LOWERCASE " + xArray[ nItem, 45 ] + CRLF
           ELSEIF xArray[ nItem, 47 ] = ".T."
              Output += Space( Indent ) + "            UPPERCASE " + xArray[ nItem, 47 ] + CRLF
           ENDIF

           IF xArray[ nItem, 51 ] = ".T."
              Output += Space( Indent ) + "            PASSWORD " + xArray[ nItem, 51 ]  + CRLF
           ENDIF

           IF xArray[ nItem, 75 ] = "CHARACTER" .OR. xArray[ nItem, 75 ] = "NUMERIC" .OR. xArray[ nItem, 51 ] = ".T."
              IF xArray[ nItem, 53 ] # "0"
                 Output += Space( Indent ) + "            MAXLENGTH " + xArray[ nItem, 53 ]  + CRLF
              ENDIF
           ENDIF

           Output += iif( Upper( xArray[ nItem, 55 ] ) = "NIL", iif( lSaveAll, Space( Indent ) + "            BACKCOLOR " + xArray[ nItem, 55 ] + CRLF, "" ), Space( Indent ) + "            BACKCOLOR " + xArray[ nItem, 55 ] + CRLF )
           Output += iif( Upper( xArray[ nItem, 57 ] ) = "NIL", iif( lSaveAll, Space( Indent ) + "            FONTCOLOR " + xArray[ nItem, 57 ] + CRLF, "" ), Space( Indent ) + "            FONTCOLOR " + xArray[ nItem, 57 ] + CRLF )

           IF ! Empty( xArray[ nItem, 59 ] ) .AND. Upper( xArray[ nItem, 59 ] ) # "NIL"
              Output += Space( Indent )+ "            FIELD " + xArray[ nItem, 59 ]  + CRLF
           ENDIF

           IF xArray[ nItem, 61 ] # "''"
              Output += iif( xArray[ nItem, 61 ]    = '""', iif( lSaveAll, Space( Indent ) + "            INPUTMASK NIL" + CRLF, "" ), Space( Indent ) + "            INPUTMASK " + AllTrim( xArray[ nItem, 61 ] ) + CRLF )
           ENDIF
           IF xArray[ nItem, 63 ] # "''"
              Output += iif( xArray[ nItem, 63 ]    = '""', iif( lSaveAll, Space( Indent ) + "            FORMAT NIL"    + CRLF, "" ), Space( Indent ) + "            FORMAT "    + AllTrim( xArray[ nItem, 63 ] ) + CRLF )
           ENDIF

           IF xArray[ nItem, 75 ] = "DATE"
              Output += Space( Indent )+"            DATE  "+xArray[ nItem, 65 ] + CRLF
              Output += iif( xArray[ nItem, 71 ] = '""', iif( lSaveAll, Space( Indent ) + "            VALUE NIL"  + CRLF, "" ), Space( Indent )+"            VALUE " + AllTrim( xArray[ nItem, 71 ] ) + CRLF )

           ELSEIF xArray[ nItem, 75 ] = "NUMERIC"
              Output += Space( Indent )+"            NUMERIC  "+xArray[ nItem, 67 ] + CRLF
              Output += iif( xArray[ nItem, 71 ] = '""', iif( lSaveAll, Space( Indent ) + "            VALUE NIL"  + CRLF, "" ), Space( Indent )+"            VALUE " + AllTrim( xArray[ nItem, 71 ] ) + CRLF )
           ELSE
              IF xArray[ nItem, 71 ] # "''"
                 Output += iif( xArray[ nItem, 71 ] = '""', iif( lSaveAll, Space( Indent ) + "            VALUE "     + AllTrim( xArray[ nItem, 71 ] ) + CRLF, "" ), Space( Indent ) + "            VALUE " + AllTrim( xArray[ nItem, 71 ] ) + CRLF )
              ENDIF
           ENDIF
             IF xArray[ nItem, 77 ] = ".F."
              Output += Space( Indent ) + "            BORDER " + xArray[ nItem, 77 ]  + CRLF
           ENDIF

           Output += Space( Indent )+"     END TEXTBOX " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "BTNTEXTBOX"    // 29

           Output += Space( Indent ) + "     DEFINE BTNTEXTBOX "  + AllTrim( xArray[ nItem, 3 ] ) + CRLF
           Output += Space( Indent ) + "            ROW    "      + AllTrim( Str( Row ) )         + CRLF
           Output += Space( Indent ) + "            COL    "      + AllTrim( Str( Col ) )         + CRLF
           Output += Space( Indent ) + "            WIDTH  "      + AllTrim( Str( Width ) )       + CRLF
           Output += Space( Indent ) + "            HEIGHT "      + AllTrim( Str( Height ) )      + CRLF

           IF xArray[ nItem, 13 ]# "NIL" .AND. Len(AllTrim( xArray[ nItem, 13 ] )) > 0
              Output += Space( Indent ) + "            FIELD " + AllTrim( xArray[ nItem, 13 ] )   + CRLF
           ENDIF

           Output += iif( xArray[ nItem, 15 ]          = '""'  , iif( lSaveAll, Space( Indent ) + "            VALUE "         + xArray[ nItem, 15 ] + CRLF, "" )           , Space( Indent ) + "            VALUE "   + xArray[ nItem, 15 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 17 ] ) = "NIL" , iif( lSaveAll, Space( Indent ) + "            ACTION "        + AllTrim( xArray[ nItem, 17 ] ) + CRLF, "" ), Space( Indent ) + "            ACTION "  + AllTrim( xArray[ nItem, 17 ] ) + CRLF )
           Output += iif( xArray[ nItem, 19 ]          = '""'  , iif( lSaveAll, Space( Indent ) + "            PICTURE "       + xArray[ nItem, 19 ] + CRLF, "" )           , Space( Indent ) + "            PICTURE " + xArray[ nItem, 19 ]            + CRLF )

           IF xArray[ nItem, 21 ] # "0"
              Output += Space( Indent )+"            BUTTONWIDTH "+xArray[ nItem, 21 ] + CRLF
           ENDIF

           Output += iif( xArray[ nItem, 23 ] = '"Arial"'    , iif( lSaveAll, Space( Indent ) + "            FONTNAME "      + xArray[ nItem, 23 ] + CRLF, "" ), Space( Indent ) + "            FONTNAME "      + xArray[ nItem, 23 ] + CRLF )
           Output += iif( xArray[ nItem, 25 ] = "9"          , iif( lSaveAll, Space( Indent ) + "            FONTSIZE "      + xArray[ nItem, 25 ] + CRLF, "" ), Space( Indent ) + "            FONTSIZE "      + xArray[ nItem, 25 ] + CRLF )
           Output += iif( xArray[ nItem, 27 ] = ".F."        , iif( lSaveAll, Space( Indent ) + "            FONTBOLD "      + xArray[ nItem, 27 ] + CRLF, "" ), Space( Indent ) + "            FONTBOLD "      + xArray[ nItem, 27 ] + CRLF )
           Output += iif( xArray[ nItem, 29 ] = ".F."        , iif( lSaveAll, Space( Indent ) + "            FONTITALIC "    + xArray[ nItem, 29 ] + CRLF, "" ), Space( Indent ) + "            FONTITALIC "    + xArray[ nItem, 29 ] + CRLF )
           Output += iif( xArray[ nItem, 31 ] = ".F."        , iif( lSaveAll, Space( Indent ) + "            FONTUNDERLINE " + xArray[ nItem, 31 ] + CRLF, "" ), Space( Indent ) + "            FONTUNDERLINE " + xArray[ nItem, 31 ] + CRLF )
           Output += iif( xArray[ nItem, 33 ] = ".F."        , iif( lSaveAll, Space( Indent ) + "            FONTSTRIKEOUT " + xArray[ nItem, 33 ] + CRLF, "" ), Space( Indent ) + "            FONTSTRIKEOUT " + xArray[ nItem, 33 ] + CRLF )

           IF xArray[ nItem, 35 ] = ".T."
              Output += Space( Indent ) + "            NUMERIC "  + xArray[ nItem, 35 ] + CRLF
           ELSEIF xArray[ nItem, 37 ] = ".T."
              Output += Space( Indent ) + "            PASSWORD " + xArray[ nItem, 37 ] + CRLF
           ENDIF

           Output += iif( xArray[ nItem, 39 ]          = '""' , iif( lSaveAll, Space( Indent ) + "            TOOLTIP "   + xArray[ nItem, 39 ] + CRLF, "" ), Space( Indent ) + "            TOOLTIP "   + xArray[ nItem, 39 ] + CRLF )
           Output += iif( Upper( xArray[ nItem, 41 ] ) = "NIL", iif( lSaveAll, Space( Indent ) + "            BACKCOLOR " + xArray[ nItem, 41 ] + CRLF, "" ), Space( Indent ) + "            BACKCOLOR " + xArray[ nItem, 41 ] + CRLF )
           Output += iif( Upper( xArray[ nItem, 43 ] ) = "NIL", iif( lSaveAll, Space( Indent ) + "            FONTCOLOR " + xArray[ nItem, 43 ] + CRLF, "" ), Space( Indent ) + "            FONTCOLOR " + xArray[ nItem, 43 ] + CRLF )

           IF xArray[ nItem, 45 ] # "0"
              Output += Space( Indent ) + "            MAXLENGTH " + xArray[ nItem, 45 ] + CRLF
           ENDIF

           IF xArray[ nItem, 47 ] = ".T."
              Output += Space( Indent ) + "            UPPERCASE " + xArray[ nItem, 47 ] + CRLF
           ELSEIF xArray[ nItem, 49 ] = ".T."
              Output += Space( Indent ) + "            LOWERCASE " + xArray[ nItem, 49 ] + CRLF
           ENDIF

           Output += iif( Upper( xArray[ nItem, 51 ] ) = "NIL", iif( lSaveAll, Space( indent ) + "            ONGOTFOCUS "    + xArray[ nItem, 51 ] + CRLF, "" ), Space( indent ) + "            ONGOTFOCUS "  + xArray[ nItem, 51 ] + CRLF )
           Output += iif( Upper( xArray[ nItem, 53 ] ) = "NIL", iif( lSaveAll, Space( indent ) + "            ONCHANGE "      + xArray[ nItem, 53 ] + CRLF, "" ), Space( indent ) + "            ONCHANGE "    + xArray[ nItem, 53 ] + CRLF )
           Output += iif( Upper( xArray[ nItem, 55 ] ) = "NIL", iif( lSaveAll, Space( indent ) + "            ONLOSTFOCUS "   + xArray[ nItem, 55 ] + CRLF, "" ), Space( indent ) + "            ONLOSTFOCUS " + xArray[ nItem, 55 ] + CRLF )
           Output += iif( Upper( xArray[ nItem, 57 ] ) = "NIL", iif( lSaveAll, Space( indent ) + "            ONENTER "       + xArray[ nItem, 57 ] + CRLF, "" ), Space( indent ) + "            ONENTER "     + xArray[ nItem, 57 ] + CRLF )
           Output += iif( Upper( xArray[ nItem, 59 ] ) = ".F.", iif( lSaveAll, Space( indent ) + "            RIGHTALIGN "    + xArray[ nItem, 59 ] + CRLF, "" ), Space( indent ) + "            RIGHTALIGN "  + xArray[ nItem, 59 ] + CRLF )
           Output += iif( Upper( xArray[ nItem, 61 ] ) = ".T.", iif( lSaveAll, Space( indent ) + "            VISIBLE "       + xArray[ nItem, 61 ] + CRLF, "" ), Space( indent ) + "            VISIBLE "     + xArray[ nItem, 61 ] + CRLF )
           Output += iif( Upper( xArray[ nItem, 63 ] ) = ".T.", iif( lSaveAll, Space( indent ) + "            TABSTOP "       + xArray[ nItem, 63 ] + CRLF, "" ), Space( indent ) + "            TABSTOP "     + xArray[ nItem, 63 ] + CRLF )
           Output += iif( Upper( xArray[ nItem, 65 ] ) = "NIL", iif( lSaveAll, Space( indent ) + "            HELPID "        + xArray[ nItem, 65 ] + CRLF, "" ), Space( indent ) + "            HELPID "      + xArray[ nItem, 65 ] + CRLF )
           Output += iif( Upper( xArray[ nItem, 67 ] ) = ".F.", iif( lSaveAll, Space( indent ) + "            DISABLEEDIT "   + xArray[ nItem, 67 ] + CRLF, "" ), Space( indent ) + "            DISABLEEDIT " + xArray[ nItem, 67 ] + CRLF )

           Output += Space( Indent )+"     END BTNTEXTBOX " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "HOTKEYBOX"   // 30

           Output += Space( indent ) + "     DEFINE HOTKEYBOX "      + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( indent ) + "            ROW    "         + AllTrim( Str( Row ) )          + CRLF
           Output += Space( indent ) + "            COL    "         + AllTrim( Str( Col ) )          + CRLF
           Output += Space( indent ) + "            WIDTH  "         + AllTrim( Str( Width ) )        + CRLF
           Output += Space( indent ) + "            HEIGHT "         + AllTrim( Str( Height ) )       + CRLF
           Output += Space( indent ) + "            VALUE "          + AllTrim( xArray[ nItem, 13 ] ) + CRLF
           Output += Space( indent ) + "            FONTNAME "       + xArray[ nItem, 15 ]            + CRLF     // Renaldo
           Output += Space( indent ) + "            FONTSIZE "       + xArray[ nItem, 17 ]            + CRLF
           Output += Space( indent ) + "            FONTBOLD "       + xArray[ nItem, 19 ]            + CRLF
           Output += Space( indent ) + "            FONTITALIC "     + xArray[ nItem, 21 ]            + CRLF
           Output += Space( indent ) + "            FONTUNDERLINE "  + xArray[ nItem, 23 ]            + CRLF
           Output += Space( indent ) + "            FONTSTRIKEOUT "  + xArray[ nItem, 25 ]            + CRLF
           Output += Space( indent ) + "            TOOLTIP "        + xArray[ nItem, 27 ]            + CRLF
           Output += Space( indent ) + "            ONCHANGE "       + xArray[ nItem, 29 ]            + CRLF
           Output += Space( indent ) + "            HELPID "         + xArray[ nItem, 31 ]            + CRLF
           Output += Space( indent ) + "            VISIBLE "        + xArray[ nItem, 33 ]            + CRLF
           Output += Space( indent ) + "            TABSTOP "        + xArray[ nItem, 35 ]            + CRLF
           Output += Space( indent ) + "     END HOTKEYBOX " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "EDITBOX"    // 12

           Output += Space( Indent ) + "     DEFINE EDITBOX "      + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent ) + "            ROW    "       + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent ) + "            COL    "       + AllTrim( Str( Col ) )          + CRLF
           Output += Space( Indent ) + "            WIDTH  "       + AllTrim( Str( Width  ))        + CRLF
           Output += Space( Indent ) + "            HEIGHT "       + AllTrim( Str( Height ) )       + CRLF
           Output += iif( xArray[ nItem, 13 ]          = '""'      , iif( lSaveAll, Space( indent ) + "            VALUE "         + AllTrim( xArray[ nItem, 13 ] ) + CRLF, "" ), Space( indent ) + "            VALUE "             + AllTrim( xArray[ nItem, 13 ] )   + CRLF )
           Output += iif( xArray[ nItem, 15 ]          = '"Arial"' , iif( lSaveAll, Space( indent ) + "            FONTNAME "      + AllTrim( xArray[ nItem, 15 ] ) + CRLF, "" ), Space( indent ) + "            FONTNAME "          + AllTrim( xArray[ nItem, 15 ] )   + CRLF )
           Output += iif( xArray[ nItem, 17 ]          = "9"       , iif( lSaveAll, Space( indent ) + "            FONTSIZE "      + xArray[ nItem, 17 ]            + CRLF, "" ), Space( indent ) + "            FONTSIZE "          + xArray[ nItem, 17 ]              + CRLF )
           Output += iif( xArray[ nItem, 19 ]          = [""]      , iif( lSaveAll, Space( indent ) + "            TOOLTIP "       + AllTrim( xArray[ nItem, 19 ] ) + CRLF, "" ), Space( indent ) + "            TOOLTIP "           + AllTrim( xArray[ nItem, 19 ] )   + CRLF )
           Output += iif( Upper( xArray[ nItem, 21 ] ) = "NIL"     , iif( lSaveAll, Space( indent ) + "            ONCHANGE "      + xArray[ nItem, 21 ]            + CRLF, "" ), Space( indent ) + "            ONCHANGE "          + xArray[ nItem, 21 ]              + CRLF )
           Output += iif( Upper( xArray[ nItem, 23 ] ) = "NIL"     , iif( lSaveAll, Space( indent ) + "            ONGOTFOCUS "    + xArray[ nItem, 23 ]            + CRLF, "" ), Space( indent ) + "            ONGOTFOCUS "        + xArray[ nItem, 23 ]              + CRLF )
           Output += iif( Upper( xArray[ nItem, 25 ] ) = "NIL"     , iif( lSaveAll, Space( indent ) + "            ONLOSTFOCUS "   + xArray[ nItem, 25 ]            + CRLF, "" ), Space( indent ) + "            ONLOSTFOCUS "       + xArray[ nItem, 25 ]              + CRLF )
           Output += iif( xArray[ nItem, 27 ]          = ".F."     , iif( lSaveAll, Space( indent ) + "            FONTBOLD "      + xArray[ nItem, 27 ]            + CRLF, "" ), Space( indent ) + "            FONTBOLD "          + xArray[ nItem, 27 ]              + CRLF )
           Output += iif( xArray[ nItem, 29 ]          = ".F."     , iif( lSaveAll, Space( indent ) + "            FONTITALIC "    + xArray[ nItem, 29 ]            + CRLF, "" ), Space( indent ) + "            FONTITALIC "        + xArray[ nItem, 29 ]              + CRLF )
           Output += iif( xArray[ nItem, 31 ]          = ".F."     , iif( lSaveAll, Space( indent ) + "            FONTUNDERLINE " + xArray[ nItem, 31 ]            + CRLF, "" ), Space( indent ) + "            FONTUNDERLINE "     + xArray[ nItem, 31 ]              + CRLF )
           Output += iif( xArray[ nItem, 33 ]          = ".F."     , iif( lSaveAll, Space( indent ) + "            FONTSTRIKEOUT " + xArray[ nItem, 33 ]            + CRLF, "" ), Space( indent ) + "            FONTSTRIKEOUT "     + xArray[ nItem, 33 ]              + CRLF )
           Output += iif( Upper( xArray[ nItem, 35 ] ) = "NIL"     , iif( lSaveAll, Space( indent ) + "            HELPID "        + xArray[ nItem, 35 ]            + CRLF, "" ), Space( indent ) + "            HELPID "            + xArray[ nItem, 35 ]              + CRLF )
           Output += iif( xArray[ nItem, 37 ]          = ".T."     , iif( lSaveAll, Space( indent ) + "            TABSTOP "       + xArray[ nItem, 37 ]            + CRLF, "" ), Space( indent ) + "            TABSTOP "           + xArray[ nItem, 37 ]              + CRLF )
           Output += iif( xArray[ nItem, 39 ]          = ".T."     , iif( lSaveAll, Space( indent ) + "            VISIBLE "       + xArray[ nItem, 39 ]            + CRLF, "" ), Space( indent ) + "            VISIBLE "           + xArray[ nItem, 39 ]              + CRLF )
           Output += iif( xArray[ nItem, 41 ]          = ".F."     , iif( lSaveAll, Space( indent ) + "            READONLY "      + xArray[ nItem, 41 ]            + CRLF, "" ), Space( indent ) + "            READONLY "          + xArray[ nItem, 41 ]              + CRLF )
           Output += iif( Upper( xArray[ nItem, 43 ] ) = "NIL"     , iif( lSaveAll, Space( indent ) + "            BACKCOLOR "     + xArray[ nItem, 43 ]            + CRLF, "" ), Space( indent ) + "            BACKCOLOR "         + xArray[ nItem, 43 ]              + CRLF )
           Output += iif( Upper( xArray[ nItem, 45 ] ) = "NIL"     , iif( lSaveAll, Space( indent ) + "            FONTCOLOR "     + xArray[ nItem, 45 ]            + CRLF, "" ), Space( indent ) + "            FONTCOLOR "         + xArray[ nItem, 45 ]              + CRLF )

           IF xArray[ nItem, 47 ] # "0"
              Output += Space( Indent )    + "            MAXLENGTH  "  + xArray[ nItem, 47 ] + CRLF
           ENDIF

           IF ! Empty( xArray[ nItem, 49 ] ) .AND.  Upper( xArray[ nItem, 49 ] ) # "NIL"
              IF At( ">", xArray[ nItem, 49 ] ) # 0
                 Output += Space( Indent ) + "            FIELD  "      + xArray[ nItem, 49 ] + CRLF
              ENDIF
           ENDIF

           IF xArray[ nItem, 51 ] # ".T." .OR. lSaveAll
              Output += Space( Indent )    + "            HSCROLLBAR  " + xArray[ nItem, 51 ] + CRLF
           ENDIF

           IF xArray[ nItem, 53 ] # ".T." .OR. lSaveAll
              Output += Space( Indent )    + "            VSCROLLBAR  " + xArray[ nItem, 53 ] + CRLF
           ENDIF

           IF xArray[ nItem, 55 ] # ".F."
              Output += Space( Indent )    + "            BREAK  "      + xArray[ nItem, 55 ] + CRLF
           ENDIF

           Output += Space( Indent ) + "     END EDITBOX  " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "LABEL"      // 13
// ONMOUSEHOVER ,ONMOUSELEAVE ,BORDER ,CLIENTEDGE ,HSCROL ,VSCROLL ,BLINK for non HMGo
           Output += Space( Indent ) + "     DEFINE LABEL "        + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent ) + "            ROW    "       + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent ) + "            COL    "       + AllTrim( Str( Col ) )          + CRLF
           Output += Space( Indent ) + "            WIDTH  "       + AllTrim( xArray[ nItem,  9 ] ) + CRLF
           Output += Space( Indent ) + "            HEIGHT "       + AllTrim( xArray[ nItem, 11 ] ) + CRLF
           Output += Space( Indent ) + "            VALUE "        + AllTrim( xArray[ nItem, 13 ] ) + CRLF
           Output += iif( xArray[ nItem, 15 ]          = '"Arial"' , iif( lSaveAll, Space( Indent ) + "            FONTNAME "      + AllTrim( xArray[ nItem, 15 ] ) + CRLF, "" ), Space( Indent ) + "            FONTNAME "      + AllTrim( xArray[ nItem, 15 ] ) + CRLF )
           Output += iif( xArray[ nItem, 17 ]          = "9"       , iif( lSaveAll, Space( Indent ) + "            FONTSIZE "      + xArray[ nItem, 17 ]            + CRLF, "" ), Space( Indent ) + "            FONTSIZE "      + xArray[ nItem, 17 ]            + CRLF )
           Output += iif( xArray[ nItem, 19 ]          = [""]      , iif( lSaveAll, Space( Indent ) + "            TOOLTIP "       + AllTrim( xArray[ nItem, 19 ] ) + CRLF, "" ), Space( Indent ) + "            TOOLTIP "       + AllTrim( xArray[ nItem, 19 ] ) + CRLF )
           Output += iif( xArray[ nItem, 21 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTBOLD "      + xArray[ nItem, 21 ]            + CRLF, "" ), Space( Indent ) + "            FONTBOLD "      + xArray[ nItem, 21 ]            + CRLF )
           Output += iif( xArray[ nItem, 23 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTITALIC "    + xArray[ nItem, 23 ]            + CRLF, "" ), Space( Indent ) + "            FONTITALIC "    + xArray[ nItem, 23 ]            + CRLF )
           Output += iif( xArray[ nItem, 25 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTUNDERLINE " + xArray[ nItem, 25 ]            + CRLF, "" ), Space( Indent ) + "            FONTUNDERLINE " + xArray[ nItem, 25 ]            + CRLF )
           Output += iif( xArray[ nItem, 27 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTSTRIKEOUT " + xArray[ nItem, 27 ]            + CRLF, "" ), Space( Indent ) + "            FONTSTRIKEOUT " + xArray[ nItem, 27 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 29 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            HELPID "        + xArray[ nItem, 29 ]            + CRLF, "" ), Space( Indent ) + "            HELPID "        + xArray[ nItem, 29 ]            + CRLF )
           Output += iif( xArray[ nItem, 31 ]          = ".T."     , iif( lSaveAll, Space( Indent ) + "            VISIBLE "       + xArray[ nItem, 31 ]            + CRLF, "" ), Space( Indent ) + "            VISIBLE "       + xArray[ nItem, 31 ]            + CRLF )
           Output += iif( xArray[ nItem, 33 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            TRANSPARENT "   + xArray[ nItem, 33 ]            + CRLF, "" ), Space( Indent ) + "            TRANSPARENT "   + xArray[ nItem, 33 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 35 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ACTION "        + xArray[ nItem, 35 ]            + CRLF, "" ), Space( Indent ) + "            ACTION "        + xArray[ nItem, 35 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 61 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONMOUSEHOVER "  + xArray[ nItem, 61 ]            + CRLF, "" ), Space( Indent ) + "            ONMOUSEHOVER "  + xArray[ nItem, 61 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 63 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONMOUSELEAVE "  + xArray[ nItem, 63 ]            + CRLF, "" ), Space( Indent ) + "            ONMOUSELEAVE "  + xArray[ nItem, 63 ]            + CRLF )
           Output += iif( xArray[ nItem, 37 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            AUTOSIZE "      + xArray[ nItem, 37 ]            + CRLF, "" ), Space( Indent ) + "            AUTOSIZE "      + xArray[ nItem, 37 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 39 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            BACKCOLOR "     + xArray[ nItem, 39 ]            + CRLF, "" ), Space( Indent ) + "            BACKCOLOR "     + xArray[ nItem, 39 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 41 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            FONTCOLOR "     + xArray[ nItem, 41 ]            + CRLF, "" ), Space( Indent ) + "            FONTCOLOR "     + xArray[ nItem, 41 ]            + CRLF )

           Output += iif( xArray[ nItem, 51 ]          = ".T."     ,                Space( Indent ) + "            BORDER "        + xArray[ nItem, 51 ]            + CRLF, "" )
           Output += iif( xArray[ nItem, 53 ]          = ".T."     ,                Space( Indent ) + "            CLIENTEDGE "    + xArray[ nItem, 53 ]            + CRLF, "" )
           Output += iif( xArray[ nItem, 55 ]          = ".T."     ,                Space( Indent ) + "            HSCROLL "       + xArray[ nItem, 55 ]            + CRLF, "" )
           Output += iif( xArray[ nItem, 57 ]          = ".T."     ,                Space( Indent ) + "            VSCROLL "       + xArray[ nItem, 57 ]            + CRLF, "" )
           Output += iif( xArray[ nItem, 59 ]          = ".T."     ,                Space( Indent ) + "            BLINK "         + xArray[ nItem, 59 ]            + CRLF, "" )

           IF xArray[ nItem, 43 ] = "2"
              Output += Space( Indent ) + "            RIGHTALIGN .T."   + CRLF
           ELSEIF xArray[ nItem, 43 ] = "3"
              Output += Space( Indent ) + "            CENTERALIGN .T."  + CRLF
           ENDIF
           Output += iif( xArray[ nItem, 65 ]          = ".T."     ,                Space( Indent ) + "            VCENTERALIGN "         + xArray[ nItem, 65 ]            + CRLF, "" )

           Output += Space( Indent ) + "     END LABEL  " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       CASE cCtrlName == "CHECKLABEL"      // 31

           Output += Space( Indent ) + "     DEFINE CHECKLABEL "        + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent ) + "            ROW    "       + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent ) + "            COL    "       + AllTrim( Str( Col ) )          + CRLF
           Output += Space( Indent ) + "            WIDTH  "       + AllTrim( xArray[ nItem,  9 ] ) + CRLF
           Output += Space( Indent ) + "            HEIGHT "       + AllTrim( xArray[ nItem, 11 ] ) + CRLF
           Output += Space( Indent ) + "            VALUE "        + AllTrim( xArray[ nItem, 13 ] ) + CRLF

           Output += iif( xArray[ nItem, 23 ]          = '"Arial"' , iif( lSaveAll, Space( Indent ) + "            FONTNAME "      + AllTrim( xArray[ nItem, 23 ] ) + CRLF, "" ), Space( Indent ) + "            FONTNAME "      + AllTrim( xArray[ nItem, 23 ] ) + CRLF )
           Output += iif( xArray[ nItem, 25 ]          = "9"       , iif( lSaveAll, Space( Indent ) + "            FONTSIZE "      + xArray[ nItem, 25 ]            + CRLF, "" ), Space( Indent ) + "            FONTSIZE "      + xArray[ nItem, 25 ]            + CRLF )
           Output += iif( xArray[ nItem, 35 ]          = [""]      , iif( lSaveAll, Space( Indent ) + "            TOOLTIP "       + AllTrim( xArray[ nItem, 35 ] ) + CRLF, "" ), Space( Indent ) + "            TOOLTIP "       + AllTrim( xArray[ nItem, 35 ] ) + CRLF )
           Output += iif( xArray[ nItem, 27 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTBOLD "      + xArray[ nItem, 27 ]            + CRLF, "" ), Space( Indent ) + "            FONTBOLD "      + xArray[ nItem, 27 ]            + CRLF )
           Output += iif( xArray[ nItem, 29 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTITALIC "    + xArray[ nItem, 29 ]            + CRLF, "" ), Space( Indent ) + "            FONTITALIC "    + xArray[ nItem, 29 ]            + CRLF )
           Output += iif( xArray[ nItem, 31 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTUNDERLINE " + xArray[ nItem, 31 ]            + CRLF, "" ), Space( Indent ) + "            FONTUNDERLINE " + xArray[ nItem, 31 ]            + CRLF )
           Output += iif( xArray[ nItem, 33 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTSTRIKEOUT " + xArray[ nItem, 33 ]            + CRLF, "" ), Space( Indent ) + "            FONTSTRIKEOUT " + xArray[ nItem, 33 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 43 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            HELPID "        + xArray[ nItem, 63 ]            + CRLF, "" ), Space( Indent ) + "            HELPID "        + xArray[ nItem, 43 ]            + CRLF )
           Output += iif( xArray[ nItem, 45 ]          = ".T."     , iif( lSaveAll, Space( Indent ) + "            VISIBLE "       + xArray[ nItem, 65 ]            + CRLF, "" ), Space( Indent ) + "            VISIBLE "       + xArray[ nItem, 45 ]            + CRLF )
           Output += iif( xArray[ nItem, 55 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            TRANSPARENT "   + xArray[ nItem, 51 ]            + CRLF, "" ), Space( Indent ) + "            TRANSPARENT "   + xArray[ nItem, 55 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 15 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ACTION "        + xArray[ nItem, 15 ]            + CRLF, "" ), Space( Indent ) + "            ACTION "        + xArray[ nItem, 15 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 17 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONMOUSEHOVER "  + xArray[ nItem, 17 ]            + CRLF, "" ), Space( Indent ) + "            ONMOUSEHOVER "  + xArray[ nItem, 17 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 19 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONMOUSELEAVE "  + xArray[ nItem, 19 ]            + CRLF, "" ), Space( Indent ) + "            ONMOUSELEAVE "  + xArray[ nItem, 19 ]            + CRLF )
           Output += iif( xArray[ nItem, 21 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            AUTOSIZE "      + xArray[ nItem, 21 ]            + CRLF, "" ), Space( Indent ) + "            AUTOSIZE "      + xArray[ nItem, 21 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 37 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            BACKCOLOR "     + xArray[ nItem, 37 ]            + CRLF, "" ), Space( Indent ) + "            BACKCOLOR "     + xArray[ nItem, 37 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 39 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            FONTCOLOR "     + xArray[ nItem, 39 ]            + CRLF, "" ), Space( Indent ) + "            FONTCOLOR "     + xArray[ nItem, 39 ]            + CRLF )

           Output += iif( Upper( xArray[ nItem, 41 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            IMAGE "         + xArray[ nItem, 41 ]            + CRLF, "" ), Space( Indent ) + "            IMAGE "     + xArray[ nItem, 41 ]            + CRLF )

           Output += iif( xArray[ nItem, 47 ]          = ".T."     ,                Space( Indent ) + "            BORDER "        + xArray[ nItem, 47 ]            + CRLF, "" )
           Output += iif( xArray[ nItem, 49 ]          = ".T."     ,                Space( Indent ) + "            CLIENTEDGE "    + xArray[ nItem, 49 ]            + CRLF, "" )
           Output += iif( xArray[ nItem, 51 ]          = ".T."     ,                Space( Indent ) + "            HSCROLL "       + xArray[ nItem, 51 ]            + CRLF, "" )
           Output += iif( xArray[ nItem, 53 ]          = ".T."     ,                Space( Indent ) + "            VSCROLL "       + xArray[ nItem, 53 ]            + CRLF, "" )
           Output += iif( xArray[ nItem, 57 ]          = ".T."     ,                Space( Indent ) + "            BLINK "         + xArray[ nItem, 57 ]            + CRLF, "" )

           IF xArray[ nItem, 59 ] =  "2"
              Output += Space( Indent ) + "            RIGHTALIGN .T."   + CRLF
           ELSEIF xArray[ nItem, 59 ] =  "3"
              Output += Space( Indent ) + "            CENTERALIGN .T."  + CRLF
           ENDIF
           Output += iif( xArray[ nItem, 67 ]          = ".T."     ,                Space( Indent ) + "            LEFTCHECK "     + xArray[ nItem, 59 ]            + CRLF, "" )
           Output += iif( xArray[ nItem, 69 ]          = ".T."     ,                Space( Indent ) + "            CHECKED "       + xArray[ nItem, 61 ]            + CRLF, "" )

           Output += Space( Indent ) + "     END CHECKLABEL  " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName ==  "PLAYER"    // 22

           Output += Space( Indent ) + "     DEFINE PLAYER "   + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent ) + "            ROW    "   + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent ) + "            COL    "   + AllTrim( Str( Col ) )          + CRLF
           Output += Space( Indent ) + "            WIDTH  "   + AllTrim( Str( Width ) )        + CRLF
           Output += Space( Indent ) + "            HEIGHT "   + AllTrim( Str( Height ) )       + CRLF
           Output += Space( Indent ) + "            FILE "     + AllTrim( xArray[ nItem, 13 ] ) + CRLF
           Output += iif( Upper( xArray[ nItem, 15 ] ) = "NIL" , iif( lSaveAll, Space( Indent ) + "            HELPID "           + xArray[ nItem, 15 ] + CRLF, "" ), Space( Indent ) + "            HELPID "            + xArray[ nItem, 15 ] + CRLF )
           Output += iif( xArray[ nItem, 17 ]          = ".F." , iif( lSaveAll, Space( Indent ) + "            NOAUTOSIZEWINDOW " + xArray[ nItem, 17 ] + CRLF, "" ), Space( Indent ) + "            NOAUTOSIZEWINDOW "  + xArray[ nItem, 17 ] + CRLF )
           Output += iif( xArray[ nItem, 19 ]          = ".F." , iif( lSaveAll, Space( Indent ) + "            NOAUTOSIZEMOVIE "  + xArray[ nItem, 19 ] + CRLF, "" ), Space( Indent ) + "            NOAUTOSIZEMOVIE "   + xArray[ nItem, 19 ] + CRLF )
           Output += iif( xArray[ nItem, 21 ]          = ".F." , iif( lSaveAll, Space( Indent ) + "            NOERRORDLG "       + xArray[ nItem, 21 ] + CRLF, "" ), Space( Indent ) + "            NOERRORDLG "        + xArray[ nItem, 21 ] + CRLF )
           Output += iif( xArray[ nItem, 23 ]          = ".F." , iif( lSaveAll, Space( Indent ) + "            NOMENU "           + xArray[ nItem, 23 ] + CRLF, "" ), Space( Indent ) + "            NOMENU "            + xArray[ nItem, 23 ] + CRLF )
           Output += iif( xArray[ nItem, 25 ]          = ".F." , iif( lSaveAll, Space( Indent ) + "            NOOPEN "           + xArray[ nItem, 25 ] + CRLF, "" ), Space( Indent ) + "            NOOPEN "            + xArray[ nItem, 25 ] + CRLF )
           Output += iif( xArray[ nItem, 27 ]          = ".F." , iif( lSaveAll, Space( Indent ) + "            NOPLAYBAR "        + xArray[ nItem, 27 ] + CRLF, "" ), Space( Indent ) + "            NOPLAYBAR "         + xArray[ nItem, 27 ] + CRLF )
           Output += iif( xArray[ nItem, 29 ]          = ".F." , iif( lSaveAll, Space( Indent ) + "            SHOWALL "          + xArray[ nItem, 29 ] + CRLF, "" ), Space( Indent ) + "            SHOWALL "           + xArray[ nItem, 29 ] + CRLF )
           Output += iif( xArray[ nItem, 31 ]          = ".F." , iif( lSaveAll, Space( Indent ) + "            SHOWMODE "         + xArray[ nItem, 31 ] + CRLF, "" ), Space( Indent ) + "            SHOWMODE "          + xArray[ nItem, 31 ] + CRLF )
           Output += iif( xArray[ nItem, 33 ]          = ".F." , iif( lSaveAll, Space( Indent ) + "            SHOWNAME "         + xArray[ nItem, 33 ] + CRLF, "" ), Space( Indent ) + "            SHOWNAME "          + xArray[ nItem, 33 ] + CRLF )
           Output += iif( xArray[ nItem, 35 ]          = ".F." , iif( lSaveAll, Space( Indent ) + "            SHOWPOSITION "     + xArray[ nItem, 35 ] + CRLF, "" ), Space( Indent ) + "            SHOWPOSITION "      + xArray[ nItem, 35 ] + CRLF )
           Output += Space( Indent ) + "     END PLAYER  " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "PROGRESSBAR"  // 21

           Output += Space( Indent ) + "     DEFINE PROGRESSBAR " + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent ) + "            ROW    "      + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent ) + "            COL    "      + AllTrim( Str( Col ) )          + CRLF
           Output += Space( Indent ) + "            WIDTH  "      + AllTrim( Str( Width ) )        + CRLF
           Output += Space( Indent ) + "            HEIGHT "      + AllTrim( Str( Height ) )       + CRLF
           Output += Space( Indent ) + "            RANGEMIN "    + xArray[ nItem, 13 ]            + CRLF
           Output += Space( Indent ) + "            RANGEMAX "    + xArray[ nItem, 15 ]            + CRLF
           Output += iif( xArray[ nItem, 17 ]          = "0"      , iif( lSaveAll, Space( Indent ) + "            VALUE "   + xArray[ nItem, 17 ]            + CRLF, "" ), Space( Indent ) + "            VALUE "     + xArray[ nItem, 17 ]            + CRLF )
           Output += iif( xArray[ nItem, 19 ]          = [""]     , iif( lSaveAll, Space( Indent ) + "            TOOLTIP " + AllTrim( xArray[ nItem, 19 ] ) + CRLF, "" ), Space( Indent ) + "            TOOLTIP "   + AllTrim( xArray[ nItem, 19 ] ) + CRLF )
           Output += iif( Upper( xArray[ nItem, 21 ] ) = "NIL"    , iif( lSaveAll, Space( Indent ) + "            HELPID "  + xArray[ nItem, 21 ]            + CRLF, "" ), Space( Indent ) + "            HELPID "    + xArray[ nItem, 21 ]            + CRLF )
           Output += iif( xArray[ nItem, 23 ]          = ".T."    , iif( lSaveAll, Space( Indent ) + "            VISIBLE " + xArray[ nItem, 23 ]            + CRLF, "" ), Space( Indent ) + "            VISIBLE "   + xArray[ nItem, 23 ]            + CRLF )
           Output += iif( xArray[ nItem, 25 ]          = ".F."    , iif( lSaveAll, Space( Indent ) + "            SMOOTH "  + xArray[ nItem, 25 ]            + CRLF, "" ), Space( Indent ) + "            SMOOTH "    + xArray[ nItem, 25 ]            + CRLF )

           IF xArray[ nItem, 33 ] = "1"
              Output += iif( xArray[ nItem, 33 ]       = "1"        , iif( lSaveAll, Space( Indent ) + "            VERTICAL .F." + CRLF, "" ), Space( Indent ) + "            VERTICAL .F." + CRLF )
           ELSE
              Output += Space( Indent ) + "            VERTICAL .T." + CRLF
           ENDIF

           Output += iif( Upper( xArray[ nItem, 29 ] )  = "NIL"   , iif( lSaveAll, Space( Indent ) + "            BACKCOLOR " + xArray[ nItem, 29 ]        + CRLF, "" ), Space( Indent ) + "            BACKCOLOR " + xArray[ nItem, 29 ]          + CRLF )
           Output += iif( Upper( xArray[ nItem, 31 ] )  = "NIL"   , iif( lSaveAll, Space( Indent ) + "            FORECOLOR " + xArray[ nItem, 31 ]        + CRLF, "" ), Space( Indent ) + "            FORECOLOR " + xArray[ nItem, 31 ]          + CRLF )
           Output += iif( Upper( xArray[ nItem, 35 ] )  = ".F."   , iif( lSaveAll, Space( Indent ) + "            MARQUEE "   + xArray[ nItem, 35 ]        + CRLF, "" ), Space( Indent ) + "            MARQUEE "   + xArray[ nItem, 35 ]          + CRLF )
           Output += iif( Upper( xArray[ nItem, 37 ] )  == "40"   , iif( lSaveAll, Space( Indent ) + "            VELOCITY "  + xArray[ nItem, 37 ]        + CRLF, "" ), Space( Indent ) + "            VELOCITY "  + xArray[ nItem, 37 ]          + CRLF )


           Output += Space( Indent )+"     END PROGRESSBAR  " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "RADIOGROUP"   // 15

           Output += Space( Indent ) + "     DEFINE RADIOGROUP "   + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent ) + "            ROW    "       + xArray[ nItem, 5 ]             + CRLF
           Output += Space( Indent ) + "            COL    "       + xArray[ nItem, 7 ]             + CRLF
           Output += Space( Indent ) + "            WIDTH  "       + xArray[ nItem, 9 ]             + CRLF
           Output += Space( Indent ) + "            HEIGHT "       + xArray[ nItem, 11 ]            + CRLF
           Output += Space( Indent ) + "            OPTIONS "      + xArray[ nItem, 13 ]            + CRLF
           Output += iif( xArray[ nItem, 15 ]          = "0"       , iif( lSaveAll, Space( Indent ) + "            VALUE "         + xArray[ nItem, 15 ]          + CRLF, "" ), Space( Indent ) + "            VALUE "          + xArray[ nItem, 15 ]          + CRLF )
           Output += iif( xArray[ nItem, 17 ]          = '"Arial"' , iif( lSaveAll, Space( Indent ) + "            FONTNAME "      + AllTrim( xArray[ nItem, 17 ] ) + CRLF, "" ), Space( Indent ) + "            FONTNAME "       + AllTrim( xArray[ nItem, 17 ] ) + CRLF )
           Output += iif( xArray[ nItem, 19 ]          = "9"       , iif( lSaveAll, Space( Indent ) + "            FONTSIZE "      + xArray[ nItem, 19 ]          + CRLF, "" ), Space( Indent ) + "            FONTSIZE "       + xArray[ nItem, 19 ]          + CRLF )
           Output += iif( xArray[ nItem, 21 ]          = [""]      , iif( lSaveAll, Space( Indent ) + "            TOOLTIP "       + AllTrim( xArray[ nItem, 21 ] ) + CRLF, "" ), Space( Indent ) + "            TOOLTIP "        + AllTrim( xArray[ nItem, 21 ] ) + CRLF )
           Output += iif( Upper( xArray[ nItem, 23 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONCHANGE "      + xArray[ nItem, 23 ]          + CRLF, "" ), Space( Indent ) + "            ONCHANGE "       + xArray[ nItem, 23 ]          + CRLF )
           Output += iif( xArray[ nItem, 25 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTBOLD "      + xArray[ nItem, 25 ]          + CRLF, "" ), Space( Indent ) + "            FONTBOLD "       + xArray[ nItem, 25 ]          + CRLF )
           Output += iif( xArray[ nItem, 27 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTITALIC "    + xArray[ nItem, 27 ]          + CRLF, "" ), Space( Indent ) + "            FONTITALIC "     + xArray[ nItem, 27 ]          + CRLF )
           Output += iif( xArray[ nItem, 29 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTUNDERLINE " + xArray[ nItem, 29 ]          + CRLF, "" ), Space( Indent ) + "            FONTUNDERLINE "  + xArray[ nItem, 29 ]          + CRLF )
           Output += iif( xArray[ nItem, 31 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTSTRIKEOUT " + xArray[ nItem, 31 ]          + CRLF, "" ), Space( Indent ) + "            FONTSTRIKEOUT "  + xArray[ nItem, 31 ]          + CRLF )
           Output += iif( Upper( xArray[ nItem, 33 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            HELPID "        + xArray[ nItem, 33 ]          + CRLF, "" ), Space( Indent ) + "            HELPID "         + xArray[ nItem, 33 ]          + CRLF )
           Output += iif( xArray[ nItem, 35 ]          = ".T."     , iif( lSaveAll, Space( Indent ) + "            TABSTOP "       + xArray[ nItem, 35 ]          + CRLF, "" ), Space( Indent ) + "            TABSTOP "        + xArray[ nItem, 35 ]          + CRLF )
           Output += iif( xArray[ nItem, 37 ]          = ".T."     , iif( lSaveAll, Space( Indent ) + "            VISIBLE "       + xArray[ nItem, 37 ]          + CRLF, "" ), Space( Indent ) + "            VISIBLE "        + xArray[ nItem, 37 ]          + CRLF )
           Output += iif( xArray[ nItem, 39 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            TRANSPARENT "   + xArray[ nItem, 39 ]          + CRLF, "" ), Space( Indent ) + "            TRANSPARENT "    + xArray[ nItem, 39 ]          + CRLF )
           Output += iif( xArray[ nItem, 41 ]          = "25"      , iif( lSaveAll, Space( Indent ) + "            SPACING "       + xArray[ nItem, 41 ]          + CRLF, "" ), Space( Indent ) + "            SPACING "        + xArray[ nItem, 41 ]          + CRLF )
           Output += iif( Upper( xArray[ nItem, 43 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            BACKCOLOR "     + xArray[ nItem, 43 ]          + CRLF, "" ), Space( Indent ) + "            BACKCOLOR "      + xArray[ nItem, 43 ]          + CRLF )
           Output += iif( Upper( xArray[ nItem, 45 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            FONTCOLOR "     + xArray[ nItem, 45 ]          + CRLF, "" ), Space( Indent ) + "            FONTCOLOR "      + xArray[ nItem, 45 ]          + CRLF )

           IF xArray[ nItem, 47 ] # ".F."
              Output += Space( Indent ) + "            LEFTJUSTIFY " + xArray[ nItem, 47 ] + CRLF
           ENDIF

           Output += iif(Len(AllTrim( xArray[ nItem, 51 ] )) = 0    , iif( lSaveAll, Space( Indent ) + "            READONLY NIL"                      + CRLF, "" ), Space( Indent ) + "            READONLY "   + xArray[ nItem, 51 ] + CRLF )
           Output += iif( xArray[ nItem, 49 ]                = ".F.", iif( lSaveAll, Space( Indent ) + "            HORIZONTAL " + xArray[ nItem, 49 ] + CRLF, "" ), Space( Indent ) + "            HORIZONTAL " + xArray[ nItem, 49 ] + CRLF )
           Output += Space( Indent )+"     END RADIOGROUP  " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "SLIDER"     // 7

           Output += Space( Indent ) + "     DEFINE SLIDER "    + AllTrim( xArray[ nItem,  3 ] ) + CRLF
           Output += Space( Indent ) + "            ROW    "    + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent ) + "            COL    "    + AllTrim( Str( Col ) )          + CRLF
           Output += Space( Indent ) + "            WIDTH  "    + AllTrim( xArray[ nItem,  9 ] ) + CRLF
           Output += Space( Indent ) + "            HEIGHT "    + AllTrim( xArray[ nItem, 11 ] ) + CRLF
           Output += Space( Indent ) + "            RANGEMIN "  + xArray[ nItem, 13 ]            + CRLF
           Output += Space( Indent ) + "            RANGEMAX "  + xArray[ nItem, 15 ]            + CRLF
           Output += iif( xArray[ nItem, 17 ]          = "0"    , iif( lSaveAll, Space( Indent ) + "            VALUE "    + xArray[ nItem, 17 ]            + CRLF, "" ), Space( Indent ) + "            VALUE "    + xArray[ nItem, 17 ]            + CRLF )
           Output += iif( xArray[ nItem, 19 ]          = [""]   , iif( lSaveAll, Space( Indent ) + "            TOOLTIP "  + AllTrim( xArray[ nItem, 19 ] ) + CRLF, "" ), Space( Indent ) + "            TOOLTIP "  + AllTrim( xArray[ nItem, 19 ] ) + CRLF )
           Output += iif( Upper( xArray[ nItem, 21 ] ) = "NIL"  , iif( lSaveAll, Space( Indent ) + "            ONCHANGE " + xArray[ nItem, 21 ]            + CRLF, "" ), Space( Indent ) + "            ONCHANGE " + xArray[ nItem, 21 ]            + CRLF )

           IF xArray[ nItem, 53 ] # "NIL"
              Output += Space( Indent ) + "            ONSCROLL " + xArray[ nItem, 53 ] + CRLF
           ENDIF

           Output += iif( Upper( xArray[ nItem, 23 ] ) = "NIL"    , iif( lSaveAll, Space( Indent ) + "            HELPID "   + xArray[ nItem, 23 ]          + CRLF, "" ), Space( Indent ) + "            HELPID "   + xArray[ nItem, 23 ]          + CRLF )
           Output += iif( xArray[ nItem, 25 ]          = ".T."    , iif( lSaveAll, Space( Indent ) + "            TABSTOP "  + xArray[ nItem, 25 ]          + CRLF, "" ), Space( Indent ) + "            TABSTOP "  + xArray[ nItem, 25 ]          + CRLF )
           Output += iif( xArray[ nItem, 27 ]          = ".T."    , iif( lSaveAll, Space( Indent ) + "            VISIBLE "  + xArray[ nItem, 27 ]          + CRLF, "" ), Space( Indent ) + "            VISIBLE "  + xArray[ nItem, 27 ]          + CRLF )

           IF xArray[ nItem, 33 ] = "2"
              IF xArray[ nItem, 35 ] = "1"
                 Output += Space( Indent ) + "            BOTH .T."     + CRLF
              ELSEIF xArray[ nItem, 35 ] = "2"
                 Output += Space( Indent ) + "            LEFT .T."     + CRLF
              ELSEIF xArray[ nItem, 35 ] = "3"
                 Output += Space( Indent ) + "            NOTICKS .T."  + CRLF
              ENDIF
              Output += Space( Indent )    + "            VERTICAL .T." + CRLF
           ENDIF

           IF xArray[ nItem, 33 ] = "1"
              IF xArray[ nItem, 35 ] = "1"
                 Output += Space( Indent ) + "            BOTH .T."     + CRLF
              ELSEIF xArray[ nItem, 35 ] = "4"
                 Output += Space( Indent ) + "            TOP .T."      + CRLF
              ELSEIF xArray[ nItem, 35 ] = "3"
                 Output += Space( Indent ) + "            NOTICKS .T."  + CRLF
              ENDIF
           ENDIF

           Output += iif( Upper( xArray[ nItem, 31 ] ) = "NIL", iif( lSaveAll, Space( Indent ) + "            BACKCOLOR " + xArray[ nItem, 31 ] + CRLF, "" ), Space( Indent ) + "            BACKCOLOR " + xArray[ nItem, 31 ] + CRLF )
           Output += Space( Indent ) + "     END SLIDER  " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "SPINNER"     //  8

           Output += Space( Indent ) + "     DEFINE SPINNER "        + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent ) + "            ROW    "         + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent ) + "            COL    "         + AllTrim( Str( Col ) )          + CRLF
           Output += Space( Indent ) + "            WIDTH  "         + xArray[ nItem,  9 ]            + CRLF
           Output += Space( Indent ) + "            HEIGHT "         + xArray[ nItem, 11 ]            + CRLF
           Output += Space( Indent ) + "            RANGEMIN "       + xArray[ nItem, 13 ]            + CRLF
           Output += Space( Indent ) + "            RANGEMAX "       + xArray[ nItem, 15 ]            + CRLF
           Output += iif( xArray[ nItem, 17 ]          = "0"       , iif( lSaveAll, Space( Indent ) + "            VALUE "         + xArray[ nItem, 17 ]            + CRLF, "" ), Space( Indent ) + "            VALUE "           + xArray[ nItem, 17 ]            + CRLF )
           Output += iif( xArray[ nItem, 19 ]          = '"Arial"' , iif( lSaveAll, Space( Indent ) + "            FONTNAME "      + AllTrim( xArray[ nItem, 19 ] ) + CRLF, "" ), Space( Indent ) + "            FONTNAME "        + AllTrim( xArray[ nItem, 19 ] ) + CRLF )
           Output += iif( xArray[ nItem, 21 ]          = "9"       , iif( lSaveAll, Space( Indent ) + "            FONTSIZE "      + xArray[ nItem, 21 ]            + CRLF, "" ), Space( Indent ) + "            FONTSIZE "        + xArray[ nItem, 21 ]            + CRLF )
           Output += iif( xArray[ nItem, 23 ]          = [""]      , iif( lSaveAll, Space( Indent ) + "            TOOLTIP "       + AllTrim( xArray[ nItem, 23 ] ) + CRLF, "" ), Space( Indent ) + "            TOOLTIP "         + AllTrim( xArray[ nItem, 23 ] ) + CRLF )
           Output += iif( Upper( xArray[ nItem, 25 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONCHANGE "      + xArray[ nItem, 25 ]            + CRLF, "" ), Space( Indent ) + "            ONCHANGE "        + xArray[ nItem, 25 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 27 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONGOTFOCUS "    + xArray[ nItem, 27 ]            + CRLF, "" ), Space( Indent ) + "            ONGOTFOCUS "      + xArray[ nItem, 27 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 29 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONLOSTFOCUS "   + xArray[ nItem, 29 ]            + CRLF, "" ), Space( Indent ) + "            ONLOSTFOCUS "     + xArray[ nItem, 29 ]            + CRLF )
           Output += iif( xArray[ nItem, 31 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTBOLD "      + xArray[ nItem, 31 ]            + CRLF, "" ), Space( Indent ) + "            FONTBOLD "        + xArray[ nItem, 31 ]            + CRLF )
           Output += iif( xArray[ nItem, 33 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTITALIC "    + xArray[ nItem, 33 ]            + CRLF, "" ), Space( Indent ) + "            FONTITALIC "      + xArray[ nItem, 33 ]            + CRLF )
           Output += iif( xArray[ nItem, 35 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTUNDERLINE " + xArray[ nItem, 35 ]            + CRLF, "" ), Space( Indent ) + "            FONTUNDERLINE "   + xArray[ nItem, 35 ]            + CRLF )
           Output += iif( xArray[ nItem, 37 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTSTRIKEOUT " + xArray[ nItem, 37 ]            + CRLF, "" ), Space( Indent ) + "            FONTSTRIKEOUT "   + xArray[ nItem, 37 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 39 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            HELPID "        + xArray[ nItem, 39 ]            + CRLF, "" ), Space( Indent ) + "            HELPID "          + xArray[ nItem, 39 ]            + CRLF )
           Output += iif( xArray[ nItem, 41 ]          = ".T."     , iif( lSaveAll, Space( Indent ) + "            TABSTOP "       + xArray[ nItem, 41 ]            + CRLF, "" ), Space( Indent ) + "            TABSTOP "         + xArray[ nItem, 41 ]            + CRLF )
           Output += iif( xArray[ nItem, 43 ]          = ".T."     , iif( lSaveAll, Space( Indent ) + "            VISIBLE "       + xArray[ nItem, 43 ]            + CRLF, "" ), Space( Indent ) + "            VISIBLE "         + xArray[ nItem, 43 ]            + CRLF )
           Output += iif( xArray[ nItem, 45 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            WRAP "          + xArray[ nItem, 45 ]            + CRLF, "" ), Space( Indent ) + "            WRAP "            + xArray[ nItem, 45 ]            + CRLF )
           Output += iif( xArray[ nItem, 47 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            READONLY "      + xArray[ nItem, 47 ]            + CRLF, "" ), Space( Indent ) + "            READONLY "        + xArray[ nItem, 47 ]            + CRLF )
           Output += iif( xArray[ nItem, 49 ]          = "1"       , iif( lSaveAll, Space( Indent ) + "            INCREMENT "     + xArray[ nItem, 49 ]            + CRLF, "" ), Space( Indent ) + "            INCREMENT "       + xArray[ nItem, 49 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 51 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            BACKCOLOR "     + xArray[ nItem, 51 ]            + CRLF, "" ), Space( Indent ) + "            BACKCOLOR "       + xArray[ nItem, 51 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 53 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            FONTCOLOR "     + xArray[ nItem, 53 ]            + CRLF, "" ), Space( Indent ) + "            FONTCOLOR "       + xArray[ nItem, 53 ]            + CRLF )
           Output += Space( Indent ) + "     END SPINNER  " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "FRAME"     // 16

           Output += Space( Indent ) + "     DEFINE FRAME "         + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent ) + "            ROW    "        + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent ) + "            COL    "        + AllTrim( Str( Col ) )          + CRLF
           Output += Space( Indent ) + "            WIDTH  "        + AllTrim( Str( Width ) )        + CRLF
           Output += Space( Indent ) + "            HEIGHT "        + AllTrim( Str( Height ) )       + CRLF
           Output += iif( xArray[ nItem, 13 ]          = '"Arial"'  , iif( lSaveAll, Space( Indent ) + "            FONTNAME "        + AllTrim( xArray[ nItem, 13 ] ) + CRLF, "" ), Space( Indent ) + "            FONTNAME "          + AllTrim( xArray[ nItem, 13 ] ) + CRLF )
           Output += iif( xArray[ nItem, 15 ]          = "9"        , iif( lSaveAll, Space( Indent ) + "            FONTSIZE "        + xArray[ nItem, 15 ]            + CRLF, "" ), Space( Indent ) + "            FONTSIZE "          + xArray[ nItem, 15 ]            + CRLF )
           Output += iif( xArray[ nItem, 17 ]          = ".F."      , iif( lSaveAll, Space( Indent ) + "            FONTBOLD "        + xArray[ nItem, 17 ]            + CRLF, "" ), Space( Indent ) + "            FONTBOLD "          + xArray[ nItem, 17 ]            + CRLF )
           Output += iif( xArray[ nItem, 19 ]          = ".F."      , iif( lSaveAll, Space( Indent ) + "            FONTITALIC "      + xArray[ nItem, 19 ]            + CRLF, "" ), Space( Indent ) + "            FONTITALIC "        + xArray[ nItem, 19 ]            + CRLF )
           Output += iif( xArray[ nItem, 21 ]          = ".F."      , iif( lSaveAll, Space( Indent ) + "            FONTUNDERLINE "   + xArray[ nItem, 21 ]            + CRLF, "" ), Space( Indent ) + "            FONTUNDERLINE "     + xArray[ nItem, 21 ]            + CRLF )
           Output += iif( xArray[ nItem, 23 ]          = ".F."      , iif( lSaveAll, Space( Indent ) + "            FONTSTRIKEOUT "   + xArray[ nItem, 23 ]            + CRLF, "" ), Space( Indent ) + "            FONTSTRIKEOUT "     + xArray[ nItem, 23 ]            + CRLF )
           Output += iif( xArray[ nItem, 25 ]          = '""'       , iif( lSaveAll, Space( Indent ) + "            CAPTION NIL"                                       + CRLF, "" ), Space( Indent ) + "            CAPTION "           + AllTrim( xArray[ nItem, 25 ] ) + CRLF )
           Output += iif( Upper( xArray[ nItem, 27 ] ) = "NIL"      , iif( lSaveAll, Space( Indent ) + "            BACKCOLOR "       + xArray[ nItem, 27 ]            + CRLF, "" ), Space( Indent ) + "            BACKCOLOR "         + xArray[ nItem, 27 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 29 ] ) = "NIL"      , iif( lSaveAll, Space( Indent ) + "            FONTCOLOR "       + xArray[ nItem, 29 ]            + CRLF, "" ), Space( Indent ) + "            FONTCOLOR "         + xArray[ nItem, 29 ]            + CRLF )
           Output += iif( xArray[ nItem, 31 ]          = ".F."      , iif( lSaveAll, Space( Indent ) + "            OPAQUE "          + xArray[ nItem, 31 ]            + CRLF, "" ), Space( Indent ) + "            OPAQUE "            + xArray[ nItem, 31 ]            + CRLF )
           Output += iif( xArray[ nItem, 35 ]          = ".F."      , iif( lSaveAll, Space( Indent ) + "            TRANSPARENT "     + xArray[ nItem, 35 ]            + CRLF, "" ), Space( Indent ) + "            TRANSPARENT "       + xArray[ nItem, 35 ]            + CRLF )
           Output += iif( xArray[ nItem, 33 ]          = ".F."      , iif( lSaveAll, Space( Indent ) + "            INVISIBLE "       + xArray[ nItem, 33 ]            + CRLF, "" ), Space( Indent ) + "            INVISIBLE "         + xArray[ nItem, 33 ]            + CRLF )

           Output += Space( Indent ) + "     END FRAME  " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "BROWSE"  // 14

           /* Start Code - A.M. Revized 23/12/2007 */

           IF Empty( xArray[ nItem, 89 ] ) .OR. Upper( xArray[ nItem, 89 ] ) == "NIL"
              cWorkArea := xArray[ nItem, 19 ]
           ELSE
              cWorkArea := xArray[ nItem, 89 ]
           ENDIF
           xArray[ nItem, 89 ] := cWorkArea

           /* End Code - A.M. Revized 23/12/2007 */

           Output += Space( Indent ) + "     DEFINE BROWSE "       + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent ) + "            ROW    "       + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent ) + "            COL    "       + AllTrim( Str( Col ) )          + CRLF
           Output += Space( Indent ) + "            WIDTH  "       + AllTrim( Str( Width ) )        + CRLF
           Output += Space( Indent ) + "            HEIGHT "       + AllTrim( Str( Height ) )       + CRLF

           Output += Space( Indent ) + "            HEADERS "      + xArray[ nItem, 13 ]            + CRLF
           Output += Space( Indent ) + "            WIDTHS "       + xArray[ nItem, 15 ]            + CRLF
           Output += Space( Indent ) + "            FIELDS "       + xArray[ nItem, 17 ]            + CRLF
           Output += iif( xArray[ nItem, 19 ]          = "0"       , iif( lSaveAll, Space( Indent ) + "            VALUE "            + xArray[ nItem, 13 ]            + CRLF, "" ), Space( Indent ) + "            VALUE "              + xArray[ nItem, 19 ]            + CRLF )
           Output += Space( Indent ) + "            WORKAREA "     + xArray[ nItem, 21 ]            + CRLF
           Output += iif( xArray[ nItem, 23 ]          = '"Arial"' , iif( lSaveAll, Space( Indent ) + "            FONTNAME "         + AllTrim( xArray[ nItem, 23 ] ) + CRLF, "" ), Space( Indent ) + "            FONTNAME "           + AllTrim( xArray[ nItem, 23 ] ) + CRLF )
           Output += iif( xArray[ nItem, 25 ]          = "9"       , iif( lSaveAll, Space( Indent ) + "            FONTSIZE "         + xArray[ nItem, 25 ]            + CRLF, "" ), Space( Indent ) + "            FONTSIZE "           + xArray[ nItem, 25 ]            + CRLF )
           Output += iif( xArray[ nItem, 27 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTBOLD "         + xArray[ nItem, 27 ]            + CRLF, "" ), Space( Indent ) + "            FONTBOLD "           + xArray[ nItem, 27 ]            + CRLF )
           Output += iif( xArray[ nItem, 29 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTITALIC "       + xArray[ nItem, 29 ]            + CRLF, "" ), Space( Indent ) + "            FONTITALIC "         + xArray[ nItem, 29 ]            + CRLF )
           Output += iif( xArray[ nItem, 31 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTUNDERLINE "    + xArray[ nItem, 31 ]            + CRLF, "" ), Space( Indent ) + "            FONTUNDERLINE "      + xArray[ nItem, 31 ]            + CRLF )
           Output += iif( xArray[ nItem, 33 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTSTRIKEOUT "    + xArray[ nItem, 33 ]            + CRLF, "" ), Space( Indent ) + "            FONTSTRIKEOUT "      + xArray[ nItem, 33 ]            + CRLF )
           Output += iif( xArray[ nItem, 35 ]          = [""]      , iif( lSaveAll, Space( Indent ) + "            TOOLTIP "          + AllTrim( xArray[ nItem, 35 ] ) + CRLF, "" ), Space( Indent ) + "            TOOLTIP "            + AllTrim( xArray[ nItem, 35 ] ) + CRLF )
           Output += iif( Upper( xArray[ nItem, 37 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            BACKCOLOR "        + xArray[ nItem, 37 ]            + CRLF, "" ), Space( Indent ) + "            BACKCOLOR "          + xArray[ nItem, 37 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 39 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            DYNAMICBACKCOLOR " + xArray[ nItem, 39 ]            + CRLF, "" ), Space( Indent ) + "            DYNAMICBACKCOLOR "   + xArray[ nItem, 39 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 41 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            DYNAMICFORECOLOR " + xArray[ nItem, 41 ]            + CRLF, "" ), Space( Indent ) + "            DYNAMICFORECOLOR "   + xArray[ nItem, 41 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 43 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            FONTCOLOR "        + xArray[ nItem, 43 ]            + CRLF, "" ), Space( Indent ) + "            FONTCOLOR "          + xArray[ nItem, 43 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 45 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONGOTFOCUS "       + xArray[ nItem, 45 ]            + CRLF, "" ), Space( Indent ) + "            ONGOTFOCUS "         + xArray[ nItem, 45 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 47 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONCHANGE "         + xArray[ nItem, 47 ]            + CRLF, "" ), Space( Indent ) + "            ONCHANGE "           + xArray[ nItem, 47 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 49 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONLOSTFOCUS "      + xArray[ nItem, 49 ]            + CRLF, "" ), Space( Indent ) + "            ONLOSTFOCUS "        + xArray[ nItem, 49 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 51 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONDBLCLICK "       + xArray[ nItem, 51 ]            + CRLF, "" ), Space( Indent ) + "            ONDBLCLICK "         + xArray[ nItem, 51 ]            + CRLF )
           Output += iif( xArray[ nItem, 53 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            ALLOWEDIT "        + xArray[ nItem, 53 ]            + CRLF, "" ), Space( Indent ) + "            ALLOWEDIT "          + xArray[ nItem, 53 ]            + CRLF )
           Output += iif( xArray[ nItem, 55 ]          = ".T."     , Space( Indent )                + "            INPLACEEDIT "      + xArray[ nItem, 55 ]            + CRLF, "" )
           Output += iif( xArray[ nItem, 57 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            ALLOWAPPEND "      + xArray[ nItem, 57 ]            + CRLF, "" ), Space( Indent ) + "            ALLOWAPPEND "        + xArray[ nItem, 57 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 59 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            INPUTITEMS "       + xArray[ nItem, 59 ]            + CRLF, "" ), Space( Indent ) + "            IMPUTITEMS "         + xArray[ nItem, 59 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 61 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            DISPLAYITEMS "     + xArray[ nItem, 61 ]            + CRLF, "" ), Space( Indent ) + "            DISPLAYITEMS "       + xArray[ nItem, 61 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 63 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONHEADCLICK "      + xArray[ nItem, 63 ]            + CRLF, "" ), Space( Indent ) + "            ONHEADCLICK "        + xArray[ nItem, 63 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 65 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            WHEN "             + xArray[ nItem, 65 ]            + CRLF, "" ), Space( Indent ) + "            WHEN "               + xArray[ nItem, 65 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 67 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            VALID "            + xArray[ nItem, 67 ]            + CRLF, "" ), Space( Indent ) + "            VALID "              + xArray[ nItem, 67 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 69 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            VALIDMESSAGES "    + xArray[ nItem, 69 ]            + CRLF, "" ), Space( Indent ) + "            VALIDMESSAGES "      + xArray[ nItem, 69 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 71 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            PAINTDOUBLEBUFFER "+ xArray[ nItem, 71 ]            + CRLF, "" ), Space( Indent ) + "            PAINTDOUBLEBUFFER "  + xArray[ nItem, 71 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 73 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            READONLYFIELDS "   + xArray[ nItem, 73 ]            + CRLF, "" ), Space( Indent ) + "            READONLYFIELDS "     + xArray[ nItem, 73 ]            + CRLF )
           Output += iif( xArray[ nItem, 75 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            LOCK "             + xArray[ nItem, 75 ]            + CRLF, "" ), Space( Indent ) + "            LOCK "               + xArray[ nItem, 75 ]            + CRLF )
           Output += iif( xArray[ nItem, 77 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            ALLOWDELETE "      + xArray[ nItem, 77 ]            + CRLF, "" ), Space( Indent ) + "            ALLOWDELETE "        + xArray[ nItem, 77 ]            + CRLF )
           Output += iif( xArray[ nItem, 79 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            NOLINES "          + xArray[ nItem, 79 ]            + CRLF, "" ), Space( Indent ) + "            NOLINES "            + xArray[ nItem, 79 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 81 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            IMAGE "            + xArray[ nItem, 81 ]            + CRLF, "" ), Space( Indent ) + "            IMAGE "              + xArray[ nItem, 81 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 83 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            JUSTIFY "          + xArray[ nItem, 83 ]            + CRLF, "" ), Space( Indent ) + "            JUSTIFY "            + xArray[ nItem, 83 ]            + CRLF )
           Output += iif( xArray[ nItem, 85 ]          = ".T."     , iif( lSaveAll, Space( Indent ) + "            VSCROLLBAR "       + xArray[ nItem, 85 ]            + CRLF, "" ), Space( Indent ) + "            VSCROLLBAR "         + xArray[ nItem, 85 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 87 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            HELPID "           + xArray[ nItem, 87 ]            + CRLF, "" ), Space( Indent ) + "            HELPID "             + xArray[ nItem, 87 ]            + CRLF )
           Output += iif( xArray[ nItem, 89 ]          = ".T."     ,                Space( Indent ) + "            BREAK "            + xArray[ nItem, 89 ]            + CRLF, "" )

           Output += iif(!Empty( xArray[ nItem, 91 ] )             , Space( Indent )                + "            HEADERIMAGE "     + xArray[ nItem, 91 ]            + CRLF, "" )
           Output += iif( xArray[ nItem, 93 ]          = ".T."     , Space( Indent )                + "            NOTABSTOP "       + xArray[ nItem, 93 ]            + CRLF, "" )

         * Output += iif( Upper( xArray[ nItem, 95] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            INPUTMASK "       + xArray[ nItem, 95 ]            + CRLF, "" ), Space( Indent ) + "            INPUTMASK "          + xArray[ nItem, 95 ]            + CRLF )
         * Output += iif( Upper( xArray[ nItem, 97] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            FORMAT "          + xArray[ nItem, 97 ]            + CRLF, "" ), Space( Indent ) + "            FORMAT "             + xArray[ nItem, 97 ]            + CRLF )



           Output += Space( Indent )+"     END BROWSE  " + CRLF
           Output += CRLF

           /* Start Code - A.M. Revized 23/12/2007 */
           SavePath( AllTrim( xArray[ nItem, 3 ] ), xArray[ nItem, 87 ] )

           SaveDbfName( AllTrim( xArray[ nItem, 3 ] ), xArray[ nItem, 19 ] )

           IF AllTrim( xArray[ nItem, 19 ] ) == AllTrim( xArray[ nItem, 89 ] )
              SaveAlias( AllTrim( xArray[ nItem, 3 ] ), "" )
           ELSE
              SaveAlias( AllTrim( xArray[ nItem, 3 ] ), xArray[ nItem, 89 ] )
           ENDIF
           /* End Code - A.M. Revized 23/12/2007 */

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName ==  "HYPERLINK"  // 18

           Output += Space( Indent ) + "     DEFINE HYPERLINK "   + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent ) + "            ROW    "      + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent ) + "            COL    "      + AllTrim( Str( Col ) )          + CRLF
           Output += Space( Indent ) + "            WIDTH  "      + AllTrim( Str( Width ) )        + CRLF
           Output += Space( Indent ) + "            HEIGHT "      + AllTrim( Str( Height ) )       + CRLF
           Output += iif( xArray[ nItem, 13 ]         = '""'      , iif( lSaveAll, Space( Indent ) + "            VALUE "         + AllTrim( xArray[ nItem, 13 ] ) + CRLF, "" ), Space( Indent ) + "            VALUE "          + AllTrim( xArray[ nItem, 13 ] ) + CRLF )
           Output += iif( xArray[ nItem, 15 ]         = '""'      , iif( lSaveAll, Space( Indent ) + "            ADDRESS "       + AllTrim( xArray[ nItem, 15 ] ) + CRLF, "" ), Space( Indent ) + "            ADDRESS "        + AllTrim( xArray[ nItem, 15 ] ) + CRLF )
           Output += iif( xArray[ nItem, 17 ]         = '"Arial"' , iif( lSaveAll, Space( Indent ) + "            FONTNAME "      + AllTrim( xArray[ nItem, 17 ] ) + CRLF, "" ), Space( Indent ) + "            FONTNAME "       + AllTrim( xArray[ nItem, 17 ] ) + CRLF )
           Output += iif( xArray[ nItem, 19 ]         = "9"       , iif( lSaveAll, Space( Indent ) + "            FONTSIZE "      + xArray[ nItem, 19 ]            + CRLF, "" ), Space( Indent ) + "            FONTSIZE "       + xArray[ nItem, 19 ]            + CRLF )
           Output += iif( xArray[ nItem, 21 ]         = [""]      , iif( lSaveAll, Space( Indent ) + "            TOOLTIP "       + AllTrim( xArray[ nItem, 21 ] ) + CRLF, "" ), Space( Indent ) + "            TOOLTIP "        + AllTrim( xArray[ nItem, 21 ] ) + CRLF )
           Output += iif( xArray[ nItem, 23 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTBOLD "      + xArray[ nItem, 23 ]            + CRLF, "" ), Space( Indent ) + "            FONTBOLD "       + xArray[ nItem, 23 ]            + CRLF )
           Output += iif( xArray[ nItem, 25 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTITALIC "    + xArray[ nItem, 25 ]            + CRLF, "" ), Space( Indent ) + "            FONTITALIC "     + xArray[ nItem, 25 ]            + CRLF )
           Output += iif( xArray[ nItem, 27 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTUNDERLINE " + xArray[ nItem, 27 ]            + CRLF, "" ), Space( Indent ) + "            FONTUNDERLINE "  + xArray[ nItem, 27 ]            + CRLF )
           Output += iif( xArray[ nItem, 29 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTSTRIKEOUT " + xArray[ nItem, 29 ]            + CRLF, "" ), Space( Indent ) + "            FONTSTRIKEOUT "  + xArray[ nItem, 29 ]            + CRLF )
           Output += iif( xArray[ nItem, 31 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            AUTOSIZE "      + xArray[ nItem, 31 ]            + CRLF, "" ), Space( Indent ) + "            AUTOSIZE "       + xArray[ nItem, 31 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 33 ] )= "NIL"     , iif( lSaveAll, Space( Indent ) + "            HELPID "        + xArray[ nItem, 33 ]            + CRLF, "" ), Space( Indent ) + "            HELPID "         + xArray[ nItem, 33 ]            + CRLF )
           Output += iif( xArray[ nItem, 35 ]         = ".T."     , iif( lSaveAll, Space( Indent ) + "            VISIBLE "       + xArray[ nItem, 35 ]            + CRLF, "" ), Space( Indent ) + "            VISIBLE "        + xArray[ nItem, 35 ]            + CRLF )
           Output += iif( xArray[ nItem, 43 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            RIGHTALIGN "    + xArray[ nItem, 43 ]            + CRLF, "" ), Space( Indent ) + "            RIGHTALIGN "     + xArray[ nItem, 43 ]            + CRLF )
           Output += iif( xArray[ nItem, 45 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            CENTERALIGN "   + xArray[ nItem, 45 ]            + CRLF, "" ), Space( Indent ) + "            CENTERALIGN "    + xArray[ nItem, 45 ]            + CRLF )
           Output += iif( xArray[ nItem, 37 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            HANDCURSOR "    + xArray[ nItem, 37 ]            + CRLF, "" ), Space( Indent ) + "            HANDCURSOR "     + xArray[ nItem, 37 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 39 ] )= "NIL"     , iif( lSaveAll, Space( Indent ) + "            BACKCOLOR "     + xArray[ nItem, 39 ]            + CRLF, "" ), Space( Indent ) + "            BACKCOLOR "      + xArray[ nItem, 39 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 41 ] )= "NIL"     , iif( lSaveAll, Space( Indent ) + "            FONTCOLOR "     + xArray[ nItem, 41 ]            + CRLF, "" ), Space( Indent ) + "            FONTCOLOR "      + xArray[ nItem, 41 ]            + CRLF )
           Output += Space( Indent )+"     END HYPERLINK  " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "MONTHCALENDAR"  // 19

           Output += Space( Indent ) + "     DEFINE MONTHCALENDAR " + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent ) + "            ROW    "        + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent ) + "            COL    "        + AllTrim( Str( Col ) )          + CRLF
           Output += Space( Indent ) + "            WIDTH  "        + AllTrim( Str( Width  ))        + CRLF
           Output += Space( Indent ) + "            HEIGHT "        + AllTrim( Str( Height ) )       + CRLF
           Output += iif( xArray[ nItem, 13 ]         = "CTOD('')"  , iif( lSaveAll, Space( indent ) + "            VALUE "          + xArray[ nItem, 13 ]            + CRLF, "" ), Space( indent ) + "            VALUE "          + xArray[ nItem, 13 ]            + CRLF )
           Output += iif( xArray[ nItem, 15 ]         = '"Arial"'   , iif( lSaveAll, Space( indent ) + "            FONTNAME "       + AllTrim( xArray[ nItem, 15 ] ) + CRLF, "" ), Space( indent ) + "            FONTNAME "       + AllTrim( xArray[ nItem, 15 ] ) + CRLF )
           Output += iif( xArray[ nItem, 17 ]         = "9"         , iif( lSaveAll, Space( indent ) + "            FONTSIZE "       + xArray[ nItem, 17 ]            + CRLF, "" ), Space( indent ) + "            FONTSIZE "       + xArray[ nItem, 17 ]            + CRLF )
           Output += iif( xArray[ nItem, 19 ]         = [""]        , iif( lSaveAll, Space( indent ) + "            TOOLTIP "        + AllTrim( xArray[ nItem, 19 ] ) + CRLF, "" ), Space( indent ) + "            TOOLTIP "        + AllTrim( xArray[ nItem, 19 ] ) + CRLF )
           Output += iif( Upper( xArray[ nItem, 21 ] )= "NIL"       , iif( lSaveAll, Space( indent ) + "            ONCHANGE "       + xArray[ nItem, 21 ]            + CRLF, "" ), Space( indent ) + "            ONCHANGE "       + xArray[ nItem, 21 ]            + CRLF )
           Output += iif( xArray[ nItem, 23 ]         = ".F."       , iif( lSaveAll, Space( indent ) + "            FONTBOLD "       + xArray[ nItem, 23 ]            + CRLF, "" ), Space( indent ) + "            FONTBOLD "       + xArray[ nItem, 23 ]            + CRLF )
           Output += iif( xArray[ nItem, 25 ]         = ".F."       , iif( lSaveAll, Space( indent ) + "            FONTITALIC "     + xArray[ nItem, 25 ]            + CRLF, "" ), Space( indent ) + "            FONTITALIC "     + xArray[ nItem, 25 ]            + CRLF )
           Output += iif( xArray[ nItem, 27 ]         = ".F."       , iif( lSaveAll, Space( indent ) + "            FONTUNDERLINE "  + xArray[ nItem, 27 ]            + CRLF, "" ), Space( indent ) + "            FONTUNDERLINE "  + xArray[ nItem, 27 ]            + CRLF )
           Output += iif( xArray[ nItem, 29 ]         = ".F."       , iif( lSaveAll, Space( indent ) + "            FONTSTRIKEOUT "  + xArray[ nItem, 29 ]            + CRLF, "" ), Space( indent ) + "            FONTSTRIKEOUT "  + xArray[ nItem, 29 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 31 ] )= "NIL"       , iif( lSaveAll, Space( indent ) + "            HELPID "         + xArray[ nItem, 31 ]            + CRLF, "" ), Space( indent ) + "            HELPID "         + xArray[ nItem, 31 ]            + CRLF )
           Output += iif( xArray[ nItem, 33 ]         = ".T."       , iif( lSaveAll, Space( indent ) + "            TABSTOP "        + xArray[ nItem, 33 ]            + CRLF, "" ), Space( indent ) + "            TABSTOP "        + xArray[ nItem, 33 ]            + CRLF )
           Output += iif( xArray[ nItem, 35 ]         = ".T."       , iif( lSaveAll, Space( indent ) + "            VISIBLE "        + xArray[ nItem, 35 ]            + CRLF, "" ), Space( indent ) + "            VISIBLE "        + xArray[ nItem, 35 ]            + CRLF )
           Output += iif( xArray[ nItem, 37 ]         = ".F."       , iif( lSaveAll, Space( indent ) + "            NOTODAY "        + xArray[ nItem, 37 ]            + CRLF, "" ), Space( indent ) + "            NOTODAY "        + xArray[ nItem, 37 ]            + CRLF )
           Output += iif( xArray[ nItem, 39 ]         = ".F."       , iif( lSaveAll, Space( indent ) + "            NOTODAYCIRCLE "  + xArray[ nItem, 39 ]            + CRLF, "" ), Space( indent ) + "            NOTODAYCIRCLE "  + xArray[ nItem, 39 ]            + CRLF )
           Output += iif( xArray[ nItem, 41 ]         = ".F."       , iif( lSaveAll, Space( indent ) + "            WEEKNUMBERS "    + xArray[ nItem, 41 ]            + CRLF, "" ), Space( indent ) + "            WEEKNUMBERS "    + xArray[ nItem, 41 ]            + CRLF )

           IF xArray[ nItem, 43 ] # "NIL"
              Output += Space( Indent ) + "            BACKCOLOR "          + xArray[ nItem, 43 ] + CRLF
           ENDIF

           IF xArray[ nItem, 45 ] # "NIL"
              Output += Space( Indent ) + "            FONTCOLOR "          + xArray[ nItem, 45 ] + CRLF
           ENDIF

           IF xArray[ nItem, 47 ] # "NIL"
              Output += Space( Indent ) + "            TITLEBACKCOLOR "     + xArray[ nItem, 47 ] + CRLF
           ENDIF

           IF xArray[ nItem, 49 ] # "NIL"
              Output += Space( Indent ) + "            TITLEFONTCOLOR "     + xArray[ nItem, 49 ] + CRLF
           ENDIF

           IF xArray[ nItem, 51 ] # "NIL"
              Output += Space( Indent ) + "            BKGNDCOLOR "         + xArray[ nItem, 51 ] + CRLF
           ENDIF

           IF xArray[ nItem, 53 ] # "NIL"
              Output += Space( Indent ) + "            TRAILINGFONTCOLOR "  + xArray[ nItem, 53 ] + CRLF
           ENDIF

           Output += Space( Indent )    + "     END MONTHCALENDAR  " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "RICHEDITBOX"  // 20

           Output += Space( Indent ) + "     DEFINE RICHEDITBOX "  + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent ) + "            ROW    "       + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent ) + "            COL    "       + AllTrim( Str( Col ) )          + CRLF
           Output += Space( Indent ) + "            WIDTH  "       + AllTrim( Str( Width ) )        + CRLF
           Output += Space( Indent ) + "            HEIGHT "       + AllTrim( Str( Height ) )       + CRLF
           Output += iif( xArray[ nItem, 13 ]          = '""'      , iif( lSaveAll, Space( Indent ) + "            VALUE "           + AllTrim( xArray[ nItem, 13 ] ) + CRLF, "" ), Space( Indent ) + "            VALUE "           + AllTrim( xArray[ nItem, 13 ] ) + CRLF )
           Output += iif( xArray[ nItem, 15 ]          = '"Arial"' , iif( lSaveAll, Space( Indent ) + "            FONTNAME "        + AllTrim( xArray[ nItem, 15 ] ) + CRLF, "" ), Space( Indent ) + "            FONTNAME "        + AllTrim( xArray[ nItem, 15 ] ) + CRLF )
           Output += iif( xArray[ nItem, 17 ]          = "9"       , iif( lSaveAll, Space( Indent ) + "            FONTSIZE "        + xArray[ nItem, 17 ]            + CRLF, "" ), Space( Indent ) + "            FONTSIZE "        + xArray[ nItem, 17 ]            + CRLF )
           Output += iif( xArray[ nItem, 19 ]          = [""]      , iif( lSaveAll, Space( Indent ) + "            TOOLTIP "         + AllTrim( xArray[ nItem, 19 ] ) + CRLF, "" ), Space( Indent ) + "            TOOLTIP "         + AllTrim( xArray[ nItem, 19 ] ) + CRLF )
           Output += iif( Upper( xArray[ nItem, 21 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONCHANGE "        + xArray[ nItem, 21 ]            + CRLF, "" ), Space( Indent ) + "            ONCHANGE "        + xArray[ nItem, 21 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 23 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONGOTFOCUS "      + xArray[ nItem, 23 ]            + CRLF, "" ), Space( Indent ) + "            ONGOTFOCUS "      + xArray[ nItem, 23 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 25 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONLOSTFOCUS "     + xArray[ nItem, 25 ]            + CRLF, "" ), Space( Indent ) + "            ONLOSTFOCUS "     + xArray[ nItem, 25 ]            + CRLF )
           Output += iif( xArray[ nItem, 27 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTBOLD "        + xArray[ nItem, 27 ]            + CRLF, "" ), Space( Indent ) + "            FONTBOLD "        + xArray[ nItem, 27 ]            + CRLF )
           Output += iif( xArray[ nItem, 29 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTITALIC "      + xArray[ nItem, 29 ]            + CRLF, "" ), Space( Indent ) + "            FONTITALIC "      + xArray[ nItem, 29 ]            + CRLF )
           Output += iif( xArray[ nItem, 31 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTUNDERLINE "   + xArray[ nItem, 31 ]            + CRLF, "" ), Space( Indent ) + "            FONTUNDERLINE "   + xArray[ nItem, 31 ]            + CRLF )
           Output += iif( xArray[ nItem, 33 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTSTRIKEOUT "   + xArray[ nItem, 33 ]            + CRLF, "" ), Space( Indent ) + "            FONTSTRIKEOUT "   + xArray[ nItem, 33 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 35 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            HELPID "          + xArray[ nItem, 35 ]            + CRLF, "" ), Space( Indent ) + "            HELPID "          + xArray[ nItem, 35 ]            + CRLF )
           Output += iif( xArray[ nItem, 37 ]          = ".T."     , iif( lSaveAll, Space( Indent ) + "            TABSTOP "         + xArray[ nItem, 37 ]            + CRLF, "" ), Space( Indent ) + "            TABSTOP "         + xArray[ nItem, 37 ]            + CRLF )
           Output += iif( xArray[ nItem, 39 ]          = ".T."     , iif( lSaveAll, Space( Indent ) + "            VISIBLE "         + xArray[ nItem, 39 ]            + CRLF, "" ), Space( Indent ) + "            VISIBLE "         + xArray[ nItem, 39 ]            + CRLF )
           Output += iif( xArray[ nItem, 41 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            READONLY "        + xArray[ nItem, 41 ]            + CRLF, "" ), Space( Indent ) + "            READONLY "        + xArray[ nItem, 41 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 43 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            BACKCOLOR "       + xArray[ nItem, 43 ]            + CRLF, "" ), Space( Indent ) + "            BACKCOLOR "       + xArray[ nItem, 43 ]            + CRLF )

           IF Upper( xArray[ nItem, 59 ] ) # "NIL"
              Output += Space( Indent ) + "            FONTCOLOR "   + xArray[ nItem, 59 ]  + CRLF
           ENDIF

           IF ! Empty( xArray[ nItem, 45 ] ) .AND.  Upper( xArray[ nItem, 45 ] ) # "NIL"
              Output += Space( Indent ) + "            FIELD  "      + xArray[ nItem, 45 ]  + CRLF
           ELSEIF ! Empty( xArray[ nItem, 49 ] ) .AND.  Upper( xArray[ nItem, 49 ] ) # "NIL"
              Output += Space( Indent ) + "            FILE "        + AllTrim( xArray[ nItem, 49 ] ) + CRLF
           ENDIF

           IF xArray[ nItem, 47 ] # "0"
              Output += Space( Indent ) + "            MAXLENGTH  "  + xArray[ nItem, 47 ]  + CRLF
           ENDIF

           IF Upper( xArray[ nItem, 51 ] ) # "NIL"
              Output += Space( Indent ) + "            ONSELECT  "   + xArray[ nItem, 51 ]  + CRLF
           ENDIF

           IF Upper( xArray[ nItem, 53 ] ) # ".F."
              Output += Space( Indent ) + "            PLAINTEXT  "  + xArray[ nItem, 53 ]  + CRLF
           ENDIF

           IF Upper( xArray[ nItem, 55 ] ) # ".T." .OR. lSaveAll
              Output += Space( Indent ) + "            HSCROLLBAR  " + xArray[ nItem, 55 ]  + CRLF
           ENDIF

           IF Upper( xArray[ nItem, 57 ] ) # ".T." .OR. lSaveAll
              Output += Space( Indent ) + "            VSCROLLBAR  " + xArray[ nItem, 57 ]  + CRLF
           ENDIF

           IF Upper( xArray[ nItem, 61 ] ) # ".F."
              Output += Space( Indent ) + " BREAK  "                 + xArray[ nItem, 61 ]  + CRLF
           ENDIF

           IF Upper( xArray[ nItem, 63 ] ) # "NIL"
              Output += Space( Indent ) + "            ONVSCROLL "   + xArray[ nItem, 63 ]  + CRLF
           ENDIF

           Output += Space( Indent )    + "     END RICHEDITBOX  " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "IPADDRESS"   // 23

           Output += Space( Indent ) + "     DEFINE IPADDRESS "     + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent ) + "            ROW    "        + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent ) + "            COL    "        + AllTrim( Str( Col ) )          + CRLF
           Output += Space( Indent ) + "            WIDTH  "        + AllTrim( Str( Width ) )        + CRLF
           Output += Space( Indent ) + "            HEIGHT "        + AllTrim( Str( Height ) )       + CRLF
           Output += iif( xArray[ nItem, 13 ]         = "{0,0,0,0}" , iif( lSaveAll, Space( Indent ) + "            VALUE "          + xArray[ nItem, 13 ]            + CRLF, "" ), Space( Indent ) + "            VALUE "          + xArray[ nItem, 13 ]            + CRLF )
           Output += iif( xArray[ nItem, 15 ]         = '"Arial"'   , iif( lSaveAll, Space( Indent ) + "            FONTNAME "       + AllTrim( xArray[ nItem, 15 ] ) + CRLF, "" ), Space( Indent ) + "            FONTNAME "       + AllTrim( xArray[ nItem, 15 ] ) + CRLF )
           Output += iif( xArray[ nItem, 17 ]         = "9"         , iif( lSaveAll, Space( Indent ) + "            FONTSIZE "       + xArray[ nItem, 17 ]            + CRLF, "" ), Space( Indent ) + "            FONTSIZE "       + xArray[ nItem, 17 ]            + CRLF )
           Output += iif( xArray[ nItem, 19 ]         = [""]        , iif( lSaveAll, Space( Indent ) + "            TOOLTIP "        + AllTrim( xArray[ nItem, 19 ] ) + CRLF, "" ), Space( Indent ) + "            TOOLTIP "        + AllTrim( xArray[ nItem, 19 ] ) + CRLF )
           Output += iif( Upper( xArray[ nItem, 21 ] )= "NIL"       , iif( lSaveAll, Space( Indent ) + "            ONCHANGE "       + xArray[ nItem, 21 ]            + CRLF, "" ), Space( Indent ) + "            ONCHANGE "       + xArray[ nItem, 21 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 23 ] )= "NIL"       , iif( lSaveAll, Space( Indent ) + "            ONGOTFOCUS "     + xArray[ nItem, 23 ]            + CRLF, "" ), Space( Indent ) + "            ONGOTFOCUS "     + xArray[ nItem, 23 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 25 ] )= "NIL"       , iif( lSaveAll, Space( Indent ) + "            ONLOSTFOCUS "    + xArray[ nItem, 25 ]            + CRLF, "" ), Space( Indent ) + "            ONLOSTFOCUS "    + xArray[ nItem, 25 ]            + CRLF )
           Output += iif( xArray[ nItem, 27 ]         = ".F."       , iif( lSaveAll, Space( Indent ) + "            FONTBOLD "       + xArray[ nItem, 27 ]            + CRLF, "" ), Space( Indent ) + "            FONTBOLD "       + xArray[ nItem, 27 ]            + CRLF )
           Output += iif( xArray[ nItem, 29 ]         = ".F."       , iif( lSaveAll, Space( Indent ) + "            FONTITALIC "     + xArray[ nItem, 29 ]            + CRLF, "" ), Space( Indent ) + "            FONTITALIC "     + xArray[ nItem, 29 ]            + CRLF )
           Output += iif( xArray[ nItem, 31 ]         = ".F."       , iif( lSaveAll, Space( Indent ) + "            FONTUNDERLINE "  + xArray[ nItem, 31 ]            + CRLF, "" ), Space( Indent ) + "            FONTUNDERLINE "  + xArray[ nItem, 31 ]            + CRLF )
           Output += iif( xArray[ nItem, 33 ]         = ".F."       , iif( lSaveAll, Space( Indent ) + "            FONTSTRIKEOUT "  + xArray[ nItem, 33 ]            + CRLF, "" ), Space( Indent ) + "            FONTSTRIKEOUT "  + xArray[ nItem, 33 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 35 ] )= "NIL"       , iif( lSaveAll, Space( Indent ) + "            HELPID "         + xArray[ nItem, 35 ]            + CRLF, "" ), Space( Indent ) + "            HELPID "         + xArray[ nItem, 35 ]            + CRLF )
           Output += iif( xArray[ nItem, 37 ]         = ".T."       , iif( lSaveAll, Space( Indent ) + "            TABSTOP "        + xArray[ nItem, 37 ]            + CRLF, "" ), Space( Indent ) + "            TABSTOP "        + xArray[ nItem, 37 ]            + CRLF )
           Output += iif( xArray[ nItem, 39 ]         = ".T."       , iif( lSaveAll, Space( Indent ) + "            VISIBLE "        + xArray[ nItem, 39 ]            + CRLF, "" ), Space( Indent ) + "            VISIBLE "        + xArray[ nItem, 39 ]            + CRLF )
           Output += Space( Indent ) + "     END IPADDRESS "  + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "TIMER"        //?

           Output += Space( Indent ) + "     DEFINE TIMER " + AllTrim( xArray[ nItem, 3 ] )
           Output += Space( Indent ) + " INTERVAL "         + xArray[ nItem, 5 ]
           Output += Space( Indent ) + " ACTION "           + xArray[ nItem, 7 ] + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "BUTTONEX"     // 24

           Output += Space( Indent ) + "     DEFINE BUTTONEX "    + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent ) + "            ROW    "      + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent ) + "            COL    "      + AllTrim( Str( Col ) )          + CRLF
           Output += Space( Indent ) + "            WIDTH  "      + AllTrim( Str( Width ) )        + CRLF
           Output += Space( Indent ) + "            HEIGHT "      + AllTrim( Str( Height ) )       + CRLF
           IF ! Empty( xArray[ nItem, 13 ] )     .AND. xArray[ nItem, 13 ] # [""]
              Output += Space( Indent ) + "            CAPTION "     + AllTrim( xArray[ nItem, 13 ] ) + CRLF
           ENDIF

           IF ! Empty( xArray[ nItem, 15 ] )     .AND. ! Upper( xArray[ nItem, 15 ] ) == "NIL"
              IF xArray[ nItem, 15 ] # [""]
              Output += Space( Indent ) + "            PICTURE "  + AllTrim( xArray[ nItem, 15 ] ) + CRLF
              Output += Space( Indent ) + "            ICON NIL"                                   + CRLF
              ENDIF

           ELSEIF ! Empty( xArray[ nItem, 17 ] ) .AND. ! Upper( xArray[ nItem, 17 ] ) == "NIL"
              Output += Space( Indent ) + "            PICTURE NIL"                                + CRLF
              Output += Space( Indent ) + "            ICON "     + AllTrim( xArray[ nItem, 17 ] ) + CRLF
           ENDIF

           Output += iif( Upper( xArray[ nItem, 19 ] )= "NIL"     , iif( lSaveAll, Space( Indent ) + "            ACTION "          + xArray[ nItem, 19 ]            + CRLF, "" ), Space( Indent ) + "            ACTION "          + xArray[ nItem, 19 ]            + CRLF )
           Output += iif( xArray[ nItem, 21 ]         = '"Arial"' , iif( lSaveAll, Space( Indent ) + "            FONTNAME "        + AllTrim( xArray[ nItem, 21 ] ) + CRLF, "" ), Space( Indent ) + "            FONTNAME "        + AllTrim( xArray[ nItem, 21 ] ) + CRLF )
           Output += iif( xArray[ nItem, 23 ]         = "9"       , iif( lSaveAll, Space( Indent ) + "            FONTSIZE "        + xArray[ nItem, 23 ]            + CRLF, "" ), Space( Indent ) + "            FONTSIZE "        + xArray[ nItem, 23 ]            + CRLF )
           Output += iif( xArray[ nItem, 25 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTBOLD "        + xArray[ nItem, 25 ]            + CRLF, "" ), Space( Indent ) + "            FONTBOLD "        + xArray[ nItem, 25 ]            + CRLF )
           Output += iif( xArray[ nItem, 27 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTITALIC "      + xArray[ nItem, 27 ]            + CRLF, "" ), Space( Indent ) + "            FONTITALIC "      + xArray[ nItem, 27 ]            + CRLF )
           Output += iif( xArray[ nItem, 29 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTUNDERLINE "   + xArray[ nItem, 29 ]            + CRLF, "" ), Space( Indent ) + "            FONTUNDERLINE "   + xArray[ nItem, 29 ]            + CRLF )
           Output += iif( xArray[ nItem, 31 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTSTRIKEOUT "   + xArray[ nItem, 31 ]            + CRLF, "" ), Space( Indent ) + "            FONTSTRIKEOUT "   + xArray[ nItem, 31 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 33 ] )= "NIL"     , iif( lSaveAll, Space( Indent ) + "            FONTCOLOR "       + xArray[ nItem, 33 ]            + CRLF, "" ), Space( Indent ) + "            FONTCOLOR "       + xArray[ nItem, 33 ]            + CRLF )
           Output += iif( xArray[ nItem, 35 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            VERTICAL "        + xArray[ nItem, 35 ]            + CRLF, "" ), Space( Indent ) + "            VERTICAL "        + xArray[ nItem, 35 ]            + CRLF )
           Output += iif( xArray[ nItem, 37 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            LEFTTEXT "        + xArray[ nItem, 37 ]            + CRLF, "" ), Space( Indent ) + "            LEFTTEXT "        + xArray[ nItem, 37 ]            + CRLF )
           Output += iif( xArray[ nItem, 39 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            UPPERTEXT "       + xArray[ nItem, 39 ]            + CRLF, "" ), Space( Indent ) + "            UPPERTEXT "       + xArray[ nItem, 39 ]            + CRLF )
           Output += iif( xArray[ nItem, 41 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            ADJUST "          + xArray[ nItem, 41 ]            + CRLF, "" ), Space( Indent ) + "            ADJUST "          + xArray[ nItem, 41 ]            + CRLF )
           Output += iif( xArray[ nItem, 43 ]         = [""]      , iif( lSaveAll, Space( Indent ) + "            TOOLTIP "         + xArray[ nItem, 43 ]            + CRLF, "" ), Space( Indent ) + "            TOOLTIP "         + xArray[ nItem, 43 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 45 ] )= "NIL"     , iif( lSaveAll, Space( Indent ) + "            BACKCOLOR "       + xArray[ nItem, 45 ]            + CRLF, "" ), Space( Indent ) + "            BACKCOLOR "       + xArray[ nItem, 45 ]            + CRLF )
           Output += iif( xArray[ nItem, 47 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            NOHOTLIGHT "      + xArray[ nItem, 47 ]            + CRLF, "" ), Space( Indent ) + "            NOHOTLIGHT "      + xArray[ nItem, 47 ]            + CRLF )
           Output += iif( xArray[ nItem, 49 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            FLAT "            + xArray[ nItem, 49 ]            + CRLF, "" ), Space( Indent ) + "            FLAT "            + xArray[ nItem, 49 ]            + CRLF )
           Output += iif( xArray[ nItem, 51 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            NOTRANSPARENT "   + xArray[ nItem, 51 ]            + CRLF, "" ), Space( Indent ) + "            NOTRANSPARENT "   + xArray[ nItem, 51 ]            + CRLF )
           Output += iif( xArray[ nItem, 53 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            NOXPSTYLE "       + xArray[ nItem, 53 ]            + CRLF, "" ), Space( Indent ) + "            NOXPSTYLE "       + xArray[ nItem, 53 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 55 ] )= "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONGOTFOCUS "      + xArray[ nItem, 55 ]            + CRLF, "" ), Space( Indent ) + "            ONGOTFOCUS "      + xArray[ nItem, 55 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 57 ] )= "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONLOSTFOCUS "     + xArray[ nItem, 57 ]            + CRLF, "" ), Space( Indent ) + "            ONLOSTFOCUS "     + xArray[ nItem, 57 ]            + CRLF )
           Output += iif( xArray[ nItem, 59 ]         = ".T."     , iif( lSaveAll, Space( Indent ) + "            TABSTOP "         + xArray[ nItem, 59 ]            + CRLF, "" ), Space( Indent ) + "            TABSTOP "         + xArray[ nItem, 59 ]            + CRLF )
           Output += iif( xArray[ nItem, 67 ]         = ".T."     , iif( lSaveAll, Space( Indent ) + "            HANDCURSOR "      + xArray[ nItem, 67 ]            + CRLF, "" ), Space( Indent ) + "            HANDCURSOR "      + xArray[ nItem, 67 ]            + CRLF )

           Output += iif( Upper( xArray[ nItem, 61 ] )= "NIL"     , iif( lSaveAll, Space( Indent ) + "            HELPID "          + xArray[ nItem, 61 ]            + CRLF, "" ), Space( Indent ) + "            HELPID "          + xArray[ nItem, 61 ]            + CRLF )
           Output += iif( xArray[ nItem, 63 ]         = ".T."     , iif( lSaveAll, Space( Indent ) + "            VISIBLE "         + xArray[ nItem, 63 ]            + CRLF, "" ), Space( Indent ) + "            VISIBLE "         + xArray[ nItem, 63 ]            + CRLF )
           Output += iif( xArray[ nItem, 65 ]         = ".F."     , iif( lSaveAll, Space( Indent ) + "            DEFAULT "         + xArray[ nItem, 65 ]            + CRLF, "" ), Space( Indent ) + "            DEFAULT "         + xArray[ nItem, 65 ]            + CRLF )
           Output += Space( Indent ) + "     END BUTTONEX  " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "COMBOBOXEX"  // 25

           Output += Space( Indent )+"     DEFINE COMBOBOXEX "  + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent )+"            ROW    "      + AllTrim( xArray[ nItem, 5 ] )  + CRLF
           Output += Space( Indent )+"            COL    "      + AllTrim( xArray[ nItem, 7 ] )  + CRLF
           Output += Space( Indent )+"            WIDTH  "      + AllTrim( Str( Width ) )        + CRLF
           Output += Space( Indent )+"            HEIGHT "      + AllTrim( xArray[ nItem, 11 ] ) + CRLF
           Output += iif( Empty( xArray[ nItem, 13 ] ), "", Space( Indent ) + "            ITEMS " + AllTrim( xArray[ nItem, 13 ] ) + CRLF )

           IF Empty( xArray[ nItem, 13 ] ) .AND. !Empty( xArray[ nItem, 15 ] )
              Output += Space( Indent ) + "            ITEMSOURCE "      + xArray[ nItem, 15 ] + CRLF
           ENDIF

           Output += iif( xArray[ nItem, 17 ] = "0", iif( lSaveAll, Space( Indent ) + "            VALUE " + AllTrim( xArray[ nItem, 17 ] ) + CRLF, "" ), Space( Indent ) + "            VALUE " + AllTrim( xArray[ nItem, 17 ] ) + CRLF )

           IF !Empty( xArray[ nItem, 19 ] )
              Output += Space( Indent ) + "            VALUESOURCE "     + xArray[ nItem, 19 ] + CRLF
           ENDIF

           IF xArray[ nItem, 21 ] # ".F."
              Output += Space( Indent ) + "            DISPLAYEDIT "     + xArray[ nItem, 21 ] + CRLF
           ENDIF

           IF xArray[ nItem, 23 ] # "0"
              Output += Space( Indent ) + "            LISTWIDTH "       + xArray[ nItem, 23 ] + CRLF
           ENDIF

           IF xArray[ nItem, 25 ] # "Arial"
              Output += Space( Indent ) + "            FONTNAME "        + xArray[ nItem, 25 ] + CRLF
           ENDIF

           IF xArray[ nItem, 27 ] # "9"
              Output += Space( Indent ) + "            FONTSIZE "        + xArray[ nItem, 27 ] + CRLF
           ENDIF

           IF xArray[ nItem, 29 ] # ".F."
              Output += Space( Indent ) + "            FONTBOLD "        + xArray[ nItem, 29 ] + CRLF
           ENDIF

           IF xArray[ nItem, 31 ] # ".F."
              Output += Space( Indent ) + "            FONTITALIC "      + xArray[ nItem, 31 ] + CRLF
           ENDIF

           IF xArray[ nItem, 33 ] # ".F."
              Output += Space( Indent ) + "            FONTUNDERLINE "   + xArray[ nItem, 33 ] + CRLF
           ENDIF

           IF xArray[ nItem, 35 ] # ".F."
              Output += Space( Indent ) + "            FONTSTRIKEOUT "   + xArray[ nItem, 35 ] + CRLF
           ENDIF

           IF xArray[ nItem, 37 ] # [""]
              Output += Space( Indent ) + "            TOOLTIP "         + xArray[ nItem, 37 ] + CRLF
           ENDIF

           IF xArray[ nItem, 65 ] # "NIL"
              Output += Space( Indent ) + "            BACKCOLOR "       + xArray[ nItem, 65 ] + CRLF
           ENDIF

           IF xArray[ nItem, 67 ] # "NIL"
              Output += Space( Indent )  +"            FONTCOLOR "       + xArray[ nItem, 67 ] + CRLF
           ENDIF

           IF xArray[ nItem, 39 ] # "NIL"
              Output += Space( Indent ) + "            ONGOTFOCUS "      + xArray[ nItem, 39 ] + CRLF
           ENDIF

           IF xArray[ nItem, 41 ] # "NIL"
              Output += Space( Indent ) + "            ONCHANGE "        + xArray[ nItem, 41 ] + CRLF
           ENDIF

           IF xArray[ nItem, 43 ] # "NIL"
              Output += Space( Indent ) + "            ONLOSTFOCUS "     + xArray[ nItem, 43 ] + CRLF
           ENDIF

           IF xArray[ nItem, 45 ] # "NIL"
              Output += Space( Indent ) + "            ONENTER "         + xArray[ nItem, 45 ] + CRLF
           ENDIF

           IF xArray[ nItem, 47 ] # "NIL"
              Output += Space( Indent ) + "            ONDISPLAYCHANGE " + xArray[ nItem, 47 ] + CRLF
           ENDIF

           IF xArray[ nItem, 49 ] # "NIL"
              Output += Space( Indent ) + "            ONLISTDISPLAY "   + xArray[ nItem, 49 ] + CRLF
           ENDIF

           IF xArray[ nItem, 51 ] # "NIL"
              Output += Space( Indent ) + "            ONLISTCLOSE "     + xArray[ nItem, 51 ] + CRLF
           ENDIF

           IF xArray[ nItem, 53 ] # ".T."
              Output += Space( Indent ) + "            TABSTOP "         + xArray[ nItem, 53 ] + CRLF
           ENDIF

           IF xArray[ nItem, 55 ] # "NIL"
              Output += Space( Indent ) + "            HELPID "          + xArray[ nItem, 55 ] + CRLF
           ENDIF

           IF xArray[ nItem, 57 ] # '""'
              Output += Space( Indent ) + "            GRIPPERTEXT "     + xArray[ nItem, 57 ] + CRLF
           ENDIF

           IF xArray[ nItem, 59 ] # ".F."
              Output += Space( Indent ) + "            BREAK "           + xArray[ nItem, 59 ] + CRLF
           ENDIF

           IF xArray[ nItem, 61 ] # ".T."
              Output += Space( Indent ) + "            VISIBLE "         + xArray[ nItem, 61 ] + CRLF
           ENDIF

           Output += iif( Empty( xArray[ nItem, 63 ] ), "", Space( Indent ) + "            IMAGE " + xArray[ nItem, 63 ] + CRLF )

           IF Empty( xArray[ nItem, 63 ] ) .AND. ! Empty( xArray[ nItem, 69 ] )
              Output += Space( Indent ) + "            IMAGELIST "       + xArray[ nItem, 69 ] + CRLF
           ENDIF

           Output += Space( Indent ) + "     END COMBOBOXEX  " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "GETBOX"     // 28

           Output += Space( Indent ) + "     DEFINE GETBOX "  + AllTrim( xArray[ nItem, 3 ] ) + CRLF
           Output += Space( Indent ) + "            ROW    "  + AllTrim( Str( Row ) )         + CRLF
           Output += Space( Indent ) + "            COL    "  + AllTrim( Str( Col ) )         + CRLF
           Output += Space( Indent ) + "            WIDTH  "  + AllTrim( Str( Width ) )       + CRLF
           Output += Space( Indent ) + "            HEIGHT "  + AllTrim( Str( Height ) )      + CRLF

           IF xArray[ nItem, 13 ] # "NIL" .AND.  Len(AllTrim( xArray[ nItem, 13 ] )) > 0
              Output += Space( Indent ) + "            FIELD " + AllTrim( xArray[ nItem, 13 ] ) + CRLF
           ENDIF

           IF xArray[ nItem, 15 ] # "NIL"
              Output += Space( Indent ) + "            VALUE "         + xArray[ nItem, 15 ] + CRLF
           ELSEIF  Len( AllTrim( xArray[ nItem, 13 ] ) ) = 0
              Output += Space( Indent ) + "            VALUE 0"                              + CRLF
           ENDIF

           IF xArray[ nItem, 65 ] # "NIL"
              Output += Space( Indent ) + "            ACTION "        + xArray[ nItem, 65 ] + CRLF
           ENDIF

           IF xArray[ nItem, 67 ] # "NIL"
              Output += Space( Indent ) + "            ACTION2 "       + xArray[ nItem, 67 ] + CRLF
           ENDIF

           IF xArray[ nItem, 69 ] # '""'
              Output += Space( Indent ) + "            IMAGE "         + xArray[ nItem, 69 ] + CRLF
           ENDIF

           IF xArray[ nItem, 71 ] # "0"
              Output += Space( Indent ) + "            BUTTONWIDTH "   + xArray[ nItem, 71 ] + CRLF
           ENDIF

           IF xArray[ nItem, 17 ] # '""'
              Output += Space( Indent ) + "            PICTURE "       + AllTrim( xArray[ nItem, 17 ] ) + CRLF
           ENDIF

           IF xArray[ nItem, 19 ] # "NIL"
              Output += Space( Indent ) + "            VALID "         + xArray[ nItem, 19 ] + CRLF
           ENDIF

           IF xArray[ nItem, 21 ] # "NIL"
              Output += Space( Indent ) + "            RANGE "         + xArray[ nItem, 21 ] + CRLF
           ENDIF

           IF xArray[ nItem, 23 ] # '""'
              Output += Space( Indent ) + "            VALIDMESSAGE "  + xArray[ nItem, 23 ] + CRLF
           ENDIF

           IF xArray[ nItem, 25 ] # '""'
              Output += Space( Indent ) + "            MESSAGE "       + xArray[ nItem, 25 ] + CRLF
           ENDIF

           IF xArray[ nItem, 27 ] # "NIL"
              Output += Space( Indent ) + "            WHEN "          + xArray[ nItem, 27 ] + CRLF
           ENDIF

           IF xArray[ nItem, 29 ] # ".F."
              Output += Space( Indent ) + "            READONLY "      + xArray[ nItem, 29 ] + CRLF
           ENDIF

           Output += iif( xArray[ nItem, 31 ]          = '"Arial"' , iif( lSaveAll, Space( Indent ) + "            FONTNAME "      + xArray[ nItem, 31 ] + CRLF, "" ), Space( Indent ) + "            FONTNAME "       + AllTrim( xArray[ nItem, 31 ] ) + CRLF )
           Output += iif( xArray[ nItem, 33 ]          = "9"       , iif( lSaveAll, Space( Indent ) + "            FONTSIZE "      + xArray[ nItem, 33 ] + CRLF, "" ), Space( Indent ) + "            FONTSIZE "       + xArray[ nItem, 33 ]            + CRLF )
           Output += iif( xArray[ nItem, 35 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTBOLD "      + xArray[ nItem, 35 ] + CRLF, "" ), Space( Indent ) + "            FONTBOLD "       + xArray[ nItem, 35 ]            + CRLF )
           Output += iif( xArray[ nItem, 37 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTITALIC "    + xArray[ nItem, 37 ] + CRLF, "" ), Space( Indent ) + "            FONTITALIC "     + xArray[ nItem, 37 ]            + CRLF )
           Output += iif( xArray[ nItem, 39 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTUNDERLINE " + xArray[ nItem, 39 ] + CRLF, "" ), Space( Indent ) + "            FONTUNDERLINE "  + xArray[ nItem, 39 ]            + CRLF )
           Output += iif( xArray[ nItem, 41 ]          = ".F."     , iif( lSaveAll, Space( Indent ) + "            FONTSTRIKEOUT " + xArray[ nItem, 41 ] + CRLF, "" ), Space( Indent ) + "            FONTSTRIKEOUT "  + xArray[ nItem, 41 ]            + CRLF )

           IF xArray[ nItem, 43 ]# ".F."
              Output += Space( Indent ) + "            PASSWORD "  + xArray[ nItem, 43 ] + CRLF
           ENDIF

           Output += iif( xArray[ nItem, 45 ]          = '""'      , iif( lSaveAll, Space( Indent ) + "            TOOLTIP "       + xArray[ nItem, 45 ] + CRLF, "" ), Space( Indent ) + "            TOOLTIP "        + xArray[ nItem, 45 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 47 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            BACKCOLOR "     + xArray[ nItem, 47 ] + CRLF, "" ), Space( Indent ) + "            BACKCOLOR "      + xArray[ nItem, 47 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 49 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            FONTCOLOR "     + xArray[ nItem, 49 ] + CRLF, "" ), Space( Indent ) + "            FONTCOLOR "      + xArray[ nItem, 49 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 51 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONCHANGE "      + xArray[ nItem, 51 ] + CRLF, "" ), Space( Indent ) + "            ONCHANGE "       + xArray[ nItem, 51 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 53 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONGOTFOCUS "    + xArray[ nItem, 53 ] + CRLF, "" ), Space( Indent ) + "            ONGOTFOCUS "     + xArray[ nItem, 53 ]            + CRLF )
           Output += iif( Upper( xArray[ nItem, 55 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            ONLOSTFOCUS "   + xArray[ nItem, 55 ] + CRLF, "" ), Space( Indent ) + "            ONLOSTFOCUS "    + xArray[ nItem, 55 ]            + CRLF )

           IF xArray[ nItem, 57 ] # ".F."
              Output += Space( Indent ) + "            RIGHTALIGN " + xArray[ nItem, 57 ] + CRLF
           ENDIF

           IF xArray[ nItem, 59 ] # ".T."
              Output += Space( Indent ) + "            VISIBLE "    + xArray[ nItem, 59 ] + CRLF
           ENDIF

           IF xArray[ nItem, 61 ] # ".T."
              Output += Space( Indent ) + "            TABSTOP "    + xArray[ nItem, 61 ] + CRLF
           ENDIF

           Output += IiF( Upper( xArray[ nItem, 73 ] ) = ".T."     , iif( lSaveAll, Space( Indent ) + "            BORDER "        + xArray[ nItem, 73 ] + CRLF, "" ), Space( Indent ) + "            BORDER "         + xArray[ nItem, 73 ]            + CRLF )
           Output += IiF( Upper( xArray[ nItem, 75 ] ) = ".F."     , iif( lSaveAll, Space( Indent ) + "            NOMINUS "       + xArray[ nItem, 75 ] + CRLF, "" ), Space( Indent ) + "            NOMINUS "        + xArray[ nItem, 75 ]            + CRLF )


           Output += IiF( Upper( xArray[ nItem, 63 ] ) = "NIL"     , iif( lSaveAll, Space( Indent ) + "            HELPID "        + xArray[ nItem, 63 ] + CRLF, "" ), Space( Indent ) + "            HELPID "         + xArray[ nItem, 63 ]            + CRLF )



           Output += Space( Indent ) + "     END GETBOX  " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "TIMEPICKER"     // 26

           Output += Space( Indent )    + "     DEFINE TIMEPICKER "     + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent )    + "            ROW    "         + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent )    + "            COL    "         + AllTrim( Str( Col ) )          + CRLF
           Output += Space( Indent )    + "            WIDTH  "         + AllTrim( Str( Width ) )        + CRLF

           IF Len( AllTrim( xArray[ nItem, 11 ] ) ) > 0
              Output += Space( Indent ) + "            VALUE "          + xArray[ nItem, 11 ]            + CRLF
           ENDIF

           IF xArray[ nItem, 13 ] # "NIL" .AND.  Len( AllTrim( xArray[ nItem, 13 ] ) ) > 0
              Output += Space( Indent ) + "            FIELD "          + AllTrim( xArray[ nItem, 13 ] ) + CRLF
           ENDIF

           Output += Space( Indent )    + "            FONTNAME "       + xArray[ nItem, 15 ] + CRLF
           Output += Space( Indent )    + "            FONTSIZE "       + xArray[ nItem, 17 ] + CRLF
           Output += Space( Indent )    + "            FONTBOLD "       + xArray[ nItem, 19 ] + CRLF
           Output += Space( Indent )    + "            FONTITALIC "     + xArray[ nItem, 21 ] + CRLF
           Output += Space( Indent )    + "            FONTUNDERLINE "  + xArray[ nItem, 23 ] + CRLF
           Output += Space( Indent )    + "            FONTSTRIKEOUT "  + xArray[ nItem, 25 ] + CRLF
           Output += Space( Indent )    + "            TOOLTIP "        + xArray[ nItem, 27 ] + CRLF

           IF xArray[ nItem, 29 ] # ".F."
              Output += Space( Indent ) + "            SHOWNONE "       + xArray[ nItem, 29 ] + CRLF
           ENDIF

           IF xArray[ nItem, 31 ] # ".F."
              Output += Space( Indent ) + "            UPDOWN "         + xArray[ nItem, 31 ] + CRLF
           ENDIF

           Output += Space( Indent )    + "            TIMEFORMAT "     + xArray[ nItem, 33 ] + CRLF
           Output += Space( Indent )    + "            ONGOTFOCUS "     + xArray[ nItem, 35 ] + CRLF
           Output += Space( Indent )    + "            ONCHANGE "       + xArray[ nItem, 37 ] + CRLF
           Output += Space( Indent )    + "            ONLOSTFOCUS "    + xArray[ nItem, 39 ] + CRLF
           Output += Space( Indent )    + "            ONENTER "        + xArray[ nItem, 41 ] + CRLF
           Output += Space( Indent )    + "            HELPID "         + xArray[ nItem, 43 ] + CRLF

           IF xArray[ nItem, 45 ] # ".T."
              Output += Space( Indent ) + "            VISIBLE "        + xArray[ nItem, 45 ] + CRLF
           ENDIF

           IF xArray[ nItem, 47 ] # ".T."
              Output += Space( Indent ) + "            TABSTOP "        + xArray[ nItem, 47 ] + CRLF
           ENDIF

           Output += Space( Indent ) + "     END TIMEPICKER  " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "QHTM"      // ?

           Output += Space( Indent ) + "     DEFINE QHTM "      + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent ) + "            ROW    "    + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent ) + "            COL    "    + AllTrim( Str( Col ) )          + CRLF

           IF Len( AllTrim( xArray[ nItem, 23 ] )) = 0
              Output += Space( Indent ) + "            WIDTH  " + AllTrim( Str( Width ) )        + CRLF
           ELSE
              Output += Space( Indent ) + "            WIDTH  " + AllTrim( xArray[ nItem, 23 ] ) + CRLF
           ENDIF

           IF Len( AllTrim( xArray[ nItem, 25 ] )) = 0
              Output += Space( Indent ) + "            HEIGHT " + AllTrim( Str( Width ) )        + CRLF
           ELSE
              Output += Space( Indent ) + "            HEIGHT " + AllTrim( xArray[ nItem, 25 ] ) + CRLF
           ENDIF

           IF Len( AllTrim( xArray[ nItem, 13 ] )) > 0
              Output += Space( Indent ) + "            VALUE  " + AllTrim( xArray[ nItem, 13 ] ) + CRLF
           ENDIF

           Output += Space( Indent ) + "            FILE   "    + xArray[ nItem, 15 ]            + CRLF
           Output += Space( Indent ) + "            RESOURCE  " + AllTrim( xArray[ nItem, 17 ] ) + CRLF
           Output += Space( Indent ) + "            ONCHANGE  " + xArray[ nItem, 19 ]            + CRLF

           IF xArray[ nItem, 21 ] # ".F."
              Output += Space( Indent ) + "            BORDER " + xArray[ nItem, 21 ]            + CRLF
           ENDIF

           Output += Space( Indent ) + "     END QHTM " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "TBROWSE"    // 40
           aComma := fillcomma(nItem)

           Output += Space( Indent ) + "     DEFINE TBROWSE "   + AllTrim( xArray[ nItem, 3 ] ) + aComma[ 3 ]                 + CRLF
           Output += Space( Indent ) + "            AT    "     + AllTrim( Str( Row )         ) + "," + AllTrim( Str( Col ) ) + " ; " + CRLF
           Output += Space( Indent ) + "            WIDTH  "    + AllTrim( Str( Width ) )       + " ; "                       + CRLF
           Output += Space( Indent ) + "            HEIGHT "    + AllTrim( Str( Height ) )      + " ; "                       + CRLF
           Output += Space( Indent ) + "            HEADERS "   + xArray[ nItem, 13 ]           + aComma[13 ]                 + CRLF
           Output += Space( Indent ) + "            COLSIZES "  + xArray[ nItem, 15 ]           + aComma[15 ]                 + CRLF
           Output += Space( Indent ) + "            WORKAREA "  + xArray[ nItem, 17 ]           + aComma[17 ]                 + CRLF
           Output += Space( Indent ) + "            FIELDS "    + xArray[ nItem, 19 ]           + aComma[19 ]                 + CRLF

           IF  ! Empty( xArray[ nItem, 21 ] )  .AND. ! Empty( xArray[ nItem, 23 ] )
               Output += Space( Indent ) + "            SELECTFILTER " + xArray[ nItem, 21 ] + " FOR " + xArray[ nItem, 23 ] + aComma[ 23 ]
               IF ! Empty( xArray[ nItem, 25 ] )
                  Output += " TO " + xArray[ nItem, 25 ] + aComma[ 25 ] + CRLF
               ELSE
                  Output += CRLF
               ENDIF
            ENDIF

           IF xArray[ nItem, 27 ] # "0"
              Output += Space( Indent ) + "            VALUE "           + xArray[ nItem, 27 ] + aComma[27 ] + CRLF
           ENDIF

           IF xArray[ nItem, 29 ] # "Arial"
              Output += Space( Indent ) + "            FONT "            + AllTrim( xArray[ nItem, 29 ] ) + aComma[29 ] + CRLF
           ENDIF

           IF xArray[ nItem, 31 ] # "9"
              Output += Space( Indent ) + "            SIZE "            + xArray[ nItem, 31 ] + aComma[31 ] + CRLF
           ENDIF

           IF xArray[ nItem, 33 ] = ".T."
              Output += Space( Indent ) + "            BOLD "            + aComma[33 ] + CRLF
           ENDIF

           IF xArray[ nItem, 35 ] = ".T."
              Output += Space( Indent ) + "            ITALIC "          + aComma[35 ] + CRLF
           ENDIF

           IF xArray[ nItem, 37 ] = ".T."
              Output += Space( Indent ) + "            UNDERLINE "       + aComma[37 ] + CRLF
           ENDIF

           IF xArray[ nItem, 39 ] = ".T."
              Output += Space( Indent ) + "            STRIKEOUT "       + aComma[39 ] + CRLF
           ENDIF

           IF Len( xArray[ nItem, 41 ] ) > 0
              Output += Space( Indent ) + "            TOOLTIP "         + xArray[ nItem, 41 ] + aComma[41 ] + CRLF
           ENDIF

           IF xArray[ nItem, 43 ] # "NIL"
              Output += Space( Indent ) + "            BACKCOLOR "       + xArray[ nItem, 43 ] + aComma[43 ] + CRLF
           ENDIF

           IF xArray[ nItem, 45 ] # "NIL"
              Output += Space( Indent ) + "            FONTCOLOR "       + xArray[ nItem, 45 ] + aComma[45 ] + CRLF
           ENDIF

           IF xArray[ nItem, 47 ] # "NIL"
              Output += Space( Indent ) + "            COLORS "          + xArray[ nItem, 47 ] + aComma[47 ] + CRLF
           ENDIF

           IF xArray[ nItem, 49 ] # "NIL"
              Output += Space( Indent ) + "            ON GOTFOCUS "     + xArray[ nItem, 49 ] + aComma[49 ] + CRLF
           ENDIF

           IF xArray[ nItem, 51 ] # "NIL"
              Output += Space( Indent ) + "            ON CHANGE "       + xArray[ nItem, 51 ] + aComma[51 ] + CRLF
           ENDIF

           IF  xArray[ nItem, 53 ] # "NIL"
              Output += Space( Indent ) + "            ON LOSTFOCUS "    + xArray[ nItem, 53 ] + aComma[53 ] + CRLF
           ENDIF

           IF xArray[ nItem, 55 ] # "NIL"
              Output += Space( Indent ) + "            ON DBLCLICK "     + xArray[ nItem, 55 ] + aComma[55 ] + CRLF
           ENDIF

           IF xArray[ nItem, 57 ] = ".T."
              Output += Space( Indent ) + "            EDIT "            + aComma[57 ] + CRLF
           ENDIF

           IF xArray[ nItem, 59 ] = ".T."
              Output += Space( Indent ) + "            GRID "            + aComma[59 ] + CRLF
           ENDIF

           IF xArray[ nItem, 61 ] = ".T."
              Output += Space( Indent ) + "            APPEND "          + aComma[61 ] + CRLF
           ENDIF

           IF xArray[ nItem, 63 ] # "NIL"
              Output += Space( Indent ) + "            ON HEADCLICK "    + xArray[ nItem, 63 ] + aComma[63 ] + CRLF
           ENDIF

           IF xArray[ nItem, 65 ] # "NIL"
              Output += Space( Indent ) + "            WHEN "            + xArray[ nItem, 65 ] + aComma[65 ] + CRLF
           ENDIF

           IF xArray[ nItem, 67 ] # "NIL"
              Output += Space( Indent ) + "            VALID "           + xArray[ nItem, 67 ] + aComma[67 ] + CRLF
           ENDIF

           IF xArray[ nItem, 69 ] # "NIL"
              Output += Space( Indent ) + "            VALIDMESSAGES "   + xArray[ nItem, 69 ] + aComma[69 ] + CRLF
           ENDIF

           IF Len( AllTrim( xArray[ nItem, 71 ] ) ) > 0
              Output += Space( Indent ) + "            MESSAGE "         + xArray[ nItem, 71 ] + aComma[71 ] + CRLF
           ENDIF

           IF xArray[ nItem, 73 ] # "NIL"
              Output += Space( Indent ) + "            READONLY "        + xArray[ nItem, 73 ] + aComma[73 ] + CRLF
           ENDIF

           IF xArray[ nItem, 75 ] = ".T."
              Output += Space( Indent ) + "            LOCK "            + aComma[75 ] + CRLF
           ENDIF

           IF xArray[ nItem, 77 ] = ".T."
              Output += Space( Indent ) + "            DELETE "          + aComma[77 ] + CRLF
           ENDIF

           IF xArray[ nItem, 79 ] = ".T."
              Output += Space( Indent ) + "            NOLINES "         + aComma[79 ] + CRLF
           ENDIF

           IF xArray[ nItem, 81 ] # "NIL"
              Output += Space( Indent ) + "            IMAGE "           + xArray[ nItem, 81 ] + aComma[81 ] + CRLF
           ENDIF

           IF xArray[ nItem, 83 ] # "NIL"
              Output += Space( Indent ) + "            JUSTIFY "         + xArray[ nItem, 83 ] + aComma[83 ] + CRLF
           ENDIF

           IF Len( AllTrim( xArray[ nItem, 85 ] ) ) > 0
              Output += Space( Indent ) + "            HELPID "          + xArray[ nItem, 85 ] + aComma[85 ] + CRLF
           ENDIF

           IF xArray[ nItem, 87 ] = ".T."
              Output += Space( Indent ) + "            BREAK "           + aComma[87 ] + CRLF
           ENDIF

           Output += Space( Indent ) + "     END TBROWSE  " + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "ACTIVEX"    // 27

           Output += Space( Indent ) + "     DEFINE ACTIVEX "  + AllTrim( xArray[ nItem, 3 ] )  + CRLF
           Output += Space( Indent ) + "            ROW    "   + AllTrim( Str( Row ) )          + CRLF
           Output += Space( Indent ) + "            COL    "   + AllTrim( Str( Col ) )          + CRLF
           Output += Space( Indent ) + "            WIDTH  "   + AllTrim( Str( Width ) )        + CRLF
           Output += Space( Indent ) + "            HEIGHT "   + AllTrim( Str( Height ) )       + CRLF
           Output += Space( Indent ) + "            PROGID "   + xArray[ nItem, 13 ]            + CRLF
           Output += Space( Indent ) + "     END ACTIVEX  "                                     + CRLF
           Output += CRLF

      *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      CASE cCtrlName == "PANEL"      // ?
           Output += Space( Indent ) + "    LOAD WINDOW " + AllTrim( xArray[ nItem, 3 ] ) + " AT " + AllTrim( Str(Row) ) + " , " + AllTrim( Str(Col) ) + " WIDTH " + AllTrim( Str(Width) ) + " HEIGHT " + AllTrim( Str(Height) ) + CRLF
           Output += CRLF

   ENDCASE

   *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   // MsgBox( "VALUE = " + xArray[ nItem, 1 ] )
   nValue :=  aScan( aUciControls, xArray[ nItem, 1 ] )

   IF nValue > 0

      Output += Space( Indent ) + "    DEFINE " + xArray[ nItem, 1 ] + " " + AllTrim( xArray[ nItem, 3 ] ) + CRLF
      Output += Space( Indent ) + "           ROW    "     + AllTrim( Str( Row ) )                         + CRLF
      Output += Space( Indent ) + "           COL    "     + AllTrim( Str( Col ) )                         + CRLF
      Output += Space( Indent ) + "           WIDTH  "     + AllTrim( Str( Width ) )                       + CRLF
      Output += Space( Indent ) + "           HEIGHT "     + AllTrim( Str( Height ) )                      + CRLF
      nPos := 11

      // MsgBox("nvalue= " + Str( nvalue ) )

      IF Len( aUciProps[ nValue ] ) > 0
         // MsgBox("len-auci= " + Str( Len( aUciProps[nValue ] ) ) + " value1= " + aUciProps[ nValue, 1 ] )
         FOR x := 1 TO Len( aUciProps[ nValue ] )
             nPos += 2
             // MsgBox( "npos1= "   + Str( nPos ) )
             // MsgBox( "uciprop= " + aUciProps[ nValue, x ] )
             // MsgBox( "value= "   + xArray[ nItem, nPos ] )
             Output += Space( indent ) + "           " + Upper( aUciProps[ nValue, x ] ) + " " + xArray[ nItem, nPos ] + CRLF
         NEXT x
      ENDIF

      IF Len( aUciEvents[ nValue ] ) > 0
         FOR x := 1 TO Len( aUciEvents[ nValue ] )
             nPos   += 2
             // MsgBox( "npos2= " + Str( nPos ) )
             // MsgBox( "event= " + aUciEvents[ nValue, x ] )
             // MsgBox( "valu= "  + xArray[ nItem, nPos ] )
             Output += Space( Indent ) + "           " + Upper( aUciEvents[ nValue, x ] ) + " " + xArray[ nItem, nPos ] + CRLF
         NEXT x
      ENDIF

      Output += Space( Indent ) + "     END " + xArray[ nItem, 1 ] + "  " + CRLF

   ENDIF

   // MsgBox("x= " +  xArray[ nItem,  1 ] + " " + xArray[ nItem,  2 ] + " " + xArray[ nItem, 3 ] + " " )
   // MsgBox("x= " +  xArray[ nItem,  4 ] + " " + xArray[ nItem,  5 ] + " " + xArray[ nItem, 6 ] + " " )
   // MsgBox("x= " +  xArray[ nItem,  7 ] + " " + xArray[ nItem,  8 ] + " " + xArray[ nItem, 9 ] + " " )
   // MsgBox("x= " +  xArray[ nItem, 10 ] + " " + xArray[ nItem, 11 ] + " " )

RETURN( output )


*------------------------------------------------------------*
