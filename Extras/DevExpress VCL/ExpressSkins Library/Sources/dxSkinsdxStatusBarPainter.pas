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

unit dxSkinsdxStatusBarPainter;

interface

uses
  Windows, SysUtils, Classes, dxSkinsCore, cxLookAndFeels, dxSkinsLookAndFeelPainter,
  dxStatusBar, cxGraphics, Graphics, cxLookAndFeelPainters;

type

  { TdxStatusBarSkinPainter }

  TdxStatusBarSkinPainter = class(TdxStatusBarStandardPainter)
  protected
    class function CheckStatusBarRect(AFormStatusBar: TdxSkinElement; const R: TRect): TRect;
    class procedure DrawContainerControl(APanelStyle: TdxStatusBarContainerPanelStyle); override;
    class function GetSkinInfo(AStatusBar: TdxCustomStatusBar;
      out ASkinInfo: TdxSkinLookAndFeelPainterInfo): Boolean;
    class function IsSkinAvailable(AStatusBar: TdxCustomStatusBar): Boolean;
  public
    class procedure AdjustTextColor(AStatusBar: TdxCustomStatusBar; var AColor: TColor;
      Active: Boolean); override;
    class function ContentExtents(AStatusBar: TdxCustomStatusBar): TRect; override;
    class function IsSizeGripInPanelArea(AStatusBar: TdxCustomStatusBar): Boolean; override;
    class function SizeGripMargins(AStatusBar: TdxCustomStatusBar): TRect; override;
    class procedure DrawBorder(AStatusBar: TdxCustomStatusBar; ACanvas: TcxCanvas;
      var R: TRect); override;
    class procedure DrawClippedElement(AElement: TdxSkinElement; ACanvas: TcxCanvas;
      const ARect, AClipRegion: TRect; ARegionOperation: TcxRegionOperation = roSet);
    class procedure DrawEmptyPanel(AStatusBar: TdxCustomStatusBar; ACanvas: TcxCanvas;
      R: TRect); override;
    class procedure DrawPanelBorder(AStatusBar: TdxCustomStatusBar;
      ABevel: TdxStatusBarPanelBevel; ACanvas: TcxCanvas; var R: TRect); override;
    class procedure DrawPanelSeparator(AStatusBar: TdxCustomStatusBar;
      ACanvas: TcxCanvas; const R: TRect); override;
    class procedure DrawSizeGrip(AStatusBar: TdxCustomStatusBar; ACanvas: TcxCanvas;
      R: TRect); override;
    class procedure FillBackground(AStatusBar: TdxCustomStatusBar;
      APanel: TdxStatusBarPanel; ACanvas: TcxCanvas; const R: TRect); override;
    class function PanelContentExtents(AStatusBar: TdxCustomStatusBar; AHasBorders: Boolean): TRect; override;
    class function SeparatorSize: Integer; override;
  end;

implementation

uses
  Types, cxGeometry;

type
  TdxCustomStatusBarAccess = class(TdxCustomStatusBar);

{ TdxStatusBarSkinPainter }

class procedure TdxStatusBarSkinPainter.AdjustTextColor(
  AStatusBar: TdxCustomStatusBar; var AColor: TColor; Active: Boolean);
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  inherited AdjustTextColor(AStatusBar, AColor, Active);
  if AColor = clWindowText then
    if GetSkinInfo(AStatusBar, ASkinInfo) then
    begin
      if Active then
      begin
        if ASkinInfo.FormStatusBar <> nil then
          AColor := ASkinInfo.FormStatusBar.TextColor;
      end
      else
        if ASkinInfo.BarDisabledTextColor <> nil then
          AColor := ASkinInfo.BarDisabledTextColor.Value;
    end;
end;

