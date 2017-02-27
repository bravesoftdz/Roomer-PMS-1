{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars components                                      }
{                                                                   }
{       Copyright (c) 1998-2014 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
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

unit dxRibbonForm;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ImgList,
  dxCore, dxMessages, cxClasses, cxGraphics, cxControls, dxShadowWindow, dxRibbonSkins, dxRibbonFormCaptionHelper,
  cxDWMApi, dxAnimation, dxCoreClasses;

const
  dxRibbonAutoHideModeHideUIAnimationTime: Integer = 200;
  dxRibbonAutoHideModeShowUIAnimationTime: Integer = 500;

type
  TdxCustomRibbonForm = class;

  { IdxRibbonFormClient }

  IdxRibbonFormClient = interface
  ['{C409C9EF-4458-4133-AAA1-DCDCBFBC0B83}']
    procedure RibbonFormCaptionChanged;
    procedure RibbonFormResized;
  end;

  { IdxRibbonFormControllerHelper }

  IdxRibbonFormControllerHelper = interface
  ['{DEC82702-29ED-413B-852D-C2AA884FD99A}']
    procedure DoAfterApplicationMenuPopup;
    procedure DoBeforeApplicationMenuPopup;
    procedure DoBeforeShowKeyTips;
  end;

  { TdxRibbonFormShadowWindow }

  TdxRibbonFormShadowWindow = class(TdxShadowWindow)
  private
    function GetOwnerWindow: TdxCustomRibbonForm;
  protected
    function CalculateVisibility: Boolean; override;
  public
    property OwnerWindow: TdxCustomRibbonForm read GetOwnerWindow;
  end;

  { TdxRibbonAutoHideMode }

  TdxRibbonAutoHideMode = class(TPersistent)
  private
    FActive: Boolean;
    FAnimation: TdxAnimationTransition;
    FEnabled: Boolean;
    FIsUIShown: Boolean;
    FRibbonForm: TdxCustomRibbonForm;
    function GetRibbon: TWinControl;
    procedure SetActive(AValue: Boolean);
    procedure SetEnabled(AValue: Boolean);
  protected
    procedure AlignControls(const R: TRect); virtual;
    procedure Finalize; virtual;
    procedure Initialize; virtual;
    function GetOwner: TPersistent; override;
    function GetStatusBar(out AControl: TWinControl): Boolean;
    procedure UpdateUIVisibility(AVisible, AWithAnimation: Boolean);
    //
    property Ribbon: TWinControl read GetRibbon;
    property RibbonForm: TdxCustomRibbonForm read FRibbonForm;
  public
    constructor Create(ARibbonForm: TdxCustomRibbonForm); virtual;
    procedure Assign(Source: TPersistent); override;
    function IsAvailable: Boolean;
    procedure HideUI(AWithAnimation: Boolean = True);
    procedure ShowUI(AWithAnimation: Boolean = True);
    //
    property Active: Boolean read FActive write SetActive;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property IsUIShown: Boolean read FIsUIShown;
  end;

  { TdxRibbonAutoHideModeAnimation }

  TdxRibbonAutoHideModeAnimation = class(TdxAnimationTransition)
  private
    FActivating: Boolean;
    FAutoHideMode: TdxRibbonAutoHideMode;
    function GetRibbon: TWinControl;
    function GetRibbonForm: TdxCustomRibbonForm;
  protected
    procedure DoAnimate; override;
  public
    constructor Create(AAutoHideMode: TdxRibbonAutoHideMode; AActivating: Boolean); reintroduce;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    //
    property Activating: Boolean read FActivating;
    property AutoHideMode: TdxRibbonAutoHideMode read FAutoHideMode;
    property Ribbon: TWinControl read GetRibbon;
    property RibbonForm: TdxCustomRibbonForm read GetRibbonForm;
  end;

  { TdxRibbonAutoHideModeController }

  TdxRibbonAutoHideModeController = class(TComponent)
  private
    FActiveRibbonForm: TdxCustomRibbonForm;
    function IsChildHandle(AHandle: HWND): Boolean;
    function IsInCaptionArea(const P: TPoint): Boolean;
    procedure SetActiveRibbonForm(const AValue: TdxCustomRibbonForm);
  protected
    procedure HookKeyboard(AKey: Word; AData: LPARAM; var AHookResult: LRESULT); virtual;
    procedure HookMouse(wParam: WPARAM; lParam: PMouseHookStruct; var AHookResult: LRESULT); virtual;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure UpdateHooksState;
  public
    destructor Destroy; override;
    //
    property ActiveRibbonForm: TdxCustomRibbonForm read FActiveRibbonForm write SetActiveRibbonForm;
  end;

  { TdxCustomRibbonForm }

  TdxCustomRibbonForm = class(TForm, IdxRibbonFormControllerHelper)
  private
    FAdjustLayoutForNonClientDrawing: Boolean;
    FAutoScroll: Boolean;
    FCaption: TCaption;
    FCornerRegions: array[0..3] of HRGN;
    FData: TdxRibbonFormData;
    FDefClientProc: TFarProc;
    FDelayedActivate: Boolean;
    FDisableAero: Boolean;
    FDisableMDIClientScrollBars: Boolean;
    FExtendFrameAtTopHeight: Integer;
    FFakeClientHandle: HWND;
    FHasRegion: Boolean;
    FIsActive: Boolean;
    FLoadedSystemMenu: HMENU;
    FNeedCallActivate: Boolean;
    FNewClientInstance: TFarProc;
    FOldClientProc: TFarProc;
    FPrevActiveControl: TWinControl;
    FRedrawCount: Integer;
    FResettingGlass: Boolean;
  {$IFDEF DELPHI10}
    FRibbonAlwaysOnTop: Boolean;
  {$ENDIF}
    FRibbonAutoHideMode: TdxRibbonAutoHideMode;
    FRibbonControl: TWinControl;
    FRibbonFormClient: IdxRibbonFormClient;
    FRibbonNonClientHelper: TdxRibbonFormCaptionHelper;
    FShadow: TdxRibbonFormShadowWindow;
    FSizingBorders: TSize;
    FSizingLoop: Boolean;
    FUseSkinColor: Boolean;
    FVisibleChanging: Boolean;
    FZoomedBoundsOffsets: TRect;
    procedure AfterResize(APrevRibbonVisible: Boolean; APrevRibbonHeight: Integer; AIsZoomed: Boolean);
    procedure BeforeResize(out ARibbonVisible: Boolean; out ARibbonHeight: Integer);
    procedure CalculateCornerRegions;
    procedure CalculateZoomedOffsets;
    function CanSetWindowRegion(ARegion: HRGN): Boolean;
    procedure CheckExtendFrame(AZoomed: Boolean);
    procedure CheckResizingNCHitTest(var AHitTest: LRESULT; const P: TPoint);
    procedure CorrectWindowStyle(var AStyle: Cardinal);
    procedure CorrectZoomedBounds(var R: TRect);
    procedure CreateCornerRegions;
    procedure DestroyCornerRegions;
    procedure ExcludeRibbonPaintArea(DC: HDC);
    procedure ForceUpdateWindowSize;
    procedure FullRedrawWithChildren;
    function GetApplicationMenuState: TdxRibbonApplicationMenuState;
    function GetBackgroundColor: TColor;
    function GetBorderIcons: TBorderIcons;
    function GetBorderStyle: TFormBorderStyle;
    function GetCurrentBordersWidth: TRect;
    function GetIsDestroying: Boolean;
    function GetRibbonNonClientHelper: TdxRibbonFormCaptionHelper;
    function GetRibbonStyle: TdxRibbonStyle;
    function GetUseSkin: Boolean;
    procedure FinalizeSkin;
    procedure InitializeSkin;
    procedure InvalidateFrame(AWnd: HWND; AUpdate: Boolean = False);
    function IsNeedCorrectForAutoHideTaskBar: Boolean;
    function IsNeedUpdateCornerRegions: Boolean;
    function IsNormalWindowState: Boolean;
    function IsRibbonHelpButtonPlacedOnCaption: Boolean;
    procedure DestroySystemMenu;
    procedure LoadSystemMenu;
    procedure NewClientWndProc(var Message: TMessage);
    procedure ResetStandardSystemMenu;
    procedure SetAutoScroll(const Value: Boolean);
    procedure SetBorderIcons(const Value: TBorderIcons);
    procedure SetBorderStyle(const Value: TFormBorderStyle);
    procedure SetDisableAero(const Value: Boolean);
    procedure SetDisableMDIClientScrollBars(const Value: Boolean);
    procedure SetPrevActiveControl(AValue: TWinControl);
    procedure SetRegion(ARegion: HRGN; ARedraw: Boolean = False);
    procedure SetRibbonControl(AValue: TWinControl);
  {$IFDEF DELPHI10}
    procedure SetRibbonAlwaysOnTop(const Value: Boolean);
  {$ENDIF}
    procedure SetRibbonAutoHideMode(const AValue: TdxRibbonAutoHideMode);
    procedure SetRibbonNonClientHelper(AValue: TdxRibbonFormCaptionHelper);
    procedure SetUseSkinColor(const Value: Boolean);
    procedure ShowSystemMenu(AFromMouse: Boolean);
    procedure ResetGlassFrame;
    procedure UpdateGlassFrame;
    //messages
    procedure CMActionUpdate(var Message: TMessage); message CM_ACTIONUPDATE;
    procedure CMActivate(var Message: TCMActivate); message CM_ACTIVATE;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure DXMRibbonFormNCChanged(var Message: TMessage); message DXM_RIBBONFORM_NCCHANGED;
    procedure DXMRibbonFormSysCommand(var Message: TMessage); message DXM_RIBBONFORM_SYSCOMMAND;
    procedure WMDisplayChange(var Message: TMessage); message WM_DISPLAYCHANGE;
    procedure WMDWMCompositionChanged(var Message: TMessage); message WM_DWMCOMPOSITIONCHANGED;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetText(var Message: TWMGetText); message WM_GETTEXT;
    procedure WMGetTextLength(var Message: TWMGetTextLength); message WM_GETTEXTLENGTH;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMNCActivate(var Message: TWMNCActivate); message WM_NCACTIVATE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure WMNCRButtonUp(var Message: TWMNCRButtonUp); message WM_NCRBUTTONUP;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMSetText(var Message: TWMSetText); message WM_SETTEXT;
    procedure WMShowWindow(var Message: TMessage); message WM_SHOWWINDOW;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMStyleChanging(var Message: TWMStyleChanging); message WM_STYLECHANGING;
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
  protected
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure AdjustLayout; virtual;
    procedure AdjustSize; override;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure BuildSystemMenu(AMenu: THandle); virtual;
    procedure CallDWMWindowProc(var Message);
    function CanAdjustLayout: Boolean; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWindowHandle; override;
    procedure DoCreate; override;
    procedure DrawNonClientArea(ADrawCaption: Boolean; AUpdateRegion: HRGN = 1);
    procedure ExtendFrameIntoClientAreaAtTop(AHeight: Integer);
    function GetFormBorderIcons: TdxRibbonBorderIcons; virtual;
    function GetMDIParent: TdxCustomRibbonForm;
    function HandleWithHelper(ADown: Boolean; AButton: TMouseButton): Boolean; virtual;
    procedure InitializeNewForm; {$IFDEF DELPHI12} override; {$ENDIF}
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure ModifySystemMenu(ASysMenu: THandle); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RecalculateCaptionArea;
    procedure RecalculateFormSizes;
    procedure ResetSystemMenu;
    procedure Resize; override;
    procedure ShiftControlsVertically(ADelta: Integer); virtual;
    procedure UpdateBorderIcons;
    procedure UpdateNonClientArea;
    procedure UpdateSkins;
    procedure UpdateSystemMenu;
    procedure UpdateWindowRegion(AIsMaximized: Boolean);
    procedure UpdateWindowStates;
    procedure WndProc(var Message: TMessage); override;

    // IdxRibbonFormControllerHelper
    procedure DoAfterApplicationMenuPopup;
    procedure DoBeforeApplicationMenuPopup;
    procedure DoBeforeShowKeyTips;

    property ApplicationMenuState: TdxRibbonApplicationMenuState read GetApplicationMenuState;
    property DisableAero: Boolean read FDisableAero write SetDisableAero default False;
    property DisableMDIClientScrollBars: Boolean read FDisableMDIClientScrollBars write SetDisableMDIClientScrollBars default True;
    property IsDestroying: Boolean read GetIsDestroying;
    property RibbonFormClient: IdxRibbonFormClient read FRibbonFormClient;
    property RibbonStyle: TdxRibbonStyle read GetRibbonStyle;
    property UseSkin: Boolean read GetUseSkin;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    destructor Destroy; override;
    procedure FullUpdate;
    function GetCaptionHeightDelta(AHasQuickAccessToolbar: Boolean): Integer; virtual;
    procedure GetTabOrderList(List: TList); override;
    procedure Invalidate; override;
    function IsUseAeroNCPaint: Boolean;
    procedure ResetWindowRegion;
    procedure SetRedraw(ARedraw: Boolean);
    procedure UpdateBorders;
    procedure UpdateColorScheme;

    property IsActive: Boolean read FIsActive;
    property PrevActiveControl: TWinControl read FPrevActiveControl write SetPrevActiveControl;
  {$IFDEF DELPHI10}
    property RibbonAlwaysOnTop: Boolean read FRibbonAlwaysOnTop write SetRibbonAlwaysOnTop;
  {$ENDIF}
    property RibbonAutoHideMode: TdxRibbonAutoHideMode read FRibbonAutoHideMode write SetRibbonAutoHideMode;
    property RibbonControl: TWinControl read FRibbonControl write SetRibbonControl;
    property RibbonNonClientHelper: TdxRibbonFormCaptionHelper read GetRibbonNonClientHelper write SetRibbonNonClientHelper;
  published
    property AdjustLayoutForNonClientDrawing: Boolean read FAdjustLayoutForNonClientDrawing write FAdjustLayoutForNonClientDrawing default True;
    property AutoScroll: Boolean read FAutoScroll write SetAutoScroll default False;
    property BorderIcons: TBorderIcons read GetBorderIcons write SetBorderIcons;
    property BorderStyle: TFormBorderStyle read GetBorderStyle write SetBorderStyle default bsSizeable;
    property KeyPreview default True;
    property UseSkinColor: Boolean read FUseSkinColor write SetUseSkinColor default True;
  end;

  { TdxRibbonForm }

  TdxRibbonForm = class(TdxCustomRibbonForm);

procedure SetWindowTextWithoutRedraw(AWnd: HWND; const AText: string);
implementation

uses
  Types, dxBar, cxGeometry, Math, dxOffice11, dxUxTheme, MultiMon, ShellAPI,
  dxRibbon, dxStatusBar, dxHooks, cxContainer;

const
  WM_NCUAHDRAWCAPTION      = $00AE;
  WM_NCUAHDRAWFRAME        = $00AF;
  WM_SYNCPAINT             = $0088;
  WM_SYSMENU               = $313;
  WM_DWMNCRENDERINGCHANGED = $031F;

  dxAdjustFormSizeFlags = SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOZORDER or SWP_NOACTIVATE;
  dxFullRedrawFlags = RDW_INVALIDATE or RDW_ERASE or RDW_FRAME or RDW_ALLCHILDREN;

  dxGlassMaximizedNonClientHeight = 4;

type
  TControlAccess = class(TControl);

var
  FAutoHideModeController: TdxRibbonAutoHideModeController = nil;
  FUnitIsFinalized: Boolean = False;

function GetAnimation: Boolean;
var
  AInfo: TAnimationInfo;
begin
  if dxSystemInfo.GetParameter(SPI_GETANIMATION, AInfo) then
    Result := AInfo.iMinAnimate <> 0
  else
    Result := False;
end;

procedure SetAnimation(AValue: Boolean);
var
  AInfo: TAnimationInfo;
begin
  AInfo.cbSize := SizeOf(TAnimationInfo);
  BOOL(AInfo.iMinAnimate) := AValue;
  SystemParametersInfo(SPI_SETANIMATION, SizeOf(AInfo), @AInfo, 0);
end;

procedure SetWindowTextWithoutRedraw(AWnd: HWND; const AText: string);
var
  AStyles: Cardinal;
begin
  AStyles := dxSetWindowStyle(AWnd, WS_VISIBLE, soSubtract);
  DefWindowProc(AWnd, WM_SETTEXT, 0, LPARAM(PChar(AText)));
  dxSetWindowStyle(AWnd, AStyles, soSet);
end;

function dxRibbonAutoHideModeController: TdxRibbonAutoHideModeController;
begin
  if (FAutoHideModeController = nil) and not FUnitIsFinalized then
    FAutoHideModeController := TdxRibbonAutoHideModeController.Create(nil);
  Result := FAutoHideModeController;
end;

procedure dxRibbonAutoHideControllerMouseHook(ACode: Integer; wParam: WPARAM; lParam: LPARAM; var AHookResult: LRESULT);
begin
  if ACode = HC_ACTION then
    FAutoHideModeController.HookMouse(wParam, PMouseHookStruct(lParam), AHookResult);
end;

procedure dxRibbonAutoHideControllerKeyboardHook(ACode: Integer; wParam: WPARAM; lParam: LPARAM; var AHookResult: LRESULT);
begin
  if ACode = HC_ACTION then
    FAutoHideModeController.HookKeyboard(wParam, lParam, AHookResult);
end;

{ TdxCustomRibbonForm }

constructor TdxCustomRibbonForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner); //CBUILDER workaround
end;

