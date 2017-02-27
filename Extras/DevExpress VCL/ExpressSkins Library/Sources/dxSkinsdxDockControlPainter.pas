{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{                    ExpressSkins Library                            }
{                                                                    }
{           Copyright (c) 2006-2014 Developer Express Inc.           }
{                     ALL RIGHTS RESERVED                            }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSSKINS AND ALL ACCOMPANYING     }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit dxSkinsdxDockControlPainter;

{$I cxVer.inc}

interface

uses
  Windows, SysUtils, Classes, Graphics, cxGraphics, dxDockControl,
  dxDockControlXPView, dxSkinsCore, dxSkinsLookAndFeelPainter, cxLookAndFeels,
  cxLookAndFeelPainters, Math, cxGeometry, dxDockControlOfficeView, dxSkinInfo,
  Types, dxSkinscxPCPainter, cxPC;

type

  { TdxDockControlSkinPainter }

  TdxDockControlSkinPainter = class(TdxDockControlXPPainter)
  private
    FPanelBackgroundCache: TdxSkinElementCache;
  protected
    function DrawCaptionFirst: Boolean; override;
    function GetCaptionFontColor(IsActive: Boolean): TColor; override;
    function GetCaptionRect(const ARect: TRect; AIsVertical: Boolean): TRect; override;
    function GetElementState(AActive: Boolean; AState: TcxButtonState): TdxSkinElementState;
    function GetHideBarButtonFontColor: TColor; override;
    function GetHideBarButtonFontColorEx(AActive: Boolean): TColor;
    function GetSkinPainterData(var AData: TdxSkinLookAndFeelPainterInfo): Boolean;
    function DrawCaptionButton(ACanvas: TcxCanvas; AGlyphIndex: Integer;
      ARect: TRect; AState: TdxSkinElementState): Boolean;
    function IsWorkingControl(AControl: TdxCustomDockControl): Boolean;
  public
    constructor Create(ADockControl: TdxCustomDockControl); override;
    destructor Destroy; override;
    class function GetTabsPainter(ATabsStyle: TcxPCStyleID): TcxPCPainterClass; override;
    class function HasLookAndFeelStyle(AStyle: TcxLookAndFeelStyle): Boolean; override;
    // Custom
    function CanVerticalCaption: Boolean; override;
    function GetCaptionContentOffsets(AIsVertical: Boolean): TRect; override;
    procedure DrawBorder(ACanvas: TcxCanvas; ARect: TRect); override;
    procedure DrawCaption(ACanvas: TcxCanvas; ARect: TRect; IsActive: Boolean); override;
    procedure DrawCaptionCloseButton(ACanvas: TcxCanvas; ARect: TRect;
      AIsActive: Boolean; AState: TcxButtonState); override;
    procedure DrawCaptionHideButton(ACanvas: TcxCanvas; ARect: TRect;
      IsActive, IsSwitched: Boolean; AState: TcxButtonState); override;
    procedure DrawCaptionMaximizeButton(ACanvas: TcxCanvas; ARect: TRect;
      IsActive, IsSwitched: Boolean; AState: TcxButtonState); override;
    procedure DrawCaptionSeparator(ACanvas: TcxCanvas; ARect: TRect); override;
    procedure DrawCaptionText(ACanvas: TcxCanvas; ARect: TRect; IsActive: Boolean); override;
    procedure DrawClient(ACanvas: TcxCanvas; ARect: TRect); override;
    function GetBorderWidths: TRect; override;
    function GetCaptionButtonSize: TSize; override;
    function GetCaptionHeight: Integer; override;
    function GetCaptionSeparatorSize: Integer; override;
    // AutoHideContainer
    procedure DrawHideBar(ACanvas: TcxCanvas; ARect: TRect; APosition: TdxAutoHidePosition); override;
    procedure DrawHideBarButtonBackground(ACanvas: TcxCanvas;
      AButton: TdxDockSiteHideBarButton; APosition: TdxAutoHidePosition); override;
    procedure DrawHideBarButtonText(ACanvas: TcxCanvas; AControl: TdxCustomDockControl;
      ARect: TRect; APosition: TdxAutoHidePosition); override;
    procedure DrawHideBarButtonSection(ACanvas: TcxCanvas;
      AButtonSection: TdxDockSiteHideBarButtonSection; APosition: TdxAutoHidePosition); override;
    procedure DrawHideBarButtonSectionSeparator(ACanvas: TcxCanvas;
      AButtonSection: TdxDockSiteHideBarButtonSection; APosition: TdxAutoHidePosition); override;
    procedure DrawHideBarScrollButton(ACanvas: TcxCanvas; const ARect: TRect;
      AState: TcxButtonState; AArrow: TcxArrowDirection); override;
    function IsHideBarButtonHotTrackSupports: Boolean; override;
  end;

  { TdxDockControlSkinTabPainter }

  TdxDockControlSkinTabPainter = class(TcxPCSkinPainter)
  private
    function GetHeaderLine: TdxSkinElement;
    function GetHeaderLineRect: TRect;
    function GetHeaderLineSize: TSize;
    function GetTabCloseButton: TdxSkinElement;
  protected
    procedure DoDrawTabCloseButton(ACanvas: TcxCanvas; const ARect: TRect;
      AState: TcxPCNavigatorButtonState); override;
    procedure DrawHeaderLine(ACanvas: TcxCanvas; const R: TRect);
    procedure DrawParentBackground(ACanvas: TcxCanvas; const R: TRect); override;
    procedure FillFreeSpaceArea(ACanvas: TcxCanvas; const ARect: TRect); override;
    procedure InternalPaintFrame(ACanvas: TcxCanvas); override;
    function GetButtonHorz: TdxSkinElement; override;
    function GetButtonVert: TdxSkinElement; override;
    function GetCloseButtonSize: TSize; override;
    function GetFreeSpaceColor: TColor; override;
    function GetHeader: TdxSkinElement; override;
    function GetIndentByIndex(AType: TcxPCSkinIndents): Integer; override;
    function GetNativeContentOffset: TRect; override;
    function GetTextColor(ATabVisibleIndex: Integer): TColor; override;
    procedure PrepareTabBitmapBackground(ABitmap: TcxBitmap;
      const ARect: TRect; ATabViewInfo: TcxTabViewInfo); override;
    function UseLookAndFeelTabButton: Boolean; override;
    //
    property HeaderLine: TdxSkinElement read GetHeaderLine;
    property HeaderLineRect: TRect read GetHeaderLineRect;
    property HeaderLineSize: TSize read GetHeaderLineSize;
    property TabCloseButton: TdxSkinElement read GetTabCloseButton;
  end;

