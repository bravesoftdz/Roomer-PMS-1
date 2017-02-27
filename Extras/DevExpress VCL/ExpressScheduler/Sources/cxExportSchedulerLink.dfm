object fmExportRangeDialog: TfmExportRangeDialog
  Left = -1
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Set Date Range'
  ClientHeight = 100
  ClientWidth = 358
  Color = clBtnFace
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object lbSetDateRange: TcxLabel
    Left = 12
    Top = 8
    AutoSize = False
    Caption = 'Text'
    Style.TransparentBorder = False
    Properties.WordWrap = True
    Height = 13
    Width = 332
  end
  object lbAnd: TcxLabel
    Left = 147
    Top = 36
    Anchors = [akRight, akBottom]
    AutoSize = False
    Caption = 'and'
    Style.TransparentBorder = False
    Properties.Alignment.Horz = taCenter
    Height = 13
    Width = 63
  end
  object btnOk: TcxButton
    Left = 139
    Top = 66
    Width = 95
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TcxButton
    Left = 249
    Top = 66
    Width = 95
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object deStart: TcxDateEdit
    Left = 20
    Top = 33
    Anchors = [akRight, akBottom]
    Properties.DateButtons = [btnToday]
    Properties.ShowTime = False
    Properties.OnChange = deDatePropertiesChange
    TabOrder = 2
    Width = 121
  end
  object deFinish: TcxDateEdit
    Left = 216
    Top = 33
    Anchors = [akRight, akBottom]
    Properties.DateButtons = [btnToday]
    Properties.ShowTime = False
    Properties.OnChange = deDatePropertiesChange
    TabOrder = 3
    Width = 121
  end
end