constructor TdxCustomRibbonForm.CreateNew(AOwner: TComponent; Dummy: Integer = 0);
begin
  inherited CreateNew(AOwner, Dummy);
{$IFNDEF DELPHI12}
  InitializeNewForm;
{$ENDIF}
end;

destructor TdxCustomRibbonForm.Destroy;
begin
  RibbonControl := nil;
  DestroyCornerRegions;
  FreeAndNil(FShadow);
  inherited Destroy;
  FreeAndNil(FRibbonAutoHideMode);
end;

procedure TdxCustomRibbonForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  CorrectWindowStyle(Params.Style);
end;

procedure TdxCustomRibbonForm.FullUpdate;
begin
  UpdateGlassFrame;
  if HandleAllocated then
  begin
    UpdateSystemMenu;
    RecalculateFormSizes;
    FullRedrawWithChildren;
  end;
end;

function TdxCustomRibbonForm.GetCaptionHeightDelta(AHasQuickAccessToolbar: Boolean): Integer;
begin
  Result := 0;
end;

procedure TdxCustomRibbonForm.GetTabOrderList(List: TList);
begin
  if ApplicationMenuState <> ramsHidden then
    RibbonNonClientHelper.GetApplicationMenuTabOrderList(List)
  else
    inherited GetTabOrderList(List);
end;

procedure TdxCustomRibbonForm.Invalidate;
begin
  if HandleAllocated and not IsIconic(Handle) then
    CheckExtendFrame(IsZoomed(Handle));
  inherited Invalidate;
  if ClientHandle <> 0 then
    InvalidateRect(ClientHandle, nil, True);
end;

procedure TdxCustomRibbonForm.CreateWnd;
var
  ClientCreateStruct: TClientCreateStruct;
begin
  FExtendFrameAtTopHeight := -1;
  inherited CreateWnd;
  if not (csDesigning in ComponentState) and (FormStyle = fsMDIForm) then
  begin
    with ClientCreateStruct do
    begin
      idFirstChild := $FF00; //check
      hWindowMenu := 0;
    end;
    FFakeClientHandle := Windows.CreateWindowEx(WS_EX_CLIENTEDGE, 'MDICLIENT',
      nil, WS_CHILD or WS_VISIBLE or WS_GROUP or WS_TABSTOP or
      WS_CLIPCHILDREN or WS_CLIPSIBLINGS or
      MDIS_ALLCHILDSTYLES, 0, 0, ClientWidth, ClientHeight, Handle, 0,
      HInstance, @ClientCreateStruct);
    SetWindowPos(FFakeClientHandle, 0, -20, -20, 10, 10, SWP_NOACTIVATE or SWP_NOZORDER);
    FOldClientProc := Pointer(GetWindowLong(ClientHandle, GWL_WNDPROC));
    FDefClientProc := Pointer(GetWindowLong(FFakeClientHandle, GWL_WNDPROC));
    FNewClientInstance := Classes.MakeObjectInstance(NewClientWndProc);
    dxSetWindowProc(ClientHandle, FNewClientInstance);
    if ClientHandle <> 0 then
    begin
      SetWindowLong(ClientHandle, GWL_EXSTYLE,
        GetWindowLong(ClientHandle, GWL_EXSTYLE) and not WS_EX_CLIENTEDGE);
      InvalidateFrame(ClientHandle);
    end;
  end;
  UpdateSystemMenu;
  LoadSystemMenu;
end;

procedure TdxCustomRibbonForm.DestroyWindowHandle;
begin
  DestroySystemMenu;
  inherited DestroyWindowHandle;
  if IsDestroying then
    RibbonNonClientHelper := nil;
end;

procedure TdxCustomRibbonForm.DoAfterApplicationMenuPopup;
begin
  UpdateColorScheme;
end;

procedure TdxCustomRibbonForm.DoBeforeApplicationMenuPopup;
begin
  RibbonAutoHideMode.HideUI(False);
  UpdateColorScheme;
end;

procedure TdxCustomRibbonForm.DoBeforeShowKeyTips;
begin
  RibbonAutoHideMode.ShowUI(False);
end;

procedure TdxCustomRibbonForm.DoCreate;
begin
  inherited DoCreate;
  if UseSkin then
    AdjustLayout;
end;

procedure TdxCustomRibbonForm.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
  if UseSkin and IsZoomed(Handle) and IsUseAeroNCPaint then
    Inc(Rect.Top, dxGlassMaximizedNonClientHeight);
  if RibbonAutoHideMode.Active then
    Inc(Rect.Top, RibbonNonClientHelper.GetWindowCaptionHeight);
end;

procedure TdxCustomRibbonForm.AdjustLayout;
var
  ALoadedHeight, AHeight, ADelta: Integer;
begin
  if CanAdjustLayout then
  begin
    RibbonNonClientHelper.GetDesignInfo(ALoadedHeight, AHeight);
    ADelta := AHeight - ALoadedHeight;
    if WindowState <> wsMaximized then
      ClientHeight := ClientHeight + ADelta - (GetSystemMetrics(SM_CYCAPTION) + GetDefaultWindowBordersWidth(Handle).Top);
    ShiftControlsVertically(ADelta);
  end;
end;

procedure TdxCustomRibbonForm.AdjustSize;
{$IFDEF DELPHI11}
var
  AFlags: Cardinal;
{$ENDIF}
begin
{$IFDEF DELPHI11}
  if not (csLoading in ComponentState) and HandleAllocated then
  begin
    AFlags := SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOZORDER;
    if IsZoomed(Handle) then
      AFlags := AFlags or SWP_NOSIZE;
    SetWindowPos(Handle, 0, 0, 0, Width, Height, AFlags);
    RequestAlign;
  end;
{$ELSE}
  inherited AdjustSize;
{$ENDIF}
end;

procedure TdxCustomRibbonForm.AlignControls(AControl: TControl; var Rect: TRect);
{$IFDEF DELPHI10}

  function AlignWork: Boolean;
  var
    I: Integer;
  begin
    Result := True;
    for I := ControlCount - 1 downto 0 do
    begin
      if (Controls[I].Align <> alNone) or (Controls[I].Anchors <> [akLeft, akTop]) then
        Exit;
    end;
    Result := False;
  end;

{$ENDIF}
begin
{$IFDEF DELPHI10}
  if RibbonAlwaysOnTop and UseSkin and AlignWork then
  begin
    if RibbonControl <> nil then
      TControlAccess(RibbonControl).UpdateBoundsRect(cxRectSetTop(AControl.BoundsRect, -1));
  end;
{$ENDIF}
  RibbonAutoHideMode.AlignControls(Rect);
  inherited AlignControls(AControl, Rect);
end;

procedure TdxCustomRibbonForm.CallDWMWindowProc(var Message);
begin
  DwmDefWindowProc(Handle, TMessage(Message).Msg, TMessage(Message).WParam,
    TMessage(Message).LParam, LRESULT(@TMessage(Message).Result));
end;

function TdxCustomRibbonForm.CanAdjustLayout: Boolean;
begin
  Result := AdjustLayoutForNonClientDrawing and
    ([csDesigning, csDestroying, csReading, csLoading] * ComponentState = []);
end;

procedure TdxCustomRibbonForm.NewClientWndProc(var Message: TMessage);

  procedure Default;
  begin
    with Message do
      Result := CallWindowProc(FDefClientProc, ClientHandle, Msg, wParam, lParam);
  end;

  procedure OldDefault;
  begin
    with Message do
      Result := CallWindowProc(FOldClientProc, ClientHandle, Msg, wParam, lParam);
  end;

  function MaximizedChildren: Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to MDIChildCount - 1 do
      if MDIChildren[I].WindowState = wsMaximized then
      begin
        Result := True;
        Break;
      end;
  end;