implementation

uses
  cxPCPainters;

type
  TdxCustomDockControlAccess = class(TdxCustomDockControl);

function GetActualTextColor(ASkinTextColor, ADefaultTextColor: TColor): TColor;
begin
  if cxColorIsValid(ADefaultTextColor) and (ADefaultTextColor <> clWindowText) then
    Result := ADefaultTextColor
  else
    if cxColorIsValid(ASkinTextColor) then
      Result := ASkinTextColor
    else
      Result := ADefaultTextColor;
end;

{ TdxDockControlSkinTabPainter }

procedure TdxDockControlSkinTabPainter.DoDrawTabCloseButton(
  ACanvas: TcxCanvas; const ARect: TRect; AState: TcxPCNavigatorButtonState);
begin
  if TabCloseButton <> nil then
    TabCloseButton.Draw(ACanvas.Handle, ARect, 0,
      ButtonStateToSkinState[NavigatorBtnStateToLookAndFeelBtnState[AState]]);
end;

procedure TdxDockControlSkinTabPainter.DrawHeaderLine(ACanvas: TcxCanvas; const R: TRect);
var
  ABitmap: TcxBitmap32;
begin
  ABitmap := TcxBitmap32.CreateSize(R, True);
  try
    case ViewInfo.TabPosition of
      tpTop:
        ABitmap.Rotate(ra0, True);
      tpLeft:
        ABitmap.Rotate(raPlus90);
      tpRight:
        ABitmap.Rotate(raMinus90);
    end;

    HeaderLine.Draw(ABitmap.Canvas.Handle, ABitmap.ClientRect);

    case ViewInfo.TabPosition of
      tpTop:
        ABitmap.Rotate(ra0, True);
      tpLeft:
        ABitmap.Rotate(raMinus90);
      tpRight:
        ABitmap.Rotate(raPlus90);
    end;

    cxBitBlt(ACanvas.Handle, ABitmap.Canvas.Handle, R, cxNullPoint, SRCCOPY);
  finally
    ABitmap.Free;
  end;
