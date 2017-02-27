{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2014 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxPSfmFootnotes;

interface

{$I cxVer.inc}

uses
  Types, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, dxPSForm, ImgList, cxControls, cxContainer,
  cxEdit, cxLabel, cxCheckBox, Menus, cxLookAndFeelPainters, cxButtons, cxPC,
  cxTextEdit, cxMemo, cxGraphics, cxMaskEdit, cxDropDownEdit, cxColorComboBox,
  cxGeometry, dxPSCore, cxLookAndFeels, IniFiles;

type
  
  { TdxfmReportFootnotesProperties }

  TdxfmReportFootnotesProperties = class(TCustomdxPSForm)
    Bevel2: TcxLabel;
    btnCancel: TcxButton;
    btnFont: TcxButton;
    btnHelp: TcxButton;
    btnOK: TcxButton;
    btnRestoreDefaults: TcxButton;
    bvlFont: TcxLabel;
    cbxColor: TcxColorComboBox;
    cbxMode: TcxComboBox;
    cbxTextAlignX: TcxComboBox;
    cbxTextAlignY: TcxComboBox;
    chbxAdjustOnScale: TcxCheckBox;
    chbxTransparent: TcxCheckBox;
    edFont: TcxTextEdit;
    ilAlignments: TImageList;
    imgFont: TImage;
    lblAlignment: TcxLabel;
    lblColor: TcxLabel;
    lblMode: TcxLabel;
    lblTextAlignX: TcxLabel;
    lblTextAlignY: TcxLabel;
    lblTransparent: TcxLabel;
    memText: TcxMemo;
    pctlMain: TcxPageControl;
    tshProperties: TcxTabSheet;
    tshText: TcxTabSheet;
    procedure btnFontClick(Sender: TObject);
    procedure btnRestoreDefaultsClick(Sender: TObject);
    procedure cbxTextAlignYPropertiesDrawItem(AControl: TcxCustomComboBox;
      ACanvas: TcxCanvas; AIndex: Integer; const ARect: TRect; AState: TOwnerDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblTransparentClick(Sender: TObject);
    procedure memTextKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TitleChanged(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    FActivePage: Integer;
    FModified: Boolean;
    FReportFootnotes: TdxReportFootnotes;
    procedure InitializeControls;
    procedure LoadStrings;
    procedure SaveUserInput;
    procedure SetModified(Value: Boolean);
    procedure SetReportFootnotes(Value: TdxReportFootnotes);
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    //
    property Modified: Boolean read FModified write SetModified;
  protected
    procedure BeforeConstruction; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;
    procedure LoadFromIniFile(AIniFile: TCustomIniFile; const ASectionName: string); override;
    procedure SaveToIniFile(AIniFile: TCustomIniFile; const ASectionName: string); override;
    //
    property ReportFootnotes: TdxReportFootnotes read FReportFootnotes write SetReportFootnotes;
  end;
  
function dxShowReportFootnotesPropertiesDlg(AReportFootnotes: TdxReportFootnotes): Boolean;
implementation

{$R *.DFM}

uses
  Registry, cxClasses, dxPrnDev, dxPSRes, dxPSUtl, dxPSGlbl, dxExtCtrls, cxDrawTextUtils;

const
  sdxActivePage = 'ActivePage'; //Don't Localize

function dxShowReportFootnotesPropertiesDlg(AReportFootnotes: TdxReportFootnotes): Boolean;
var
  ADialog: TdxfmReportFootnotesProperties;
begin
  Result := False;
  if Assigned(AReportFootnotes) then
  begin
    ADialog := TdxfmReportFootnotesProperties.Create(nil);
    try
      ADialog.ReportFootnotes := AReportFootnotes;
      Result := ADialog.Execute;
      if Result then
        AReportFootnotes.Assign(ADialog.ReportFootnotes);
    finally
      ADialog.Free;
    end;           
  end;
end;

{ TdxfmReportFootnotesProperties }

constructor TdxfmReportFootnotesProperties.Create(AOwner: TComponent);
begin
  HelpContext := dxhcFootnotesPropertiesDlg;
  inherited Create(AOwner);
  CheckDialogFormHelpContext(Self, btnHelp, btnCancel, btnOK);
  FReportFootnotes := TdxReportFootnotes.Create(nil);
  LoadStrings;
end;

destructor TdxfmReportFootnotesProperties.Destroy;
begin
  FreeAndNil(FReportFootnotes);
  inherited Destroy;
end;

function TdxfmReportFootnotesProperties.Execute: Boolean;
begin
  InitializeControls;
  pctlMain.ActivePage := pctlMain.Pages[FActivePage];
  Modified := False;
  Result := (ShowModal = mrOK) and Modified;
end;

procedure TdxfmReportFootnotesProperties.BeforeConstruction;
begin
  inherited BeforeConstruction;
  Options := Options + [foSizeableDialog];
end;

procedure TdxfmReportFootnotesProperties.FormClose(
  Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrOK then
    SaveUserInput;
end;

procedure TdxfmReportFootnotesProperties.InitializeControls;
begin
  chbxAdjustOnScale.Checked := ReportFootnotes.AdjustOnReportScale;
  cbxColor.ColorValue := ReportFootnotes.Color;
  FontInfoToText(ReportFootnotes.Font, edFont);
  cbxMode.ItemIndex := Integer(ReportFootnotes.Mode);
  memText.Text := ReportFootnotes.Text;
  cbxTextAlignX.ItemIndex := Integer(ReportFootnotes.TextAlignX);
  cbxTextAlignY.ItemIndex := Integer(ReportFootnotes.TextAlignY);
  chbxTransparent.Checked := ReportFootnotes.Transparent;
  cbxColor.Enabled := not chbxTransparent.Checked;
end;

procedure TdxfmReportFootnotesProperties.SetReportFootnotes(Value: TdxReportFootnotes);
begin
  FReportFootnotes.Assign(Value);
end;

procedure TdxfmReportFootnotesProperties.SetModified(Value: Boolean);
begin
  FModified := Value;
  cbxColor.Enabled := not chbxTransparent.Checked;
end;

procedure TdxfmReportFootnotesProperties.TitleChanged(Sender: TObject);
begin
  cbxColor.Enabled := not chbxTransparent.Checked;
  Modified := True;    
end;

procedure TdxfmReportFootnotesProperties.lblTransparentClick(Sender: TObject);
begin
  if chbxTransparent.CanFocus then
    ActiveControl := chbxTransparent;
  chbxTransparent.Checked := not chbxTransparent.Checked;
end;

procedure TdxfmReportFootnotesProperties.LoadStrings;
begin
  Caption := cxGetResourceString(@sdxReportFootnotesDlgCaption);
  btnOK.Caption := cxGetResourceString(@sdxBtnOkAccelerated);
  btnCancel.Caption := cxGetResourceString(@sdxBtnCancel);
  btnHelp.Caption := cxGetResourceString(@sdxBtnHelp);
  btnRestoreDefaults.Caption := cxGetResourceString(@sdxBtnRestoreDefaults);
  
  lblMode.Caption := cxGetResourceString(@sdxMode);
  cbxMode.Clear;
  cbxMode.Properties.Items.Add(cxGetResourceString(@sdxFootnotesModeNone));
  cbxMode.Properties.Items.Add(cxGetResourceString(@sdxFootnotesModeOnLastPage));
  cbxMode.Properties.Items.Add(cxGetResourceString(@sdxFootnotesModeOnEveryBottomPage));
    
  tshText.Caption := cxGetResourceString(@sdxText);
  tshProperties.Caption := cxGetResourceString(@sdxProperties);
  lblColor.Caption := cxGetResourceString(@sdxColor);
  btnFont.Caption := cxGetResourceString(@sdxBtnFont);
  chbxAdjustOnScale.Caption := cxGetResourceString(@sdxAdjustOnScale);
  
  lblAlignment.Caption := DropAmpersand(cxGetResourceString(@sdxAlignment));

  lblTextAlignX.Caption := cxGetResourceString(@sdxTextAlignHorz) + ':';
  cbxTextAlignX.Clear;
  cbxTextAlignX.Properties.Items.Add(cxGetResourceString(@sdxTextAlignLeft));
  cbxTextAlignX.Properties.Items.Add(cxGetResourceString(@sdxTextAlignCenter));
  cbxTextAlignX.Properties.Items.Add(cxGetResourceString(@sdxTextAlignRight));
  
  lblTextAlignY.Caption := cxGetResourceString(@sdxTextAlignVert) + ':'; 
  cbxTextAlignY.Clear;
  cbxTextAlignY.Properties.Items.Add(cxGetResourceString(@sdxTextAlignTop));
  cbxTextAlignY.Properties.Items.Add(cxGetResourceString(@sdxTextAlignVCenter));
  cbxTextAlignY.Properties.Items.Add(cxGetResourceString(@sdxTextAlignBottom));    

  lblTransparent.Caption := cxGetResourceString(@sdxTransparent);
end;

procedure TdxfmReportFootnotesProperties.SaveUserInput;
begin
  ReportFootnotes.AdjustOnReportScale := chbxAdjustOnScale.Checked;
  ReportFootnotes.Color := cbxColor.ColorValue;
  ReportFootnotes.Mode := TdxReportFootnoteMode(cbxMode.ItemIndex);
  ReportFootnotes.Text := memText.Text;
  ReportFootnotes.TextAlignX := TcxTextAlignX(cbxTextAlignX.ItemIndex);
  ReportFootnotes.TextAlignY := TcxTextAlignY(cbxTextAlignY.ItemIndex);
  ReportFootnotes.Transparent := chbxTransparent.Checked;
end;

procedure TdxfmReportFootnotesProperties.CMDialogChar(var Message: TCMDialogChar);
var
  I: Integer;
begin
  inherited;
  with pctlMain do
    for I := 0 to PageCount - 1 do
      if IsAccel(Message.CharCode, Pages[I].Caption) then
      begin
        Message.Result := 1;
        ActivePage := Pages[I];
        Exit;
      end;
end;

procedure TdxfmReportFootnotesProperties.btnFontClick(Sender: TObject);
begin
  FontDialog.Font := ReportFootnotes.Font;
  if FontDialog.Execute then
  begin
    ReportFootnotes.Font := FontDialog.Font;
    FontInfoToText(ReportFootnotes.Font, edFont);
    TitleChanged(nil);
  end;
end;
  
procedure TdxfmReportFootnotesProperties.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TdxfmReportFootnotesProperties.LoadFromIniFile(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  inherited LoadFromIniFile(AIniFile, ASectionName);
  FActivePage := AIniFile.ReadInteger(ASectionName, sdxActivePage, FActivePage);
end;

procedure TdxfmReportFootnotesProperties.SaveToIniFile(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  inherited SaveToIniFile(AIniFile, ASectionName);
  AIniFile.WriteInteger(ASectionName, sdxActivePage, pctlMain.ActivePage.PageIndex);
end;

procedure TdxfmReportFootnotesProperties.btnRestoreDefaultsClick(Sender: TObject);
begin
  ReportFootnotes.RestoreDefaults;
  InitializeControls;
  TitleChanged(nil);
end;

procedure TdxfmReportFootnotesProperties.cbxTextAlignYPropertiesDrawItem(
  AControl: TcxCustomComboBox; ACanvas: TcxCanvas; AIndex: Integer;
  const ARect: TRect; AState: TOwnerDrawState);
var
  R: TRect;
begin
  R := ARect;
  ACanvas.FillRect(R);
  ilAlignments.Draw(ACanvas.Canvas, R.Left + 1,
    R.Top + (cxRectHeight(R) - ilAlignments.Height) div 2,
    3 * TTagToInt(AControl.Tag) + AIndex, True);
  Inc(R.Left, 1 + ilAlignments.Width + 2);
  ACanvas.DrawTexT(AControl.Properties.Items[AIndex], R, cxAlignVCenter);
end;

procedure TdxfmReportFootnotesProperties.memTextKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and cxShiftStateMoveOnly(Shift) then
    ModalResult := mrCancel;
end;

end.