var
  AColor: TColor;
  PS: TPaintStruct;
  R: TRect;
begin
  if DisableMDIClientScrollBars then
  begin
    if (Message.Msg = WM_NCCALCSIZE) or (Message.Msg = WM_NCPAINT) then
      Exit;
  end;

  if not UseSkin then
  begin
    case Message.Msg of
      WM_NCHITTEST, WM_PAINT, WM_ERASEBKGND:
        OldDefault;
      else
        Default;
    end;
    Exit;
  end;

  case Message.Msg of
    WM_PAINT:
      if TWMPaint(Message).DC = 0 then
      begin
        TWMPaint(Message).DC := BeginPaint(ClientHandle, PS);
        R := cxGetWindowRect(ClientHandle);
        R.TopLeft := ScreenToClient(R.TopLeft);
        MoveWindowOrg(TWMPaint(Message).DC, -R.Left, -R.Top);
        PaintHandler(TWMPaint(Message));
        EndPaint(ClientHandle, PS);
        TWMPaint(Message).DC := 0;
      end
      else
        PaintHandler(TWMPaint(Message));

    WM_ERASEBKGND:
      begin
        AColor := GetBackgroundColor;
        FillRectByColor(TWMEraseBkGnd(Message).DC, ClientRect, AColor);
        // Erase the background at the location of an MDI client window
        if (FormStyle = fsMDIForm) and (ClientHandle <> 0) then
        begin
          Windows.GetClientRect(ClientHandle, R);
          FillRectByColor(TWMEraseBkGnd(Message).DC, R, AColor);
        end;
        Message.Result := 1;
      end;

    WM_KEYDOWN:
      begin
        KeyDown(Message.WParamLo, KeyDataToShiftState(Message.LParam));
        if Message.WParamLo = 0 then Exit;
        Default;
      end;

    WM_NCHITTEST:
      begin
        Default;
        if Message.Result = HTCLIENT then
          Message.Result := HTTRANSPARENT;
      end;
    {
    $3F://!
      begin
        Default;
        F := ActiveMDIChild;
        if (F <> nil) and MaximizedChildren then
        begin
          //correct maximized bounds
          GetWindowRect(ClientHandle, R);
          R.Right := R.Right - R.Left + (F.Width - F.ClientWidth);
          R.Bottom := R.Bottom - R.Top + (F.Height - F.ClientHeight);
          if (F is TdxCustomRibbonForm) and TdxCustomRibbonForm(F).UseSkin then
            Inc(R.Bottom, TdxCustomRibbonForm(F).RibbonNonClientHelper.GetWindowCaptionHeight);
          SetWindowPos(F.Handle, 0, 0, 0, R.Right, R.Bottom,
            SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOZORDER);
        end;
      end;
    }
    WM_MDIREFRESHMENU:
      Message.Result := 0;
    WM_NCACTIVATE:
      Message.Result := 1;
    else
      Default;
  end;
end;

procedure TdxCustomRibbonForm.DrawNonClientArea(ADrawCaption: Boolean; AUpdateRegion: HRGN = 1);
var
  DC: HDC;
  AFlags: Integer;
  ARgn: HRGN;
  AZoomed: Boolean;
begin
  if IsUseAeroNCPaint then Exit;
  UpdateWindowStates;
  AFlags := DCX_CACHE or DCX_CLIPSIBLINGS or DCX_WINDOW or DCX_VALIDATE;
  if AUpdateRegion <> 1 then
  begin
    ARgn := CreateRectRgnIndirect(cxEmptyRect);
    CombineRgn(ARgn, AUpdateRegion, 0, RGN_COPY);
    DC := GetDCEx(Handle, ARgn, AFlags or DCX_INTERSECTRGN);
  end
  else
    DC := GetDCEx(Handle, 0, AFlags);
  cxPaintCanvas.BeginPaint(DC);
  cxPaintCanvas.Canvas.Lock;
  try
    if IsIconic(Handle) then
      RibbonNonClientHelper.DrawWindowCaption(cxPaintCanvas, Caption)
    else
    begin
      AZoomed := IsZoomed(Handle);
      if not AZoomed then
        RibbonNonClientHelper.DrawWindowBorders(cxPaintCanvas);
      if ADrawCaption then
        RibbonNonClientHelper.DrawWindowCaption(nil, Caption);
    end;
  finally
    cxPaintCanvas.Canvas.Unlock;
    cxPaintCanvas.EndPaint;
    ReleaseDC(Handle, DC);
  end;
end;

procedure TdxCustomRibbonForm.DXMRibbonFormNCChanged(var Message: TMessage);
begin
  inherited;
  if AutoSize then
    AdjustSize;
end;

procedure TdxCustomRibbonForm.DXMRibbonFormSysCommand(var Message: TMessage);

  function GetSystemCommand(AIcon: TdxRibbonBorderIcon): Word;
  const
    Commands: array[Boolean, Boolean] of Word = (
      (SC_MINIMIZE, SC_RESTORE), (SC_MAXIMIZE, SC_RESTORE)
    );
  begin
    case AIcon of
      rbiMinimize:
        Result := Commands[False, WindowState = wsMinimized];
      rbiMaximize:
        Result := Commands[True, WindowState = wsMaximized];
      else
        Result := SC_CLOSE;
    end;
  end;

var
  AIcon: TdxRibbonBorderIcon;
begin
  AIcon := TdxRibbonBorderIcon(Message.WParam);
  case AIcon of
    rbiSystemMenu, rbiMinimize, rbiMaximize:
      PostMessage(Handle, WM_SYSCOMMAND, GetSystemCommand(AIcon), 0);
    rbiAutoHide:
      RibbonAutoHideMode.Active := not RibbonAutoHideMode.Active;
    rbiAutoHideModeShowUI:
      RibbonAutoHideMode.ShowUI;
    rbiHelp:
      if IsRibbonHelpButtonPlacedOnCaption then
        RibbonNonClientHelper.RibbonHelper.DoHelpButtonClick
      else
        PostMessage(Handle, WM_SYSCOMMAND, SC_CONTEXTHELP, 0);
  end;
end;

function TdxCustomRibbonForm.HandleWithHelper(ADown: Boolean; AButton: TMouseButton): Boolean;
var
  P: TPoint;
begin
  Result := UseSkin;
  if Result then
  begin
    P := GetMouseCursorPos;
    if RibbonNonClientHelper.IsInCaptionArea(P) then
    begin
      if ADown then
        Result := RibbonNonClientHelper.MouseDown(P, AButton)
      else
        Result := RibbonNonClientHelper.MouseUp(P, AButton);
    end
    else
      Result := False;
  end;
end;

procedure TdxCustomRibbonForm.InitializeNewForm;
begin
{$IFDEF DELPHI12}
  inherited InitializeNewForm;
{$ENDIF}
  FAutoScroll := False;
  FUseSkinColor := True;
  FDisableMDIClientScrollBars := True;
  FAdjustLayoutForNonClientDrawing := True;
  AutoScroll := False;
  KeyPreview := True;
  FShadow := TdxRibbonFormShadowWindow.Create(Self);
  FShadow.AllowResizeOwnerWindowViaShadow := True;
  FRibbonAutoHideMode := TdxRibbonAutoHideMode.Create(Self);
  CreateCornerRegions;
end;

procedure TdxCustomRibbonForm.KeyDown(var Key: Word; Shift: TShiftState);
var
  I: Integer;
  AIntf: IdxFormKeyPreviewListener;
  AForm: TForm;
begin
  inherited KeyDown(Key, Shift);
  if KeyPreview then
  begin
    if FormStyle = fsMDIChild then
      AForm := Application.MainForm
    else
      AForm := Self;

    for I := 0 to AForm.ControlCount - 1 do
      if Supports(AForm.Controls[I], IdxFormKeyPreviewListener, AIntf) then
      begin
        AIntf.FormKeyDown(Key, Shift);
        AIntf := nil;
      end;
  end;
end;

procedure TdxCustomRibbonForm.ModifySystemMenu(ASysMenu: THandle);
begin
  if BorderStyle <> bsNone then
    cxModifySystemMenu(ASysMenu, Handle,
      BorderStyle = bsDialog, BorderIcons, WindowState, False);
end;

procedure TdxCustomRibbonForm.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if Operation = opRemove then
  begin
    if AComponent = FPrevActiveControl then
      FPrevActiveControl := nil;
    if AComponent = RibbonControl then
      RibbonControl := nil;
  end;
  inherited Notification(AComponent, Operation);
end;

procedure TdxCustomRibbonForm.ResetSystemMenu;
begin
  if HandleAllocated then
    LoadSystemMenu;
end;

procedure TdxCustomRibbonForm.Resize;
begin
  if AlignDisabled then Exit;
  inherited Resize;
end;

procedure TdxCustomRibbonForm.ShiftControlsVertically(ADelta: Integer);
var
  I: Integer;
  R: TRect;
begin
  if ADelta = 0 then Exit;
  DisableAlign;
  try
    for I := 0 to ControlCount - 1 do
      with Controls[I] do
        if Align in [alNone, alCustom] then
        begin
          if akBottom in Anchors then
          begin
            if akTop in Anchors then
            begin
              R := BoundsRect;
              Inc(R.Top, ADelta);
              BoundsRect := R;
            end;
          end
          else
            Top := Top + ADelta;
        end;
  finally
    EnableAlign;
  end;
end;

procedure TdxCustomRibbonForm.UpdateNonClientArea;
begin
  UpdateWindowStates;
  if UseSkin and IsWindowVisible(Handle) then
  begin
    DrawNonClientArea(False);
    RibbonNonClientHelper.UpdateNonClientArea;
  end;
end;

procedure TdxCustomRibbonForm.UpdateWindowRegion(AIsMaximized: Boolean);
var
  ARgn: HRGN;
begin
  if UseSkin and not IsUseAeroNCPaint then
  begin
    if not AIsMaximized then
      ARgn := RibbonNonClientHelper.GetWindowRegion
    else
      if FormStyle = fsMDIChild then
        ARgn := 0
      else
        ARgn := CreateRectRgnIndirect(cxRectContent(
          cxGetWindowBounds(Handle), GetDefaultWindowBordersWidth(Handle)));

    SetRegion(ARgn, True);
  end;
end;

procedure TdxCustomRibbonForm.UpdateWindowStates;
begin
  if UseSkin and not IsDestroying then
  begin
    FillChar(FData, SizeOf(TdxRibbonFormData), 0);
    if HandleAllocated then
    begin
      FData.Handle := Handle;
      FData.Bounds := cxRectSetNullOrigin(cxGetWindowRect(Self));
      if IsIconic(Handle) then
        FData.State := wsMinimized
      else if IsZoomed(Handle) then
        FData.State := wsMaximized
      else
        FData.State := wsNormal;
    end;
    FData.Active := FIsActive;
    FData.Border := BorderStyle;
    FData.Style  := FormStyle;
    FData.DontUseAero := DisableAero or (ParentWindow <> 0);
    FData.UseRoundedWindowCorners := RibbonNonClientHelper.UseRoundedWindowCorners;
    RibbonNonClientHelper.CheckWindowStates(FData);
  end;
end;

procedure TdxCustomRibbonForm.AfterResize(
  APrevRibbonVisible: Boolean; APrevRibbonHeight: Integer; AIsZoomed: Boolean);

  procedure CheckGlassFrame;
  begin
    if UseSkin and IsUseAeroNCPaint then
    begin
      if AIsZoomed then
        ResetWindowRegion;
      CheckExtendFrame(AIsZoomed);
    end;
  end;

  procedure DoRibbonFormResized;
  begin
    if RibbonFormClient <> nil then
      RibbonFormClient.RibbonFormResized;
  end;

var
  ARibbonHandle: THandle;