end;

procedure TdxDockControlSkinTabPainter.DrawParentBackground(ACanvas: TcxCanvas; const R: TRect);
var
  AInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(AInfo) and (AInfo.DockControlTabHeaderBackground <> nil) then
  begin
    ACanvas.SaveClipRegion;
    try
      ACanvas.FillRect(ViewInfo.ClientRect, GetFreeSpaceColor);
      ACanvas.SetClipRegion(TcxRegion.Create(R), roIntersect);
      AInfo.DockControlTabHeaderBackground.Draw(ACanvas.Handle, ViewInfo.TabsAreaRect);
    finally
      ACanvas.RestoreClipRegion;
    end;
  end;
end;

procedure TdxDockControlSkinTabPainter.FillFreeSpaceArea(ACanvas: TcxCanvas; const ARect: TRect);
begin
  DrawParentBackground(ACanvas, ARect);
end;

procedure TdxDockControlSkinTabPainter.InternalPaintFrame(ACanvas: TcxCanvas);
begin
  if HeaderLine <> nil then
    DrawHeaderLine(ACanvas, HeaderLineRect)
  else
    inherited InternalPaintFrame(ACanvas)
end;

procedure TdxDockControlSkinTabPainter.PrepareTabBitmapBackground(
  ABitmap: TcxBitmap; const ARect: TRect; ATabViewInfo: TcxTabViewInfo);
var
  APrevWindowOrg: TPoint;
begin
  if NeedDrawTabBitmapBackground then
  begin
    APrevWindowOrg := ABitmap.cxCanvas.WindowOrg;
    try
      ABitmap.cxCanvas.WindowOrg := ARect.TopLeft;
      DrawParentBackground(ABitmap.cxCanvas, ARect);
      DrawHeaderLine(ABitmap.cxCanvas, HeaderLineRect);
    finally
      ABitmap.cxCanvas.WindowOrg := APrevWindowOrg;
    end;
  end;
end;

function TdxDockControlSkinTabPainter.UseLookAndFeelTabButton: Boolean;
begin
  Result := False;
end;

function TdxDockControlSkinTabPainter.GetButtonHorz: TdxSkinElement;
var
  AInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(AInfo) then
    Result := AInfo.DockControlTabButtonHorz
  else
    Result := nil;
end;

function TdxDockControlSkinTabPainter.GetButtonVert: TdxSkinElement;
var
  AInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(AInfo) then
    Result := AInfo.DockControlTabButtonVert
  else
    Result := nil;
end;

function TdxDockControlSkinTabPainter.GetCloseButtonSize: TSize;
begin
  if TabCloseButton <> nil then
    Result := TabCloseButton.MinSize.Size
  else
    Result := cxNullSize;
end;

function TdxDockControlSkinTabPainter.GetFreeSpaceColor: TColor;
var
  AInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(AInfo) and (AInfo.DockControlBorder <> nil) then
    Result := AInfo.DockControlBorder.Color
  else
    Result := inherited GetFreeSpaceColor;
end;

function TdxDockControlSkinTabPainter.GetHeader: TdxSkinElement;
var
  AInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(AInfo) then
    Result := AInfo.DockControlTabHeader
  else
    Result := nil;
end;

function TdxDockControlSkinTabPainter.GetHeaderLine: TdxSkinElement;
var
  AInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(AInfo) then
    Result := AInfo.DockControlTabHeaderLine
  else
    Result := nil;
end;

function TdxDockControlSkinTabPainter.GetHeaderLineRect: TRect;
begin
  Result := GetPageFrameRect;
  case ViewInfo.TabPosition of
    tpTop:
      Result := cxRectSetHeight(Result, HeaderLineSize.cy);
    tpBottom:
      Result := cxRectSetBottom(Result, Result.Bottom, HeaderLineSize.cy);
    tpLeft:
      Result := cxRectSetWidth(Result, HeaderLineSize.cx);
    tpRight:
      Result := cxRectSetRight(Result, Result.Right, HeaderLineSize.cx);
  end;