class function TdxStatusBarSkinPainter.ContentExtents(AStatusBar: TdxCustomStatusBar): TRect;
var
  ABorderWidth: Integer;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinInfo(AStatusBar, ASkinInfo) then
  begin
    Result := cxRect(1, ASkinInfo.FormStatusBar.ContentOffset.Top, 1, 1);
    ABorderWidth := TdxCustomStatusBarAccess(AStatusBar).BorderWidth;
    OffsetRect(Result, ABorderWidth, ABorderWidth);
  end
  else
    inherited ContentExtents(AStatusBar);
end;

class function TdxStatusBarSkinPainter.IsSizeGripInPanelArea(AStatusBar: TdxCustomStatusBar): Boolean;
begin
  if IsSkinAvailable(AStatusBar) then
    Result := False
  else
    Result := inherited IsSizeGripInPanelArea(AStatusBar);
end;

class function TdxStatusBarSkinPainter.SizeGripMargins(AStatusBar: TdxCustomStatusBar): TRect;
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinInfo(AStatusBar, ASkinInfo) and (ASkinInfo.FormStatusBar <> nil) then
    Result := ASkinInfo.FormStatusBar.ContentOffset.Rect
  else
    Result := cxNullRect;
end;

class procedure TdxStatusBarSkinPainter.DrawBorder(
  AStatusBar: TdxCustomStatusBar; ACanvas: TcxCanvas; var R: TRect);
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
  AStatusBarRect: TRect;
begin
  if GetSkinInfo(AStatusBar, ASkinInfo) and (ASkinInfo.FormStatusBar <> nil) then
  begin
    AStatusBarRect := AStatusBar.Bounds;
    DrawClippedElement(ASkinInfo.FormStatusBar, ACanvas,
      CheckStatusBarRect(ASkinInfo.FormStatusBar, AStatusBarRect), R, roIntersect);
    R := cxRectContent(R, ContentExtents(AStatusBar));
  end
  else
    inherited DrawBorder(AStatusBar, ACanvas, R);
end;

class procedure TdxStatusBarSkinPainter.DrawClippedElement(AElement: TdxSkinElement;
  ACanvas: TcxCanvas; const ARect: TRect; const AClipRegion: TRect;
  ARegionOperation: TcxRegionOperation = roSet);
begin
  ACanvas.SaveClipRegion;
  try
    ACanvas.SetClipRegion(TcxRegion.Create(AClipRegion), ARegionOperation);
    AElement.Draw(ACanvas.Handle, ARect);
  finally
    ACanvas.RestoreClipRegion;
  end;
end;

class procedure TdxStatusBarSkinPainter.DrawEmptyPanel(AStatusBar: TdxCustomStatusBar;
  ACanvas: TcxCanvas; R: TRect);
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if not GetSkinInfo(AStatusBar, ASkinInfo) or (ASkinInfo.FormStatusBar = nil) then
    inherited DrawEmptyPanel(AStatusBar, ACanvas, R)
  else
    DrawClippedElement(ASkinInfo.FormStatusBar, ACanvas,
      CheckStatusBarRect(ASkinInfo.FormStatusBar, AStatusBar.Bounds), R);
end;

class procedure TdxStatusBarSkinPainter.DrawPanelBorder(AStatusBar: TdxCustomStatusBar;
  ABevel: TdxStatusBarPanelBevel; ACanvas: TcxCanvas; var R: TRect);
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if (ABevel <> dxpbNone) and GetSkinInfo(AStatusBar, ASkinInfo) and
    (ASkinInfo.LinkBorderPainter <> nil) then
  begin
    ASkinInfo.LinkBorderPainter.Draw(ACanvas.Handle, R);
    R := cxRectContent(R, ASkinInfo.LinkBorderPainter.ContentOffset.Rect);
  end
  else
    inherited DrawPanelBorder(AStatusBar, ABevel, ACanvas, R);
end;

class procedure TdxStatusBarSkinPainter.DrawPanelSeparator(AStatusBar: TdxCustomStatusBar;
  ACanvas: TcxCanvas; const R: TRect);