begin
  if APrevRibbonVisible then
  begin
    ARibbonHandle := RibbonControl.Handle;
    if (ApplicationMenuState = ramsHidden) and IsWindowVisible(ARibbonHandle) then
    begin
      SendMessage(ARibbonHandle, WM_SETREDRAW, 0, 0);
      EnableAlign;
      CheckGlassFrame; 
      if APrevRibbonHeight <> RibbonControl.Height then
      begin
        RedrawWindow(Handle, nil, 0, dxFullRedrawFlags or RDW_UPDATENOW);
        //ensure redraw after restoring minimized ribbon for MDI form
        if FormStyle = fsMDIForm then
          RedrawWindow(ClientHandle, nil, 0, RDW_INVALIDATE or RDW_ALLCHILDREN);
        Realign;
      end;
      SendMessage(ARibbonHandle, WM_SETREDRAW, 1, 0);
      RedrawWindow(ARibbonHandle, nil, 0, dxFullRedrawFlags or RDW_UPDATENOW);
    end
    else
    begin
      EnableAlign;
      CheckGlassFrame;
    end;
    Resize;
  end;
  DoRibbonFormResized;
end;

procedure TdxCustomRibbonForm.BeforeResize(out ARibbonVisible: Boolean; out ARibbonHeight: Integer);
begin
  ARibbonVisible := (RibbonControl <> nil) and RibbonControl.HandleAllocated;
  if ARibbonVisible then
  begin
    ARibbonHeight := RibbonControl.Height;
    DisableAlign;
  end
  else
    ARibbonHeight := -1;
end;

procedure TdxCustomRibbonForm.CalculateCornerRegions;

  procedure CalculateRegion(ACornerRgn: HRGN; DX, DY: Integer; const ACornerRect: TRect);
  var
    R1, R2: HRGN;
  begin
    R1 := CreateRectRgnIndirect(cxEmptyRect);
    GetWindowRgn(Handle, ACornerRgn);
    GetWindowRgn(Handle, R1);
    OffsetRgn(R1, DX, DY);
    CombineRgn(ACornerRgn, ACornerRgn, R1, RGN_DIFF);
    R2 := CreateRectRgnIndirect(ACornerRect);
    CombineRgn(ACornerRgn, ACornerRgn, R2, RGN_AND);
    DeleteObject(R1);
    DeleteObject(R2);
  end;

var
  H: Integer;
begin
  if FData.UseRoundedWindowCorners then
    H := GetSystemMetrics(SM_CYCAPTION)
  else
    H := FSizingBorders.cy;

  CalculateRegion(FCornerRegions[0],  FSizingBorders.cx,  FSizingBorders.cy,
    cxRect(0, 0, H, H));
  CalculateRegion(FCornerRegions[1], -FSizingBorders.cx,  FSizingBorders.cy,
    cxRect(Width - H, 0, Width, H));
  CalculateRegion(FCornerRegions[2], -FSizingBorders.cx, -FSizingBorders.cy,
    cxRect(Width - H, Height - H, Width, Height));
  CalculateRegion(FCornerRegions[3],  FSizingBorders.cx, -FSizingBorders.cy,
    cxRect(0, Height - H, H, Height));
end;

procedure TdxCustomRibbonForm.CalculateZoomedOffsets;
var
  ABData: TAppBarData;
begin
  FZoomedBoundsOffsets := cxEmptyRect;
  if IsNeedCorrectForAutoHideTaskBar then
  begin
    FillChar(ABData, sizeof(ABData), 0);
    ABData.cbSize := sizeof(ABData);
    ABData.hWnd := Handle;
    SHAppBarMessage(ABM_GETTASKBARPOS, ABData);
    if ABData.uEdge = ABE_LEFT then
      FZoomedBoundsOffsets.Left := 1
    else if (ABData.uEdge = ABE_TOP) and not IsUseAeroNCPaint then
      FZoomedBoundsOffsets.Top := 1
    else if ABData.uEdge = ABE_RIGHT then
      FZoomedBoundsOffsets.Right := 1 + Ord(IsUseAeroNCPaint)
    else if ABData.uEdge = ABE_BOTTOM then
      FZoomedBoundsOffsets.Bottom := 1;
  end;
end;

function TdxCustomRibbonForm.CanSetWindowRegion(ARegion: HRGN): Boolean;
begin
  Result := HandleAllocated and (FResettingGlass or
    (ARegion = 0) and FHasRegion or IsWindowVisible(Handle));
end;

procedure TdxCustomRibbonForm.CheckExtendFrame(AZoomed: Boolean);
var
  ANonClientHeight: Integer;
begin
  if UseSkin and HandleAllocated and IsUseAeroNCPaint then
  begin
    ANonClientHeight := RibbonNonClientHelper.GetWindowCaptionHeight +
      RibbonNonClientHelper.GetCaptionAreaExtention;
    //prevent client area rendering beyond the screen if maximized
    if AZoomed and (ANonClientHeight > 0) then
      Inc(ANonClientHeight, dxGlassMaximizedNonClientHeight);
    ExtendFrameIntoClientAreaAtTop(ANonClientHeight);
  end;
end;

function TdxCustomRibbonForm.GetUseSkin: Boolean;
begin
  Result := FRibbonNonClientHelper <> nil;
end;

procedure TdxCustomRibbonForm.FinalizeSkin;
begin
  if HandleAllocated then
  begin
    ResetWindowRegion;
    UpdateSkins;
    UpdateSystemMenu;
  end;
  BuildSystemMenu(GetSystemMenu(Handle, False));
end;

procedure TdxCustomRibbonForm.InitializeSkin;
begin
  FIsActive := HandleAllocated and (GetActiveWindow = Handle) or
   (FormStyle = fsMDIChild) and (Application.MainForm.ActiveMDIChild = Self);
  UpdateWindowStates;
  if HandleAllocated then
  begin
    UpdateSkins;
    ResetWindowRegion;
    UpdateSystemMenu;
  end;
  RecalculateCaptionArea;
end;

procedure TdxCustomRibbonForm.InvalidateFrame(AWnd: HWND; AUpdate: Boolean = False);
begin
  SetWindowPos(AWnd, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or
    SWP_NOZORDER or SWP_NOACTIVATE or SWP_DRAWFRAME);
  if AUpdate then
    UpdateWindow(AWnd);
end;

function TdxCustomRibbonForm.IsNeedCorrectForAutoHideTaskBar: Boolean;
var
  ABData : TAppBarData;
begin
  FillChar(ABData, sizeof(ABData), 0);
  ABData.cbSize := sizeof(ABData);
  Result := ((SHAppBarMessage(ABM_GETSTATE, ABData) and ABS_AUTOHIDE) > 0) and
    (MonitorFromWindow(FindWindow('Shell_TrayWnd', nil), MONITOR_DEFAULTTONEAREST) = Monitor.Handle);
end;

function TdxCustomRibbonForm.IsNeedUpdateCornerRegions: Boolean;
begin
  Result := UseSkin and HandleAllocated and not IsUseAeroNCPaint and IsNormalWindowState;
end;

function TdxCustomRibbonForm.IsNormalWindowState: Boolean;
begin
  Result := not (IsIconic(Handle) or IsZoomed(Handle));
end;

function TdxCustomRibbonForm.IsRibbonHelpButtonPlacedOnCaption: Boolean;
begin
  Result := (RibbonNonClientHelper <> nil) and RibbonNonClientHelper.IsRibbonHelpButtonPlacedOnCaption;
end;

procedure TdxCustomRibbonForm.BuildSystemMenu(AMenu: THandle);
begin
  LoadSystemMenu;
  DeleteMenu(AMenu, 0, MF_BYPOSITION);
  cxMoveMenuItems(GetSubMenu(FLoadedSystemMenu, 0), AMenu);
  ModifySystemMenu(AMenu);
end;

procedure TdxCustomRibbonForm.DestroySystemMenu;
begin
  if FLoadedSystemMenu <> 0 then
  begin
    DestroyMenu(FLoadedSystemMenu);
    FLoadedSystemMenu := 0;
  end;
end;

procedure TdxCustomRibbonForm.LoadSystemMenu;
const
  SysMenuTypes: array[Boolean] of TcxSystemMenuType = (smSystem, smChild);
begin
  DestroySystemMenu;
  FLoadedSystemMenu := cxLoadSysMenu(SysMenuTypes[FormStyle = fsMDIChild]);
end;

procedure TdxCustomRibbonForm.ResetStandardSystemMenu;
begin
  if UseSkin and HandleAllocated then
    GetSystemMenu(Handle, True);
end;

procedure TdxCustomRibbonForm.ResetWindowRegion;
begin
  if HandleAllocated then
    SetRegion(0);
end;

procedure TdxCustomRibbonForm.SetRedraw(ARedraw: Boolean);
begin
  if not (HandleAllocated and Visible) then Exit;
  if not ARedraw then
  begin
    Inc(FRedrawCount);
    if FRedrawCount = 1 then
      SendMessage(Handle, WM_SETREDRAW, 0, 0);
  end
  else
  begin
    Dec(FRedrawCount);
    if FRedrawCount = 0 then
    begin
      SendMessage(Handle, WM_SETREDRAW, 1, 0);
      FullRedrawWithChildren;
    end;
  end;
end;

procedure TdxCustomRibbonForm.UpdateBorderIcons;
begin
  if RibbonNonClientHelper <> nil then
    RibbonNonClientHelper.UpdateWindowBorderIcons(GetFormBorderIcons);
end;

procedure TdxCustomRibbonForm.UpdateBorders;
begin
  UpdateGlassFrame;
  UpdateSystemMenu;
  ForceUpdateWindowSize;
end;

procedure TdxCustomRibbonForm.SetAutoScroll(const Value: Boolean);
begin
  //don't change
  inherited AutoScroll := False;
end;

procedure TdxCustomRibbonForm.SetBorderIcons(const Value: TBorderIcons);
begin
  if Value <> BorderIcons then
  begin
    inherited BorderIcons := Value;
    UpdateBorders;
  end;
end;

procedure TdxCustomRibbonForm.SetBorderStyle(const Value: TFormBorderStyle);
begin
  if Value <> BorderStyle then
  begin
    inherited BorderStyle := Value;
    UpdateBorders;
  end;
end;

procedure TdxCustomRibbonForm.SetDisableAero(const Value: Boolean);
var
  AHelper: TdxRibbonFormCaptionHelper;
begin
  if FDisableAero <> Value then
  begin
    if IsCompositionEnabled then
    begin
      AHelper := RibbonNonClientHelper;
      try
        RibbonNonClientHelper := nil;
        FDisableAero := Value;
      finally
        RibbonNonClientHelper := AHelper;
        UpdateColorScheme;
        FullUpdate;
      end;
    end
    else
      FDisableAero := Value;
  end;
end;

procedure TdxCustomRibbonForm.SetDisableMDIClientScrollBars(const Value: Boolean);
begin
  if DisableMDIClientScrollBars <> Value then
  begin
    FDisableMDIClientScrollBars := Value;
    if FormStyle = fsMDIForm then
      SetWindowPos(ClientHandle, 0, 0, 0, 0, 0, dxAdjustFormSizeFlags or SWP_NOSIZE);
  end;
end;

procedure TdxCustomRibbonForm.SetPrevActiveControl(AValue: TWinControl);
begin
  if (AValue <> FPrevActiveControl) then
  begin
    if Assigned(FPrevActiveControl) then
      FPrevActiveControl.RemoveFreeNotification(Self);
    FPrevActiveControl := AValue;
    if Assigned(FPrevActiveControl) then
      FPrevActiveControl.FreeNotification(Self);
  end;
end;

procedure TdxCustomRibbonForm.SetRegion(ARegion: HRGN; ARedraw: Boolean = False);
begin
  if CanSetWindowRegion(ARegion) then
  begin
    FHasRegion := ARegion <> 0;
    SetWindowRgn(Handle, ARegion, ARedraw and IsWindowVisible(Handle));
  end
  else
    if ARegion <> 0 then
      DeleteObject(ARegion);
end;

procedure TdxCustomRibbonForm.SetRibbonAutoHideMode(const AValue: TdxRibbonAutoHideMode);
begin
  FRibbonAutoHideMode.Assign(AValue);
end;

procedure TdxCustomRibbonForm.SetRibbonControl(AValue: TWinControl);
begin
  if AValue <> FRibbonControl then
  begin
    if FRibbonControl <> nil then
    begin
      FRibbonControl.RemoveFreeNotification(Self);
      FRibbonControl := nil;
    end;
    if AValue <> nil then
    begin
      FRibbonControl := AValue;
      FRibbonControl.FreeNotification(Self);
    end;
    if not Supports(RibbonControl, IdxRibbonFormClient, FRibbonFormClient) then
      FRibbonFormClient := nil;
  end;
end;

{$IFDEF DELPHI10}
procedure TdxCustomRibbonForm.SetRibbonAlwaysOnTop(const Value: Boolean);
begin
  if FRibbonAlwaysOnTop <> Value then
  begin
    FRibbonAlwaysOnTop := Value;
    Realign;
  end;