end;

function TdxDockControlSkinTabPainter.GetHeaderLineSize: TSize;
begin
  if HeaderLine <> nil then
  begin
    Result := HeaderLine.MinSize.Size;
    if ViewInfo.TabPosition in [tpLeft, tpRight] then
      Result := cxSize(Result.cy, Result.cx);
  end
  else
    Result := cxNullSize;
end;

function TdxDockControlSkinTabPainter.GetIndentByIndex(AType: TcxPCSkinIndents): Integer;
var
  AInfo: TdxSkinLookAndFeelPainterInfo;
begin
  Result := 0;
  if GetSkinPainterData(AInfo) then
  begin
    case AType of
      siNear, siFar:
        Result := 4;
      siSelectedDownGrowBottomRight, siSelectedDownGrow:
        Result := AInfo.DockControlIndents[0];
      siHorzGrow:
        Result := AInfo.DockControlIndents[1];
      siVertGrow:
        Result := AInfo.DockControlIndents[2];
    end;
  end;
end;

function TdxDockControlSkinTabPainter.GetNativeContentOffset: TRect;
begin
  with HeaderLineSize do
    Result := cxRect(cx, cy, cx, cy);
end;

function TdxDockControlSkinTabPainter.GetTabCloseButton: TdxSkinElement;
var
  AInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(AInfo) then
    Result := AInfo.DockControlTabHeaderCloseButton
  else
    Result := nil;
end;

function TdxDockControlSkinTabPainter.GetTextColor(ATabVisibleIndex: Integer): TColor;
var
  AColor: TdxSkinColor;
  AInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(AInfo) then
    AColor := AInfo.DockControlTabTextColor[ViewInfo.TabsViewInfo[ATabVisibleIndex].IsMainTab]
  else
    AColor := nil;

  if AColor = nil then
    Result := inherited GetTextColor(ATabVisibleIndex)
  else
    Result := AColor.Value;
end;

{ TdxDockControlSkinPainter }

constructor TdxDockControlSkinPainter.Create(ADockControl: TdxCustomDockControl);
begin
  inherited Create(ADockControl);
  FPanelBackgroundCache := TdxSkinElementCache.Create;
end;

destructor TdxDockControlSkinPainter.Destroy;
begin
  FreeAndNil(FPanelBackgroundCache);
  inherited Destroy;
end;

function TdxDockControlSkinPainter.CanVerticalCaption: Boolean;
begin
  Result := False;
end;

procedure TdxDockControlSkinPainter.DrawBorder(ACanvas: TcxCanvas; ARect: TRect);
var
  ABorder: TdxSkinElement;
  ACaption: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(ASkinInfo) then
  begin
    ABorder := ASkinInfo.DockControlBorder;
    ACaption := ASkinInfo.DockControlCaption;
  end
  else
  begin
    ABorder := nil;
    ACaption := nil;
  end;

  if (ABorder = nil) or (ACaption = nil) then
    inherited DrawBorder(ACanvas, ARect)
  else
  begin
    FPanelBackgroundCache.DrawEx(ACanvas.Handle, ABorder, ARect);
    ACanvas.SaveClipRegion;
    try
      ACanvas.IntersectClipRect(cxRectSetHeight(ARect, GetBorderWidths.Top));
      ACaption.Draw(ACanvas.Handle, cxRectSetHeight(ARect, ACaption.Size.cy));
    finally
      ACanvas.RestoreClipRegion;
    end;
  end;
end;

procedure TdxDockControlSkinPainter.DrawCaption(
  ACanvas: TcxCanvas; ARect: TRect; IsActive: Boolean);
