object frmHomedate: TfrmHomedate
  Left = 1288
  Top = 335
  BorderIcons = []
  BorderStyle = bsToolWindow
  ClientHeight = 80
  ClientWidth = 212
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  GlassFrame.Enabled = True
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TsPanel
    Left = 0
    Top = 0
    Width = 212
    Height = 80
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    ExplicitHeight = 96
    object dtHome: TsDateEdit
      Left = 0
      Top = 0
      Width = 212
      Height = 47
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      AutoSelect = False
      AutoSize = False
      Color = 3355443
      EditMask = '!99/99/99;1; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15724527
      Font.Height = -35
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 0
      Text = '  .  .  '
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -13
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'EDIT'
      ShowButton = False
      GlyphMode.Blend = 0
      GlyphMode.Grayed = False
      YearDigits = dyTwo
      ExplicitLeft = 8
      ExplicitTop = 4
      ExplicitWidth = 196
    end
    object sPanel1: TsPanel
      Left = 0
      Top = 47
      Width = 212
      Height = 33
      Align = alBottom
      TabOrder = 1
      SkinData.SkinSection = 'PANEL'
      ExplicitLeft = 8
      ExplicitTop = 205
      ExplicitWidth = 196
      DesignSize = (
        212
        33)
      object Button2: TsButton
        Left = 52
        Top = 4
        Width = 74
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'OK'
        Default = True
        ImageIndex = 82
        Images = DImages.PngImageList1
        TabOrder = 0
        OnClick = Button2Click
        SkinData.SkinSection = 'BUTTON'
        ExplicitLeft = 36
      end
      object Button1: TsButton
        Left = 132
        Top = 4
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Cancel = True
        Caption = 'Cancel'
        ImageIndex = 10
        Images = DImages.PngImageList1
        ModalResult = 8
        TabOrder = 1
        OnClick = Button1Click
        SkinData.SkinSection = 'BUTTON'
        ExplicitLeft = 116
      end
    end
  end
end
