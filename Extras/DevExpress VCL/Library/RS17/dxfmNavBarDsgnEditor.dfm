object dxfmNavBarDesignWindow: TdxfmNavBarDesignWindow
  Left = 405
  Top = 152
  AutoScroll = False
  BorderIcons = [biSystemMenu]
  ClientHeight = 433
  ClientWidth = 539
  Color = clBtnFace
  Constraints.MinHeight = 467
  Constraints.MinWidth = 547
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object nbMain: TdxNavBar
    Left = 0
    Top = 0
    Width = 137
    Height = 392
    Align = alLeft
    ActiveGroupIndex = 0
    TabOrder = 1
    View = 8
    OptionsBehavior.Common.AllowSelectLinks = True
    OptionsImage.LargeImages = ilNavBarLarge
    OptionsImage.SmallImages = ilNavBarSmall
    OnLinkClick = nbMainLinkClick
    object bgMain: TdxNavBarGroup
      Caption = 'Main'
      LargeImageIndex = 0
      SelectedLinkIndex = -1
      TopVisibleLinkIndex = 0
      UseSmallImages = False
      Links = <
        item
          Item = biGroups
        end
        item
          Item = biItems
        end
        item
          Item = biLinks
        end
        item
          Item = biViews
        end
        item
          Item = biLookAndFeelViews
        end>
    end
    object bgStyles: TdxNavBarGroup
      Caption = 'Styles'
      LargeImageIndex = 1
      SelectedLinkIndex = -1
      TopVisibleLinkIndex = 0
      UseSmallImages = False
      Links = <
        item
          Item = biDefaultStyles
        end
        item
          Item = biCustomStyles
        end>
    end
    object biGroups: TdxNavBarItem
      Caption = 'Groups'
      SmallImageIndex = 0
    end
    object biItems: TdxNavBarItem
      Caption = 'Items'
      SmallImageIndex = 1
    end
    object biLinks: TdxNavBarItem
      Caption = 'Link designer'
      SmallImageIndex = 2
    end
    object biViews: TdxNavBarItem
      Caption = 'Views'
      SmallImageIndex = 3
    end
    object biLookAndFeelViews: TdxNavBarItem
      Caption = 'Schemes'
      SmallImageIndex = 4
    end
    object biDefaultStyles: TdxNavBarItem
      Caption = 'Default styles'
      SmallImageIndex = 5
    end
    object biCustomStyles: TdxNavBarItem
      Caption = 'Custom styles'
      SmallImageIndex = 6
    end
  end
  object pnCommonButtons: TPanel
    Left = 0
    Top = 392
    Width = 539
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btCancel: TButton
      Left = 431
      Top = 8
      Width = 100
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Close'
      TabOrder = 0
      OnClick = btCancelClick
    end
  end
  object pcMain: TPageControl
    Left = 137
    Top = 0
    Width = 402
    Height = 392
    ActivePage = tsGroups
    Align = alClient
    TabOrder = 0
    object tsGroups: TTabSheet
      Caption = 'Groups'
      object pnButtons: TPanel
        Left = 0
        Top = 0
        Width = 394
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object tlbGroups: TToolBar
          Left = 0
          Top = 6
          Width = 150
          Height = 25
          Align = alNone
          Caption = 'Commands'
          EdgeInner = esNone
          EdgeOuter = esNone
          Flat = True
          Images = ilActions
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object ToolButton3: TToolButton
            Left = 0
            Top = 0
            Action = actAdd
          end
          object ToolButton5: TToolButton
            Left = 23
            Top = 0
            Action = actDelete
          end
          object ToolButton6: TToolButton
            Left = 46
            Top = 0
            Width = 8
            Caption = 'ToolButton6'
            ImageIndex = 5
            Style = tbsSeparator
          end
          object ToolButton1: TToolButton
            Left = 54
            Top = 0
            Action = actMoveUp
          end
          object ToolButton2: TToolButton
            Left = 77
            Top = 0
            Action = actMoveDown
          end
          object ToolButton7: TToolButton
            Left = 100
            Top = 0
            Width = 8
            Caption = 'ToolButton7'
            ImageIndex = 5
            Style = tbsSeparator
          end
          object ToolButton12: TToolButton
            Left = 108
            Top = 0
            Action = actSelectAll
          end
        end
      end
      object lbxGroups: TListBox
        Left = 0
        Top = 33
        Width = 394
        Height = 331
        Align = alClient
        ItemHeight = 13
        MultiSelect = True
        PopupMenu = pmMain
        TabOrder = 1
        OnClick = ListBoxClick
        OnContextPopup = lbxContextPopup
      end
    end
    object tsItems: TTabSheet
      Caption = 'Items'
      ImageIndex = 5
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 394
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object tlbItems: TToolBar
          Left = 0
          Top = 6
          Width = 161
          Height = 25
          Align = alNone
          Caption = 'Commands'
          EdgeInner = esNone
          EdgeOuter = esNone
          Flat = True
          Images = ilActions
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object ToolButton4: TToolButton
            Left = 0
            Top = 0
            Action = actAdd
            DropdownMenu = pmGroupItemClasses
            Style = tbsDropDown
          end
          object ToolButton8: TToolButton
            Left = 36
            Top = 0
            Action = actDelete
          end
          object ToolButton9: TToolButton
            Left = 59
            Top = 0
            Width = 8
            Caption = 'ToolButton6'
            ImageIndex = 5
            Style = tbsSeparator
          end
          object ToolButton10: TToolButton
            Left = 67
            Top = 0
            Action = actMoveUp
          end
          object ToolButton11: TToolButton
            Left = 90
            Top = 0
            Action = actMoveDown
          end
          object ToolButton13: TToolButton
            Left = 113
            Top = 0
            Width = 8
            Caption = 'ToolButton7'
            ImageIndex = 5
            Style = tbsSeparator
          end
          object ToolButton14: TToolButton
            Left = 121
            Top = 0
            Action = actSelectAll
          end
        end
      end
      object lbxItems: TListBox
        Left = 0
        Top = 33
        Width = 394
        Height = 331
        Align = alClient
        ItemHeight = 13
        MultiSelect = True
        PopupMenu = pmMain
        TabOrder = 1
        OnClick = ListBoxClick
        OnContextPopup = lbxItemsContextPopup
      end
    end
    object tsLinks: TTabSheet
      Caption = 'Link designer'
      ImageIndex = 2
      object Splitter1: TSplitter
        Left = 227
        Top = 28
        Height = 336
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 394
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object tlbLinkDesigner: TToolBar
          Left = 0
          Top = 6
          Width = 150
          Height = 25
          Align = alNone
          Caption = 'Commands'
          EdgeInner = esNone
          EdgeOuter = esNone
          Flat = True
          Images = ilActions
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object ToolButton22: TToolButton
            Left = 0
            Top = 0
            Action = actAdd
          end
          object ToolButton23: TToolButton
            Left = 23
            Top = 0
            Action = actDelete
          end
          object ToolButton24: TToolButton
            Left = 46
            Top = 0
            Width = 8
            Caption = 'ToolButton6'
            ImageIndex = 5
            Style = tbsSeparator
          end
          object ToolButton25: TToolButton
            Left = 54
            Top = 0
            Action = actMoveUp
          end
          object ToolButton26: TToolButton
            Left = 77
            Top = 0
            Action = actMoveDown
          end
        end
      end
      object Panel3: TPanel
        Left = 230
        Top = 28
        Width = 164
        Height = 336
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object lbxLinkDesignerItems: TListView
          Left = 0
          Top = 25
          Width = 164
          Height = 311
          Align = alClient
          Columns = <>
          DragMode = dmAutomatic
          HideSelection = False
          ReadOnly = True
          PopupMenu = pmMain
          SmallImages = ilLinkDesigner
          TabOrder = 0
          ViewStyle = vsList
          OnContextPopup = lbxContextPopup
          OnEndDrag = lbxLinkDesignerItemsEndDrag
          OnDragDrop = lbxLinkDesignerItemsDragDrop
          OnDragOver = lbxLinkDesignerItemsDragOver
          OnStartDrag = lbxLinkDesignerItemsStartDrag
        end
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 164
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label2: TLabel
            Left = 0
            Top = 7
            Width = 28
            Height = 13
            Caption = 'Items:'
          end
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 28
        Width = 227
        Height = 336
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 2
        object tvLinkDesignerGroups: TTreeView
          Left = 0
          Top = 25
          Width = 227
          Height = 311
          Align = alClient
          DragMode = dmAutomatic
          HideSelection = False
          Images = ilLinkDesigner
          Indent = 19
          PopupMenu = pmMain
          ReadOnly = True
          TabOrder = 0
          OnContextPopup = lbxContextPopup
          OnDragDrop = tvLinkDesignerGroupsDragDrop
          OnDragOver = tvLinkDesignerGroupsDragOver
          OnEndDrag = tvLinkDesignerGroupsEndDrag
          OnExit = tvLinkDesignerGroupsExit
          OnStartDrag = tvLinkDesignerGroupsStartDrag
        end
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 227
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label1: TLabel
            Left = 0
            Top = 7
            Width = 82
            Height = 13
            Caption = 'Groups and links:'
          end
        end
      end
    end
    object tsViews: TTabSheet
      Caption = 'Views'
      ImageIndex = 4
      object Label3: TLabel
        Left = 193
        Top = 14
        Width = 41
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Preview:'
      end
      object Label4: TLabel
        Left = 0
        Top = 58
        Width = 57
        Height = 13
        Caption = 'View styles:'
      end
      object lblColorScheme: TLabel
        Left = 0
        Top = 325
        Width = 67
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'Color scheme:'
      end
      object Label5: TLabel
        Left = 0
        Top = 14
        Width = 49
        Height = 13
        Caption = 'Category:'
      end
      object nbPreview: TdxNavBar
        Left = 193
        Top = 32
        Width = 201
        Height = 332
        Anchors = [akTop, akRight, akBottom]
        BorderStyle = bsSingle
        ActiveGroupIndex = 0
        DragCopyCursor = -1141
        DragCursor = -1140
        HotTrackedLinkCursor = crHandPoint
        TabOrder = 0
        View = 13
        OptionsImage.LargeImages = ilPreviewLarge
        OptionsImage.SmallImages = ilPreviewSmall
        object bgLocal: TdxNavBarGroup
          Caption = 'Local'
          LargeImageIndex = 4
          SelectedLinkIndex = -1
          SmallImageIndex = 10
          TopVisibleLinkIndex = 0
          UseSmallImages = False
          Links = <
            item
              Item = biInbox
            end
            item
              Item = biOutbox
            end
            item
              Item = biSentItems
            end
            item
              Item = biDeletedItems
            end
            item
              Item = biReport
            end>
        end
        object bgContacts: TdxNavBarGroup
          Caption = 'Contacts'
          LargeImageIndex = 7
          LinksUseSmallImages = False
          SelectedLinkIndex = -1
          SmallImageIndex = 5
          TopVisibleLinkIndex = 0
          Links = <
            item
              Item = nbCalendar
            end
            item
              Item = nbTask
            end
            item
              Item = biReport
            end>
        end
        object biInbox: TdxNavBarItem
          Caption = 'Inbox'
          LargeImageIndex = 3
          SmallImageIndex = 3
        end
        object biOutbox: TdxNavBarItem
          Caption = 'Outbox'
          LargeImageIndex = 7
          SmallImageIndex = 7
        end
        object biSentItems: TdxNavBarItem
          Caption = 'Sent Items'
          Enabled = False
          LargeImageIndex = 0
          SmallImageIndex = 0
        end
        object biDeletedItems: TdxNavBarItem
          Caption = 'Deleted Items'
          LargeImageIndex = 1
          SmallImageIndex = 1
        end
        object biReport: TdxNavBarItem
          Caption = 'Report'
          LargeImageIndex = 2
          SmallImageIndex = 2
        end
        object nbCalendar: TdxNavBarItem
          Caption = 'Calendar'
          LargeImageIndex = 6
          SmallImageIndex = 6
        end
        object nbTask: TdxNavBarItem
          Caption = 'Task'
          LargeImageIndex = 5
          SmallImageIndex = 4
        end
      end
      object lbxViewStyles: TListBox
        Left = 0
        Top = 77
        Width = 189
        Height = 242
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 1
        OnClick = lbxViewStylesChange
        OnContextPopup = lbxContextPopup
      end
      object cbColorScheme: TComboBox
        Left = 0
        Top = 343
        Width = 189
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akRight, akBottom]
        ItemHeight = 0
        TabOrder = 2
        OnChange = cbColorSchemeChange
      end
      object cbCategories: TComboBox
        Left = 0
        Top = 32
        Width = 189
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 3
        Text = 'All'
        OnChange = cbCategoriesChange
        Items.Strings = (
          'All'
          'Explorer Bar'
          'Side Bar')
      end
      object chSortViews: TCheckBox
        Left = 78
        Top = 57
        Width = 111
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Sort alphabetically'
        TabOrder = 4
        OnClick = chSortViewsClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Schemes'
      ImageIndex = 6
      object Label6: TLabel
        Left = 8
        Top = 49
        Width = 22
        Height = 13
        Caption = 'Flat:'
      end
      object Label7: TLabel
        Left = 8
        Top = 79
        Width = 48
        Height = 13
        Caption = 'Standard:'
      end
      object Label8: TLabel
        Left = 8
        Top = 110
        Width = 43
        Height = 13
        Caption = 'UltraFlat:'
      end
      object Label9: TLabel
        Left = 8
        Top = 141
        Width = 45
        Height = 13
        Caption = 'Office11:'
      end
      object Label10: TLabel
        Left = 8
        Top = 173
        Width = 35
        Height = 13
        Caption = 'Native:'
      end
      object Label11: TLabel
        Left = 8
        Top = 205
        Width = 23
        Height = 13
        Caption = 'Skin:'
      end
      object Label12: TLabel
        Left = 8
        Top = 11
        Width = 109
        Height = 13
        Caption = 'Look && Feel scheme:'
      end
      object cbFlat: TComboBox
        Left = 70
        Top = 46
        Width = 209
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = cbFlatChange
      end
      object cbStandard: TComboBox
        Tag = 1
        Left = 70
        Top = 76
        Width = 209
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        OnChange = cbFlatChange
      end
      object cbUltraFlat: TComboBox
        Tag = 2
        Left = 70
        Top = 107
        Width = 209
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
        OnChange = cbFlatChange
      end
      object cbOffice11: TComboBox
        Tag = 4
        Left = 70
        Top = 138
        Width = 209
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
        OnChange = cbFlatChange
      end
      object cbNative: TComboBox
        Tag = 3
        Left = 70
        Top = 170
        Width = 209
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 5
        OnChange = cbFlatChange
      end
      object cbSkin: TComboBox
        Tag = 5
        Left = 70
        Top = 202
        Width = 209
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 6
        OnChange = cbFlatChange
      end
      object cbLookAndFeelSchemes: TComboBox
        Left = 134
        Top = 8
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'Custom'
        OnChange = cbLookAndFeelSchemesChange
        Items.Strings = (
          'Custom'
          'Explorer Bar View'
          'Side Bar View')
      end
    end
    object tsDefaultStyles: TTabSheet
      Caption = 'Default styles'
      ImageIndex = 5
      object lbxDefaultStyles: TListBox
        Left = 0
        Top = 33
        Width = 394
        Height = 331
        Align = alClient
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 0
        OnClick = ListBoxClick
        OnContextPopup = lbxContextPopup
      end
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 394
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object tlbDefaultStyles: TToolBar
          Left = 0
          Top = 6
          Width = 150
          Height = 33
          Align = alNone
          Caption = 'Commands'
          EdgeInner = esNone
          EdgeOuter = esNone
          Flat = True
          Images = ilActions
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object ToolButton27: TToolButton
            Left = 0
            Top = 0
            Action = actDefaultSettings
          end
        end
      end
    end
    object tsCustomStyles: TTabSheet
      Caption = 'Custom styles'
      ImageIndex = 3
      object lbxCustomStyles: TListBox
        Left = 0
        Top = 33
        Width = 394
        Height = 331
        Align = alClient
        ItemHeight = 13
        MultiSelect = True
        PopupMenu = pmMain
        TabOrder = 0
        OnClick = ListBoxClick
        OnContextPopup = lbxContextPopup
      end
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 394
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object tlbCustomStyles: TToolBar
          Left = 0
          Top = 6
          Width = 150
          Height = 33
          Align = alNone
          Caption = 'Commands'
          EdgeInner = esNone
          EdgeOuter = esNone
          Flat = True
          Images = ilActions
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object ToolButton15: TToolButton
            Left = 0
            Top = 0
            Action = actAdd
          end
          object ToolButton16: TToolButton
            Left = 23
            Top = 0
            Action = actDelete
          end
          object ToolButton17: TToolButton
            Left = 46
            Top = 0
            Width = 8
            Caption = 'ToolButton6'
            ImageIndex = 5
            Style = tbsSeparator
          end
          object ToolButton18: TToolButton
            Left = 54
            Top = 0
            Action = actMoveUp
          end
          object ToolButton19: TToolButton
            Left = 77
            Top = 0
            Action = actMoveDown
          end
          object ToolButton20: TToolButton
            Left = 100
            Top = 0
            Width = 8
            Caption = 'ToolButton7'
            ImageIndex = 5
            Style = tbsSeparator
          end
          object ToolButton21: TToolButton
            Left = 108
            Top = 0
            Action = actSelectAll
          end
        end
      end
    end
  end
  object pmMain: TPopupMenu
    Images = ilActions
    Left = 15
    Top = 247
    object miAdd: TMenuItem
      Action = actAdd
      Visible = False
    end
    object msiAdd: TMenuItem
      Caption = '&Add'
      Hint = 'Add'
      ImageIndex = 0
      Visible = False
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object miEdit: TMenuItem
      Caption = '&Edit'
      object miCut: TMenuItem
        Action = actCut
      end
      object miCopy: TMenuItem
        Action = actCopy
      end
      object miPaste: TMenuItem
        Action = actPaste
      end
      object miDelete: TMenuItem
        Action = actDelete
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object miSelectAll: TMenuItem
        Action = actSelectAll
      end
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object miMoveUp: TMenuItem
      Action = actMoveUp
    end
    object miMoveDown: TMenuItem
      Action = actMoveDown
    end
  end
  object actlCommands: TActionList
    Images = ilActions
    OnUpdate = actlCommandsUpdate
    Left = 96
    Top = 248
    object actAdd: TAction
      Category = 'EditCollection'
      Caption = '&Add'
      Hint = 'Add'
      ImageIndex = 0
      ShortCut = 45
      OnExecute = AddClick
    end
    object actMoveUp: TAction
      Category = 'EditCollection'
      Caption = 'Move &Up'
      Hint = 'Move up'
      ImageIndex = 5
      ShortCut = 16422
      OnExecute = MoveUpClick
    end
    object actMoveDown: TAction
      Category = 'EditCollection'
      Caption = 'Move &Down'
      Hint = 'Move Down'
      ImageIndex = 6
      ShortCut = 16424
      OnExecute = MoveDownClick
    end
    object actCut: TAction
      Category = 'EditCollection'
      Caption = 'Cu&t'
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 1
      ShortCut = 16472
      OnExecute = ActionClick
    end
    object actDefaultSettings: TAction
      Category = 'DefaultStyles'
      Caption = 'DefaultSettings'
      Hint = 'Default settings'
      ImageIndex = 7
      ShortCut = 16452
      OnExecute = DefaultSettingsClick
    end
    object actCopy: TAction
      Category = 'EditCollection'
      Caption = '&Copy'
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 2
      ShortCut = 16451
      OnExecute = ActionClick
    end
    object actPaste: TAction
      Category = 'EditCollection'
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 3
      ShortCut = 16470
      OnExecute = ActionClick
    end
    object actDelete: TAction
      Category = 'EditCollection'
      Caption = '&Delete'
      Hint = 'Delete|Erases the selection'
      ImageIndex = 4
      ShortCut = 46
      OnExecute = ActionClick
    end
    object actSelectAll: TAction
      Category = 'EditCollection'
      Caption = 'Select All'
      Hint = 'Select All|Selects the entire document'
      ImageIndex = 8
      ShortCut = 16449
      OnExecute = ActionClick
    end
  end
  object ilActions: TcxImageList
    FormatVersion = 1
    DesignInfo = 19398672
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000B0B0B210B0B0B210B0B0B210B0B
          0B210B0B0B210000000000000000000000000000000000000000000000000000
          00000000000000000000000000000A8261FF09805FFF077E5DFF077C5BFF067A
          5AFF0B0B0B210000000000000000000000000000000000000000000000000000
          00000000000000000000000000000C8665FF3CC2AAFF3CC2AAFF3BC2AAFF077D
          5CFF0B0B0B210000000000000000000000000000000000000000000000000000
          00000000000000000000000000000F8968FF3DC5ADFF3DC5ACFF3DC5ACFF0980
          5FFF0B0B0B210000000000000000000000000000000000000000000000000000
          00000B0B0B210B0B0B210B0B0B21128D6CFF40C8B0FF40C8B0FF40C7B0FF0A82
          62FF0B0B0B210B0B0B210B0B0B210B0B0B210B0B0B2100000000000000001B9D
          7CFF1A9A79FF189776FF169573FF149270FF44CDB4FF44CCB3FF44CBB3FF0D87
          66FF0C8463FF0A8261FF097F5EFF077E5DFF0B0B0B2100000000000000001FA0
          7FFF4AD3BAFF4AD3B9FF49D2B9FF49D2B8FF49D0B8FF47D0B8FF47D0B7FF47CF
          B6FF46CFB7FF46CFB6FF46CEB5FF09805FFF0B0B0B21000000000000000020A4
          83FF4ED7BEFF4DD7BEFF4DD6BDFF4DD6BDFF4CD6BCFF4CD5BCFF4BD4BCFF4BD4
          BBFF4BD4BAFF49D3B9FF49D2B9FF0B8462FF0B0B0B21000000000000000022A6
          86FF51DCC2FF51DBC2FF51DBC1FF50DAC1FF50DAC1FF50DAC0FF4FD9C0FF4FD9
          BFFF4ED8BFFF4ED8BFFF4DD7BDFF0E8866FF0B0B0B21000000000000000023A9
          88FF23A886FF22A685FF20A383FF1EA180FF53DDC4FF53DEC4FF53DDC3FF1797
          76FF169473FF14916FFF128E6DFF108B6AFF0000000000000000000000000000
          000000000000000000000000000021A583FF57E1C7FF56E0C7FF56E0C6FF1A9A
          79FF0B0B0B210000000000000000000000000000000000000000000000000000
          000000000000000000000000000023A786FF58E3C9FF58E3C9FF58E3C8FF1C9E
          7DFF0B0B0B210000000000000000000000000000000000000000000000000000
          000000000000000000000000000024A989FF58E3C9FF58E3C9FF58E3C9FF1FA2
          81FF0B0B0B210000000000000000000000000000000000000000000000000000
          000000000000000000000000000025AB8AFF25AA89FF23A988FF23A786FF21A5
          84FF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000084000000840000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000008400000000000000000000008400000000000000000000008400
          0000840000000000000000000000000000000000000000000000000000000000
          0000000000008400000000000000000000008400000000000000840000000000
          0000000000008400000000000000000000000000000000000000000000000000
          0000000000008400000000000000000000008400000000000000840000000000
          0000000000008400000000000000000000000000000000000000000000000000
          0000000000000000000084000000840000008400000000000000840000000000
          0000000000008400000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000008400000000000000840000008400
          0000840000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000008400000000000000840000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000F3FF0000ED9F0000ED6F0000ED6F0000F16F0000FD1F0000FC7F
          0000FEFF0000FC7F0000FD7F0000F93F0000FBBF0000FBBF0000FBBF0000FFFF
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000008400000084000000840000008400
          0000840000008400000084000000840000008400000000000000000000000000
          00000000000000000000000000000000000084000000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008400000000000000000000000000
          00000000000000000000000000000000000084000000FFFFFF00000000000000
          0000000000000000000000000000FFFFFF008400000000000000000000000000
          00000000000000000000000000000000000084000000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00840000000000000000000000FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF00000000000000
          0000000000000000000000000000FFFFFF00840000000000000000000000FFFF
          FF000000000000000000000000000000000084000000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00840000000000000000000000FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF00000000000000
          0000FFFFFF00840000008400000084000000840000000000000000000000FFFF
          FF000000000000000000000000000000000084000000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF0084000000FFFFFF0084000000000000000000000000000000FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00840000008400000000000000000000000000000000000000FFFF
          FF000000000000000000FFFFFF00000000008400000084000000840000008400
          000084000000840000000000000000000000000000000000000000000000FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000000000000000000000
          000000000000000000000000000000000000000000000000000000000000FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000FFFF0000FC010000FC010000FC01000000010000000100000001
          0000000100000003000000070000000F000000FF000001FF000003FF0000FFFF
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000008400000084000000840000008400
          0000840000008400000084000000840000008400000084000000000000000000
          00000000000000000000000000000000000084000000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084000000000000008484
          84000084840084848400008484008484840084000000FFFFFF00840000008400
          000084000000840000008400000084000000FFFFFF0084000000000000000084
          84008484840000848400848484000084840084000000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084000000000000008484
          84000084840084848400008484008484840084000000FFFFFF00840000008400
          000084000000FFFFFF0084000000840000008400000084000000000000000084
          84008484840000848400848484000084840084000000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0084000000FFFFFF008400000000000000000000008484
          84000084840084848400008484008484840084000000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0084000000840000000000000000000000000000000084
          8400848484000084840084848400008484008400000084000000840000008400
          0000840000008400000084000000000000000000000000000000000000008484
          8400008484008484840000848400848484000084840084848400008484008484
          8400008484008484840000848400000000000000000000000000000000000084
          8400848484000000000000000000000000000000000000000000000000000000
          0000000000008484840084848400000000000000000000000000000000008484
          84008484840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
          C600000000008484840000848400000000000000000000000000000000000084
          840084848400008484000000000000FFFF00000000000000000000FFFF000000
          0000848484000084840084848400000000000000000000000000000000000000
          00000000000000000000000000000000000000FFFF0000FFFF00000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000FC00000080000000000000000000000000000000000100000003
          0000000300000003000000030000000300000003000080070000F87F0000FFFF
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000A1C290141ACFF171717450000000000000000000000000000
          00000141ACFF1717174500000000000000000000000000000000000000000000
          0000000A1C290141ACFF2D60DFFF0141ACFF1717174500000000000000000141
          ACFF2D60DFFF0141ACFF17171745000000000000000000000000000000000000
          00000141ACFF2D60DFFF3666E9FF2D60DFFF0141ACFF171717450141ACFF2D60
          DFFF3666E9FF2D60DFFF0141ACFF171717450000000000000000000000000000
          0000000A1C290141ACFF2F63E1FF3869EBFF2F63E1FF0141ACFF2F63E1FF3969
          EBFF2F63E1FF0141ACFF17171745000000000000000000000000000000000000
          000000000000000A1C290141ACFF3368E3FF3C6EEEFF3C6EEEFF3C6FEEFF3367
          E3FF0141ACFF1717174500000000000000000000000000000000000000000000
          00000000000000000000000A1C290141ACFF4074F2FF4075F1FF4074F1FF0141
          ACFF171717450000000000000000000000000000000000000000000000000000
          000000000000000A1C290141ACFF3871E8FF4379F4FF4379F4FF437AF4FF3970
          E8FF0141ACFF1717174500000000000000000000000000000000000000000000
          0000000A1C290141ACFF3B73EAFF467DF6FF3B73EAFF0141ACFF3B73EAFF467D
          F6FF3B73EAFF0141ACFF17171745000000000000000000000000000000000000
          00000141ACFF3B73EAFF467DF6FF3B73EAFF0141ACFF171717450141ACFF3B73
          EAFF467DF6FF3B73EAFF0141ACFF171717450000000000000000000000000000
          0000000A1C290141ACFF3B73EAFF0141ACFF1717174500000000000000000141
          ACFF3B73EAFF0141ACFF17171745000000000000000000000000000000000000
          000000000000000A1C290141ACFF171717450000000000000000000000000000
          00000141ACFF1717174500000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000B0B0B260B0B0B260B0B0B260B0B
          0B260B0B0B260000000000000000000000000000000000000000000000000000
          000000000000000000000000000025AB8AFF24AA89FF23AA87FF22A987FF22A9
          86FF0B0B0B260000000000000000000000000000000000000000000000000000
          000000000000000000000000000022A988FF58E3C9FF58E3C9FF58E3C9FF1EA6
          84FF0B0B0B260000000000000000000000000000000000000000000000000000
          00000000000000000000000000001FA583FF55E0C6FF55E0C6FF55E0C6FF1BA0
          7EFF0B0B0B260000000000000000000000000000000000000000000000000000
          00000000000000000000000000001B9E7CFF51DBC2FF51DBC2FF51DBC1FF179C
          7AFF0B0B0B260000000000000000000000000000000000000000000000000000
          0000000000000B0B0B260B0B0B26189C7AFF4CD6BCFF4CD5BCFF4CD5BCFF149B
          78FF0B0B0B260B0B0B260B0B0B260B0B0B260000000000000000000000000000
          0000179C7AFF169C79FF159B78FF149B78FF47D0B6FF47D0B6FF47D0B6FF1199
          76FF109975FF0F9875FF0E9874FF000000000000000000000000000000000000
          00000023194B138D6BFF37BDA3FF42CAB1FF42CAB1FF42CAB2FF42CAB2FF42CA
          B1FF37BDA3FF0C8464FF00000000000000000000000000000000000000000000
          0000000000000023194B0F8766FF33B89FFF3EC5ADFF3EC5ADFF3EC6ADFF34B8
          9FFF0A8160FF0000000000000000000000000000000000000000000000000000
          000000000000000000000023194B0B8362FF32B69CFF3BC2AAFF32B69CFF087F
          5EFF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000023194B087F5CFF32B69CFF067C5CFF0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000023194B057A59FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000023194B057A59FF0E0E0E300000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000023194B087F5CFF32B69CFF067C5CFF0E0E
          0E30000000000000000000000000000000000000000000000000000000000000
          000000000000000000000023194B0B8362FF32B69CFF3BC2AAFF32B69CFF087F
          5EFF0E0E0E300000000000000000000000000000000000000000000000000000
          0000000000000023194B0F8766FF33B89FFF3EC5ADFF3EC5ADFF3EC6ADFF34B8
          9FFF0A8160FF0E0E0E3000000000000000000000000000000000000000000000
          00000023194B138D6BFF37BDA3FF42CAB1FF42CAB1FF42CAB2FF42CAB2FF42CA
          B1FF37BDA3FF0C8464FF0E0E0E30000000000000000000000000000000000000
          0000179C7AFF169C79FF159B78FF149B78FF47D0B6FF47D0B6FF47D0B6FF1199
          76FF109975FF0F9875FF0E9874FF0E0E0E300000000000000000000000000000
          0000000000000000000000000000189C7AFF4CD6BCFF4CD5BCFF4CD5BCFF149B
          78FF0E0E0E300000000000000000000000000000000000000000000000000000
          00000000000000000000000000001B9E7CFF51DBC2FF51DBC2FF51DBC1FF179C
          7AFF0E0E0E300000000000000000000000000000000000000000000000000000
          00000000000000000000000000001FA583FF55E0C6FF55E0C6FF55E0C6FF1BA0
          7EFF0E0E0E300000000000000000000000000000000000000000000000000000
          000000000000000000000000000022A988FF58E3C9FF58E3C9FF58E3C9FF1EA6
          84FF0E0E0E300000000000000000000000000000000000000000000000000000
          000000000000000000000000000025AB8AFF24AA89FF23AA87FF22A987FF22A9
          86FF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000070A09280C11
          10430141ACFF0B2E60B61D282D8A17211F82151C1B73121817620F1413510C10
          0F41090C0C310608082104050514000000000000000000000000000000000000
          0000001B47696794F6FF6794F6FF5B83DAE22D416C7000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000587FD3DB6794F6FF6794F6FF0C5BCDFF0141ACFF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000314675796794F6FF6794F6FF0B45BAFF0C5BCDFF0141ACFF0000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000121A2B2D3863F1FF0141ACFF6794F6FF0B45BAFF0C5BCDFF0141
          ACFF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000013DA2F03863F1FF3E71EFFF6794F6FF0B45BAFF0C5B
          CDFF0141ACFF0000000000000000000000000000000000000000000000000000
          00000000000000000000000000000141ACFF3863F1FF3E71EFFF6794F6FF0B45
          BAFF0C5BCDFF0141ACFF00000000000000000000000000000000000000000000
          00000000000000000000FFFFFFFFFFFFFFFF0141ACFF3863F1FF3E71EFFF6794
          F6FF0B45BAFF0C5BCDFF0141ACFF000000000000000000000000000000000000
          000000000000FFFFFFFF000000FFFFFFFFFF000000000141ACFF3863F1FF3E71
          EFFF6794F6FF0B45BAFFFFFFFFFF2E7857FF0000000000000000000000000000
          0000FFFFFFFF000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF3E71EFFFFFFFFFFF3C906FFF429664FF286443CF0000000000000000FFFF
          FFFF000000FF000000FF000000FF000000FF000000FF000000FF000000FFFFFF
          FFFFFFFFFFFF69B2A5FF8FCDAEFF429664FF429664FF1535236E000000000000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FFFFFF
          FFFF276F65FF70BD99FF70BD99FF8FCDAEFF317B52FF00000000000000000000
          0000000000FF000000FF000000FF000000FF000000FF000000FF000000FFFFFF
          FFFF00000000286443CF70BD99FF317B52FF0000000000000000000000000000
          000000000000000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF0000000000000000112B1D59000000000000000000000000000000000000
          00000000000000000000000000FF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000FF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000FF0000000000000000000000000032
          86FFFFFFFFFF003286FFFFFFFFFF003286FFFFFFFFFF003286FFFFFFFFFF0032
          86FFFFFFFFFF000000FF000000FF000000FF000000FF000000FF00000000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E9FFE8E8E8FFE7E7E7FFE6E6E6FFE4E4
          E4FFE3E3E3FFE3E3E3FFFFFFFFFF000000FF0000000000000000000000000032
          86FFFFFFFFFFFFFFFFFF007756FF007756FF007756FF007756FF007756FF0077
          56FF007756FFE4E4E4FFFFFFFFFF000000FF000000000000000000000000FFFF
          FFFFFFFFFFFFFFFFFFFF007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF007756FFE6E6E6FFFFFFFFFFFFFFFFFF0000000000000000000000000032
          86FFFFFFFFFFFFFFFFFF007756FFFFFFFFFF494949FF474747FF454545FFFFFF
          FFFF007756FFE7E7E7FFFFFFFFFF003286FF000000000000000000000000FFFF
          FFFFFFFFFFFFFFFFFFFF007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF007756FFE9E9E9FFFFFFFFFFFFFFFFFF0000000000000000000000000032
          86FFFFFFFFFFFFFFFFFF007756FFFFFFFFFF646464FF626262FF606060FFFFFF
          FFFF007756FFEBEBEBFFFFFFFFFF003286FF000000000000000000000000FFFF
          FFFFFFFFFFFFFFFFFFFF007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF007756FFEDEDEDFFFFFFFFFFFFFFFFFF0000000000000000000000000032
          86FFFFFFFFFFFFFFFFFF007756FFFFFFFFFF818181FF7E7E7EFFFFFFFFFFFFFF
          FFFF007756FFFFFFFFFFFFFFFFFF003286FF000000000000000000000000FFFF
          FFFFFFFFFFFFFFFFFFFF007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0077
          56FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000032
          86FFFFFFFFFFFFFFFFFF007756FF007756FF007756FF007756FF007756FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF003286FF000000000000000000000000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000032
          86FFFFFFFFFF003286FFFFFFFFFF003286FFFFFFFFFF003286FFFFFFFFFF0032
          86FFFFFFFFFF003286FFFFFFFFFF003286FF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000006060611121212351414143B1414143B1414143BFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF12121235060606110000000000000000000000000000
          000000221848026D50EC007756FF007756FF007756FF007756FFFFFFFFFF0000
          00FF000000FFFFFFFFFF0E2F2672121212350000000000000000000000000000
          0000006A4DE4B7D9CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
          00FF000000FFFFFFFFFFFFFFFFFF1414143B0000000000000000000000000000
          0000007756FFFFFFFFFFADADADFFADADADFFFFFFFFFF000000FF000000FF0000
          00FF000000FF000000FF000000FF1414143B00000000000000000404040C0D0D
          0D270E7156FFE2E2E2FFE2E2E2FFE2E2E2FFFFFFFFFF000000FF000000FF0000
          00FF000000FF000000FF000000FF1E1E1E590404040C000000000D3329630D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FFFFFFFFFFFFFFFFFFFFFFFFFF0000
          00FF000000FFFFFFFFFFFFFFFFFF0D9570FF0D332963000000000D9570FF0D95
          70FF007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
          00FF000000FFFFFFFFFF007756FF0D9570FF0D9570FF000000000D9570FF0D95
          70FF007756FFFFFFFFFF8D968BFF8D968BFF8D968BFF8D968BFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF007756FF0D9570FF0D9570FF000000000D9570FF0D95
          70FF0E7156FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2
          E2FFE2E2E2FFE2E2E2FF0E7156FF0D9570FF0D9570FF0000000003251C3F0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF03251C3F00000000000000000000
          0000007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF007756FF1414143B0000000000000000000000000000
          0000007756FFFFFFFFFFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3
          C3FFC3C3C3FFFFFFFFFF007756FF121212350000000000000000000000000000
          0000006C4EE7BDDCD3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFBDDCD3FF016D4FEB0505050F0000000000000000000000000000
          0000001D153F005E44C9007756FF007756FF007756FF007756FF007756FF0077
          56FF007756FF005E44C9001D153F000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000006060611121212351414143B1414143B1414143BFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF12121235060606110000000000000000000000000000
          000000221848026D50EC007756FF007756FF007756FF007756FFFFFFFFFF0000
          00FF000000FFFFFFFFFF0E2F2672121212350000000000000000000000000000
          0000006A4DE4B7D9CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
          00FF000000FFFFFFFFFFFFFFFFFF1414143B0000000000000000000000000000
          0000007756FFFFFFFFFF434343FFFFFFFFFFFFFFFFFF000000FF000000FF0000
          00FF000000FF000000FF000000FF1414143B0000000000000000000000000000
          0000007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF000000FF0000
          00FF000000FF000000FF000000FF1414143B0000000000000000000000000000
          0000007756FF007756FF007756FF007756FFFFFFFFFFFFFFFFFFFFFFFFFF0000
          00FF000000FFFFFFFFFFFFFFFFFF1414143B0000000000000000000000000000
          0000007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
          00FF000000FFFFFFFFFF007756FF1414143B0000000000000000000000000000
          0000007756FFFFFFFFFF434343FFFFFFFFFFA6A6A6FFA6A6A6FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF007756FF1414143B0000000000000000000000000000
          0000007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF007756FF1414143B0000000000000000000000000000
          0000007756FF007756FF007756FF007756FF007756FF007756FF007756FF0077
          56FF007756FF007756FF007756FF1414143B0000000000000000000000000000
          0000007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF007756FF1414143B0000000000000000000000000000
          0000007756FFFFFFFFFF434343FFFFFFFFFFA6A6A6FFA6A6A6FFA6A6A6FFA6A6
          A6FFA6A6A6FFFFFFFFFF007756FF121212350000000000000000000000000000
          0000006C4EE7BDDCD3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFBDDCD3FF016D4FEB0505050F0000000000000000000000000000
          0000001D153F005E44C9007756FF007756FF007756FF007756FF007756FF0077
          56FF007756FF005E44C9001D153F000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end>
  end
  object ilNavBarLarge: TcxImageList
    Height = 32
    Width = 32
    FormatVersion = 1
    DesignInfo = 19398704
    ImageInfo = <
      item
        Image.Data = {
          36100000424D3610000000000000360000002800000020000000200000000100
          2000000000000010000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000010101022222223B393939624040
          406D4141416F4242427143434372434343734444447444444475464646774646
          4678474747794747477A4848487B4848487C4949497D4A4A4A7E4A4A4A7F4444
          4475292929470202020300000000000000000000000000000000000000000000
          00000000000000000000000000000004030615604CA5128D6CF10D9570FF0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF138E6DF32773
          5EC5494C4B822828284500000000000000000000000000000000000000000000
          0000000000000000000000000000074F3B870D9570FF0D9570FF0D9570FF0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D95
          70FF29725EC34343437200000000000000000000000000000000000000000000
          00000000000000000000000000000C8967EA0D9570FF51B398FFE8F5F2FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8F5F2FF51B398FF0D95
          70FF118F6CF44747477A00000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FFE5F4F0FFFCFCFCFFF4F4
          F4FFF2F2F2FFF1F1F1FFF1F1F1FFF0F0F0FFEFEFEFFFEFEFEFFFEEEEEEFFEEEE
          EEFFEDEDEDFFECECECFFECECECFFEBEBEBFFEDEDEDFFF9F9F9FFE5F4F0FF0D95
          70FF0D9570FF4646467800000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FFFFFFFFFFF8F8F8FFF7F7
          F7FF818181FF818181FF808080FF7F7F7FFF7E7E7EFF7D7D7DFF7D7D7DFF7C7C
          7CFF7B7B7BFF7A7A7AFF7A7A7AFF797979FFEEEEEEFFEFEFEFFFFFFFFFFF0D95
          70FF0D9570FF4444447400000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FFFFFFFFFFFBFBFBFFFBFB
          FBFFFAFAFAFFFAFAFAFFF9F9F9FFF8F8F8FFF8F8F8FFF7F7F7FFF6F6F6FFF6F6
          F6FFF5F5F5FFF4F4F4FFF3F3F3FFF3F3F3FFF2F2F2FFF1F1F1FFFFFFFFFF0D95
          70FF0D9570FF4242427100000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FFFFFFFFFFFEFEFEFFFEFE
          FEFFFEFEFEFFFDFDFDFFFDFDFDFFFCFCFCFFFBFBFBFFFBFBFBFFFAFAFAFFFAFA
          FAFFF9F9F9FFF8F8F8FFF8F8F8FFF7F7F7FFF6F6F6FFF6F6F6FFFFFFFFFF0D95
          70FF0D9570FF4040406E00000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FFFFFFFFFFFFFFFFFFFFFF
          FFFF909090FF8F8F8FFF8E8E8EFF8E8E8EFF8C8C8CFF8B8B8BFF8A8A8AFF8989
          89FF888888FF878787FF868686FF858585FFFAFAFAFFFAFAFAFFFFFFFFFF0D95
          70FF0D9570FF3F3F3F6B00000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FFE8F5F2FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFFFFE8F5F2FF0D95
          70FF0D9570FF3D3D3D6800000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FF49AF93FFCCE9E1FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFCCD5F8FF6C87EAFF234AE0FF6C87EAFFCCD5F8FFDFF1ECFF49AF93FF0D95
          70FF0D9570FF3A3A3A6400000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FF0D9570FF0D9570FF0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF09644CFFBAD0
          CAFF6C87EAFF153FDEFFFFFFFFFF153FDEFF6C87EAFFBAD0CAFF09644CFF0D95
          70FF0D9570FF3939396100000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FF0D9570FF0D9570FF0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF085842FFF5F8
          F8FF234AE0FFFFFFFFFFFFFFFFFFFFFFFFFF234AE0FFF5F8F8FF085842FF0D95
          70FF0D9570FF3636365D00000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF41CBAFFF41CBAFFF41CBAFFF41CB
          AEFF41CBAFFF41CBAFFF41CBAEFF41CBAFFF41CBAEFF41CBAEFF157059FFBAD0
          CAFF6C87EAFF153FDEFF153FDEFF153FDEFF6C87EAFFBAD0CAFF15705AFF41CB
          AFFF0D9570FF3434345900000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF2FB798FF32BB9CFF32BB9CFF32BC
          9DFF32BC9DFF32BC9DFF32BC9DFF32BC9DFF32BB9CFF32BC9DFF1E8B71FF6596
          89FFC6D1F4FF6C87EAFF234AE0FF6C87EAFFC6D1F4FF659689FF1E8B71FF2FB7
          98FF0D9570FF3232325600000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF129B76FF1EA785FF23AC8BFF23AC
          8BFF23AC8BFF23AC8AFF23AC8BFF23AC8BFF23AC8BFF23AC8AFF20A182FF1274
          5BFF659689FFBAD0CAFFF5F8F8FFBAD0CAFF659689FF12745BFF1B9D7CFF129B
          76FF0D9570FF3030305200000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FF0D9570FF0D9570FF0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0C8D
          6AFF0B7759FF09644CFF085842FF09644CFF0B7759FF0C8D6AFF0D9570FF0D95
          70FF0D9570FF2E2E2E4F00000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FF51B398FFE8F5F2FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8F5F2FF51B398FF0D95
          70FF0D9570FF2C2C2C4B00000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FFE5F4F0FFFCFCFCFFF4F4
          F4FFF2F2F2FFF1F1F1FFF1F1F1FFF0F0F0FFEFEFEFFFEFEFEFFFEEEEEEFFEEEE
          EEFFEDEDEDFFECECECFFECECECFFEBEBEBFFEDEDEDFFF9F9F9FFE5F4F0FF0D95
          70FF0D9570FF2929294700000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FFFFFFFFFFF8F8F8FFF7F7
          F7FFBBBBBBFFBABABAFFB8B8B8FFB7B7B7FFB6B6B6FFB4B4B4FFB3B3B3FFB1B1
          B1FFB0B0B0FFAFAFAFFFADADADFFADADADFFEEEEEEFFEFEFEFFFFFFFFFFF0D95
          70FF0D9570FF2727274300000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FFFFFFFFFFFBFBFBFFFBFB
          FBFFFAFAFAFFFAFAFAFFF9F9F9FFF8F8F8FFF8F8F8FFF7F7F7FFF6F6F6FFF6F6
          F6FFF5F5F5FFF4F4F4FFF3F3F3FFF3F3F3FFF2F2F2FFF1F1F1FFFFFFFFFF0D95
          70FF0D9570FF2525253F00000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FFFFFFFFFFFEFEFEFFFEFE
          FEFFFEFEFEFFFDFDFDFFFDFDFDFFFCFCFCFFFBFBFBFFFBFBFBFFFAFAFAFFFAFA
          FAFFF9F9F9FFF8F8F8FFF8F8F8FFF7F7F7FFF6F6F6FFF6F6F6FFFFFFFFFF0D95
          70FF0D9570FF2323233C00000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FFFFFFFFFFFFFFFFFFFFFF
          FFFFCBCBCBFFCBCBCBFFCBCBCBFFCACACAFFC8C8C8FFC8C8C8FFC7C7C7FFC5C5
          C5FFC4C4C4FFC3C3C3FFC1C1C1FFC0C0C0FFFAFAFAFFFAFAFAFFFFFFFFFF0D95
          70FF0D9570FF2121213800000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FFE8F5F2FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFFFFE8F5F2FF0D95
          70FF0D9570FF1E1E1E3400000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FF49AF93FFCCE9E1FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFCCD5F8FF6C87EAFF234AE0FF6C87EAFFCCD5F8FFDFF1ECFF49AF93FF0D95
          70FF0D9570FF1C1C1C3000000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FF0D9570FF0D9570FF0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF09644CFFBAD0
          CAFF6C87EAFF153FDEFFFFFFFFFF153FDEFF6C87EAFFBAD0CAFF09644CFF0D95
          70FF0D9570FF1A1A1A2D00000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF0D9570FF0D9570FF0D9570FF0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF085842FFF5F8
          F8FF234AE0FFFFFFFFFFFFFFFFFFFFFFFFFF234AE0FFF5F8F8FF085842FF0D95
          70FF0D9570FF1818182900000000000000000000000000000000000000000000
          00000000000000000000000000000D9570FF41CBAFFF41CBAFFF41CBAFFF41CB
          AEFF41CBAFFF41CBAFFF41CBAEFF41CBAFFF41CBAEFF41CBAEFF157059FFBAD0
          CAFF6C87EAFF153FDEFF153FDEFF153FDEFF6C87EAFFBAD0CAFF15705AFF41CB
          AFFF0D9570FF1414142200000000000000000000000000000000000000000000
          00000000000000000000000000000C8967EA32BB9CFF32BB9CFF32BB9CFF32BC
          9DFF32BC9DFF32BC9DFF32BC9DFF32BC9DFF32BB9CFF32BC9DFF1E8B71FF6596
          89FFC6D1F4FF6C87EAFF234AE0FF6C87EAFFC6D1F4FF659689FF1E8B71FF32BB
          9CFF0E8A68ED0B0B0B1200000000000000000000000000000000000000000000
          0000000000000000000000000000074F3B87169F7BFF22AB8AFF23AC8BFF23AC
          8BFF23AC8BFF23AC8AFF23AC8BFF23AC8BFF23AC8BFF23AC8AFF20A182FF1274
          5BFF659689FFBAD0CAFFF5F8F8FFBAD0CAFF659689FF12745BFF1FA081FF169F
          7BFF0B533F8E0101010100000000000000000000000000000000000000000000
          000000000000000000000000000000040306074D3A840C8564E40D9570FF0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0C8D
          6AFF0B7759FF09644CFF085842FF09644CFF0B7759FF0C8D6AFF0C8564E4074D
          3A84000403060000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36100000424D3610000000000000360000002800000020000000200000000100
          2000000000000010000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000010101040405051506090824090C
          0C310A0E0E3A0B100F3F0A0E0E3A090C0C310609082404050515010101040000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000060D1025133547721A526FAC1F648CD12272
          A0EE2378A9FE22719EEE1E638AD11A506EAC1437487E0D17194A080B0B2E0406
          0618000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000102020713394D7720658CCF2690C1FF28A0CFFF29AEDCFF2AB9
          E6FF2DBFEBFF2DBBE5FF2DAEDBFF2A9FCDFF278CBBFF1E5F84CB163C4F860B10
          0F3F060908240102020700000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000061218231B5271A82790C2FE29A8D7FF2BBFECFF2BC0ECFF2DC1ECFF2EC1
          EDFF30C1EDFF31C2EDFF33C3EEFF36C4EEFF37C3EDFF32A9D5FF298AB9FE1A4F
          6DAA0F1E2456070A092801020207000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000612
          18221D5B7CB6289BCCFF2AB7E4FF2BC0ECFF2CC0ECFF2DC1EDFF2FC2ECFF75AC
          9EFFCB8F3BFFCC8F3BFF79AD9FFF39C5EFFF3CC7EFFF3EC8EFFF3DBDE5FF3097
          C5FF1B5676B60F1E245606090824000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000010101051B53
          72A5299CCEFF2BBBE8FF2CC1ECFF2DC1EDFF2FC1EDFF31C2EDFF32C3EEFFCC8F
          3BFFFD7E00FFFD7E00FFCD903BFF3EC7F0FF41C9F0FF44CAF1FF46CAF1FF46C5
          ECFF3399C6FF1A506DAA0B100F3F040606180000000000000000000000000000
          000000000000000000000000000000000000000000000000000013394E722895
          C9FE2BB8E6FF2EC1EDFF24B3C3FF16A08FFF16A08FFF28B4C3FF36C4EFFFCD90
          3BFFFD7E00FFFD7E00FFCE903BFF44C9F0FF46CBF1FF49CBF2FF4CCDF2FF4FCD
          F2FF4BC2E8FF308FBDFE163C5086080B0B2E0101010400000000000000000000
          0000020202032020203D353535653B3B3B713C3C3C733B4245852D769FE32BAD
          DCFF2EC2EDFF31C2EDFF16A08FFF0D9570FF0D9570FF18A18FFF3BC6EFFF7EAF
          9FFFCE903BFFCF913CFF82B1A1FF49CBF2FF419EB5FF366269FF376369FF47A0
          B7FF57D1F5FF46B2DBFF1E6187CB0D17194A0405051500000000000000000004
          030614604BA6118C6BF10D9570FF0D9570FF0D9470FF198C89FF2A9ACFFF30C2
          EDFF32C3EEFF34C4EEFF17A18FFF0D9570FF0D9570FF19A190FF40C8F0FF43C9
          F0FF46CBF1FF48CBF2FF4BCCF2FF4ECEF3FF376269FF2E3F3CFF2E3F3CFF3963
          6AFF5ED3F6FF60D4F5FF3694C2FF1537497E060908240000000000000000074F
          3B870D9570FF0D9570FF0D9570FF0D9570FF0F906DFF1F8B9EFF2EA9DBFF33C3
          EEFF36C4EFFF38C5EFFF2BB6C5FF19A18FFF1AA290FF31B8C6FF45CAF1FF48CB
          F2FF4ACCF2FF4ECEF3FF50CEF3FF54CFF4FF386369FF2E3F3CFF2E3F3CFF3A64
          6AFF62D6F7FF66D6F7FF49ADD6FF1B5271AC090C0C3100000000000000000C89
          67EA0D9570FF51B398FFE8F5F2FFFFFFFFFFEBECECFF53A1CDFF32B6E4FF38C5
          EEFF3BC6EFFF3DC7EFFF3FC8EFFF42C9F0FF45CAF1FF47CBF1FF4BCCF1FF4ECD
          F2FF50CFF3FF54D0F4FF57D1F4FF59D2F4FF4DA2B8FF3A646AFF3B646AFF53A4
          B9FF68D8F7FF6CD9F8FF5CC2E6FF20668FD10A0E0E3A00000000000000000D95
          70FF0D9570FFE5F4F0FFFFFFFFFFFFFFFFFFE3E5E5FF3996CBFF38C0EBFF2988
          F1FF133AF4FF133AF4FF2F8AF2FF48CBF2FF4ACCF2FF4DCDF3FF50CEF3FF53D0
          F3FF56D1F4FF59D2F4FF5CD3F5FF5FD5F6FF62D5F7FF66D7F6FF69D8F8FF6BD9
          F8FF6EDAF8FF72DBF9FF6CD3F3FF2377A7EE0B100F3F00000000000000000D95
          70FF0D9570FFFFFFFFFFFFFFFFFFFFFFFFFFDDE0E0FF2B91CAFF3FC6F0FF133A
          F4FF040BF5FF040BF5FF153BF4FF4DCDF3FF50CEF3FF53D0F3FF56D0F4FF59D2
          F5FF5CD3F5FF5FD4F6FF62D6F7FF65D6F7FF68D7F7FF6BD8F8FF56C0FBFF399F
          FEFF399FFEFF5CC2FCFF78DEF9FF2680B5FE0A0E0E3A00000000000000000D95
          70FF0D9570FFFFFFFFFFFFFFFFFFFFFFFFFFDADDDDFF3A98CDFF41C4EDFF153A
          F4FF040BF5FF040BF5FF173BF5FF52CFF4FF56D0F4FF58D1F5FF5CD3F5FF5ED4
          F6FF61D5F6FF65D6F7FF67D7F7FF6AD9F8FF6EDAF8FF71DAF9FF399FFEFF268B
          FFFF268BFFFF3BA0FEFF75D7F5FF2379ABEE090C0C3100000000000000000D95
          70FF0D9570FFFFFFFFFFFFFFFFFFFFFFFFFFDDDFDFFF53A2CFFF3DB6E3FF348C
          F4FF173BF5FF173BF5FF3A8FF4FF58D2F5FF5CD2F5FF5ED3F5FF61D5F6FF58C8
          EDFF47B0DDFF56C1E9FF69D5F6FF70DBF9FF73DCF9FF76DDFAFF3BA0FEFF268B
          FFFF268BFFFF3CA0FEFF6BCAEBFF206B94D10609082400000000000000000D95
          70FF0D9570FFFFFFFFFFFFFFFFFFFFFFFFFFE1E4E3FF88B9D3FF2C94CEFF4EC9
          F0FF54D0F4FF58D1F5FF5AD3F5FF5ED4F5FF61D5F6FF55C4EBFF3298CEFF4295
          C3FF61A1C3FF5F9FC2FF2C8DC5FF57BDE5FF78DEFBFF7BDFFBFF61C4FDFF3CA0
          FEFF3DA0FEFF65C5FEFF5AB8DFFF1C5575AC0405051500000000000000000D95
          70FF0D9570FFFFFFFFFFFFFFFFFFFFFFFFFFEDEEEEFFCED6D7FF3A97CDFF2D96
          CFFF42B0E0FF4FC0E9FF56C7EEFF4CBAE5FF359DD3FF2B90CAFF78ABC7FFD2D7
          D7FFD3D6D6FFB5BBBAFF599DC3FF3DA1D3FF7DE0FBFF80E1FCFF82E2FCFF85E3
          FDFF87E4FEFF88E3FDFF44A2D1FF133648720101010400000000000000000D95
          70FF0D9570FFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFD8DCDBFFC6D0D3FF7DB2
          CFFF54A1CDFF4A9DCCFF499CCBFF489CCBFF5DA3C9FFB9D1DDFFFEFEFEFFFFFF
          FFFFFFFFFFFFCDD2D1FF4F9AC3FF44A7D8FF82E1FCFF85E3FDFF87E3FDFF88E4
          FEFF8AE5FEFF68C4E8FF226B94D1060E11250000000000000000000000000D95
          70FF0D9570FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFE8EAEAFFDADD
          DDFFD4D8D7FFD2D6D5FFCFD3D3FFD6D9D9FFF1F2F2FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFBEC9CCFF2A8FCAFF70CFF1FF86E3FDFF88E4FDFF8BE5FEFF8CE5
          FEFF7FD9F6FF43A2D2FE143B5077000000000000000000000000000000000D95
          70FF0D9570FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFF9FAFAFF84ABBEFF3A9FD4FF88E4FDFF8AE4FEFF8BE5FEFF8DE6FFFF87DF
          FBFF51B0DDFF1C5877AD01020207000000000000000000000000000000000D95
          70FF0D9570FFFFFFFFFFFFFFFFFFFFFFFFFFCBCBCBFFCBCBCBFFCBCBCBFFCACA
          CAFFC9C9C9FFC8C8C8FFC7C7C7FFC7C7C7FFC5C5C5FFC5C5C5FFC4C4C4FFC3C3
          C3FFE0E5E6FF5B9EC2FF67C6ECFF8BE5FEFF8DE6FEFF8FE6FEFF81DAF7FF51B2
          DEFF206085BD0612182300000000000000000000000000000000000000000D95
          70FF0D9570FFFFFFFFFFFFFFFFFFFFFFFFFFCBCBCBFFCBCBCBFFCBCBCBFFCACA
          CAFFC9C9C9FFC8C8C8FFC7C7C7FFC7C7C7FFC5C5C5FFC5C5C5FFC4C4C4FFC1C1
          C1FFB3C9D3FF2A91CCFF79D4F4FF8EE7FFFF8EE6FFFF67C4EAFF389BD0FE1E59
          79B107131A270000000000000000000000000000000000000000000000000D95
          70FF0D9570FFE8F5F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F3
          F3FFAFB8BAFF5DA0C4FF48ABDBFF4AACDCFF399ED4FF2B78A2E4163E54820203
          030B000000000000000000000000000000000000000000000000000000000D95
          70FF0D9570FF49AF93FFCCE9E1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCCD5F8FF6C87EAFF234AE0FF6B86
          E7FFA8B3CEFF8AAAB1FF328CA8FF23849BFF1D8485FF2932346F000000000000
          0000000000000000000000000000000000000000000000000000000000000D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D95
          70FF0D9570FF0D9570FF09644CFFBAD0CAFF6C87EAFF153FDEFFFFFFFFFF153F
          DDFF6883E0FF9BB0AAFF115C49FF118A69FF0E936FFF2727274A000000000000
          0000000000000000000000000000000000000000000000000000000000000D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D95
          70FF0D9570FF0D9570FF085842FFF5F8F8FF234AE0FFFFFFFFFFFFFFFFFFFFFF
          FFFF234AE0FFF5F8F8FF085842FF0D9570FF0D9570FF25252546000000000000
          0000000000000000000000000000000000000000000000000000000000000D95
          70FF41CBAFFF41CBAFFF41CBAFFF41CBAEFF41CBAFFF41CBAFFF41CBAEFF41CB
          AFFF41CBAEFF41CBAEFF157059FFBAD0CAFF6C87EAFF153FDEFF153FDEFF153F
          DEFF6C87EAFFBAD0CAFF15705AFF41CBAFFF0D9570FF2020203C000000000000
          0000000000000000000000000000000000000000000000000000000000000C89
          67EA32BB9CFF32BB9CFF32BB9CFF32BC9DFF32BC9DFF32BC9DFF32BC9DFF32BC
          9DFF32BB9CFF32BC9DFF1E8B71FF659689FFC6D1F4FF6C87EAFF234AE0FF6C87
          EAFFC6D1F4FF659689FF1E8B71FF32BB9CFF0E8C69EF11111120000000000000
          000000000000000000000000000000000000000000000000000000000000074F
          3B87169F7BFF22AB8AFF23AC8BFF23AC8BFF23AC8BFF23AC8AFF23AC8BFF23AC
          8BFF23AC8BFF23AC8AFF20A182FF12745BFF659689FFBAD0CAFFF5F8F8FFBAD0
          CAFF659689FF12745BFF1FA081FF169F7BFF0E56439501010101000000000000
          0000000000000000000000000000000000000000000000000000000000000004
          0306074D3A840C8564E40D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D95
          70FF0D9570FF0D9570FF0D9570FF0C8D6AFF0B7759FF09644CFF085842FF0964
          4CFF0B7759FF0C8D6AFF0C8564E4074D3A840004030600000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36100000424D3610000000000000360000002800000020000000200000000100
          2000000000000010000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000080808000808080008080
          8000808080008080800080808000808080008080800080808000808080008080
          8000808080008080800000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000008080800000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000080800000808000000000000000
          000000000000000000000000000000000000C0C0C000C0C0C000000000000080
          8000000000008080800000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00000000000080800000808000000000000000
          000000000000000000000000000000000000C0C0C000C0C0C000000000000080
          8000000000008080800000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000000000000080800000808000000000000000
          000000000000000000000000000000000000C0C0C000C0C0C000000000000080
          8000000000008080800000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00000000000080800000808000000000000000
          0000000000000000000000000000000000000000000000000000000000000080
          8000000000008080800000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00000000000080800000808000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          8000000000008080800000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C000FFFFFF00C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000000000000080800000808000000000000000
          0000000000000000000000000000000000000000000000000000008080000080
          8000000000008080800000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00000000000080800000000000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000080
          8000000000008080800000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000080
          8000000000008080800000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C00080808000808080008080
          8000808080008080800080808000000000000080800000000000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000080
          8000000000008080800000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000080
          8000000000008080800000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00000000000080800000000000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
          0000000000008080800000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C0C0
          C000000000008080800000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C00080808000808080008080
          8000808080008080800080808000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C000FFFFFF00C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00C0C0C000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C000FFFFFF00C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00C0C0C000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C00080808000808080008080
          80008080800080808000808080008080800080808000C0C0C000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          BE000000424DBE000000000000003E0000002800000020000000200000000100
          010000000000800000000000000000000000020000000000000000000000FFFF
          FF00FFFFFFFFFFFFFFFFFFFE000FFFFC000FF000000FF000000FF000000FF000
          000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000
          000FF000001FF0003FFFF0003FFFF0003FFFF0003FFFF0003FFFF0003FFFF000
          3FFFF0003FFFF0003FFFF0003FFFF0003FFFF0003FFFF0003FFFFFFFFFFFFFFF
          FFFF}
      end>
  end
  object ilNavBarSmall: TcxImageList
    FormatVersion = 1
    DesignInfo = 22544432
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000505050E0F0F0F2E11111133111111331111113311111133111111331111
          11331111113311111133111111330F0F0F2E0505050E00000000000000000022
          1848016D4FEB007756FF007756FF007756FF007756FF007756FF007756FF0077
          56FF007756FF007756FF026D50EC0C2E256D0F0F0F2E0000000000000000006A
          4DE4B7D9CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFB7D9CFFF026C4FE91111113300000000000000000077
          56FFFFFFFFFFF7F7F7FF969696FF939393FF929292FF8F8F8FFF8D8D8DFF8B8B
          8BFF8A8A8AFFECECECFFFFFFFFFF007756FF1111113300000000000000000077
          56FFFFFFFFFFF6F6F6FFF3F3F3FFF1F1F1FFEEEEEEFFECECECFFE9E9E9FFE8E8
          E8FFE6E6E6FFE5E5E5FFFFFFFFFF007756FF1111113300000000000000000077
          56FFFFFFFFFFF8F8F8FF9E9E9EFF9C9C9CFF999999FF979797FF959595FF9292
          92FF909090FFE6E6E6FFFFFFFFFF007756FF1111113300000000000000000077
          56FFFFFFFFFFF9F9F9FFF7F7F7FFF5F5F5FFF2F2F2FFF5F5F5FFFAFAFAFFFEFE
          FEFFF9F9F9FFF0F0F0FFFFFFFFFF007756FF1111113300000000000000000077
          56FFFFFFFFFFFCFCFCFFA7A7A7FFA4A4A4FFF8F8F8FFCCD5F8FF6C87EAFF234A
          E0FF6C87EAFFCCD5F8FFFFFFFFFF007756FF1111113300000000000000000077
          56FFBDDCD3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6C87EAFF153FDEFFFFFF
          FFFF153FDEFF6C87EAFFEDF5F3FF007756FF1111113300000000000000000077
          56FF007756FF007756FF007756FF085742FFF5F8F8FF234AE0FFFFFFFFFFFFFF
          FFFFFFFFFFFF234AE0FFF5F8F8FF085742FF1111113300000000000000000077
          56FF35BB9EFF35BB9EFF35BB9EFF126D56FFBAD0CAFF6C87EAFF153FDEFF153F
          DEFF153FDEFF6C87EAFFBAD0CAFF065D46FF1111113300000000000000000077
          56FF28A98BFF2CAE90FF2CAD90FF1B846AFF659689FFC6D1F4FF6C87EAFF234A
          E0FF6C87EAFFC6D1F4FF659689FF04674CFF0F0F0F2E0000000000000000006C
          4EE7047D5CFF0E8969FF128D6EFF118667FF0C6951FF659689FFBAD0CAFFF5F8
          F8FFBAD0CAFF659689FF07644BFF026A4DEE0404040D0000000000000000001D
          153F005E44C9007756FF007756FF007756FF017353FF04674CFF065D46FF0857
          42FF065D46FF04674CFF015D44D0001D153F0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000006060611121212351414143B1414143B1414143B1414143B1414
          143B1414143B1414143B12121235060606110000000000000000000000000000
          000000221848026D50EC007756FF007756FF007756FF007756FF007756FF0077
          56FF007756FF026E50ED0E2F2672121212350000000000000000000000000000
          0000006A4DE4B7D9CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFB7D9CFFF026C4FEA1414143B0000000000000000000000000000
          0000007756FFFFFFFFFFADADADFFADADADFFADADADFFADADADFFADADADFFADAD
          ADFFADADADFFFFFFFFFF007756FF1414143B00000000000000000404040C0D0D
          0D270E7156FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2
          E2FFE2E2E2FFE2E2E2FF0E7156FF1E1E1E590404040C000000000D3329630D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D332963000000000D9570FF0D95
          70FF007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF007756FF0D9570FF0D9570FF000000000D9570FF0D95
          70FF007756FFFFFFFFFF8D968BFF8D968BFF8D968BFF8D968BFF8D968BFF8D96
          8BFF8D968BFFFFFFFFFF007756FF0D9570FF0D9570FF000000000D9570FF0D95
          70FF0E7156FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2
          E2FFE2E2E2FFE2E2E2FF0E7156FF0D9570FF0D9570FF0000000003251C3F0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF03251C3F00000000000000000000
          0000007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF007756FF1414143B0000000000000000000000000000
          0000007756FFFFFFFFFFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3
          C3FFC3C3C3FFFFFFFFFF007756FF121212350000000000000000000000000000
          0000006C4EE7BDDCD3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFBDDCD3FF016D4FEB0505050F0000000000000000000000000000
          0000001D153F005E44C9007756FF007756FF007756FF007756FF007756FF0077
          56FF007756FF005E44C9001D153F000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000060606121313133A1515154015151540151515401515
          154015151540151515401313133A060606120000000000000000000000000000
          00000000000000221848026D50EC007756FF007756FF007756FF007756FF0077
          56FF007756FF026E50ED0F312876131313390000000000000000000000000000
          000000000000006A4DE4B7D9CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFB7D9CFFF036D4FEB151515400000000000000000000000000000
          000000000000007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF007756FF151515400000000000000000000000001C1C
          1C543B3B3BB0555555FF555555FF555555FF9E9E9EFFFFFFFFFFFFFFFFFF9E9E
          9EFF555555FF555555FF555555FF414141C41C1C1C5400000000000000003B3B
          3BB0B9B9B9FFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFF555555FF555555FFEEEE
          EEFFEEEEEEFFEEEEEEFFEEEEEEFFADADADFF3B3B3BB000000000000000005555
          55FFF2F2F2FFA2A2A2FF555555FF555555FF555555FF555555FF555555FF5555
          55FF585858FF5D5D5DFF878787FFEEEEEEFF555555FF00000000000000005555
          55FFF5F5F5FF555555FFFFFFFFFF555555FFEAEAEAFFEDEDEDFFEFEFEFFFEAEA
          EAFF555555FFFFFFFFFF555555FFEEEEEEFF555555FF00000000000000005555
          55FFF5F5F5FFBABABAFF555555FF555555FF555555FF555555FF555555FF5555
          55FF555555FF555555FF9C9C9CFFEEEEEEFF555555FF00000000000000003B3B
          3BB0ADADADFFF4F4F4FFEEEEEEFFEEEEEEFFEDEDEDFF555555FF555555FFEEEE
          EEFFEEEEEEFFEEEEEEFFEEEEEEFFADADADFF3B3B3BB000000000000000001C1C
          1C543B3B3BB0555555FF555555FF555555FF9E9E9EFFFFFFFFFFFFFFFFFF9E9E
          9EFF555555FF555555FF555555FF414141C41C1C1C5400000000000000000000
          000000000000007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF007756FF1313133A0000000000000000000000000000
          000000000000006C4EE7BDDCD3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFBDDCD3FF026D50EC050505100000000000000000000000000000
          000000000000001D153F005E44C9007756FF007756FF007756FF007756FF0077
          56FF007756FF005E44C9001D153F000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000022
          1848006C4EE7007756FF007756FF007756FF007756FF007756FF007756FF0077
          56FF006C4EE7002218480000000000000000000000000000000000000000006A
          4DE4B7D9CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFB7D9CFFF026C4FEA1414143B121212350606061100000000000000000077
          56FFFFFFFFFF8A8A8AFF8A8A8AFF8A8A8AFF8A8A8AFF8A8A8AFF8A8A8AFF8A8A
          8AFFFFFFFFFF007756FF15795EED14332A721212123500000000000000000077
          56FFFFFFFFFFF8F8F8FFF5F5F5FFF3F3F3FFF0F0F0FFEEEEEEFFEBEBEBFFE9E9
          E9FFFFFFFFFF007756FFBDDCD4FF16775DEA1414143B00000000000000000077
          56FFFFFFFFFFF9F9F9FFF7F7F7FFF5F5F5FFF2F2F2FFEFEFEFFFEDEDEDFFEBEB
          EBFFFFFFFFFF007756FFFFFFFFFF168365FF1414143B00000000000000000077
          56FFFFFFFFFF8A8A8AFF8A8A8AFF8A8A8AFF8A8A8AFF8A8A8AFF8A8A8AFF8A8A
          8AFFFFFFFFFF007756FFFFFFFFFF168365FF1414143B00000000000000000077
          56FFBDDCD3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFBDDCD3FF007756FFFFFFFFFF168365FF1414143B00000000000000000077
          56FF007756FF007756FF007756FF007756FF007756FF007756FF007756FF0077
          56FF007756FF007756FFFFFFFFFF168365FF1414143B00000000000000000077
          56FF35BB9EFF35BB9EFF35BB9EFF35BB9EFF35BB9EFF35BC9EFF35BC9EFF35BC
          9EFF35BB9EFF007756FFC3DFD7FF168365FF1414143B00000000000000000077
          56FF28A98BFF2CAE90FF2CAD90FF2CAE90FF2CAE90FF2CAE90FF2CAD90FF2CAD
          90FF28A88AFF007756FF168365FF168365FF1414143B0000000000000000006C
          4EE7047D5CFF0E8969FF128D6EFF128D6DFF128D6EFF128D6EFF128D6EFF0E89
          69FF047D5CFF067F5EFF42CDB0FF168365FF1414143B0000000000000000001D
          153F005E44C9007756FF007756FF007756FF007756FF007756FF007756FF0077
          56FF128D6DFF3FC5A9FF52DBC1FF168365FF1212123500000000000000000000
          00000000000014775BE7229578FF37B498FF3DBDA1FF3DBCA1FF3DBDA1FF3DBD
          A1FF3DBDA1FF37B498FF229578FF15785DEB0505050F00000000000000000000
          0000000000000520193F116750C9168365FF168365FF168365FF168365FF1683
          65FF168365FF168365FF116750C90520193F0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000130000001A00000013000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000007000000183D3D
          3DBC555555FF3D3D3DBE0000001A000000130000001700000006000000000000
          00000000000000000000000000000000000017171745505050F13D3D3DBE5555
          55FFEEEEEEFF555555FF3D3D3DBD4B4B4BE41414145000000015000000000000
          000000000000000000000000000000000000454545CFD7D7D7FFB8B8B8FFCCCC
          CCFFFFFFFFFFCCCCCCFFB8B8B8FFD7D7D7FF454545D400000015000000000000
          000000000007000000180000001A0000001A474747D9B7B7B7FFEEEEEEFFA5A5
          A5FF555555FFA5A5A5FFEDEDEDFFB7B7B7FF464646D700000003000000000022
          1848006C4EE9007756FF007756FF007756FF0B7356FF555555FFE9E9E9FF5D5D
          5DFFCDCDCDFF5D5D5DFFECECECFF555555FE0A0A0A340000001600000000006A
          4DE4AFD1C7FFF4F3F4FFF3F3F3FFF2F2F2FF6F6F6FFFB1B1B1FFF4F4F4FFA1A1
          A1FF555555FFA1A1A1FFF4F4F4FFB1B1B1FF474747D900000015000000000077
          56FFF6F5F5FFF5F4F5FFF4F4F4FFF4F4F3FF757575FFDDDDDDFFC2C2C2FFCFCF
          CFFFEEEEEEFFCFCFCFFFC2C2C2FFDDDDDDFF444444D100000006000000000077
          56FFF6F7F6FFF5F6F6FFF5F6F6FFF4F5F5FFCFCFCFFF6A6A6AFF808080FF5555
          55FFFFFFFFFF555555FF3E3E3EC54A4A4ADE1414143C00000000000000000077
          56FFF8F8F8FFF7F6F7FFF6F6F6FFF6F6F5FFF5F5F5FFF5F5F5FFF4F4F4FF7E7E
          7EFF555555FF3F5E55FF0000001A000000000000000000000000000000000077
          56FFF8F8F9FFF8F8F8FFF7F8F7FFF7F7F7FFF6F7F6FFF6F5F6FFF5F5F6FFF5F5
          F5FFF4F5F4FF007756FF0000001A000000000000000000000000000000000077
          56FF007756FF007756FF007756FF007756FF007756FF007756FF007756FF0077
          56FF007756FF007756FF0000001A000000000000000000000000000000000077
          56FF2AAD8FFF2AAE90FF2BAE90FF2BAD90FF2BAD90FF2AAD90FF2BAE90FF2BAD
          8FFF2BAE8FFF007756FF0000001A000000000000000000000000000000000077
          56FF1D9A7CFF1D9A7BFF1D9B7CFF1C9B7CFF1C9B7CFF1C9A7BFF1C9B7CFF1D9A
          7BFF1C9B7BFF007756FF0000001800000000000000000000000000000000006C
          4EE70D8767FF128D6DFF128D6DFF128D6DFF128D6DFF128D6DFF128D6DFF128D
          6DFF0D8767FF006C4EE90000000600000000000000000000000000000000001D
          153F005E44C9007756FF007756FF007756FF007756FF007756FF007756FF0077
          56FF005E44C9001D153F00000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000203030C0507071E080B0A2C0A0E0D370A0E
          0D37080B0A2C0507071E0203030C000000000000000000000000000000000000
          000000000000000000000B202B47113D5C980E4777CF074680F106437DF10B43
          71CF103B599D0F263163090C0C31040606180000000000000000000000000000
          00000000000010364E75136192E21983B9FF24A1D1FF2DB8E5FF30B9E4FF29A0
          CFFF1B7BB0FF0E5084E310364D8A0A0E0D380406061800000000000000000000
          00000F364F6E1978AFF625A2D4FF30C2EDFF32C3EDFFFD7E00FFFD7E00FF40C8
          F0FF44CAF1FF33A0CEFF146095F610364D8A090C0C310203030C00000000081D
          29341B6FA1DE28A7D8FF009172FF009172FF39C6EEFFFD7E00FFFD7E00FF48CB
          F1FF2E3F3CFF2E3F3CFF3EA5D0FF135386E30F2631630507071E000000001344
          6280269ACFFF35C4EDFF009172FF009172FF41C8F0FF46CAF1FF4BCCF2FF50CE
          F3FF2E3F3CFF2E3F3CFF61D4F6FF2F85B6FF103C5A9D080B0A2C000000001D67
          94C031B1E0FF3BC6EFFF40C8EFFF44C9F1FF49CBF2FF4FCEF3FF54CFF3FF5AD1
          F5FF5FD4F6FF65D6F6FF6AD8F7FF52B1D9FF0D4775CF0A0E0D37000000002482
          B9ED3CC2ECFF040BF5FF040BF5FF4DCDF2FF52CFF3FF57D1F4FF5DD3F6FF63D5
          F6FF68D7F7FF268BFFFF268BFFFF6FD1F1FF0A4D86F10A0E0D37000000002686
          BDED44C5EEFF040BF5FF040BF5FF56D0F4FF5CD3F5FF61D5F5FF66D6F6FF4DB1
          DBFF6DD6F5FF268BFFFF268BFFFF77D5F3FF0D538CF1080B0A2C00000000206D
          9AC044BBE6FF54D0F4FF5AD2F4FF5FD3F6FF65D6F6FF4DB5E0FF227EB9FF1C76
          B2FF50AED8FF7EDFFBFF82E1FBFF65BEE1FF135280CF0507071E00000000123F
          586E2F98D1FF53C6EDFF59CAEFFF3FA7D8FF2A8EC8FF227BB0EA16507397227F
          BBFF7FDFFAFF85E3FDFF89E4FDFF499FCCFF144361980203030C000000000001
          01010E32465821719EC62274A3CC1A5A7F9F1447647E02070A0C1E6D9BCA4DAD
          DAFF88E3FCFF8BE5FDFF6BC3E6FF2774A2E20B212D4700000000000000000000
          0000000000000000000000000000000000000000000002090C0F288BC7FC75D1
          F1FF8DE5FDFF6DC7EAFF3890C2F6113A52750000000000000000000000000000
          0000000000000000000000000000000000000000000000000000185273903297
          CEFF40A1D4FF2B7EAEDB113A526E000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000040E
          1419071A242D081C283200000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000070A09280C11
          10430141ACFF0B2E60B61D282D8A17211F82151C1B73121817620F1413510C10
          0F41090C0C310608082104050514000000000000000000000000000000000000
          0000001B47696794F6FF6794F6FF5B83DAE22D416C7000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000587FD3DB6794F6FF6794F6FF0C5BCDFF0141ACFF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000314675796794F6FF6794F6FF0B45BAFF0C5BCDFF0141ACFF0000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000121A2B2D3863F1FF0141ACFF6794F6FF0B45BAFF0C5BCDFF0141
          ACFF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000013DA2F03863F1FF3E71EFFF6794F6FF0B45BAFF0C5B
          CDFF0141ACFF0000000000000000000000000000000000000000000000000000
          00000000000000000000000000000141ACFF3863F1FF3E71EFFF6794F6FF0B45
          BAFF0C5BCDFF0141ACFF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000141ACFF3863F1FF3E71EFFF6794
          F6FF0B45BAFF0C5BCDFF0141ACFF000000000000000000000000000000000000
          000000000000000000000000000000000000000000000141ACFF3863F1FF3E71
          EFFF6794F6FF0B45BAFFFFFFFFFF2E7857FF0000000000000000000000000000
          00000000000000000000000000000000000000000000000000000141ACFF3863
          F1FF3E71EFFFFFFFFFFF3C906FFF429664FF286443CF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000141
          ACFFFFFFFFFF69B2A5FF8FCDAEFF429664FF429664FF1535236E000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000276F65FF70BD99FF70BD99FF8FCDAEFF317B52FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000286443CF70BD99FF317B52FF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000112B1D59000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end>
  end
  object ilLinkDesigner: TcxImageList
    FormatVersion = 1
    DesignInfo = 22544400
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000006060611121212351414143B1414143B1414143B1414143B1414
          143B1414143B1414143B12121235060606110000000000000000000000000000
          000000221848026D50EC007756FF007756FF007756FF007756FF007756FF0077
          56FF007756FF026E50ED0E2F2672121212350000000000000000000000000000
          0000006A4DE4B7D9CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFB7D9CFFF026C4FEA1414143B0000000000000000000000000000
          0000007756FFFFFFFFFFADADADFFADADADFFADADADFFADADADFFADADADFFADAD
          ADFFADADADFFFFFFFFFF007756FF1414143B00000000000000000404040C0D0D
          0D270E7156FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2
          E2FFE2E2E2FFE2E2E2FF0E7156FF1E1E1E590404040C000000000D3329630D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D332963000000000D9570FF0D95
          70FF007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF007756FF0D9570FF0D9570FF000000000D9570FF0D95
          70FF007756FFFFFFFFFF8D968BFF8D968BFF8D968BFF8D968BFF8D968BFF8D96
          8BFF8D968BFFFFFFFFFF007756FF0D9570FF0D9570FF000000000D9570FF0D95
          70FF0E7156FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2E2FFE2E2
          E2FFE2E2E2FFE2E2E2FF0E7156FF0D9570FF0D9570FF0000000003251C3F0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D9570FF0D95
          70FF0D9570FF0D9570FF0D9570FF0D9570FF03251C3F00000000000000000000
          0000007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF007756FF1414143B0000000000000000000000000000
          0000007756FFFFFFFFFFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3
          C3FFC3C3C3FFFFFFFFFF007756FF121212350000000000000000000000000000
          0000006C4EE7BDDCD3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFBDDCD3FF016D4FEB0505050F0000000000000000000000000000
          0000001D153F005E44C9007756FF007756FF007756FF007756FF007756FF0077
          56FF007756FF005E44C9001D153F000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000505050E0F0F0F2E11111133111111331111113311111133111111331111
          11331111113311111133111111330F0F0F2E0505050E00000000000000000022
          1848016D4FEB007756FF007756FF007756FF007756FF007756FF007756FF0077
          56FF007756FF007756FF026D50EC0C2E256D0F0F0F2E0000000000000000006A
          4DE4B7D9CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFB7D9CFFF026C4FE91111113300000000000000000077
          56FFFFFFFFFFF7F7F7FF969696FF939393FF929292FF8F8F8FFF8D8D8DFF8B8B
          8BFF8A8A8AFFECECECFFFFFFFFFF007756FF1111113300000000000000000077
          56FFFFFFFFFFF6F6F6FFF3F3F3FFF1F1F1FFEEEEEEFFECECECFFE9E9E9FFE8E8
          E8FFE6E6E6FFE5E5E5FFFFFFFFFF007756FF1111113300000000000000000077
          56FFFFFFFFFFF8F8F8FF9E9E9EFF9C9C9CFF999999FF979797FF959595FF9292
          92FF909090FFE6E6E6FFFFFFFFFF007756FF1111113300000000000000000077
          56FFFFFFFFFFF9F9F9FFF7F7F7FFF5F5F5FFF2F2F2FFF5F5F5FFFAFAFAFFFEFE
          FEFFF9F9F9FFF0F0F0FFFFFFFFFF007756FF1111113300000000000000000077
          56FFFFFFFFFFFCFCFCFFA7A7A7FFA4A4A4FFF8F8F8FFCCD5F8FF6C87EAFF234A
          E0FF6C87EAFFCCD5F8FFFFFFFFFF007756FF1111113300000000000000000077
          56FFBDDCD3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6C87EAFF153FDEFFFFFF
          FFFF153FDEFF6C87EAFFEDF5F3FF007756FF1111113300000000000000000077
          56FF007756FF007756FF007756FF085742FFF5F8F8FF234AE0FFFFFFFFFFFFFF
          FFFFFFFFFFFF234AE0FFF5F8F8FF085742FF1111113300000000000000000077
          56FF35BB9EFF35BB9EFF35BB9EFF126D56FFBAD0CAFF6C87EAFF153FDEFF153F
          DEFF153FDEFF6C87EAFFBAD0CAFF065D46FF1111113300000000000000000077
          56FF28A98BFF2CAE90FF2CAD90FF1B846AFF659689FFC6D1F4FF6C87EAFF234A
          E0FF6C87EAFFC6D1F4FF659689FF04674CFF0F0F0F2E0000000000000000006C
          4EE7047D5CFF0E8969FF128D6EFF118667FF0C6951FF659689FFBAD0CAFFF5F8
          F8FFBAD0CAFF659689FF07644BFF026A4DEE0404040D0000000000000000001D
          153F005E44C9007756FF007756FF007756FF017353FF04674CFF065D46FF0857
          42FF065D46FF04674CFF015D44D0001D153F0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000E0000001C00000029000000290000002900000017000000000000
          0000000000170000002900000029000000290000001C0000000E000000001C1C
          1C543B3B3BB9555555FF555555FF555555FF313131A400000029000000293131
          31A4555555FF555555FF555555FF3B3B3BBD1C1C1C6F0000001C000000003B3B
          3BB0B9B9B9FFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFF555555FF555555FFEEEE
          EEFFEEEEEEFFEEEEEEFFEEEEEEFFADADADFF3B3B3BBD00000029000000005555
          55FFF2F2F2FFA2A2A2FF555555FF555555FF555555FF555555FF555555FF5555
          55FF585858FF5D5D5DFF878787FFEEEEEEFF555555FF00000029000000005555
          55FFF5F5F5FF555555FF00000000555555FFEAEAEAFFEDEDEDFFEFEFEFFFEAEA
          EAFF555555FF00000000555555FFEEEEEEFF555555FF00000029000000005555
          55FFF5F5F5FFBABABAFF555555FF555555FF555555FF555555FF555555FF5555
          55FF555555FF555555FF9C9C9CFFEEEEEEFF555555FF0000001C000000003B3B
          3BB0ADADADFFF4F4F4FFEEEEEEFFEEEEEEFFEDEDEDFF555555FF555555FFEEEE
          EEFFEEEEEEFFEEEEEEFFEEEEEEFFADADADFF3B3B3BB90000000E000000001C1C
          1C543B3B3BB0555555FF555555FF555555FF3131319200000000000000003131
          3192555555FF555555FF555555FF3B3B3BB01C1C1C5400000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000000FF
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000000FF
          FF0000FFFF0000000000000000000000000000000000000000000000000000FF
          FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
          FF0000FFFF0000FFFF00000000000000000000000000000000000000000000FF
          FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
          FF0000FFFF0000FFFF0000FFFF000000000000000000000000000000000000FF
          FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
          FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000000FF
          FF0000FFFF000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000000FF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000FFFF0000FFFF0000FFFF0000FF3F0000FF1F0000000F00000007
          00000003000000070000000F0000FF1F0000FF3F0000FFFF0000FFFF0000FFFF
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000000FF
          000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000000
          00000000000000000000000000000000000000000000000000000000000000FF
          0000000000000000000000000000000000000000000000FF000000FF000000FF
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000FF000000FF000000FF
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000FF000000FF000000FF
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000FF000000FF000000FF
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000FF000000FF000000FF000000FF000000FF
          000000FF000000FF000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000FF000000FF000000FF000000FF
          000000FF00000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000FF000000FF000000FF
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000FF00000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000FFFF0000FFFF0000807F0000003F0000001F00003C1F0000FC1F
          0000F0070000F0070000F80F0000FC1F0000FE3F0000FF7F0000FFFF0000FFFF
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000006060611121212351414143B1414143B1414143B1414143B1414
          143B1414143B1414143B12121235060606110000000000000000000000000000
          000000221848026D50EC007756FF007756FF007756FF007756FF007756FF0077
          56FF007756FF026E50ED0E2F2672121212350000000000000000000000000000
          0000006A4DE4B7D9CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFB7D9CFFF026C4FEA1414143B0000000000000000000000000000
          0000007756FFFFFFFFFF434343FFFFFFFFFFA6A6A6FFA6A6A6FFA6A6A6FFA6A6
          A6FFA6A6A6FFFFFFFFFF007756FF1414143B0000000000000000000000000000
          0000007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF007756FF1414143B0000000000000000000000000000
          0000007756FF007756FF007756FF007756FF007756FF007756FF007756FF0077
          56FF007756FF007756FF007756FF1414143B0000000000000000000000000000
          0000007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF007756FF1414143B0000000000000000000000000000
          0000007756FFFFFFFFFF434343FFFFFFFFFFA6A6A6FFA6A6A6FFA6A6A6FFA6A6
          A6FFA6A6A6FFFFFFFFFF007756FF1414143B0000000000000000000000000000
          0000007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF007756FF1414143B0000000000000000000000000000
          0000007756FF007756FF007756FF007756FF007756FF007756FF007756FF0077
          56FF007756FF007756FF007756FF1414143B0000000000000000000000000000
          0000007756FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF007756FF1414143B0000000000000000000000000000
          0000007756FFFFFFFFFF434343FFFFFFFFFFA6A6A6FFA6A6A6FFA6A6A6FFA6A6
          A6FFA6A6A6FFFFFFFFFF007756FF121212350000000000000000000000000000
          0000006C4EE7BDDCD3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFBDDCD3FF016D4FEB0505050F0000000000000000000000000000
          0000001D153F005E44C9007756FF007756FF007756FF007756FF007756FF0077
          56FF007756FF005E44C9001D153F000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end>
  end
  object ilToolBar: TcxImageList
    FormatVersion = 1
    DesignInfo = 17563805
  end
  object ilTreeView: TcxImageList
    FormatVersion = 1
    DesignInfo = 19923101
  end
  object ilToolBarDisabled: TcxImageList
    FormatVersion = 1
    DesignInfo = 17563837
  end
  object pmGroupItemClasses: TPopupMenu
    Images = ilActions
    Left = 56
    Top = 248
  end
  object ilPreviewSmall: TcxImageList
    FormatVersion = 1
    DesignInfo = 22544464
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00C0A8900070584000705040006048300060483000604830006048
          3000604830006048300060483000604830006048300060483000FF00FF00FF00
          FF00FF00FF00C0A89000FFF8F000F0E0E000F0D8C000E0D0C000E0C8B000E0C0
          B000E0B8A000E0B0A000D0A89000D0A09000D0A0800060483000FF00FF00FF00
          FF00FF00FF00C0A8A000FFF8FF00FFF8F000FFF8F000F0F0E000F0E8E000F0E0
          D000F0D8D000F0D8C000F0D0C000F0D0C000D0A8900060483000708890007078
          800060707000C0A8A000FFFFFF00C0B0A000B0A09000B0989000B0988000A090
          8000F0E0D000F0D8D000F0D8C000F0D0C000E0B0A0006048300070889000A0E0
          F00070D0F000C0B0A000FFFFFF00D0C0B000C0B0A000C0A8A000C0A89000B0A0
          9000B0A09000F0E0D000F0D8D000F0D8C000E0B0A0006048300080889000B0E8
          F00090E8FF00C0B0A000FFFFFF00FFFFFF00FFF8FF00FFF8F000FFF8F000FFF0
          F000F0E8E000F0E8E000F0E0D000F0D8D000E0B8A000604830008090A000B0E8
          F000A0E8FF00D0B0A000FFFFFF00FFFFFF00FFFFFF00FFF8FF00FFF8FF00FFF8
          F000FFF0F000FFE8E0002048D0002040A000E0C0B000604830008090A000B0F0
          FF00B0F0FF00D0B8A000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF8FF00FFF8
          FF00FFF8F000FFF0F0004060F0002048D000F0D0D000705040008098A000C0F0
          FF00B0F0F000D0B8A000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFF8FF00FFF8F000FFF8F000FFF0F000F0E8E000705840008098A000C0F0
          FF00B0F0FF00D0B8A000D0B8A000D0B8A000C0B0A000C0B0A000C0B0A000C0A8
          A000C0A8A000C0A8A000C0A89000C0A89000C0A89000C0A8900090A0A000C0F0
          FF00B0F0FF00B0F0FF00B0F0F000A0F0FF0090E8FF0090E0FF0080E0FF0070D0
          FF0060D0F00050C0F00050B8F0002098D00060708000FF00FF0090A0B000C0F0
          FF00C0F0FF00C0F0FF00C0F0FF00B0F0FF00B0F0FF00A0E8FF0090E8FF0090E0
          FF0080D8FF0070D0FF0070C8F00060B8F00060708000FF00FF0090A0B00090A0
          B00090A0B00090A0B00090A0B00090A0B00090A0A0009098A0008098A0008098
          A0008098A0008098A0008098A0008090A000FF00FF00FF00FF0090A8B000B0E8
          F000B0F0FF00B0F0FF00B0F0F00090E0F00090A0B000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0090A8
          B00090A8B00090A8B00090A8B00090A8B000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF0073655700403020004030200040302000503830005038
          300065574900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00B19D9700E1CBB400FFF0D000FFFFE000FFF0D000FFE8C000FFD8
          A000F0D0B000735E4900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00A0888000FFFFFF00FFF8FF00FFF8F000FFF0E000FFF0D000FFE8
          C000FFE0C00080685000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00B4ADA500F0F8E00070B860000060000000480000004800003090
          4000F0D8B000B0907000917B7000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00BDACA700E1DAD200D0F0D00020982000E0D0D000FFFFFF00B0C090001070
          2000C0C89000E0B8A00065574900FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00A58F8700F0F0F000F0F8F00080D8800020982000FFFFFF00308030001070
          1000FFE0C000F0D0B00060483000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00B0989000FFFFFF00FFFFFF00FFFFFF0020C020000068000000601000C0E0
          A000FFF0D000FFE0B00070605000FF00FF00FF00FF00FF00FF00FF00FF00BDAC
          A700C0B0B000FFFFFF00FFFFFF00FFFFFF00E0FFD00010B0100090D89000FFFF
          F000FFF0D000FFE8C000A088700091877D00FF00FF00FF00FF00FF00FF00A58F
          8700E0D0D000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF8
          E000FFF0E000FFF0D000D0B0900070635600FF00FF00FF00FF00FF00FF00A088
          8000F0F0F000FFF8FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF8
          F000FFF0E000FFF0E000F0D0B0005A4B3C00FF00FF00FF00FF00FF00FF00A58F
          8700A0888000A090800090888000A0908000A0908000A0908000A0908000A090
          8000A0888000A08880007060500050403000FF00FF00FF00FF00FF00FF00C0B2
          A5008F7A730080706000B0A09000E0D8D000F0F0F000FFF8F000FFFFFF00FFFF
          FF00F0F0F000D0C8C000E0D0D0007B6F6300FF00FF00FF00FF00FF00FF00FF00
          FF009F938700A4907D00C0C0C000F0F0F000FFF8FF00FFFFFF00FFFFFF00FFFF
          FF00E0E0E000D0C0C00093816F00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00A7A1910096877800907870009080700090787000907870008070
          60007058400070635600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF005859
          5800006000000060000000600000006000000060000000600000006000000060
          00000060000000600000006000000060000000600000FF00FF001C201C00FFFF
          FF008BD9A0000098000000980000009800000098000000980000009800000098
          00000098000000980000009800000098000000600000FF00FF0098ACB3001C20
          1C00808080008BD9A00081D7990077D592006CD38A0061D1830056CF7B004BCD
          730040CB6B0035C9630030C860000098000000600000FF00FF001C201C00FFFF
          FF009FDDAF0095DBA7008BD9A00081D7990077D592006CD38A0061D183002025
          2000202520002025200035C963000098000000600000FF00FF0098ACB3001C20
          1C00808080009FDDAF0095DBA7008BD9A00081D7990077D592006CD38A0061D1
          830056CF7B004BCD730040CB6B000098000000600000FF00FF001C201C00FFFF
          FF00B4E1BD00A9DFB6009FDDAF0095DBA7008BD9A00081D7990077D592006CD3
          8A0061D1830056CF7B004BCD73000098000000600000FF00FF0098ACB3001C20
          1C0080808000B9E2C100AFE0BA00A4DEB2009ADCAB0090DAA40086D89C0077D5
          92006CD38A0061D1830056CF7B000098000000600000FF00FF001C201C00FFFF
          FF00BEE3C400BEE3C400B9E2C100AFE0BA00A4DEB2009ADCAB0090DAA40086D8
          9C007CD6950072D48E0067D287000098000000600000FF00FF0098ACB3001C20
          1C0080808000BEE3C400BEE3C400B9E2C100AFE0BA00A4DEB2009ADCAB0090DA
          A40086D89C007CD6950072D48E000098000000600000FF00FF001C201C00FFFF
          FF00BEE3C400BEE3C40000980000006000000060000000600000006000000060
          00000060000086D89C007CD695000098000000600000FF00FF0098ACB3001C20
          1C0080808000BEE3C4000098000030C860005FD0810088D89E00ACDFB700BEE3
          C4000060000090DAA40086D89C000098000000600000FF00FF001C201C00FFFF
          FF00BEE3C400BEE3C4000098000030C8600030C860005FD0810088D89E009ADC
          AB00006000009ADCAB0090DAA4000098000000600000FF00FF0098ACB3001C20
          1C0080808000BEE3C40000980000009800000098000000980000009800000098
          000000980000A4DEB2009ADCAB000098000000600000FF00FF001C201C00FFFF
          FF00BEE3C400BEE3C400BEE3C400BEE3C400BEE3C400BEE3C400BEE3C400BEE3
          C400BEE3C400B4E1BD00A9DFB6000098000000600000FF00FF0098ACB3001C20
          1C0080808000BEE3C400BEE3C400BEE3C400BEE3C400BEE3C400BEE3C400BEE3
          C400BEE3C400BEE3C400B4E1BD00A9DFB60000600000FF00FF00FF00FF000098
          0000009800000098000000980000009800000098000000980000009800000098
          00000098000000980000009800000098000000980000FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0080A8C00050708000407090003068800030688000306080003058
          7000305870003058700030587000305060003050600030486000FF00FF00FF00
          FF00FF00FF0080A8C000D0FFFF00A0E8FF0080E0F00080D8F00070D0F00070D0
          F00070C8F00070C8F00070C8F00060C8F00060C0F00030506000FF00FF00FF00
          FF00FF00FF0080A8C000C0E8F000B0F8FF0090F0FF0090F0FF0090F0FF0090F0
          FF0090F0FF0090F0FF0090F0FF0080E0FF0060B8E00030506000708890007078
          80006070700080B0C00080B8D00090E0F00090F8FF0090F0FF0080E8FF0070E0
          FF0080E8FF0080E8FF0090F0FF0070D8F0004088B0004058600070889000A0E0
          F00070D0F00090B0C000B0E8F00060B8D00080E8FF0070E0F00050B0E00030A0
          D0003090C00070D0F00070D8F0004098C00060C0E0004058700080889000B0E8
          F00090E8FF0090B8D000D0FFFF00A0E8F00070C8F00050B0E00080D8F00080E8
          FF0080E8F00040A0C00050C0E00080E0F00070C8F000406070008090A000B0E8
          F000A0E8FF0090C0D000D0FFFF0090E8F00060B8E00080E0F000A0F8FF0090F0
          FF0090F0FF0090E8FF0050A8D00080E0F00070D0F000406070008090A000B0F0
          FF00B0F0FF0090C0D000C0F8FF0060C0E00090E0F000A0F8FF00A0F8FF00A0F8
          FF00A0F8FF0090F0FF0090E8FF0050A0C00060C0E000506870008098A000C0F0
          FF00B0F0F00090C8D000A0E0F000E0FFFF00E0FFFF00E0FFFF00E0FFFF00E0FF
          FF00E0FFFF00D0FFFF00D0FFFF00B0F8FF004098C000507080008098A000C0F0
          FF00B0F0FF0090C8D00090C8D00090C8D00090C8D00090C0D00090C0D00090B8
          D00090B8C00080B0C00080B0C00080A8C00080A8C00080A8C00090A0A000C0F0
          FF00B0F0FF00B0F0FF00B0F0F000A0F0FF0090E8FF0090E0FF0080E0FF0070D0
          FF0060D0F00050C0F00050B8F0002098D00060708000FF00FF0090A0B000C0F0
          FF00C0F0FF00C0F0FF00C0F0FF00B0F0FF00B0F0FF00A0E8FF0090E8FF0090E0
          FF0080D8FF0070D0FF0070C8F00060B8F00060708000FF00FF0090A0B00090A0
          B00090A0B00090A0B00090A0B00090A0B00090A0A0009098A0008098A0008098
          A0008098A0008098A0008098A0008090A000FF00FF00FF00FF0090A8B000B0E8
          F000B0F0FF00B0F0FF00B0F0F00090E0F00090A0B000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0090A8
          B00090A8B00090A8B00090A8B00090A8B000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF0000436E0000436E0000436E0000436E0000436E0000436E0000436E000043
          6E0000436E0000436E0000436E0000436E00FF00FF00FF00FF00FF00FF000090
          C80077D6EF000290C9000290C9000290C9000290C9000290C9000290C9000290
          C9000290C9000290C9000290C9000290C90000436E00FF00FF00FF00FF000090
          C800D0BCAF006947310069473100694731006947310069473100694731006947
          31006947310069473100694731000290C90000436E00FF00FF00FF00FF000090
          C800CFBBAD00F5F0ED00F1EAE600EDE4DF00E9DED800E5D8D100E1D2CA00DDCC
          C200DBC9BF00DBC9BF00694731000290C90000436E00FF00FF00FF00FF000090
          C800CEBAAC00FBF9F800F7F3F100CECCE4004F5CCF00D9D2DA00E7DBD500E3D5
          CD00DFCFC600DBC9BF00694731000290C90000436E00FF00FF00FF00FF000090
          C800CDB9AA00FFFFFF00FBF9F8005D6AD6000017C6005662D000EBE1DC00E7DB
          D500E3D5CD00DFCFC600694731000290C90000436E00FF00FF00FF00FF000090
          C800CCB7A900FFFFFF00C4C9F200041BC700616DD700041AC700ACADDA00EBE1
          DC00E7DBD500E3D5CD00694731000290C90000436E00FF00FF00FF00FF000090
          C800CBB6A800FFFFFF006472DC00283BCF00F4F3F7008F97DF001B2ECA00DDD8
          E000EBE1DC00E7DBD500694731000290C90000436E00FF00FF00FF00FF000090
          C800CAB5A600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBF9F8006C78D9004150
          D000ECE5E200EBE1DC00694731000290C90000436E00FF00FF00FF00FF000090
          C800CAB5A600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBF9F8006C78
          D9005F6BD400EFE7E200694731000290C90000436E00FF00FF00FF00FF000090
          C800CAB5A600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBF9
          F8008890DE006F78D600694731000290C90000436E00FF00FF00FF00FF000090
          C800CAB5A600FFFFFF000060980000436E0000436E0000436E0000436E000043
          6E0000436E00003A8100694731000290C90000436E00FF00FF00FF00FF000090
          C800CAB5A600CAB5A6000060980095E8F8006ED0EC0000436E006ED0EC004EBD
          E3000B95CC0000436E00CAB5A6000290C90000436E00FF00FF00FF00FF000090
          C80095E8F80095E8F80095E8F8000060980095E8F80000436E0000436E006ED0
          EC0000436E0095E8F8008DE4F60086DFF30000436E00FF00FF00FF00FF00FF00
          FF000090C8000090C8000090C8000090C8000060980095E8F80095E8F8000043
          6E000090C8000090C8000090C8000090C800FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000060980000609800006098000060
          9800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D5BFB1006947
          3100694731006947310069473100694731006947310069473100694731006947
          3100694731006947310069473100694731006947310069473100D5BFB100F6F2
          EF00B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A2930069473100D5BFB1002A80
          1E00136F0D00136F0D00136F0D00136F0D00136F0D00136F0D002A801E00E3D5
          CE00E0D1C900DFCFC600DCCBC100DBC9BF00B7A2930069473100D5BFB10059A8
          5100448B2F003CA02C0032A4260032A526003D9E2C00438D2E00136F0D00E7DB
          D500A1745C00A1745C00A1745C00A1745C00B7A2930069473100D5BFB10080BC
          790042952E0031A62600369B3200369E320032A727003E952C00136F0D00EAE0
          DA00E7DBD500E4D7D000E2D3CB00DFCFC600B7A2930069473100D5BFB100CFE8
          CD004CA741002D942F0071AB90006FA68E0030923100136F0D00EFE8E300EDE4
          DF00A1745C00A1745C00A1745C00A1745C00B7A2930069473100D5BFB100FFFF
          FF00B9DDC2004F9DA000559BC8004E96C2004E8E8F00A8C2AA00F2ECE800EFE8
          E300EDE4DF00EAE0DA00E7DBD500E4D7D000B7A2930069473100D5BFB100FFFF
          FF00A5CDE8005DAADD005CA9DD0057A4D900519ACC00A0BACA00F5F0ED00F2EC
          E800EFE8E300EDE4DF00EAE0DA00E7DBD500B7A2930069473100D5BFB100ECF6
          FA006CB9DF0065B2E50065B1E5005FACDF0056A2D700689EBE00F7F4F100F5F0
          ED00F2ECE800EFE8E300EDE4DF00EAE0DA00B7A2930069473100D5BFB100E9F6
          FA005BB0D5005CA6D50065AFDF0062AFE20058A4D8003285A700FAF8F600F7F4
          F100F7A07300F7A07300F7A07300F7A07300B7A2930069473100D5BFB100F4FA
          FC0078C0DD0056A0CD00569DCA00539CCA00448DBB003285A700FDFCFB00FAF8
          F600F7F4F100F5F0ED00F2ECE800EFE8E300B7A2930069473100D5BFB100FFFF
          FF00CEEAF40062B5DE005DA7D5004B92BE003285A700C6DCE600FFFFFF00FDFC
          FB00F7A07300F7A07300F7A07300F7A07300B7A2930069473100D5BFB100FFFF
          FF00FFFFFF00CEEAF400A5CDE800A5CDE800CEEAF400FFFFFF00FFFFFF00FFFF
          FF00FEFEFD00FCFAF900F9F6F400F6F2EF00F3EEEA0069473100D5BFB100D5BF
          B100D5BFB100D5BFB100D5BFB100D5BFB100D5BFB100D5BFB100D5BFB100D5BF
          B100D5BFB100D5BFB100D5BFB100D5BFB100D5BFB100D5BFB100FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ABACAC006947
          3100694731006947310069473100694731006947310069473100694731006947
          3100694731006947310069473100694731006947310069473100ABACAC00F9F6
          F400B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A2930069473100ABACAC00FCFB
          F900F9F6F400F6F2EF00F3EDE900F0E8E400EDE4DF00EAE0D900E7DBD400E4D7
          CF00E1D2C900DECDC400DBC9BF00DBC9BF00B7A2930069473100ABACAC00FFFF
          FF00808080008080800080808000808080008080800080808000808080008080
          8000808080008080800080808000DBC9BF00B7A2930069473100ABACAC00FFFF
          FF0080808000FFFFFF0080808000FFFFFF0080808000FFFFFF0080808000FFFF
          FF0080808000FFFFFF0080808000DECDC400B7A2930069473100ABACAC00FFFF
          FF00808080008080800080808000808080008080800080808000808080008080
          8000808080008080800080808000E1D2C900B7A2930069473100ABACAC00FFFF
          FF0080808000FFFFFF0080808000FFFFFF0080808000FFFFFF0080808000FFFF
          FF0080808000FFFFFF0080808000E4D7CF00B7A2930069473100ABACAC00FFFF
          FF00808080008080800080808000808080008080800080808000808080008080
          8000808080008080800080808000E9DED700B7A2930069473100ABACAC00FFFF
          FF00FFFFFF00FFFFFF0080808000FFFFFF0080808000FFFFFF0080808000FFFF
          FF0080808000FFFFFF0080808000ECE2DC00B7A2930069473100ABACAC00FFFF
          FF00FFFFFF00FFFFFF0080808000808080008080800080808000808080008080
          8000808080008080800080808000EEE6E100B7A2930069473100ABACAC00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFD
          FC00FBF9F700F7F4F100F4EFEC00F1EBE700B7A2930069473100CD762100CD76
          2100CD762100CD762100CD762100CD762100CD762100CD762100CD762100CD76
          2100CD762100CD762100CD762100CD762100CD76210069473100CD762100FBC3
          9F00FBC39F00FBC39F00FBC39F00FBBE9800FAB38A00F8A77B00F79C6D00F693
          5F00F6895300F57F4600F4753900F46B2D00F46B2D0069473100CD762100FBC3
          9F00FBC39F00FBC39F00FBC39F00FBC39F00FBBE9800FAB38A00F8A77B00F79C
          6D00F6935F00F68E5900F5844C00F57A4000F470330069473100CD762100CD76
          2100CD762100CD762100CD762100CD762100CD762100CD762100CD762100CD76
          2100CD762100CD762100CD762100CD762100CD762100CD762100}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00BBA6970073533D0073533D0073533D0073533D0073533D007353
          3D0073533D0073533D0073533D0073533D0073533D0073533D00FF00FF00FF00
          FF00FF00FF00BBA69700F8F3F200E5CBB900E5CBB900E5CBB900E5CBB900E5CB
          B900E5CBB900E5CBB900E5CBB900E5CBB900E5CBB90073533D00FF00FF00FF00
          FF00FF00FF00BBA69700FBF9F900F8F4F300A58F8100957B6A00A7908200EADF
          DA00E6DAD300E3D4CD00DFCFC600DBCAC000E5CBB90073533D00FF00FF00FF00
          FF00FF00FF00BBA69700FEFEFE00FCFAF9009C85760073533D007D604B00E5DB
          D500EBE0DB00E7DAD400E3D5CE00DFD0C700E5CBB90073533D00859299000060
          900000609000BBA69700FFFFFF00FEFEFE00D7CDC7007656410073533D00A38D
          7E00E6DCD600B5A19400E2D5CE00E3D6CF00E5CBB90073533D00859299008CF1
          F8000691CD00BBA69700FFFFFF00FFFFFF00FDFDFD00BFAFA500765641007353
          3D007F624D0078594400987E6D00E3D6CF00E5CBB90073533D008592990092F4
          F8008CF1F800BBA69700FFFFFF00FFFFFF00FFFFFF00FEFEFE00DDD5D000A38D
          7F00876C590075554000886C5900DFD3CD00E5CBB90073533D008592990092F4
          F80092F4F800BBA69700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FDFC
          FC00F6F3F100A8948600E5DCD700EFE8E400E5CBB90073533D008592990092F4
          F80092F4F800BBA69700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFE
          FE00FEFDFD00F7F4F200F7F3F100F3EEEB00F0E8E40073533D008592990092F4
          F80092F4F800BBA69700BBA69700BBA69700BBA69700BBA69700BBA69700BBA6
          9700BBA69700BBA69700BBA69700BBA69700BBA69700BBA697008592990092F4
          F80092F4F80092F4F80092F4F80092F4F8008FF3F80089F0F80080EAF6007AE7
          F60074E3F5006EE0F5000691CD0000609000FF00FF00FF00FF008592990092F4
          F80092F4F80092F4F80092F4F80092F4F80092F4F8008FF3F80089F0F80083EC
          F7007DE9F60077E5F5000691CD0000609000FF00FF00FF00FF008592990092F4
          F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F8008FF3F80089F0
          F80083ECF7007DE9F60077E5F50000609000FF00FF00FF00FF00859299008592
          9900859299008592990085929900859299008592990085929900859299008592
          990085929900859299008592990085929900FF00FF00FF00FF008592990094F5
          F80094F5F80094F5F80094F5F80085929900FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008592
          9900859299008592990085929900FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00708890007078
          8000607070005060600040505000303840002028300010202000101020001010
          20001010200010102000101020001010200010102000FF00FF0070889000A0E0
          F00070D0F00050B8E00030B0E00030A8E00020A0D0002098C0002090C0002080
          B0002080B0001080B0002078A0002070900010202000FF00FF0080889000B0E8
          F00090E8FF0080E0FF0070D8FF0070D0F00060C8F00050C0F00040B8F00030A8
          F00030A8E0002098E0001090D0002078A00020283000FF00FF008090A000B0E8
          F000A0E8FF0090E8FF0080E0FF0070D8FF0070D0F00060C8F00050C0F00040B8
          F00030A8F00030A0E0002098E0001080B00030384000FF00FF008090A000B0F0
          FF00B0F0FF00A0E8FF0090E0FF0080E0FF0070D8FF0070D0F00060C8F00050C0
          F00040B0F00030A8F00020A0E0001080B00040405000FF00FF008098A000C0F0
          FF00B0F0F000A0F0FF00A0E8FF0090E0FF0080E0FF0070D8FF0060D0F00060C8
          F00050B8F00040B0F00030A8E0001088C00050506000FF00FF008098A000C0F0
          FF00B0F0FF00B0F0FF00A0E8FF0090E8FF0090E0FF0080E0FF0070D8FF0060D0
          F00060C8F00050B8F00030A8E0001090C00050607000FF00FF0090A0A000C0F0
          FF00B0F0FF00B0F0FF00B0F0F000A0F0FF0090E8FF0090E0FF0080E0FF0070D0
          FF0060D0F00050C0F00050B8F0002098D00060708000FF00FF0090A0B000C0F0
          FF00C0F0FF00C0F0FF00C0F0FF00B0F0FF00B0F0FF00A0E8FF0090E8FF0090E0
          FF0080D8FF0070D0FF0070C8F00060C0F00060708000FF00FF0090A0B00090A0
          B00090A0B00090A0B00090A0B00090A0B00090A0A0009098A0008098A0008098
          A0008098A0008098A0008098A0008098A000FF00FF00FF00FF0090A8B000B0E8
          F000B0F0FF00B0F0FF00B0F0F00090E0F00090A0B000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0090A8
          B00090A8B00090A8B00090A8B00090A8B000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007698
          DA003757BB001530A400344FAC007490C700FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0080A8C000507890005088A0006090B00070A0C0004070D0002040
          D0001038C0001038D0001028A0001028A0004060A0006088A000FF00FF00FF00
          FF00FF00FF0080A8C000E0FFFF00B0E8FF00A0E8FF0070A8F0002050F0002048
          E0001038C000B0E8FF004070F0002050E0001028A0005070A000FF00FF00FF00
          FF00FF00FF0080B0C000C0E8F000C0F8FF00B0F8FF003070FF001048FF000048
          FF002048E0001038C000D0F8FF005080F0001030B0003050B000708890007078
          80006070700080B0C00080C0D000A0E8F000B0F8FF001048FF001048E000C0F0
          FF001048FF002048E0001040C000C0E8FF001038E0001030B00070889000A0E0
          F00070D0F00090B8C000B0E8F00080C8E000A0F0FF002060FF002048E00070B0
          F000A0E0F0001048FF002048E0001038C0002040D0003058C00080889000B0E8
          F00090E8FF0090B8D000D0FFFF00B0F0FF0090E0F00060A0F0001048FF003058
          D00090B8FF00A0E0F0001048FF002048E0002048E0006080C0008090A000B0E8
          F000A0E8FF0090C0D000D0FFFF00A0E8F00080C8E000A0E0FF006090FF001048
          FF002048E0002048E0001048FF001050F0005088F00070A0B0008090A000B0F0
          FF00B0F0FF0090C0D000C0F8FF0070C8E000A0E8F000B0F8FF00A0E8FF006098
          FF003068FF002050FF004078FF006098F00090C8F0007098A0008098A000C0F0
          FF00B0F0F00090C8D000A0E0F000E0FFFF00E0FFFF00E0FFFF00E0FFFF00E0FF
          FF00E0FFFF00E0FFFF00E0FFFF00C0F8FF0070B8D000708890008098A000C0F0
          FF00B0F0FF0090C8D00090C8D00090C8E00090C8D000A0C8D000A0C8D000A0C8
          D000A0C8D000A0C8D000A0C0D00090B8D00090B8C00090B0C00090A0A000C0F0
          FF00B0F0FF00B0F0FF00B0F0F000A0F0FF0090E8FF0090E0FF0080E0FF0080D8
          FF0070D0FF0060C8F00060C0F00030A0D00070788000FF00FF0090A0B000C0F0
          FF00C0F0FF00C0F0FF00C0F0FF00B0F0FF00B0F0FF00A0E8FF0090E8FF0090E0
          FF0080D8FF0080D8FF0070D0F00060C0F00060708000FF00FF0090A0B00090A0
          B00090A0B00090A0B00090A0B00090A0B00090A0A0009098A0008098A0008098
          A0008098A0008098A0008098A0008090A000FF00FF00FF00FF0090A8B000B0E8
          F000B0F0FF00B0F0FF00B0F0F00090E0F00090A0B000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0090A8
          B00090A8B00090A8B00090A8B00090A8B000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C0989000C090
          9000C0888000B0808000B0787000A0707000A0686000A0686000A0686000A068
          6000A0686000A0686000A0606000A0606000A0606000A0606000C0989000F0D8
          C000FFFFF000FFF0D000FFE0B000FFD8A000FFC89000FFC89000FFC09000FFB8
          8000FFB88000FFA87000FFA87000F0A06000D0805000A0606000D0989000D0A8
          A000E0D0C000FFFFF000FFF8E000FFF0D000FFE8D000FFE8C000FFE0C000FFD8
          B000FFD8B000FFD0A000FFC89000D0987000C0706000A0686000D0A09000FFFF
          F000D0B0A000E0D0C000FFF8F000FFF8F000FFF8F000FFF0E000FFF0E000FFE8
          C000FFE0C000FFD8B000E0A88000C0807000FFB87000A0686000D0A0A000FFFF
          FF00FFFFF000D0A09000E0C8C000FFF8F000FFF8F000FFF8F000FFF0E000FFF0
          D000F0E0C000D0A88000C0787000FFD8A000FFD09000A0687000D0A0A000FFFF
          FF00F0D8D000E0C0B000E0C0B000E0C0B000E0C8C000E0C8B000E0C0B000E0C0
          B000D0B0A000D0A8A000D0989000E0B09000FFD8A000A0707000D0A8A000F0D0
          C000E0B8B000F0F0F000F0F0F000E0B8A000E0B8A000D0B0A000D0B0A000D0A8
          A000D0A8A000F0E8E000F0E0D000C0989000E0A88000A0787000D0A8A000C0B8
          B000F0F0F000FFF8F000F0E0E000F0F0F000F0F0F000F0F0F000F0F0E000F0F0
          E000F0F0E000F0E0D000FFF0E000F0D8D000A0909000A0787000D0A8A000A0D8
          F000FFFFF000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF000FFF8
          F000FFF8F000FFF0F000F0F0F000E0E0E00050B0E000A0787000D0A8A000A0E8
          FF00B0E0FF00B0E0FF00A0D8FF0080D0FF0060D0FF0060C8FF0060C8FF0050C8
          FF0050C0F00040B8F00040B0F00030B0F00020B0FF00C0989000FF00FF00D0B8
          C000C0F0FF00D0F8FF00D0F0FF00D0E8FF00B0E8FF00A0E0FF0080D0FF0070C8
          FF0050C8FF0070C8FF0060C8FF0040B8FF00A0B0C000FF00FF00FF00FF00FF00
          FF00D0B8B000D0E0E000D0F8FF00D0F0FF00D0E8FF00B0E8FF00A0E0FF0080D0
          FF0070C8FF0050C8FF0090C0E000B0A8B000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00D6B5A300D0B8B000E0F8FF00E0F8FF00D0F0FF00B0E0FF0090E0
          FF0070D0FF00C0B0B000C4A89A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00E1BBAA00D0B0A000E0E0E000D0F8FF00C0F0FF00B0C8
          D000D0B8B000DDB39D00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00D9B2A500D0B0A000D0B0A000D0AF
          9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF006C8C
          9C00293643002936430029364300293643002936430029364300293643002936
          43002936430029364300293643002936430029364300293643006C8C9C00335D
          7100335D7100335D7100335D7100335D7100335D7100335D7100335D7100335D
          7100335D71005CCAE10077DEEB0085E9F00098F8F800293643006C8C9C0090F2
          F50053A3B70053A3B70053A3B70053A3B70053A3B70053A3B70053A3B70053A3
          B70053A3B700335D71005CCAE10077DEEB0085E9F000293643006C8C9C0098F8
          F80090F2F50088EBF20080E5EF0078DFEB0070D9E80068D3E50061CEE30059C8
          E00053A3B7005CCAE100335D71005CCAE10077DEEB00293643006C8C9C0098F8
          F80098F8F80090F2F50088EBF20080E5EF0078DFEB0070D9E80068D3E50061CE
          E30053A3B70098F8F8005CCAE100335D71005CCAE100293643006C8C9C0098F8
          F80098F8F80098F8F80090F2F50088EBF20080E5EF0078DFEB0070D9E80068D3
          E50053A3B70053A3B70053A3B70053A3B700335D7100293643006C8C9C0098F8
          F80098F8F80098F8F80098F8F80094F5F70088EBF20080E5EF0078DFEB0070D9
          E80068D3E50061CEE30059C8E00053A3B700335D7100293643006C8C9C0098F8
          F80098F8F80098F8F80098F8F80098F8F80094F5F7008CEFF40084E8F0007CE2
          ED0074DCEA0068D3E50061CEE30053A3B700335D7100293643006C8C9C0098F8
          F80098F8F80098F8F80098F8F80098F8F80098F8F80094F5F7008CEFF40084E8
          F0007CE2ED0074DCEA006CD6E70053A3B700335D7100293643006C8C9C0098F8
          F80098F8F80098F8F80098F8F80098F8F80098F8F80098F8F80094F5F7008CEF
          F40084E8F0007CE2ED0074DCEA0053A3B700335D7100293643006C8C9C0098F8
          F80098F8F80098F8F80098F8F80098F8F80098F8F80098F8F80098F8F80094F5
          F7008CEFF40084E8F0007CE2ED0074DCEA00335D71006C8C9C006C8C9C006C8C
          9C006C8C9C006C8C9C006C8C9C006C8C9C006C8C9C006C8C9C006C8C9C006C8C
          9C006C8C9C006C8C9C006C8C9C006C8C9C006C8C9C00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end>
  end
  object ilPreviewLarge: TcxImageList
    Height = 28
    Width = 28
    FormatVersion = 1
    DesignInfo = 19398736
    ImageInfo = <
      item
        Image.Data = {
          760C0000424D760C00000000000036000000280000001C0000001C0000000100
          200000000000400C000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BBA6
          970073533D0073533D0073533D0073533D0073533D0073533D0073533D007353
          3D0073533D0073533D0073533D0073533D0073533D0073533D0073533D007353
          3D0073533D0073533D00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00BBA69700F7F3F100BBA69700BBA69700BBA6
          9700BBA69700BBA69700BBA69700BBA69700BBA69700BBA69700BBA69700BBA6
          9700BBA69700BBA69700BBA69700BBA69700BBA6970073533D00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BBA6
          9700FAF7F500F7F3F200F5F0ED00ECE4E000E7DDD800E5DAD400E3D7D100E7DC
          D600E8DCD600E5D8D200E3D5CD00E0D1C900DECEC500DCCAC000DBC9BF00DBC9
          BF00BBA6970073533D00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00BBA69700FCFAFA00FAF7F600F7F4F200AA96
          8900866956008569560085685500C4B3A800EAE0DA00E8DCD600E6D8D200E3D5
          CE00E0D2CA00DECEC500DCCAC100DBC9BF00BBA6970073533D00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BBA6
          9700FEFDFD00FCFAFA00FAF7F600AC998C0073533D0073533D0073533D00AF9B
          8E00ECE3DE00EAE0DB00E8DCD600E6D8D200E3D5CE00E0D2CA00DECEC500DCCB
          C100BBA6970073533D00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00BBA69700FEFEFE00FEFEFE00FCFBFB00D0C4
          BC0074543E0073533D0073533D00896E5B00E8DFDA00EDE4DF00EAE0DB00E6DB
          D500E6D9D200E3D6CE00E1D2CA00DECEC500BBA6970073533D00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BBA6
          9700FFFFFF00FFFFFF00FEFEFE00F7F4F3008A705D0073533D0073533D007353
          3D00B3A09300EBE2DE00E8DED800B29E9100E1D4CD00E6D9D300E3D6CF00E1D2
          CB00BBA6970073533D00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00BBA69700FFFFFF00FFFFFF00FFFFFF00FEFE
          FE00D6CCC6007A5C470073533D0073533D0075564000A38D7E00C3B3A8008467
          53009D847400E2D6CF00E6D9D300E3D6CF00BBA6970073533D00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BBA6
          9700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFCFC00C8BBB3007C5E4A007353
          3D0073533D0073533D0075553F0073543E0073533E009E867600E2D6CF00E6DA
          D300BBA6970073533D0085929900006090000060900000609000006090000060
          9000006090000060900000609000BBA69700FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FDFDFD00DBD3CE00957D6C007656410073533D0073533D007353
          3D0073533D007B5D4800CFC0B700E9DED800BBA6970073533D00859299008BF0
          F7000691CD000691CD000691CD000691CD000691CD000691CD000691CD00BBA6
          9700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FBF9
          F900DED6D000BDADA300A69183007A5B47007A5C4700C7B8AE00EDE4E000EBE1
          DC00BBA6970073533D00859299008BF0F70087EEF70083ECF7007FEAF6007CE8
          F60078E6F50074E4F50071E2F500BBA69700FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FDFCFC00FBF9F800F2EEEC009279
          6800C8BAB100F2EBE800F0E8E400EDE5E000BBA6970073533D00859299008EF2
          F8008BF0F70087EEF70083ECF7007FEAF6007CE8F60078E6F50074E4F500BBA6
          9700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FEFEFE00FEFDFD00F8F5F400DDD4CF00F5F1EF00F4EFEC00F2ECE800F0E8
          E400BBA6970073533D008592990092F4F8008EF2F8008BF0F70087EEF70083EC
          F7007FEAF6007CE8F60078E6F500BBA69700FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FEFDFD00FCF9
          F900F9F6F500F7F3F100F5EFED00F3ECE900F0E9E50073533D008592990092F4
          F80092F4F8008EF2F8008BF0F70087EEF70083ECF7007FEAF6007CE8F600BBA6
          9700BBA69700BBA69700BBA69700BBA69700BBA69700BBA69700BBA69700BBA6
          9700BBA69700BBA69700BBA69700BBA69700BBA69700BBA69700BBA69700BBA6
          9700BBA69700BBA697008592990092F4F80092F4F80092F4F8008EF2F8008BF0
          F70087EEF70083ECF7007FEAF6007CE8F60078E6F50074E4F50071E2F5006DE0
          F5006ADDF40066DBF40062D9F4005ED7F4005AD5F30056D3F3000691CD000060
          9000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008592990092F4
          F80092F4F80092F4F80092F4F80090F3F8008DF1F80089EFF70083ECF7007FEA
          F6007CE8F60078E6F50074E4F50071E2F5006DE0F5006ADDF40066DBF40062D9
          F4005ED7F4005AD5F3000691CD0000609000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008592990092F4F80092F4F80092F4F80092F4F80092F4
          F80090F3F8008DF1F80089EFF70085EDF70081EBF6007EE9F6007AE7F60076E5
          F50072E3F5006FE1F5006CDFF50068DCF40064DAF40060D8F4000691CD000060
          9000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008592990092F4
          F80092F4F80092F4F80092F4F80092F4F80092F4F80090F3F8008DF1F80089EF
          F70085EDF70081EBF6007EE9F6007AE7F60076E5F50072E3F5006FE1F5006CDF
          F50068DCF40064DAF4000691CD0000609000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008592990092F4F80092F4F80092F4F80092F4F80092F4
          F80092F4F80092F4F80090F3F8008DF1F80089EFF70085EDF70081EBF6007EE9
          F6007AE7F60076E5F50072E3F5006FE1F5006CDFF50068DCF4000691CD000060
          9000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008592990092F4
          F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F80090F3
          F8008DF1F80089EFF70085EDF70081EBF6007EE9F6007AE7F60076E5F50072E3
          F5006FE1F5006CDFF5000691CD0000609000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008592990092F4F80092F4F80092F4F80092F4F80092F4
          F80092F4F80092F4F80092F4F80092F4F80090F3F8008DF1F80089EFF70085ED
          F70081EBF6007EE9F6007AE7F60076E5F50072E3F5006FE1F5000691CD000060
          9000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008592990092F4
          F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4
          F80092F4F80090F3F8008DF1F80089EFF70085EDF70081EBF6007EE9F6007AE7
          F60076E5F50072E3F5000691CD0000609000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008592990092F4F80092F4F80092F4F80092F4F80092F4
          F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F8008EF2
          F8008BF0F70087EEF70083ECF7007EE9F6007AE7F60072E3F50072E3F5000060
          9000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00859299008592
          9900859299008592990085929900859299008592990085929900859299008592
          9900859299008592990085929900859299008592990085929900859299008592
          990085929900859299008592990085929900FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008592990095F6F80092F4F80091F2F80090F1F8008EF0
          F8008DEFF80090F1F80079CADE0085929900FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008592990084DB
          E80094F5F80092F4F80091F2F80090F1F80090F1F80079CADE0085929900FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00859299008592990085929900859299008592
          99008592990085929900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          760C0000424D760C00000000000036000000280000001C0000001C0000000100
          200000000000400C000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF009C9288004D3D2F004D3D2F004D3D2F004D3D2F004D3D2F004D3D
          2F004D3D2F004D3D2F004D3D2F004D3D2F0073605100FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0096867800ECD9C800ECD7
          C500EBD5C200EBD4BF00EBD2BB00EBD0B800EACEB500EACDB200EACBAE00E9C9
          AB00AD9178008D796A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00A49B9100BEAD9F00F9E8D900F9E6D600F9E4D200F8E2CF00F8E0CB00F8DE
          C700F7DCC400F7DBC000F7D8BC00F7D7B900DCBDA0006D605500FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF0096867800DCCEC100FAEADD00F9E8
          D900F9E6D600F9E4D200DBCDB700CCBAA800D9C3AF00EDD3BC00F7DAC000F7D9
          BD00F3D3B6004E3E2F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF008D7B6E00F0E3D900FAECE100EEE0D300BDB2A600E5D4C4008CA67D003366
          3200255A2500656A5200D1BBA500F5D9BF00F7D9BD00A18872008D796A00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00AEA09300E5E1D600769B77003A85
          480026813800A5A09100468B4B00116F1F000E6518002459240034592C008F84
          7100F2D6BC00D9BDA4006D605500FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A49B
          9100CBC0B70088C7940023A24400209A3E001E9138006D7F67004E9855001477
          250016702200376B3600125F16001A53190076715D00EBCFB50052413200FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0096867800DCDED3003EB5600026AC4C0023A4
          46002A9D4600789E7800EDE5D50068A56A00B4B19D00B0BB9A000E6618000B5D
          1200155315009C917C00937D6A008D796A00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008D7B
          6E00D6EAD90036B65D0041AF600089C59400D2DDC800F5EBE100FAEDE100F2E7
          D900EEE2D10085AB7D00127020000F671A00145E1900ADA48D00C4AD98006658
          4C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00A49B9100BBB0A700BAE6C6002FC65F00418E5800ABAB
          A500D6D3CB00FBF1EA00FAEFE600FAEDE200F8EADD00539A5A00157927001270
          200026682A00D8C6B300E9D2BC0057453600FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0096867800D9D2
          CC00A1E1B40030C8600030C45F0039A75A00ABB0A600FBF3ED00FBF1E900FBEF
          E600F5EADE0090BC8D00459650001A7C2B0054805100EEDAC800F7E0CC00836F
          5E008D796A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008D7B6E00F0EBE900BCE9C80033C8620030C8600033C2
          6000C0BDBA00E6E1DD00F7EFE900FBF1EA00F4E9E000D6CEC30098A38C00B2AD
          9E00E0D9C400F8E5D400F9E4D100BAA593006D605500FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A99B9000FBF7
          F600F8F8F50063CD840035C7630061C37F00C2CEC30056AA6E009A999400F8F0
          EA00ACCAAB0037984E0022943D003C714400BEB1A600F9E7D800F9E5D400E8D3
          C1004E3E2F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00A49B9100C8BEB700FDFAF900F8F8F500D8ECDC00F6F6F300DAE6
          DB0048C26E002FC75F00389E5700989C9400CCDFC9002AA84C00229F42002B8F
          42009DAE9300F4E5D700F9E8D900F7E0CC00736051008D796A00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0096867800E7E1DD00FDFA
          F900FDFAF900FDFAF900FDFAF900B4E5C10031C8600030C860002FC75F00399C
          570070A37C0028B04F0024A74800508F5D00F9EDE200FAECE000F9EADC00F9E8
          D900A79586006D605500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF008D7B6E00FAF7F600FDFAF900FDFAF900FDFAF900FDFAF900FDFA
          F900B4E6C2003DCA6A0030C760004DB96F004BB56B0039BB5F005EBD7600CBD7
          C400FBF0E700FAEEE400FAECE000FAEADD00D7C6B8004E3E2F00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00ACA39900B4A99F00FDFAF900FDFA
          F900FDFAF900FDFAF900FDFAF900FDFAF900FCF9F800DDF1E100C3E8CC00CEE5
          D300D5ECDA00EBF1E800F9F4F000FBF4EE00FBF2EB00FBF0E700FAEEE400FAEC
          E000F1E1D40065544600A49B9100FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0096897B00C3BAB300E7E1DE00E7E1DE00E7E1DE00E7E1DE00E7E1DE00E7E1
          DE00E7E1DE00E7E1DE00E7E1DE00E7E1DE00E7E1DE00E7E1DE00E6E0DD00E6DF
          DA00E6DDD600E5DCD400E4DAD000E4D9CE00E2D5C9006D5C4F00918A8400FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00948376008D7B6E008F7D6E008F7D
          6E008F7D6E00907E7100A89C9100A89B8F00A89B8F00ADA09700AB9D9300A99B
          9000A7998D00A5978A00A3958700A19184009F8F82009D8C7F00988679009382
          75008E7E70005E4B3D00A49B9100FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00A49B9100918173008D796A008D796A008D796A009F908500F9F8F800F5F2
          F200EFEBE900E9E3E100E3DCD800DDD4D000D7CDC700D1C6BF00CBBEB600C4B7
          AE00BEAEA500AE9E9300A59387009E8C8000928073005F4E4000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A49B91008C796A008D79
          6A008D796A00AFA39800FBFAFA00FAF9F900F4F2F100EFEBE900E8E3E000E3DC
          D800DCD4D000D7CDC800D1C6BF00CBBFB700C5B7AE00B8A99F00AC9A8F00A593
          87007A6A5D00918A8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00948376008C786A008D796A00BFB6AE00FCFBFB00FCFB
          FB00FBF9F900F6F3F300F0EBEA00E9E4E200E3DDD900DDD5D100D7CEC800D2C7
          C000CBBFB700C2B4AC00B3A39800A593880066574B00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A49B91009483
          76008C786900CDC5C000FCFBFB00FCFBFB00FCFBFB00FBF9F900F5F3F300F0EC
          EB00E9E4E200E4DEDA00DDD6D100D8CFC900D2C7C000CBBFB700BAA99F007E6E
          6200A49B9100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00A49B91008A786A00D9D4CF00FCFBFB00FCFB
          FB00FCFBFB00FCFBFB00FBF9F900F7F4F400F0ECEB00EAE5E300E4DEDA00DED6
          D200D8CFC900D3C8C100AB9C92006D605500FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00A49B910094837600BFB4AC00BFB4AC00BFB4AC00BFB4AC00BFB4AC00BFB4
          AC00BFB4AC00BFB4AC00BFB4AC00BFB4AC00BFB4AC00BFB4AC0078685C00A49B
          9100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A49B9100948376009483
          7600948376009483760094837600948376009483760094837600948376009483
          76009483760094837600A49B9100FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          760C0000424D760C00000000000036000000280000001C0000001C0000000100
          200000000000400C000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF002025200020252000006000000060
          0000006000000060000000600000006000000060000000600000006000000060
          0000006000000060000000600000006000000060000000600000006000000060
          0000006000000060000000600000FF00FF00FF00FF00FF00FF00FF00FF002025
          2000FFFFFF007070700020252000009800000098000000980000009800000098
          0000009800000098000000980000009800000098000000980000009800000098
          000000980000009800000098000000980000009800000098000000600000FF00
          FF00FF00FF00FF00FF00FF00FF0091939500202520002025200089D89E0083D7
          9A007DD6960077D5920072D48E006CD3890066D2850060D181005AD07D0054CE
          79004ECD740048CC700042CB6C003CCA680036C9640030C8600030C8600030C8
          600030C860000098000000600000FF00FF00FF00FF00FF00FF00FF00FF002025
          2000FFFFFF00707070002025200089D89E0083D79A007DD6960077D5920072D4
          8E006CD3890066D2850060D181005AD07D0054CE79004ECD740048CC700042CB
          6C003CCA680036C9640030C8600030C8600030C860000098000000600000FF00
          FF00FF00FF00FF00FF00FF00FF0091939500202520002025200095DBA6008FD9
          A20089D89E0083D79A007DD6960077D5920072D48E006CD3890066D2850060D1
          81005AD07D0054CE790020252000202520002025200020252000202520002025
          200030C860000098000000600000FF00FF00FF00FF00FF00FF00FF00FF002025
          2000FFFFFF00707070002025200095DBA6008FD9A20089D89E0083D79A007DD6
          960077D5920072D48E006CD3890066D2850060D181005AD07D0054CE79004ECD
          740048CC700042CB6C003CCA680036C9640030C860000098000000600000FF00
          FF00FF00FF00FF00FF00FF00FF00919395002025200020252000A4DEB1009EDD
          AD0098DBA90092DAA40089D89E0083D79A007DD6960077D5920072D48E006CD3
          890066D2850060D181005AD07D0054CE79004ECD740048CC700042CB6C003CCA
          680036C964000098000000600000FF00FF00FF00FF00FF00FF00FF00FF002025
          2000FFFFFF007070700020252000A4DEB1009EDDAD0098DBA90092DAA4008CD9
          A00086D89C0080D698007AD5940075D590006FD48C0069D2870063D183005DD0
          7F0057CF7B0051CE770048CC700042CB6C003CCA68000098000000600000FF00
          FF00FF00FF00FF00FF00FF00FF00919395002025200020252000B0E0B900AADF
          B500A4DEB1009EDDAD0098DBA90092DAA4008CD9A00086D89C0080D698007AD5
          940075D590006FD48C0069D2870063D183005DD07F0057CF7B0051CE77004BCD
          720045CC6E000098000000600000FF00FF00FF00FF00FF00FF00FF00FF002025
          2000FFFFFF007070700020252000B0E0B900AADFB500A4DEB1009EDDAD0098DB
          A90092DAA4008CD9A00086D89C0080D698007AD5940075D590006FD48C0069D2
          870063D183005DD07F0057CF7B0051CE77004BCD72000098000000600000FF00
          FF00FF00FF00FF00FF00FF00FF00919395002025200020252000BCE3C200B6E2
          BE00B0E0B900AADFB500A4DEB1009EDDAD0098DBA90092DAA4008CD9A00086D8
          9C0080D698007AD5940075D590006FD48C0069D2870063D183005DD07F0057CF
          7B0051CE77000098000000600000FF00FF00FF00FF00FF00FF00FF00FF002025
          2000FFFFFF007070700020252000BCE3C200B6E2BE00B0E0B900AADFB500A4DE
          B1009EDDAD0098DBA90092DAA4008CD9A00086D89C0080D698007AD5940075D5
          90006FD48C0069D2870063D183005DD07F0057CF7B000098000000600000FF00
          FF00FF00FF00FF00FF00FF00FF00919395002025200020252000BEE3C400BEE3
          C400BCE3C200B6E2BE00B0E0B900AADFB500A4DEB1009EDDAD0098DBA90092DA
          A4008CD9A00086D89C0080D698007AD5940075D590006FD48C0069D2870063D1
          83005DD07F000098000000600000FF00FF00FF00FF00FF00FF00FF00FF002025
          2000FFFFFF007070700020252000BEE3C400BEE3C400BEE3C400B9E2C000B3E1
          BB00ADE0B700A7DEB300A1DDAF009BDCAB0095DBA6008FD9A20086D89C0080D6
          98007AD5940075D590006FD48C0069D2870063D183000098000000600000FF00
          FF00FF00FF00FF00FF00FF00FF00919395002025200020252000BEE3C400BEE3
          C400BEE3C400BEE3C400BEE3C400B9E2C000B3E1BB00ADE0B700A7DEB300A1DD
          AF009BDCAB0095DBA6008FD9A20089D89E0083D79A007DD6960077D5920072D4
          8E006CD389000098000000600000FF00FF00FF00FF00FF00FF00FF00FF002025
          2000FFFFFF007070700020252000BEE3C400BEE3C400BEE3C400BEE3C400BEE3
          C400B9E2C000B3E1BB00ADE0B700A7DEB300A1DDAF009BDCAB0095DBA6008FD9
          A20089D89E0083D79A007DD6960077D5920072D48E000098000000600000FF00
          FF00FF00FF00FF00FF00FF00FF00919395002025200020252000BEE3C400BEE3
          C400BEE3C4000098000000600000006000000060000000600000006000000060
          000000600000006000000060000000600000006000000060000083D79A007DD6
          960077D592000098000000600000FF00FF00FF00FF00FF00FF00FF00FF002025
          2000FFFFFF007070700020252000BEE3C400BEE3C4000098000038C966004ACC
          72005CD07F006ED38B007CD6960088D89E0094DAA600A0DDAF00ACDFB700B8E1
          BF00BEE3C4000060000089D89E0083D79A007DD696000098000000600000FF00
          FF00FF00FF00FF00FF00FF00FF00919395002025200020252000BEE3C400BEE3
          C400BEE3C4000098000030C8600038C966004ACC72005CD07F006ED38B007CD6
          960088D89E0094DAA600A0DDAF00ACDFB700B8E1BF00006000008FD9A20089D8
          9E0083D79A000098000000600000FF00FF00FF00FF00FF00FF00FF00FF002025
          2000FFFFFF007070700020252000BEE3C400BEE3C4000098000030C8600030C8
          600038C966004ACC72005CD07F006ED38B007CD6960088D89E0094DAA600A0DD
          AF00ACDFB7000060000095DBA6008FD9A20089D89E000098000000600000FF00
          FF00FF00FF00FF00FF00FF00FF00919395002025200020252000BEE3C400BEE3
          C400BEE3C4000098000030C8600030C8600030C8600038C966004ACC72005CD0
          7F006ED38B007CD6960088D89E0094DAA600A0DDAF00006000009EDDAD0098DB
          A90092DAA4000098000000600000FF00FF00FF00FF00FF00FF00FF00FF002025
          2000FFFFFF007070700020252000BEE3C400BEE3C4000098000030C8600030C8
          600030C8600030C8600038C966004ACC72005CD07F006ED38B007CD6960088D8
          9E0094DAA60000600000A4DEB1009EDDAD0098DBA9000098000000600000FF00
          FF00FF00FF00FF00FF00FF00FF00919395002025200020252000BEE3C400BEE3
          C400BEE3C4000098000000980000009800000098000000980000009800000098
          0000069A06000C9C0C00129F120018A119001EA31F0000980000AADFB500A4DE
          B1009EDDAD000098000000600000FF00FF00FF00FF00FF00FF00FF00FF002025
          2000FFFFFF007070700020252000BEE3C400BEE3C400BEE3C400BEE3C400BEE3
          C400BEE3C400BEE3C400BEE3C400BEE3C400BEE3C400BEE3C400BEE3C400BEE3
          C400BCE3C200B6E2BE00B0E0B900AADFB500A4DEB1000098000000600000FF00
          FF00FF00FF00FF00FF00FF00FF00919395002025200000980000BEE3C400BEE3
          C400BEE3C400BEE3C400BEE3C400BEE3C400BEE3C400BEE3C400BEE3C400BEE3
          C400BEE3C400BEE3C400BEE3C400BEE3C400BEE3C400BCE3C200B6E2BE00B0E0
          B900AADFB500A4DEB10000600000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000098000000980000009800000098000000980000009800000098
          0000009800000098000000980000009800000098000000980000009800000098
          000000980000009800000098000000980000009800000098000000980000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          760C0000424D760C00000000000036000000280000001C0000001C0000000100
          200000000000400C000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00C6B0A30069473100694731006947310069473100694731006947
          3100694731006947310069473100694731006947310069473100694731006947
          31006947310069473100694731006947310069473100FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CFB9AB00FAF8F700B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          930069473100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00CFB9AB00FDFBFB00FAF8F700F8F4F300F6F1EF00F3EEEB00F1EA
          E700EFE7E300EDE4DF00EBE0DB00E8DDD700E6D9D300E4D6CF00E1D3CB00DFCF
          C700DDCCC300DBC9BF00DBC9BF00B7A2930069473100FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CFB9AB00FFFFFF00FDFB
          FB00FAF8F700F8F4F300F6F1EF00F3EEEB00F1EAE700EFE7E300EDE4DF00EBE0
          DB00E8DDD700E6D9D300E4D6CF00E1D3CB00DFCFC700DDCCC300DBC9BF00B7A2
          930069473100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00CFB9AB00FFFFFF00FFFFFF00FDFBFB00FAF8F700F3AB5900F3AB
          5900F3AB5900F3AB5900F3AB5900F3AB5900F3AB5900F3AB5900E6D9D300E4D6
          CF00E1D3CB00DFCFC700DDCCC300B7A2930069473100FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CFB9AB00FFFFFF00FFFF
          FF00FFFFFF00FDFBFB00FAF8F700F8F4F300F6F1EF00F3EEEB00F1EAE700EFE7
          E300EDE4DF00EBE0DB00E8DDD700E6D9D300E4D6CF00E1D3CB00DFCFC700B7A2
          930069473100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00CFB9AB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFBFB00FAF8
          F700F8F4F300F6F1EF00F3EEEB00F1EAE700EFE7E300EDE4DF00EBE0DB00E8DD
          D700E6D9D300E4D6CF00E1D3CB00B7A2930069473100FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CFB9AB00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00F3AB5900F3AB5900F3AB5900F3AB5900F3AB5900F3AB
          5900F3AB5900F3AB5900EDE4DF00EBE0DB00E8DDD700E6D9D300E4D6CF00B7A2
          930069473100FF00FF0085929900006090000060900000609000006090000060
          900000609000CFB9AB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FEFDFD00FCFAF900F9F6F500F7F3F100F5EFED00F2ECE900F0E9E500EEE5
          E100ECE2DD00EADFD900E7DBD500B7A2930069473100FF00FF00859299008BF0
          F7000691CD000691CD000691CD000691CD000691CD00CFB9AB00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFDFD00FCFAF900F9F6
          F500F7F3F100F5EFED00F2ECE900316ADC00316ADC00316ADC00EADFD900B7A2
          930069473100FF00FF00859299008BF0F70087EEF70083ECF7007FEAF6007CE8
          F60078E6F500CFB9AB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FEFDFD00FCFAF900F9F6F500F7F3F100F5EFED00314A
          800060A2FA00316ADC00ECE2DD00B7A2930069473100FF00FF00859299008EF2
          F8008BF0F70087EEF70083ECF7007FEAF6007CE8F600CFB9AB00FFFFFF004878
          F8004878F8004878F800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFD
          FD00FCFAF900F9F6F500F7F3F100396EE30060A2FA00316ADC00EEE5E100B7A2
          930069473100FF00FF008592990092F4F8008EF2F8008BF0F70087EEF70083EC
          F7007FEAF600CFB9AB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFDFD00FCFAF900F9F6F500F7F3
          F100F5EFED00F2ECE900F0E9E500EEE5E10069473100FF00FF008592990092F4
          F80092F4F8008EF2F8008BF0F70087EEF70083ECF700CFB9AB00CFB9AB00CFB9
          AB00CFB9AB00CFB9AB00CFB9AB00CFB9AB00CFB9AB00CFB9AB00CFB9AB00CFB9
          AB00CFB9AB00CFB9AB00CFB9AB00CFB9AB00CFB9AB00CFB9AB00CFB9AB00CFB9
          AB00CFB9AB00FF00FF008592990092F4F80092F4F80092F4F8008EF2F8008BF0
          F70087EEF70083ECF7007FEAF6007CE8F60078E6F50074E4F50071E2F5006DE0
          F5006ADDF40066DBF40062D9F4005ED7F4005AD5F30056D3F3000691CD000060
          9000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008592990092F4
          F80092F4F80092F4F80092F4F80090F3F8008DF1F80089EFF70083ECF7007FEA
          F6007CE8F60078E6F50074E4F50071E2F5006DE0F5006ADDF40066DBF40062D9
          F4005ED7F4005AD5F3000691CD0000609000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008592990092F4F80092F4F80092F4F80092F4F80092F4
          F80090F3F8008DF1F80089EFF70085EDF70081EBF6007EE9F6007AE7F60076E5
          F50072E3F5006FE1F5006CDFF50068DCF40064DAF40060D8F4000691CD000060
          9000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008592990092F4
          F80092F4F80092F4F80092F4F80092F4F80092F4F80090F3F8008DF1F80089EF
          F70085EDF70081EBF6007EE9F6007AE7F60076E5F50072E3F5006FE1F5006CDF
          F50068DCF40064DAF4000691CD0000609000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008592990092F4F80092F4F80092F4F80092F4F80092F4
          F80092F4F80092F4F80090F3F8008DF1F80089EFF70085EDF70081EBF6007EE9
          F6007AE7F60076E5F50072E3F5006FE1F5006CDFF50068DCF4000691CD000060
          9000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008592990092F4
          F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F80090F3
          F8008DF1F80089EFF70085EDF70081EBF6007EE9F6007AE7F60076E5F50072E3
          F5006FE1F5006CDFF5000691CD0000609000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008592990092F4F80092F4F80092F4F80092F4F80092F4
          F80092F4F80092F4F80092F4F80092F4F80090F3F8008DF1F80089EFF70085ED
          F70081EBF6007EE9F6007AE7F60076E5F50072E3F5006FE1F5000691CD000060
          9000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008592990092F4
          F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4
          F80092F4F80090F3F8008DF1F80089EFF70085EDF70081EBF6007EE9F6007AE7
          F60076E5F50072E3F5000691CD0000609000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008592990092F4F80092F4F80092F4F80092F4F80092F4
          F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F8008EF2
          F8008BF0F70087EEF70083ECF7007EE9F6007AE7F60072E3F50072E3F5000060
          9000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00859299008592
          9900859299008592990085929900859299008592990085929900859299008592
          9900859299008592990085929900859299008592990085929900859299008592
          990085929900859299008592990085929900FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008592990095F6F80092F4F80091F2F80090F1F8008EF0
          F8008DEFF80090F1F80079CADE0085929900FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008592990084DB
          E80094F5F80092F4F80091F2F80090F1F80090F1F80079CADE0085929900FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00859299008592990085929900859299008592
          99008592990085929900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          760C0000424D760C00000000000036000000280000001C0000001C0000000100
          200000000000400C000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00C7B2A3006947310069473100694731006947
          3100694731006947310069473100694731006947310069473100694731006947
          3100694731006947310069473100694731006947310069473100694731006947
          31006947310069473100694731006947310069473100FF00FF00FF00FF00C7B2
          A300DBC9BF00B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          930069473100FF00FF00FF00FF00C7B2A300B7A29300DFD0C700DFD0C700DFD0
          C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0
          C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0
          C700DFD0C700DFD0C700DFD0C700CE99970069473100FF00FF00FF00FF00C7B2
          A300DBC9BF00B7A29300E4D7CF00E4D7CF00E4D7CF00E4D7CF00E4D7CF00E4D7
          CF00E4D7CF00E4D7CF00E4D7CF00E4D7CF00E4D7CF00E4D7CF00E4D7CF00E4D7
          CF00E4D7CF00E4D7CF00E4D7CF00E4D7CF00E4D7CF00E4D7CF00B7A29300B7A2
          930069473100FF00FF00FF00FF00C7B2A300DECEC500DECEC500B7A29300E9DE
          D700E9DED700E9DED700E9DED700E9DED700E9DED700E9DED700E9DED700E9DE
          D700E9DED700E9DED700E9DED700E9DED700E9DED700E9DED700E9DED700E9DE
          D700E9DED700B7A29300DECEC500B7A2930069473100FF00FF00FF00FF00C7B2
          A300E2D4CC00E2D4CC00E2D4CC00B7A29300EDE4DF00EDE4DF00EDE4DF00EDE4
          DF00EDE4DF00EDE4DF00EDE4DF00EDE4DF00EDE4DF00EDE4DF00EDE4DF00EDE4
          DF00EDE4DF00EDE4DF00EDE4DF00EDE4DF00B7A29300E2D4CC00E2D4CC00B7A2
          930069473100FF00FF00FF00FF00C7B2A300E6D9D200E6D9D200E6D9D200E6D9
          D200B7A29300F0E9E500F0E9E500F0E9E500F0E9E500F0E9E500F0E9E500F0E9
          E500F0E9E500F0E9E500F0E9E500F0E9E500F0E9E500F0E9E500F0E9E500B7A2
          9300E6D9D200E6D9D200E6D9D200B7A2930069473100FF00FF00FF00FF00C7B2
          A300EADFD900EADFD900EADFD900EADFD900EADFD900B7A29300F4EFEC00F4EF
          EC00F4EFEC00F4EFEC00F4EFEC00F4EFEC00F4EFEC00F4EFEC00F4EFEC00F4EF
          EC00F4EFEC00F4EFEC00B7A29300EADFD900EADFD900EADFD900EADFD900B7A2
          930069473100FF00FF00FF00FF00C7B2A300EDE4DF00EDE4DF00EDE4DF00EDE4
          DF00EDE4DF00EDE4DF00B7A29300F8F4F200F8F4F200F8F4F200F8F4F200F8F4
          F200F8F4F200F8F4F200F8F4F200F8F4F200F8F4F200B7A29300EDE4DF00EDE4
          DF00EDE4DF00EDE4DF00EDE4DF00B7A2930069473100FF00FF00FF00FF00C7B2
          A300F0E8E400F0E8E400F0E8E400F0E8E400F0E8E400F0E8E400B7A29300B7A2
          9300FCFAF900FCFAF900FCFAF900FCFAF900FCFAF900FCFAF900FCFAF900FCFA
          F900B7A29300B7A29300F0E8E400F0E8E400F0E8E400F0E8E400F0E8E400B7A2
          930069473100FF00FF00FF00FF00C7B2A300F3EDE900F3EDE900F3EDE900F3ED
          E900F3EDE900B7A29300DDC5C200DDC5C200B7A29300DDC5C200FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00DDC5C200B7A29300DDC5C200DDC5C200B7A29300F3ED
          E900F3EDE900F3EDE900F3EDE900B7A2930069473100FF00FF00FF00FF00C7B2
          A300F6F1EF00F6F1EF00F6F1EF00F6F1EF00B7A29300DDC5C200FBF9F700F7F4
          F100DDC5C200C7B2A300B7A29300B7A29300B7A29300B7A29300C7B2A300DDC5
          C200DCCBC100DBC9BF00DDC5C200B7A29300F6F1EF00F6F1EF00F6F1EF00B7A2
          930069473100FF00FF00FF00FF00C7B2A300F9F6F400F9F6F400F9F6F400B7A2
          9300DDC5C200FFFFFF00FEFDFC00FBF9F700F7F4F100EEE0E000EEE0E000EEE0
          E000EEE0E000EEE0E000EEE0E000E4D7CF00E1D2C900DECDC400DBC9BF00DDC5
          C200B7A29300F9F6F400F9F6F400B7A2930069473100FF00FF00FF00FF00C7B2
          A300FCFBFA00FCFBFA00B7A29300C8B3A400FFFFFF00FFFFFF00B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300DECDC400DBC9BF00D2C0B300B7A29300FCFBFA00B7A2
          930069473100FF00FF00FF00FF00C7B2A300FFFFFF00B8A39400DDC5C200C8B3
          A400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFBF900F9F6F400F6F2
          EF00F3EDE900F0E8E400EDE4DF00EAE0D900E7DBD400E4D7CF00E1D2C900DECD
          C400D2BFB200DDC5C200B7A29300FFFFFF0069473100FF00FF00FF00FF00C7B2
          A300B7A29300DDC5C20027A5E900C8B3A400FFFFFF00FFFFFF00B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300E4D7CF00E1D2C900D1BEB10027A5E900DDC5C200B7A2
          930069473100FF00FF00FF00FF00C7B2A300DDC5C20027A5E90027A5E900C8B3
          A400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFB
          F900F9F6F400F6F2EF00F3EDE900F0E8E400EDE4DF00EAE0D900E7DBD400E4D7
          CF00D1BEB10027A5E90027A5E900B7A2930069473100FF00FF00FF00FF00FF00
          FF00C7B2A300DDC5C20047B6FF00C8B3A400FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFBF900F9F6F400F6F2EF00F3ED
          E900F0E8E400EDE4DF00EAE0D900E7DBD400D0BDB00047B6FF00B7A293006947
          3100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C7B2A300DDC5C200C8B3
          A400C8B3A400C8B3A400C8B3A400C8B3A400C8B3A400C9B4A500C9B5A600CAB6
          A700CBB6A800CBB7A900CCB8AA00CCB9AB00CDB9AB00CEBAAC00CEBBAD00CFBB
          AE00CFBCAF00BCA7980069473100FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00C7B2A300DDC5C200DBF3FA00DBF3FA00DBF3FA00D4F0
          FA00C7EBFB00B9E5FB00ACDFFB009ED9FC0091D4FC0082CEFD0073C8FD0064C2
          FE0055BCFE0047B6FF0047B6FF0047B6FF00BBA6970073533E00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C7B2
          A300EEE0E000DBF3FA00DBF3FA00DBF3FA00D4F0FA00C7EBFB00B9E5FB00B2E2
          FB00A5DCFC0097D6FC0089D1FC007BCBFD006CC5FD005DBFFE004EB9FE00B7A2
          930069473100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00C7B2A300EEE0E000DBF3FA00DBF3
          FA00DBF3FA00DBF3FA00CDEDFA00C0E8FB00B2E2FB00A5DCFC0097D6FC0089D1
          FC007BCBFD006CC5FD00B7A2930069473100FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00C7B2A300EEE0E000DBF3FA00DBF3FA00DBF3FA00DBF3FA00CDED
          FA00C0E8FB00B2E2FB00A5DCFC0097D6FC0089D1FC00B7A2930069473100FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C7B2A300EEE0
          E000DBF3FA00DBF3FA00DBF3FA00DBF3FA00CDEDFA00C0E8FB00B2E2FB00A5DC
          FC00B7A2930069473100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00C7B2A300EEE0E000EEE0E000EEE0E000EEE0
          E000EEE0E000EEE0E000DDC5C200B7A2930069473100FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00C7B2A300C7B2A300C7B2A300C7B2A300C7B2A300C7B2A300C7B2A300C7B2
          A300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          760C0000424D760C00000000000036000000280000001C0000001C0000000100
          200000000000400C000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000090C800006098000060
          9800006098000060980000609800006098000060980000609800006098000060
          9800006098000060980000609800006098000060980000609800006098000060
          9800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000090C80070D1EC000290C9000290C9000290C9000290C9000290C9000290
          C9000290C9000290C9000290C9000290C9000290C9000290C9000290C9000290
          C9000290C9000290C9000290C9000290C90000609800FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000090C80075D4EE0070D1EC006CCF
          EB0067CCE90062C9E8005EC7E70059C4E50054C1E4004FBEE2004BBBE10046B8
          DF0041B5DE003DB2DD0038AFDB0036AEDB0036AEDB0036AEDB0036AEDB000290
          C90000609800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000090C8007AD7EF00CAB5A600694731006947310069473100694731006947
          3100694731006947310069473100694731006947310069473100694731006947
          31006947310069473100694731000290C90000609800FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000090C8007EDAF000CAB5A600F0E9
          E500B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300694731000290
          C90000609800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000090C80083DDF200CAB5A600F2ECE900F0E9E500EEE5E100ECE2DD00EADF
          D900E7DBD500E5D8D100E3D4CD00E0D1C900DECEC500DDCCC300DBC9BF00DBC9
          BF00DBC9BF00B7A29300694731000290C90000609800FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000090C80088DFF300CAB5A600F5EF
          ED00F2ECE900F0E9E500EEE5E100ECE2DD00EADFD900E7DBD500E6D9D300E4D6
          CF00E1D3CB00DFCFC700DDCCC300DBC9BF00DBC9BF00B7A29300694731000290
          C90000609800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000090C8008CE2F500CAB5A600F7F3F100F5EFED00F2ECE900F0E9E5006971
          D000C1BDD800EBE0DB00E8DDD700E6D9D300E4D6CF00E1D3CB00DFCFC700DDCC
          C300DBC9BF00B7A29300694731000290C90000609800FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000090C80093E6F700CAB5A600F9F6
          F500F8F4F300F6F1EF00DDDBE800041AC7000418C200C1BDD800EBE0DB00E8DD
          D700E6D9D300E4D6CF00E1D3CB00DFCFC700DDCCC300B7A29300694731000290
          C90000609800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000090C80095E8F800CAB5A600FDFBFB00FAF8F700F8F4F3007B86DF000019
          CA000017C6004B57CC00EDE4DF00EBE0DB00E8DDD700E6D9D300E4D6CF00E1D3
          CB00DFCFC700B7A29300694731000290C90000609800FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000090C80095E8F800CAB5A600FFFF
          FF00FDFBFB00DCDEF300102AD4002339D3007A84DB000017C600B4B3DB00EDE4
          DF00EBE0DB00E8DDD700E6D9D300E4D6CF00E1D3CB00B7A29300694731000290
          C90000609800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000090C80095E8F800CAB5A600FFFFFF00FFFFFF006B7DE8000826D700AFB5
          E900F3EEEF002E41D0002638CB00E8E1E200EDE4DF00EBE0DB00E8DDD700E6D9
          D300E4D6CF00B7A29300694731000290C90000609800FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000090C80095E8F800CAB5A600FFFF
          FF00FFFFFF00FFFFFF00FDFBFB00FAF8F700F8F4F300CDCDE9000B23CC006E77
          D500EFE7E300EDE4DF00EBE0DB00E8DDD700E6D9D300B7A29300694731000290
          C90000609800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000090C80095E8F800CAB5A600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFB
          FB00FAF8F700F8F4F300AAAFE500041DCC00B2B3DF00EFE7E300EDE4DF00EBE0
          DB00E8DDD700B7A29300694731000290C90000609800FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000090C80095E8F800CAB5A600FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFBFB00FAF8F700F8F4F3008B94
          E200132BCE00D4D0E300F0E9E500EEE5E100ECE2DD00B7A29300694731000290
          C90000609800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000090C80095E8F800CAB5A600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FDFBFB00FAF8F700F9F6F5008B95E3002A3FD200E8E3E800F0E9
          E500EEE5E100B7A29300694731000290C90000609800FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000090C80095E8F800CAB5A600FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFDFD00FCFA
          F900F9F6F5009BA3E5004153D500E8E3E800F0E9E500B7A29300694731000290
          C90000609800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000090C80095E8F800CAB5A600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FEFDFD00FCFAF900F9F6F500C6C8EA006874
          DA00F2ECE900B7A29300694731000290C90000609800FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000090C80095E8F800CAB5A600FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FEFDFD00FCFAF900F9F6F500F7F3F100F5EFED00B7A29300694731000290
          C90000609800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000090C80095E8F800CAB5A600FFFFFF00FFFFFF00B7A29300B7A29300B7A2
          9300B7A29300B8A39400B9A49500BAA59700BBA69800BCA89A00BDA99B00BFAA
          9C00F7F3F100B7A29300694731000290C90000609800FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000090C80095E8F800CAB5A600FFFF
          FF00B7A293000060900000609000006090000060900000609000006090000060
          900000609000006090000060900000609000BFAA9C0069473100694731000290
          C90000609800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000090C80095E8F800CAB5A600CAB5A600006098004EBDE3004EBDE3004EBD
          E3004EBDE3004EBDE3006ED0EC006ED0EC004EBDE3004EBDE3004EBDE3000290
          C90000436E00CAB5A600CAB5A6000290C90000609800FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000090C80095E8F80095E8F80095E8
          F80095E8F800006098006ED0EC006ED0EC006ED0EC0000436E000290C9006ED0
          EC006ED0EC006ED0EC000290C90000436E0088DFF30083DDF2007EDAF0000290
          C90000609800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000090C80080C4E80095E8F80095E8F80095E8F80095E8F800006098006ED0
          EC006ED0EC0000436E0000436E0095E8F8006ED0EC000290C90000436E0091E5
          F6008CE2F50088DFF30083DDF2005DB4E1000290C900FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000090C8000090C8000190
          C8000190C8000190C8000060980095E8F80095E8F80095E8F80095E8F80095E8
          F80095E8F8000290C90000436E000290C9000290C9000290C9000290C9000290
          C900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000060
          9800006098000060980000609800006098000060980000609800FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          760C0000424D760C00000000000036000000280000001C0000001C0000000100
          200000000000400C000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00D0BAAC006947310069473100694731006947
          3100694731006947310069473100694731006947310069473100694731006947
          3100694731006947310069473100694731006947310069473100694731006947
          31006947310069473100694731006947310069473100FF00FF00FF00FF00D0BA
          AC00FAF8F600B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          930069473100FF00FF00FF00FF00D0BAAC00FCFAF900FAF8F600F8F5F300F6F2
          F000F5F0ED00F3EDE900F1EAE600EFE8E300EDE5E000ECE2DE00EBE0DB00E9DD
          D700E7DAD400E5D7D100E3D5CD00E1D2CA00DFCFC700DDCDC300DBCAC000DBC9
          BF00DBC9BF00DBC9BF00DBC9BF00B7A2930069473100FF00FF00FF00FF00D0BA
          AC00FDFDFC00B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300DBC9BF00B7A2
          930069473100FF00FF00FF00FF00D0BAAC00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00B7A29300FFFFFF00FFFFFF00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00B7A29300FFFFFF00FFFFFF00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00B7A29300DBC9BF00B7A2930069473100FF00FF00FF00FF00D0BA
          AC00FFFFFF00B7A29300FFFFFF00FFFFFF00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00B7A29300FFFFFF00FFFFFF00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00B7A29300FFFFFF00FFFFFF00FFFFFF00B7A29300DBC9BF00B7A2
          930069473100FF00FF00FF00FF00D0BAAC00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00B7A29300FFFFFF00FFFFFF00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00B7A29300FFFFFF00FFFFFF00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00B7A29300DBCAC000B7A2930069473100FF00FF00FF00FF00D0BA
          AC00FFFFFF00B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300C8600000C8600000C860
          0000C8600000C8600000B7A29300B7A29300B7A29300B7A29300DECEC500B7A2
          930069473100FF00FF00FF00FF00D0BAAC00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00B7A29300FFFFFF00FFFFFF00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00C8600000FDEDE300FDEDE300FDEDE300C8600000FFFFFF00FFFF
          FF00FFFFFF00B7A29300E0D1C800B7A2930069473100FF00FF00FF00FF00D0BA
          AC00FFFFFF00B7A29300FFFFFF00FFFFFF00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00B7A29300FFFFFF00FFFFFF00FFFFFF00C8600000F8C8C800FDED
          E300FDEDE300C8600000FFFFFF00FFFFFF00FFFFFF00B7A29300E2D3CC00B7A2
          930069473100FF00FF00FF00FF00D0BAAC00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00B7A29300FFFFFF00FFFFFF00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00C860000090300000F8C8C800FDEDE300C8600000FFFFFF00FFFF
          FF00FFFFFF00B7A29300E4D6CF00B7A2930069473100FF00FF00FF00FF00D0BA
          AC00FFFFFF00B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300C8600000C8600000C860
          0000C8600000C8600000B7A29300B7A29300B7A29300B7A29300E6D9D200B7A2
          930069473100FF00FF00FF00FF00D0BAAC00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00B7A29300FFFFFF00FFFFFF00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00B7A29300FFFFFF00FFFFFF00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00B7A29300E8DBD600B7A2930069473100FF00FF00FF00FF00D0BA
          AC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00B7A29300FFFFFF00FFFFFF00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00B7A29300FFFFFF00FFFFFF00FFFFFF00B7A29300EBE0DB00B7A2
          930069473100FF00FF00FF00FF00D0BAAC00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00B7A29300FFFFFF00FFFFFF00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00B7A29300FFFFFF00FFFFFF00FFFFFF00B7A29300FFFFFF00FFFF
          FF00FFFFFF00B7A29300ECE2DE00B7A2930069473100FF00FF00FF00FF00D0BA
          AC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300EDE5E000B7A2
          930069473100FF00FF00FF00FF00D0BAAC00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FDFDFC00FCFAF900FAF8F600F8F5F300F6F2F000F5F0
          ED00F3EDE900F1EAE600EFE8E300B7A2930069473100FF00FF00FF00FF00CD76
          2100CD762100CD762100CD762100CD762100CD762100CD762100CD762100CD76
          2100CD762100CD762100CD762100CD762100CD762100CD762100CD762100CD76
          2100CD762100CD762100CD762100CD762100CD762100CD762100CD762100CD76
          210069473100FF00FF00FF00FF00CD762100FBC39F00FBC39F00FBC39F00FBC3
          9F00FBC39F00FBC39F00FBBE9700FAB89000FAB28800F9AC8000F8A67900F8A0
          7100F79A6900F7956200F78F5B00F6895300F6834B00F57D4400F5773C00F471
          3400F46B2D00F46B2D00F46B2D00F46B2D0069473100FF00FF00FF00FF00CD76
          2100FBC39F00FBC39F00FBC39F0069473100FBC39F00FBC39F00FBC39F00FBBE
          9700FAB89000FAB28800F9AC8000F8A67900F8A07100F79A6900F7956200F78F
          5B00F6895300F6834B00F57D440069473100F4713400F46B2D00F46B2D00F46B
          2D0069473100FF00FF00FF00FF00CD762100FBC39F00FBC39F00A36F5A00A36F
          5A0069473100FBC39F00FBC39F00FBC39F00FBBE9700FAB89000FAB28800F9AC
          8000F8A67900F8A07100F79A6900F7956200F78F5B00F6895300A36F5A00A36F
          5A0069473100F4713400F46B2D00F46B2D0069473100FF00FF00FF00FF00CD76
          2100FBC39F00FBC39F00A36F5A00C898980069473100FBC39F00FBC39F00FBC3
          9F00FBC39F00FBBE9700FAB89000FAB28800F9AC8000F8A67900F8A07100F79A
          6900F7956200F78F5B00A36F5A00C898980069473100F5773C00F4713400F46B
          2D0069473100FF00FF00FF00FF00CD762100FBC39F00FBC39F00A36F5A00E4B4
          B40069473100FBC39F00FBC39F00FBC39F00FBC39F00FBC39F00FBC19B00FBBB
          9400FAB58C00F9AF8400F8A67900F8A07100F79A6900F7956200A36F5A00E4B4
          B40069473100F57D4400F5773C00F471340069473100FF00FF00FF00FF00CD76
          2100CD762100CD762100A36F5A00F5C5C50069473100CD762100CD762100CD76
          2100CD762100CD762100CD762100CD762100CD762100CD762100CD762100CD76
          2100CD762100CD762100A36F5A00F5C5C50069473100CD762100CD762100CD76
          2100CD762100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A36F5A00FFFF
          FF0069473100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A36F5A00FFFF
          FF0069473100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00A36F5A00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00A36F5A00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          760C0000424D760C00000000000036000000280000001C0000001C0000000100
          200000000000400C000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00D5BFB1006947310069473100694731006947
          3100694731006947310069473100694731006947310069473100694731006947
          3100694731006947310069473100694731006947310069473100694731006947
          31006947310069473100694731006947310069473100FF00FF00FF00FF00D5BF
          B100F7F3F100B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          930069473100FF00FF00FF00FF00D5BFB100F9F6F400F7F3F100F5F1EE00F4EE
          EB00F2ECE800F1EAE600EFE7E300EDE5E000ECE3DD00EBE1DB00E9DED800E7DC
          D500E6D9D200E4D7CF00E3D5CD00E1D2CA00DFD0C700DECDC400DCCBC100DBC9
          BF00DBC9BF00DBC9BF00DBC9BF00B7A2930069473100FF00FF00FF00FF00D5BF
          B100FBF9F800E5EDE200B0CCAC002F872800146D0E00136F0D0013700D001370
          0D00136F0D00146D0E00156B0E001E821B00A4BB9700D4D1C200E4D7CF00E3D5
          CD00E1D2CA00DFD0C700DECDC400DCCBC100DBC9BF00DBC9BF00DBC9BF00B7A2
          930069473100FF00FF00FF00FF00D5BFB100FDFCFB0059AA53002E771E004487
          2F0044933000409A2E003D9F2D003D9F2D003F9C2D0044942F00488C3200307D
          20001A73110047964100E6D9D200A1745C00A1745C00A1745C00A1745C00A174
          5C00A1745C00A1745C00DBC9BF00B7A2930069473100FF00FF00FF00FF00D5BF
          B100FEFEFD00158B0E004B863300449330003D9F2D0038A82A0033AB270032AA
          260037AA2A003DA02C0042962F004A8932002C7C1D0000680000E7DCD500E6D9
          D200E4D7CF00E3D5CD00E1D2CA00DFD0C700DECDC400DCCBC100DBC9BF00B7A2
          930069473100FF00FF00FF00FF00D5BFB100FFFFFF00148D0E00488C3100409B
          2E0038A82A0030B126001B911700188D15002BAD220037AA2A003E9E2D00468F
          30002A7F1C00006E0000EADFD900A1745C00A1745C00A1745C00A1745C00A174
          5C00A1745C00A1745C00DCCBC100B7A2930069473100FF00FF00FF00FF00D5BF
          B100FFFFFF009ECB9800459030003E9E2D0032AC27001E961A00589D58006EAD
          6D001D93190030AE26003BA22C003B9029000E730B0084AF7C00EBE2DC00EADF
          D900E8DDD600E7DBD400E5D8D100E3D6CE00E2D3CB00E0D1C800DFCFC600B7A2
          930069473100FF00FF00FF00FF00D5BFB100FFFFFF00D0EAD0003FA13600399E
          2A00269D1E002D802E00A5D0B400BCD5CC00428A4600289820003BA12C003587
          290098B59000EEE6E100EDE4DF00A1745C00A1745C00A1745C00A1745C00A174
          5C00A1745C00A1745C00E0D1C800B7A2930069473100FF00FF00FF00FF00D5BF
          B100FFFFFF00FFFFFF00CAE8CA002E9F2800298F3300548E94005A96BE005792
          BC004386900039824D001677110098BA9200F1EBE700F0E8E400EEE6E100EDE4
          DF00EBE2DC00EADFD900E8DDD600E7DBD400E5D8D100E3D6CE00E2D3CB00B7A2
          930069473100FF00FF00FF00FF00D5BFB100FFFFFF00FFFFFF00FFFFFF00C5E0
          E20055A1C80055A1D50053A1D600509ED4004C9ACF004C8DB3009AB1B300EFEC
          E900F3EDEA00F1EBE700F0E8E400EEE6E100EDE4DF00EBE2DC00EADFD900E8DD
          D600E7DBD400E5D8D100E3D6CE00B7A2930069473100FF00FF00FF00FF00D5BF
          B100FFFFFF00FFFFFF00FFFFFF0077B3DA005AA7DC005BA8DC005AA7DB0057A4
          D90053A1D6004D9BD000598AAC00E6E6E600F5F1EE00F4EEEB00F2ECE800F1EA
          E600EFE7E300EDE4DF00EBE2DC00EADFD900E8DDD600E7DBD400E5D8D100B7A2
          930069473100FF00FF00FF00FF00D5BFB100FFFFFF00FFFFFF00B4D6EB0063AB
          DC0060ADE10061AEE20060ADE1005DAADE0059A6DB0053A1D6004C93C400ABBA
          C200F7F3F100F5F1EE00F4EEEB00F2ECE800F1EAE600EFE7E300EDE5E000ECE3
          DD00EBE1DB00E9DED800E7DBD400B7A2930069473100FF00FF00FF00FF00D5BF
          B100FFFFFF00FFFFFF0072C5DF0054ADDF0068B4E70068B5E80066B3E60062AF
          E2005EABDF0058A5DA00519ED4006B98AE00F9F6F400F7F3F100F5F1EE00F4EE
          EB00F2ECE800F1EAE600EFE7E300EDE5E000ECE3DD00EBE1DB00E9DED800B7A2
          930069473100FF00FF00FF00FF00D5BFB100FFFFFF00FFFFFF0072C5DF0051A8
          D80069B3E4006EBAEC006BB7EA0066B3E50060ADE1005AA7DB0054A2D7003386
          A800FAF8F600F9F6F400F7F3F100F5F1EE00F4EEEB00F2ECE800F1EAE600EFE7
          E300EDE5E000ECE3DD00EBE1DB00B7A2930069473100FF00FF00FF00FF00D5BF
          B100FFFFFF00FFFFFF0072C5DF003F93C0004E94C000549BC70061A9D80064AF
          E10061AEE10058A4D8004E98CA003285A700FCFAF900FAF8F600F9F6F400F7F3
          F100F5F1EE00F4EEEB00F2ECE800F1EAE600EFE7E300EDE5E000ECE3DD00B7A2
          930069473100FF00FF00FF00FF00D5BFB100FFFFFF00FFFFFF00BFE5F1003BA1
          CD0059A1CE00579ECC005197C3005198C500549DCC00478EBB002A7AA40092BE
          D000FEFEFD00FCFAF900FAF8F600F7A07300F7A07300F7A07300F7A07300F7A0
          7300F7A07300F7A07300EDE5E000B7A2930069473100FF00FF00FF00FF00D5BF
          B100FFFFFF00FFFFFF00FFFFFF004BB5D8005EAEDD0064ADDB005AA1CF004F95
          C200458AB6003A80AB00277BA200E7F1F400FFFFFF00FEFEFD00FDFCFB00FBF9
          F800F9F7F500F8F4F200F6F2EF00F4EEEB00F2ECE800F1EAE600EFE7E300B7A2
          930069473100FF00FF00FF00FF00D5BFB100FFFFFF00FFFFFF00FFFFFF00EFF8
          FB005ABADD005DB2E10060A9D700539BC700468DB9003B87AB00C5DCE500FFFF
          FF00FFFFFF00FFFFFF00FEFEFD00F7A07300F7A07300F7A07300F7A07300F7A0
          7300F7A07300F7A07300F1EBE700B7A2930069473100FF00FF00FF00FF00D5BF
          B100FFFFFF00FFFFFF00FFFFFF00FFFFFF00E3F4F90052B7DA001C8CBF001887
          BA001D88B900CEE2E900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
          FD00FDFCFB00FBF9F800F9F7F500F8F4F200F6F2EF00F5F0ED00F3EDEA00B7A2
          930069473100FF00FF00FF00FF00D5BFB100FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFD00FDFCFB00FBF9F800F9F7
          F500F8F4F200F6F2EF00F5F0ED00F3EDEA0069473100FF00FF00FF00FF00D5BF
          B100D5BFB100D5BFB100D5BFB100D5BFB100D5BFB100D5BFB100D5BFB100D5BF
          B100D5BFB100D5BFB100D5BFB100D5BFB100D5BFB100D5BFB100D5BFB100D5BF
          B100D5BFB100D5BFB100D5BFB100D5BFB100D5BFB100D5BFB100D5BFB100D5BF
          B100D5BFB100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          760C0000424D760C00000000000036000000280000001C0000001C0000000100
          200000000000400C000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007088
          9000405860004050600040506000404850003040500030404000303840003030
          4000202830002028300020283000202020001020200010182000101820001010
          2000101020001010200010102000101020001010200010102000101020001010
          200010102000FF00FF00FF00FF007090A000A0E0F00060C0E00060C0E00060B8
          E00060B8D00050B0D00050A8D00050A8C00040A0C00040A0C0004098C0003090
          B0003090B0003088B0003080B0002080B0002080B0002080A0002078A0002078
          A0002078A0002078A0002078A0002078A00010102000FF00FF00FF00FF008090
          A000A0E0F00080D8F00080D8F00070C8E00060C0E00060C0E00050B8E00050B8
          E00040B0E00040B0E00040A8E00040A8D00030A0D00030A0D00030A0D0003098
          D0003098D0002098D0002090D0002090C0002088C0002088C0002078A0002078
          A00010102000FF00FF00FF00FF008090A000A0E0F00080D8F00080D8F00080D0
          F00070D0F00070C8F00060C8F00060C0F00050C0F00050C0F00050B8F00040B8
          E00040B0E00040B0E00030A8E00030A8E00030A8E00030A0E00020A0D0002098
          D0002098D0002088C0002078A0002078A00010182000FF00FF00FF00FF008090
          A000B0E8F00090D8F00090D8F00080D8F00080D0F00070D0F00060C8F00060C8
          F00050C0F00050C0F00050C0F00040B8F00040B0E00040B0E00040A8E00030A8
          E00030A8E00030A0E00030A0D00020A0D0002098D0002090C0002078A0002078
          A00010202000FF00FF00FF00FF008090A000B0E8FF0090E0F00090E0F00090D8
          F00080D8F00070D0F00070D0F00060C8F00060C8F00060C8F00050C0F00050C0
          F00040B8E00040B0E00040B0E00040A8E00040A8E00030A8E00030A0E00030A0
          D0002098D0002090C0002078A0002078A00020203000FF00FF00FF00FF008090
          A000B0E8FF0090E0F00090E0F00090D8F00080D8F00070D0F00070D0F00060C8
          F00060C8F00060C8F00050C0F00050C0F00040B8E00040B0E00040B0E00040A8
          E00040A8E00030A8E00030A0E00030A0D0002098D0002090C0002078A0002078
          A00020203000FF00FF00FF00FF008090A000B0E8FF00A0E0F000A0E0F00090E0
          F00080D8F00080D0F00070D0F00070C8F00060C8F00060C8F00060C0F00050C0
          F00050C0F00040B8E00040B0E00040B0E00040B0E00030A8E00030A8E00030A0
          E00030A0D0002090D0002080B0002080B00020283000FF00FF00FF00FF008098
          A000C0F0FF00A0E0F000A0E0F000A0E0F00090E0F00080D8F00080D0F00070D0
          F00060C8F00060C8F00060C8F00050C0F00050C0F00050B8F00040B8E00040B0
          E00040B0E00040B0E00030A8E00030A8E00030A0E0002098D0002080B0002080
          B00030304000FF00FF00FF00FF008098A000C0F0FF00A0E8F000A0E8F000A0E0
          F00090E0F00090D8F00080D8F00080D0F00070D0F00070D0F00060C8F00060C8
          F00050C0F00050C0F00050B8F00040B8E00040B8E00040B0E00040B0E00030A8
          E00030A8E0003098D0003088B0003088B00030384000FF00FF00FF00FF008098
          A000C0F0FF00B0E8FF00B0E8FF00A0E8F000A0E0F00090E0F00090D8F00080D8
          F00070D0F00070D0F00070D0F00060C8F00060C0F00050C0F00050C0F00050B8
          F00050B8F00040B8E00040B0E00040B0E00030A8E0003098D0003090B0003090
          B00040405000FF00FF00FF00FF008098A000C0F0FF00B0E8FF00B0E8FF00B0E8
          F000A0E8F000A0E0F00090E0F00080D8F00080D0F00080D0F00070D0F00070C8
          F00060C8F00060C0F00050C0F00050C0F00050C0F00040B8F00040B0E00040B0
          E00040A8E00030A0D0003090C0003090C00040485000FF00FF00FF00FF008098
          A000D0F0FF00B0F0FF00B0F0FF00B0E8FF00A0E8F000A0E0F00090E0F00090D8
          F00080D8F00080D8F00080D0F00070D0F00060C8F00060C8F00050C0F00050C0
          F00050C0F00050C0F00040B8E00040B0E00040B0E00030A0D0004098C0004098
          C00040506000FF00FF00FF00FF008098A000D0F0FF00B0F0FF00B0F0FF00B0E8
          FF00A0E8F000A0E0F00090E0F00090D8F00080D8F00080D8F00080D0F00070D0
          F00060C8F00060C8F00050C0F00050C0F00050C0F00050C0F00040B8E00040B0
          E00040B0E00030A0D0004098C0004098C00040506000FF00FF00FF00FF008098
          A000D0F0FF00C0F0FF00C0F0FF00B0F0FF00B0E8FF00A0E8F000A0E0F00090E0
          F00090D8F00090D8F00080D8F00070D0F00070D0F00060C8F00060C8F00050C0
          F00050C0F00050C0F00050C0F00040B8E00040B0E00040A8D00040A0C00040A0
          C00050586000FF00FF00FF00FF008098A000D0F8FF00C0F0FF00C0F0FF00C0F0
          FF00B0E8FF00B0E8F000A0E8F000A0E0F00090E0F00090E0F00080D8F00080D8
          F00070D0F00070C8F00060C8F00060C0F00060C0F00050C0F00050C0F00050B8
          F00040B8E00040B0E00050A8D00050A8D00050607000FF00FF00FF00FF008098
          A000D0F8FF00D0F8FF00D0F8FF00D0F0FF00C0F0FF00C0F0FF00C0F0FF00B0E8
          FF00B0E8F000B0E8F000A0E0F000A0E0F00090D8F00090D8F00080D8F00080D0
          F00080D0F00080D0F00070D0F00070D0F00070C8F00070C8F00070B0D00070B0
          D00060707000FF00FF00FF00FF008098A0008098A0008098A0008098A0008098
          A0008098A0008090A0008090A0007090A0007088900070889000708890007088
          9000708890007080900070809000708090007080900070809000708090007080
          900070809000708090007080900070809000FF00FF00FF00FF00FF00FF008098
          A00090B8C000A0D0E000A0D0E000A0D0E000A0D0E000A0D0D000A0C8D00090C8
          D00090C8D00090C8D00080B8C0008098A000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF008098A000B0D8E000B0D8E000C0F0
          FF00C0F0FF00C0F0FF00B0F0FF00B0E8FF00A0D0E000A0D0E0008098A000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF008098A000B0D8E000B0D8E000C0F0FF00C0F0FF00C0F0FF00B0F0FF00B0E8
          FF00A0D0E000A0D0E0008098A000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008098A0008098A0008098
          A0008098A0008098A0008090A0008090A0008098A0008098A000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          760C0000424D760C00000000000036000000280000001C0000001C0000000100
          200000000000400C000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00C7B2A30069473100694731006947
          3100694731006947310069473100694731006947310069473100694731006947
          3100694731006947310069473100694731006947310069473100694731006947
          31006947310069473100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00C7B2A300DFD0C700B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A2930069473100FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00C7B2A300B7A29300DFD0C700DFD0
          C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0
          C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0
          C700B7A2930069473100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00C7B2A300DFD0C700B7A29300E6DAD300E6DAD300E6DAD300E6DAD300E6DA
          D300E6DAD300E6DAD300E6DAD300E6DAD300E6DAD300E6DAD300E6DAD300E6DA
          D300E6DAD300E6DAD300E6DAD300B7A29300B7A2930069473100FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00C7B2A300E4D7CF00E4D7CF00B7A2
          9300EEE5DF00EEE5DF00EEE5DF00EEE5DF00EEE5DF00EEE5DF00EEE5DF00EEE5
          DF00EEE5DF00EEE5DF00EEE5DF00EEE5DF00EEE5DF00EEE5DF00B7A29300DFD0
          C700B7A2930069473100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00C7B2A300E9DED800E9DED800E9DED800B7A29300F2EBE800F2EBE800F2EB
          E800F2EBE800F2EBE800F2EBE800F2EBE800F2EBE800F2EBE800F2EBE800F2EB
          E800F2EBE800B7A29300E6DAD300E6DAD300B7A2930069473100FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00C7B2A300EEE5E000EEE5E000EEE5
          E000EEE5E000B7A29300F6F2F000F6F2F000F6F2F000F6F2F000F6F2F000F6F2
          F000F6F2F000F6F2F000F6F2F000F6F2F000B7A29300EEE5DF00EEE5DF00EEE5
          DF00B7A2930069473100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00C7B2A300F1EAE700F1EAE700F1EAE700F1EAE700F1EAE700B7A29300FBF9
          F800FBF9F800FBF9F800FBF9F800FBF9F800FBF9F800FBF9F800FBF9F800B7A2
          9300F2EBE800F2EBE800F2EBE800F2EBE800B7A2930069473100FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00C7B2A300F4EFED00F4EFED00F4EF
          ED00F4EFED00B7A29300EEE0E000B7A29300FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00B7A29300DDC5C200B7A29300F6F2F000F6F2F000F6F2
          F000B7A293006947310085929900006090000060900000609000006090000060
          9000C7B2A300F8F4F300F8F4F300F8F4F300B7A29300EEE0E000FBF8F700EEE0
          E000B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300DDC5C200DBC9
          BF00DDC5C200B7A29300FBF9F800FBF9F800B7A2930069473100859299008BF0
          F7000691CD000691CD000691CD000691CD00C7B2A300FCFAF900FCFAF900B7A2
          9300EEE0E000FFFFFF00FEFDFD00FBF8F700EEE0E000EEE0E000EEE0E000EEE0
          E000EEE0E000EEE0E000E4D6CF00E0D1C800DCCBC200DDC5C200B7A29300FFFF
          FF00B7A2930069473100859299008BF0F70087EEF70083ECF7007FEAF6007CE8
          F600C7B2A300FFFFFF00B8A39400FFFFFF00FFFFFF00B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300E0D1C800DCCBC200C8B3A400B7A29300F7F1EA0069473100859299008EF2
          F8008BF0F70087EEF70083ECF7007FEAF600C7B2A300B7A29300C8B3A400FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFAFA00F9F5F400F5F0
          EE00F2EBE800EEE6E200EBE1DC00E8DCD600E4D6CF00E0D1C800C8B3A400DDC5
          C200D1A09E00694731008592990092F4F8008EF2F8008BF0F70087EEF70083EC
          F700C7B2A30027A5E900C8B3A400FFFFFF00FFFFFF00B7A29300B7A29300B7A2
          9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
          9300E8DCD600E4D6CF00C8B3A40027A5E900B7A29300694731008592990092F4
          F80092F4F8008EF2F8008BF0F70087EEF700C7B2A30027A5E900C8B3A400FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFA
          FA00F9F5F400F5F0EE00F2EBE800EEE6E200EBE1DC00E8DCD600C8B3A40027A5
          E900B7A29300694731008592990092F4F80092F4F80092F4F8008EF2F8008BF0
          F70087EEF700C7B2A300C8B3A400C8B3A400C8B3A400C8B3A400C8B3A400C8B3
          A400C8B3A400C8B3A400C8B3A400C8B3A400C8B3A400C8B3A400C8B3A400C8B3
          A400C8B3A400C8B3A400C8B3A400B9A4950069473100FF00FF008592990092F4
          F80092F4F80092F4F80092F4F80090F3F8008DF1F80089EFF700C7B2A300DBF3
          FA00DBF3FA00DBF3FA00D3F0FA00C5EAFB00B6E3FB00A7DDFC0098D7FC0089D1
          FC007BCBFD006CC5FD005DBFFE004EB9FE0047B6FF0047B6FF00B7A293006947
          3100FF00FF00FF00FF008592990092F4F80092F4F80092F4F80092F4F80092F4
          F80090F3F8008DF1F80089EFF700C7B2A300DBF3FA00DBF3FA00DBF3FA00D3F0
          FA00C5EAFB00B6E3FB00A7DDFC0098D7FC0091D4FC0082CEFD0073C8FD0064C2
          FE0055BCFE00B7A2930069473100FF00FF00FF00FF00FF00FF008592990092F4
          F80092F4F80092F4F80092F4F80092F4F80092F4F80090F3F8008DF1F80089EF
          F700C7B2A300DBF3FA00DBF3FA00DBF3FA00DBF3FA00CCEDFB00BDE6FB00AEE0
          FB009FDAFC0091D4FC0082CEFD0073C8FD00B7A2930069473100FF00FF00FF00
          FF00FF00FF00FF00FF008592990092F4F80092F4F80092F4F80092F4F80092F4
          F80092F4F80092F4F80090F3F8008DF1F80089EFF700C7B2A300DBF3FA00DBF3
          FA00DBF3FA00DBF3FA00CCEDFB00BDE6FB00AEE0FB009FDAFC0091D4FC00B7A2
          930069473100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008592990092F4
          F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F80090F3
          F8008DF1F80089EFF700C7B2A300DBF3FA00DBF3FA00DBF3FA00DBF3FA00CCED
          FB00BDE6FB00AEE0FB009FDAFC0069473100FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008592990092F4F80092F4F80092F4F80092F4F80092F4
          F80092F4F80092F4F80092F4F80092F4F80090F3F8008DF1F80089EFF700C7B2
          A300C7B2A300C7B2A300C7B2A300C7B2A300C7B2A300C7B2A300C7B2A3000060
          9000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008592990092F4
          F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4
          F80092F4F80090F3F8008DF1F80089EFF70085EDF70081EBF6007EE9F6007AE7
          F60076E5F50072E3F5000691CD0000609000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008592990092F4F80092F4F80092F4F80092F4F80092F4
          F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F80092F4F8008EF2
          F8008BF0F70087EEF70083ECF7007EE9F6007AE7F60072E3F50072E3F5000060
          9000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00859299008592
          9900859299008592990085929900859299008592990085929900859299008592
          9900859299008592990085929900859299008592990085929900859299008592
          990085929900859299008592990085929900FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008592990095F6F80092F4F80091F2F80090F1F8008EF0
          F8008DEFF80090F1F80079CADE0085929900FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008592990084DB
          E80094F5F80092F4F80091F2F80090F1F80090F1F80079CADE0085929900FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00859299008592990085929900859299008592
          99008592990085929900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          760C0000424D760C00000000000036000000280000001C0000001C0000000100
          200000000000400C000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF006C8C9C002936430029364300293643002936430029364300293643002936
          4300293643002936430029364300293643002936430029364300293643002936
          4300293643002936430029364300293643002936430029364300293643002936
          4300FF00FF00FF00FF00FF00FF006C8C9C00335D7100335D7100335D7100335D
          7100335D7100335D7100335D7100335D7100335D7100335D7100335D7100335D
          7100335D7100335D7100335D7100335D7100335D71005CCAE10077DEEB0085E9
          F00098F8F80098F8F80098F8F80029364300FF00FF00FF00FF00FF00FF006C8C
          9C008DEFF30053A3B70053A3B70053A3B70053A3B70053A3B70053A3B70053A3
          B70053A3B70053A3B70053A3B70053A3B70053A3B70053A3B70053A3B70053A3
          B70053A3B700335D71005CCAE10077DEEB0085E9F00098F8F80098F8F8002936
          4300FF00FF00FF00FF00FF00FF006C8C9C0092F4F6008DEFF30087EBF10082E7
          EF007CE3ED0077DEEB0071DAE9006CD6E70066D2E50061CEE3005CCAE10056C5
          DE0051C1DC004BBDDA0046B9D80040B4D60053A3B7005CCAE100335D71005CCA
          E10077DEEB0085E9F00098F8F80029364300FF00FF00FF00FF00FF00FF006C8C
          9C0098F8F80092F4F6008DEFF30087EBF10082E7EF007CE3ED0077DEEB0071DA
          E9006CD6E70066D2E50061CEE3005CCAE10056C5DE0051C1DC004BBDDA0046B9
          D80053A3B70077DEEB005CCAE100335D71005CCAE10077DEEB0085E9F0002936
          4300FF00FF00FF00FF00FF00FF006C8C9C0098F8F80098F8F80092F4F6008DEF
          F30087EBF10082E7EF007CE3ED0077DEEB0071DAE9006CD6E70066D2E50061CE
          E3005CCAE10056C5DE0051C1DC004BBDDA0053A3B70085E9F00077DEEB005CCA
          E100335D71005CCAE10077DEEB0029364300FF00FF00FF00FF00FF00FF006C8C
          9C0098F8F80098F8F80098F8F80095F6F70090F2F5008AEDF20085E9F0007CE3
          ED0077DEEB0071DAE9006CD6E70066D2E50061CEE3005CCAE10056C5DE0051C1
          DC0053A3B70098F8F80085E9F00077DEEB005CCAE100335D71005CCAE1002936
          4300FF00FF00FF00FF00FF00FF006C8C9C0098F8F80098F8F80098F8F80098F8
          F80095F6F70090F2F5008AEDF20085E9F0007FE5EE007AE1EC0074DCEA006FD8
          E80069D4E60064D0E4005ECCE20056C5DE0053A3B70053A3B70053A3B70053A3
          B70053A3B70053A3B700335D710029364300FF00FF00FF00FF00FF00FF006C8C
          9C0098F8F80098F8F80098F8F80098F8F80098F8F80095F6F70090F2F5008AED
          F20085E9F0007FE5EE007AE1EC0074DCEA006FD8E80069D4E60064D0E4005ECC
          E20059C7DF0053C3DD004EBFDB0048BBD90043B6D70053A3B700335D71002936
          4300FF00FF00FF00FF00FF00FF006C8C9C0098F8F80098F8F80098F8F80098F8
          F80098F8F80098F8F80095F6F70090F2F5008AEDF20085E9F0007FE5EE007AE1
          EC0074DCEA006FD8E80069D4E60064D0E4005ECCE20059C7DF0053C3DD004EBF
          DB0048BBD90053A3B700335D710029364300FF00FF00FF00FF00FF00FF006C8C
          9C0098F8F80098F8F80098F8F80098F8F80098F8F80098F8F80098F8F80095F6
          F70090F2F5008AEDF20085E9F0007FE5EE007AE1EC0074DCEA006FD8E80069D4
          E60064D0E4005ECCE20059C7DF0053C3DD004EBFDB0053A3B700335D71002936
          4300FF00FF00FF00FF00FF00FF006C8C9C0098F8F80098F8F80098F8F80098F8
          F80098F8F80098F8F80098F8F80098F8F80095F6F70090F2F5008AEDF20085E9
          F0007FE5EE007AE1EC0074DCEA006FD8E80069D4E60064D0E4005ECCE20059C7
          DF0053C3DD0053A3B700335D710029364300FF00FF00FF00FF00FF00FF006C8C
          9C0098F8F80098F8F80098F8F80098F8F80098F8F80098F8F80098F8F80098F8
          F80098F8F80095F6F70090F2F5008AEDF20085E9F0007FE5EE007AE1EC0074DC
          EA006FD8E80069D4E60064D0E4005ECCE20059C7DF0053A3B700335D71002936
          4300FF00FF00FF00FF00FF00FF006C8C9C0098F8F80098F8F80098F8F80098F8
          F80098F8F80098F8F80098F8F80098F8F80098F8F80098F8F80098F8F80092F4
          F6008DEFF30087EBF10082E7EF007AE1EC0074DCEA006FD8E80069D4E60064D0
          E4005ECCE20053A3B700335D710029364300FF00FF00FF00FF00FF00FF006C8C
          9C0098F8F80098F8F80098F8F80098F8F80098F8F80098F8F80098F8F80098F8
          F80098F8F80098F8F80098F8F80098F8F80092F4F6008DEFF30087EBF10082E7
          EF007CE3ED0077DEEB0071DAE9006CD6E70066D2E50053A3B700335D71002936
          4300FF00FF00FF00FF00FF00FF006C8C9C0098F8F80098F8F80098F8F80098F8
          F80098F8F80098F8F80098F8F80098F8F80098F8F80098F8F80098F8F80098F8
          F80098F8F80092F4F6008DEFF30087EBF10082E7EF007CE3ED0077DEEB0071DA
          E9006CD6E70053A3B700335D710029364300FF00FF00FF00FF00FF00FF006C8C
          9C0098F8F80098F8F80098F8F80098F8F80098F8F80098F8F80098F8F80098F8
          F80098F8F80098F8F80098F8F80098F8F80098F8F80098F8F80092F4F6008DEF
          F30087EBF10082E7EF007CE3ED0077DEEB0071DAE9006CD6E700335D71006C8C
          9C00FF00FF00FF00FF00FF00FF006C8C9C006C8C9C006C8C9C006C8C9C006C8C
          9C006C8C9C006C8C9C006C8C9C006C8C9C006C8C9C006C8C9C006C8C9C006C8C
          9C006C8C9C006C8C9C006C8C9C006C8C9C006C8C9C006C8C9C006C8C9C006C8C
          9C006C8C9C006C8C9C006C8C9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end>
  end
end