begin
  if not IsSkinAvailable(AStatusBar) then
    inherited DrawPanelSeparator(AStatusBar, ACanvas, R);
end;

class procedure TdxStatusBarSkinPainter.DrawSizeGrip(AStatusBar: TdxCustomStatusBar;
  ACanvas: TcxCanvas; R: TRect);
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  R := cxRectSetBottom(R, R.Bottom - 2, GripSize.cy);
  if GetSkinInfo(AStatusBar, ASkinInfo) and (ASkinInfo.SizeGrip <> nil) then
    ASkinInfo.SizeGrip.Draw(ACanvas.Handle, R)
  else
    inherited DrawSizeGrip(AStatusBar, ACanvas, R);
end;

class procedure TdxStatusBarSkinPainter.FillBackground(
  AStatusBar: TdxCustomStatusBar; APanel: TdxStatusBarPanel; ACanvas: TcxCanvas;
  const R: TRect);
begin
  if not IsSkinAvailable(AStatusBar) then
    inherited FillBackground(AStatusBar, APanel, ACanvas, R);
end;

class function TdxStatusBarSkinPainter.PanelContentExtents(
  AStatusBar: TdxCustomStatusBar; AHasBorders: Boolean): TRect;
var
  AInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if not AHasBorders then
    Result := cxNullRect
  else
    if GetSkinInfo(AStatusBar, AInfo) and (AInfo.LinkBorderPainter <> nil) then
      Result := AInfo.LinkBorderPainter.ContentOffset.Rect
    else
      Result := inherited PanelContentExtents(AStatusBar, AHasBorders);
end;

class function TdxStatusBarSkinPainter.SeparatorSize: Integer;
begin
  Result := 1;
end;

class function TdxStatusBarSkinPainter.CheckStatusBarRect(
  AFormStatusBar: TdxSkinElement; const R: TRect): TRect;
begin
  Result := R;
  if Assigned(AFormStatusBar) then
    with AFormStatusBar.ContentOffset do
    begin
      Dec(Result.Left, Left);
      Inc(Result.Right, Right);
      Inc(Result.Bottom, Bottom);
    end;
end;

class procedure TdxStatusBarSkinPainter.DrawContainerControl(APanelStyle: TdxStatusBarContainerPanelStyle);
var
  AControl: TdxStatusBarContainerControl;
  AParentRect: TRect;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
  AStatusBar: TdxCustomStatusBar;
begin
  AStatusBar := APanelStyle.StatusBarControl;
  if GetSkinInfo(AStatusBar, ASkinInfo) and (ASkinInfo.FormStatusBar <> nil) then
  begin
    AControl := APanelStyle.Container;
    AParentRect := cxRectOffset(AStatusBar.ClientBounds, -AControl.Left, -AControl.Top);
    DrawClippedElement(ASkinInfo.FormStatusBar, AControl.Canvas,
      CheckStatusBarRect(ASkinInfo.FormStatusBar, AParentRect), AControl.ClientRect,
      roIntersect);
  end
  else
    inherited DrawContainerControl(APanelStyle);
end;

class function TdxStatusBarSkinPainter.GetSkinInfo(AStatusBar: TdxCustomStatusBar;
  out ASkinInfo: TdxSkinLookAndFeelPainterInfo): Boolean;
begin
  with TdxCustomStatusBarAccess(AStatusBar) do
    Result := LookAndFeel.SkinPainter.GetPainterData(ASkinInfo);
end;

class function TdxStatusBarSkinPainter.IsSkinAvailable(
  AStatusBar: TdxCustomStatusBar): Boolean;
begin
  with TdxCustomStatusBarAccess(AStatusBar) do
    Result := LookAndFeel.SkinPainter <> nil;
end;

initialization
  dxStatusBarSkinPainterClass := TdxStatusBarSkinPainter;

finalization
  dxStatusBarSkinPainterClass := nil;

end.