const
  States: array[Boolean] of TdxSkinElementState = (esNormal, esActive);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(ASkinInfo) then
    AElement := ASkinInfo.DockControlCaption
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawCaption(ACanvas, ARect, IsActive)
  else
  begin
    ACanvas.SaveClipRegion;
    try
      ACanvas.IntersectClipRect(ARect);
      AElement.Draw(ACanvas.Handle,
        cxRectInflate(ARect, 0, GetBorderWidths.Top, 0, 0), 0,
        States[IsActive]);
    finally
      ACanvas.RestoreClipRegion;
    end;
  end;
end;

procedure TdxDockControlSkinPainter.DrawCaptionCloseButton(
  ACanvas: TcxCanvas; ARect: TRect; AIsActive: Boolean; AState: TcxButtonState);
begin
  if not DrawCaptionButton(ACanvas, 2, ARect, GetElementState(AIsActive, AState)) then
    inherited DrawCaptionCloseButton(ACanvas, ARect, AIsActive, AState);
end;

procedure TdxDockControlSkinPainter.DrawCaptionHideButton(ACanvas: TcxCanvas;
  ARect: TRect; IsActive, IsSwitched: Boolean; AState: TcxButtonState);
const
  GlyphsMap: array[Boolean] of Integer = (3, 4);
begin
  if not DrawCaptionButton(ACanvas, GlyphsMap[IsSwitched], ARect, GetElementState(IsActive, AState)) then
    inherited DrawCaptionHideButton(ACanvas, ARect, IsActive, IsSwitched, AState);
end;

procedure TdxDockControlSkinPainter.DrawCaptionMaximizeButton(ACanvas: TcxCanvas;
  ARect: TRect; IsActive, IsSwitched: Boolean; AState: TcxButtonState);
const
  GlyphsMap: array[Boolean] of Integer = (1, 0);
begin
  if not DrawCaptionButton(ACanvas, GlyphsMap[IsSwitched], ARect, GetElementState(IsActive, AState)) then
    inherited DrawCaptionMaximizeButton(ACanvas, ARect, IsActive, IsSwitched, AState);
end;

procedure TdxDockControlSkinPainter.DrawCaptionSeparator(ACanvas: TcxCanvas; ARect: TRect);
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if not GetSkinPainterData(ASkinInfo) then
    inherited DrawCaptionSeparator(ACanvas, ARect);
end;

procedure TdxDockControlSkinPainter.DrawCaptionText(
  ACanvas: TcxCanvas; ARect: TRect; IsActive: Boolean);
var
  R: TRect;  
begin
  if IsValidImageIndex(DockControl.ImageIndex) then
  begin
    R.Left := ARect.Left;
    R.Top := ARect.Top + (ARect.Bottom - ARect.Top - GetImageHeight) div 2;
    R.Right := R.Left + GetImageWidth;
    R.Bottom := R.Top + GetImageHeight;
    if RectInRect(R, ARect) then
    begin
      DrawImage(ACanvas, DockControl.Images, DockControl.ImageIndex, R);
      ARect.Left := R.Right + 2 * GetSpaceBetweenCaptionButtons;
    end;
  end;

  ACanvas.Brush.Style := bsClear;
  ACanvas.Font := GetFont;
  ACanvas.Font.Color := GetCaptionFontColor(IsActive);
  cxDrawText(ACanvas.Handle, DockControl.Caption, ARect,
    DT_SINGLELINE or DT_LEFT or DT_VCENTER or DT_END_ELLIPSIS);
end;