end;
{$ENDIF}

procedure TdxCustomRibbonForm.SetRibbonNonClientHelper(AValue: TdxRibbonFormCaptionHelper);
begin
  if IsDestroying then
    AValue := nil;
  if FRibbonNonClientHelper <> AValue then
  begin
    FRibbonNonClientHelper := AValue;
    FExtendFrameAtTopHeight := -1;
    if not IsDestroying then
    begin
      RibbonAutoHideMode.Active := False;
      if UseSkin then
        InitializeSkin
      else
        FinalizeSkin;
    end;
  end;
end;

procedure TdxCustomRibbonForm.SetUseSkinColor(const Value: Boolean);
begin
  if FUseSkinColor <> Value then
  begin
    FUseSkinColor := Value;
    if HandleAllocated then
      InvalidateRect(Handle, nil, True);
  end;
end;

procedure TdxCustomRibbonForm.ShowSystemMenu(AFromMouse: Boolean);
var
  P: TPoint;
  R: TRect;
  ACommand: LongWord;
  AMenu: THandle;
begin
  if AFromMouse then
    P := GetMouseCursorPos
  else
  begin
    R := RibbonNonClientHelper.GetWindowSystemMenuBounds;
    P.X := R.Left;
    P.Y := R.Bottom;
    P := ClientToScreen(P);
  end;
  AMenu := GetSystemMenu(Handle, False);
  ACommand := LongWord(TrackPopupMenu(AMenu, TPM_RETURNCMD or TPM_TOPALIGN or TPM_LEFTALIGN, P.X, P.Y, 0, Handle, nil));
  PostMessage(Handle, WM_SYSCOMMAND, ACommand, 0);
end;

procedure TdxCustomRibbonForm.RecalculateCaptionArea;
begin
  UpdateWindowStates;
  UpdateBorderIcons;
  if RibbonFormClient <> nil then
    RibbonFormClient.RibbonFormCaptionChanged;
end;

procedure TdxCustomRibbonForm.RecalculateFormSizes;
begin
  if HandleAllocated then
    SetWindowPos(Handle, 0, 0, 0, Width, Height, dxAdjustFormSizeFlags);
end;

procedure TdxCustomRibbonForm.ResetGlassFrame;
begin
  UpdateWindowStates;
  if HandleAllocated then
  begin
    FResettingGlass := True;
    DisableAlign;
    try
      ResetWindowRegion;
      UpdateGlassFrame;
      UpdateSystemMenu;
    finally
      FResettingGlass := False;
      EnableAlign;
    end;
  end;
end;

procedure TdxCustomRibbonForm.UpdateGlassFrame;
begin
  UpdateWindowStates;
  if IsCompositionEnabled and not IsDestroying then
  begin
    if not UseSkin or DisableAero then
      ExtendFrameIntoClientAreaAtTop(0)
    else
      CheckExtendFrame(WindowState = wsMaximized);

    if UseSkin then
    begin
      RecalculateCaptionArea;
      UpdateNonClientArea;
    end;
  end;
end;

procedure TdxCustomRibbonForm.UpdateColorScheme;
begin
  if HandleAllocated then
  begin
    UpdateWindowStates;
    UpdateWindowRegion(IsZoomed(Handle));
  end;
  if RibbonAutoHideMode.Active then
  begin
    if not (rbiAutoHide in GetFormBorderIcons) then
      RibbonAutoHideMode.Active := False;
  end;
  FShadow.UpdateVisibility;
  RecalculateCaptionArea;
end;

procedure TdxCustomRibbonForm.UpdateSkins;
begin
  SendMessage(Handle, DXM_SKINS_SETISSKINNED, WPARAM(UseSkin), 0);
end;

procedure TdxCustomRibbonForm.UpdateSystemMenu;
begin
  if UseSkin then
  begin
    UpdateBorderIcons;
    ResetStandardSystemMenu;
  end;
end;

procedure TdxCustomRibbonForm.CMActionUpdate(var Message: TMessage);

  function UpdateControlAction(AControl: TControl): Boolean;
  begin
    Result := (AControl <> nil) and
      AControl.UpdateAction(TBasicAction(Message.LParam));
  end;

  function ProcessChildren(AContainer: TWinControl): Boolean;
  var
    I: Integer;
    AControl: TControl;
  begin
    if AContainer.Showing then
      for I := 0 to AContainer.ControlCount - 1 do
      begin
        AControl := AContainer.Controls[I];
        if AControl.Visible and UpdateControlAction(AControl) or
          (AControl is TWinControl) and ProcessChildren(TWinControl(AControl)) then
        begin
          Result := True;
          Exit;
        end;
      end;
    Result := False;
  end;

begin
  if (csDesigning in ComponentState) or not Showing then Exit;
  if PrevActiveControl is TWinControl then
  begin
    UpdateControlAction(PrevActiveControl);
    Message.Result := 1;
  end
  else
    if UpdateControlAction(ActiveControl) or UpdateControlAction(Self) or ProcessChildren(Self) then
      Message.Result := 1;
end;

procedure TdxCustomRibbonForm.CMActivate(var Message: TCMActivate);
begin
  FNeedCallActivate := True;
  if not FDelayedActivate then
    inherited;
end;

procedure TdxCustomRibbonForm.CMColorChanged(var Message: TMessage);
begin
  if UseSkin then
  begin
    if (FormStyle = fsMDIForm) and (ClientHandle <> 0) then
      Windows.InvalidateRect(ClientHandle, nil, True);
  end;
  inherited;
end;

procedure TdxCustomRibbonForm.CMShowingChanged(var Message: TMessage);

  function GetNonClientParts: TcxObjectList;
  var
    AControl: TControl;
    I: Integer;
  begin
    Result := TcxObjectList.Create(False);
    for I := 0 to ControlCount - 1 do
    begin
      AControl := Controls[I];
      if Supports(AControl, IdxRibbonFormNonClientPart) then
      begin
        if AControl.Visible then
          Result.Add(AControl);
      end;
    end;
  end;

  procedure HideRibbonControls(AList: TList);
  var
    AControl: TWinControl;
    I: Integer;
  begin
    for I := 0 to AList.Count - 1 do
    begin
      AControl := TWinControl(AList[I]);
      if AControl.HandleAllocated then
        ShowWindow(AControl.Handle, SW_HIDE);
    end;
  end;

  procedure ShowRibbonControls(AList: TList);
  var
    AControl: TWinControl;
    I: Integer;
  begin
    for I := 0 to AList.Count - 1 do
    begin
      AControl := TWinControl(AList[I]);
      if AControl.HandleAllocated and AControl.Visible then
      begin
        ShowWindow(AControl.Handle, SW_SHOWNA);
        UpdateWindow(AControl.Handle);
      end;
    end;
  end;

var
  ANonClientParts: TList;
  ANeedHideRibbonControls: Boolean;
begin
  ANeedHideRibbonControls := Visible and FVisibleChanging and (WindowState <> wsNormal);
  FDelayedActivate := ANeedHideRibbonControls;
  FNeedCallActivate := False;
  ANonClientParts := GetNonClientParts;
  try
    if ANeedHideRibbonControls then
      HideRibbonControls(ANonClientParts);
    inherited;
  finally
    UpdateGlassFrame;
    UpdateSystemMenu;
    if ANeedHideRibbonControls then
      ShowRibbonControls(ANonClientParts);
    FreeAndNil(ANonClientParts);
    if FDelayedActivate then
    begin
      FDelayedActivate := False;
      if FNeedCallActivate then
        Perform(CM_ACTIVATE, 0, 0);
    end;
    if Visible and HandleAllocated then
      UpdateWindowRegion(IsZoomed(Handle));
  end;
end;

procedure TdxCustomRibbonForm.CMVisibleChanged(var Message: TMessage);
var
  Animation: Boolean;
begin
  FVisibleChanging := True;
  try
    if UseSkin and Visible and HandleAllocated and (FormStyle = fsMDIChild) then
    begin
      Animation := GetAnimation;
      if Animation then SetAnimation(False);
      inherited;
      if Animation then SetAnimation(True);
    end
    else
      inherited;
  finally
    FVisibleChanging := False;
  end;
end;

procedure TdxCustomRibbonForm.WMDisplayChange(var Message: TMessage);
var
  AWindowPlacement: TWindowPlacement;
  AWindowRect, ANormalRect: TRect;
begin
  if Useskin and Visible and (WindowState = wsMaximized) then
  begin
    AWindowPlacement.Length := SizeOf(AWindowPlacement);
    GetWindowPlacement(Handle, @AWindowPlacement);
    GetWindowRect(Handle, AWindowRect);
    ANormalRect := AWindowPlacement.rcNormalPosition;
    AWindowPlacement.rcNormalPosition := AWindowRect;
    SetWindowPlacement(Handle, @AWindowPlacement);
    WindowState := wsNormal;
    inherited;
    WindowState := wsMaximized;
    AWindowPlacement.rcNormalPosition := ANormalRect;
    SetWindowPlacement(Handle, @AWindowPlacement);
  end
  else
    inherited;
end;

procedure TdxCustomRibbonForm.WMEraseBkgnd(var Message: TWMEraseBkgnd);
var
  R: TRect;
begin
  if UseSkin and (IsUseAeroNCPaint or not DoubleBuffered or cxIsDrawToMemory(Message)) then
  begin
    R := ClientRect;
    //reduce flickering
    if IsUseAeroNCPaint then
      Inc(R.Top, FExtendFrameAtTopHeight);
    if not cxRectIsEmpty(R) then
      RibbonNonClientHelper.DrawRibbonFormBackground(Message.DC, R)
  end
  else
    inherited;
end;

procedure TdxCustomRibbonForm.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if HandleWithHelper(True, mbLeft) then
    UpdateNonClientArea
  else
    inherited;
end;

procedure TdxCustomRibbonForm.WMLButtonUp(var Message: TWMLButtonUp);
begin
  if UseSkin then
  begin
    if HandleWithHelper(False, mbLeft) then
      Message.Result := 0
    else
    begin
      RibbonNonClientHelper.CancelMode;
      inherited;
    end;
  end
  else inherited
end;

procedure TdxCustomRibbonForm.WMRButtonDown(var Message: TWMRButtonDown);
begin
  if HandleWithHelper(True, mbRight) then
    Message.Result := 0
  else
    inherited;
end;

procedure TdxCustomRibbonForm.WMRButtonUp(var Message: TWMRButtonUp);
begin
  if HandleWithHelper(False, mbRight) then
    Message.Result := 0
  else
    inherited;
end;

procedure TdxCustomRibbonForm.WMNCRButtonUp(var Message: TWMNCRButtonUp);
begin
  if HandleWithHelper(False, mbRight) then
    Message.Result := 0
  else
    inherited;
end;

procedure TdxCustomRibbonForm.WMNCActivate(var Message: TWMNCActivate);
var
  AStyles: Cardinal;
begin
  FIsActive := Message.Active;
  if UseSkin then
  begin
    UpdateWindowStates;
    if (FormStyle = fsMDIChild) or IsUseAeroNCPaint then // AB15017 only on XP
    begin                                                // Aero required to call a default method
      AStyles := dxSetWindowStyle(Handle, WS_VISIBLE, soSubtract);
      Message.Result := DefWindowProc(Handle, WM_NCACTIVATE, TMessage(Message).WParam, 0);
      dxSetWindowStyle(Handle, AStyles, soSet);
    end
    else
      Message.Result := 1; //B20794

    if not IsDestroying then
    begin
      if not FIsActive then
      begin
        RibbonNonClientHelper.CancelMode;
        RibbonAutoHideMode.HideUI;
      end;
      UpdateNonClientArea;
    end;

    if (FormStyle = fsMDIForm) and (ActiveMDIChild <> nil) then
      ActiveMDIChild.Perform(WM_NCACTIVATE, Ord(IsActive), 0);
  end
  else
    inherited;
end;

procedure TdxCustomRibbonForm.WMNCCalcSize(var Message: TWMNCCalcSize);
var
  ACanCalcSize: Boolean;
  AIsZoomed: Boolean;
  ARect: TRect;
  T: Integer;
