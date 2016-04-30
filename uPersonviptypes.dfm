object frmPersonviptypes: TfrmPersonviptypes
  Left = 2968
  Top = 305
  Caption = 'Person VIP Types'
  ClientHeight = 518
  ClientWidth = 444
  Color = clBtnFace
  Constraints.MinWidth = 460
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sbMain: TsStatusBar
    Left = 0
    Top = 499
    Width = 444
    Height = 19
    Panels = <>
    SimplePanel = True
    SkinData.SkinSection = 'STATUSBAR'
  end
  object PanTop: TsPanel
    Left = 0
    Top = 0
    Width = 444
    Height = 89
    Align = alTop
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object cLabFilter: TsLabel
      Left = 19
      Top = 41
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Filter :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object btnClear: TsSpeedButton
      Left = 265
      Top = 39
      Width = 59
      Height = 21
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 10
    end
    object btnInsert: TsButton
      Left = 7
      Top = 7
      Width = 84
      Height = 26
      Hint = 'Add new record'
      Caption = 'New'
      ImageIndex = 23
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnInsertClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnEdit: TsButton
      Left = 97
      Top = 7
      Width = 84
      Height = 26
      Hint = 'Edit current record'
      Caption = 'Edit'
      ImageIndex = 25
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnEditClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnDelete: TsButton
      Left = 187
      Top = 7
      Width = 83
      Height = 26
      Hint = 'Delete current record'
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnOther: TsButton
      Left = 276
      Top = 7
      Width = 146
      Height = 26
      Hint = 'Other actions - Select from menu'
      Caption = 'Other actions'
      DropDownMenu = mnuOther
      ImageIndex = 76
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      Style = bsSplitButton
      TabOrder = 3
      OnClick = btnOtherClick
      SkinData.SkinSection = 'BUTTON'
    end
    object chkActive: TsCheckBox
      Left = 56
      Top = 65
      Width = 279
      Height = 19
      Caption = 'Active (if checked then just active are visible else all)'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = chkActiveClick
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object edFilter: TsEdit
      Left = 56
      Top = 39
      Width = 206
      Height = 21
      Color = 3355443
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15724527
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnChange = edFilterChange
      SkinData.SkinSection = 'EDIT'
    end
  end
  object panBtn: TsPanel
    Left = 0
    Top = 466
    Width = 444
    Height = 33
    Align = alBottom
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      444
      33)
    object btnCancel: TsButton
      Left = 356
      Top = 4
      Width = 85
      Height = 25
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 4
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCancelClick
      SkinData.SkinSection = 'BUTTON'
    end
    object BtnOk: TsButton
      Left = 267
      Top = 4
      Width = 84
      Height = 25
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 1
      OnClick = BtnOkClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object grData: TcxGrid
    Left = 0
    Top = 89
    Width = 444
    Height = 377
    Align = alClient
    TabOrder = 3
    LookAndFeel.NativeStyle = False
    object tvData: TcxGridDBTableView
      OnDblClick = tvDataDblClick
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = True
      Navigator.Buttons.PriorPage.Visible = True
      Navigator.Buttons.Prior.Visible = True
      Navigator.Buttons.Next.Visible = True
      Navigator.Buttons.NextPage.Visible = True
      Navigator.Buttons.Last.Visible = True
      Navigator.Buttons.Insert.Enabled = False
      Navigator.Buttons.Insert.Visible = False
      Navigator.Buttons.Append.Enabled = False
      Navigator.Buttons.Append.Visible = False
      Navigator.Buttons.Delete.Enabled = False
      Navigator.Buttons.Delete.Visible = False
      Navigator.Buttons.Edit.Enabled = False
      Navigator.Buttons.Edit.Visible = False
      Navigator.Buttons.Post.Enabled = False
      Navigator.Buttons.Post.Visible = False
      Navigator.Buttons.Cancel.Enabled = False
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = True
      Navigator.Buttons.SaveBookmark.Visible = True
      Navigator.Buttons.GotoBookmark.Visible = True
      Navigator.Buttons.Filter.Visible = True
      Navigator.InfoPanel.Visible = True
      Navigator.Visible = True
      DataController.DataSource = DS
      DataController.Filter.OnChanged = tvDataDataControllerFilterChanged
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      DataController.OnSortingChanged = tvDataDataControllerSortingChanged
      OptionsBehavior.AlwaysShowEditor = True
      OptionsBehavior.IncSearch = True
      OptionsData.Appending = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object tvDataRecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
      end
      object tvDataID: TcxGridDBColumn
        DataBinding.FieldName = 'ID'
        Visible = False
      end
      object tvDataCode: TcxGridDBColumn
        DataBinding.FieldName = 'Code'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Properties.OnValidate = tvDataCodePropertiesValidate
        Width = 51
      end
      object tvDataDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
      end
      object tvDataVipGrade: TcxGridDBColumn
        Caption = 'Grade'
        DataBinding.FieldName = 'VipGrade'
      end
      object tvDataactive: TcxGridDBColumn
        DataBinding.FieldName = 'active'
        Width = 44
      end
    end
    object lvData: TcxGridLevel
      GridView = tvData
    end
  end
  object m_: TdxMemData
    Indexes = <>
    SortOptions = []
    BeforeInsert = m_BeforeInsert
    BeforePost = m_BeforePost
    BeforeDelete = m_BeforeDelete
    OnNewRecord = m_NewRecord
    Left = 312
    Top = 136
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
    object m_Description: TWideStringField
      DisplayWidth = 35
      FieldName = 'Description'
      Size = 35
    end
    object m_VipGrade: TIntegerField
      FieldName = 'VipGrade'
    end
    object m_active: TBooleanField
      FieldName = 'active'
    end
    object m_Code: TWideStringField
      FieldName = 'Code'
      Size = 5
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 40
    Top = 184
    object mnuiPrint: TMenuItem
      Caption = 'Print'
      ImageIndex = 3
      OnClick = mnuiPrintClick
    end
    object mnuiAllowGridEdit: TMenuItem
      Caption = 'Allow grid edit'
      Checked = True
      OnClick = mnuiAllowGridEditClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Export1: TMenuItem
      Caption = 'Export'
      ImageIndex = 98
      object mnuiGridToExcel: TMenuItem
        Caption = 'Grid to Excel'
        ImageIndex = 132
        OnClick = mnuiGridToExcelClick
      end
      object mnuiGridToHtml: TMenuItem
        Caption = 'Grid to HTML'
        ImageIndex = 99
        OnClick = mnuiGridToHtmlClick
      end
      object mnuiGridToText: TMenuItem
        Caption = 'Grid to text'
        ImageIndex = 0
        OnClick = mnuiGridToTextClick
      end
      object mnuiGridToXml: TMenuItem
        Caption = 'Grid to XML'
        ImageIndex = 0
        OnClick = mnuiGridToXmlClick
      end
    end
  end
  object DS: TDataSource
    DataSet = m_
    Left = 360
    Top = 136
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLink_grData
    Version = 0
    Left = 368
    Top = 224
    object prLink_grData: TdxGridReportLink
      Active = True
      Component = grData
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 42490.533069560190000000
      BuiltInReportLink = True
    end
  end
  object FormStore: TcxPropertiesStore
    Components = <
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Position'
          'Top'
          'Width')
      end>
    StorageName = 'Software\Roomer\FormStatus\Currencies'
    StorageType = stRegistry
    Left = 355
    Top = 328
  end
end