procedure TdxDockControlSkinPainter.DrawClient(ACanvas: TcxCanvas; ARect: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(ASkinInfo) then
    AElement := ASkinInfo.GroupBoxClient
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawClient(ACanvas, ARect)
  else
    AElement.Draw(ACanvas.Handle, ARect);
end;

function TdxDockControlSkinPainter.GetBorderWidths: TRect;
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(ASkinInfo) then
    AElement := ASkinInfo.DockControlBorder
  else
    AElement := nil;
    
  if AElement = nil then
    Result := inherited GetBorderWidths
  else
    Result := AElement.ContentOffset.Rect;
end;

function TdxDockControlSkinPainter.GetCaptionButtonSize: TSize;
var
  AButton: TdxSkinElement;
  AButtonGlyph: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(ASkinInfo) then
  begin
    AButtonGlyph := ASkinInfo.DockControlWindowButtonGlyphs;
    AButton := ASkinInfo.DockControlWindowButton;
  end
  else
  begin
    AButtonGlyph := nil;
    AButton := nil;
  end;

  if (AButton <> nil) and (AButtonGlyph <> nil) then
  begin
    Result := AButton.MinSize.Size;
    if Result.cx = 0 then
      Result.cx := cxMarginsWidth(AButton.ContentOffset.Rect) + AButtonGlyph.Size.cx;
    if Result.cy = 0 then
      Result.cy := cxMarginsHeight(AButton.ContentOffset.Rect) + AButtonGlyph.Size.cy;
  end
  else
    Result := inherited GetCaptionButtonSize;
end;

function TdxDockControlSkinPainter.GetCaptionHeight: Integer;
var
  ACaptionButtonSize: TSize;
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(ASkinInfo) then
    AElement := ASkinInfo.DockControlCaption
  else
    AElement := nil;

  if (AElement <> nil) and not AElement.Image.Empty then
  begin
    ACaptionButtonSize := GetCaptionButtonSize;
    Result := AElement.Size.cy - cxMarginsHeight(GetBorderWidths);
    Inc(Result, Integer(Odd(Result + ACaptionButtonSize.cy)));
    Result := Max(Result, ACaptionButtonSize.cy) + cxMarginsHeight(GetCaptionContentOffsets(False));
  end
  else
    Result := inherited GetCaptionHeight;
end;

function TdxDockControlSkinPainter.GetCaptionSeparatorSize: Integer;
begin
  Result := 1;
end;

procedure TdxDockControlSkinPainter.DrawHideBar(
  ACanvas: TcxCanvas; ARect: TRect; APosition: TdxAutoHidePosition);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  AElement := nil;
  if GetSkinPainterData(ASkinInfo) then
    case APosition of
      ahpTop, ahpUndefined:
        AElement := ASkinInfo.DockControlHideBar;
      ahpLeft:
        AElement := ASkinInfo.DockControlHideBarLeft;
      ahpRight:
        AElement := ASkinInfo.DockControlHideBarRight;
      ahpBottom:
        AElement := ASkinInfo.DockControlHideBarBottom;
    end;

  if AElement = nil then
    inherited DrawHideBar(ACanvas, ARect, APosition)
  else
  begin
    AElement.UseCache := True;
    AElement.Draw(ACanvas.Handle, ARect);
  end;
end;

procedure TdxDockControlSkinPainter.DrawHideBarButtonBackground(
  ACanvas: TcxCanvas; AButton: TdxDockSiteHideBarButton; APosition: TdxAutoHidePosition);
begin
  // do nothing
end;

procedure TdxDockControlSkinPainter.DrawHideBarButtonText(ACanvas: TcxCanvas;
  AControl: TdxCustomDockControl; ARect: TRect; APosition: TdxAutoHidePosition);

  procedure DrawButtonText(ACanvas: TcxCanvas; R: TRect; AControl: TdxCustomDockControl);
  begin
    ACanvas.Brush.Style := bsClear;
    ACanvas.Font := GetHideBarButtonFont;
    ACanvas.Font.Color := GetHideBarButtonFontColorEx(IsWorkingControl(AControl));
    cxDrawText(ACanvas.Handle, AControl.Caption, R,
      DT_LEFT or DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS);
  end;

var
  ABitmap: TcxBitmap;
begin
  InflateRect(ARect, -4, -4);
  case APosition of
    ahpTop, ahpBottom:
      DrawButtonText(ACanvas, ARect, AControl);

    ahpRight, ahpLeft:
      begin
        ABitmap := TcxBitmap.CreateSize(ARect, pf32bit);
        try
          cxBitBlt(ABitmap.Canvas.Handle, ACanvas.Handle, ABitmap.ClientRect, ARect.TopLeft, SRCCOPY);
          ABitmap.Rotate(raPlus90);
          DrawButtonText(ABitmap.cxCanvas, ABitmap.ClientRect, AControl);
          ABitmap.Rotate(raMinus90);
          ACanvas.Draw(ARect.Left, ARect.Top, ABitmap);
        finally
          ABitmap.Free;
        end;
      end;
  end;
end;

procedure TdxDockControlSkinPainter.DrawHideBarButtonSection(ACanvas: TcxCanvas;
  AButtonSection: TdxDockSiteHideBarButtonSection; APosition: TdxAutoHidePosition);

  procedure RotateBitmap(ABitmap: TcxBitmap; AReverse: Boolean);
  const
    RotationHorMap: array[Boolean] of TcxRotationAngle = (raPlus90, raMinus90);
  begin
    case APosition of
      ahpLeft:
        ABitmap.Rotate(RotationHorMap[not AReverse]);
      ahpRight:
        ABitmap.Rotate(RotationHorMap[AReverse]);
      ahpTop:
        ABitmap.Rotate(ra0, True);
    end;
  end;

  function CreateHideBarButtonBuffer(R: TRect): TcxBitmap;
  var
    ATemp: Integer;
  begin
    OffsetRect(R, -R.Left, -R.Top);
    if APosition in [ahpLeft, ahpRight] then
    begin
      ATemp := R.Right;
      R.Right := R.Left + (R.Bottom - R.Top);
      R.Bottom := R.Top + (ATemp - R.Left);
    end;
    Result := TcxBitmap.CreateSize(R, pf32bit);
  end;

var
  ABitmap: TcxBitmap;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(ASkinInfo) and (ASkinInfo.DockControlHideBarButtons <> nil) then
  begin
    ABitmap := CreateHideBarButtonBuffer(AButtonSection.Bounds);
    try
      RotateBitmap(ABitmap, False);
      cxBitBlt(ABitmap.Canvas.Handle, ACanvas.Handle,
        ABitmap.ClientRect, AButtonSection.Bounds.TopLeft, SRCCOPY);
      RotateBitmap(ABitmap, True);
      ASkinInfo.DockControlHideBarButtons.Draw(ABitmap.Canvas.Handle,
        ABitmap.ClientRect, Integer(IsWorkingControl(AButtonSection.DockControl)));
      RotateBitmap(ABitmap, False);
      cxBitBlt(ACanvas.Handle, ABitmap.Canvas.Handle,
        AButtonSection.Bounds, cxNullPoint, SRCCOPY);
    finally
      ABitmap.Free;
    end;
  end;
  inherited DrawHideBarButtonSection(ACanvas, AButtonSection, APosition);
end;

procedure TdxDockControlSkinPainter.DrawHideBarButtonSectionSeparator(ACanvas: TcxCanvas;
  AButtonSection: TdxDockSiteHideBarButtonSection; APosition: TdxAutoHidePosition);
begin
  // do nothing
end;

procedure TdxDockControlSkinPainter.DrawHideBarScrollButton(ACanvas: TcxCanvas;
  const ARect: TRect; AState: TcxButtonState; AArrow: TcxArrowDirection);
const
  ImageIndexesMap: array[TcxArrowDirection] of Integer = (2, 1, 1, 2);
var
  AElement: TdxSkinElement;
  AInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(AInfo) then
  begin
    if AArrow in [adLeft, adRight] then
      AElement := AInfo.DockControlTabButtonHorz
    else
      AElement := AInfo.DockControlTabButtonVert;
  end
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawHideBarScrollButton(ACanvas, ARect, AState, AArrow)
  else
    AElement.Draw(ACanvas.Handle, ARect, ImageIndexesMap[AArrow], ButtonStateToSkinState[AState]);
end;

function TdxDockControlSkinPainter.IsHideBarButtonHotTrackSupports: Boolean;
begin
  Result := True;
end;

function TdxDockControlSkinPainter.IsWorkingControl(AControl: TdxCustomDockControl): Boolean;
begin
  if AControl.AutoHideHostSite.WorkingControl is TdxTabContainerDockSite then
    Result := AControl = TdxTabContainerDockSite(AControl.AutoHideHostSite.WorkingControl).ActiveChild
  else
    Result := AControl = AControl.AutoHideHostSite.WorkingControl;
end;

class function TdxDockControlSkinPainter.GetTabsPainter(ATabsStyle: TcxPCStyleID): TcxPCPainterClass;
begin
  if (ATabsStyle = cxPCDefaultStyle) or (ATabsStyle = cxPCSkinStyle) then
    Result := TdxDockControlSkinTabPainter
  else
    Result := inherited GetTabsPainter(ATabsStyle);
end;

class function TdxDockControlSkinPainter.HasLookAndFeelStyle(AStyle: TcxLookAndFeelStyle): Boolean;
begin
  Result := AStyle = lfsSkin;
end;

function TdxDockControlSkinPainter.GetCaptionFontColor(IsActive: Boolean): TColor;
var
  AColor: TColor;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  AColor := clDefault;
  if GetSkinPainterData(ASkinInfo) then
  begin
    if not IsActive then
      AColor := ASkinInfo.DockControlCaptionNonFocusedTextColor
    else
      if ASkinInfo.DockControlCaption <> nil then
        AColor := ASkinInfo.DockControlCaption.TextColor;
  end;

  if AColor = clDefault then
    Result := inherited GetCaptionFontColor(IsActive)
  else
    Result := AColor;
end;

function TdxDockControlSkinPainter.GetCaptionRect(const ARect: TRect; AIsVertical: Boolean): TRect;
var
  ABorders: TRect;
begin
  Result := inherited GetCaptionRect(ARect, AIsVertical);
  ABorders := GetBorderWidths;
  Dec(Result.Left, ABorders.Left);
  Inc(Result.Right, ABorders.Right);
end;

function TdxDockControlSkinPainter.GetCaptionContentOffsets(AIsVertical: Boolean): TRect;
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(ASkinInfo) and (ASkinInfo.DockControlCaption <> nil) then
  begin
    Result := ASkinInfo.DockControlCaption.ContentOffset.Rect;
    Dec(Result.Top, GetBorderWidths.Top);
    Inc(Result.Right, 2);
    Inc(Result.Left, 2);
  end
  else
    Result := inherited GetCaptionContentOffsets(AIsVertical);
end;

function TdxDockControlSkinPainter.GetElementState(
  AActive: Boolean; AState: TcxButtonState): TdxSkinElementState;
begin
  Result := ButtonStateToSkinState[AState];
  if AActive and (Result = esNormal) then
    Result := esActive;
end;

function TdxDockControlSkinPainter.GetHideBarButtonFontColor: TColor;
begin
  Result := GetHideBarButtonFontColorEx(False);
end;

function TdxDockControlSkinPainter.GetHideBarButtonFontColorEx(AActive: Boolean): TColor;
var
  AColor: TdxSkinColor;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  Result := inherited GetHideBarButtonFontColor;
  if GetSkinPainterData(ASkinInfo) then
  begin
    AColor := ASkinInfo.DockControlHideBarTextColor[AActive];
    if AColor <> nil then
      Result := GetActualTextColor(AColor.Value, Result);
  end;
end;

function TdxDockControlSkinPainter.GetSkinPainterData(var AData: TdxSkinLookAndFeelPainterInfo): Boolean;
begin
  Result := LookAndFeelPainter.GetPainterData(AData);
end;

function TdxDockControlSkinPainter.DrawCaptionFirst: Boolean;
begin
  Result := True;
end;

function TdxDockControlSkinPainter.DrawCaptionButton(ACanvas: TcxCanvas;
  AGlyphIndex: Integer; ARect: TRect; AState: TdxSkinElementState): Boolean;
var
  AElement: TdxSkinElement;
  AGlyph: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  AElement := nil;
  AGlyph := nil;
  if GetSkinPainterData(ASkinInfo) then
  begin
    AElement := ASkinInfo.DockControlWindowButton;
    AGlyph := ASkinInfo.DockControlWindowButtonGlyphs;
  end;                             
  Result := (AElement <> nil) and (AGlyph <> nil);
  if Result then
  begin
    AElement.UseCache := True;
    AElement.Draw(ACanvas.Handle, ARect, 0, AState);
    AGlyph.Draw(ACanvas.Handle, cxRectContent(ARect, AElement.ContentOffset.Rect),
      AGlyphIndex, AState);
  end;
end;

initialization
  dxDockingPaintersManager.Register(TdxDockControlSkinPainter);

finalization
  dxDockingPaintersManager.Unregister(TdxDockControlSkinPainter);
end.