begin
  AIsZoomed := IsZoomed(Handle);
  ACanCalcSize := UseSkin and not IsIconic(Handle) and not (csReading in ComponentState);
  if IsWinXP and AIsZoomed and IsThemeActive then 
    ACanCalcSize := ACanCalcSize and Visible;     

  if not ACanCalcSize then
  begin
    inherited;
    Exit;
  end;

  if Message.CalcValidRects then
  begin
    if IsUseAeroNCPaint then
    begin
      T := Message.CalcSize_Params^.rgrc[0].Top;
      inherited;
      ARect := Message.CalcSize_Params^.rgrc[0];
      ARect.Top := T;
    end
    else
      ARect := cxRectContent(Message.CalcSize_Params^.rgrc[0], GetCurrentBordersWidth);

    if AIsZoomed then
    begin
      if FormStyle = fsMDIChild then
        Inc(ARect.Top, GetDefaultWindowNCSize(Handle).Top - RibbonNonClientHelper.GetWindowCaptionHeight)
      else
      begin
        CalculateZoomedOffsets; //check for Taskbar autohide
        CorrectZoomedBounds(ARect);
      end;
    end;

    if not cxRectCompare(ARect, Message.CalcSize_Params^.rgrc[0]) then
    begin
      Message.CalcSize_Params^.rgrc[0] := ARect;
      PostMessage(Handle, DXM_RIBBONFORM_NCCHANGED, 0, 0);
    end;
  end
  else
    inherited;

  Message.Result := 0;
end;

procedure TdxCustomRibbonForm.WMNCHitTest(var Message: TWMNCHitTest);

  function AllowResize: Boolean;
  begin
    Result := BorderStyle in [bsSizeable, bsSizeToolWin];
  end;

  function IsButtonHitTest(AHitTest: Integer): Boolean;
  begin
    Result := AHitTest in [HTCLOSE, HTMINBUTTON, HTMAXBUTTON, HTHELP];
  end;

  function IsSizeFrame(AHitTest: Integer): Boolean;
  begin
    Result := (AHitTest >= HTSIZEFIRST) and (AHitTest <= HTSIZELAST);
  end;

  function CheckHitTest(AHitTest: Integer): Boolean;
  begin
    Result := (AllowResize or not IsSizeFrame(Message.Result)) and
      (Message.Result <> HTCAPTION) and (Message.Result <> HTCLIENT);
  end;

  procedure CalculateHitTest(var Message: TWMNCHitTest);
  var
    P: TPoint;
  begin
    P := SmallPointToPoint(Message.Pos);
    P := cxPointOffset(P, cxGetWindowRect(Handle).TopLeft, False);
    if AllowResize then
      CheckResizingNCHitTest(Message.Result, P);
    if Message.Result = HTNOWHERE then
      RibbonNonClientHelper.CalculateWindowCaptionHitTest(Message);
    if Message.Result = HTNOWHERE then
      Message.Result := HTCLIENT;
  end;

begin
  if UseSkin then
  begin
    Message.Result := HTNOWHERE;
    if IsUseAeroNCPaint then
    begin
      CallDWMWindowProc(Message);
      if Message.Result = HTNOWHERE then
      begin
        inherited;
        if IsButtonHitTest(Message.Result) then
          Message.Result := HTCAPTION;
      end;
      if not CheckHitTest(Message.Result) then
        Message.Result := HTNOWHERE;
    end;
    if Message.Result = HTNOWHERE then
      CalculateHitTest(Message);
  end
  else
    inherited;
end;

procedure TdxCustomRibbonForm.WMShowWindow(var Message: TMessage);
var
  AForm: TForm;
  AMDIParentForm: TdxCustomRibbonForm;
begin
  inherited;
  if WordBool(Message.WParam) and UseSkin then
  begin
    UpdateBorderIcons;
    if IsNormalWindowState then
    begin
      //for showing MDIChild on vista without DWM
      //make sure for WM_SIZE & WM_NCCALCSIZE
      RecalculateFormSizes;
      RecalculateCaptionArea;
      if not IsUseAeroNCPaint then //upper corner glitch with Windows Classic
      begin
        AMDIParentForm := GetMDIParent;
        if AMDIParentForm <> nil then
        begin
          AForm := AMDIParentForm.ActiveMDIChild;
          //skip posting for maximized MDI children
          if not ((AForm <> nil) and (AForm.WindowState = wsMaximized)) then
            PostMessage(Handle, WM_SIZE, 0, 0);
        end
        else
          PostMessage(Handle, WM_SIZE, 0, 0);
      end;
    end;
  end;
end;

procedure TdxCustomRibbonForm.WMNCPaint(var Message: TMessage);
begin
  if UseSkin then
  begin
    if IsUseAeroNCPaint then
      inherited;
    DrawNonClientArea(False, Message.WParam);
    Message.Result := 0;
  end
  else
    inherited;
end;

procedure TdxCustomRibbonForm.WMPaint(var Message: TWMPaint);
begin
  if UseSkin then
  begin
    UpdateWindowStates;
    if IsUseAeroNCPaint then
      ExcludeRibbonPaintArea(Message.DC);
  end;
  inherited;
end;

procedure TdxCustomRibbonForm.WMSize(var Message: TWMSize);
var
  APrevRibbonHeight: Integer;
  APrevRibbonVisible: Boolean;
begin
  if not (csReading in ComponentState) then
  begin
    UpdateWindowStates;
    BeforeResize(APrevRibbonVisible, APrevRibbonHeight);
    try
      if RibbonNonClientHelper <> nil then
        RibbonNonClientHelper.Calculate;
      inherited;
      if Message.SizeType = SIZE_RESTORED then
        RibbonAutoHideMode.Active := False;
      UpdateWindowRegion(Message.SizeType = SIZE_MAXIMIZED);
    finally
      AfterResize(APrevRibbonVisible, APrevRibbonHeight, Message.SizeType = SIZE_MAXIMIZED);
    end;
  end
  else
    inherited;
end;

procedure TdxCustomRibbonForm.WMStyleChanging(var Message: TWMStyleChanging);
begin
  if Message.StyleType = WPARAM(GWL_STYLE) then
    CorrectWindowStyle(Message.StyleStruct^.styleNew);
  inherited;
end;

procedure TdxCustomRibbonForm.WMSysCommand(var Message: TWMSysCommand);
var
  ACommand: Word;
  Animation, AIsChild: Boolean;
begin
  if UseSkin then
  begin
    ACommand := Message.CmdType and $FFF0;
    AIsChild := GetWindowLong(Handle, GWL_STYLE) and WS_CHILD = WS_CHILD;
    if (ACommand = SC_KEYMENU) and (Message.Key = $20) then
    begin
      LockWindowUpdate(Handle);
      inherited;
      LockWindowUpdate(0);
    end
    else
    begin
      if AIsChild and ((ACommand = SC_MAXIMIZE) or
        (ACommand = SC_MINIMIZE) or (ACommand = SC_RESTORE) or (ACommand = SC_CLOSE)) then
      begin
        Animation := GetAnimation;
        if Animation then SetAnimation(False);
        inherited;
        if Animation then SetAnimation(True);
      end
      else
      begin
        if ACommand = SC_CONTEXTHELP then
        begin
          LockWindowUpdate(Handle);
          inherited;
          LockWindowUpdate(0);
        end
        else
          inherited;
      end;
      case ACommand of
        SC_MINIMIZE, SC_CLOSE:
          begin
            if AIsChild then //B147844
            begin
              RecalculateCaptionArea;
              UpdateNonClientArea;
            end
            else
              UpdateWindowStates;
          end;
        SC_MAXIMIZE, SC_RESTORE:
          begin
            RecalculateCaptionArea; //need to recalculate, if the caption was changed in IsIconic
            UpdateNonClientArea;
          end
        else
          UpdateWindowStates;
      end;
    end;
  end
  else
    inherited;
end;

procedure TdxCustomRibbonForm.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  UpdateWindowStates;
  inherited;
  if UseSkin then
  begin
    FSizingBorders.cx := GetSystemMetrics(SM_CXSIZEFRAME);
    FSizingBorders.cy := GetSystemMetrics(SM_CYSIZEFRAME);
  end;
  if IsNeedUpdateCornerRegions then
    CalculateCornerRegions;
end;

procedure TdxCustomRibbonForm.WMDWMCompositionChanged(var Message: TMessage);
begin
  inherited;
  if UseSkin then
  begin
    if not DisableAero then
      RibbonAutoHideMode.Active := False;
    ResetGlassFrame;
    RecalculateCaptionArea;
    Message.Result := 0;
  end;
end;

procedure TdxCustomRibbonForm.WndProc(var Message: TMessage);
begin
  if not UseSkin then
    inherited WndProc(Message)
  else
    with Message do
    begin
      case Msg of
        // menus
        WM_INITMENU:
          begin
            if biSystemMenu in BorderIcons then
            begin
              Message.WParam := GetSystemMenu(Handle, False);
              LockWindowUpdate(Handle);
              try
                BuildSystemMenu(Message.WParam);
                inherited WndProc(Message);
              finally
                LockWindowUpdate(0);
              end;
            end
            else
              inherited WndProc(Message);
          end;
        WM_SYSMENU, DXM_BAR_SHOWSYSTEMMENU:
          begin
            if IsWindowEnabled(Handle) then //B136020
              ShowSystemMenu(True);
            Result := 0;
          end;
        WM_EXITMENULOOP, WM_QUERYOPEN:
          begin
            ResetStandardSystemMenu;
            inherited WndProc(Message);
          end;
        // other
        WM_DWMNCRENDERINGCHANGED:
          begin
            FExtendFrameAtTopHeight := -1; // Windows 7 can reset a non-client settings
            UpdateGlassFrame;
            Result := 0;
          end;
        WM_ENTERSIZEMOVE:
          begin
            FSizingLoop := True;
            inherited WndProc(Message);
          end;
        WM_EXITSIZEMOVE:
          begin
            FSizingLoop := False;
            inherited WndProc(Message);
            UpdateNonClientArea;
          end;
        WM_CANCELMODE:
          begin
            RibbonNonClientHelper.CancelMode;
            inherited WndProc(Message);
          end;
        WM_CAPTURECHANGED:
          begin
            if THandle(Message.LParam) <> Handle then
            begin
              FSizingLoop := False;
              RibbonNonClientHelper.CancelMode;
            end;
            inherited WndProc(Message);
          end;
        WM_NCUAHDRAWCAPTION,
        WM_NCUAHDRAWFRAME:
          begin
            if IsUseAeroNCPaint then
              CallDWMWindowProc(Message);
            DrawNonClientArea(True);
            Message.Result := 0;
          end;
        WM_MOUSEACTIVATE, WM_SYNCPAINT:
          begin
            inherited WndProc(Message);
            DrawNonClientArea(True);
          end;
        WM_NCLBUTTONDOWN:
          begin
            if not IsUseAeroNCPaint then
              UpdateWindow(Handle);
            inherited WndProc(Message);
            if IsIconic(Handle) then
            begin
              DrawNonClientArea(True);
              Result := 0;
            end;
          end;
        WM_NCMOUSELEAVE:
          begin
            if IsUseAeroNCPaint then
              CallDWMWindowProc(Message)
            else
              inherited;
          end;
        WM_LBUTTONDOWN:
          begin
            //dmAutomatic suppress a dispatching
            if (DragMode = dmAutomatic) and not IsUseAeroNCPaint then
              if HandleWithHelper(True, mbLeft) then
                Exit;
            inherited;
          end;
        DXM_SKINS_GETISSKINNED:
          Result := Ord(UseSkin);
      else
        inherited;
      end;
    end;
end;

function TdxCustomRibbonForm.IsUseAeroNCPaint: Boolean;
begin
  Result := UseAeroNCPaint(FData);
end;

procedure TdxCustomRibbonForm.CheckResizingNCHitTest(var AHitTest: LRESULT; const P: TPoint);
const
  CornerHitTests: array[0..3] of DWORD = (HTTOPLEFT, HTTOPRIGHT, HTBOTTOMRIGHT, HTBOTTOMLEFT);
var
  I: Integer;
  R, RW: TRect;
begin
  if IsNormalWindowState then
  begin
    for I := 0 to 3 do
      if cxPtInRegion(FCornerRegions[I], P) then
      begin
        AHitTest := CornerHitTests[I];
        Break;
      end;

    if AHitTest = HTNOWHERE then
    begin
      RW := cxGetWindowRect(Handle);
      OffsetRect(RW, -RW.Left, -RW.Top);
      R := RW;
      if IsUseAeroNCPaint then
        R.Bottom := R.Top + (FSizingBorders.cy div 2)
      else
        R.Bottom := R.Top + FSizingBorders.cy;
      if cxRectPtIn(R, P) then
        AHitTest := HTTOP
      else
        if not IsUseAeroNCPaint then
        begin
          R := RW;
          R.Left := R.Right - FSizingBorders.cx;
          if cxRectPtIn(R, P) then
            AHitTest := HTRIGHT
          else
          begin
            R := RW;
            R.Top := R.Bottom - FSizingBorders.cy;
            if cxRectPtIn(R, P) then
              AHitTest := HTBOTTOM
            else
            begin
              R := RW;
              R.Right := R.Left + FSizingBorders.cx;
              if cxRectPtIn(R, P) then
                AHitTest := HTLEFT;
            end;
          end;
        end;
    end;
  end;
end;

procedure TdxCustomRibbonForm.CreateCornerRegions;
var
  I: Integer;
begin
  for I := 0 to 3 do
    FCornerRegions[I] := CreateRectRgnIndirect(cxEmptyRect);
end;

procedure TdxCustomRibbonForm.DestroyCornerRegions;
var
  I: Integer;
begin
  for I := 0 to 3 do
    DeleteObject(FCornerRegions[I]);
end;

procedure TdxCustomRibbonForm.ExcludeRibbonPaintArea(DC: HDC);
var
  R: TRect;
begin
  if (DC <> 0) and (FExtendFrameAtTopHeight > 0) then
  begin
    R := cxRect(0, 0, ClientWidth, FExtendFrameAtTopHeight);
    FillRect(DC, R, GetStockObject(BLACK_BRUSH));
    ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
end;

procedure TdxCustomRibbonForm.ForceUpdateWindowSize;
begin
  if UseSkin and HandleAllocated then
  begin
    if not UseAeroNCPaint(FData) and IsNormalWindowState then
      SetRegion(RibbonNonClientHelper.GetWindowRegion, True);
    RecalculateCaptionArea;
  end;
end;

procedure TdxCustomRibbonForm.FullRedrawWithChildren;
begin
  WinControlFullInvalidate(Self, True, True);
end;

procedure TdxCustomRibbonForm.ExtendFrameIntoClientAreaAtTop(AHeight: Integer);
var
  M: TdxMargins;
  DC: HDC;
  R: TRect;
begin
  if HandleAllocated and (FExtendFrameAtTopHeight <> AHeight) then
  begin
    if AHeight > FExtendFrameAtTopHeight then
    begin
      R := cxRect(0, FExtendFrameAtTopHeight, Width, AHeight);
      if not FVisibleChanging then
        Inc(R.Left, 100);
      if not cxRectIsEmpty(R) then
      begin
        DC := GetWindowDC(Handle);
        FillRect(DC, R, GetStockObject(BLACK_BRUSH));
        ReleaseDC(Handle, DC);
      end;
    end;
    FExtendFrameAtTopHeight := AHeight;
    M.cxLeftWidth := 0;
    M.cxRightWidth := 0;
    M.cyBottomHeight := 0;
    M.cyTopHeight := AHeight;
    DwmExtendFrameIntoClientArea(Handle, @M);
    if IsWindowVisible(Handle) then
      RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_UPDATENOW);
  end;
end;

function TdxCustomRibbonForm.GetFormBorderIcons: TdxRibbonBorderIcons;

  function ConverterBorderIconsToRibbonBorderIcons(const AIcons: TBorderIcons): TdxRibbonBorderIcons;
  const
    Map: array[TBorderIcon] of TdxRibbonBorderIcon = (rbiSystemMenu, rbiMinimize, rbiMaximize, rbiHelp);
  var
    I: TBorderIcon;
  begin
    Result := [];
    for I := Low(TBorderIcon) to High(TBorderIcon) do
    begin
      if I in AIcons then
        Include(Result, Map[I]);
    end;
  end;

  function GetBorderStyle: TFormBorderStyle;
  begin
    Result := BorderStyle;
    if (FormStyle = fsMDIChild) and (Result in [bsNone, bsDialog]) then
      Result := bsSizeable;
  end;

begin
  Result := ConverterBorderIconsToRibbonBorderIcons(BorderIcons);
  if not (rbiSystemMenu in Result) then
  begin
    Result := [];
    Exit;
  end;

  if IsRibbonHelpButtonPlacedOnCaption then
    Include(Result, rbiHelp);

  if (RibbonStyle = rs2013) and RibbonAutoHideMode.IsAvailable and
    (ApplicationMenuState <> ramsShownAsFullScreenFrame) then
  begin
    Include(Result, rbiAutoHide);
    if RibbonAutoHideMode.Active and not RibbonAutoHideMode.IsUIShown then
      Result := Result * [rbiAutoHide, rbiSystemMenu] + [rbiAutoHideModeShowUI];
  end;  

  case GetBorderStyle of
    bsNone:
      Result := [];
    bsDialog:
      Result := Result * [rbiSystemMenu, rbiHelp] - [rbiMaximize];
    bsToolWindow, bsSizeToolWin:
      Result := Result * [rbiSystemMenu];
  end;
end;

function TdxCustomRibbonForm.GetIsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TdxCustomRibbonForm.GetMDIParent: TdxCustomRibbonForm;

  function Check(AForm: TForm): Boolean;
  begin
    Result := (AForm <> nil) and (AForm.FormStyle = fsMDIForm) and (AForm is TdxCustomRibbonForm);
  end;

var
  AForm: TForm;
  I: Integer;
begin
  Result := nil;
  if FormStyle = fsMDIChild then
  begin
    AForm := Application.MainForm;
    if Check(AForm) then
      Result := TdxCustomRibbonForm(AForm)
    else
    begin
      for I := 0 to Screen.FormCount - 1 do
      begin
        AForm := Screen.Forms[I];
        if Check(AForm) then
        begin
          Result := TdxCustomRibbonForm(AForm);
          Break;
        end;
      end;
    end;
  end;
end;

procedure TdxCustomRibbonForm.CorrectWindowStyle(var AStyle: Cardinal);
begin
  if UseSkin and IsWinVistaOrLater then
  begin
    if BorderStyle in [bsSingle, bsToolWindow, bsDialog] then
      AStyle := AStyle or WS_SIZEBOX;
  end;
end;

procedure TdxCustomRibbonForm.CorrectZoomedBounds(var R: TRect);
begin
  Inc(R.Left, FZoomedBoundsOffsets.Left);
  Inc(R.Top, FZoomedBoundsOffsets.Top);
  Dec(R.Right, FZoomedBoundsOffsets.Right);
  Dec(R.Bottom, FZoomedBoundsOffsets.Bottom);
end;

function TdxCustomRibbonForm.GetCurrentBordersWidth: TRect;
begin
  if IsZoomed(Handle) then
  begin
    Result := GetDefaultWindowBordersWidth(Handle);
    if FormStyle = fsMDIChild then
      Result.Top := 0;
  end
  else
    Result := RibbonNonClientHelper.GetWindowBordersWidth;
end;

function TdxCustomRibbonForm.GetBorderIcons: TBorderIcons;
begin
  Result := inherited BorderIcons;
end;

function TdxCustomRibbonForm.GetBorderStyle: TFormBorderStyle;
begin
  Result := inherited BorderStyle;
end;

function TdxCustomRibbonForm.GetRibbonNonClientHelper: TdxRibbonFormCaptionHelper;
begin
  Result := FRibbonNonClientHelper; // CBuilder 2009 workaround (Buggy CB must die!)
end;

function TdxCustomRibbonForm.GetRibbonStyle: TdxRibbonStyle;
begin
  if RibbonNonClientHelper <> nil then
    Result := RibbonNonClientHelper.RibbonHelper.GetRibbonStyle
  else
    Result := rs2007;
end;

function TdxCustomRibbonForm.GetApplicationMenuState: TdxRibbonApplicationMenuState;
begin
  if RibbonNonClientHelper <> nil then
    Result := RibbonNonClientHelper.ApplicationMenuState
  else
    Result := ramsHidden;
end;

function TdxCustomRibbonForm.GetBackgroundColor: TColor;
begin
  if UseSkin and UseSkinColor then
    Result := RibbonNonClientHelper.GetWindowColor
  else
    Result := Color;
end;

procedure TdxCustomRibbonForm.WMGetText(var Message: TWMGetText);
var
  L: Integer;
begin
  if (csLoading in ComponentState) or UseSkin then
  begin
    L := Length(FCaption) + 1; //include the terminating null character
    if Message.TextMax < WPARAM(L) then
      L := Message.TextMax;
    if L > 1 then
      Move(Pointer(FCaption)^, Pointer(Message.Text)^, L * SizeOf(Char));
    Message.Result := L - 1;
  end
  else
    inherited;
end;

procedure TdxCustomRibbonForm.WMGetTextLength(var Message: TWMGetTextLength);
begin
  if (csLoading in ComponentState) or UseSkin then
    Message.Result := Length(FCaption)
  else
    inherited;
end;

procedure TdxCustomRibbonForm.WMSetText(var Message: TWMSetText);

  function IsMaximizedChildForRibbonForm(AForm: TdxCustomRibbonForm): Boolean;
  begin
    Result := (AForm <> nil) and AForm.UseSkin and IsZoomed(Handle);
  end;

  procedure UpdateMDIFormText;
  var
    AStyles: Cardinal;
  begin
    if ClientHandle <> 0 then
    begin
      AStyles := dxSetWindowStyle(Handle, WS_VISIBLE, soSubtract);
      DefFrameProc(Handle, ClientHandle, WM_SETTEXT, 0, TMessage(Message).LParam);
      dxSetWindowStyle(Handle, AStyles, soSet);
    end
    else
      if FormStyle = fsMDIChild then
      begin
        AStyles := dxSetWindowStyle(Handle, WS_VISIBLE, soSubtract);
        DefMDIChildProc(Handle, WM_SETTEXT, 0, TMessage(Message).LParam);
        dxSetWindowStyle(Handle, AStyles, soSet);
      end;
  end;

  procedure UpdateMDIForm(AForm: TdxCustomRibbonForm);
  begin
    if IsMaximizedChildForRibbonForm(AForm) then
      AForm.RecalculateCaptionArea;
  end;

var
  AMDIParentForm: TdxCustomRibbonForm;
begin
  FCaption := Message.Text;
  AMDIParentForm := GetMDIParent;
  if (csLoading in ComponentState) or UseSkin then
  begin
    if UseSkin then
    begin
      RecalculateCaptionArea;
      UpdateMDIFormText;
      UpdateMDIForm(AMDIParentForm);
      Perform(CM_TEXTCHANGED, 0, 0);
      if GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_APPWINDOW = WS_EX_APPWINDOW then
        SetWindowTextWithoutRedraw(Handle, RibbonNonClientHelper.GetTaskBarCaption);
    end
    else
    begin
      inherited;
      UpdateMDIForm(AMDIParentForm);
    end;
  end
  else
  begin
    if not IsThemeActive and IsMaximizedChildForRibbonForm(AMDIParentForm) then
    begin
      UpdateMDIFormText;
      Perform(CM_TEXTCHANGED, 0, 0);
      SetWindowTextWithoutRedraw(Handle, Message.Text);
    end
    else
      inherited;

    UpdateMDIForm(AMDIParentForm);
  end;
end;

{ TdxRibbonFormShadowWindow }

function TdxRibbonFormShadowWindow.CalculateVisibility: Boolean;
begin
  Result := inherited CalculateVisibility and not OwnerWindow.IsUseAeroNCPaint and
    OwnerWindow.UseSkin and (OwnerWindow.RibbonNonClientHelper <> nil) and
    OwnerWindow.RibbonNonClientHelper.RibbonHelper.HasExternalRibbonFormShadow;
end;

function TdxRibbonFormShadowWindow.GetOwnerWindow: TdxCustomRibbonForm;
begin
  Result := inherited OwnerWindow as TdxCustomRibbonForm;
end;

{ TdxRibbonAutoHideMode }

constructor TdxRibbonAutoHideMode.Create(ARibbonForm: TdxCustomRibbonForm);
begin
  inherited Create;
  FRibbonForm := ARibbonForm;
  FEnabled := True;
end;

procedure TdxRibbonAutoHideMode.AlignControls(const R: TRect);
var
  AStatusBar: TWinControl;
  R1: TRect;
begin
  if (FAnimation = nil) and Active then
  begin
    Ribbon.BoundsRect := cxRectSetHeight(R, Ribbon.Height);
    if GetStatusBar(AStatusBar) then
    begin
      R1 := cxRectSetBottom(R, R.Bottom, AStatusBar.Height);
      if not IsUIShown then
        R1 := cxRectOffset(R1, 0, AStatusBar.Height);
      AStatusBar.BoundsRect := R1;
    end;
  end;
end;

procedure TdxRibbonAutoHideMode.Assign(Source: TPersistent);
begin
  if Source is TdxRibbonAutoHideMode then
    Active := TdxRibbonAutoHideMode(Source).Active;
end;

procedure TdxRibbonAutoHideMode.Finalize;
var
  AStatusBar: TWinControl;
begin
  if not RibbonForm.IsDestroying then
  begin
    RibbonForm.DisableAlign;
    try
      if Ribbon <> nil then
      begin
        Ribbon.Align := alTop;
        Ribbon.Top := -1;
      end;
      if GetStatusBar(AStatusBar) then
      begin
        AStatusBar.Align := alBottom;
        AStatusBar.Top := RibbonForm.ClientHeight + 1;
      end;
    finally
      RibbonForm.EnableAlign;
    end;
  end;
end;

procedure TdxRibbonAutoHideMode.Initialize;
var
  AStatusBar: TWinControl;
begin
  FIsUIShown := False;
  Ribbon.Align := alNone;
  Ribbon.BringToFront;
  if GetStatusBar(AStatusBar) then
  begin
    AStatusBar.Align := alNone;
    AStatusBar.BringToFront;
  end;
  RibbonForm.RecalculateCaptionArea;
end;

function TdxRibbonAutoHideMode.IsAvailable: Boolean;
begin
  Result := Enabled and RibbonForm.UseSkin and not RibbonForm.IsUseAeroNCPaint and
    RibbonForm.HandleAllocated and (GetParent(RibbonForm.Handle) = 0);
end;

procedure TdxRibbonAutoHideMode.HideUI(AWithAnimation: Boolean = True);
begin
  UpdateUIVisibility(False, AWithAnimation);
end;

procedure TdxRibbonAutoHideMode.ShowUI(AWithAnimation: Boolean = True);
begin
  UpdateUIVisibility(True, AWithAnimation);
end;

procedure TdxRibbonAutoHideMode.UpdateUIVisibility(AVisible, AWithAnimation: Boolean);
begin
  if Active and not RibbonForm.IsDestroying then
  begin
    if AVisible <> IsUIShown then
    begin
      FIsUIShown := AVisible;
      if AWithAnimation then
      begin
        FAnimation := TdxRibbonAutoHideModeAnimation.Create(Self, IsUIShown);
        FAnimation.ImmediateAnimation;
        FAnimation := nil;
      end;

      if IsUIShown then
        dxRibbonAutoHideModeController.ActiveRibbonForm := RibbonForm
      else
        dxRibbonAutoHideModeController.ActiveRibbonForm := nil;

      RibbonForm.RecalculateCaptionArea;
      RibbonForm.Realign;
    end;
  end;
end;

function TdxRibbonAutoHideMode.GetOwner: TPersistent;
begin
  Result := RibbonForm;
end;

function TdxRibbonAutoHideMode.GetRibbon: TWinControl;
begin
  Result := RibbonForm.RibbonControl;
end;

function TdxRibbonAutoHideMode.GetStatusBar(out AControl: TWinControl): Boolean;
var
  AIntf: IdxRibbonFormStatusBar;
begin
  AControl := nil;
  if RibbonForm.RibbonNonClientHelper <> nil then
  begin
    if Supports(RibbonForm.RibbonNonClientHelper.RibbonHelper.GetStatusBarInterface, IdxRibbonFormStatusBar, AIntf) then
      AControl := AIntf.GetControl;
  end;
  Result := AControl <> nil;
end;

procedure TdxRibbonAutoHideMode.SetActive(AValue: Boolean);
begin
  AValue := AValue and IsAvailable;
  if FActive <> AValue then
  begin
    FActive := AValue;
    if Active then
    begin
      RibbonForm.WindowState := wsMaximized;
      Initialize;
    end
    else
      Finalize;

    RibbonForm.RecalculateCaptionArea;
    RibbonForm.Realign;
  end;
end;

procedure TdxRibbonAutoHideMode.SetEnabled(AValue: Boolean);
begin
  if FEnabled <> AValue then
  begin
    FEnabled := AValue;
    Active := False;
    RibbonForm.RecalculateCaptionArea;
  end;
end;

{ TdxRibbonAutoHideModeAnimation }

constructor TdxRibbonAutoHideModeAnimation.Create(
  AAutoHideMode: TdxRibbonAutoHideMode; AActivating: Boolean);

  function GetAnimationTime: Cardinal;
  begin
    if AActivating then
      Result := dxRibbonAutoHideModeShowUIAnimationTime
    else
      Result := dxRibbonAutoHideModeHideUIAnimationTime;
  end;

begin
  inherited Create(GetAnimationTime, ateAccelerateDecelerate, 100);
  FAutoHideMode := AAutoHideMode;
  FActivating := AActivating;
  RibbonForm.DisableAlign;
end;

destructor TdxRibbonAutoHideModeAnimation.Destroy;
begin
  if not Activating then
    RibbonForm.RecalculateCaptionArea;
  RibbonForm.EnableAlign;
  inherited Destroy;
end;

procedure TdxRibbonAutoHideModeAnimation.AfterConstruction;
var
  AStatusBar: TWinControl;
begin
  inherited AfterConstruction;
  if AutoHideMode.GetStatusBar(AStatusBar) then
    AStatusBar.BringToFront;
  RibbonForm.RibbonControl.BringToFront;
  if Activating then
  begin
    RibbonForm.RibbonControl.Top := -cxInvisibleCoordinate;
    RibbonForm.RecalculateCaptionArea;
  end;
end;

procedure TdxRibbonAutoHideModeAnimation.DoAnimate;
var
  AStatusBar: TWinControl;
  AVisibility: Integer;
  R1: TRect;
begin
  if Activating then
    AVisibility := Position
  else
    AVisibility := 100 - Position;

  R1 := cxRectSetHeight(RibbonForm.ClientRect, Ribbon.Height);
  R1 := cxRectOffset(R1, 0, -MulDiv(Ribbon.Height, 100 - AVisibility, 100));
  SetWindowPos(Ribbon.Handle, 0, R1.Left, R1.Top, 0, 0, SWP_NOSIZE or SWP_NOZORDER);

  if AutoHideMode.GetStatusBar(AStatusBar) then
  begin
    R1 := RibbonForm.ClientRect;
    R1 := cxRectSetBottom(R1, R1.Bottom, AStatusBar.Height);
    R1 := cxRectOffset(R1, 0, MulDiv(AStatusBar.Height, 100 - AVisibility, 100));
    SetWindowPos(AStatusBar.Handle, 0, R1.Left, R1.Top, 0, 0, SWP_NOSIZE or SWP_NOZORDER);
  end;

  RedrawWindow(RibbonForm.Handle, nil, 0, RDW_UPDATENOW or RDW_ALLCHILDREN);
end;

function TdxRibbonAutoHideModeAnimation.GetRibbon: TWinControl;
begin
  Result := AutoHideMode.Ribbon;
end;

function TdxRibbonAutoHideModeAnimation.GetRibbonForm: TdxCustomRibbonForm;
begin
  Result := AutoHideMode.RibbonForm;
end;

{ TdxRibbonAutoHideModeController }

destructor TdxRibbonAutoHideModeController.Destroy;
begin
  ActiveRibbonForm := nil;
  inherited Destroy;
end;

procedure TdxRibbonAutoHideModeController.HookKeyboard(AKey: Word; AData: LPARAM; var AHookResult: LRESULT);

  function IsKeyBeingPressed: Boolean;
  begin
    Result := AData and $80000000 = 0;
  end;

begin
  if (AKey = VK_ESCAPE) and IsKeyBeingPressed then
  begin
    if ActiveBarControl = nil then
      ActiveRibbonForm := nil;
  end;
end;

procedure TdxRibbonAutoHideModeController.HookMouse(
  wParam: WPARAM; lParam: PMouseHookStruct; var AHookResult: LRESULT);
begin
  if IsMouseDownMessage(wParam) then
  begin
    if not (IsChildHandle(lParam^.hwnd) or IsInCaptionArea(lParam^.pt)) then
      ActiveRibbonForm := nil;
  end;
end;

function TdxRibbonAutoHideModeController.IsChildHandle(AHandle: HWND): Boolean;

  function IsHandleAllocated(AControl: TWinControl): Boolean;
  begin
    Result := (AControl <> nil) and AControl.HandleAllocated;
  end;

  function GetCustomizingBarControl: TWinControl;
  begin
    Result := BarDesignController.CustomizingBarControl;
    if (Result = nil) and (BarDesignController.CustomizingItemLink <> nil) then
      Result := BarDesignController.CustomizingItemLink.BarControl;
    if (Result = nil) and (BarDesignController.CustomizingBarManager <> nil) then
    begin
      if BarDesignController.CustomizingBarManager.Owner = ActiveRibbonForm then
        Result := ActiveRibbonForm.RibbonControl; 
    end;
  end;

  function GetControlOwner(AControl: TWinControl; out AOwnerHandle: HWND): Boolean;
  var
    AOwnerControl: TWinControl;
    APopup: IdxPopupControl;
  begin
    Result := False;
    if IsHandleAllocated(AControl) then
    begin
      if Supports(AControl, IdxPopupControl, APopup) then
        AOwnerControl := APopup.GetOwnerControl
      else

      if AControl is TdxBarCustomizingPopup then
        AOwnerControl := GetCustomizingBarControl
      else

      if AControl is TdxRibbonCustomBarControl then
        AOwnerControl := TdxRibbonCustomBarControl(AControl).Ribbon
      else
      
      if AControl is TdxBarSubMenuControl then
        AOwnerControl := TdxBarSubMenuControl(AControl).ParentBar
      else
        AOwnerControl := nil;

      Result := IsHandleAllocated(AOwnerControl);
      if Result then
        AOwnerHandle := AOwnerControl.Handle;
    end;
  end;

  function GetOwner(var AHandle: HWND): Boolean;
  begin
    Result := GetControlOwner(FindControl(AHandle), AHandle);
    if not Result then
    begin
      AHandle := GetParent(AHandle);
      Result := AHandle <> 0;
    end;
  end;

  function HasNativeHandle(AControl: TWinControl; AHandle: HWND): Boolean;
  var
    AParentHandle: HWND;
  begin
    Result := False;
    if IsHandleAllocated(AControl) and (AHandle <> 0) then
    begin
      AParentHandle := AControl.Handle;
      repeat
        Result := (AParentHandle = AHandle) or IsChild(AParentHandle, AHandle);
      until Result or not GetOwner(AHandle);
    end;
  end;

var
  AStatusBar: TWinControl;
begin
  Result := HasNativeHandle(ActiveRibbonForm.RibbonAutoHideMode.Ribbon, AHandle);
  if not Result and ActiveRibbonForm.RibbonAutoHideMode.GetStatusBar(AStatusBar) then
    Result := HasNativeHandle(AStatusBar, AHandle);
end;

function TdxRibbonAutoHideModeController.IsInCaptionArea(const P: TPoint): Boolean;
begin
  Result := (ActiveRibbonForm.RibbonNonClientHelper <> nil) and
    ActiveRibbonForm.RibbonNonClientHelper.IsInCaptionArea(P);
end;

procedure TdxRibbonAutoHideModeController.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then
  begin
    if AComponent = ActiveRibbonForm then
      ActiveRibbonForm := nil;
  end;
end;

procedure TdxRibbonAutoHideModeController.UpdateHooksState;
begin
  dxReleaseHook(dxRibbonAutoHideControllerKeyboardHook);
  dxReleaseHook(dxRibbonAutoHideControllerMouseHook);
  if ActiveRibbonForm <> nil then
  begin
    dxSetHook(htKeyboard, dxRibbonAutoHideControllerKeyboardHook);
    dxSetHook(htMouse, dxRibbonAutoHideControllerMouseHook);
  end;
end;

procedure TdxRibbonAutoHideModeController.SetActiveRibbonForm(const AValue: TdxCustomRibbonForm);
begin
  if FActiveRibbonForm <> AValue then
  begin
    if FActiveRibbonForm <> nil then
    begin
      FActiveRibbonForm.RemoveFreeNotification(Self);
      FActiveRibbonForm.RibbonAutoHideMode.HideUI;
      FActiveRibbonForm := nil;
    end;
    if AValue <> nil then
    begin
      FActiveRibbonForm := AValue;
      FActiveRibbonForm.FreeNotification(Self);
    end;
    UpdateHooksState;
  end;
end;

initialization

finalization
  FUnitIsFinalized := True;
  FreeAndNil(FAutoHideModeController);
end.
