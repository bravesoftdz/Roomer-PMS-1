{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           Express Cross Platform Library controls                  }
{                                                                    }
{           Copyright (c) 2000-2014 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSCROSSPLATFORMLIBRARY AND ALL   }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
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

unit cxControls;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI16}
  System.UITypes,
{$ENDIF}
  Windows, Messages, Types, Forms, Controls, Graphics, Dialogs, Classes, Themes,
  StdCtrls, Menus, dxCore, dxCoreClasses, dxMessages, cxGraphics, cxScrollBar,
  dxTouch, cxClasses, cxLookAndFeels, cxLookAndFeelPainters;

const
  FAPPCOMMAND_MASK = $0000F000;
 {$EXTERNALSYM FAPPCOMMAND_MASK}
  APPCOMMAND_BROWSER_BACKWARD = 1;
 {$EXTERNALSYM APPCOMMAND_BROWSER_BACKWARD}
  APPCOMMAND_BROWSER_FORWARD  = 2;
 {$EXTERNALSYM APPCOMMAND_BROWSER_FORWARD}

 cxDesignSelectorIndentFromBorder = 8;
 cxDesignSelectorSize = 15;

const
  cxInvisibleCoordinate = 30000;

type
  TcxSystemMenuType = (smSystem, smChild, smDialog);

  TcxHandle = HWND;

  TcxDragDetect = (ddNone, ddDrag, ddCancel);

  TcxNumberType = (ntInteger, ntFloat, ntExponent);

{$IFDEF DELPHI17}
  TcxScrollStyle = System.UITypes.TScrollStyle;
{$ELSE}
  TcxScrollStyle = StdCtrls.TScrollStyle;
{$ENDIF}

  TcxRecordScrollMode = (rsmDefault, rsmByRecord, rsmByPixel);

  TLBGetItemRect = packed record
    Msg: Cardinal;
    ItemIndex: Integer;
    Rect: PRect;
    Result: Longint;
  end;

  TcxControl = class;
  TcxControlScrollBar = class;

  TDragControlObjectClass = class of TDragControlObject;

  IdxPopupControl = interface
  ['{631D4C30-8543-4A08-A50E-9ABA2FA7EF33}']
    function GetOwnerControl: TWinControl;
  end;

  IdxSpellChecker = interface
  ['{4515FCEE-2D09-4709-A170-E29C556355BF}']
    procedure CheckFinish;
    procedure CheckStart(AControl: TWinControl);
    procedure DrawMisspellings(AControl: TWinControl);
    function IsSpellCheckerDialogControl(AWnd: THandle): Boolean;
    procedure KeyPress(AKey: Char);
    procedure LayoutChanged(AControl: TWinControl);
    function QueryPopup(APopup: TComponent; const P: TPoint): Boolean;
    procedure SelectionChanged(AControl: TWinControl);
    procedure TextChanged(AControl: TWinControl);
    procedure Undo;
  end;

  IdxSpellChecker2 = interface
  ['{0480D25C-94DA-449D-BBE6-B771C76D0BB1}']
    procedure KeyDown(AKey: Word; Shift: TShiftState);
    procedure KeyUp(AKey: Word; Shift: TShiftState);
  end;

  IdxSpellCheckerControl = interface
  ['{2DEA4CCA-3C6D-4283-9441-AABBD61F74F3}']
    function SupportsSpelling: Boolean;
    procedure SetSelText(const AText: string; APost: Boolean = False);
    procedure SetIsBarControl(AValue: Boolean);
    procedure SetValue(const AValue: Variant);
  end;

  IdxSystemInfoListener = interface
  ['{F137963E-6165-47F9-A4C7-96BB4EB91AE0}']
    procedure Changed(AParameter: Cardinal);
  end;

  TdxSpellCheckerAutoCorrectWordRange = record
    Replacement: WideString;
    SelStart: Integer;
    SelLength: Integer;
    NewSelStart: Integer;
  end;
  PdxSpellCheckerAutoCorrectWordRange = ^TdxSpellCheckerAutoCorrectWordRange;

  IcxMouseCaptureObject = interface
    ['{ACB73657-6066-4564-9A3D-D4D0273AA82F}']
    procedure DoCancelMode;
  end;

  IcxMouseTrackingCaller = interface
    ['{84A4BCBE-E001-4D60-B7A6-75E2B0DCD3E9}']
    procedure MouseLeave;
  end;

  IcxMouseTrackingCaller2 = interface(IcxMouseTrackingCaller)
    ['{3A5D973B-F016-4F22-80B6-1D35668D7743}']
    function PtInCaller(const P: TPoint): Boolean;
  end;

  { IcxCompoundControl }

  IcxCompoundControl = interface
  ['{A4A77F28-1D03-425B-9A83-0B853B5D8DEF}']
    function GetActiveControl: TWinControl;
    property ActiveControl: TWinControl read GetActiveControl;
  end;

  { IcxControlComponentState }

  IcxControlComponentState = interface
  ['{E29BF582-E8C0-4868-A799-DB4C41AC3BC8}']
    function IsDesigning: Boolean;
    function IsDestroying: Boolean;
    function IsLoading: Boolean;
  end;

  { IcxPopupMenu }

  IcxPopupMenu = interface
  ['{61EEDA7D-88CC-45BF-8A00-5C25174D6501}']
    function IsShortCutKey(var Message: TWMKey): Boolean;
    procedure Popup(X, Y: Integer);
  end;

  { IcxPopupMenu2 }

  IcxPopupMenu2 = interface(IcxPopupMenu)
  ['{E6DC09CE-3252-457B-B6D2-09D8335C2DED}']
    procedure Popup(X, Y: Integer; const AOwnerBounds: TRect; APopupAlignment: TPopupAlignment);
  end;

  { IcxTransparentControl }

  IcxTransparentControl = interface
    ['{F4980C69-029E-4B14-B3AD-953DA5C18BE7}']
    function IsTransparentRegionsPresent: Boolean;
  end;

  { control child component }

  TcxControlChildComponent = class(TcxComponent)
  private
    FControl: TcxControl;
    function GetIsLoading: Boolean;
  protected
    function GetIsDestroying: Boolean; virtual;
    procedure Initialize; virtual;
    procedure SetControl(Value: TcxControl); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateEx(AControl: TcxControl;
      AAssignOwner: Boolean = True); virtual;
    destructor Destroy; override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    procedure SetParentComponent(Value: TComponent); override;
    property Control: TcxControl read FControl write SetControl;
    property IsDestroying: Boolean read GetIsDestroying;
    property IsLoading: Boolean read GetIsLoading;
  end;

  { scrollbar and size grip }

  TcxScrollBarData = class
  private
    FAllowHide: Boolean;
    FAllowShow: Boolean;
    FEnabled: Boolean;
    FIsValid: Boolean;
    FLargeChange: TScrollBarInc;
    FMin: Integer;
    FMax: Integer;
    FPosition: Integer;
    FPageSize: Integer;
    FSmallChange: TScrollBarInc;
    FVisible: Boolean;
  protected
    procedure Validate;
  public
    property AllowHide: Boolean read FAllowHide write FAllowHide;
    property AllowShow: Boolean read FAllowShow write FAllowShow;
    property Enabled: Boolean read FEnabled write FEnabled;
    property IsValid: Boolean read FIsValid;
    property LargeChange: TScrollBarInc read FLargeChange write FLargeChange;
    property Min: Integer read FMin write FMin;
    property Max: Integer read FMax write FMax;
    property Position: Integer read FPosition write FPosition;
    property PageSize: Integer read FPageSize write FPageSize;
    property SmallChange: TScrollBarInc read FSmallChange write FSmallChange;
    property Visible: Boolean read FVisible write FVisible;
  end;

  IcxControlScrollBar = interface
    ['{D70735C6-82E8-4D17-AE14-9317D2A11D0C}']
    procedure ApplyData;
    function GetControl: TcxControlScrollBar;
    function GetBoundsRect: TRect;
    function GetData: TcxScrollBarData;
    function GetEnabled: Boolean;
    function GetHeight: Integer;
    function GetKind: TScrollBarKind;
    function GetLargeChange: TScrollBarInc;
    function GetLeft: Integer;
    function GetMax: Integer;
    function GetMin: Integer;
    function GetPageSize: Integer;
    function GetPosition: Integer;
    function GetSmallChange: TScrollBarInc;
    function GetTop: Integer;
    function GetUnlimitedTracking: Boolean;
    function GetVisible: Boolean;
    function GetWidth: Integer;
    procedure SetBoundsRect(const AValue: TRect);
    procedure SetEnabled(AValue: Boolean);
    procedure SetHeight(AValue: Integer);
    procedure SetKind(AValue: TScrollBarKind);
    procedure SetLargeChange(AValue: TScrollBarInc);
    procedure SetLeft(AValue: Integer);
    procedure SetMax(AValue: Integer);
    procedure SetMin(AValue: Integer);
    procedure SetPageSize(AValue: Integer);
    procedure SetPosition(AValue: Integer);
    procedure SetScrollParams(AMin, AMax, APosition, APageSize: Integer; ARedraw: Boolean = True);
    procedure SetSmallChange(AValue: TScrollBarInc);
    procedure SetTop(AValue: Integer);
    procedure SetUnlimitedTracking(AValue: Boolean);
    procedure SetVisible(AValue: Boolean);
    procedure SetWidth(AValue: Integer);
    property BoundsRect: TRect read GetBoundsRect write SetBoundsRect;
    property Control: TcxControlScrollBar read GetControl;
    property Data: TcxScrollBarData read GetData;
    property Enabled: Boolean read GetEnabled write SetEnabled;
    property Height: Integer read GetHeight write SetHeight;
    property Kind: TScrollBarKind read GetKind write SetKind;
    property LargeChange: TScrollBarInc read GetLargeChange write SetLargeChange;
    property Left: Integer read GetLeft write SetLeft;
    property Max: Integer read GetMax write SetMax;
    property Min: Integer read GetMin write SetMin;
    property PageSize: Integer read GetPageSize write SetPageSize;
    property Position: Integer read GetPosition write SetPosition;
    property SmallChange: TScrollBarInc read GetSmallChange write SetSmallChange;
    property Top: Integer read GetTop write SetTop;
    property UnlimitedTracking: Boolean read GetUnlimitedTracking write SetUnlimitedTracking;
    property Visible: Boolean read GetVisible write SetVisible;
    property Width: Integer read GetWidth write SetWidth;
  end;

  TcxControlScrollBar = class(TcxScrollBar, IcxControlScrollBar)
  private
    FData: TcxScrollBarData;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
  protected
    procedure DoPaint(ACanvas: TcxCanvas); override;
    procedure FocusParent; virtual;
    procedure SetZOrder(TopMost: Boolean); override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // IcxControlScrollBar
    procedure ApplyData;
    function GetBoundsRect: TRect;
    function GetControl: TcxControlScrollBar;
    function GetData: TcxScrollBarData;
    function GetHeight: Integer;
    function GetLeft: Integer;
    function GetTop: Integer;
    function GetVisible: Boolean;
    function GetWidth: Integer;
    procedure SetBoundsRect(const AValue: TRect);
    procedure SetHeight(AValue: Integer);
    procedure SetLeft(AValue: Integer);
    procedure SetTop(AValue: Integer);
    procedure SetVisible(AValue: Boolean);
    procedure SetWidth(AValue: Integer);
    property Control: TcxControlScrollBar read GetControl;
    property Visible: Boolean read GetVisible write SetVisible;
  end;
  TcxControlScrollBarClass = class of TcxControlScrollBar;

  TcxControlScrollBarHelper = class(TcxScrollBarHelper, IcxControlScrollBar)
  private
    FData: TcxScrollBarData;
  public
    constructor Create(AOwner: IcxScrollBarOwner); override;
    destructor Destroy; override;
    procedure Repaint; override;
    // IcxControlScrollBar
    procedure ApplyData;
    function GetControl: TcxControlScrollBar;
    function GetData: TcxScrollBarData;
    function GetHeight: Integer;
    function GetLeft: Integer;
    function GetTop: Integer;
    function GetWidth: Integer;
    procedure SetHeight(Value: Integer);
    procedure SetLeft(Value: Integer);
    procedure SetTop(Value: Integer);
    procedure SetWidth(Value: Integer);
    property Control: TcxControlScrollBar read GetControl;
    property Left: Integer read GetLeft write SetLeft;
    property Top: Integer read GetTop write SetTop;
    property Height: Integer read GetHeight write SetHeight;
    property Width: Integer read GetWidth write SetWidth;
  end;
  TcxControlScrollBarHelperClass = class of TcxControlScrollBarHelper;

  { TcxSizeGrip }

  TcxSizeGrip = class(TCustomControl)
  private
    FLookAndFeel: TcxLookAndFeel;
    procedure WMEraseBkgnd(var AMessage: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure Draw(ACanvas: TCanvas); virtual;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
    procedure Paint; override;
    procedure SetZOrder(TopMost: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property LookAndFeel: TcxLookAndFeel read FLookAndFeel;
  end;
  TcxSizeGripClass = class of TcxSizeGrip;

  { TcxSizeGripHelper }

  TcxSizeGripHelper = class
  private
    FBoundsRect: TRect;
    FIsNonClient: Boolean;
    FOwner: IcxScrollBarOwner;
    FVisible: Boolean;
    procedure RefreshNCPart(const ARect: TRect);
  protected
    property Owner: IcxScrollBarOwner read FOwner;
  public
    constructor Create(AOwner: IcxScrollBarOwner); virtual;
    procedure Paint(ACanvas: TcxCanvas); virtual;
    procedure Repaint; virtual;
    property BoundsRect: TRect read FBoundsRect write FBoundsRect;
    property IsNonClient: Boolean read FIsNonClient write FIsNonClient;
    property Visible: Boolean read FVisible write FVisible;
  end;
  TcxSizeGripHelperClass = class of TcxSizeGripHelper;

  TcxControlScrollBarsManager = class(TcxIUnknownObject,
    IcxMouseTrackingCaller, IcxMouseTrackingCaller2)
  private
    FIsCapture: Boolean;
    FHotScrollBar: TcxControlScrollBarHelper;
    FOwner: TcxControl;
    FScrollBars: TList;
    function GetScrollBars(AIndex: Integer): TcxControlScrollBarHelper;
    procedure SetHotScrollBar(AValue: TcxControlScrollBarHelper);
    procedure SetIsCapture(AValue: Boolean);
  protected
    function ProcessMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; virtual;
    function ProcessMouseMove(Shift: TShiftState; X, Y: Integer): Boolean; virtual;
    function ProcessMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; virtual;
    // IcxMouseTrackingCaller
    procedure MouseLeave;
    // IcxMouseTrackingCaller2
    function PtInCaller(const P: TPoint): Boolean;

    property HotScrollBar: TcxControlScrollBarHelper read FHotScrollBar write SetHotScrollBar;
    property IsCapture: Boolean read FIsCapture write SetIsCapture;
    property ScrollBars[Index: Integer]: TcxControlScrollBarHelper read GetScrollBars;
  public
    constructor Create(AOwner: TcxControl); virtual;
    destructor Destroy; override;
    function HandleMessage(var Message: TMessage): Boolean; virtual;
    function IsScrollBarsArea(const APoint: TPoint): Boolean; virtual;
    procedure Paint(ACanvas: TcxCanvas); virtual;
    procedure RegisterScrollBar(AScrollBar: TcxControlScrollBarHelper);
    procedure UnRegisterScrollBar(AScrollBar: TcxControlScrollBarHelper);
  end;

  TcxControlCustomScrollBars = class(TcxIUnknownObject)
  private
    FCalculating: Boolean;
    FOwner: TcxControl;
    FHScrollBar: TObject;
    FSizeGrip: TObject;
    FVScrollBar: TObject;
  protected
    procedure ApplyData; virtual;
    procedure BringInternalControlsToFront; virtual;
    function CheckSize(AKind: TScrollBarKind): Boolean; virtual;
    procedure CheckSizeGripVisible(AValue: Boolean); virtual; abstract;
    function CreateScrollBar(AKind: TScrollBarKind): TObject; virtual; abstract;
    procedure CreateScrollBars; virtual;
    function CreateSizeGrip: TObject; virtual; abstract;
    procedure DestroyScrollBars; virtual;
    procedure DoScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer); virtual;
    function GetScrollBar(AKind: TScrollBarKind): IcxControlScrollBar; virtual;
    procedure InitScrollBars; virtual;
    function IsInternalControl(AControl: TControl): Boolean; virtual;
    function IsScrollBarVisible(AKind: TScrollBarKind): Boolean; virtual;
    function IsSizeGripArea(const APoint: TPoint): Boolean; virtual;
    procedure SetInternalControlsBounds; virtual;
    procedure UpdateInternalControlsState; virtual;

    property Calculating: Boolean read FCalculating write FCalculating;
    property Owner: TcxControl read FOwner;
  public
    constructor Create(AOwner: TcxControl); virtual;
    destructor Destroy; override;
    procedure Invalidate; virtual;
    procedure DrawSizeGrip(ACanvas: TcxCanvas); virtual;
  end;
  TcxControlCustomScrollBarsClass = class of TcxControlCustomScrollBars;

  TcxControlScrollBars = class(TcxControlCustomScrollBars, IcxScrollBarOwner)
  private
    function GetHScrollBar: TcxControlScrollBarHelper;
    function GetSizeGrip: TcxSizeGripHelper;
    function GetVScrollBar: TcxControlScrollBarHelper;
  protected
    // IcxScrollBarOwner
    function GetControl: TWinControl; virtual;
    function GetLookAndFeel: TcxLookAndFeel; virtual;

    function CheckSize(AKind: TScrollBarKind): Boolean; override;
    procedure CheckSizeGripVisible(AValue: Boolean); override;
    function CreateScrollBar(AKind: TScrollBarKind): TObject; override;
    function CreateSizeGrip: TObject; override;
    procedure DestroyScrollBars; override;
    function GetScrollBarClass(AKind: TScrollBarKind): TcxControlScrollBarHelperClass; virtual;
    function GetSizeGripClass: TcxSizeGripHelperClass; virtual;
    function IsSizeGripArea(const APoint: TPoint): Boolean; override;
    procedure SetInternalControlsBounds; override;

    property HScrollBar: TcxControlScrollBarHelper read GetHScrollBar;
    property VScrollBar: TcxControlScrollBarHelper read GetVScrollBar;
    property SizeGrip: TcxSizeGripHelper read GetSizeGrip;
  public
    procedure Invalidate; override;
    procedure DrawSizeGrip(ACanvas: TcxCanvas); override;
  end;

  TcxControlWindowedScrollBars = class(TcxControlCustomScrollBars)
  private
    function GetHScrollBar: TcxControlScrollBar;
    function GetSizeGrip: TcxSizeGrip;
    function GetVScrollBar: TcxControlScrollBar;
  protected
    procedure BringInternalControlsToFront; override;
    function CheckSize(AKind: TScrollBarKind): Boolean; override;
    procedure CheckSizeGripVisible(AValue: Boolean); override;
    function CreateScrollBar(AKind: TScrollBarKind): TObject; override;
    function CreateSizeGrip: TObject; override;
    procedure DestroyScrollBars; override;
    procedure InitScrollBars; override;
    function IsInternalControl(AControl: TControl): Boolean; override;
    procedure SetInternalControlsBounds; override;
    procedure UpdateInternalControlsState; override;

    property HScrollBar: TcxControlScrollBar read GetHScrollBar;
    property VScrollBar: TcxControlScrollBar read GetVScrollBar;
    property SizeGrip: TcxSizeGrip read GetSizeGrip;
  public
    procedure Invalidate; override;
  end;

  { drag & drop objects }

  TcxDragAndDropObjectClass = class of TcxDragAndDropObject;

  TcxDragAndDropObject = class
  private
    FCanvas: TcxCanvas;
    FControl: TcxControl;
    FDirty: Boolean;
    procedure SetDirty(Value: Boolean);
  protected
    procedure ChangeMousePos(const P: TPoint);
    procedure DirtyChanged; virtual;
    function GetClientCursorPos: TPoint; virtual;
    function GetDragAndDropCursor(Accepted: Boolean): TCursor; virtual;
    function GetImmediateStart: Boolean; virtual;

    procedure AfterDragAndDrop(Accepted: Boolean); virtual;
    procedure BeginDragAndDrop; virtual;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); virtual;
    procedure EndDragAndDrop(Accepted: Boolean); virtual;

    property Canvas: TcxCanvas read FCanvas write FCanvas;
    property Control: TcxControl read FControl;
    property Dirty: Boolean read FDirty write SetDirty;
  public
    CurMousePos: TPoint;
    PrevMousePos: TPoint;
    constructor Create(AControl: TcxControl); virtual;

    procedure DoBeginDragAndDrop;
    procedure DoDragAndDrop(const P: TPoint; var Accepted: Boolean);
    procedure DoEndDragAndDrop(Accepted: Boolean);

    property ImmediateStart: Boolean read GetImmediateStart;
  end;

  TcxDragControlObject = class(TDragControlObject)
  protected
    procedure Finished(Target: TObject; X, Y: Integer; Accepted: Boolean); override;
    function GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor; override;
  end;

  TcxDragImageListClass = class of TcxDragImageList;

  TcxDragImageList = class(TDragImageList);

  { control }

  TcxControlBorderStyle = (cxcbsNone, cxcbsDefault);
  TcxDragAndDropState = (ddsNone, ddsStarting, ddsInProcess);

  TcxKey = (kAll, kArrows, kChars, kTab);
  TcxKeys = set of TcxKey;

  TcxMouseWheelScrollingKind = (mwskNone, mwskHorizontal, mwskVertical);

  TcxControlListernerLink = class
    Ref: TcxControl;
  end;

  TcxControl = class(TCustomControl, IcxLookAndFeelContainer, IdxLocalizerListener,
    IdxSystemInfoListener, IdxGestureClient, IdxGestureOwner, IcxScrollBarOwner)
  private
    FActiveCanvas: TcxCanvas;
    FBorderStyle: TcxControlBorderStyle;
    FCanvas: TcxCanvas;
    FCreatingWindow: Boolean;
    FDragAndDropObject: TcxDragAndDropObject;
    FDragAndDropObjectClass: TcxDragAndDropObjectClass;
    FDragAndDropPrevCursor: TCursor;
    FDragAndDropState: TcxDragAndDropState;
    FDragImages: TcxDragImageList;
    FFinishingDragAndDrop: Boolean;
    FFocusOnClick: Boolean;
    FFontListenerList: IInterfaceList;
    // touch
    FGestureHelper: TdxGestureHelper;
    FGestureAccumulatedDelta: TPoint;
    //
    FInitialHScrollBarVisible: Boolean;
    FInitialVScrollBarVisible: Boolean;
    FIsInitialScrollBarsParams: Boolean;
    FKeys: TcxKeys;
    FLookAndFeel: TcxLookAndFeel;
    FMouseButtonPressed: Boolean;
    FMouseCaptureObject: TObject;
    FMouseDownPos: TPoint;
    FMouseEnterCounter: Integer;
    FMouseRightButtonReleased: Boolean;
    FMouseWheelAccumulator: Integer;
    FPopupMenu: TComponent;

    FMainScrollBars: TcxControlCustomScrollBars;
    FScrollBars: TcxScrollStyle;
    FScrollBarsManager: TcxControlScrollBarsManager;
    FScrollBarsLockCount: Integer;
    FScrollBarsUpdateNeeded: Boolean;
    FUpdatingScrollBars: Boolean;
    FIsScrollingContent: Boolean;
    FOnFocusChanged: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;

    function GetActiveCanvas: TcxCanvas;
    function GetDragAndDropObject: TcxDragAndDropObject;
    function GetHScrollBar: IcxControlScrollBar;
    function GetHScrollBarVisible: Boolean;
    function GetIsDestroying: Boolean;
    function GetIsLoading: Boolean;
    function GetSizeGrip: TcxSizeGrip;
    function GetVScrollBar: IcxControlScrollBar;
    function GetVScrollBarVisible: Boolean;
    procedure SetBorderStyle(Value: TcxControlBorderStyle);
    procedure SetDragAndDropState(Value: TcxDragAndDropState);
    procedure SetLookAndFeel(Value: TcxLookAndFeel);
    procedure SetKeys(Value: TcxKeys);
    procedure SetMouseCaptureObject(Value: TObject);
    procedure SetPopupMenu(Value: TComponent);
    procedure SetScrollBars(Value: TcxScrollStyle);

    procedure DoNCPaint(AWindowDC: HDC);
    procedure DoScrollBarBasedGestureScroll(AKind: TScrollBarKind;
      var AAccumulatedDelta: Integer; ADeltaX, ADeltaY: Integer);

    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMPrint(var Message: TWMPrint); message WM_PRINT;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
  {$IFNDEF DELPHI14}
    procedure WMTabletQuerySystemGestureStatus(var Message: TMessage); message WM_TABLET_QUERYSYSTEMGESTURESTATUS;
  {$ENDIF}
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMCursorChanged(var Message: TMessage); message CM_CURSORCHANGED;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMInvalidate(var Message: TMessage); message CM_INVALIDATE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMNCSizeChanged(var Message: TMessage); message DXM_NCSIZECHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure CNSysKeyDown(var Message: TWMKeyDown); message CN_SYSKEYDOWN;
    procedure CreateScrollBars;
    procedure DestroyScrollBars;
  protected
    FBounds: TRect;
  {$IFNDEF DELPHI10}
    function ClientToParent(const P: TPoint; AParent: TWinControl): TPoint;
  {$ENDIF}
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure Resize; override;
    procedure WndProc(var Message: TMessage); override;
    procedure DestroyWindowHandle; override;
    procedure DoContextPopup(MousePos: TPoint;
      var Handled: Boolean); override;

    // touch
    procedure BeginGestureScroll(APos: TPoint); virtual;
    function CanScrollContentByGestureWithoutScrollBars: Boolean; virtual;
    procedure CheckOverpan(AScrollKind: TScrollBarKind;
      ANewDataPos, AMinDataPos, AMaxDataPos: Integer; ADeltaX, ADeltaY: Integer); virtual;
    procedure DoGestureScroll(AScrollKind: TScrollBarKind; ANewScrollPos: Integer); virtual;
    procedure EndGestureScroll; virtual;
  {$IFDEF DELPHI14}
    procedure DoGesture(const EventInfo: TGestureEventInfo; var Handled: Boolean); override;
    procedure DoGetGestureOptions(var Gestures: TInteractiveGestures;
      var Options: TInteractiveGestureOptions); override;
    function GetDefaultInteractiveGestures: TInteractiveGestures; virtual;
    function GetDefaultInteractiveGestureOptions: TInteractiveGestureOptions; virtual;
    function IsTouchPropertyStored(AProperty: TTouchProperty): Boolean; override;
  {$ENDIF}
    procedure GestureScroll(ADeltaX, ADeltaY: Integer); virtual;
    function IsDefaultGesture(AGestureID: Integer): Boolean; virtual;
    function IsGestureHelperMessage(var Message: TMessage): Boolean; virtual;
    function IsGestureScrolling: Boolean; virtual;
    function IsScrollBarBasedGestureScroll(AScrollKind: TScrollBarKind): Boolean; virtual;
    function GetDefaultPanOptions: Integer; virtual;
    procedure ScrollContentByGesture(AScrollKind: TScrollBarKind; ADelta: Integer); virtual;
    //
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
       MousePos: TPoint): Boolean; override;
    function DoShowPopupMenu(AMenu: TComponent; X, Y: Integer): Boolean; virtual;
    function GetPopupMenu: TPopupMenu; override;
    function InternalMouseWheel(Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint): Boolean; virtual;
    function IsDoubleBufferedNeeded: Boolean; virtual;
    function IsMenuKey(var Message: TWMKey): Boolean; virtual;
    procedure Modified; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetParentBackground(Value: Boolean); override;

    procedure EraseBackground(DC: HDC); overload; virtual;
    procedure EraseBackground(ACanvas: TcxCanvas; const ARect: TRect); overload; virtual;
    procedure Paint; override;
    procedure StandardPaintHandler(var Message: TWMPaint);
    procedure PaintNonClientArea(ACanvas: TcxCanvas); virtual;
    procedure PaintWindow(DC: HDC); override;

    procedure AddChildComponent(AComponent: TcxControlChildComponent); dynamic;
    procedure RemoveChildComponent(AComponent: TcxControlChildComponent); dynamic;

    procedure AfterMouseDown(AButton: TMouseButton; X, Y: Integer); virtual;
    procedure BeforeMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure BringInternalControlsToFront; virtual;
    procedure CancelMouseOperations; virtual;
    procedure DoCancelMode; dynamic;
    procedure DoPaint; virtual;
    procedure DrawBorder(ACanvas: TcxCanvas); virtual;
    procedure DrawScrollBars(ACanvas: TcxCanvas); virtual;
    function GetBorderSize: Integer; virtual;
    function GetBounds: TRect; virtual;
    function GetClientBounds: TRect; virtual;
    function GetClientOffsets: TRect; virtual;
    function GetCurrentCursor(X, Y: Integer): TCursor; virtual;
    function GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean; dynamic;
    function GetDragObjectClass: TDragControlObjectClass; dynamic;
    function GetIsDesigning: Boolean; virtual;
    function GetIsFocused: Boolean; virtual;
    function GetMainScrollBarsClass: TcxControlCustomScrollBarsClass; virtual;
    function GetMouseCursorClientPos: TPoint;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; virtual;
    function GetPaintBlackOpaqueOnGlass: Boolean; virtual;
    function GetScrollBarClass(AKind: TScrollBarKind): TcxControlScrollBarClass; virtual;
    function GetSizeGripClass: TcxSizeGripClass; virtual;
    procedure InitControl; virtual;
    class procedure InvalidateControl(AControl: TWinControl; ANeedInvalidateSelf, ANeedInvalidateChildren: Boolean);
    procedure MouseEnter(AControl: TControl); dynamic;
    procedure MouseLeave(AControl: TControl); dynamic;
    procedure FocusEnter; dynamic;
    procedure FocusLeave; dynamic;
    procedure SetPaintRegion; virtual;

    // Conditions
    function AllowCompositionPainting: Boolean; virtual;
    function CanFocusOnClick: Boolean; overload; virtual;
    function CanFocusOnClick(X, Y: Integer): Boolean; overload; virtual;
    function FocusWhenChildIsClicked(AChild: TControl): Boolean; virtual;
    function HasBackground: Boolean; virtual;
    function HasNonClientArea: Boolean; virtual;
    function IsMouseWheelHandleNeeded(Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint): Boolean; virtual;
    function IsTransparentBackground: Boolean; virtual;
    function IsInternalControl(AControl: TControl): Boolean; virtual;
    function MayFocus: Boolean; dynamic;
    function NeedRedrawOnResize: Boolean; virtual;
    function UpdateMousePositionIfControlMoved: Boolean; virtual;

    // Notifications
    procedure BoundsChanged; dynamic;
    procedure ColorChanged; dynamic;
    procedure ParentBackgroundChanged; virtual;
    procedure CursorChanged; dynamic;
    procedure FocusChanged; dynamic;
    procedure FontChanged; dynamic;
    procedure TextChanged; dynamic;
    procedure VisibleChanged; dynamic;

    // IdxGestureClient
    function AllowGesture(AGestureId: Integer): Boolean; virtual;
    function AllowPan(AScrollKind: TScrollBarKind): Boolean; virtual;
    function GetPanOptions: Integer; virtual;
    function IsPanArea(const APoint: TPoint): Boolean; virtual;
    function NeedPanningFeedback(AScrollKind: TScrollBarKind): Boolean; virtual;
    // IdxGestureOwner
    function GetGestureClient(const APoint: TPoint): IdxGestureClient; virtual;
    function IdxGestureOwner.GetHandle = GetGestureClientHandle;
    function GetGestureClientHandle: THandle; virtual;
    function IsGestureTarget(AWnd: THandle): Boolean; virtual;
    // IcxLookAndFeelContainer
    function IcxLookAndFeelContainer.GetLookAndFeel = GetLookAndFeelValue;
    function GetLookAndFeelValue: TcxLookAndFeel; virtual;
    // IcxScrollBarOwner
    function GetControl: TWinControl;
    function IcxScrollBarOwner.GetLookAndFeel = GetScrollBarLookAndFeel;
    function GetScrollBarLookAndFeel: TcxLookAndFeel; virtual;

    // look&feel
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainter; virtual;
    procedure LookAndFeelChangeHandler(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues);
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues); virtual;
    property LookAndFeel: TcxLookAndFeel read FLookAndFeel write SetLookAndFeel;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainter read GetLookAndFeelPainter;

    // scrollbars
    function CanScrollLineWithoutScrollBars(ADirection: TcxDirection): Boolean; virtual;
    function CanUpdateScrollBars: Boolean; virtual;
    procedure CheckNeedsScrollBars;
    procedure DoScrolling;
    procedure DoUpdateScrollBars; virtual;
    function GetHScrollBarBounds: TRect; virtual;
    function GetSizeGripBounds: TRect; virtual;
    function GetScrollBar(AKind: TScrollBarKind): IcxControlScrollBar;
    function GetSystemSizeScrollBars: TcxScrollStyle; virtual;
    function GetVScrollBarBounds: TRect; virtual;
    procedure InitScrollBars;
    procedure InitScrollBarsParameters; virtual;
    function IsPixelScrollBar(AKind: TScrollBarKind): Boolean; virtual;
    function IsScrollBarsArea(const APoint: TPoint): Boolean; virtual;
    function IsScrollBarsCapture: Boolean;
    function IsSizeGripArea(const APoint: TPoint): Boolean; virtual;
    function IsSizeGripVisible: Boolean; virtual;
    function NeedsScrollBars: Boolean; virtual;
    function NeedsToBringInternalControlsToFront: Boolean; virtual;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
      var AScrollPos: Integer); virtual;
    procedure SetInternalControlsBounds; virtual;
    procedure UpdateInternalControlsState; virtual;
    procedure UpdateScrollBars; virtual; 

    property HScrollBar: IcxControlScrollBar read GetHScrollBar;
    property HScrollBarVisible: Boolean read GetHScrollBarVisible;
    property MainScrollBars: TcxControlCustomScrollBars read FMainScrollBars;
    property ScrollBarsManager: TcxControlScrollBarsManager read FScrollBarsManager;
    property ScrollBars: TcxScrollStyle read FScrollBars write SetScrollBars default ssBoth;
    property SizeGrip: TcxSizeGrip read GetSizeGrip;
    property UpdatingScrollBars: Boolean read FUpdatingScrollBars;
    property VScrollBar: IcxControlScrollBar read GetVScrollBar;
    property VScrollBarVisible: Boolean read GetVScrollBarVisible;

    // internal drag and drop (columns moving, ...)
    function AllowAutoDragAndDropAtDesignTime(X, Y: Integer; Shift: TShiftState): Boolean; virtual;
    function AllowDragAndDropWithoutFocus: Boolean; dynamic;
    function CanCancelDragStartOnCaptureObjectClear: Boolean; virtual;
    function CreateDragAndDropObject: TcxDragAndDropObject; virtual;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); dynamic;
    procedure EndDragAndDrop(Accepted: Boolean); dynamic;
    function GetDragAndDropObjectClass: TcxDragAndDropObjectClass; virtual;
    function StartDragAndDrop(const P: TPoint): Boolean; dynamic;

    // delphi drag and drop
    function CanDrag(X, Y: Integer): Boolean; dynamic;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    procedure DrawDragImage(ACanvas: TcxCanvas; const R: TRect); virtual;
    function GetDragImagesClass: TcxDragImageListClass; virtual;
    function GetDragImagesSize: TPoint; virtual;
    function GetIsCopyDragDrop: Boolean; virtual;
    function HasDragImages: Boolean; virtual;
    procedure HideDragImage;
    procedure InitDragImages(ADragImages: TcxDragImageList); virtual;
    procedure ShowDragImage;
    property DragImages: TcxDragImageList read FDragImages;
    property GestureHelper: TdxGestureHelper read FGestureHelper;
    property IsCopyDragDrop: Boolean read GetIsCopyDragDrop;

    property BorderSize: Integer read GetBorderSize;
    property BorderStyle: TcxControlBorderStyle read FBorderStyle write SetBorderStyle;
    property CreatingWindow: Boolean read FCreatingWindow;
    property FocusOnClick: Boolean read FFocusOnClick write FFocusOnClick default True;
    property FontListenerList: IInterfaceList read FFontListenerList;
    property Keys: TcxKeys read FKeys write SetKeys;
    property MouseRightButtonReleased: Boolean read FMouseRightButtonReleased write FMouseRightButtonReleased;
    property MouseWheelScrollingKind: TcxMouseWheelScrollingKind read GetMouseWheelScrollingKind;
    property PopupMenu: TComponent read FPopupMenu write SetPopupMenu;
    property IsScrollingContent: Boolean read FIsScrollingContent;
    property ParentBackground default True;

    property OnFocusChanged: TNotifyEvent read FOnFocusChanged write FOnFocusChanged;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetDragImages: TDragImageList; override;
    function CanFocusEx: Boolean; virtual;
    function AcceptMousePosForClick(X, Y: Integer): Boolean; virtual;
    procedure InvalidateRect(const R: TRect; EraseBackground: Boolean);
    procedure InvalidateRgn(ARegion: TcxRegion; EraseBackground: Boolean);
    procedure InvalidateWithChildren;
    function IsMouseInPressedArea(X, Y: Integer): Boolean; virtual;
    procedure PostMouseMove(AMousePos: TPoint); overload;
    procedure PostMouseMove; overload;
    procedure ScrollContent(ADirection: TcxDirection); virtual;
    procedure ScrollWindow(DX, DY: Integer; const AScrollRect: TRect);
    procedure SetScrollBarInfo(AScrollBarKind: TScrollBarKind;
      AMin, AMax, AStep, APage, APos: Integer; AAllowShow, AAllowHide: Boolean);
    function StartDrag(DragObject: TDragObject): Boolean; dynamic;
    procedure UpdateWithChildren;

    // internal drag and drop (columns moving, ...)
    procedure BeginDragAndDrop; dynamic;
    procedure FinishDragAndDrop(Accepted: Boolean);
    property DragAndDropObject: TcxDragAndDropObject read GetDragAndDropObject;
    property DragAndDropObjectClass: TcxDragAndDropObjectClass read GetDragAndDropObjectClass
      write FDragAndDropObjectClass;
    property DragAndDropState: TcxDragAndDropState read FDragAndDropState
      write SetDragAndDropState;

    procedure AddFontListener(AListener: IcxFontListener);
    procedure RemoveFontListener(AListener: IcxFontListener);

    procedure LockScrollBars;
    procedure UnlockScrollBars;

    // IdxLocalizerListener
    procedure TranslationChanged; virtual;

    // IdxSystemInfoListener
    procedure IdxSystemInfoListener.Changed = SystemInfoChanged;
    procedure SystemInfoChanged(AParameter: Cardinal); virtual;

    property ActiveCanvas: TcxCanvas read GetActiveCanvas;
    property Bounds: TRect read GetBounds;
    property Canvas: TcxCanvas read FCanvas;
    property ClientBounds: TRect read GetClientBounds;
    property IsDesigning: Boolean read GetIsDesigning;
    property IsDestroying: Boolean read GetIsDestroying;
    property IsLoading: Boolean read GetIsLoading;
    property IsFocused: Boolean read GetIsFocused;
    property MouseCaptureObject: TObject read FMouseCaptureObject write SetMouseCaptureObject;
    property MouseDownPos: TPoint read FMouseDownPos write FMouseDownPos;

    property TabStop default True; // MayFocus = True
  {$IFDEF DELPHI14}
  published
    property Touch;
    property OnGesture;
  {$ENDIF}
  end;

  TcxControlClass = class of TcxControl; 

  TdxChangeType = (ctLight, ctMedium, ctHard);
  TdxAutoSizeMode = (asNone, asAutoWidth, asAutoHeight, asAutoSize);

  IdxScrollingControl = interface
  ['{7F141990-5975-4E6B-BFAF-03D378860F20}']
    function GetLeftPos: Integer;
    procedure SetLeftPos(Value: Integer);
    function GetTopPos: Integer;
    procedure SetTopPos(Value: Integer);
    function GetContentSize: TSize;

    function GetInstance: TcxControl;
  end;

  TcxScrollingControl = class(TcxControl, IdxScrollingControl)
  private
    function GetTopPos: Integer;
    function GetLeftPos: Integer;
    function GetInstance: TcxControl;
  protected
    FAutoSizeMode: TdxAutoSizeMode;
    FAutoSizeModeSetting: Boolean;
    FLeftPos: Integer;
    FTopPos: Integer;

    procedure LookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues); override;

    procedure BoundsChanged; override;
    procedure Calculate(AType: TdxChangeType); virtual;
    procedure LayoutChanged(AType: TdxChangeType = ctHard); virtual;
    procedure ScrollPosChanged; virtual;

    function IsScrollDataValid: Boolean; virtual;

    procedure CheckPositions;
    procedure CheckLeftPos(var AValue: Integer);
    procedure CheckTopPos(var AValue: Integer);
    function GetContentSize: TSize; virtual;
    function GetClientSize: TSize; virtual;
    procedure InitScrollBarsParameters; override;
    procedure MakeVisible(const ARect: TRect; AFully: Boolean);
    procedure SetAutoSize(Value: Boolean); override;
    procedure SetAutoSizeMode(AValue: TdxAutoSizeMode); virtual;
    procedure SetLeftPos(AValue: Integer); virtual;
    procedure SetTopPos(AValue: Integer); virtual;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode; var AScrollPos: Integer); override;

    property AutoSizeMode: TdxAutoSizeMode read FAutoSizeMode write SetAutoSizeMode;
    property LeftPos: Integer read GetLeftPos write SetLeftPos;
    property TopPos: Integer read GetTopPos write SetTopPos;
  end;

  TdxScrollHelper = class
  private
    class procedure CheckLeftPos(AControl: IdxScrollingControl; var AValue: Integer);
    class procedure CheckTopPos(AControl: IdxScrollingControl; var AValue: Integer);

//    class procedure ScrollContent(AControl: IdxScrollingControl; APrevPos, ACurPos: Integer; AHorzScrolling: Boolean);
    class procedure ScrollContent(AControl: IdxScrollingControl);
  public
    class procedure CheckPositions(AControl: IdxScrollingControl);
    class procedure SetPos(AControl: IdxScrollingControl; X, Y: Integer);
    class procedure SetLeftPos(AControl: IdxScrollingControl; AValue: Integer);
    class procedure SetTopPos(AControl: IdxScrollingControl; AValue: Integer);
    class function IsScrollDataValid(AControl: IdxScrollingControl): Boolean;
    class procedure GestureScroll(AControl: IdxScrollingControl; ADeltaX, ADeltaY: Integer);
    class function GetClientSize(AControl: IdxScrollingControl): TSize;
    class procedure InitScrollBarsParameters(AControl: IdxScrollingControl);
    class procedure Scroll(AControl: IdxScrollingControl; AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode; var AScrollPos: Integer);
  end;

  { customize listbox }

  TcxCustomizeListBox = class(TListBox)
  private
    FDragAndDropItemIndex: Integer;
    FMouseDownPos: TPoint;
    function GetDragAndDropItemObject: TObject;
    function GetItemObject: TObject;
    procedure SetItemObject(Value: TObject);
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure BeginDragAndDrop; dynamic;

    property DragAndDropItemIndex: Integer read FDragAndDropItemIndex;
    property DragAndDropItemObject: TObject read GetDragAndDropItemObject;
  public
    constructor Create(AOwner: TComponent); override;
    property ItemObject: TObject read GetItemObject write SetItemObject;
  end;

  { TcxDesignSelector }

  TcxDesignSelector = class(TcxControl)
  private
    function CreateRegion: TcxRegionHandle;
    function GetDesignRect: TRect;
  protected
    function GetSelected: Boolean; virtual;
    procedure BoundsChanged; override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    //
    property DesignRect: TRect read GetDesignRect;
    property Selected: Boolean read GetSelected;
  end;

  { TcxMessageWindow }

  TcxMessageWindow = class(TcxIUnknownObject)
  private
    FHandle: HWND;
    procedure MainWndProc(var Message: TMessage);
  protected
    procedure WndProc(var Message: TMessage); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property Handle: HWND read FHandle;
  end;

  { TcxSystemController }

  TcxSystemController = class(TcxMessageWindow)
  private
    FPrevWakeMainThread: TNotifyEvent;
    procedure WakeMainThread(Sender: TObject);
    procedure HookSynchronizeWakeup;
    procedure UnhookSynchronizeWakeup;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  { TdxSystemInfo }

  TdxSystemInfo = class(TcxMessageWindow)
  private
    FIsDropShadow: Boolean;
    FListeners: TInterfaceList;
    FNonClientMetrics: TNonClientMetrics;
    function GetIsRemoteSession: Boolean;
    procedure UpdateCache(AParameter: Cardinal);
  protected
    procedure WndProc(var Message: TMessage); override;
    procedure NotifyListeners(AParameter: Cardinal);
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure AddListener(AListener: IdxSystemInfoListener);
    function GetParameter(AParameter: Cardinal; var AValue): Boolean;
    procedure RemoveListener(AListener: IdxSystemInfoListener);

    property IsDropShadow: Boolean read FIsDropShadow;
    property IsRemoteSession: Boolean read GetIsRemoteSession;
    property NonClientMetrics: TNonClientMetrics read FNonClientMetrics;
  end;

  { TdxMessagesController }

  TdxMessagesController = class
  private
    FLockedMessages: TList;
  protected
    FOldWndProc: Pointer;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    function IsMessageInQueue(AWnd: THandle; AMessage: UINT): Boolean;
    function KillMessages(AWnd: THandle; AMsgFilterMin: UINT; AMsgFilterMax: UINT = 0;
      AKillAllMessages: Boolean = True): Boolean;

    function IsMessageLocked(AMessage: UINT): Boolean;
    procedure LockMessages(AMessages: array of UINT);
    procedure UnlockMessages(AMessages: array of UINT);
    procedure BlockMessage(AHandle: THandle);
    procedure BlockLockedMessage(AHandle: THandle; var AMessage: UINT);
  end;

  { popup }

  TcxPopupAlignHorz = (pahLeft, pahCenter, pahRight);
  TcxPopupAlignVert = (pavTop, pavCenter, pavBottom);
  TcxPopupDirection = (pdHorizontal, pdVertical);

  TcxPopupWindow = class(TForm, IdxSkinSupport2)
  private
    FAdjustable: Boolean;
    FAlignHorz: TcxPopupAlignHorz;
    FAlignVert: TcxPopupAlignVert;
    FBorderSpace: Integer;
    FBorderStyle: TcxPopupBorderStyle;
    FCanvas: TcxCanvas;
    FDirection: TcxPopupDirection;
    FFrameColor: TColor;
    FOwnerBounds: TRect;
    FOwnerParent: TControl;
    FPrevActiveWindow: HWND;
    function GetNCHeight: Integer;
    function GetNCWidth: Integer;
    procedure SetBorderSpace(Value: Integer);
    procedure SetBorderStyle(Value: TcxPopupBorderStyle);
    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMActivateApp(var Message: TWMActivateApp); message WM_ACTIVATEAPP;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
  protected
    procedure Deactivate; override;
    procedure Paint; override;
    procedure VisibleChanged; dynamic;

    function CalculatePosition: TPoint; virtual;
    procedure CalculateSize; virtual;
    function GetBorderWidth(ABorder: TcxBorder): Integer; virtual;
    function GetClientBounds: TRect; virtual;
    function GetFrameWidth(ABorder: TcxBorder): Integer; virtual;
    function GetOwnerScreenBounds: TRect; virtual;
    procedure InitPopup; virtual;
    procedure RestoreControlsBounds;

    procedure DrawFrame; virtual;

    // IdxSkinSupport2
    function IsSkinnable: Boolean;

    property BorderWidths[ABorder: TcxBorder]: Integer read GetBorderWidth;
    property Canvas: TcxCanvas read FCanvas;
    property FrameWidths[ABorder: TcxBorder]: Integer read GetFrameWidth;
    property NCHeight: Integer read GetNCHeight;
    property NCWidth: Integer read GetNCWidth;
  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
    procedure CloseUp; virtual;
    procedure Popup; virtual;

    property Adjustable: Boolean read FAdjustable write FAdjustable;
    property AlignHorz: TcxPopupAlignHorz read FAlignHorz write FAlignHorz;
    property AlignVert: TcxPopupAlignVert read FAlignVert write FAlignVert;
    property BorderSpace: Integer read FBorderSpace write SetBorderSpace;
    property BorderStyle: TcxPopupBorderStyle read FBorderStyle write SetBorderStyle;
    property ClientBounds: TRect read GetClientBounds;
    property Direction: TcxPopupDirection read FDirection write FDirection;
    property FrameColor: TColor read FFrameColor write FFrameColor;
    property OwnerBounds: TRect read FOwnerBounds write FOwnerBounds;
    property OwnerParent: TControl read FOwnerParent write FOwnerParent;
    property OwnerScreenBounds: TRect read GetOwnerScreenBounds;
  end;

  { drag image }

  TcxCustomDragImage = class(TcxPopupWindow, IdxSkinSupport, IdxSkinSupport2)
  private
  {$IFNDEF DELPHI9}
    FPopupParent: TCustomForm;
  {$ENDIF}
    FPositionOffset: TPoint;
    function GetAlphaBlended: Boolean;
    function GetVisible: Boolean;
    procedure SetVisible(Value: Boolean);
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    // IdxSkinSupport2
    function IsSkinnable: Boolean; virtual;
  public
    constructor Create; override;
  {$IFDEF DELPHI9}
    destructor Destroy; override;
  {$ENDIF}
    procedure Init(const ASourceBounds: TRect; const ASourcePoint: TPoint);
    procedure MoveTo(const APosition: TPoint);
    procedure Show(ACmdShow: Integer = SW_SHOWNA);
    procedure Hide;

    property AlphaBlended: Boolean read GetAlphaBlended;
  {$IFNDEF DELPHI9}
    property PopupParent: TCustomForm read FPopupParent write FPopupParent;
  {$ENDIF}
    property PositionOffset: TPoint read FPositionOffset write FPositionOffset;
    property Visible: Boolean read GetVisible write SetVisible;
  end;

  TcxDragImage = class(TcxCustomDragImage)
  private
    FImage: TcxBitmap;
    function GetImageCanvas: TcxCanvas;
    function GetWindowCanvas: TcxCanvas;
  protected
    procedure Paint; override;
    property Image: TcxBitmap read FImage;
    property WindowCanvas: TcxCanvas read GetWindowCanvas;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property Canvas: TcxCanvas read GetImageCanvas;
  end;

  TcxDragImageClass = class of TcxDragImage;

  { TcxSizeFrame }

  TcxSizeFrame = class(TcxCustomDragImage)
  private
    FFillSelection: Boolean;
    FFrameWidth: Integer;
    FRegion: TcxRegion;

    procedure InitializeFrameRegion;
    procedure SetWindowRegion;
  protected
    procedure Paint; override;

    property FrameWidth: Integer read FFrameWidth;
  public
    constructor Create(AFrameWidth: Integer = 2); reintroduce; virtual;
    destructor Destroy; override;

    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    procedure DrawSizeFrame(const ARect: TRect); overload;
    procedure DrawSizeFrame(const ARect: TRect; const ARegion: TcxRegion); overload;

    property FillSelection: Boolean read FFillSelection write FFillSelection;
  end;

  { TcxDragAndDropArrow }

  TcxArrowPlace = (apLeft, apTop, apRight, apBottom);

  TcxDragAndDropArrowClass = class of TcxDragAndDropArrow;

  TcxDragAndDropArrow = class(TcxDragImage)
  private
    FTransparent: Boolean;
    function GetTransparent: Boolean;
  protected
    function GetImageBackColor: TColor; virtual;
    property ImageBackColor: TColor read GetImageBackColor;
  public
    constructor Create(ATransparent: Boolean); reintroduce; virtual;
    procedure Init(AOwner: TControl; const AAreaBounds, AClientRect: TRect;
      APlace: TcxArrowPlace); overload;
    procedure Init(const AOwnerOrigin: TPoint; const AAreaBounds, AClientRect: TRect;
      APlace: TcxArrowPlace); overload;
    property Transparent: Boolean read GetTransparent;
  end;

  { TcxDesignController }

  TcxDesignState = (dsDesignerModifying);
  TcxDesignStates = set of TcxDesignState;

  TcxDesignController = class
  private
    FLockDesignerModifiedCount: Integer;
  protected
    FState: TcxDesignStates;
  public
    procedure DesignerModified(AForm: TCustomForm); overload;
    function IsDesignerModifiedLocked: Boolean;
    procedure LockDesignerModified;
    procedure UnLockDesignerModified;
  end;

  TcxWindowProcLinkedObject = class(TcxDoublyLinkedObject)
  private
    FControl: TControl;
    FHandle: THandle;
    FWindowProc: TWndMethod;
  protected
    property WindowProc: TWndMethod read FWindowProc write FWindowProc;
  public
    constructor Create(AControl: TControl); overload;
    constructor Create(AHandle: THandle); overload;
    procedure DefaultProc(var Message: TMessage);
    property Control: TControl read FControl;
    property Handle: THandle read FHandle;
  end;

  TcxSubclassingHelper = class
  protected
    FDefaultWindowProc: TWndMethod;
    function CreateLinkedObject: TcxDoublyLinkedObject; virtual; abstract;
    procedure RestoreDefaultProc; virtual; abstract;
    procedure StoreAndReplaceDefaultProc(AWndProc: TWndMethod); virtual; abstract;
    property DefaultWindowProc: TWndMethod read FDefaultWindowProc;
  end;

  TcxVCLSubclassingHelper = class(TcxSubclassingHelper)
  private
    FControl: TControl;
  protected
    function CreateLinkedObject: TcxDoublyLinkedObject; override;
    procedure RestoreDefaultProc; override;
    procedure StoreAndReplaceDefaultProc(AWndProc: TWndMethod); override;
  public
    constructor Create(AControl: TControl);
  end;

  TcxWin32SubclassingHelper = class(TcxSubclassingHelper)
  private
    FAPIDefaultWndProc: Pointer;
    FAPIWndProc: Pointer;
    FHandle: THandle;
  protected
    function CreateLinkedObject: TcxDoublyLinkedObject; override;
    procedure DefaultWndProc(var Message: TMessage);
    procedure RestoreDefaultProc; override;
    procedure StoreAndReplaceDefaultProc(AWndProc: TWndMethod); override;
  public
    constructor Create(AHandle: THandle);
  end;

  TcxWindowProcLinkedObjectList = class(TcxDoublyLinkedObjectList)
  private
    FControl: TControl;
    FHandle: THandle;
    FHelper: TcxSubclassingHelper;
  protected
    function AddProc(AWndProc: TWndMethod): TcxWindowProcLinkedObject;
    function CreateLinkedObject: TcxDoublyLinkedObject; override;
    procedure Initialize; virtual;
    function IsEmpty: Boolean;
    procedure WndProc(var Message: TMessage);
    property Control: TControl read FControl;
    property Handle: THandle read FHandle;
  public
    constructor Create(AControl: TControl); overload;
    constructor Create(AHandle: THandle); overload;
    destructor Destroy; override;
  end;

  TcxWindowProcController = class
  private
    FWindowProcObjects: TcxObjectList;
    function GetControlWindowProcObjects(AControl: TControl): TcxWindowProcLinkedObjectList; overload;
    function GetControlWindowProcObjects(AHandle: THandle): TcxWindowProcLinkedObjectList; overload;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(AControl: TControl; AWndProc: TWndMethod): TcxWindowProcLinkedObject; overload;
    function Add(AHandle: THandle; AWndProc: TWndMethod): TcxWindowProcLinkedObject; overload;
    procedure Remove(var AWndProcObject: TcxWindowProcLinkedObject);
  end;

// LOCKED STATE

  TcxLockedStatePaintHelper = class;

  IcxLockedStatePaint = interface
  ['{EB45AB76-3681-4838-BDA8-7D0081B4C184}']
    function GetImage: TcxBitmap32;
    function GetTopmostControl: TcxControl;
  end;

  IcxLockedStateFontChanged = interface
  ['{825BFA90-77C6-4725-BE95-B0A1EA8F934D}']
    procedure FontChanged(AFont: TFont);
  end;

  { TcxLockedStateImageOptions }

  TcxLockedStateImageShowingMode = (lsimNever, lsimPending, lsimImmediate);
  TcxLockedStateImageEffect = (lsieNone, lsieLight, lsieDark);

  TcxLockedStateImageAssignedValue = (lsiavFont, lsiavColor);
  TcxLockedStateImageAssignedValues = set of TcxLockedStateImageAssignedValue;

  TcxLockedStateImageOptions = class(TPersistent)
  private
    FAssignedValues: TcxLockedStateImageAssignedValues;
    FEnabled: Boolean;
    FOwner: TComponent;
    FShowText: Boolean;
    FEffect: TcxLockedStateImageEffect;
    FText: string;
    FColor: TColor;
    FFont: TFont;
    procedure FontChanged(Sender: TObject);
    function IsFontStored: Boolean;
    procedure SetColor(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetAssignedValues(const Value: TcxLockedStateImageAssignedValues);
  protected
    function GetFont: TFont; virtual; abstract;
    function IsTextStored: Boolean; virtual;

    property Owner: TComponent read FOwner;
  public
    constructor Create(AOwner: TComponent); virtual;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Assign(Source: TPersistent); override;
    procedure UpdateFont(AFont: TFont);
  published
    property AssignedValues: TcxLockedStateImageAssignedValues read FAssignedValues write SetAssignedValues default [];
    property Color: TColor read FColor write SetColor default clNone;
    property Effect: TcxLockedStateImageEffect read FEffect write FEffect default lsieNone;
    property Enabled: Boolean read FEnabled write FEnabled default True;
    property Font: TFont read FFont write SetFont stored IsFontStored;
    property ShowText: Boolean read FShowText write FShowText default False;
    property Text: string read FText write FText stored IsTextStored;
  end;

  { TcxLockedStatePaintHelper }

  TcxLockedStatePaintHelper = class
  private
    FBitmap: TcxBitmap32;
    FCount: Integer;
    FCreatingImage: Boolean;
    FIsImageReady: Boolean;
    FOwner: TComponent;
    function GetColor: TColor; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetEffect: TcxLockedStateImageEffect; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetFont: TFont; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetText: string; {$IFDEF DELPHI9} inline; {$ENDIF}
  protected
    procedure CreateImage;
    procedure DrawText;
    procedure PrepareImage; virtual;
    procedure ValidateImage;
    //virtual
    function CanCreateLockedImage: Boolean; virtual;
    function CanControlPaint: Boolean; virtual;
    function DoPrepareImage: Boolean; virtual;
    function GetOptions: TcxLockedStateImageOptions; virtual; abstract;
    function GetControl: TcxControl; virtual; abstract;
    function GetPainter: TcxCustomLookAndFeelPainter; virtual;

    property Bitmap: TcxBitmap32 read FBitmap;
    property Color: TColor read GetColor;
    property Control: TcxControl read GetControl;
    property CreatingImage: Boolean read FCreatingImage;
    property Effect: TcxLockedStateImageEffect read GetEffect;
    property Font: TFont read GetFont;
    property IsImageReady: Boolean read FIsImageReady;
    property Options: TcxLockedStateImageOptions read GetOptions;
    property Owner: TComponent read FOwner;
    property Painter: TcxCustomLookAndFeelPainter read GetPainter;
    property Text: string read GetText;
  public
    constructor Create(AOwner: TComponent); virtual;
    destructor Destroy; override;
    procedure BeginLockedPaint(AMode: TcxLockedStateImageShowingMode);
    procedure EndLockedPaint;
    function GetActiveCanvas: TcxCanvas; virtual;
    function GetImage: TcxBitmap32;
    function IsActive: Boolean;
  end;

  TdxSetOperation = (soSet, soAdd, soSubtract);
  TdxWindowStyleIndex = (wsiStyle, wsiExStyle);

// WINDOW HANDLE
function CanAllocateHandle(AControl: TWinControl): Boolean;
function dxMapWindowPoint(AHandleFrom, AHandleTo: TcxHandle; const P: TPoint; AClient: Boolean = True): TPoint;
function dxMapWindowRect(AHandleFrom, AHandleTo: TcxHandle; const R: TRect; AClient: Boolean = True): TRect;
procedure cxRecreateControlWnd(AControl: TWinControl; APostponed: Boolean = False);
function cxClientToScreen(AHandle: THandle; const APoint: TPoint): TPoint;
function cxGetClientRect(AControl: TWinControl): TRect; overload;
function cxGetClientRect(AHandle: THandle): TRect; overload;
function cxGetClientOffset(AHandle: THandle): TPoint;
function cxGetWindowRect(AControl: TWinControl): TRect; overload;
function cxGetWindowRect(AHandle: THandle): TRect; overload;
function cxGetWindowText(AHandle: THandle): string;
function cxGetWindowBounds(AControl: TWinControl): TRect; overload;
function cxGetWindowBounds(AHandle: THandle): TRect; overload;
function cxWindowFromPoint(P: TPoint): HWND;
procedure dxSetZOrder(AHandle: THandle; AWndAfter: THandle = HWND_TOPMOST;
  AActivate: Boolean = False; AFlags: DWORD = 0);

// SYSTEM MENU
function cxLoadSysMenu(AMenuType: TcxSystemMenuType): THandle;
procedure cxModifySystemMenu(ASysMenu: THandle; AWindowHandle: THandle;
  AIsDialog: Boolean; ABorderIcons: TBorderIcons; AWindowState: TWindowState;
  ALockRepaint: Boolean = True);
procedure cxMoveMenuItems(ASource, ADest: THandle);

// MOUSE
function GetMouseKeys: WPARAM;
function GetDblClickInterval: Integer;
function GetMouseCursorPos: TPoint;
function GetPointPosition(const ARect: TRect; const P: TPoint;
  AHorzSeparation, AVertSeparation: Boolean): TcxPosition;
function cxShiftStateMoveOnly(const AShift: TShiftState): Boolean;
function cxShiftStateLeftOnly(AShift: TShiftState; ACanIncludeDoubleClick: Boolean = False): Boolean;

// MONITOR
function GetDesktopWorkArea(const P: TPoint): TRect;
function GetMonitorWorkArea(const AMonitor: Integer): TRect;
procedure MakeVisibleOnDesktop(var ABounds: TRect; const ADesktopPoint: TPoint); overload;
procedure MakeVisibleOnDesktop(AControl: TControl); overload;

// PARENT STRAIN
function IsChildClassWindow(AWnd: HWND): Boolean;
function IsChildEx(AParentWnd, AWnd: HWND): Boolean;
function IsMDIChild(AForm: TCustomForm): Boolean;
function IsMDIForm(AForm: TCustomForm): Boolean;
function IsOwner(AOwnerWnd, AWnd: HWND): Boolean;
function IsOwnerEx(AOwnerWnd, AWnd: HWND): Boolean;
function IsWindowEnabledEx(AWindowHandle: HWND): Boolean;
function IsControlVisible(AControl: TWinControl): Boolean;
function cxFindVCLControl(AWnd: HWND): TWinControl;
function cxFindComponent(AParentComponent: TComponent; AClass: TClass): TComponent;
function cxClientToParent(AControl: TControl; const P: TPoint; AParent: TWinControl): TPoint;
function cxParentToClient(AControl: TControl; const P: TPoint; AParent: TWinControl): TPoint;
function dxFindParentControl(AHandle: THandle): TWinControl;
function dxGetParentForm(AHandle: THandle): TCustomForm;
procedure dxPerformMessageByQueue(AControl: TControl; AMessage: Cardinal);

// CHARS
function GetCharFromKeyCode(ACode: Word): Char;
function IsCtrlPressed: Boolean;
function IsEditStartChar(C: Char): Boolean;
function IsIncSearchStartChar(C: Char): Boolean;
function IsNumericChar(C: Char; AType: TcxNumberType): Boolean;
function IsSysKey(AKey: Word): Boolean;
function IsTextChar(C: Char): Boolean;
function RemoveAccelChars(const S: AnsiString; AAppendTerminatingUnderscore: Boolean = True): AnsiString; overload;
function RemoveAccelChars(const S: WideString; AAppendTerminatingUnderscore: Boolean = True): WideString; overload;
function ShiftStateToKeys(AShift: TShiftState): WORD;
function TranslateKey(Key: Word): Word;

// MOUSE TRACKING
procedure BeginMouseTracking(AControl: TWinControl; const ABounds: TRect;
  ACaller: IcxMouseTrackingCaller);
procedure EndMouseTracking(ACaller: IcxMouseTrackingCaller);
function IsMouseTracking(ACaller: IcxMouseTrackingCaller): Boolean;

// HOURGLASS
procedure HideHourglassCursor;
procedure ShowHourglassCursor;

// POPUPMENU
function GetPopupMenuHeight(APopupMenu: TPopupMenu): Integer;
function IsPopupMenu(APopupMenu: TComponent): Boolean;
function IsPopupMenuShortCut(APopupMenu: TComponent; var Message: TWMKey): Boolean;
function ShowPopupMenu(ACaller, APopupMenu: TComponent; const P: TPoint): Boolean; overload;
function ShowPopupMenu(ACaller, APopupMenu: TComponent; X, Y: Integer): Boolean; overload;
function ShowPopupMenu(ACaller, APopupMenu: TComponent;
  const AOwnerBounds: TRect; APopupAlignment: TPopupAlignment): Boolean; overload;
function ShowPopupMenuFromCursorPos(ACaller, AComponent: TComponent): Boolean;

// DRAG&DROP
function cxExtractDragObjectSource(ADragObject: TObject): TObject;
function cxDragDetect(Wnd: HWND; const AStartPoint: TPoint): TcxDragDetect;
function GetDragObject: TDragObject;
function IsPointInDragDetectArea(const AMouseDownPos: TPoint; X, Y: Integer): Boolean;

// DRAG&DROP ARROW
function GetDragAndDropArrowBounds(const AAreaBounds, AClientRect: TRect; APlace: TcxArrowPlace): TRect;
procedure GetDragAndDropArrowPoints(const ABounds: TRect; APlace: TcxArrowPlace;
  out P: TPointArray; AForRegion: Boolean);
procedure DrawDragAndDropArrow(ACanvas: TcxCanvas; const ABounds: TRect; APlace: TcxArrowPlace);

// WINDOWS
function cxIsDrawToMemory(const AMessage: TWMEraseBkgnd): Boolean;
procedure DialogApplyFont(ADialog: TCustomForm; AFont: TFont);
procedure cxSetLayeredWindowAttributes(AHandle: HWND; AAlphaBlendValue: Integer);
function cxWindowProcController: TcxWindowProcController;
function dxIsWindowStyleSet(AHandle: THandle; AStyle: DWORD): Boolean;
function dxSetWindowProc(AHandle: THandle; ANewWindowProc: Pointer): Pointer;
function dxSetWindowStyle(AHandle: THandle; ANewStyle: TdxNativeInt;
  AOperation: TdxSetOperation = soSet; AStyleIndex: TdxWindowStyleIndex = wsiStyle): TdxNativeInt;
function dxSystemInfo: TdxSystemInfo;
// vista extension
procedure dxDrawTextOnGlass(DC: HDC; const AText: string; AFont: TFont;
  const ABounds: TRect; AColor: TColor; AFlags: DWORD; AGlowingSize: Integer; ATransparent: Boolean);
procedure dxDrawWindowOnGlass(AWnd, ADC: THandle; const ABounds: TRect; APaintBlackOpaque: Boolean = False); overload;
procedure dxDrawWindowOnGlass(AWnd: THandle; APaintBlackOpaque: Boolean = False); overload;
procedure dxPaintWindowOnGlass(AWnd: THandle; APaintBlackOpaque: Boolean = False);
procedure dxBufferedPaintControl(AControl: TWinControl);
function dxIsPaintOnGlass(AControl: TWinControl): Boolean;
{$IFDEF VCLGLASSPAINT}
procedure dxForceProcessBufferedPaintMessages(AControl: TWinControl);
{$ENDIF}
//widow objects
function cxMessageWindow: TcxMessageWindow;
function dxMessagesController: TdxMessagesController;

// DESIGNER
function DesignController: TcxDesignController;
procedure SetDesignerModified(AComponent: TComponent);
function cxGetFullComponentName(AComponent: TComponent): string;
procedure cxReleaseForm(var AForm); // usually AForm is Designer

function cxIsVCLThemesAvailable: Boolean;
function cxIsVCLThemesEnabled: Boolean;
function cxStyleServices:{$IFDEF DELPHI16}TCustomStyleServices{$ELSE}TThemeServices{$ENDIF};

function GET_APPCOMMAND_LPARAM(lParam: LPARAM): Integer;
{$EXTERNALSYM GET_APPCOMMAND_LPARAM}

type
  TcxGetParentFormForDockingFunc = function (AControl: TControl): TCustomForm;
  TcxGetParentWndForDockingFunc = function (AWnd: HWND): HWND;

var
  cxDragAndDropWindowTransparency: Byte = 180;
  cxGetParentFormForDocking: TcxGetParentFormForDockingFunc = nil;
  cxGetParentWndForDocking: TcxGetParentWndForDockingFunc = nil;
  dxISpellChecker: IdxSpellChecker;
  dxISpellChecker2: IdxSpellChecker2;

implementation

{$R cxControls.res}

uses
{$IFNDEF DELPHI10}
  Consts,
{$ENDIF}
  SysUtils, Math, dxUxTheme, dxThemeConsts, cxGeometry, cxLibraryConsts,
  MultiMon, cxLibraryStrs, cxDWMApi, cxFormats, dxThemeManager;

const
  crFullScroll = crBase + 1;
  crHorScroll = crBase + 2;
  crVerScroll = crBase + 3;
  crUpScroll = crBase + 4;
  crRightScroll = crBase + 5;
  crDownScroll = crBase + 6;
  crLeftScroll = crBase + 7;

  ScreenHandle = 0;

type
  TControlAccess = class(TControl);
  TCustomFormAccess = class(TCustomForm);
  TMenuItemAccess = class(TMenuItem);

var
  FUnitIsFinalized: Boolean;
  FDragObject: TDragObject;
  FcxMessageWindow: TcxMessageWindow;
  FcxWindowProcController: TcxWindowProcController;
  FdxSystemInfo: TdxSystemInfo;
  FDesignController: TcxDesignController;
  FSystemController: TcxSystemController;
  FMessagesController: TdxMessagesController;

function dxGetUpdateRgn(AControl: TWinControl; ARegion: HRGN): Boolean;
const
  ValidClipRegions: set of Byte = [SIMPLEREGION, COMPLEXREGION];
begin
  if IsWinSeven and not IsCompositionEnabled then
    Result := False 
  else
    Result := GetUpdateRgn(AControl.Handle, ARegion, False) in ValidClipRegions;
end;

procedure cxSetLayeredWindowAttributes(AHandle: HWND; AAlphaBlendValue: Integer);
var
  AStyle: Integer;
begin
  if Assigned(SetLayeredWindowAttributes) then
  begin
    AStyle := GetWindowLong(AHandle, GWL_EXSTYLE);
    if AAlphaBlendValue < 255 then
    begin
      if (AStyle and WS_EX_LAYERED) = 0 then
        SetWindowLong(AHandle, GWL_EXSTYLE, AStyle or WS_EX_LAYERED);
      SetLayeredWindowAttributes(AHandle, 0, AAlphaBlendValue, LWA_ALPHA);
    end
    else
      if (AStyle and WS_EX_LAYERED) <> 0 then
      begin
        SetWindowLong(AHandle, GWL_EXSTYLE, AStyle and not WS_EX_LAYERED);
        RedrawWindow(AHandle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
      end;
  end;
end;

function cxWindowProcController: TcxWindowProcController;
begin
  if (FcxWindowProcController = nil) and not FUnitIsFinalized then
    FcxWindowProcController := TcxWindowProcController.Create;
  Result := FcxWindowProcController;
end;

function dxIsWindowStyleSet(AHandle: THandle; AStyle: DWORD): Boolean;
begin
  Result := GetWindowLong(AHandle, GWL_STYLE) and AStyle = AStyle;
end;

function dxSetWindowProc(AHandle: THandle; ANewWindowProc: Pointer): Pointer;
begin
  Result := Pointer(SetWindowLong(AHandle, GWL_WNDPROC, TdxNativeInt(ANewWindowProc)));
end;

function dxSetWindowStyle(AHandle: THandle; ANewStyle: TdxNativeInt;
  AOperation: TdxSetOperation = soSet; AStyleIndex: TdxWindowStyleIndex = wsiStyle): TdxNativeInt;
const
  StyleIndexMap: array[TdxWindowStyleIndex] of TdxNativeInt = (GWL_STYLE, GWL_EXSTYLE);
var
  AStyle: Integer;
begin
  case AOperation of
    soAdd:
      AStyle := GetWindowLong(AHandle, StyleIndexMap[AStyleIndex]) or ANewStyle;
    soSubtract:
      AStyle := GetWindowLong(AHandle, StyleIndexMap[AStyleIndex]) and not ANewStyle;
    else // soSet
      AStyle := ANewStyle;
  end;
  Result := SetWindowLong(AHandle, StyleIndexMap[AStyleIndex], AStyle);
end;

function dxSystemInfo: TdxSystemInfo;
begin
  if (FdxSystemInfo = nil) and not FUnitIsFinalized then
    FdxSystemInfo := TdxSystemInfo.Create;
  Result := FdxSystemInfo;
end;

procedure dxDrawTextOnGlass(DC: HDC; const AText: string; AFont: TFont;
  const ABounds: TRect; AColor: TColor; AFlags: DWORD; AGlowingSize: Integer;
  ATransparent: Boolean);
var
  AInfo: TBitmapInfo;
  AMemoryDC: HDC;
  AOptions: TdxDTTOpts;
  ATheme: TdxTheme;
  DIB, AOldBitmap: HBITMAP;
  P: Pointer;
  R: TRect;
begin
  AMemoryDC := CreateCompatibleDC(DC);

  AInfo.bmiHeader.biSize := SizeOf(TBitmapInfo);
  AInfo.bmiHeader.biWidth := cxRectWidth(ABounds);
  AInfo.bmiHeader.biHeight := -cxRectHeight(ABounds);
  AInfo.bmiHeader.biPlanes := 1;
  AInfo.bmiHeader.biBitCount := 32;
  AInfo.bmiHeader.biCompression := BI_RGB;

  DIB := CreateDIBSection(DC, AInfo, DIB_RGB_COLORS, P, 0, 0);
  AOldBitmap := SelectObject(AMemoryDC, dib);

  R := cxRect(0, 0, ABounds.Right - ABounds.Left, ABounds.Bottom - ABounds.Top);
  if ATransparent then
    cxBitBlt(AMemoryDC, DC, R, ABounds.TopLeft, SRCCOPY);

  SelectObject(AMemoryDC, AFont.Handle);
  AOptions.dwSize := SizeOf(TdxDTTOpts);
  AOptions.dwFlags := DTT_COMPOSITED or DTT_TEXTCOLOR;

  AOptions.crText := ColorToRGB(AColor);
  if AGlowingSize > 0 then
  begin
    AOptions.dwFlags := AOptions.dwFlags or DTT_GLOWSIZE;
    AOptions.iGlowSize := AGlowingSize;
  end;

  ATheme := OpenTheme(totWindow);
  DrawThemeTextEx(ATheme, AMemoryDC, 0, 0, AText, -1, AFlags, R, AOptions);
  cxBitBlt(DC, AMemoryDC, ABounds, cxNullPoint, SRCCOPY);

  SelectObject(AMemoryDC, AOldBitmap);
  DeleteObject(DIB);
  DeleteDC(AMemoryDC);
end;

procedure dxDrawWindowOnGlass(AWnd, ADC: THandle; const ABounds: TRect; APaintBlackOpaque: Boolean);

  procedure DoDraw(ADC: THandle);
  begin
    SendMessage(AWnd, WM_ERASEBKGND, ADC, ADC);
    SendMessage(AWnd, WM_PRINTCLIENT, ADC, PRF_CLIENT);
  end;

var
  AMemDC: HDC;
  APaintBuffer: THandle;
begin
  if not cxRectIsEmpty(ABounds) then
  begin
    APaintBuffer := BeginBufferedPaint(ADC, @ABounds, BPBF_COMPOSITED, nil, AMemDC);
    if APaintBuffer <> 0 then
    try
      BufferedPaintClear(APaintBuffer, ABounds);
      DoDraw(AMemDC);
      if not APaintBlackOpaque then
        BufferedPaintSetAlpha(APaintBuffer, @ABounds, 255);
    finally
      if GetFocus = AWnd then
      begin
        HideCaret(AWnd);
        EndBufferedPaint(APaintBuffer, True);
        ShowCaret(AWnd);
      end
      else
        EndBufferedPaint(APaintBuffer, True);
    end
    else
      DoDraw(ADC);
  end;
end;

procedure dxDrawWindowOnGlass(AWnd: THandle; APaintBlackOpaque: Boolean);
var
  R: TRect;
  ADC: THandle;
begin
  ADC := GetDC(AWnd);
  try
    GetClientRect(AWnd, R);
    dxDrawWindowOnGlass(AWnd, ADC, R, APaintBlackOpaque);
  finally
    ReleaseDC(AWnd, ADC);
  end;
end;

procedure dxPaintWindowOnGlass(AWnd: THandle; APaintBlackOpaque: Boolean);
var
  ADC: HDC;
  PS: TPaintStruct;
begin
  ADC := BeginPaint(AWnd, PS);
  try
    dxDrawWindowOnGlass(AWnd, ADC, PS.rcPaint, APaintBlackOpaque);
  finally
    EndPaint(AWnd, PS);
  end;
end;

procedure dxBufferedPaintControl(AControl: TWinControl);
var
  ADC, AMemDC: HDC;
  AClipRgn: HRgn;
  AHasClipRgn: Boolean;
  AMemBitmap, AOldBitmap: HBITMAP;
  PS: TPaintStruct;
begin
  AClipRgn := CreateRectRgn(0, 0, 0, 0);
  AHasClipRgn := dxGetUpdateRgn(AControl, AClipRgn);
  ADC := BeginPaint(AControl.Handle, PS);
  AMemBitmap := CreateCompatibleBitmap(ADC, cxRectWidth(PS.rcPaint), cxRectHeight(PS.rcPaint));
  try
    AMemDC := CreateCompatibleDC(ADC);
    AOldBitmap := SelectObject(AMemDC, AMemBitmap);
    try
      SetWindowOrgEx(AMemDC, PS.rcPaint.Left, PS.rcPaint.Top, nil);
      if AHasClipRgn then
      begin
        OffsetRgn(AClipRgn, -PS.rcPaint.Left, -PS.rcPaint.Top);
        SelectClipRgn(AMemDC, AClipRgn);
      end;
      AControl.Perform(WM_ERASEBKGND, AMemDC, AMemDC);
      AControl.Perform(WM_PAINT, AMemDC, 0);
      cxBitBlt(ADC, AMemDC, PS.rcPaint, PS.rcPaint.TopLeft, SRCCOPY);
    finally
      SelectObject(AMemDC, AOldBitmap);
      DeleteDC(AMemDC);
    end;
  finally
    DeleteObject(AClipRgn);
    DeleteObject(AMemBitmap);
    EndPaint(AControl.Handle, PS);
  end;
end;

function dxIsPaintOnGlass(AControl: TWinControl): Boolean;
{$IFDEF DELPHI11}

  {$IFNDEF DELPHI12}
    function HasGlassArea(AParentForm: TCustomForm): Boolean;
    var
      R: TRect;
    begin
      R := cxRectOffset(AControl.ClientRect, AParentForm.ScreenToClient(AControl.ClientToScreen(cxNullPoint)));
      with AParentForm.GlassFrame do
        Result := ((Left > 0) and (R.Left < Left)) or ((Top > 0) and (R.Top < Top)) or
          ((Right > 0) and (R.Right > (AParentForm.ClientRect.Right - Right))) or
          ((Bottom > 0) and (R.Bottom > (AParentForm.ClientRect.Bottom - Bottom)));
    end;
  {$ENDIF}

{$IFNDEF DELPHI12}
var
  AParentForm: TCustomForm;
{$ENDIF}
{$ENDIF}
begin
  Result := False;
{$IFDEF DELPHI11}
  if AControl.HandleAllocated and IsCompositionEnabled then
  begin
  {$IFDEF DELPHI12}
    Result := csGlassPaint in AControl.ControlState;
  {$ELSE}
    AParentForm := GetParentForm(AControl);
    Result := (AParentForm <> nil) and AParentForm.GlassFrame.Enabled and
      (AParentForm.GlassFrame.SheetOfGlass or HasGlassArea(AParentForm));
  {$ENDIF}
  end;
{$ENDIF}
end;

{$IFDEF VCLGLASSPAINT}
procedure dxForceProcessBufferedPaintMessages(AControl: TWinControl);
const
  BufferedPaintMessage = CM_BUFFEREDPRINTCLIENT;
var
  AMessage: TMsg;
begin
  if (AControl <> nil) and AControl.HandleAllocated and not (csDestroying in AControl.ComponentState) then
  begin
    while PeekMessage(AMessage, AControl.Handle, BufferedPaintMessage, BufferedPaintMessage, PM_REMOVE) do
      DispatchMessage(AMessage);
  end;
end;
{$ENDIF}

function CanAllocateHandle(AControl: TWinControl): Boolean;
begin
  Result :=
    (AControl <> nil) and
    (AControl.HandleAllocated or
      not (csDestroying in AControl.ComponentState) and
      ((AControl.ParentWindow <> 0) or
         CanAllocateHandle(AControl.Parent) or
         ((AControl.Parent = nil) and (Application <> nil) and (Application.Handle <> 0) and
           ((AControl is TCustomForm) or (AControl is TCustomFrame)))));
end;

function cxIsDrawToMemory(const AMessage: TWMEraseBkgnd): Boolean;
begin
  Result := TMessage(AMessage).wParam = WPARAM(TMessage(AMessage).lParam); 
end;

function cxMessageWindow: TcxMessageWindow;
begin
  if (FcxMessageWindow = nil) and not FUnitIsFinalized then
    FcxMessageWindow := TcxMessageWindow.Create;
  Result := FcxMessageWindow;
end;

function dxMessagesController: TdxMessagesController;
begin
  if (FMessagesController = nil) and not FUnitIsFinalized then
    FMessagesController := TdxMessagesController.Create;
  Result := FMessagesController;
end;

function cxIsVCLThemesAvailable: Boolean;
begin
{$IFDEF DELPHI16}
  Result := cxStyleServices.Available;
{$ELSE}
  Result := cxStyleServices.ThemesAvailable;
{$ENDIF}
end;

function cxIsVCLThemesEnabled: Boolean;
begin
{$IFDEF DELPHI16}
  Result := cxStyleServices.Enabled;
{$ELSE}
  Result := cxStyleServices.ThemesEnabled;
{$ENDIF}
end;

function cxStyleServices:{$IFDEF DELPHI16}TCustomStyleServices{$ELSE}TThemeServices{$ENDIF};
begin
  Result := {$IFDEF DELPHI16}StyleServices{$ELSE}ThemeServices{$ENDIF};
end;

function cxDragDetect(Wnd: HWND; const AStartPoint: TPoint): TcxDragDetect;
var
  NoDragZone: TRect;
  P: TPoint;
  Msg: TMsg;
begin
  Result := ddCancel;

  NoDragZone.Right := 2 * Mouse.DragThreshold;//GetSystemMetrics(SM_CXDRAG);
  NoDragZone.Bottom := 2 * Mouse.DragThreshold;//GetSystemMetrics(SM_CYDRAG);
  NoDragZone.Left := AStartPoint.X - NoDragZone.Right div 2;
  NoDragZone.Top := AStartPoint.Y - NoDragZone.Bottom div 2;
  Inc(NoDragZone.Right, NoDragZone.Left);
  Inc(NoDragZone.Bottom, NoDragZone.Top);

  SetCapture(Wnd);
  try
    while GetCapture = Wnd do
    begin
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
            PostQuitMessage(Msg.wParam);
            Break;
          end;
      end;
      try
        case Msg.message of
          WM_KEYDOWN, WM_KEYUP:
            if Msg.wParam = VK_ESCAPE then Break;
          WM_MOUSEMOVE:
            if Msg.hwnd = Wnd then
            begin
              P := Point(LoWord(Msg.lParam), HiWord(Msg.lParam));
              ClientToScreen(Msg.hwnd, P);
              if not PtInRect(NoDragZone, P) then
              begin
                Result := ddDrag;
                Break;
              end;
            end;
          WM_LBUTTONUP, WM_RBUTTONUP, WM_MBUTTONUP:
            begin
              Result := ddNone;
              Break;
            end;
        end;
      finally
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  finally
    if GetCapture = Wnd then ReleaseCapture;
  end;
end;

function GetCharFromKeyCode(ACode: Word): Char;
const
  MAPVK_VK_TO_VSC = 0;

var
  AScanCode: UINT;
  AKeyState: TKeyboardState;
  ABufChar: Word;
begin
  ABufChar := 0;
  AScanCode := MapVirtualKey(ACode, MAPVK_VK_TO_VSC);
  GetKeyboardState(AKeyState);
{$IFDEF DELPHI12}
  if ToUnicode(ACode, AScanCode, AKeyState, ABufChar, 1, 0) = 1 then
    Result := Char(ABufChar)
  else
    Result := #0;
{$ELSE}
  if ToAscii(ACode, AScanCode, AKeyState, @ABufChar, 0) = 1 then
    Result := PChar(@ABufChar)^
  else
    Result := #0;
{$ENDIF}
end;

function GetMouseKeys: WPARAM;
begin
  Result := 0;
  if GetAsyncKeyState(VK_LBUTTON) < 0 then Inc(Result, MK_LBUTTON);
  if GetAsyncKeyState(VK_MBUTTON) < 0 then Inc(Result, MK_MBUTTON);
  if GetAsyncKeyState(VK_RBUTTON) < 0 then Inc(Result, MK_RBUTTON);
  if GetAsyncKeyState(VK_CONTROL) < 0 then Inc(Result, MK_CONTROL);
  if GetAsyncKeyState(VK_SHIFT) < 0 then Inc(Result, MK_SHIFT);
end;

function GetDblClickInterval: Integer;
begin
  Result := GetDoubleClickTime;
end;

function GetDesktopWorkArea(const P: TPoint): TRect;
begin
  Result := GetMonitorWorkArea(MonitorFromPoint(P, MONITOR_DEFAULTTONEAREST));
end;

function GetMonitorWorkArea(const AMonitor: Integer): TRect;
var
  Info: TMonitorInfo;
begin
  if AMonitor = 0 then
    Result := Screen.WorkAreaRect
  else
  begin
    Info.cbSize := SizeOf(Info);
    GetMonitorInfo(AMonitor, @Info);
    Result := Info.rcWork;
  end;
end;

function GetMouseCursorPos: TPoint;
begin
  if not Windows.GetCursorPos(Result) then
    Result := cxInvalidPoint;
end;

function GetPointPosition(const ARect: TRect; const P: TPoint;
  AHorzSeparation, AVertSeparation: Boolean): TcxPosition;
const
  Positions: array[Boolean, Boolean] of TcxPosition =
    ((posBottom, posRight), (posLeft, posTop));
type
  TCorner = (BottomLeft, TopLeft, TopRight, BottomRight);

  function GetCornerCoords(ACorner: TCorner): TPoint;
  begin
    case ACorner of
      BottomLeft:
        Result := Point(ARect.Left, ARect.Bottom);
      TopLeft:
        Result := ARect.TopLeft;
      TopRight:
        Result := Point(ARect.Right, ARect.Top);
      BottomRight:
        Result := ARect.BottomRight;
    end;
  end;

  function GetSign(const P1, P2, P: TPoint): Integer;
  begin
    Result := (P.X - P1.X) * (P2.Y - P1.Y) - (P.Y - P1.Y) * (P2.X - P1.X);
  end;

var
  ASign1, ASign2: Integer;
begin
  if AHorzSeparation and AVertSeparation then
  begin
    ASign1 := GetSign(GetCornerCoords(BottomLeft), GetCornerCoords(TopRight), P);
    ASign2 := GetSign(GetCornerCoords(TopLeft), GetCornerCoords(BottomRight), P);
    Result := Positions[ASign1 >= 0, ASign2 >= 0];
  end
  else
    if AHorzSeparation then
      if P.X < GetRangeCenter(ARect.Left, ARect.Right) then
        Result := posLeft
      else
        Result := posRight
    else
      if AVertSeparation then
        if P.Y < GetRangeCenter(ARect.Top, ARect.Bottom) then
          Result := posTop
        else
          Result := posBottom
      else
        Result := posNone;
end;

function cxShiftStateMoveOnly(const AShift: TShiftState): Boolean;
begin
  Result := AShift * [ssShift, ssAlt, ssCtrl, ssLeft, ssRight, ssMiddle, ssDouble] = [];
end;

function cxShiftStateLeftOnly(AShift: TShiftState; ACanIncludeDoubleClick: Boolean = False): Boolean;
begin
  Result := (ssLeft in AShift) and
    (AShift * [ssShift, ssAlt, ssCtrl, ssRight, ssMiddle] = []) and
    (ACanIncludeDoubleClick or not (ssDouble in AShift));
end;

function IsChildClassWindow(AWnd: HWND): Boolean;
begin
  Result := GetWindowLong(AWnd, GWL_STYLE) and WS_CHILD = WS_CHILD;
end;

function IsChildEx(AParentWnd, AWnd: HWND): Boolean;
begin
  Result := (AParentWnd <> 0) and ((AParentWnd = AWnd) or IsChild(AParentWnd, AWnd));
end;

function FormStyle(AForm: TCustomForm): TFormStyle;
begin
  Result := TCustomFormAccess(AForm).FormStyle;
end;

function IsMDIChild(AForm: TCustomForm): Boolean;
begin
  Result := (AForm <> nil) and not (csDesigning in AForm.ComponentState) and
    (FormStyle(AForm) = fsMDIChild);
end;

function IsMDIForm(AForm: TCustomForm): Boolean;
begin
  Result := (AForm <> nil) and not (csDesigning in AForm.ComponentState) and
    (FormStyle(AForm) = fsMDIForm);
end;

function IsCtrlPressed: Boolean;
begin
  Result := GetAsyncKeyState(VK_CONTROL) < 0;
end;

function IsEditStartChar(C: Char): Boolean;
begin
  Result := IsTextChar(C) or (C = #8) or (C = ^V) or (C = ^X);
end;

function IsIncSearchStartChar(C: Char): Boolean;
begin
  Result := IsTextChar(C) or (C = #8);
end;

function IsOwner(AOwnerWnd, AWnd: HWND): Boolean;
begin
  if AOwnerWnd <> 0 then
    repeat
      AWnd := GetParent(AWnd);
      Result := AWnd = AOwnerWnd;
    until Result or (AWnd = 0)
  else
    Result := False;
end;

function IsOwnerEx(AOwnerWnd, AWnd: HWND): Boolean;
begin
  Result := (AOwnerWnd <> 0) and ((AOwnerWnd = AWnd) or IsOwner(AOwnerWnd, AWnd));
end;

function IsWindowEnabledEx(AWindowHandle: HWND): Boolean;
begin
  Result := IsWindowEnabled(AWindowHandle);
  if IsChildClassWindow(AWindowHandle) then
    Result := Result and IsWindowEnabledEx(GetParent(AWindowHandle))
end;

function IsControlVisible(AControl: TWinControl): Boolean;
begin
  Result := (AControl <> nil) and AControl.HandleAllocated and IsWindowVisible(AControl.Handle);
end;

function cxFindVCLControl(AWnd: HWND): TWinControl;
begin
  Result := nil;
  while (Result = nil) and (AWnd <> 0) do
  begin
    Result := FindControl(AWnd);
    AWnd := GetAncestor(AWnd, GA_PARENT);
  end;
end;

function cxFindComponent(AParentComponent: TComponent; AClass: TClass): TComponent;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to AParentComponent.ComponentCount - 1 do
    if AParentComponent.Components[I] is AClass then
    begin
      Result := AParentComponent.Components[I];
      Break;
    end;
end;

{$IFDEF DELPHI10}
function cxClientToParent(AControl: TControl; const P: TPoint;
  AParent: TWinControl): TPoint;
begin
  Result := AControl.ClientToParent(P, AParent);
end;

function cxParentToClient(AControl: TControl; const P: TPoint;
  AParent: TWinControl): TPoint;
begin
  Result := AControl.ParentToClient(P, AParent);
end;
{$ELSE}
function cxClientToParent(AControl: TControl; const P: TPoint;
  AParent: TWinControl): TPoint;
var
  LParent: TWinControl;
begin
  if AParent = nil then
    AParent := AControl.Parent;
  if AParent = nil then
    raise EInvalidOperation.CreateFmt(SParentRequired, [AControl.Name]);
  Result := P;
  Inc(Result.X, AControl.Left);
  Inc(Result.Y, AControl.Top);
  LParent := AControl.Parent;
  while (LParent <> nil) and (LParent <> AParent) do
  begin
    if LParent.Parent <> nil then
    begin
      Inc(Result.X, LParent.Left);
      Inc(Result.Y, LParent.Top);
    end;
    LParent := LParent.Parent;
  end;
  if LParent = nil then
    raise EInvalidOperation.CreateFmt(SParentGivenNotAParent, [AControl.Name]);
end;

function cxParentToClient(AControl: TControl; const P: TPoint;
  AParent: TWinControl): TPoint;
var
  LParent: TWinControl;
begin
  if AParent = nil then
    AParent := AControl.Parent;
  if AParent = nil then
    raise EInvalidOperation.CreateFmt(SParentRequired, [AControl.Name]);
  Result := P;
  Dec(Result.X, AControl.Left);
  Dec(Result.Y, AControl.Top);
  LParent := AControl.Parent;
  while (LParent <> nil) and (LParent <> AParent) do
  begin
    if LParent.Parent <> nil then
    begin
      Dec(Result.X, LParent.Left);
      Dec(Result.Y, LParent.Top);
    end;
    LParent := LParent.Parent;
  end;
  if LParent = nil then
    raise EInvalidOperation.CreateFmt(SParentGivenNotAParent, [AControl.Name]);
end;
{$ENDIF}

function dxFindParentControl(AHandle: THandle): TWinControl;
begin
  repeat
    Result := FindControl(AHandle);
    if Result <> nil then
      Break;
    AHandle := GetAncestor(AHandle, GA_PARENT);
  until AHandle = 0;
end;

function dxGetParentForm(AHandle: THandle): TCustomForm;
var
  AControl: TWinControl;
begin
  AControl := dxFindParentControl(AHandle);
  if AControl <> nil then
    Result := GetParentForm(AControl)
  else
    Result := nil;
end;

procedure dxPerformMessageByQueue(AControl: TControl; AMessage: Cardinal);
begin
  while AControl <> nil do
  begin
    AControl.Perform(AMessage, 0, 0);
    AControl := AControl.Parent;
    if AControl is TCustomForm then
      Break;
  end;
end;

function IsPointInDragDetectArea(const AMouseDownPos: TPoint; X, Y: Integer): Boolean;
begin
  Result :=
    (Abs(X - AMouseDownPos.X) < Mouse.DragThreshold) and
    (Abs(Y - AMouseDownPos.Y) < Mouse.DragThreshold);
end;

function IsNumericChar(C: Char; AType: TcxNumberType): Boolean;
begin
{$IFDEF DELPHI12}
  Result := (C = '-') or (C = '+') or
    (dxGetWideCharCType1(C) and C1_DIGIT > 0);
{$ELSE}
  Result := C in ['-', '+', '0'..'9'];
{$ENDIF}
  if AType in [ntFloat, ntExponent] then
  begin
    Result := Result or (C = dxFormatSettings.DecimalSeparator);
    if AType = ntExponent then
      Result := Result or (C = 'e') or (C = 'E');
  end;
end;

function IsSysKey(AKey: Word): Boolean;
begin
  Result := AKey in [VK_CANCEL, 
    VK_TAB, VK_CLEAR, VK_RETURN, VK_SHIFT, VK_CONTROL,
    VK_MENU, VK_PAUSE, VK_CAPITAL, VK_ESCAPE, VK_PRIOR..VK_HELP,
    VK_LWIN..VK_SCROLL, VK_LSHIFT..VK_RMENU, VK_PROCESSKEY, VK_ATTN..VK_OEM_CLEAR];
end;

function IsTextChar(C: Char): Boolean;
begin
{$IFDEF DELPHI12}
  Result := not (dxGetWideCharCType1(C) and C1_CNTRL > 0);
{$ELSE}
  Result := C in [#32..#255];
{$ENDIF}
end;

procedure MakeVisibleOnDesktop(var ABounds: TRect; const ADesktopPoint: TPoint);
var
  ADesktopBounds: TRect;
begin
  ADesktopBounds := GetDesktopWorkArea(ADesktopPoint);
  if ABounds.Right > ADesktopBounds.Right then
    Offsetrect(ABounds, ADesktopBounds.Right - ABounds.Right, 0);
  if ABounds.Bottom > ADesktopBounds.Bottom then
    OffsetRect(ABounds, 0, ADesktopBounds.Bottom - ABounds.Bottom);
  if ABounds.Left < ADesktopBounds.Left then
    OffsetRect(ABounds, ADesktopBounds.Left - ABounds.Left, 0);
  if ABounds.Top < ADesktopBounds.Top then
    OffsetRect(ABounds, 0, ADesktopBounds.Top - ABounds.Top);
end;

procedure MakeVisibleOnDesktop(AControl: TControl);
var
  ABounds: TRect;
begin
  ABounds := AControl.BoundsRect;
  MakeVisibleOnDesktop(ABounds, ABounds.TopLeft);
  AControl.BoundsRect := ABounds;
end;

function dxMapWindowPoint(AHandleFrom, AHandleTo: TcxHandle; const P: TPoint; AClient: Boolean = True): TPoint;
var
  AWindowRectFrom, AWindowRectTo: TRect;
begin
  Result := P;
  if AClient then
    MapWindowPoints(AHandleFrom, AHandleTo, Result, 1)
  else
  begin
    AWindowRectFrom := cxGetWindowRect(AHandleFrom);
    AWindowRectTo := cxGetWindowRect(AHandleTo);
    Result := cxPointOffset(Result, AWindowRectFrom.TopLeft);
    Result := cxPointOffset(Result, AWindowRectTo.TopLeft, False);
  end;
end;

function dxMapWindowRect(AHandleFrom, AHandleTo: TcxHandle; const R: TRect; AClient: Boolean): TRect;
begin
  Result := cxRectSetOrigin(R, dxMapWindowPoint(AHandleFrom, AHandleTo, R.TopLeft, AClient));
end;

procedure cxRecreateControlWnd(AControl: TWinControl; APostponed: Boolean = False);
begin
  if AControl.HandleAllocated then
    if APostponed then
      PostMessage(AControl.Handle, CM_RECREATEWND, 0, 0)
    else
      AControl.Perform(CM_RECREATEWND, 0, 0);
end;

function cxClientToScreen(AHandle: THandle; const APoint: TPoint): TPoint;
begin
  Result := APoint;
  ClientToScreen(AHandle, Result);
end;

function cxGetClientRect(AHandle: THandle): TRect;
begin
  if not GetClientRect(AHandle, Result) then
    Result := cxEmptyRect;
end;

function cxGetClientOffset(AHandle: THandle): TPoint;
var
  R: TRect;
begin
  R := cxGetWindowRect(AHandle);
  Result:= cxPointOffset(cxClientToScreen(AHandle, cxNullPoint), R.TopLeft, False);
end;

function cxGetClientRect(AControl: TWinControl): TRect;
begin
  if not AControl.HandleAllocated or not GetClientRect(AControl.Handle, Result) then
    Result := cxEmptyRect;
end;

function cxGetWindowRect(AHandle: THandle): TRect;
begin
  if not GetWindowRect(AHandle, Result) then
    Result := cxEmptyRect;
end;

function cxGetWindowText(AHandle: THandle): string;
var
  ABuffer: array[0..1023] of Char;
begin
  FillChar(ABuffer, SizeOf(ABuffer), 0);
  if GetWindowText(AHandle, PChar(@ABuffer[0]), Length(ABuffer)) > 0 then
    Result := ABuffer
  else
    Result := '';
end;

function cxGetWindowRect(AControl: TWinControl): TRect;
begin
  if AControl.HandleAllocated then
    Result := cxGetWindowRect(AControl.Handle)
  else
    Result := cxEmptyRect;
end;

function cxGetWindowBounds(AControl: TWinControl): TRect;
begin
  Result := cxGetWindowBounds(AControl.Handle);
end;

function cxGetWindowBounds(AHandle: THandle): TRect;
begin
  Result := cxGetWindowRect(AHandle);
  Result := cxRectSetNullOrigin(Result);
end;

function cxWindowFromPoint(P: TPoint): HWND;

  function FindOne(Wnd: HWND; P: TPoint): HWND;
  begin
    Result := ChildWindowFromPointEx(Wnd, P, CWP_SKIPINVISIBLE);
    if Result = 0 then
      Result := Wnd
    else
      if Result <> Wnd then
        Result := FindOne(Result, dxMapWindowPoint(Wnd, Result, P));
  end;

begin
  Result := WindowFromPoint(P);
  if Result <> 0 then
  begin
    ScreenToClient(Result, P);
    Result := FindOne(Result, P);
  end;
end;

procedure dxSetZOrder(AHandle: THandle; AWndAfter: THandle; AActivate: Boolean; AFlags: DWORD);
const
  AActivateMap: array[Boolean] of Byte = (SWP_NOACTIVATE, 0);
begin
  SetWindowPos(AHandle, AWndAfter, 0, 0, 0, 0,
    SWP_NOMOVE or SWP_NOSIZE or AActivateMap[AActivate] or AFlags);
end;

function cxLoadSysMenu(AMenuType: TcxSystemMenuType): THandle;
const
  ID_SYSMENU       = $10;
  ID_CLOSEMENU     = $20;
  CHILDSYSMENU     = ID_CLOSEMENU;
  ID_DIALOGSYSMENU = $30;
  MenuTypes: array[TcxSystemMenuType] of UINT = (ID_SYSMENU, CHILDSYSMENU, ID_DIALOGSYSMENU);
var
  AMenuInfo: TMenuInfo;
  AMenuItemInfo: TMenuItemInfo;
begin
  Result := LoadMenu(GetModuleHandle(user32), MAKEINTRESOURCE(MenuTypes[AMenuType]));
  if Result = 0 then
    Exit;
  //Add the check or bmp style. (draw bitmaps and checkmarks on the same column)
  AMenuInfo.cbSize := sizeof(AMenuInfo);
  AMenuInfo.fMask  := MIM_STYLE or MIM_APPLYTOSUBMENUS;
  AMenuInfo.dwStyle := MNS_CHECKORBMP;
  SetMenuInfo(Result, AMenuInfo);
  // Add the bitmaps for close, minimize, maximize and restore items.
  if not IsWin95 then
    AMenuItemInfo.cbSize := SizeOf(AMenuItemInfo)
  else
  begin
    AMenuItemInfo.cbSize := 44;
    AMenuItemInfo.hbmpItem := 0;
  end;
  AMenuItemInfo.fMask := MIIM_BITMAP;
  AMenuItemInfo.hbmpItem := HBMMENU_POPUP_CLOSE;
  SetMenuItemInfo(Result, SC_CLOSE, False, AMenuItemInfo);
  if AMenuType <> smDialog then
  begin
    AMenuItemInfo.hbmpItem := HBMMENU_POPUP_MINIMIZE;
    SetMenuItemInfo(Result, SC_MINIMIZE, False, AMenuItemInfo);
    AMenuItemInfo.hbmpItem := HBMMENU_POPUP_MAXIMIZE;
    SetMenuItemInfo(Result, SC_MAXIMIZE, False, AMenuItemInfo);
    AMenuItemInfo.hbmpItem := HBMMENU_POPUP_RESTORE;
    SetMenuItemInfo(Result, SC_RESTORE, False, AMenuItemInfo);
  end;
end;

function IsSmallerThanScreen(AWnd: THandle): Boolean;
var
  dxMax, dyMax: Integer;
  AMonitor: HMONITOR;
  AWorkArea, AWindowRect: TRect;
begin
  AMonitor  := MonitorFromWindow(AWnd, MONITOR_DEFAULTTOPRIMARY);
  AWorkArea := GetMonitorWorkArea(AMonitor);
  dxMax := AWorkArea.Right - AWorkArea.Left;
  dyMax := AWorkArea.Bottom - AWorkArea.Top;
  GetWindowRect(AWnd, AWindowRect);
  Result := (AWindowRect.Right - AWindowRect.Left < dxMax) or
    (AWindowRect.Bottom - AWindowRect.Top < dyMax);
end;

procedure SetupSystemMenuItems(AWnd: THandle; AMenu: THandle = 0);
var
  ASize, AMinimize, AMaximize, AMove, ARestore, ADefault: UINT;
  AStyles: Integer;

  function TestWF(AFlag: Integer): Boolean;
  begin
    Result := AStyles and AFlag = AFlag;
  end;

begin
  AStyles := GetWindowLong(AWnd, GWL_STYLE);
  ASize := 0;
  AMaximize := 0;
  AMinimize := 0;
  AMove := 0;
  ARestore := MFS_GRAYED;
  ADefault := SC_CLOSE;
  // Minimized state: no minimize, restore.
  if IsIconic(AWnd) then
  begin
    ARestore  := 0;
    AMinimize := MFS_GRAYED;
    ASize     := MFS_GRAYED;
    ADefault  := SC_RESTORE;
  end
  else
    if not TestWF(WS_MINIMIZEBOX) then
       AMinimize := MFS_GRAYED;
  // Maximized state: no maximize, restore.
  if not TestWF(WS_MAXIMIZEBOX)  then
    AMaximize := MFS_GRAYED
  else
    if IsZoomed(AWnd) then
    begin
      ARestore := 0;
      AMove := MFS_GRAYED;
      if not TestWF(WS_CHILD) and IsSmallerThanScreen(AWnd) then
        AMove := 0;
      ASize     := MFS_GRAYED;
      AMaximize := MFS_GRAYED;
    end;
  if not TestWF(WS_SIZEBOX) then
    ASize := MFS_GRAYED;
  // Update menuitems
  EnableMenuItem(AMenu, SC_SIZE, ASize or MF_BYCOMMAND);
  EnableMenuItem(AMenu, SC_MINIMIZE, AMinimize or MF_BYCOMMAND);
  EnableMenuItem(AMenu, SC_MAXIMIZE, AMaximize or MF_BYCOMMAND);
  EnableMenuItem(AMenu, SC_RESTORE, ARestore or MF_BYCOMMAND);
  EnableMenuItem(AMenu, SC_MOVE, AMove or MF_BYCOMMAND);
  SetMenuDefaultItem(AMenu, ADefault, MF_BYCOMMAND);
end;

procedure cxModifySystemMenu(ASysMenu, AWindowHandle: THandle;
  AIsDialog: Boolean; ABorderIcons: TBorderIcons; AWindowState: TWindowState;
  ALockRepaint: Boolean = True);
begin
  if biSystemMenu in ABorderIcons then
  try
    if ALockRepaint then
      LockWindowUpdate(AWindowHandle);
    if AIsDialog then
    begin
      DeleteMenu(ASysMenu, SC_TASKLIST, MF_BYCOMMAND);
      DeleteMenu(ASysMenu, 7, MF_BYPOSITION);
      DeleteMenu(ASysMenu, 5, MF_BYPOSITION);
      DeleteMenu(ASysMenu, SC_MAXIMIZE, MF_BYCOMMAND);
      DeleteMenu(ASysMenu, SC_MINIMIZE, MF_BYCOMMAND);
      DeleteMenu(ASysMenu, SC_SIZE, MF_BYCOMMAND);
      DeleteMenu(ASysMenu, SC_RESTORE, MF_BYCOMMAND);
    end;
    SetupSystemMenuItems(AWindowHandle, ASysMenu);
  finally
    if ALockRepaint then
      LockWindowUpdate(0);
  end;
end;

procedure cxMoveMenuItems(ASource, ADest: THandle);
const
  dxItemInfoMaskGeneral = MIIM_CHECKMARKS or MIIM_ID or MIIM_STATE or
    MIIM_SUBMENU or MIIM_TYPE or MIIM_DATA;
var
  I: Integer;
  ABuffer: array[0..511] of Char;
  AItemID: UINT;
  AMenuItemInfo: TMenuItemInfo;

  procedure InitItemInfo(AMask: UINT);
  begin
    FillChar(AMenuItemInfo, SIzeOf(AMenuItemInfo), 0);
    if not IsWin95 then
      AMenuItemInfo.cbSize := SizeOf(AMenuItemInfo)
    else
      AMenuItemInfo.cbSize := 44;
    AMenuItemInfo.dwTypeData := ABuffer;
    AMenuItemInfo.cch := 512;
    AMenuItemInfo.fMask := AMask;
  end;

  procedure SetItemInfo(ASourceItemIndex, ADestItem: Integer; AByPos: Boolean; AMask: UINT);
  begin
    InitItemInfo(AMask);
    GetMenuItemInfo(ASource, ASourceItemIndex, True, AMenuItemInfo);
    SetMenuItemInfo(ADest, ADestItem, AByPos, AMenuItemInfo);
  end;

begin
  if (ASource = ADest) or not (IsMenu(ASource) and IsMenu(ADest)) then
    Exit;
  for I := GetMenuItemCount(ADest) - 1 downto 0 do
  begin
    AItemID := GetMenuItemID(ADest, I);
    DeleteMenu(ADest, AItemID, MF_BYCOMMAND);
  end;
  for I := 0 to GetMenuItemCount(ASource) - 1 do
  begin
    InitItemInfo(dxItemInfoMaskGeneral);
    GetMenuItemInfo(ASource, I, True, AMenuItemInfo);
    InsertMenuItem(ADest, I, True, AMenuItemInfo);
    SetItemInfo(I, I, True, MIIM_STRING);
    if not IsWin95 then
      SetItemInfo(I, I, True, MIIM_BITMAP);
  end;
  // some magic for aero
  EnableMenuItem(ADest, SC_CLOSE, MF_BYCOMMAND or MF_GRAYED);
  EnableMenuItem(ADest, SC_CLOSE, MF_BYCOMMAND or MF_ENABLED);
end;

function RemoveAccelChars(const S: AnsiString;
  AAppendTerminatingUnderscore: Boolean = True): AnsiString;
var
  ALastIndex, I: Integer;
begin
  Result := '';
  I := 1;
  ALastIndex := Length(S);
  while I <= ALastIndex do
  begin
    if S[I] = '&' then
      if (I < ALastIndex) or not AAppendTerminatingUnderscore then
        Inc(I)
      else
      begin
        Result := Result + '_';
        Break;
      end;
    Result := Result + S[I];
    Inc(I);
  end;
end;

function RemoveAccelChars(const S: WideString;
  AAppendTerminatingUnderscore: Boolean = True): WideString;
var
  ALastIndex, I: Integer;
begin
  Result := '';
  I := 1;
  ALastIndex := Length(S);
  while I <= ALastIndex do
  begin
    if S[I] = '&' then
      if (I < ALastIndex) or not AAppendTerminatingUnderscore then
        Inc(I)
      else
      begin
        Result := Result + '_';
        Break;
      end;
    Result := Result + S[I];
    Inc(I);
  end;
end;

procedure SetDesignerModified(AComponent: TComponent);

  function IsValidComponentState(AComponent: TComponent): Boolean;
  begin
    Result := AComponent.ComponentState * [csLoading, csWriting, csDestroying] = [];
  end;

  function CanSetModified(AControl: TControl): Boolean;
  begin
    Result := IsValidComponentState(AControl) and ((AControl.Parent = nil) or CanSetModified(AControl.Parent));
  end;

  function IsDesigning: Boolean;
  begin
    Result := ((AComponent is TcxControl) and (AComponent as TcxControl).IsDesigning) or
      (not (AComponent is TcxControl) and (csDesigning in AComponent.ComponentState));
  end;

var
  ADesigner: IDesignerNotify;
begin
  if not IsDesigning or not IsValidComponentState(AComponent) or
      ((AComponent is TControl) and not CanSetModified(AComponent as TControl)) then
    Exit;
  ADesigner := FindRootDesigner(AComponent);
  if ADesigner <> nil then
    ADesigner.Modified;
end;

function cxGetFullComponentName(AComponent: TComponent): string;
begin
  Result := AComponent.Name;
  while (AComponent.Name <> '') and (AComponent.Owner <> nil) do
  begin
    AComponent := AComponent.Owner;
    if AComponent.Name <> '' then
      Result := AComponent.Name + '.' + Result;
  end;
{
  if AComponent = nil then
    Result := ''
  else
    if (AComponent.Owner = nil) or  then
      Result := AComponent.Name
    else
      Result := cxGetFullComponentName(AComponent.Owner) + '.' + AComponent.Name;
      }
end;

procedure cxReleaseForm(var AForm);
var
  ATempForm: TCustomForm;
begin
  ATempForm := TObject(AForm) as TCustomForm;
  if ATempForm.HandleAllocated then
    ATempForm.Release
  else
    ATempForm.Free;
  TCustomForm(AForm) := nil;
end;

function ShiftStateToKeys(AShift: TShiftState): WORD;
begin
  Result := 0;
  if ssShift in AShift then Inc(Result, MK_SHIFT);
  if ssCtrl in AShift then Inc(Result, MK_CONTROL);
  if ssLeft in AShift then Inc(Result, MK_LBUTTON);
  if ssRight in AShift then Inc(Result, MK_RBUTTON);
  if ssMiddle in AShift then Inc(Result, MK_MBUTTON);
end;

function TranslateKey(Key: Word): Word;
begin
  Result := Key;
end;

{ mouse tracking }

var
  FMouseTrackingTimerList: TList;

function MouseTrackingTimerList: TList;
begin
  if not FUnitIsFinalized and (FMouseTrackingTimerList = nil) then
    FMouseTrackingTimerList := TList.Create;
  Result := FMouseTrackingTimerList;
end;

type
  TMouseTrackingTimer = class(TcxTimer)
  protected
    procedure TimerHandler(Sender: TObject);
  public
    Caller: IcxMouseTrackingCaller;
    Control: TWinControl;
    Bounds: TRect;
    constructor Create(AOwner: TComponent); override;
  end;

constructor TMouseTrackingTimer.Create(AOwner: TComponent);
begin
  inherited;
  Interval := 10;
  OnTimer := TimerHandler;
end;

procedure TMouseTrackingTimer.TimerHandler(Sender: TObject);

  function IsParentFormDisabled: Boolean;
  begin
    Result := not (Control.HandleAllocated and IsWindowEnabledEx(Control.Handle));
  end;

  function IsPointInControl: Boolean;
  begin
    Result := PtInRect(Control.ClientRect, Control.ScreenToClient(GetMouseCursorPos));
  end;

  function IsMouseCursorInOverlaidWindow(const APoint: TPoint): Boolean;
  begin
    Result := (Control <> nil) and Control.HandleAllocated and
      not IsChildEx(Control.Handle, cxWindowFromPoint(APoint)) and
       (GetCapture <> Control.Handle);
  end;

  function PtInCaller: Boolean;
  var
    ACaller2: IcxMouseTrackingCaller2;
    APoint: TPoint;
  begin
    APoint := GetMouseCursorPos;
    if IsMouseCursorInOverlaidWindow(APoint) then
      Result := False
    else
      if not Supports(Caller, IcxMouseTrackingCaller2, ACaller2) then
        Result := PtInRect(Bounds, APoint)
      else
        if Control <> nil then
          Result := Control.HandleAllocated and ACaller2.PtInCaller(Control.ScreenToClient(APoint))
        else
          Result := ACaller2.PtInCaller(APoint);
  end;

var
  ACaller: IcxMouseTrackingCaller;
  AControl: TWinControl;
begin
  if not PtInCaller or (Control <> nil) and IsParentFormDisabled then
  begin
    ACaller := Caller;   
    AControl := Control; 
    if (AControl <> nil) and AControl.HandleAllocated and (not IsPointInControl or IsParentFormDisabled) then
      SendMessage(AControl.Handle, CM_MOUSELEAVE, 0, LPARAM(AControl));
    if (ACaller <> nil) and ((AControl = nil) or AControl.HandleAllocated) then
      ACaller.MouseLeave;
    EndMouseTracking(ACaller);
  end;
end;

procedure BeginMouseTracking(AControl: TWinControl; const ABounds: TRect;
  ACaller: IcxMouseTrackingCaller);
var
  ATimer: TMouseTrackingTimer;
begin
  if FUnitIsFinalized or IsMouseTracking(ACaller) then Exit;
  ATimer := TMouseTrackingTimer.Create(nil);
  ATimer.Control := AControl;
  ATimer.Bounds := ABounds;
  if ATimer.Control <> nil then
    ATimer.Bounds := dxMapWindowRect(ATimer.Control.Handle, ScreenHandle, ATimer.Bounds);
  ATimer.Caller := ACaller;
  MouseTrackingTimerList.Add(ATimer);
end;

function GetMouseTrackingTimer(ACaller: IcxMouseTrackingCaller): TMouseTrackingTimer;
var
  I: Integer;
begin
  if not FUnitIsFinalized then
  begin
    for I := 0 to MouseTrackingTimerList.Count - 1 do
    begin
      Result := TMouseTrackingTimer(MouseTrackingTimerList[I]);
      if Result.Caller = ACaller then Exit;
    end;
  end;
  Result := nil;
end;

procedure EndMouseTracking(ACaller: IcxMouseTrackingCaller);
var
  ATimer: TMouseTrackingTimer;
begin
  ATimer := GetMouseTrackingTimer(ACaller);
  if ATimer <> nil then
  begin
    MouseTrackingTimerList.Remove(ATimer);
    ATimer.Free;
  end;
end;

{ hourglass cursor showing }

var
  FPrevScreenCursor: TCursor;
  FHourglassCursorUseCount: Integer;

function IsMouseTracking(ACaller: IcxMouseTrackingCaller): Boolean;
begin
  Result := not FUnitIsFinalized and (GetMouseTrackingTimer(ACaller) <> nil);
end;

procedure HideHourglassCursor;
begin
  if FHourglassCursorUseCount <> 0 then
  begin
    Dec(FHourglassCursorUseCount);
    if FHourglassCursorUseCount = 0 then
      Screen.Cursor := FPrevScreenCursor;
  end;
end;

procedure ShowHourglassCursor;
begin
  if FHourglassCursorUseCount = 0 then
  begin
    FPrevScreenCursor := Screen.Cursor;
    Screen.Cursor := crHourglass;
  end;
  Inc(FHourglassCursorUseCount);
end;

{ popup menu routines }

function GetPopupMenuHeight(APopupMenu: TPopupMenu): Integer;

  function IsOwnerDrawItem(AMenuItem: TMenuItem): Boolean;
  begin
    Result := APopupMenu.OwnerDraw or (AMenuItem.GetImageList <> nil) or
      not AMenuItem.Bitmap.Empty;
  end;

const
  AMenuItemHeightCorrection = 4;
  APopupMenuHeightCorrection = 4;
var
  ACanvas: TcxScreenCanvas;
  AMenuItemDefaultHeight, AMenuItemHeight, AMenuItemWidth, AMenuColumnHeight, I: Integer;
  AMenuItem: TMenuItem;
begin
  ACanvas := TcxScreenCanvas.Create;
  try
    ACanvas.Font.Assign(Screen.MenuFont);
    AMenuItemDefaultHeight := ACanvas.TextHeight('Qg') + AMenuItemHeightCorrection;
    AMenuColumnHeight := 0;
    Result := 0;
    for I := 0 to APopupMenu.Items.Count - 1 do
    begin
      AMenuItem := APopupMenu.Items[I];
      if AMenuItem.Visible then
      begin
        AMenuItemHeight := AMenuItemDefaultHeight;
        if IsOwnerDrawItem(AMenuItem) then
          TMenuItemAccess(AMenuItem).MeasureItem(ACanvas.Canvas,
            AMenuItemWidth, AMenuItemHeight);
        if AMenuItem.Break <> mbNone then
        begin
          Result := Max(AMenuColumnHeight, Result);
          AMenuColumnHeight := 0;
        end;
        Inc(AMenuColumnHeight, AMenuItemHeight);
      end;
    end;
    Result := Max(AMenuColumnHeight, Result);
    Inc(Result, APopupMenuHeightCorrection);
  finally
    ACanvas.Free;
  end;
end;

function IsPopupMenu(APopupMenu: TComponent): Boolean;
begin
  Result := (APopupMenu is TPopupMenu) or Supports(APopupMenu, IcxPopupMenu);
end;

function IsPopupMenuShortCut(APopupMenu: TComponent; var Message: TWMKey): Boolean;
var
  AIcxPopupMenu: IcxPopupMenu;
begin
  if Supports(APopupMenu, IcxPopupMenu, AIcxPopupMenu) then
    Result := AIcxPopupMenu.IsShortCutKey(Message)
  else
    Result := (APopupMenu is TPopupMenu) and (TPopupMenu(APopupMenu).WindowHandle <> 0) and
      TPopupMenu(APopupMenu).IsShortCut(Message);
end;

function ShowPopupMenu(ACaller, APopupMenu: TComponent; const P: TPoint): Boolean;
begin
  Result := ShowPopupMenu(ACaller, APopupMenu, P.X, P.Y);
end;

function ShowPopupMenu(ACaller, APopupMenu: TComponent; X, Y: Integer): Boolean;
var
  AIcxPopupMenu: IcxPopupMenu;
  AStdPopupMenu: TPopupMenu;
begin
  Result := True;
  if Supports(APopupMenu, IcxPopupMenu, AIcxPopupMenu) then
    AIcxPopupMenu.Popup(X, Y)
  else
    if (APopupMenu is TPopupMenu) and TPopupMenu(APopupMenu).AutoPopup then
    begin
      AStdPopupMenu := TPopupMenu(APopupMenu);
      AStdPopupMenu.PopupComponent := ACaller;
      AStdPopupMenu.Popup(X, Y);
    end
    else
      Result := False;
end;

function ShowPopupMenu(ACaller, APopupMenu: TComponent;
  const AOwnerBounds: TRect; APopupAlignment: TPopupAlignment): Boolean;

  function GetPopupPoint: TPoint;
  begin
    Result := cxPoint(AOwnerBounds.Left, AOwnerBounds.Bottom);
    case APopupAlignment of
      paRight:
        Inc(Result.X, cxRectWidth(AOwnerBounds));
      paCenter:
        Inc(Result.X, cxRectWidth(AOwnerBounds) div 2);
    end;
  end;

  procedure CheckPopupMenuPosition(APopupMenu: TPopupMenu; var P: TPoint);
  var
    AMenuHeight: Integer;
  begin
    AMenuHeight := GetPopupMenuHeight(APopupMenu);
    if P.Y + AMenuHeight > GetDesktopWorkArea(P).Bottom then
      Dec(P.Y, cxRectHeight(AOwnerBounds) + AMenuHeight + 2);
  end;

  procedure CheckPopupAlignment(var APopupAlignment: TPopupAlignment; const P: TPoint);
  var
    ADesktopWorkArea: TRect;
  begin
    ADesktopWorkArea := GetDesktopWorkArea(P);
    if P.X <= ADesktopWorkArea.Left then
      APopupAlignment := paRight
    else
      if P.X >= ADesktopWorkArea.Right then
        APopupAlignment := paLeft;
  end;

var
  AIcxPopupMenu: IcxPopupMenu2;
  AStdPopupMenu: TPopupMenu;
  APoint: TPoint;
  APrevPopupAlignment: TPopupAlignment;
begin
  Result := True;
  APoint := GetPopupPoint;
  if Supports(APopupMenu, IcxPopupMenu2, AIcxPopupMenu) then
    AIcxPopupMenu.Popup(APoint.X, APoint.Y, AOwnerBounds, APopupAlignment)
  else
    if (APopupMenu is TPopupMenu) and TPopupMenu(APopupMenu).AutoPopup then
    begin
      AStdPopupMenu := TPopupMenu(APopupMenu);
      APrevPopupAlignment := AStdPopupMenu.Alignment;
      try
        CheckPopupMenuPosition(AStdPopupMenu, APoint);
        CheckPopupAlignment(APopupAlignment, APoint);
        AStdPopupMenu.Alignment := APopupAlignment;
        AStdPopupMenu.PopupComponent := ACaller;
        AStdPopupMenu.Popup(APoint.X, APoint.Y);
      finally
        AStdPopupMenu.Alignment := APrevPopupAlignment;
      end;
    end
    else
      Result := False;
end;

function ShowPopupMenuFromCursorPos(ACaller, AComponent: TComponent): Boolean;
begin
  Result := ShowPopupMenu(ACaller, AComponent, GetMouseCursorPos);
end;       

function cxExtractDragObjectSource(ADragObject: TObject): TObject;
begin
  if ADragObject is TcxDragControlObject then
    Result := TcxDragControlObject(ADragObject).Control
  else
    Result := ADragObject;
end;

function GetDragObject: TDragObject;
begin
  Result := FDragObject;
end;

{ drag and drop arrow }

const
  DragAndDropArrowWidth = 11;
  DragAndDropArrowHeight = 9;
  DragAndDropArrowBorderColor = clBlack;
  DragAndDropArrowColor = clLime;

function GetDragAndDropArrowBounds(const AAreaBounds, AClientRect: TRect;
  APlace: TcxArrowPlace): TRect;

  procedure CheckResult;
  begin
    if IsRectEmpty(AClientRect) then Exit;
    with AClientRect do
    begin
      Result.Left := Max(Result.Left, Left);
      Result.Right := Max(Result.Right, Left);
      Result.Left := Min(Result.Left, Right - 1);
      Result.Right := Min(Result.Right, Right - 1);

      Result.Top := Max(Result.Top, Top);
      Result.Bottom := Max(Result.Bottom, Top);
      Result.Top := Min(Result.Top, Bottom - 1);
      Result.Bottom := Min(Result.Bottom, Bottom - 1);
    end;
  end;

  procedure CalculateHorizontalArrowBounds;
  begin
    Result.Bottom := Result.Top + 1;
    InflateRect(Result, 0, DragAndDropArrowWidth div 2);
    if APlace = apLeft then
    begin
      Result.Right := Result.Left;
      Dec(Result.Left, DragAndDropArrowHeight);
    end
    else
    begin
      Result.Left := Result.Right;
      Inc(Result.Right, DragAndDropArrowHeight);
    end;
  end;

  procedure CalculateVerticalArrowBounds;
  begin
    Result.Right := Result.Left + 1;
    InflateRect(Result, DragAndDropArrowWidth div 2, 0);
    if APlace = apTop then
    begin
      Result.Bottom := Result.Top;
      Dec(Result.Top, DragAndDropArrowHeight);
    end
    else
    begin
      Result.Top := Result.Bottom;
      Inc(Result.Bottom, DragAndDropArrowHeight);
    end;
  end;

begin
  Result := AAreaBounds;
  CheckResult;
  if APlace in [apLeft, apRight] then
    CalculateHorizontalArrowBounds
  else
    CalculateVerticalArrowBounds;
end;

procedure GetDragAndDropArrowPoints(const ABounds: TRect; APlace: TcxArrowPlace;
  out P: TPointArray; AForRegion: Boolean);

  procedure CalculatePointsForLeftArrow;
  begin
    with ABounds do
    begin
      P[0] := Point(Left + 3, Top - Ord(AForRegion));
      P[1] := Point(Left + 3, Top + 3);
      P[2] := Point(Left, Top + 3);
      P[3] := Point(Left, Bottom - 4 + Ord(AForRegion));
      P[4] := Point(Left + 3, Bottom - 4 + Ord(AForRegion));
      P[5] := Point(Left + 3, Bottom - 1 + Ord(AForRegion));
      P[6] := Point(Right - 1 + Ord(AForRegion), Top + 5);
    end;
  end;

  procedure CalculatePointsForTopArrow;
  begin
    with ABounds do
    begin
      P[0] := Point(Left + 3, Top);
      P[1] := Point(Right - 4 + Ord(AForRegion), Top);
      P[2] := Point(Right - 4 + Ord(AForRegion), Top + 3);
      P[3] := Point(Right - 1 + Ord(AForRegion), Top + 3);
      P[4] := Point(Left + 5, Bottom - 1 + Ord(AForRegion));
      P[5] := Point(Left, Top + 3);
      P[6] := Point(Left + 3, Top + 3);
    end;
  end;

  procedure CalculatePointsForRightArrow;
  begin
    with ABounds do
    begin
      P[0] := Point(Right - 4 + Ord(AForRegion), Top - Ord(AForRegion));
      P[1] := Point(Right - 4 + Ord(AForRegion), Top + 3);
      P[2] := Point(Right - 1 + Ord(AForRegion), Top + 3);
      P[3] := Point(Right - 1 + Ord(AForRegion), Bottom - 4 + Ord(AForRegion));
      P[4] := Point(Right - 4 + Ord(AForRegion), Bottom - 4 + Ord(AForRegion));
      P[5] := Point(Right - 4 + Ord(AForRegion), Bottom - 1 + Ord(AForRegion));
      P[6] := Point(Left, Top + 5);
    end;
  end;

  procedure CalculatePointsForBottomArrow;
  begin
    with ABounds do
    begin
      P[0] := Point(Left + 3, Bottom - 1 + Ord(AForRegion));
      P[1] := Point(Right - 4 + Ord(AForRegion), Bottom - 1 + Ord(AForRegion));
      P[2] := Point(Right - 4 + Ord(AForRegion), Bottom - 4 + Ord(AForRegion));
      P[3] := Point(Right - 1 + Ord(AForRegion), Bottom - 4 + Ord(AForRegion));
      P[4] := Point(Left + 5, Top - Ord(AForRegion));
      P[5] := Point(Left - Ord(AForRegion), Bottom - 4 + Ord(AForRegion));
      P[6] := Point(Left + 3, Bottom - 4);
    end;
  end;

begin
  SetLength(P, 7);
  case APlace of
    apLeft:
      CalculatePointsForLeftArrow;
    apTop:
      CalculatePointsForTopArrow;
    apRight:
      CalculatePointsForRightArrow;
    apBottom:
      CalculatePointsForBottomArrow;
  end;
end;

procedure DrawDragAndDropArrow(ACanvas: TcxCanvas; const ABounds: TRect;
  APlace: TcxArrowPlace);
var
  P: TPointArray;
begin
  GetDragAndDropArrowPoints(ABounds, APlace, P, False);
  ACanvas.Brush.Color := DragAndDropArrowColor;
  ACanvas.Pen.Color := DragAndDropArrowBorderColor;
  ACanvas.Polygon(P);
end;

{ other }

procedure DialogApplyFont(ADialog: TCustomForm; AFont: TFont);

  function GetTextHeight: Integer;
  begin
    Result := cxTextHeight(ADialog.Canvas.Handle);
  end;

var
  AOldTextHeight, ANewTextHeight: Integer;
begin
  with ADialog do
  begin
    AOldTextHeight := GetTextHeight;
    Font := AFont;
    ANewTextHeight := GetTextHeight;
    TCustomFormAccess(ADialog).ScaleControls(ANewTextHeight, AOldTextHeight);
    ClientWidth := MulDiv(ClientWidth, ANewTextHeight, AOldTextHeight);
    ClientHeight := MulDiv(ClientHeight, ANewTextHeight, AOldTextHeight);
  end;
end;

function DesignController: TcxDesignController;
begin
  if (FDesignController = nil) and not FUnitIsFinalized then
    FDesignController := TcxDesignController.Create;
  Result := FDesignController;
end;

function GET_APPCOMMAND_LPARAM(lParam: LPARAM): Integer;
begin
  Result := Short(HiWord(lParam) and not FAPPCOMMAND_MASK);
end;

{ TcxControlChildComponent }

constructor TcxControlChildComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Initialize;
end;

constructor TcxControlChildComponent.CreateEx(AControl: TcxControl; AAssignOwner: Boolean = True);
begin
  //FControl := AControl;
  if AAssignOwner then
    Create(AControl.Owner)
  else
    Create(nil);
  Control := AControl;
end;

destructor TcxControlChildComponent.Destroy;
begin
  if FControl <> nil then
    FControl.RemoveChildComponent(Self);
  inherited;
end;

function TcxControlChildComponent.GetIsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

function TcxControlChildComponent.GetIsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

procedure TcxControlChildComponent.Initialize;
begin
end;

procedure TcxControlChildComponent.SetControl(Value: TcxControl);
begin
  FControl := Value;
end;

procedure TcxControlChildComponent.SetParentComponent(Value: TComponent);
begin
  inherited;
  if Value is TcxControl then
    TcxControl(Value).AddChildComponent(Self);
end;

function TcxControlChildComponent.GetParentComponent: TComponent;
begin
  Result := FControl;
end;

function TcxControlChildComponent.HasParent: Boolean;
begin
  Result := FControl <> nil;
end;

{ TcxScrollBarData }

procedure TcxScrollBarData.Validate;
begin
  FIsValid := (Max >= Min) and (Max - Min + 1 > PageSize) and (Position >= Min);
end;

{ TcxControlScrollBar }

constructor TcxControlScrollBar.Create(AOwner: TComponent);
begin
  inherited;
  Color := clBtnFace;
  ControlStyle := ControlStyle - [csFramed] + [csNoDesignVisible];
  TabStop := False;
  Visible := False;
  FData := TcxScrollBarData.Create;
  ParentShowHint := False;
  ShowHint := True;
end;

destructor TcxControlScrollBar.Destroy;
begin
  FreeAndNil(FData);
  cxClearObjectLinks(Self);
  inherited Destroy;
end;

procedure TcxControlScrollBar.ApplyData;
begin
  if FData.Visible and FData.IsValid then
  begin
    SetScrollParams(FData.Min, FData.Max, FData.Position, FData.PageSize, True);
    SmallChange := FData.SmallChange;
    LargeChange := FData.LargeChange;
  end;
  Enabled := FData.Enabled;
  if Visible <> FData.Visible then
  begin
    Visible := FData.Visible;
  {$IFDEF DELPHI11}
    Perform(CM_SHOWINGCHANGED, 0, 0);
  {$ENDIF}
  end;
end;

function TcxControlScrollBar.GetBoundsRect: TRect;
begin
  Result := inherited BoundsRect;
end;

function TcxControlScrollBar.GetControl: TcxControlScrollBar;
begin
  Result := Self;
end;

function TcxControlScrollBar.GetData: TcxScrollBarData;
begin
  Result := FData;
end;

function TcxControlScrollBar.GetHeight: Integer;
begin
  Result := inherited Height;
end;

function TcxControlScrollBar.GetLeft: Integer;
begin
  Result := inherited Left;
end;

function TcxControlScrollBar.GetTop: Integer;
begin
  Result := inherited Top;
end;

function TcxControlScrollBar.GetVisible: boolean;
begin
  Result := inherited Visible;
end;

function TcxControlScrollBar.GetWidth: Integer;
begin
  Result := inherited Width;
end;

procedure TcxControlScrollBar.SetBoundsRect(const AValue: TRect);
begin
  inherited BoundsRect := AValue;
end;

procedure TcxControlScrollBar.SetHeight(AValue: Integer);
begin
  inherited Height := AValue;
end;

procedure TcxControlScrollBar.SetLeft(AValue: Integer);
begin
  inherited Left := AValue;
end;

procedure TcxControlScrollBar.SetTop(AValue: Integer);
begin
  inherited Top := AValue;
end;

procedure TcxControlScrollBar.SetVisible(AValue: Boolean);
begin
  inherited Visible := AValue;
end;

procedure TcxControlScrollBar.SetWidth(AValue: Integer);
begin
  inherited Width := AValue;
end;

procedure TcxControlScrollBar.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  Message.Result := 1;
end;

procedure TcxControlScrollBar.CMHintShow(var Message: TCMHintShow);
begin
  Message.Result := 1;
end;

procedure TcxControlScrollBar.WndProc(var Message: TMessage);
var
  ALink: TcxObjectLink;
begin
  ALink := cxAddObjectLink(Self);
  try
    if Message.Msg = WM_LBUTTONDOWN then
      FocusParent;
    if ALink.Ref <> nil then
      inherited;
  finally
    cxRemoveObjectLink(ALink);
  end;
end;

procedure TcxControlScrollBar.DoPaint(ACanvas: TcxCanvas);
var
  AIntf: IcxLockedStatePaint;
  ATopMostControl: TWinControl;
  P: TPoint;
begin
  if Supports(Parent, IcxLockedStatePaint, AIntf) and (AIntf.GetImage <> nil) then
  begin
    ATopMostControl := AIntf.GetTopmostControl;
    if ATopmostControl = Parent then
      P := BoundsRect.TopLeft
    else
      P := cxClientToParent(Self, cxNullPoint, ATopMostControl);
    cxBitBlt(ACanvas.Handle, AIntf.GetImage.cxCanvas.Handle, ClientRect, P, SRCCOPY);
  end
  else
    inherited DoPaint(ACanvas);
end;

procedure TcxControlScrollBar.FocusParent;
begin
  if Parent = nil then Exit;
  if (Parent is TcxControl) and TcxControl(Parent).FocusWhenChildIsClicked(Self) or
    not (Parent is TcxControl) and Parent.CanFocus then
      Parent.SetFocus;
end;

procedure TcxControlScrollBar.SetZOrder(TopMost: Boolean);
begin
  if HandleAllocated then
    SetWindowPos(WindowHandle, HWND_TOP, 0, 0, 0, 0,
      SWP_NOMOVE + SWP_NOSIZE + SWP_DEFERERASE);
end;

{ TcxControlScrollBarHelper }

constructor TcxControlScrollBarHelper.Create(AOwner: IcxScrollBarOwner);
begin
  inherited;
  FData := TcxScrollBarData.Create;
end;

destructor TcxControlScrollBarHelper.Destroy;
begin
  FreeAndNil(FData);
  inherited;
end;

procedure TcxControlScrollBarHelper.Repaint;
var
  ADC: HDC;
  AIntf: IcxLockedStatePaint;
begin
  if not Supports(Owner.GetControl, IcxLockedStatePaint, AIntf) or (AIntf.GetImage = nil) then
  begin
    if not IsNonClient then
    begin
      ADC := GetDC(Handle);
      try
        Paint(ADC);
      finally
        ReleaseDC(Handle, ADC);
      end;
    end
    else
      inherited;
  end;
end;

procedure TcxControlScrollBarHelper.ApplyData;
begin
  if FData.Visible and FData.IsValid then
  begin
    SetScrollParams(FData.Min, FData.Max, FData.Position, FData.PageSize, Visible);
    SmallChange := FData.SmallChange;
    LargeChange := FData.LargeChange;
  end;
  Enabled := FData.Enabled;
  if Visible <> FData.Visible then
    Visible := FData.Visible;
end;

function TcxControlScrollBarHelper.GetControl: TcxControlScrollBar;
begin
  Result := nil;
end;

function TcxControlScrollBarHelper.GetData: TcxScrollBarData;
begin
  Result := FData;
end;

function TcxControlScrollBarHelper.GetHeight: Integer;
begin
  Result := cxRectHeight(BoundsRect);
end;

function TcxControlScrollBarHelper.GetLeft: Integer;
begin
  Result := BoundsRect.Left;
end;

function TcxControlScrollBarHelper.GetTop: Integer;
begin
  Result := BoundsRect.Top;
end;

function TcxControlScrollBarHelper.GetWidth: Integer;
begin
  Result := cxRectWidth(BoundsRect);
end;

procedure TcxControlScrollBarHelper.SetHeight(Value: Integer);
begin
  BoundsRect := cxRectSetHeight(BoundsRect, Value);
end;

procedure TcxControlScrollBarHelper.SetLeft(Value: Integer);
begin
  BoundsRect := cxRectSetLeft(BoundsRect, Value);
end;

procedure TcxControlScrollBarHelper.SetTop(Value: Integer);
begin
  BoundsRect := cxRectSetTop(BoundsRect, Value);
end;

procedure TcxControlScrollBarHelper.SetWidth(Value: Integer);
begin
  BoundsRect := cxRectSetWidth(BoundsRect, Value);
end;

{ TcxSizeGrip }

constructor TcxSizeGrip.Create(AOwner: TComponent);
begin
  inherited;
  Color := clBtnFace;
  ControlStyle := ControlStyle + [csNoDesignVisible];
  FLookAndFeel := TcxLookAndFeel.Create(Self);
  FLookAndFeel.OnChanged := LookAndFeelChanged; 
end;

destructor TcxSizeGrip.Destroy;
begin
  FreeAndNil(FLookAndFeel);
  inherited Destroy;
end;

procedure TcxSizeGrip.Draw(ACanvas: TCanvas);
begin
  ACanvas.Brush.Color := LookAndFeel.Painter.DefaultSizeGripAreaColor;
  ACanvas.FillRect(ClientRect);
end;

procedure TcxSizeGrip.LookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
begin
  Invalidate;
end;

procedure TcxSizeGrip.Paint;
var
  AIntf: IcxLockedStatePaint;
  ATopMostControl: TWinControl;
  P: TPoint;
begin
  if Supports(Parent, IcxLockedStatePaint, AIntf) and (AIntf.GetImage <> nil) then
  begin
    ATopMostControl := AIntf.GetTopmostControl;
    if ATopmostControl = Parent then
      P := BoundsRect.TopLeft
    else
      P := cxClientToParent(Self, cxNullPoint, ATopMostControl);
    cxBitBlt(Canvas.Handle, AIntf.GetImage.cxCanvas.Handle, ClientRect, P, SRCCOPY);
  end
  else
    Draw(Canvas);
end;

procedure TcxSizeGrip.SetZOrder(TopMost: Boolean);
begin
  if HandleAllocated then
    SetWindowPos(WindowHandle, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_DEFERERASE);
end;

procedure TcxSizeGrip.WMEraseBkgnd(var AMessage: TWMEraseBkgnd);
begin
  AMessage.Result := 1;
end;

{ TcxSizeGripHelper }

constructor TcxSizeGripHelper.Create(AOwner: IcxScrollBarOwner);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure TcxSizeGripHelper.Paint(ACanvas: TcxCanvas);
begin
  ACanvas.Brush.Color := FOwner.GetLookAndFeel.Painter.DefaultSizeGripAreaColor;
  ACanvas.FillRect(FBoundsRect);
end;

procedure TcxSizeGripHelper.Repaint;
begin
  if FOwner.GetControl.HandleAllocated then
    if IsNonClient then
      RefreshNCPart(FBoundsRect)
    else
      cxInvalidateRect(FOwner.GetControl.Handle, FBoundsRect, False);
end;

procedure TcxSizeGripHelper.RefreshNCPart(const ARect: TRect);
var
  R: TRect;
  ANCOrigin: TPoint;
begin
  R := ARect;
  ANCOrigin := FOwner.GetControl.ScreenToClient(cxGetWindowRect(FOwner.GetControl.Handle).TopLeft);
  R := cxRectOffset(R, ANCOrigin);
  RedrawWindow(FOwner.GetControl.Handle, @R, 0, RDW_INVALIDATE or RDW_FRAME);
end;

{ TcxControlScrollBarsManager }

constructor TcxControlScrollBarsManager.Create(AOwner: TcxControl);
begin
  inherited Create;
  FOwner := AOwner;
  FScrollBars := TList.Create;
end;

destructor TcxControlScrollBarsManager.Destroy;
begin
  FreeAndNil(FScrollBars);
  inherited;
end;

function TcxControlScrollBarsManager.HandleMessage(var Message: TMessage): Boolean;

  function GetMousePos: TPoint;
  begin
    if FOwner.HandleAllocated and ((FOwner.Width > 32768) or (FOwner.Height > 32768)) then
      Result := FOwner.ScreenToClient(GetMouseCursorPos)
    else
      Result := SmallPointToPoint(TWMMouse(Message).Pos);
  end;

  function GetMouseButton: TMouseButton;
  begin
    case Message.Msg of
      WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
        Result := mbLeft;
      WM_RBUTTONDOWN, WM_RBUTTONDBLCLK:
        Result := mbRight;
    else
      Result := mbMiddle;
    end;
  end;

  function ShiftState: TShiftState;
  begin
    Result := KeysToShiftState(TWMMouse(Message).Keys);
  end;

begin
  Result := False;
  case Message.Msg of
    WM_MOUSEMOVE:
      begin
        with GetMousePos do
          Result := ProcessMouseMove(ShiftState, X, Y);
        if Result then
          Application.CancelHint;
      end;
    WM_LBUTTONDBLCLK, WM_RBUTTONDBLCLK, WM_MBUTTONDBLCLK,
    WM_LBUTTONDOWN, WM_RBUTTONDOWN, WM_MBUTTONDOWN:
      begin
        with GetMousePos do
          Result := ProcessMouseDown(GetMouseButton, ShiftState, X, Y);
      end;
    WM_LBUTTONUP, WM_RBUTTONUP, WM_MBUTTONUP:
      begin
        with GetMousePos do
          Result := ProcessMouseUp(GetMouseButton, ShiftState, X, Y);
      end;
    WM_CAPTURECHANGED:
      begin
        FIsCapture := False;
        if HotScrollBar <> nil then
         HotScrollBar.CancelMode;
      end;
  end;
end;

function TcxControlScrollBarsManager.IsScrollBarsArea(const APoint: TPoint): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to FScrollBars.Count - 1 do
    if ScrollBars[I].Visible and PtInRect(ScrollBars[I].BoundsRect, APoint) then
    begin
      Result := True;
      Break;
    end;
end;

procedure TcxControlScrollBarsManager.Paint(ACanvas: TcxCanvas);
var
  I: Integer;
begin
  for I := 0 to FScrollBars.Count - 1 do
    if ScrollBars[I].Visible and ACanvas.RectVisible(ScrollBars[I].BoundsRect) then
    begin
      ScrollBars[I].Paint(ACanvas);
      ACanvas.ExcludeClipRect(ScrollBars[I].BoundsRect);
    end;
end;

procedure TcxControlScrollBarsManager.RegisterScrollBar(
  AScrollBar: TcxControlScrollBarHelper);
begin
  FScrollBars.Add(AScrollBar);
end;

procedure TcxControlScrollBarsManager.UnRegisterScrollBar(
  AScrollBar: TcxControlScrollBarHelper);
begin
  if AScrollBar = FHotScrollBar then
    HotScrollBar := nil;
  FScrollBars.Remove(AScrollBar);
end;

function TcxControlScrollBarsManager.ProcessMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  if FOwner.IsSizeGripArea(Point(X, Y)) then
    Result := True
  else
  begin
    Result := FHotScrollBar <> nil;
    if Result and (Button = mbLeft) and FHotScrollBar.Enabled then
    begin
      FHotScrollBar.MouseDown(Button, Shift, X, Y);
      IsCapture := True;
      if FOwner.CanFocusOnClick(X, Y) then
        FOwner.SetFocus;
    end;
  end;
end;

function TcxControlScrollBarsManager.ProcessMouseMove(Shift: TShiftState; X, Y: Integer): Boolean;

  function GetScrollBarAtPos: TcxControlScrollBarHelper;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to FScrollBars.Count - 1 do
      if ScrollBars[I].Visible and ScrollBars[I].Enabled and PtInRect(ScrollBars[I].BoundsRect, Point(X, Y)) then
        Result := ScrollBars[I];
  end;

begin
  Result := False;
  if (GetCapture = FOwner.Handle) and not FIsCapture then
    Exit;
  if not FIsCapture then
    HotScrollBar := GetScrollBarAtPos;

  if HotScrollBar <> nil then
  begin
    HotScrollBar.MouseMove(Shift, X, Y);
    Result := True;
  end
  else
    if FOwner.IsSizeGripArea(Point(X, Y)) then
      Result := True;
end;

function TcxControlScrollBarsManager.ProcessMouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := False;
  if FIsCapture then
  begin
    Result := True;
    FHotScrollBar.MouseUp(Button, Shift, X, Y);
    IsCapture := False;
  end;
end;

procedure TcxControlScrollBarsManager.MouseLeave;
begin
  HotScrollBar := nil;
end;

function TcxControlScrollBarsManager.PtInCaller(const P: TPoint): Boolean;
begin
  Result := PtInRect(FHotScrollBar.BoundsRect, P) or FIsCapture;
end;

function TcxControlScrollBarsManager.GetScrollBars(
  AIndex: Integer): TcxControlScrollBarHelper;
begin
  Result := TcxControlScrollBarHelper(FScrollBars[AIndex]);
end;

procedure TcxControlScrollBarsManager.SetHotScrollBar(
  AValue: TcxControlScrollBarHelper);
begin
  if FHotScrollBar <> AValue then
  begin
    if FHotScrollBar <> nil then
    begin
      FHotScrollBar.MouseLeave(nil);
      EndMouseTracking(Self);
    end;
    FHotScrollBar := AValue;
    if FHotScrollBar <> nil then
    begin
      FHotScrollBar.MouseEnter(nil);
      BeginMouseTracking(FOwner, FHotScrollBar.BoundsRect, Self);
    end;
  end;
end;

procedure TcxControlScrollBarsManager.SetIsCapture(AValue: Boolean);
begin
  if AValue <> FIsCapture then
  begin
    FIsCapture := AValue;
    if FIsCapture then
      SetCapture(FOwner.Handle)
    else
      ReleaseCapture;
  end;
end;

{ TcxControlCustomScrollBars }

constructor TcxControlCustomScrollBars.Create(AOwner: TcxControl);
begin
  inherited Create;
  FOwner := AOwner;
  CreateScrollBars;
end;

destructor TcxControlCustomScrollBars.Destroy;
begin
  DestroyScrollBars;
  inherited;
end;

procedure TcxControlCustomScrollBars.Invalidate;
begin
end;

procedure TcxControlCustomScrollBars.DrawSizeGrip(ACanvas: TcxCanvas);
begin
end;

procedure TcxControlCustomScrollBars.ApplyData;
begin
  GetScrollBar(sbHorizontal).ApplyData;
  GetScrollBar(sbVertical).ApplyData;
end;

procedure TcxControlCustomScrollBars.BringInternalControlsToFront;
begin
end;

function TcxControlCustomScrollBars.CheckSize(AKind: TScrollBarKind): Boolean;
begin
  Result := False;
end;

procedure TcxControlCustomScrollBars.CreateScrollBars;
begin
  FHScrollBar := CreateScrollBar(sbHorizontal);
  FVScrollBar := CreateScrollBar(sbVertical);
  FSizeGrip := CreateSizeGrip;
end;

procedure TcxControlCustomScrollBars.DestroyScrollBars;
begin
  FreeAndNil(FSizeGrip);
  FreeAndNil(FVScrollBar);
  FreeAndNil(FHScrollBar);
end;

procedure TcxControlCustomScrollBars.DoScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
var
  AScrollBar: IcxControlScrollBar;
begin
  Supports(Sender, IcxControlScrollBar, AScrollBar);
  FOwner.Scroll(AScrollBar.Kind, ScrollCode, ScrollPos);
end;

function TcxControlCustomScrollBars.GetScrollBar(AKind: TScrollBarKind): IcxControlScrollBar;
var
  AScrollBar: TObject;
begin
  if AKind = sbHorizontal then
    AScrollBar := FHScrollBar
  else
    AScrollBar := FVScrollBar;
  Supports(AScrollBar, IcxControlScrollBar, Result);
end;

procedure TcxControlCustomScrollBars.InitScrollBars;
begin
end;

function TcxControlCustomScrollBars.IsInternalControl(AControl: TControl): Boolean;
begin
  Result := False;
end;

function TcxControlCustomScrollBars.IsScrollBarVisible(AKind: TScrollBarKind): Boolean;
begin
  if FCalculating then
    Result := GetScrollBar(AKind).Data.Visible
  else
    Result := GetScrollBar(AKind).Visible;
end;

function TcxControlCustomScrollBars.IsSizeGripArea(const APoint: TPoint): Boolean;
begin
  Result := False;
end;

procedure TcxControlCustomScrollBars.SetInternalControlsBounds;
begin
end;

procedure TcxControlCustomScrollBars.UpdateInternalControlsState;
begin
end;

{ TcxControlScrollBars }

procedure TcxControlScrollBars.Invalidate;
begin
  if HScrollBar.Visible then
    HScrollBar.Invalidate;
  if VScrollBar.Visible then
    VScrollBar.Invalidate;
  if SizeGrip.Visible then
    SizeGrip.Repaint;
end;

procedure TcxControlScrollBars.DrawSizeGrip(ACanvas: TcxCanvas);
begin
  if SizeGrip.Visible and ACanvas.RectVisible(SizeGrip.BoundsRect) then
  begin
    SizeGrip.Paint(ACanvas);
    ACanvas.ExcludeClipRect(SizeGrip.BoundsRect);
  end;
end;

function TcxControlScrollBars.GetControl: TWinControl;
begin
  Result := FOwner;
end;

function TcxControlScrollBars.GetLookAndFeel: TcxLookAndFeel;
begin
  Result := FOwner.LookAndFeel;
end;

function TcxControlScrollBars.CheckSize(AKind: TScrollBarKind): Boolean;
var
  ASize: Integer;
begin
  Result := False;
  if AKind = sbHorizontal then
  begin
    ASize := GetScrollBarSize.cy;
    if HScrollBar.Height <> ASize then
    begin
      HScrollBar.Height := ASize;
      HScrollBar.Calculate;
      Result := True;
    end;
  end
  else
  begin
    ASize := GetScrollBarSize.cx;
    if VScrollBar.Width <> ASize then
    begin
      VScrollBar.Width := ASize;
      VScrollBar.Calculate;
      Result := True;
    end;
  end;
end;

procedure TcxControlScrollBars.CheckSizeGripVisible(AValue: Boolean);
begin
  SizeGrip.Visible := AValue;
end;

function TcxControlScrollBars.CreateScrollBar(AKind: TScrollBarKind): TObject;
var
  AScrollBar: TcxControlScrollBarHelper;
begin
  AScrollBar := GetScrollBarClass(AKind).Create(Self);
  Result := AScrollBar;
  AScrollBar.Kind := AKind;
  AScrollBar.IsNonClient := False;
  AScrollBar.OnScroll := DoScroll;
  if AKind = sbHorizontal then
    AScrollBar.Height := GetScrollBarSize.cy
  else
    AScrollBar.Width := GetScrollBarSize.cx;
  Owner.ScrollBarsManager.RegisterScrollBar(AScrollBar);
end;

function TcxControlScrollBars.CreateSizeGrip: TObject;
var
  ASizeGrip: TcxSizeGripHelper;
begin
  ASizeGrip := GetSizeGripClass.Create(Self);
  ASizeGrip.IsNonClient := False;
  Result := ASizeGrip;
end;

procedure TcxControlScrollBars.DestroyScrollBars;
begin
  Owner.ScrollBarsManager.UnRegisterScrollBar(HScrollBar);
  Owner.ScrollBarsManager.UnRegisterScrollBar(VScrollBar);
  inherited;
end;

function TcxControlScrollBars.GetScrollBarClass(AKind: TScrollBarKind): TcxControlScrollBarHelperClass;
begin
  Result := TcxControlScrollBarHelper;
end;

function TcxControlScrollBars.GetSizeGripClass: TcxSizeGripHelperClass;
begin
  Result := TcxSizeGripHelper;
end;

function TcxControlScrollBars.IsSizeGripArea(const APoint: TPoint): Boolean;
begin
  Result := SizeGrip.Visible and cxRectPtIn(SizeGrip.BoundsRect, APoint);
end;

procedure TcxControlScrollBars.SetInternalControlsBounds;
begin
  if HScrollBar.Visible then
  begin
    HScrollBar.BoundsRect := FOwner.GetHScrollBarBounds;
    HScrollBar.Calculate;
  end;
  if VScrollBar.Visible then
  begin
    VScrollBar.BoundsRect := FOwner.GetVScrollBarBounds;
    VScrollBar.Calculate;
  end;
  if SizeGrip.Visible then
    SizeGrip.BoundsRect := FOwner.GetSizeGripBounds;
end;

function TcxControlScrollBars.GetHScrollBar: TcxControlScrollBarHelper;
begin
  Result := FHScrollBar as TcxControlScrollBarHelper;
end;

function TcxControlScrollBars.GetSizeGrip: TcxSizeGripHelper;
begin
  Result := FSizeGrip as TcxSizeGripHelper;
end;

function TcxControlScrollBars.GetVScrollBar: TcxControlScrollBarHelper;
begin
  Result := FVScrollBar as TcxControlScrollBarHelper;
end;

{ TcxControlWindowedScrollBars }

procedure TcxControlWindowedScrollBars.Invalidate;
begin
  if HScrollBar.Visible then
    HScrollBar.Invalidate;
  if VScrollBar.Visible then
    VScrollBar.Invalidate;
  if SizeGrip.Visible then
    SizeGrip.Invalidate;
end;

procedure TcxControlWindowedScrollBars.BringInternalControlsToFront;
begin
  if HScrollBar.Visible then
    HScrollBar.BringToFront;
  if VScrollBar.Visible then
    VScrollBar.BringToFront;
  if SizeGrip.Visible then
    SizeGrip.BringToFront;
end;

function TcxControlWindowedScrollBars.CheckSize(AKind: TScrollBarKind): Boolean;
var
  ASize: Integer;
begin
  Result := False;
  if AKind = sbHorizontal then
  begin
    ASize := GetScrollBarSize.cy;
    if HScrollBar.Height <> ASize then
    begin
      HScrollBar.Height := ASize;
      Result := True;
    end;
  end
  else
  begin
    ASize := GetScrollBarSize.cx;
    if VScrollBar.Width <> ASize then
    begin
      VScrollBar.Width := ASize;
      Result := True;
    end;
  end;
end;

procedure TcxControlWindowedScrollBars.CheckSizeGripVisible(AValue: Boolean);
begin
  SizeGrip.Visible := AValue;
end;

function TcxControlWindowedScrollBars.CreateScrollBar(AKind: TScrollBarKind): TObject;
var
  AScrollBar: TcxControlScrollBar;
begin
  AScrollBar := FOwner.GetScrollBarClass(AKind).Create(nil);
  Result := AScrollBar;
  AScrollBar.Kind := AKind;
  AScrollBar.OnScroll := DoScroll;
  AScrollBar.LookAndFeel.MasterLookAndFeel := FOwner.LookAndFeel;
  AScrollBar.ControlStyle := AScrollBar.ControlStyle + [csReplicatable];
end;

function TcxControlWindowedScrollBars.CreateSizeGrip: TObject;
var
  ASizeGrip: TcxSizeGrip;
begin
  ASizeGrip := FOwner.GetSizeGripClass.Create(nil);
  Result := ASizeGrip;
  ASizeGrip.LookAndFeel.MasterLookAndFeel := FOwner.LookAndFeel;
  ASizeGrip.ControlStyle := ASizeGrip.ControlStyle + [csReplicatable];
end;

procedure TcxControlWindowedScrollBars.DestroyScrollBars;
begin
  if Owner.IsDestroying and (SizeGrip.Parent = Owner) then //will be destroyed in TWinControl.Destroy
    Exit;                                                  //SC B134824
  inherited;
end;

procedure TcxControlWindowedScrollBars.InitScrollBars;
begin
  HScrollBar.Parent := FOwner;
  VScrollBar.Parent := FOwner;
  SizeGrip.Parent := FOwner;
  HScrollBar.HandleNeeded;
  VScrollBar.HandleNeeded;
  SizeGrip.HandleNeeded;
end;

function TcxControlWindowedScrollBars.IsInternalControl(AControl: TControl): Boolean;
begin
  Result := (AControl = HScrollBar) or (AControl = VScrollBar) or (AControl = SizeGrip);
end;

procedure TcxControlWindowedScrollBars.SetInternalControlsBounds;
begin
  if HScrollBar.Visible then
    HScrollBar.BoundsRect := FOwner.GetHScrollBarBounds;
  if VScrollBar.Visible then
    VScrollBar.BoundsRect := FOwner.GetVScrollBarBounds;
  if SizeGrip.Visible then
    SizeGrip.BoundsRect := FOwner.GetSizeGripBounds;
end;

procedure TcxControlWindowedScrollBars.UpdateInternalControlsState;
begin
  if HScrollBar.Visible then
    HScrollBar.UpdateControlState;
  if VScrollBar.Visible then
    VScrollBar.UpdateControlState;
  if SizeGrip.Visible then
    SizeGrip.UpdateControlState;
end;

function TcxControlWindowedScrollBars.GetHScrollBar: TcxControlScrollBar;
begin
  Result := FHScrollBar as TcxControlScrollBar;
end;

function TcxControlWindowedScrollBars.GetSizeGrip: TcxSizeGrip;
begin
  Result := FSizeGrip as TcxSizeGrip;
end;

function TcxControlWindowedScrollBars.GetVScrollBar: TcxControlScrollBar;
begin
  Result := FVScrollBar as TcxControlScrollBar;
end;

{ TcxDragAndDropObject }

constructor TcxDragAndDropObject.Create(AControl: TcxControl);
begin
  inherited Create;
  FControl := AControl;
  if AControl <> nil then
    FCanvas := Control.Canvas;
  CurMousePos := cxInvalidPoint;
  PrevMousePos := cxInvalidPoint;
end;

procedure TcxDragAndDropObject.SetDirty(Value: Boolean);
begin
  if FDirty <> Value then
  begin
    FDirty := Value;
    DirtyChanged;
  end;
end;

procedure TcxDragAndDropObject.ChangeMousePos(const P: TPoint);
begin
  PrevMousePos := CurMousePos;
  CurMousePos := P;
end;

procedure TcxDragAndDropObject.DirtyChanged;
begin
end;

function TcxDragAndDropObject.GetClientCursorPos: TPoint;
begin
 Result := Control.ScreenToClient(GetMouseCursorPos);
end;

function TcxDragAndDropObject.GetDragAndDropCursor(Accepted: Boolean): TCursor;
const
  Cursors: array[Boolean] of TCursor = (crNoDrop, crDrag);
begin
  Result := Cursors[Accepted];
end;

function TcxDragAndDropObject.GetImmediateStart: Boolean;
begin
  Result := False;
end;

procedure TcxDragAndDropObject.AfterDragAndDrop(Accepted: Boolean);
begin
end;

procedure TcxDragAndDropObject.BeginDragAndDrop;
begin
  DirtyChanged;
end;

procedure TcxDragAndDropObject.DragAndDrop(const P: TPoint; var Accepted: Boolean);
begin
  Dirty := False;
  Screen.Cursor := GetDragAndDropCursor(Accepted);
end;

procedure TcxDragAndDropObject.EndDragAndDrop(Accepted: Boolean);
begin
  Dirty := True;
end;

procedure TcxDragAndDropObject.DoBeginDragAndDrop;
begin
  CurMousePos := GetClientCursorPos;
  PrevMousePos := CurMousePos;
  BeginDragAndDrop;
end;

procedure TcxDragAndDropObject.DoDragAndDrop(const P: TPoint; var Accepted: Boolean);
begin
  ChangeMousePos(P);
  DragAndDrop(P, Accepted);
end;

procedure TcxDragAndDropObject.DoEndDragAndDrop(Accepted: Boolean);
begin
  EndDragAndDrop(Accepted);
  AfterDragAndDrop(Accepted);
end;

{ TcxDragControlObject }

procedure TcxDragControlObject.Finished(Target: TObject; X, Y: Integer; Accepted: Boolean);
begin
  inherited;
  Free;
end;

function TcxDragControlObject.GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor;
begin
  if Accepted and (Control as TcxControl).IsCopyDragDrop then
    Result := crDragCopy
  else
    Result := inherited GetDragCursor(Accepted, X, Y);
end;

{ TcxControl }

constructor TcxControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if HasDragImages then
    ControlStyle := ControlStyle + [csDisplayDragImage];
  FCanvas := TcxControlCanvas.Create(inherited Canvas);
  FFocusOnClick := True;
  FFontListenerList := TInterfaceList.Create;
  FLookAndFeel := TcxLookAndFeel.Create(Self);
  FLookAndFeel.OnChanged := LookAndFeelChangeHandler;
  FScrollBars := ssBoth;
  FScrollBarsManager := TcxControlScrollBarsManager.Create(Self);
  CreateScrollBars;
  TabStop := MayFocus;
  FGestureHelper := TdxGestureHelper.Create(Self);
{$IFDEF DELPHI14}
  Touch.InteractiveGestures := GetDefaultInteractiveGestures;
  Touch.InteractiveGestureOptions := GetDefaultInteractiveGestureOptions;
{$ENDIF}
  dxResourceStringsRepository.AddListener(Self);
end;

destructor TcxControl.Destroy;
begin
  dxResourceStringsRepository.RemoveListener(Self);
  FreeAndNil(FGestureHelper);
  EndDrag(False);
  DestroyScrollBars;
  FreeAndNil(FScrollBarsManager);
  FFontListenerList := nil;
  FreeAndNil(FActiveCanvas);
  FCanvas.Free;
  FreeAndNil(FLookAndFeel);
  cxClearObjectLinks(Self);
  inherited Destroy;
end;

function TcxControl.GetActiveCanvas: TcxCanvas;
begin
  if HandleAllocated then
  begin
    if FActiveCanvas <> nil then FreeAndNil(FActiveCanvas);
    Result := Canvas;
  end
  else
  begin
    if FActiveCanvas = nil then
      FActiveCanvas := TcxScreenCanvas.Create;
    Result := FActiveCanvas;
  end;
end;

function TcxControl.GetDragAndDropObject: TcxDragAndDropObject;
begin
  if FDragAndDropObject = nil then
    FDragAndDropObject := CreateDragAndDropObject;
  Result := FDragAndDropObject;
end;

function TcxControl.GetHScrollBar: IcxControlScrollBar;
begin
  Result := GetScrollBar(sbHorizontal);
end;

function TcxControl.GetHScrollBarVisible: Boolean;
begin
  Result := (FMainScrollBars <> nil) and FMainScrollBars.IsScrollBarVisible(sbHorizontal);
end;

function TcxControl.GetIsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TcxControl.GetIsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

function TcxControl.GetSizeGrip: TcxSizeGrip;
begin
  if (FMainScrollBars <> nil) and (FMainScrollBars is TcxControlWindowedScrollBars) then
    Result := TcxControlWindowedScrollBars(FMainScrollBars).SizeGrip
  else
    Result := nil;
end;

function TcxControl.GetVScrollBarVisible: Boolean;
begin
  Result := (FMainScrollBars <> nil) and FMainScrollBars.IsScrollBarVisible(sbVertical)
end;

procedure TcxControl.SetBorderStyle(Value: TcxControlBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    BoundsChanged;
  end;
end;

procedure TcxControl.SetDragAndDropState(Value: TcxDragAndDropState);
begin
  if FDragAndDropState <> Value then
  begin
    FDragAndDropState := Value;
    if (Value = ddsNone) and not FFinishingDragAndDrop then DoCancelMode;
  end;
end;

procedure TcxControl.SetLookAndFeel(Value: TcxLookAndFeel);
begin
  LookAndFeel.Assign(Value);
end;

procedure TcxControl.SetKeys(Value: TcxKeys);
begin
  if FKeys <> Value then
  begin
    FKeys := Value;
  end;
end;

procedure TcxControl.SetMouseCaptureObject(Value: TObject);
var
  AIMouseCaptureObject: IcxMouseCaptureObject;
  AMouseWasCaught: Boolean;
begin
  if FMouseCaptureObject <> Value then
  begin
    if (FMouseCaptureObject <> nil) and
      Supports(FMouseCaptureObject, IcxMouseCaptureObject, AIMouseCaptureObject) then
      AIMouseCaptureObject.DoCancelMode;
    FMouseCaptureObject := Value;
    AMouseWasCaught := MouseCapture;
    MouseCapture := FMouseCaptureObject <> nil;
    if AMouseWasCaught and not MouseCapture and (DragAndDropState = ddsStarting) and
       CanCancelDragStartOnCaptureObjectClear then
      Perform(WM_CANCELMODE, 0, 0);
  end;
end;

procedure TcxControl.SetPopupMenu(Value: TComponent);
begin
  if not IsPopupMenu(Value) then
    Value := nil;
  if FPopupMenu <> Value then
  begin
    if FPopupMenu <> nil then
      FPopupMenu.RemoveFreeNotification(Self);
    FPopupMenu := Value;
    if FPopupMenu <> nil then
      FPopupMenu.FreeNotification(Self);
  end;
end;

procedure TcxControl.SetScrollBars(Value: TcxScrollStyle);
begin
  if FScrollBars <> Value then
  begin
    FScrollBars := Value;
    BoundsChanged;
  end;
end;

procedure TcxControl.DoNCPaint(AWindowDC: HDC);
var
  ABitmap: TcxBitmap;
  ABounds, AClientRect, ACustomNonClientBounds: TRect;
  ASaveIndex: Integer;
begin
  ASaveIndex := SaveDC(AWindowDC);
  try
    AClientRect := cxRectOffset(ClientRect, cxGetClientOffset(Handle));
    ExcludeClipRect(AWindowDC, AClientRect.Left, AClientRect.Top, AClientRect.Right, AClientRect.Bottom);
    ACustomNonClientBounds := cxRectInflate(AClientRect, GetClientOffsets);
    IntersectClipRect(AWindowDC, ACustomNonClientBounds.Left, ACustomNonClientBounds.Top,
      ACustomNonClientBounds.Right, ACustomNonClientBounds.Bottom);

    ABounds := cxGetWindowBounds(Self);
    ABitmap := TcxBitmap.CreateSize(ABounds);
    try
      PaintNonClientArea(ABitmap.cxCanvas);
      cxBitBlt(AWindowDC, ABitmap.cxCanvas.Handle, ABounds, ABounds.TopLeft, SRCCOPY);
    finally
      ABitmap.Free;
    end;
  finally
    RestoreDC(AWindowDC, ASaveIndex);
  end;
end;

procedure TcxControl.DoScrollBarBasedGestureScroll(AKind: TScrollBarKind;
  var AAccumulatedDelta: Integer; ADeltaX, ADeltaY: Integer);

  procedure GetScrollParameters(AKind: TScrollBarKind;
    out AMin, AMax, APageSize, APosition: Integer);
  var
    AScrollBar: IcxControlScrollBar;
  begin
    AScrollBar := GetScrollBar(AKind);
    if CanScrollContentByGestureWithoutScrollBars then
    begin
      AMin := AScrollBar.Data.Min;
      AMax := AScrollBar.Data.Max;
      APageSize := AScrollBar.Data.PageSize;
      APosition := AScrollBar.Data.Position;
    end
    else
    begin
      AMin := AScrollBar.Min;
      AMax := AScrollBar.Max;
      APageSize := AScrollBar.PageSize;
      APosition := AScrollBar.Position;
    end;
    AMax := AMax - AMin - APageSize + 1;
  end;

  function GetScale(AKind: TScrollBarKind; APageSize: Integer): Integer;
  const
    AMaxScale = 30;
  var
    AThumbPage: Integer;
  begin
    if APageSize = 0 then
      Result := AMaxScale
    else
    begin
      AThumbPage := IfThen(AKind = sbHorizontal, ClientWidth, ClientHeight);
      Result := Min(AThumbPage div APageSize, AMaxScale);
    end;
  end;

var
  ANewDataPos: Integer;
  AScale: Integer;
  AMin, AMax, APageSize, APosition: Integer;
begin
  GetScrollParameters(AKind, AMin, AMax, APageSize, APosition);
  AScale := GetScale(AKind, APageSize);
  ANewDataPos := APosition - AAccumulatedDelta div AScale;
  if ANewDataPos <> APosition then
  begin
    AAccumulatedDelta := AAccumulatedDelta mod AScale;
    CheckOverpan(AKind, ANewDataPos, AMin, AMax, ADeltaX, ADeltaY);
    ANewDataPos := EnsureRange(ANewDataPos, AMin, AMax);
    DoGestureScroll(AKind, ANewDataPos);
    Update;
  end;
end;

procedure TcxControl.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  FinishDragAndDrop(False);
  DoCancelMode;
end;

procedure TcxControl.WMContextMenu(var Message: TWMContextMenu);
begin
  if IsScrollBarsCapture or IsScrollBarsArea(ScreenToClient(SmallPointToPoint(Message.Pos))) then
    Message.Result := 1
  else
    inherited;
end;

procedure TcxControl.WMEraseBkgnd(var Message: TWMEraseBkgnd);
var
  ADrawToMemory: Boolean;
begin
  ADrawToMemory := cxIsDrawToMemory(Message);
  if HasBackground or ADrawToMemory then
  begin
    if not IsDoubleBufferedNeeded or ADrawToMemory then
      EraseBackground(Message.DC);
    Message.Result := 1;
  end
  else
    Message.Result := 0;
end;

procedure TcxControl.WMGetDlgCode(var Message: TWMGetDlgCode);
const
  DlgCodes: array[TcxKey] of Integer =
    (DLGC_WANTALLKEYS, DLGC_WANTARROWS, DLGC_WANTCHARS, DLGC_WANTTAB);
var
  I: TcxKey;
  Res: Integer;
begin
  Res := 0;
  for I := Low(TcxKey) to High(TcxKey) do
    if (I in FKeys) and ((I <> kTab) or (GetAsyncKeyState(VK_CONTROL) >= 0)) then
      Inc(Res, DlgCodes[I]);
  Message.Result := Res;
end;

procedure TcxControl.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  PostMessage(Handle, DXM_NCSIZECHANGED, 0, 0);
end;

procedure TcxControl.WMNCPaint(var Message: TWMNCPaint);
var
  DC: THandle;
  AFlags: Integer;
  ARegion, AUpdateRegion: HRGN;
begin
  inherited;
  if HasNonClientArea then
  begin
    AFlags := DCX_CACHE or DCX_CLIPSIBLINGS or DCX_WINDOW or DCX_VALIDATE;
    AUpdateRegion := Message.RGN;

    if AUpdateRegion <> 1 then
    begin
      ARegion := CreateRectRgnIndirect(cxEmptyRect);
      CombineRgn(ARegion, AUpdateRegion, 0, RGN_COPY);
      AFlags := AFlags or DCX_INTERSECTRGN;
    end
    else
      ARegion := 0;

    DC := GetDCEx(Handle, ARegion, AFlags);
    DoNCPaint(DC);
    ReleaseDC(Handle, DC);
    Message.Result := 0;
  end;
end;

procedure TcxControl.StandardPaintHandler(var Message: TWMPaint);

  function GetGraphicControls: TList;
  var
    ASubControl: TControl;
    I: Integer;
  begin
    Result := TList.Create;
    Result.Capacity := ControlCount;
    for I := 0 to ControlCount - 1 do
    begin
      ASubControl := Controls[I];
      if not (ASubControl is TWinControl) then
        Result.Add(ASubControl);
    end;
  end;

var
  AClientOffset, AAncestorRelativeNCOffset: TPoint;
  AClientRect: TRect;
  AClipRgn: TcxRegion;
  AGraphicControls: TList;
  AHasClipRgn: Boolean;
  ASaveIndex, I, AClip: Integer;
  ASubControl: TControl;
  DC: HDC;
  PS: TPaintStruct;
begin
  DC := Message.DC;
  AClipRgn := TcxRegion.Create;
  try
    if DC = 0 then
    begin
      AHasClipRgn := dxGetUpdateRgn(Self, AClipRgn.Handle);
      DC := BeginPaint(Handle, PS);
      if AHasClipRgn then
        SelectClipRgn(DC, AClipRgn.Handle);
    end;
    try
      AGraphicControls := GetGraphicControls;
      try
        if (csPaintCopy in ControlState) and HasNonClientArea then
        begin
          AClientOffset := GetClientOffsets.TopLeft;
          AAncestorRelativeNCOffset := cxPointOffset(cxGetClientOffset(Handle),  AClientOffset, False);
          cxPaintCanvas.BeginPaint(DC);
          try
            MoveWindowOrg(cxPaintCanvas.Handle, -AAncestorRelativeNCOffset.X, -AAncestorRelativeNCOffset.Y);
            PaintNonClientArea(cxPaintCanvas);
          finally
            cxPaintCanvas.EndPaint;
          end;
          AClientRect := ClientRect;
          MoveWindowOrg(DC, AClientOffset.X, AClientOffset.Y);
          IntersectClipRect(DC, AClientRect.Left, AClientRect.Top, AClientRect.Right, AClientRect.Bottom);
        end;
        if AGraphicControls.Count = 0 then
          PaintWindow(DC)
        else
        begin
          ASaveIndex := SaveDC(DC);
          try
            AClip := SimpleRegion;
            for I := 0 to AGraphicControls.Count - 1 do
            begin
              ASubControl := TControl(AGraphicControls[I]);
              if (ASubControl.Visible or (csDesigning in ASubControl.ComponentState) and
                not (csNoDesignVisible in ASubControl.ControlStyle)) and
                (csOpaque in ASubControl.ControlStyle) then
              begin
                AClip := ExcludeClipRect(DC, ASubControl.Left, ASubControl.Top,
                  ASubControl.Left + ASubControl.Width, ASubControl.Top + ASubControl.Height);
                if AClip = NullRegion then Break;
              end;
            end;
            if AClip <> NullRegion then
              PaintWindow(DC);
          finally
            RestoreDC(DC, ASaveIndex);
          end;
        end;
        PaintControls(DC, nil);
      finally
        AGraphicControls.Free;
      end;
    finally
      if Message.DC = 0 then
        EndPaint(Handle, PS);
    end
  finally 
    AClipRgn.Free;
  end;
end;

procedure TcxControl.WMPaint(var Message: TWMPaint);
begin
  if (Message.DC <> 0) or not IsDoubleBufferedNeeded then
    StandardPaintHandler(Message)
  else
    if IsCompositionEnabled and AllowCompositionPainting then
      dxPaintWindowOnGlass(Handle, GetPaintBlackOpaqueOnGlass)
    else
      dxBufferedPaintControl(Self);
end;

procedure TcxControl.WMPrint(var Message: TWMPrint);
begin
  inherited;
  if Message.Flags and PRF_NONCLIENT <> 0 then
  begin
    if HasNonClientArea then
      DoNCPaint(Message.DC);
  end;
end;

procedure TcxControl.WMSetCursor(var Message: TWMSetCursor);

  function InternalSetCursor: Boolean;
  var
    P: TPoint;
    ACursor: TCursor;
  begin
    ACursor := crDefault;
    if (DragAndDropState = ddsNone) and (Screen.Cursor = crDefault) then
    begin
      P := ScreenToClient(GetMouseCursorPos);
      ACursor := GetCurrentCursor(P.X, P.Y);
    end;
    Result := ACursor <> crDefault;
    if Result then
      SetCursor(Screen.Cursors[ACursor]);
  end;

begin
  if (Message.CursorWnd <> Handle) or not InternalSetCursor then
    inherited;
end;

{$IFNDEF DELPHI14}
procedure TcxControl.WMTabletQuerySystemGestureStatus(var Message: TMessage);
begin
  Message.Result := TABLET_DISABLE_FLICKS;
end;
{$ENDIF}

procedure TcxControl.CMColorChanged(var Message: TMessage);
begin
  ColorChanged;
  inherited;
end;

procedure TcxControl.CMCursorChanged(var Message: TMessage);
begin
  CursorChanged;
  inherited;
end;

procedure TcxControl.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  inherited;
  with Message do
    if Result = 0 then
      Result := Integer(GetDesignHitTest(XPos, YPos, KeysToShiftState(Keys)));
end;

procedure TcxControl.CMFontChanged(var Message: TMessage);
begin
  inherited;
  FontChanged;
end;

procedure TcxControl.CMInvalidate(var Message: TMessage);
begin
  if HandleAllocated and not IsDestroying then
    InvalidateControl(Self, Message.WParam = 0, NeedRedrawOnResize);
end;

procedure TcxControl.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if Message.lParam = 0 then
    MouseEnter(Self)
  else
    MouseEnter(TControl(Message.lParam));
end;

procedure TcxControl.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if Message.lParam = 0 then
    MouseLeave(Self)
  else
    MouseLeave(TControl(Message.lParam));
end;

procedure TcxControl.CMNCSizeChanged(var Message: TMessage);

  procedure CheckSize(AKind: TScrollBarKind; var AChanged: Boolean);
  begin
    AChanged := FMainScrollBars.CheckSize(AKind) or AChanged;
  end;

var
  ABoundsChanged: Boolean;
begin
  if not NeedsScrollBars then
    Exit;
  ABoundsChanged := False;
  case GetSystemSizeScrollBars of
    ssHorizontal:
       CheckSize(sbHorizontal, ABoundsChanged);
    ssVertical:
       CheckSize(sbVertical, ABoundsChanged);
    ssBoth:
    begin
      CheckSize(sbHorizontal, ABoundsChanged);
      CheckSize(sbVertical, ABoundsChanged);
    end;
  end;
  if ABoundsChanged then
    BoundsChanged;
end;

procedure TcxControl.CMTextChanged(var Message: TMessage);
begin
  inherited;
  TextChanged;
end;

procedure TcxControl.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
  VisibleChanged;
end;

procedure TcxControl.CNKeyDown(var Message: TWMKeyDown);
var
  AMask: Integer;
begin
  with Message do
  begin
    Result := 1;
    UpdateUIState(Message.CharCode);
    if IsMenuKey(Message) then Exit;
    if DragAndDropState <> ddsNone then
    begin
      FinishDragAndDrop(False);
      Exit;
    end;
    if not IsDesigning then
    begin
      if Perform(CM_CHILDKEY, CharCode, LPARAM(Self)) <> 0 then
        Exit;
      AMask := 0;
      case CharCode of
        VK_TAB:
          AMask := DLGC_WANTTAB;
        VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN:
          AMask := DLGC_WANTARROWS;
        VK_RETURN, VK_EXECUTE, VK_ESCAPE, VK_CANCEL:
          AMask := DLGC_WANTALLKEYS;
      end;
      if (AMask <> 0) and
        (Perform(CM_WANTSPECIALKEY, CharCode, 0) = 0) and
        (Perform(WM_GETDLGCODE, 0, 0) and AMask = 0) and
        (GetParentForm(Self).Perform(CM_DIALOGKEY,
        CharCode, KeyData) <> 0) then Exit;
    end;
    Result := 0;
  end;
end;

procedure TcxControl.CNSysKeyDown(var Message: TWMKeyDown);
begin
  with Message do
  begin
    Result := 1;
    if IsMenuKey(Message) then Exit;
    if not IsDesigning then
    begin
      if Perform(CM_CHILDKEY, CharCode, LPARAM(Self)) <> 0 then
        Exit;
      if GetParentForm(Self).Perform(CM_DIALOGKEY, CharCode, KeyData) <> 0 then Exit;
    end;
    Result := 0;
  end;
end;

procedure TcxControl.CreateScrollBars;
begin
  if not NeedsScrollBars or (FMainScrollBars <> nil) then Exit;
  FMainScrollBars := GetMainScrollBarsClass.Create(Self);
  dxSystemInfo.AddListener(Self);
end;

procedure TcxControl.DestroyScrollBars;
begin
  if FMainScrollBars = nil then Exit;
  dxSystemInfo.RemoveListener(Self);
  FreeAndNil(FMainScrollBars);
end;

{$IFNDEF DELPHI10}
function TcxControl.ClientToParent(const P: TPoint; AParent: TWinControl): TPoint;
begin
  Result := cxClientToParent(Self, P, AParent);
end;
{$ENDIF}

procedure TcxControl.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    Style := Style or WS_CLIPCHILDREN;
end;

procedure TcxControl.CreateWnd;
begin
  FCreatingWindow := True;
  try
    inherited;
    CheckNeedsScrollBars;
    InitControl;
  finally
    FCreatingWindow := False;
  end;
end;

procedure TcxControl.Resize;
begin
  inherited;
  BoundsChanged;
end;

procedure TcxControl.WndProc(var Message: TMessage);

  function GetMousePos: TPoint;
  begin
    if HandleAllocated and ((Width > 32768) or (Height > 32768)) then
      Result := ScreenToClient(GetMouseCursorPos)
    else
      Result := SmallPointToPoint(TWMMouse(Message).Pos);
  end;

  function GetMouseButton: TMouseButton;
  begin
    case Message.Msg of
      WM_LBUTTONDOWN:
        Result := mbLeft;
      WM_RBUTTONDOWN:
        Result := mbRight;
    else
      Result := mbMiddle;
    end;
  end;

  procedure DoAfterMouseDown;
  begin
    case Message.Msg of
      WM_LBUTTONDOWN, WM_RBUTTONDOWN, WM_MBUTTONDOWN:
        with GetMousePos do
          AfterMouseDown(GetMouseButton, X, Y);
    end;
  end;

  function IsScrollBarsManagerMessage: Boolean;
  begin
    Result := (ScrollBarsManager <> nil) and ScrollBarsManager.HandleMessage(Message);
  end;

var
  ALink: TcxObjectLink;
begin
  if IsGestureHelperMessage(Message) or IsScrollBarsManagerMessage then
    Exit;
  ALink := cxAddObjectLink(Self);
  try
    if ((Message.Msg = WM_LBUTTONDOWN) or (Message.Msg = WM_LBUTTONDBLCLK)) and not Dragging and
      (IsDesigning and GetDesignHitTest(GetMousePos.X, GetMousePos.Y, [ssLeft]) or
       not IsDesigning and (DragMode = dmAutomatic)) then
    begin
      if not IsControlMouseMsg(TWMMouse(Message)) then
      begin
        ControlState := ControlState + [csLButtonDown];
        Dispatch(Message);
        ControlState := ControlState - [csLButtonDown];
      end;
      Exit;
    end;
    if Message.Msg = WM_RBUTTONUP then
      FMouseRightButtonReleased := True;
    inherited;
  finally
    try
      if (ALink.Ref <> nil) and not IsDestroying then
      begin
        case Message.Msg of
          (*WM_KEYDOWN:
            if Message.wParam = VK_ESCAPE then FinishDragAndDrop(False);//!!!*)
          WM_RBUTTONUP:
            FMouseRightButtonReleased := False;
          WM_SETFOCUS:
            begin
              FocusEnter;
              FocusChanged;
            end;
          WM_KILLFOCUS:
            begin
              FocusLeave;
              FocusChanged;
            end;
        end;
        DoAfterMouseDown;
      end;
    finally
      cxRemoveObjectLink(ALink);
    end;
  end;
end;

procedure TcxControl.DestroyWindowHandle;
begin
  inherited DestroyWindowHandle;
  ControlState := ControlState - [csClicked];
end;

procedure TcxControl.DoContextPopup(MousePos: TPoint;
  var Handled: Boolean);
var
  P: TPoint;
begin
  inherited;
  if not Handled then
  begin
    if (MousePos.X = -1) and (MousePos.Y = -1) then
      P := ClientToScreen(Point(0, 0)) // TODO: GetOffsetPos method
    else
      P := ClientToScreen(MousePos);
    Handled := (Assigned(dxISpellChecker) and dxISpellChecker.QueryPopup(PopupMenu, MousePos)) or
      DoShowPopupMenu(PopupMenu, P.X, P.Y);
  end;
end;

procedure TcxControl.BeginGestureScroll(APos: TPoint);
begin
  FGestureAccumulatedDelta := cxNullPoint;
end;

function TcxControl.CanScrollContentByGestureWithoutScrollBars: Boolean;
begin
  Result := False;
end;

procedure TcxControl.CheckOverpan(AScrollKind: TScrollBarKind;
  ANewDataPos, AMinDataPos, AMaxDataPos: Integer; ADeltaX, ADeltaY: Integer);
begin
  FGestureHelper.CheckOverpan(AScrollKind, ANewDataPos, AMinDataPos, AMaxDataPos, ADeltaX, ADeltaY);
end;

procedure TcxControl.DoGestureScroll(AScrollKind: TScrollBarKind; ANewScrollPos: Integer);
begin
  Scroll(AScrollKind, scTrack, ANewScrollPos);
end;

procedure TcxControl.EndGestureScroll;
begin
end;

{$IFDEF DELPHI14}
procedure TcxControl.DoGesture(const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  FGestureHelper.DoGesture(EventInfo, Handled);
end;

procedure TcxControl.DoGetGestureOptions(var Gestures: TInteractiveGestures;
  var Options: TInteractiveGestureOptions);
begin
  inherited;
  FGestureHelper.CheckGestureOptions(Gestures, Options);
end;

function TcxControl.GetDefaultInteractiveGestures: TInteractiveGestures;
var
  I: Integer;
begin
  Result := [];
  for I := 0 to dxSupportedGestureCount - 1 do
    if IsDefaultGesture(dxSupportedGestureIDs[I]) then
      Include(Result, GetInteractiveGestureByGestureID(dxSupportedGestureIDs[I]));
end;

function TcxControl.GetDefaultInteractiveGestureOptions: TInteractiveGestureOptions;
begin
  Result := [igoParentPassthrough] + GetInteractiveGestureOptionsByPanOptions(GetDefaultPanOptions);
end;

function TcxControl.IsTouchPropertyStored(AProperty: TTouchProperty): Boolean;
begin
  case AProperty of
    tpInteractiveGestures: Result := Touch.InteractiveGestures <> GetDefaultInteractiveGestures;
    tpInteractiveGestureOptions: Result := Touch.InteractiveGestureOptions <> GetDefaultInteractiveGestureOptions;
  else
    Result := inherited IsTouchPropertyStored(AProperty);
  end;
end;
{$ENDIF}

procedure TcxControl.GestureScroll(ADeltaX, ADeltaY: Integer);
var
  AAccumulatedDelta: Integer;
  AScrollingControl: IdxScrollingControl;
begin
  if Supports(Self, IdxScrollingControl, AScrollingControl) then
    TdxScrollHelper.GestureScroll(AScrollingControl, ADeltaX, ADeltaY)
  else
  begin
    if not IsScrollBarBasedGestureScroll(sbHorizontal) then
      ScrollContentByGesture(sbHorizontal, ADeltaX)
    else
      if HScrollBarVisible and HScrollBar.Enabled or
        CanScrollContentByGestureWithoutScrollBars and HScrollBar.Data.IsValid then
      begin
        AAccumulatedDelta := FGestureAccumulatedDelta.X;
        Inc(AAccumulatedDelta, ADeltaX);
        DoScrollBarBasedGestureScroll(sbHorizontal, AAccumulatedDelta, ADeltaX, ADeltaY);
        FGestureAccumulatedDelta.X := AAccumulatedDelta;
      end;

    if not IsScrollBarBasedGestureScroll(sbVertical) then
      ScrollContentByGesture(sbVertical, ADeltaY)
    else
      if VScrollBarVisible and VScrollBar.Enabled or
        CanScrollContentByGestureWithoutScrollBars and VScrollBar.Data.IsValid then
      begin
        AAccumulatedDelta := FGestureAccumulatedDelta.Y;
        Inc(AAccumulatedDelta, ADeltaY);
        DoScrollBarBasedGestureScroll(sbVertical, AAccumulatedDelta, ADeltaX, ADeltaY);
        FGestureAccumulatedDelta.Y := AAccumulatedDelta;
      end;
  end;
end;

function TcxControl.IsDefaultGesture(AGestureID: Integer): Boolean;
begin
  Result := AGestureID in [GID_PAN, GID_PRESSANDTAP];
end;

function TcxControl.IsGestureHelperMessage(var Message: TMessage): Boolean;
begin
  Result := (FGestureHelper <> nil) and FGestureHelper.HandleMessage(Message);
end;

function TcxControl.IsGestureScrolling: Boolean;
begin
  Result := FGestureHelper.IsPanning;
end;

function TcxControl.IsScrollBarBasedGestureScroll(AScrollKind: TScrollBarKind): Boolean;
begin
  Result := True;
end;

function TcxControl.GetDefaultPanOptions: Integer;
begin
  Result := dxTouchPanOptions;
end;

procedure TcxControl.ScrollContentByGesture(AScrollKind: TScrollBarKind; ADelta: Integer);
begin

end;

function TcxControl.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos);
  if not Result and IsMouseWheelHandleNeeded(Shift, WheelDelta, MousePos) then
  begin
    WheelDelta := EnsureRange(WheelDelta, -WHEEL_DELTA, WHEEL_DELTA);
    if FMouseWheelAccumulator * WheelDelta > 0 then
      Inc(FMouseWheelAccumulator, WheelDelta)
    else
      FMouseWheelAccumulator := WheelDelta;

    if Abs(FMouseWheelAccumulator) >= WHEEL_DELTA then
    begin
      InternalMouseWheel(Shift, FMouseWheelAccumulator, MousePos);
      FMouseWheelAccumulator := 0;
    end;
    Result := True;
  end;
end;

function TcxControl.DoShowPopupMenu(AMenu: TComponent; X, Y: Integer): Boolean;
begin
  Result := ShowPopupMenu(Self, AMenu, X, Y);
end;

procedure TcxControl.EraseBackground(DC: HDC);
begin
  if IsLoading then Exit;
  cxPaintCanvas.BeginPaint(DC);
  EraseBackground(cxPaintCanvas, ClientRect);
  cxPaintCanvas.EndPaint;
end;

procedure TcxControl.EraseBackground(ACanvas: TcxCanvas; const ARect: TRect);
begin
  if IsTransparentBackground then
    cxDrawTransparentControlBackground(Self, ACanvas, ARect)
  else
    FillRect(ACanvas.Handle, ARect, Brush.Handle);
end;

function TcxControl.GetPopupMenu: TPopupMenu;
begin
  if FPopupMenu is TPopupMenu then
    Result := TPopupMenu(FPopupMenu)
  else
    Result := nil;
end;

function TcxControl.InternalMouseWheel(Shift: TShiftState; WheelDelta: Integer;
   MousePos: TPoint): Boolean;
const
  ADirections: array[Boolean, Boolean] of TcxDirection = ((dirLeft, dirRight), (dirUp, dirDown));
  AScrollCode: array[Boolean] of TScrollCode = (scPageUp, scPageDown);
var
  I: Integer;
  AScrollPos: Integer;
begin
  Result := MouseWheelScrollingKind <> mwskNone;
  if Result then
    if Mouse.WheelScrollLines = -1 then
      Scroll(sbVertical, AScrollCode[WheelDelta < 0], AScrollPos)
    else
      for I := 0 to Mouse.WheelScrollLines - 1 do
        ScrollContent(ADirections[MouseWheelScrollingKind = mwskVertical, WheelDelta < 0]);
end;

function TcxControl.IsMenuKey(var Message: TWMKey): Boolean;
var
  AControl: TWinControl;
  AParentForm: TCustomForm;
  AControlPopupMenu: TPopupMenu;
begin
  Result := True;
  if not IsDesigning then
  begin
    AControl := Self;
    repeat
      AControlPopupMenu := TControlAccess(AControl).GetPopupMenu;
      if Assigned(AControlPopupMenu) and (AControlPopupMenu.WindowHandle <> 0) and
        AControlPopupMenu.IsShortCut(Message) then Exit;
      if (AControl is TcxControl) and
        IsPopupMenuShortCut(TcxControl(AControl).PopupMenu, Message) then Exit;
      AControl := AControl.Parent;
    until AControl = nil;
    AParentForm := GetParentForm(Self);
    if (AParentForm <> nil) and AParentForm.IsShortCut(Message) then Exit;
  end;
  with Message do
    if SendAppMessage(CM_APPKEYDOWN, CharCode, KeyData) <> 0 then Exit;
  Result := False;
end;

function TcxControl.IsDoubleBufferedNeeded: Boolean;
begin
  Result := DoubleBuffered or IsWinSevenOrLater;
end;

procedure TcxControl.Modified;
begin
  SetDesignerModified(Self);
end;

procedure TcxControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  procedure ProcessDragAndDrop;
  begin
    if FFinishingDragAndDrop then Exit; 
    if (Button = mbLeft) and not (ssDouble in Shift) and StartDragAndDrop(Point(X, Y)) then
      if DragAndDropObject.ImmediateStart then
        BeginDragAndDrop
      else
        DragAndDropState := ddsStarting
    else
      FinishDragAndDrop(False);
  end;

var
  ALink: TcxObjectLink;
  AOriginalBounds: TRect;
begin
  FMouseDownPos := Point(X, Y);
  ALink := cxAddObjectLink(Self);
  try
    if CanFocusOnClick(X, Y) and not (ssDouble in Shift) then  // to allow form showing on dbl click
    begin
      AOriginalBounds := BoundsRect;
      SetFocus;
      if ALink.Ref = nil then Exit;
      // to workaround the bug in VCL with parented forms
      if (GetParentForm(Self) <> nil) and (GetParentForm(Self).ActiveControl = Self) and
        not IsFocused then
        Windows.SetFocus(Handle);
      if not IsFocused and not AllowDragAndDropWithoutFocus then
      begin
        MouseCapture := False;
        Exit;
      end;
      if UpdateMousePositionIfControlMoved then
      begin
        Inc(X, AOriginalBounds.Left - Left);
        Inc(Y, AOriginalBounds.Top - Top);
      end;
    end;
    ProcessDragAndDrop;
    if ALink.Ref = nil then Exit;
    BeforeMouseDown(Button, Shift, X, Y);
    if ALink.Ref = nil then Exit;
    inherited;
  finally
    if ALink.Ref <> nil then
      if MouseCapture then FMouseButtonPressed := True;
    cxRemoveObjectLink(ALink);
  end;
end;

procedure TcxControl.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  AAccepted: Boolean;
begin
  inherited;
  if (DragAndDropState = ddsStarting) and not IsMouseInPressedArea(X, Y) then
    BeginDragAndDrop;
  if DragAndDropState = ddsInProcess then
  begin
    AAccepted := False;
    DragAndDrop(Point(X, Y), AAccepted);
  end;
end;

procedure TcxControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FMouseButtonPressed := False;
  CancelMouseOperations;
  inherited;
end;

procedure TcxControl.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = PopupMenu) then
    PopupMenu := nil;
end;

procedure TcxControl.SetParentBackground(Value: Boolean);
var
  AParentBackgroundChanged: Boolean;
begin
  AParentBackgroundChanged := Value <> ParentBackground;
  inherited;
  if AParentBackgroundChanged then
    ParentBackgroundChanged;
end;

procedure TcxControl.Paint;
var
  AIntf: IcxLockedStatePaint;
  ATopMostControl: TWinControl;
  P: TPoint;
begin
  if IsLoading then Exit;
  if Supports(Self, IcxLockedStatePaint, AIntf) and (AIntf.GetImage <> nil) then
  begin
    ATopMostControl := AIntf.GetTopmostControl;
    if ATopmostControl = Self then
      ActiveCanvas.Canvas.StretchDraw(ClientRect, AIntf.GetImage)
    else
    begin
      P := ClientToParent(cxNullPoint, ATopMostControl);
      cxBitBlt(ActiveCanvas.Handle, AIntf.GetImage.cxCanvas.Handle, ClientRect, P, SRCCOPY);
    end;
  end
  else
  begin
    (Canvas as TcxControlCanvas).BeginPaint;
    try
      DoPaint;
    finally
      (Canvas as TcxControlCanvas).EndPaint;
    end;
  end;
end;

procedure TcxControl.PaintNonClientArea(ACanvas: TcxCanvas);
begin
end;

procedure TcxControl.PaintWindow(DC: HDC);


begin
  if IsLoading then Exit;
  if Canvas.Canvas.HandleAllocated then
  begin
    Canvas.SaveDC;
    try
      inherited;
    finally
      Canvas.RestoreDC;
    end;
  end
  else
    inherited;
end;

procedure TcxControl.ColorChanged;
begin
end;

procedure TcxControl.DoScrolling;
const
  ScrollTimeStep = 20;
  ScrollValueStep = 5;
  MaxSpeed = 12;
var
  BreakOnMouseUp: Boolean;
  AllowHorScrolling, AllowVerScrolling: Boolean;
  P, PrevP, AnchorPos: TPoint;
  AnchorSize, Speed, TimerHits: Integer;
  AnchorWnd, CaptureWnd: HWND;
  ADirection: TcxDirection;
  ATimer: TdxNativeUInt;
  Msg: TMsg;

  function CreateScrollingAnchorWnd: HWND;
  var
    B: TBitmap;
    W, H: Integer;
    Rgn: HRGN;
    DC: HDC;

    function GetResourceBitmapName: string;
    begin
      if AllowHorScrolling and AllowVerScrolling then
        Result := 'CX_FULLSCROLLBITMAP'
      else
        if AllowHorScrolling then
          Result := 'CX_HORSCROLLBITMAP'
        else
          Result := 'CX_VERSCROLLBITMAP';
    end;

  begin
    B := TBitmap.Create;
    B.LoadFromResourceName(HInstance, GetResourceBitmapName);

    W := B.Width;
    H := B.Height;
    AnchorSize := W;
    with AnchorPos do
      Result := CreateWindowEx(WS_EX_TOPMOST, 'STATIC', nil, WS_POPUP,
        X - W div 2, Y - H div 2, W, H, Handle, 0, HInstance, nil);
    Rgn := CreateEllipticRgn(0, 0, W + 1, H + 1);
    SetWindowRgn(Result, Rgn, True);
    SetWindowPos(Result, 0, 0, 0, 0, 0,
      SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW or SWP_NOACTIVATE);

    DC := GetWindowDC(Result);
    BitBlt(DC, 0, 0, W, H, B.Canvas.Handle, 0, 0, SRCCOPY);
    Rgn := CreateEllipticRgn(0, 0, W + 1, H + 1);
    FrameRgn(DC, Rgn, GetSysColorBrush(COLOR_WINDOWTEXT), 1, 1);
    DeleteObject(Rgn);
    ReleaseDC(Result, DC);

    B.Free;
  end;

  procedure CalcDirectionAndSpeed(const P: TPoint);
  var
    DeltaX, DeltaY, SpeedValue: Integer;

    function GetNeutralZone: TRect;
    begin
      Result := Classes.Bounds(AnchorPos.X - AnchorSize div 2, AnchorPos.Y - AnchorSize div 2, AnchorSize, AnchorSize);
      if not AllowHorScrolling then
      begin
        Result.Left := 0;
        Result.Right := Screen.Width;
      end;
      if not AllowVerScrolling then
      begin
        Result.Top := 0;
        Result.Bottom := Screen.Height;
      end;
    end;

  begin
    if PtInRect(GetNeutralZone, P) then
    begin
      ADirection := dirNone;
      Speed := 0;
      Exit;
    end
    else
    begin
      BreakOnMouseUp := True;
      DeltaX := P.X - AnchorPos.X;
      DeltaY := P.Y - AnchorPos.Y;
      if AllowHorScrolling and (not AllowVerScrolling or (Abs(DeltaX) > Abs(DeltaY))) then
      begin
        if DeltaX < 0 then
          ADirection := dirLeft
        else
          ADirection := dirRight;
        SpeedValue := Abs(DeltaX);
      end
      else
      begin
        if DeltaY < 0 then
          ADirection := dirUp
        else
          ADirection := dirDown;
        SpeedValue := Abs(DeltaY);
      end;
    end;
    Dec(SpeedValue, AnchorSize div 2);
    Speed := 1 + SpeedValue div ScrollValueStep;
    if Speed > MaxSpeed then Speed := MaxSpeed;
  end;

  procedure SetMouseCursor;
  var
    Cursor: TCursor;
  begin
    case ADirection of
      dirLeft:
        Cursor := crLeftScroll;
      dirUp:
        Cursor := crUpScroll;
      dirRight:
        Cursor := crRightScroll;
      dirDown:
        Cursor := crDownScroll;
    else
      if AllowHorScrolling and AllowVerScrolling then
        Cursor := crFullScroll
      else
        if AllowHorScrolling then
          Cursor := crHorScroll
        else
          Cursor := crVerScroll;
    end;
    SetCursor(Screen.Cursors[Cursor]);
  end;

var
  AMessage: TMessage;
begin
  if not NeedsScrollBars then Exit;
  AllowHorScrolling := HScrollBarVisible;
  AllowVerScrolling := VScrollBarVisible;
  if not (AllowHorScrolling or AllowVerScrolling) then Exit;
  FIsScrollingContent := True;
  BreakOnMouseUp := False;
  PrevP := GetMouseCursorPos;
  AnchorPos := PrevP;
  AnchorWnd := CreateScrollingAnchorWnd;
  ADirection := dirNone;
  SetMouseCursor;
  Speed := 1;
  TimerHits := 0;
  ATimer := SetTimer(0, 0, ScrollTimeStep, nil);

  CaptureWnd := Handle;
  SetCapture(CaptureWnd);
  try
    while GetCapture = CaptureWnd do
    begin
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
            PostQuitMessage(Msg.wParam);
            Break;
          end;
      end;
      AMessage.Msg := Msg.message;
      AMessage.WParam := Msg.wParam;
      AMessage.LParam := msg.lParam;
      if (Msg.message = WM_PAINT) and (Msg.hwnd = AnchorWnd) then
      begin
        ValidateRect(AnchorWnd, nil);
        Continue;
      end;
      if (Msg.message >= WM_MOUSEFIRST) and (Msg.message <= WM_MOUSELAST) and
        (Msg.message <> WM_MOUSEMOVE) and (Msg.message <> WM_MBUTTONUP) then
        Break;
      try
        case Msg.message of
          WM_KEYDOWN, WM_KEYUP:
            if TWMKey(AMessage).CharCode = VK_ESCAPE then Break;
          WM_MOUSEMOVE:
            begin
              P := SmallPointToPoint(TWMMouse(AMessage).Pos);
              Windows.ClientToScreen(Msg.hwnd, P);
              if (P.X <> PrevP.X) or (P.Y <> PrevP.Y) then
              begin
                CalcDirectionAndSpeed(P);
                SetMouseCursor;
                PrevP := P;
              end;
            end;
          WM_LBUTTONDOWN, WM_RBUTTONDOWN:
            Break;
          WM_MBUTTONUP:
            if BreakOnMouseUp then Break;
          WM_TIMER:
            if TWMTimer(AMessage).TimerID = WPARAM(ATimer) then
            begin
              Inc(TimerHits);
              if TimerHits mod (MaxSpeed - Speed + 1) = 0 then
                ScrollContent(ADirection);
            end;
        end;
      finally
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  finally
    if GetCapture = CaptureWnd then ReleaseCapture;

    KillTimer(0, ATimer);
    DestroyWindow(AnchorWnd);
    FIsScrollingContent := False;
  end;
end;

procedure TcxControl.DoUpdateScrollBars;
var
  APrevUpdatingScrollBars, APrevHScrollBarVisible, APrevVScrollBarVisible: Boolean;

  procedure CalculateScrollBarsParams;
  var
    APrevHScrollBarVisible, APrevVScrollBarVisible: Boolean;

    procedure CheckPixelScrollBars;
    var
      AHideScrollBar: array[TScrollBarKind] of Boolean;
      I: TScrollBarKind;

      function CanHide(AScrollBarKind: TScrollBarKind): Boolean;
      var
        AData: TcxScrollBarData;
      begin
        AData := GetScrollBar(AScrollBarKind).Data;
        Result := AData.Visible and AData.Enabled and AData.AllowHide;
      end;

      function GetOppositeScrollBarSize(AScrollBarKind: TScrollBarKind): Integer;
      begin
        if AScrollBarKind = sbHorizontal then
          Result := VScrollBar.Width
        else
          Result := HScrollBar.Height;
      end;

      procedure CheckPixelScrollBar(AScrollBarKind: TScrollBarKind);
      var
        AData: TcxScrollBarData;
      begin
        AData := GetScrollBar(AScrollBarKind).Data;
        if IsPixelScrollBar(AScrollBarKind) and
          (AData.PageSize + GetOppositeScrollBarSize(AScrollBarKind) >= AData.Max - AData.Min + 1) then
          AHideScrollBar[AScrollBarKind] := True;
      end;

    begin
      if not CanHide(sbHorizontal) or not CanHide(sbVertical) then Exit;
      AHideScrollBar[sbHorizontal] := False;
      AHideScrollBar[sbVertical] := False;
      CheckPixelScrollBar(sbHorizontal);
      CheckPixelScrollBar(sbVertical);
      if AHideScrollBar[sbHorizontal] and AHideScrollBar[sbVertical] then
        for I := Low(TScrollBarKind) to High(TScrollBarKind) do
          with GetScrollBar(I).Data do
            SetScrollBarInfo(I, Min, Max, SmallChange, PageSize + GetOppositeScrollBarSize(I),
              Position, AllowShow, AllowHide);
    end;

  begin
    if FMainScrollBars.Calculating then Exit;
    FMainScrollBars.Calculating := True;
    try
      HScrollBar.Data.Visible := False;
      VScrollBar.Data.Visible := False;
      repeat
        APrevHScrollBarVisible := HScrollBarVisible;
        APrevVScrollBarVisible := VScrollBarVisible;
        //BoundsChanged; - causes things like Left/TopPos to be recalculated during scrolling
        InitScrollBarsParameters;
      until (HScrollBarVisible = APrevHScrollBarVisible) and
        (VScrollBarVisible = APrevVScrollBarVisible);
      CheckPixelScrollBars; 
    finally
      FMainScrollBars.Calculating := False;
    end;
  end;

  function GetIsInitialScrollBarsParams: Boolean;
  begin
    Result := APrevUpdatingScrollBars and
      (HScrollBar.Data.Visible = FInitialHScrollBarVisible) and
      (VScrollBar.Data.Visible = FInitialVScrollBarVisible);
  end;

  procedure CheckScrollBarParams(AScrollBar: IcxControlScrollBar; AInitialVisible: Boolean);
  begin
    with AScrollBar do
      if Visible <> AInitialVisible then
      begin
        Enabled := False;
        Visible := True;
      end;
  end;

  function IsBoundsChangeNeeded: Boolean;
  begin
    Result :=
      (HScrollBar.Visible <> APrevHScrollBarVisible) or
      (VScrollBar.Visible <> APrevVScrollBarVisible);
  end;

begin
  if not FUpdatingScrollBars then
  begin
    FInitialHScrollBarVisible := HScrollBar.Visible;
    FInitialVScrollBarVisible := VScrollBar.Visible;
  end;
  APrevUpdatingScrollBars := FUpdatingScrollBars;
  FUpdatingScrollBars := True;
  try
    APrevHScrollBarVisible := HScrollBar.Visible;
    APrevVScrollBarVisible := VScrollBar.Visible;
    if not FIsInitialScrollBarsParams then
    begin
      CalculateScrollBarsParams;
      FIsInitialScrollBarsParams := GetIsInitialScrollBarsParams;
      if FIsInitialScrollBarsParams then
      begin
        CheckScrollBarParams(HScrollBar, FInitialHScrollBarVisible);
        CheckScrollBarParams(VScrollBar, FInitialVScrollBarVisible);
      end
      else
        MainScrollBars.ApplyData;
    end;
    if IsBoundsChangeNeeded then
      BoundsChanged
    else
    begin
      FMainScrollBars.CheckSizeGripVisible(IsSizeGripVisible);
      SetInternalControlsBounds;
      if NeedsToBringInternalControlsToFront then
        BringInternalControlsToFront;
    end;
  finally
    if not APrevUpdatingScrollBars then
      FIsInitialScrollBarsParams := False;
    FUpdatingScrollBars := APrevUpdatingScrollBars;
  end;
end;

procedure TcxControl.ParentBackgroundChanged;
begin
end;

procedure TcxControl.VisibleChanged;
begin
end;

procedure TcxControl.AddChildComponent(AComponent: TcxControlChildComponent);
begin
  AComponent.Control := Self;
end;

procedure TcxControl.RemoveChildComponent(AComponent: TcxControlChildComponent);
begin
  AComponent.Control := nil;
end;

procedure TcxControl.AfterMouseDown(AButton: TMouseButton; X, Y: Integer);
begin
  if (DragMode = dmAutomatic) and (AButton = mbLeft) and
    MouseCapture and { to prevent drag and drop when mouse button is released already }
    (not IsDesigning or AllowAutoDragAndDropAtDesignTime(X, Y, [])) and
    CanDrag(X, Y) and (cxDragDetect(Handle, ClientToScreen(Point(X, Y))) = ddDrag) then
    BeginDrag(True{False});
  if AButton = mbMiddle then DoScrolling;
end;

function TcxControl.AllowAutoDragAndDropAtDesignTime(X, Y: Integer;
  Shift: TShiftState): Boolean;
begin
  Result := True;
end;

function TcxControl.AllowDragAndDropWithoutFocus: Boolean;
begin
  Result := False;
end;

function TcxControl.CanCancelDragStartOnCaptureObjectClear: Boolean;
begin
  Result := True;
end;

function TcxControl.CreateDragAndDropObject: TcxDragAndDropObject;
begin
  Result := GetDragAndDropObjectClass.Create(Self);
end;

procedure TcxControl.BeforeMouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
end;

procedure TcxControl.BoundsChanged;
begin
  UpdateScrollBars;
  if NeedRedrawOnResize then
    Invalidate;
end;

procedure TcxControl.BringInternalControlsToFront;
begin
  FMainScrollBars.BringInternalControlsToFront;
end;

procedure TcxControl.CancelMouseOperations;
begin
  FinishDragAndDrop(True);
  MouseCaptureObject := nil;
end;

function TcxControl.CanDrag(X, Y: Integer): Boolean;
begin
  Result := DragAndDropState = ddsNone;
end;

function TcxControl.AllowCompositionPainting: Boolean;
begin
  Result := True;
end;

function TcxControl.CanFocusOnClick: Boolean;
begin
  Result := not IsDesigning and FFocusOnClick and MayFocus and CanFocus;
end;

function TcxControl.CanFocusOnClick(X, Y: Integer): Boolean;
begin
  Result := CanFocusOnClick;
end;

procedure TcxControl.CursorChanged;
begin
end;

procedure TcxControl.DoCancelMode;
begin
  FMouseButtonPressed := False;
  MouseCaptureObject := nil;
end;

procedure TcxControl.DoPaint;
begin
  DrawScrollBars(Canvas);
  if FBorderStyle = cxcbsDefault then
  begin
    DrawBorder(Canvas);
    Canvas.IntersectClipRect(cxRectInflate(Bounds, -BorderSize, -BorderSize));
    SetPaintRegion;
  end;
  // CB9021 - bug in VCL: to actually show internal controls
  // if they were made visible when one of the parent's Showing was False
  UpdateInternalControlsState;
end;

procedure TcxControl.DrawBorder(ACanvas: TcxCanvas);
begin
  LookAndFeelPainter.DrawBorder(ACanvas, Bounds);
end;

procedure TcxControl.DrawScrollBars(ACanvas: TcxCanvas);
begin
  FScrollBarsManager.Paint(ACanvas);
  if FMainScrollBars <> nil then
    FMainScrollBars.DrawSizeGrip(ACanvas);
end;

procedure TcxControl.FocusChanged;
begin
  if Assigned(FOnFocusChanged) then FOnFocusChanged(Self);
end;

function TcxControl.FocusWhenChildIsClicked(AChild: TControl): Boolean;
begin
  Result := CanFocusOnClick;
end;

procedure TcxControl.FontChanged;
var
  I: Integer;
  AIntf: IcxLockedStateFontChanged;
begin
  if Supports(Self, IcxLockedStateFontChanged, AIntf) then
    AIntf.FontChanged(Font);
  for I := 0 to FFontListenerList.Count - 1 do
    IcxFontListener(FFontListenerList[I]).Changed(Self, Font);
  Invalidate;
end;

function TcxControl.GetBorderSize: Integer;
begin
  Result := IfThen(FBorderStyle = cxcbsDefault, LookAndFeelPainter.BorderSize);
end;

function TcxControl.GetBounds: TRect;
begin
  if IsRectEmpty(FBounds) then
    if HandleAllocated then
      Result := ClientRect
    else
      Result := Rect(0, 0, Width, Height)
  else
    Result := FBounds;
end;

function TcxControl.GetClientBounds: TRect;
begin
  Result := Bounds;
  InflateRect(Result, -BorderSize, -BorderSize);
  if HScrollBarVisible then
    Dec(Result.Bottom, HScrollBar.Height);
  if VScrollBarVisible then
    Dec(Result.Right, VScrollBar.Width);
end;

function TcxControl.GetClientOffsets: TRect;
begin
  Result := cxNullRect;
end;

function TcxControl.GetCurrentCursor(X, Y: Integer): TCursor;
begin
  if IsScrollBarsArea(Point(X, Y)) then
    Result := crArrow
  else
    Result := Cursor;
end;

function TcxControl.GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean;
begin
  Result := (DragAndDropState <> ddsNone) or FMouseButtonPressed or
    IsScrollBarsArea(Point(X, Y));
end;

function TcxControl.GetDragObjectClass: TDragControlObjectClass;
begin
  Result := TcxDragControlObject;
end;

function TcxControl.GetIsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TcxControl.GetIsFocused: Boolean;
begin                                {7}
  Result := Focused;
end;

function TcxControl.GetMainScrollBarsClass: TcxControlCustomScrollBarsClass;
begin
  Result := TcxControlWindowedScrollBars;
end;

function TcxControl.GetMouseCursorClientPos: TPoint;
begin
  Result := ScreenToClient(GetMouseCursorPos);
end;

function TcxControl.GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind;
begin
  if VScrollBarVisible then
    Result := mwskVertical
  else
    Result := mwskNone;
end;

function TcxControl.GetPaintBlackOpaqueOnGlass: Boolean;
begin
{$IFDEF DELPHI15}
  Result := csPaintBlackOpaqueOnGlass in ControlStyle;
{$ELSE}
  Result := False;
{$ENDIF}
end;

function TcxControl.GetScrollBarClass(AKind: TScrollBarKind): TcxControlScrollBarClass;
begin
  Result := TcxControlScrollBar;
end;

function TcxControl.GetSizeGripClass: TcxSizeGripClass;
begin
  Result := TcxSizeGrip;
end;

function TcxControl.HasBackground: Boolean;
begin
  Result := IsTransparentBackground;
end;

function TcxControl.HasNonClientArea: Boolean;
begin
  Result := False;
end;

function TcxControl.IsMouseWheelHandleNeeded(Shift: TShiftState; WheelDelta: Integer;
   MousePos: TPoint): Boolean;
begin
  Result := MouseWheelScrollingKind <> mwskNone;
end;

function TcxControl.IsTransparentBackground: Boolean;
begin
  Result := cxIsVCLThemesEnabled and Assigned(Parent) and (csParentBackground in ControlStyle)
end;

procedure TcxControl.InitControl;
begin
  InitScrollBars;
end;

class procedure TcxControl.InvalidateControl(AControl: TWinControl; ANeedInvalidateSelf, ANeedInvalidateChildren: Boolean);

  function NeedInvalidateControl(AControl: TControl): Boolean;
  var
    AcxTransparentControl: IcxTransparentControl;
  begin
    if Supports(AControl, IcxTransparentControl, AcxTransparentControl) then
      Result := AcxTransparentControl.IsTransparentRegionsPresent
    else
      Result := (AControl is TWinControl) and
        (not (csOpaque in AControl.ControlStyle) or (csParentBackground in AControl.ControlStyle));
  end;

var
  I: Integer;
begin
  if AControl.HandleAllocated then
  begin
    if AControl.Parent <> nil then
      AControl.Parent.Perform(CM_INVALIDATE, 1, 0);
    if ANeedInvalidateSelf then
    begin
      cxInvalidateRect(AControl.Handle, not (csOpaque in AControl.ControlStyle));
      if ANeedInvalidateChildren then
      begin
        for I := 0 to AControl.ControlCount - 1 do
          if NeedInvalidateControl(AControl.Controls[I]) then
            AControl.Controls[I].Invalidate;
      end;
    end;
  end;
end;

function TcxControl.IsInternalControl(AControl: TControl): Boolean;
begin
  Result := (FMainScrollBars <> nil) and FMainScrollBars.IsInternalControl(AControl);
end;

function TcxControl.MayFocus: Boolean;
begin
  Result := True;
end;

procedure TcxControl.MouseEnter(AControl: TControl);
begin
  if ((AControl = Self) or (AControl = nil)) and (FMouseEnterCounter = 0) then
  begin
    Inc(FMouseEnterCounter);
    dxCallNotify(FOnMouseEnter, Self);
  end;
end;

procedure TcxControl.MouseLeave(AControl: TControl);
begin
  if ((AControl = Self) or (AControl = nil)) and (FMouseEnterCounter = 1) then
  begin
    Dec(FMouseEnterCounter);
    dxCallNotify(FOnMouseLeave, Self);
 end;
end;

procedure TcxControl.FocusEnter;
begin
//do nothing
end;

procedure TcxControl.FocusLeave;
begin
//do nothing
end;

procedure TcxControl.SetPaintRegion;
begin
  Canvas.IntersectClipRect(ClientBounds);
end;

function TcxControl.NeedRedrawOnResize: Boolean;
begin
  Result := False;
end;

procedure TcxControl.TextChanged;
begin
end;

function TcxControl.UpdateMousePositionIfControlMoved: Boolean;
begin
  Result := True;
end;

function TcxControl.AllowGesture(AGestureId: Integer): Boolean;
begin
{$IFNDEF DELPHI14}
   Result := IsDefaultGesture(AGestureId);
{$ELSE}
   Result := (GetInteractiveGestureByGestureID(AGestureId) in Touch.InteractiveGestures);
{$ENDIF}
end;

function TcxControl.AllowPan(AScrollKind: TScrollBarKind): Boolean;
begin
  if CanScrollContentByGestureWithoutScrollBars then
    if AScrollKind = sbHorizontal then
      Result := MouseWheelScrollingKind <> mwskVertical
    else
      Result := MouseWheelScrollingKind = mwskVertical
  else
    if AScrollKind = sbHorizontal then
      Result := HScrollBarVisible and
       ((MouseWheelScrollingKind = mwskHorizontal) or not VScrollBarVisible)
    else
      Result := VScrollBarVisible and
       ((MouseWheelScrollingKind = mwskVertical) or not HScrollBarVisible);
end;

function TcxControl.GetPanOptions: Integer;
begin
{$IFDEF DELPHI14}
  Result := GetPanOptionsByInteractiveGestureOptions(Touch.InteractiveGestureOptions);
  if igPan in Touch.InteractiveGestures then
    Result := GC_PAN or Result;
{$ELSE}
  Result := GetDefaultPanOptions;
{$ENDIF}
end;

function TcxControl.IsPanArea(const APoint: TPoint): Boolean;
begin
  Result := PtInRect(ClientBounds, APoint) and not IsScrollBarsArea(APoint);
end;

function TcxControl.NeedPanningFeedback(AScrollKind: TScrollBarKind): Boolean;
begin
  Result := True;
end;

function TcxControl.GetGestureClient(const APoint: TPoint): IdxGestureClient;
begin
  Result := Self;
end;

function TcxControl.GetGestureClientHandle: THandle;
begin
  Result := Handle;
end;

function TcxControl.IsGestureTarget(AWnd: THandle): Boolean;
begin
  Result := AWnd = Handle;
end;

function TcxControl.GetLookAndFeelValue: TcxLookAndFeel;
begin
  Result := LookAndFeel;
end;

function TcxControl.GetControl: TWinControl;
begin
  Result := Self;
end;

function TcxControl.GetScrollBarLookAndFeel: TcxLookAndFeel;
begin
  Result := FLookAndFeel;
end;

function TcxControl.GetLookAndFeelPainter: TcxCustomLookAndFeelPainter;
begin
  Result := LookAndFeel.Painter;
end;

procedure TcxControl.LookAndFeelChangeHandler(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
  if not (csDestroying in (Application.ComponentState + ComponentState)) then
    LookAndFeelChanged(Sender, AChangedValues);
end;

procedure TcxControl.LookAndFeelChanged(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
end;

procedure TcxControl.InitScrollBarsParameters;
begin
end;

function TcxControl.IsPixelScrollBar(AKind: TScrollBarKind): Boolean;
begin
  Result := False;
end;

function TcxControl.IsScrollBarsArea(const APoint: TPoint): Boolean;
begin
  Result := FScrollBarsManager.IsScrollBarsArea(APoint) or IsSizeGripArea(APoint);
end;

function TcxControl.IsScrollBarsCapture: Boolean;
begin
  Result := FScrollBarsManager.IsCapture;
end;

function TcxControl.IsSizeGripArea(const APoint: TPoint): Boolean;
begin
  Result := (FMainScrollBars <> nil) and FMainScrollBars.IsSizeGripArea(APoint);
end;

function TcxControl.IsSizeGripVisible: Boolean;
begin
  Result := HScrollBar.Visible and VScrollBar.Visible;
end;

function TcxControl.NeedsScrollBars: Boolean;
begin
  Result := True;
end;

function TcxControl.NeedsToBringInternalControlsToFront: Boolean;
begin
{$IFDEF DELPHI9}
  Result := not IsDesigning;
{$ELSE}
  Result := True;
{$ENDIF}
end;

procedure TcxControl.Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
  var AScrollPos: Integer);
begin
end;

function TcxControl.CanScrollLineWithoutScrollBars(ADirection: TcxDirection): Boolean;
begin
  Result := False;
end;

function TcxControl.CanUpdateScrollBars: Boolean;
begin
  Result := NeedsScrollBars;
end;

procedure TcxControl.CheckNeedsScrollBars;
begin
  if NeedsScrollBars then
  begin
    CreateScrollBars;
    if HandleAllocated then
      InitScrollBars;
  end
  else
    DestroyScrollBars;
end;

function TcxControl.GetHScrollBarBounds: TRect;
begin
  Result := ClientBounds;
  Result.Top := Result.Bottom;
  Result.Bottom := Result.Top + HScrollBar.Height;
end;

function TcxControl.GetSizeGripBounds: TRect;
begin
  with Result do
  begin
    Left := VScrollBar.Left;
    Right := Left + VScrollBar.Width;
    Top := HScrollBar.Top;
    Bottom := Top + HScrollBar.Height;
  end;
end;

function TcxControl.GetScrollBar(AKind: TScrollBarKind): IcxControlScrollBar;
begin
  if FMainScrollBars <> nil then
    Result := FMainScrollBars.GetScrollBar(AKind)
  else
    Result := nil;
end;

function TcxControl.GetSystemSizeScrollBars: TcxScrollStyle;
begin
  Result := ssBoth;
end;

function TcxControl.GetVScrollBar: IcxControlScrollBar;
begin
  Result := GetScrollBar(sbVertical);
end;

function TcxControl.GetVScrollBarBounds: TRect;
begin
  Result := ClientBounds;
  Result.Left := Result.Right;
  Result.Right := Result.Left + VScrollBar.Width;
end;

procedure TcxControl.InitScrollBars;
begin
  if NeedsScrollBars then
    FMainScrollBars.InitScrollBars;
end;

procedure TcxControl.SetInternalControlsBounds;
begin
  FMainScrollBars.SetInternalControlsBounds;
end;

procedure TcxControl.UpdateInternalControlsState;
begin
  if NeedsScrollBars then
    FMainScrollBars.UpdateInternalControlsState;
end;

procedure TcxControl.UpdateScrollBars;
begin
  if not CanUpdateScrollBars then Exit;
  if FScrollBarsLockCount > 0 then
  begin
    FScrollBarsUpdateNeeded := True;
    Exit;
  end;
  DoUpdateScrollBars;
end;

procedure TcxControl.DragAndDrop(const P: TPoint; var Accepted: Boolean);
begin
  DragAndDropObject.DoDragAndDrop(P, Accepted);
end;

procedure TcxControl.EndDragAndDrop(Accepted: Boolean);
begin
  DragAndDropState := ddsNone;
  Screen.Cursor := FDragAndDropPrevCursor;
  MouseCapture := False;
  MouseCaptureObject := nil;
  DragAndDropObject.DoEndDragAndDrop(Accepted);
  {DragAndDropObject.DoEndDragAndDrop(Accepted);
  SetCaptureControl(nil);
  DragAndDropState := ddsNone;
  Screen.Cursor := FDragAndDropPrevCursor;}
end;

function TcxControl.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  Result := FDragAndDropObjectClass;
  if Result = nil then
    Result := TcxDragAndDropObject;
end;

function TcxControl.StartDragAndDrop(const P: TPoint): Boolean;
begin
  Result := False;
end;

procedure TcxControl.DoStartDrag(var DragObject: TDragObject);
begin
  Update;
  inherited;
  if (DragObject = nil) and (GetDragObjectClass <> nil) then
    DragObject := GetDragObjectClass.Create(Self);
  if not StartDrag(DragObject) then
  begin
    DragObject.Free;
    DragObject := nil;
    CancelDrag;
  end;
end;

procedure TcxControl.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited;
  FreeAndNil(FDragImages);
end;

procedure TcxControl.DragOver(Source: TObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  if Source is TDragObject then
    if State = dsDragLeave then
      FDragObject := nil
    else
      FDragObject := TDragObject(Source);
  inherited;
end;

procedure TcxControl.DrawDragImage(ACanvas: TcxCanvas; const R: TRect);
begin
end;

function TcxControl.GetDragImages: TDragImageList;
begin
  if HasDragImages then
  begin
    if FDragImages = nil then
    begin
      FDragImages := GetDragImagesClass.Create(nil);
      InitDragImages(FDragImages);
    end;
    if FDragImages.Count = 0 then
      Result := nil
    else
      Result := FDragImages;
  end
  else
    Result := nil;
end;

function TcxControl.GetDragImagesClass: TcxDragImageListClass;
begin
  Result := TcxDragImageList;
end;

function TcxControl.GetDragImagesSize: TPoint;
begin
  Result := Point(0, 0);
end;

function TcxControl.GetIsCopyDragDrop: Boolean;
begin
  Result := IsCtrlPressed;
end;

function TcxControl.HasDragImages: Boolean;
begin
  Result := False;
end;

procedure TcxControl.HideDragImage;
begin
  if GetDragObject <> nil then
    GetDragObject.HideDragImage;
end;

procedure TcxControl.InitDragImages(ADragImages: TcxDragImageList);
var
  B: TBitmap;
  ACanvas: TcxCanvas;
begin
  with ADragImages, GetDragImagesSize do
  begin
    Width := X;
    Height := Y;
    if (X = 0) or (Y = 0) then Exit;
  end;

  B := TBitmap.Create;
  try
    with B do
    begin
      Width := ADragImages.Width;
      Height := ADragImages.Height;
      ACanvas := TcxCanvas.Create(Canvas);
      try
        DrawDragImage(ACanvas, Rect(0, 0, Width, Height));
      finally
        ACanvas.Free;
      end;
    end;
    ADragImages.AddMasked(B, B.TransparentColor);
  finally
    B.Free;
  end;
end;

procedure TcxControl.ShowDragImage;
begin
  if GetDragObject <> nil then
    GetDragObject.ShowDragImage;
end;

function TcxControl.CanFocusEx: Boolean;
var
  AParentForm: TCustomForm;
begin
  AParentForm := GetParentForm(Self);
  Result := CanFocus and ((AParentForm = nil) or
    AParentForm.CanFocus and AParentForm.Enabled and AParentForm.Visible);
end;

function TcxControl.AcceptMousePosForClick(X, Y: Integer): Boolean;
begin
  Result := (DragMode = dmManual) or IsMouseInPressedArea(X, Y);
end;

procedure TcxControl.InvalidateRect(const R: TRect; EraseBackground: Boolean);
begin
  if HandleAllocated then
    cxInvalidateRect(Handle, R, EraseBackground);
end;

procedure TcxControl.InvalidateRgn(ARegion: TcxRegion; EraseBackground: Boolean);
begin
  if HandleAllocated and (ARegion <> nil) and not ARegion.IsEmpty then
    Windows.InvalidateRgn(Handle, ARegion.Handle, EraseBackground);
end;

procedure TcxControl.InvalidateWithChildren;
begin
  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_NOERASE);
end;

function TcxControl.IsMouseInPressedArea(X, Y: Integer): Boolean;
begin
  Result := IsPointInDragDetectArea(MouseDownPos, X, Y);
end;

procedure TcxControl.PostMouseMove;
begin
  if HandleAllocated then
    PostMouseMove(ScreenToClient(GetMouseCursorPos));
end;

procedure TcxControl.PostMouseMove(AMousePos: TPoint);
begin
  if HandleAllocated and (GetCapture = 0) then 
    with AMousePos do
      PostMessage(Handle, WM_MOUSEMOVE, 0, MakeLParam(X, Y));
end;

procedure TcxControl.ScrollContent(ADirection: TcxDirection);

  function GetScrollBarKind: TScrollBarKind;
  begin
    if ADirection in [dirLeft, dirRight] then
      Result := sbHorizontal
    else
      Result := sbVertical;
  end;

  function GetScrollCode: TScrollCode;
  begin
    if ADirection in [dirLeft, dirUp] then
      Result := scLineUp
    else
      Result := scLineDown;
  end;

  function GetScrollPos: Integer;
  begin
    if not NeedsScrollBars then
      Result := 0
    else
      Result := GetScrollBar(GetScrollBarKind).Position;
  end;

var
  AScrollPos: Integer;
begin
  if (ADirection = dirNone) or
    not NeedsScrollBars and not CanScrollLineWithoutScrollBars(ADirection) then
      Exit;
  AScrollPos := GetScrollPos;
  Scroll(GetScrollBarKind, GetScrollCode, AScrollPos);
  Update;
end;

procedure TcxControl.ScrollWindow(DX, DY: Integer; const AScrollRect: TRect);
begin
  HideDragImage;
  try
    ScrollWindowEx(Handle, DX, DY, @AScrollRect, nil, 0, nil, SW_ERASE or SW_INVALIDATE);
  finally
    ShowDragImage;
  end;
end;

procedure TcxControl.SetScrollBarInfo(AScrollBarKind: TScrollBarKind;
  AMin, AMax, AStep, APage, APos: Integer; AAllowShow, AAllowHide: Boolean);
var
  AScrollBarData: TcxScrollBarData;
  AAllowShowInOptions: Boolean;
begin
  AScrollBarData := GetScrollBar(AScrollBarKind).Data;
  AScrollBarData.PageSize := APage;
  AScrollBarData.Min := AMin;
  AScrollBarData.Max := AMax;
  AScrollBarData.SmallChange := AStep;
  AScrollBarData.LargeChange := APage;
  AScrollBarData.Position := APos;
  AScrollBarData.Validate;

  if AScrollBarKind = sbHorizontal then
    AAllowShowInOptions := FScrollBars in [ssHorizontal, ssBoth]
  else
    AAllowShowInOptions := FScrollBars in [ssVertical, ssBoth];

  AScrollBarData.AllowShow := AAllowShow and AAllowShowInOptions;
  AScrollBarData.AllowHide := AAllowHide;

  if AScrollBarData.AllowShow then
    if not AScrollBarData.IsValid then
      if AScrollBarData.AllowHide then
        AScrollBarData.Visible := False
      else
      begin
        AScrollBarData.Enabled := False;
        AScrollBarData.Visible := True;
      end
    else
    begin
      AScrollBarData.Enabled := True;
      AScrollBarData.Visible := True;
    end
  else
    AScrollBarData.Visible := False;
end;

function TcxControl.StartDrag(DragObject: TDragObject): Boolean;
begin
  Result := True;
end;

procedure TcxControl.UpdateWithChildren;
begin
  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_UPDATENOW or RDW_ALLCHILDREN);
end;

procedure TcxControl.BeginDragAndDrop;
begin
  DragAndDropObject.DoBeginDragAndDrop;
  MouseCapture := True;
  FDragAndDropPrevCursor := Screen.Cursor;
  DragAndDropState := ddsInProcess;
end;

procedure TcxControl.FinishDragAndDrop(Accepted: Boolean);
begin
  if FFinishingDragAndDrop then Exit;
  FFinishingDragAndDrop := True;
  try
    if DragAndDropState = ddsInProcess then
      EndDragAndDrop(Accepted)
    else
      DragAndDropState := ddsNone;
    FreeAndNil(FDragAndDropObject);
  finally
    FFinishingDragAndDrop := False;
  end;
end;

procedure TcxControl.AddFontListener(AListener: IcxFontListener);
begin
  FFontListenerList.Add(AListener);
end;

procedure TcxControl.RemoveFontListener(AListener: IcxFontListener);
begin
  FFontListenerList.Remove(AListener);
end;

procedure TcxControl.LockScrollBars;
begin
  if FScrollBarsLockCount = 0 then
    FScrollBarsUpdateNeeded := False;
  Inc(FScrollBarsLockCount);
end;

procedure TcxControl.UnlockScrollBars;
begin
  if FScrollBarsLockCount > 0 then
  begin
    Dec(FScrollBarsLockCount);
    if (FScrollBarsLockCount = 0) and FScrollBarsUpdateNeeded then
      UpdateScrollBars;
  end;
end;

procedure TcxControl.TranslationChanged;
begin
end;

procedure TcxControl.SystemInfoChanged(AParameter: Cardinal);
begin
  if HandleAllocated then
    SendNotifyMessage(Handle, DXM_NCSIZECHANGED, 0, 0);
end;

{ TcxScrollingControl }

const
  dxcScrollStep = 10;

procedure TcxScrollingControl.LookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
begin
  inherited LookAndFeelChanged(Sender, AChangedValues);
  LayoutChanged;
end;

procedure TcxScrollingControl.BoundsChanged;
begin
  LayoutChanged;
end;

procedure TcxScrollingControl.Calculate(AType: TdxChangeType);
begin

end;

procedure TcxScrollingControl.LayoutChanged(AType: TdxChangeType);
begin
  if HandleAllocated then
  begin
    Calculate(AType);
    if AutoSize then
      AdjustSize;
    UpdateScrollBars;
    CheckPositions;
    Invalidate;
  end;
end;

procedure TcxScrollingControl.ScrollPosChanged;
begin
  LayoutChanged(ctLight);
  Invalidate;
  Update;
end;

function TcxScrollingControl.IsScrollDataValid: Boolean;
begin
  Result := HandleAllocated;
end;

procedure TcxScrollingControl.CheckPositions;
begin
  LeftPos := LeftPos;
  TopPos := TopPos;
end;

procedure TcxScrollingControl.CheckLeftPos(var AValue: Integer);
begin
  AValue := Max(Min(AValue, GetContentSize.cx - GetClientSize.cx), 0);
end;

procedure TcxScrollingControl.CheckTopPos(var AValue: Integer);
begin
  AValue := Max(Min(AValue, GetContentSize.cy - GetClientSize.cy), 0);
end;

function TcxScrollingControl.GetContentSize: TSize;
begin
  Result := cxNullSize;
end;

function TcxScrollingControl.GetClientSize: TSize;
begin
  Result := cxSize(ClientBounds);
end;

procedure TcxScrollingControl.InitScrollBarsParameters;
begin
  inherited;
  if IsScrollDataValid then
  begin
    SetScrollBarInfo(sbHorizontal, 0, GetContentSize.cx - 1,
      dxcScrollStep, GetClientSize.cx, LeftPos, True, True);
    SetScrollBarInfo(sbVertical, 0, GetContentSize.cy - 1,
      dxcScrollStep, GetClientSize.cy, TopPos, True, True);
  end;
end;

procedure TcxScrollingControl.MakeVisible(const ARect: TRect; AFully: Boolean);

  procedure MakeVisibleInOneDirection(AItemMin, AItemMax,
    AClientMin, AClientMax: Integer; AIsHorizontal: Boolean);
  var
    AOffset: Integer;

    procedure ChangeOffset(ADelta: Integer);
    begin
      Inc(AOffset, ADelta);
      Dec(AItemMin, ADelta);
      Dec(AItemMax, ADelta);
    end;

    procedure ApplyOffset;
    begin
      if AIsHorizontal then
        LeftPos := LeftPos + AOffset
      else
        TopPos := TopPos + AOffset;
    end;

  begin
    AOffset := 0;
    if AFully then
    begin
      if AItemMin < AClientMin then
        ChangeOffset(AItemMin - AClientMin)
      else
        if AItemMax > AClientMax then
          ChangeOffset(AItemMax - AClientMax)
    end
    else
      if AItemMin > AClientMax then
        ChangeOffset(AItemMax - AClientMax)
      else
        if AItemMax < AClientMin then
          ChangeOffset(AItemMin - AClientMin);

    ApplyOffset;
  end;
  
var
  AClientRect: TRect;
begin
  AClientRect := GetClientBounds;
  MakeVisibleInOneDirection(ARect.Left, ARect.Right, AClientRect.Left, AClientRect.Right, True);
  MakeVisibleInOneDirection(ARect.Top, ARect.Bottom, AClientRect.Top, AClientRect.Bottom, False);
end;

procedure TcxScrollingControl.SetAutoSize(Value: Boolean);
const
  AutoSizeModeMap: array[Boolean] of TdxAutoSizeMode = (asNone, asAutoSize);
begin
  if not FAutoSizeModeSetting and (Autosize <> Value) then
    FAutoSizeMode := AutoSizeModeMap[Value];

  inherited;
end;

procedure TcxScrollingControl.SetAutoSizeMode(AValue: TdxAutoSizeMode);
begin
  if FAutoSizeMode <> AValue then
  begin
    FAutoSizeModeSetting := True;
    try
      FAutoSizeMode := AValue;
      if AutoSize and (FAutoSizeMode <> asNone) then
        AdjustSize
      else
        AutoSize := FAutoSizeMode <> asNone;
    finally
     FAutoSizeModeSetting := False;
    end;
  end;
end;

procedure TcxScrollingControl.SetLeftPos(AValue: Integer);
begin
  CheckLeftPos(AValue);
  if FLeftPos <> AValue then
  begin
    FLeftPos := AValue;
    if IsScrollDataValid then
      ScrollPosChanged;
  end;
end;

procedure TcxScrollingControl.SetTopPos(AValue: Integer);
begin
  CheckTopPos(AValue);
  if FTopPos <> AValue then
  begin
    FTopPos := AValue;
    if IsScrollDataValid then
      ScrollPosChanged;
  end;
end;

procedure TcxScrollingControl.Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode; var AScrollPos: Integer);

  function GetContentPos: Integer;
  begin
    if AScrollBarKind = sbHorizontal then
      Result := LeftPos
    else
      Result := TopPos;
  end;

  procedure SetContentPos(Value: Integer);
  begin
    if AScrollBarKind = sbHorizontal then
      LeftPos := Value
    else
      TopPos := Value;
  end;

  function GetPageScrollStep: Integer;
  begin
    if AScrollBarKind = sbHorizontal then
      Result := ClientWidth
    else
      Result := ClientHeight;
  end;

begin
  inherited;
  case AScrollCode of
    scLineUp:
      SetContentPos(GetContentPos - dxcScrollStep);
    scLineDown:
      SetContentPos(GetContentPos + dxcScrollStep);
    scPageUp:
      SetContentPos(GetContentPos - GetPageScrollStep);
    scPageDown:
      SetContentPos(GetContentPos + GetPageScrollStep);
    scTrack:
      SetContentPos(AScrollPos);
  end;
  AScrollPos := GetContentPos;
end;

function TcxScrollingControl.GetTopPos: Integer;
begin
  Result := FTopPos;
end;

function TcxScrollingControl.GetLeftPos: Integer;
begin
  Result := FLeftPos;
end;

function TcxScrollingControl.GetInstance: TcxControl;
begin
  Result := Self;
end;

{ TdxScrollHelper }

class function TdxScrollHelper.IsScrollDataValid(AControl: IdxScrollingControl): Boolean;
begin
  Result := AControl.GetInstance.HandleAllocated;
end;

class procedure TdxScrollHelper.GestureScroll(AControl: IdxScrollingControl; ADeltaX, ADeltaY: Integer);
var
  ANewPos: TPoint;
  AHScrollEnabled, AVScrollEnabled: Boolean;
  AInstance: TcxControl;
begin
  AInstance := AControl.GetInstance;
  AHScrollEnabled := AInstance.HScrollBarVisible and AInstance.HScrollBar.Enabled;
  AVScrollEnabled := AInstance.VScrollBarVisible and AInstance.VScrollBar.Enabled;
  if not AHScrollEnabled then
    ADeltaX := 0;
  if not AVScrollEnabled then
    ADeltaY := 0;
  ANewPos := Point(AControl.GetLeftPos - ADeltaX, AControl.GetTopPos - ADeltaY);
  if AHScrollEnabled and (ADeltaX <> 0) then
    AInstance.GestureHelper.CheckOverpan(sbHorizontal, ANewPos.X, 0,
      AControl.GetContentSize.cx - GetClientSize(AControl).cx, ADeltaX, ADeltaY);
  if AVScrollEnabled and (ADeltaY <> 0) then
    AInstance.GestureHelper.CheckOverpan(sbVertical, ANewPos.Y, 0,
      AControl.GetContentSize.cy - GetClientSize(AControl).cy, ADeltaX, ADeltaY);
  SetPos(AControl, ANewPos.X, ANewPos.Y);
end;

class function TdxScrollHelper.GetClientSize(AControl: IdxScrollingControl): TSize;
begin
  Result := cxSize(AControl.GetInstance.ClientBounds);
end;

class procedure TdxScrollHelper.InitScrollBarsParameters(AControl: IdxScrollingControl);
begin
  AControl.GetInstance.SetScrollBarInfo(sbHorizontal, 0, AControl.GetContentSize.cx - 1,
    dxcScrollStep, GetClientSize(AControl).cx, AControl.GetLeftPos, True, True);
  AControl.GetInstance.SetScrollBarInfo(sbVertical, 0, AControl.GetContentSize.cy - 1,
    dxcScrollStep, GetClientSize(AControl).cy, AControl.GetTopPos, True, True);
end;

class procedure TdxScrollHelper.Scroll(AControl: IdxScrollingControl;
  AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode; var AScrollPos: Integer);

  function GetContentPos: Integer;
  begin
    if AScrollBarKind = sbHorizontal then
      Result := AControl.GetLeftPos
    else
      Result := AControl.GetTopPos;
  end;

  procedure SetContentPos(Value: Integer);
  begin
    if AScrollBarKind = sbHorizontal then
      SetLeftPos(AControl, Value)
    else
      SetTopPos(AControl, Value);
  end;

  function GetPageScrollStep: Integer;
  begin
    if AScrollBarKind = sbHorizontal then
      Result := AControl.GetInstance.ClientWidth
    else
      Result := AControl.GetInstance.ClientHeight;
  end;

begin
  inherited;
  case AScrollCode of
    scLineUp:
      SetContentPos(GetContentPos - dxcScrollStep);
    scLineDown:
      SetContentPos(GetContentPos + dxcScrollStep);
    scPageUp:
      SetContentPos(GetContentPos - GetPageScrollStep);
    scPageDown:
      SetContentPos(GetContentPos + GetPageScrollStep);
    scTrack:
      SetContentPos(AScrollPos);
  end;
  AScrollPos := GetContentPos;
end;

class procedure TdxScrollHelper.CheckPositions(AControl: IdxScrollingControl);
begin
  SetPos(AControl, AControl.GetLeftPos, AControl.GetTopPos);
end;

class procedure TdxScrollHelper.CheckLeftPos(AControl: IdxScrollingControl; var AValue: Integer);
begin
  AValue := Max(Min(AValue, AControl.GetContentSize.cx - GetClientSize(AControl).cx), 0);
end;

class procedure TdxScrollHelper.CheckTopPos(AControl: IdxScrollingControl; var AValue: Integer);
begin
  AValue := Max(Min(AValue, AControl.GetContentSize.cy - GetClientSize(AControl).cy), 0);
end;

class procedure TdxScrollHelper.SetPos(AControl: IdxScrollingControl; X, Y: Integer);
begin
  CheckLeftPos(AControl, X);
  CheckTopPos(AControl, Y);
  if (AControl.GetLeftPos <> X) or (AControl.GetTopPos <> Y) then
  begin
    AControl.SetLeftPos(X);
    AControl.SetTopPos(Y);
    if IsScrollDataValid(AControl) then
      ScrollContent(AControl);
  end;
end;

class procedure TdxScrollHelper.SetLeftPos(AControl: IdxScrollingControl; AValue: Integer);
begin
  CheckLeftPos(AControl, AValue);
  if AControl.GetLeftPos <> AValue then
  begin
    AControl.SetLeftPos(AValue);
    if IsScrollDataValid(AControl) then
      ScrollContent(AControl);
  end;
end;

class procedure TdxScrollHelper.SetTopPos(AControl: IdxScrollingControl; AValue: Integer);
begin
  CheckTopPos(AControl, AValue);
  if AControl.GetTopPos <> AValue then
  begin
    AControl.SetTopPos(AValue);
    if IsScrollDataValid(AControl) then
      ScrollContent(AControl);
  end;
end;

class procedure TdxScrollHelper.ScrollContent(AControl: IdxScrollingControl);
begin
  AControl.GetInstance.UpdateScrollBars;
  CheckPositions(AControl);
  AControl.GetInstance.Invalidate;
  AControl.GetInstance.Update;
end;

{ TcxCustomizeListBox }

constructor TcxCustomizeListBox.Create(AOwner: TComponent);
begin
  inherited;
  FDragAndDropItemIndex := -1;
end;

function TcxCustomizeListBox.GetDragAndDropItemObject: TObject;
begin
  Result := Items.Objects[FDragAndDropItemIndex];
end;

function TcxCustomizeListBox.GetItemObject: TObject;
begin
  if ItemIndex = -1 then
    Result := nil
  else
    Result := Items.Objects[ItemIndex];
end;

procedure TcxCustomizeListBox.SetItemObject(Value: TObject);
begin
  if ItemObject <> Value then
  begin
    ItemIndex := Items.IndexOfObject(Value);
    Click;
  end;
end;

procedure TcxCustomizeListBox.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  FDragAndDropItemIndex := -1;
end;

procedure TcxCustomizeListBox.WMMouseMove(var Message: TWMMouseMove);
begin
  if FDragAndDropItemIndex = -1 then
    inherited
  else
    with Message do
      MouseMove(KeysToShiftState(Keys), XPos, YPos);
end;

procedure TcxCustomizeListBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params.WindowClass do
    style := style or CS_HREDRAW;
end;

procedure TcxCustomizeListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if (Button = mbLeft) and (ItemAtPos(Point(X, Y), True) <> -1) and
    (ItemObject <> nil) then
  begin
    FDragAndDropItemIndex := ItemIndex;
    FMouseDownPos := Point(X, Y);
  end;
end;

procedure TcxCustomizeListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (FDragAndDropItemIndex <> -1) and
    (not IsPointInDragDetectArea(FMouseDownPos, X, Y) or
     (ItemAtPos(Point(X, Y), True) <> FDragAndDropItemIndex)) then
  begin
    ItemIndex := FDragAndDropItemIndex;
    BeginDragAndDrop;
    FDragAndDropItemIndex := -1;
  end;
end;

procedure TcxCustomizeListBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  FDragAndDropItemIndex := -1;
end;

procedure TcxCustomizeListBox.BeginDragAndDrop;
var
  I: Integer;
begin
  if MultiSelect then
    with Items do
    begin
      BeginUpdate;
      try
        for I := 0 to Count - 1 do
          Selected[I] := I = ItemIndex;
      finally
        EndUpdate;
      end;
    end;
end;

{ TcxMessageWindow }

constructor TcxMessageWindow.Create;
begin
  inherited Create;
  FHandle := AllocateHWnd(MainWndProc);
end;

destructor TcxMessageWindow.Destroy;
begin
  DeallocateHWnd(FHandle);
  inherited Destroy;
end;

procedure TcxMessageWindow.WndProc(var Message: TMessage);
begin
  Message.Result := DefWindowProc(Handle, Message.Msg, Message.wParam, Message.lParam);
end;

procedure TcxMessageWindow.MainWndProc(var Message: TMessage);
begin
  try
    WndProc(Message);
  except
    Application.HandleException(Self);
  end;
end;

{ TcxSystemController }

constructor TcxSystemController.Create;
begin
  inherited;
  if IsLibrary then
    HookSynchronizeWakeup;
end;

destructor TcxSystemController.Destroy;
begin
  if IsLibrary then
    UnhookSynchronizeWakeup;
  inherited;
end;

procedure TcxSystemController.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    DXM_SYNCHRONIZETHREADS: CheckSynchronize;
  else
    inherited;
  end;
end;

procedure TcxSystemController.WakeMainThread(Sender: TObject);
begin
  PostMessage(Handle, DXM_SYNCHRONIZETHREADS, 0, 0);
end;

procedure TcxSystemController.HookSynchronizeWakeup;
begin
  FPrevWakeMainThread := Classes.WakeMainThread;
  Classes.WakeMainThread := WakeMainThread;
end;

procedure TcxSystemController.UnhookSynchronizeWakeup;
begin
  Classes.WakeMainThread := FPrevWakeMainThread;
end;

{ TdxSystemInfo }

constructor TdxSystemInfo.Create;
begin
  inherited;
  FListeners := TInterfaceList.Create;
  UpdateCache(SPI_SETDROPSHADOW);
  UpdateCache(SPI_SETNONCLIENTMETRICS);
end;

destructor TdxSystemInfo.Destroy;
begin
  FreeAndNil(FListeners);
  inherited;
end;

procedure TdxSystemInfo.AddListener(
  AListener: IdxSystemInfoListener);
begin
  FListeners.Add(AListener);
end;

function TdxSystemInfo.GetParameter(AParameter: Cardinal; var AValue): Boolean;
var
  Auiparam: Cardinal;
begin
  Auiparam := 0;
  case AParameter of
    SPI_GETANIMATION:
    begin
      Auiparam := SizeOf(TAnimationInfo);
      TAnimationInfo(AValue).cbSize := Auiparam;
    end;
    SPI_GETICONTITLELOGFONT:
      Auiparam := SizeOf(TLogFont);
    SPI_GETNONCLIENTMETRICS:
      begin
      {$IFDEF DELPHI14}
        TNonClientMetrics(AValue).cbSize := TNonClientMetrics.SizeOf;
      {$ELSE}
        TNonClientMetrics(AValue).cbSize := SizeOf(TNonClientMetrics);
      {$ENDIF}
      end;
  end;
  Result := SystemParametersInfo(AParameter, Auiparam, @AValue, 0);
end;

procedure TdxSystemInfo.RemoveListener(
  AListener: IdxSystemInfoListener);
begin
  if FListeners <> nil then
    FListeners.Remove(AListener);
end;

procedure TdxSystemInfo.WndProc(var Message: TMessage);
begin
  if (Message.Msg = WM_SETTINGCHANGE) and (Message.WParam <> 0) then
  begin
    UpdateCache(Message.WParam);
    NotifyListeners(Message.WParam);
    Message.Result := 0;
  end
  else
    inherited;
end;

procedure TdxSystemInfo.NotifyListeners(AParameter: Cardinal);
var
  I: Integer;
begin
  for I := 0 to FListeners.Count - 1 do
    (FListeners[I] as IdxSystemInfoListener).Changed(AParameter);
end;

function TdxSystemInfo.GetIsRemoteSession: Boolean;
{$IFNDEF DELPHI11}
const
  SM_REMOTESESSION = $1000;
{$ENDIF}
begin
  Result := GetSystemMetrics(SM_REMOTESESSION) = 1;
end;

procedure TdxSystemInfo.UpdateCache(AParameter: Cardinal);
var
  AIsDropShadow: BOOL;
begin
  case AParameter of
    SPI_SETDROPSHADOW:
      begin
        GetParameter(SPI_GETDROPSHADOW, AIsDropShadow);
        FIsDropShadow := AIsDropShadow;
      end;
    SPI_SETNONCLIENTMETRICS:
      GetParameter(SPI_GETNONCLIENTMETRICS, FNonClientMetrics);
  end;
end;

{ TdxMessagesController }

constructor TdxMessagesController.Create;
begin
  inherited Create;
  FLockedMessages := TList.Create;
end;

destructor TdxMessagesController.Destroy;
begin
  FreeAndNil(FLockedMessages);
  inherited;
end;

function TdxMessagesController.IsMessageInQueue(AWnd: THandle; AMessage: UINT): Boolean;
var
  AMsg: TMSG;
begin
  Result := PeekMessage(AMsg, AWnd, AMessage, AMessage, PM_NOREMOVE) and (AMsg.hwnd = AWnd);
end;

function TdxMessagesController.KillMessages(AWnd: THandle; AMsgFilterMin, AMsgFilterMax: UINT;
  AKillAllMessages: Boolean): Boolean;
var
  AMsg: TMsg;
begin
  if AMsgFilterMax = 0 then
    AMsgFilterMax := AMsgFilterMin;
  Result := False;
  while PeekMessage(AMsg, AWnd, AMsgFilterMin, AMsgFilterMax, PM_REMOVE) do
    if AMsg.message = WM_QUIT then
    begin
      PostQuitMessage(AMsg.wParam);
      Break;
    end
    else
    begin
      Result := True;
      if not AKillAllMessages then
        Break;
    end;
end;

function TdxMessagesController.IsMessageLocked(AMessage: UINT): Boolean;
begin
  Result := FLockedMessages.IndexOf(Pointer(AMessage)) <> -1;
end;

procedure TdxMessagesController.LockMessages(AMessages: array of UINT);
var
  I: Integer;
begin
  for I := Low(AMessages) to High(AMessages) do
    FLockedMessages.Add(Pointer(AMessages[I]));
end;

procedure TdxMessagesController.UnlockMessages(AMessages: array of UINT);
var
  I: Integer;
begin
  for I := Low(AMessages) to High(AMessages) do
    FLockedMessages.Remove(Pointer(AMessages[I]));
end;

function TdxMessagesController_LockWndProc(hWnd: HWND; Msg: UINT; WParam: WPARAM; LParam: LPARAM): LRESULT stdcall;
begin
  dxSetWindowProc(hwnd, dxMessagesController.FOldWndProc);
  dxMessagesController.FOldWndProc := nil;
  Result := 1;
end;

procedure TdxMessagesController.BlockMessage(AHandle: THandle);
begin
  if FOldWndProc <> nil then
    raise EdxException.Create('dxLockMessage fails');
  FOldWndProc := dxSetWindowProc(AHandle, @TdxMessagesController_LockWndProc);
end;

procedure TdxMessagesController.BlockLockedMessage(AHandle: THandle; var AMessage: UINT);
begin
  if IsMessageLocked(AMessage) then
  begin
    BlockMessage(AHandle);
    AMessage := 0;
  end;
end;

{ TcxPopupWindow }

constructor TcxPopupWindow.Create;
begin
  CreateNew(nil);
  inherited BorderStyle := bsNone;
  DefaultMonitor := dmDesktop;
  FormStyle := fsStayOnTop;
  FAdjustable := True;
  FAlignVert := pavBottom;
  FCanvas := TcxCanvas.Create(inherited Canvas);
  FDirection := pdVertical;
  FFrameColor := clWindowText;
{$IFDEF DELPHI16}
  ControlStyle := ControlStyle + [csOverrideStylePaint];
{$ENDIF}
end;

destructor TcxPopupWindow.Destroy;
begin
  FCanvas.Free;
  inherited;
end;

function TcxPopupWindow.GetNCHeight: Integer;
begin
  Result := BorderWidths[bTop] + BorderWidths[bBottom];
end;

function TcxPopupWindow.GetNCWidth: Integer;
begin
  Result := BorderWidths[bLeft] + BorderWidths[bRight];
end;

procedure TcxPopupWindow.SetBorderSpace(Value: Integer);
begin
  RestoreControlsBounds;
  FBorderSpace := Value;
end;

procedure TcxPopupWindow.SetBorderStyle(Value: TcxPopupBorderStyle);
begin
  RestoreControlsBounds;
  FBorderStyle := Value;
end;

procedure TcxPopupWindow.WMActivate(var Message: TWMActivate);
begin
  inherited;
  if Message.Active <> WA_INACTIVE then
  begin
    FPrevActiveWindow := Message.ActiveWindow;
    SendMessage(FPrevActiveWindow, WM_NCACTIVATE, WPARAM(True), 0);
  end;
end;

procedure TcxPopupWindow.WMActivateApp(var Message: TWMActivateApp);
begin
  inherited;
  if not Message.Active then
  begin
    SendMessage(FPrevActiveWindow, WM_NCACTIVATE, WPARAM(False), 0);
    CloseUp;
  end;
end;

procedure TcxPopupWindow.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
  VisibleChanged;
end;

procedure TcxPopupWindow.Deactivate;
begin
  inherited;
  CloseUp;
end;

procedure TcxPopupWindow.Paint;
begin
  inherited;
  DrawFrame;
end;

procedure TcxPopupWindow.VisibleChanged;
begin
end;

function TcxPopupWindow.CalculatePosition: TPoint;
var
  AAlignHorz: TcxPopupAlignHorz;
  AAlignVert: TcxPopupAlignVert;
  AOwnerScreenBounds: TRect;
  AOrigin: TPoint;

  procedure CalculateCommonPosition;
  var
    AWidth, AHeight: Integer;
  begin
    if AAlignHorz = pahCenter then
    begin
      AWidth := AOwnerScreenBounds.Left + AOwnerScreenBounds.Right;
      Result.X := (AWidth - Width) div 2;
      AOrigin.X := Result.X;
    end;
    if AAlignVert = pavCenter then
    begin
      AHeight := AOwnerScreenBounds.Top + AOwnerScreenBounds.Bottom;
      Result.Y := (AHeight - Height) div 2;
      AOrigin.Y := Result.Y;
    end;
  end;

  procedure CalculateHorizontalPosition;
  begin
    case AAlignHorz of
      pahLeft:
        begin
          Result.X := AOwnerScreenBounds.Left - Width;
          AOrigin.X := AOwnerScreenBounds.Left;
        end;
      pahRight:
        begin
          Result.X := AOwnerScreenBounds.Right;
          AOrigin.X := AOwnerScreenBounds.Right;
        end;
    end;
    case AAlignVert of
      pavTop:
        begin
          Result.Y := AOwnerScreenBounds.Top;
          AOrigin.Y := AOwnerScreenBounds.Top;
        end;
      pavBottom:
        begin
          Result.Y := AOwnerScreenBounds.Bottom - Height;
          AOrigin.Y := AOwnerScreenBounds.Bottom;
        end;
    end;
  end;

  procedure CalculateVerticalPosition;
  begin
    case AAlignHorz of
      pahLeft:
        begin
          Result.X := AOwnerScreenBounds.Left;
          AOrigin.X := AOwnerScreenBounds.Left;
        end;
      pahRight:
        begin
          Result.X := AOwnerScreenBounds.Right - Width;
          AOrigin.X := AOwnerScreenBounds.Right;
        end;
    end;
    case AAlignVert of
      pavTop:
        begin
          Result.Y := AOwnerScreenBounds.Top - Height;
          AOrigin.Y := AOwnerScreenBounds.Top;
        end;
      pavBottom:
        begin
          Result.Y := AOwnerScreenBounds.Bottom;
          AOrigin.Y := AOwnerScreenBounds.Bottom;
        end;
    end;
  end;

  procedure CheckPosition;
  var
    ADesktopWorkArea: TRect;

    procedure CheckCommonPosition;
    begin
      if (FDirection = pdVertical) or (AAlignHorz = pahCenter) then
      begin
        if Result.X + Width > ADesktopWorkArea.Right then Result.X := ADesktopWorkArea.Right - Width;
        if Result.X < ADesktopWorkArea.Left then Result.X := ADesktopWorkArea.Left;
      end;
      if (FDirection = pdHorizontal) or (AAlignVert = pavCenter) then
      begin
        if Result.Y + Height > ADesktopWorkArea.Bottom then Result.Y := ADesktopWorkArea.Bottom - Height;
        if Result.Y < ADesktopWorkArea.Top then Result.Y := ADesktopWorkArea.Top;
      end;
    end;

    procedure CheckHorizontalPosition;

      function MoreSpaceOnLeft: Boolean;
      begin
        Result := AOwnerScreenBounds.Left - ADesktopWorkArea.Left > ADesktopWorkArea.Right - AOwnerScreenBounds.Right;
      end;

    begin
      case AAlignHorz of
        pahLeft:
          if (Result.X < ADesktopWorkArea.Left) and not MoreSpaceOnLeft then
            AAlignHorz := pahRight;
        pahRight:
          if (Result.X + Width > ADesktopWorkArea.Right) and MoreSpaceOnLeft then
            AAlignHorz := pahLeft;
      end;
      CalculateHorizontalPosition;
    end;

    procedure CheckVerticalPosition;

      function MoreSpaceOnTop: Boolean;
      begin
        Result := AOwnerScreenBounds.Top - ADesktopWorkArea.Top > ADesktopWorkArea.Bottom - AOwnerScreenBounds.Bottom;
      end;

    begin
      case AAlignVert of
        pavTop:
          if (Result.Y < Top) and not MoreSpaceOnTop then
            AAlignVert := pavBottom;
        pavBottom:
          if (Result.Y + Height > ADesktopWorkArea.Bottom) and MoreSpaceOnTop then
            AAlignVert := pavTop;
      end;
      CalculateVerticalPosition;
    end;

  begin
    ADesktopWorkArea := GetDesktopWorkArea(AOrigin);
    if FDirection = pdHorizontal then
      CheckHorizontalPosition
    else
      CheckVerticalPosition;
    CheckCommonPosition;
  end;

begin
  AAlignHorz := FAlignHorz;
  AAlignVert := FAlignVert;
  AOwnerScreenBounds := OwnerScreenBounds;
  CalculateCommonPosition;
  if FDirection = pdHorizontal then
    CalculateHorizontalPosition
  else
    CalculateVerticalPosition;
  CheckPosition;
end;

procedure TcxPopupWindow.CalculateSize;
var
  AClientWidth, AClientHeight, I: Integer;
  ABounds: TRect;

  procedure CheckClientSize;
  begin
    with ABounds do
    begin
      if Right > AClientWidth then AClientWidth := Right;
      if Bottom > AClientHeight then AClientHeight := Bottom;
    end;
  end;

begin
  if not FAdjustable then Exit;

  AClientWidth := 0;
  AClientHeight := 0;
  for I := 0 to ControlCount - 1 do
  begin
    ABounds := Controls[I].BoundsRect;
    CheckClientSize;
    OffsetRect(ABounds, BorderWidths[bLeft], BorderWidths[bTop]);
    Controls[I].BoundsRect := ABounds;
  end;

  if (AClientWidth <> 0) or (ControlCount <> 0) then
    Width := BorderWidths[bLeft] + AClientWidth + BorderWidths[bRight];
  if (AClientHeight <> 0) or (ControlCount <> 0) then
    Height := BorderWidths[bTop] + AClientHeight + BorderWidths[bBottom];
end;

function TcxPopupWindow.GetBorderWidth(ABorder: TcxBorder): Integer;
begin
  Result := FBorderSpace + FrameWidths[ABorder];
end;

function TcxPopupWindow.GetClientBounds: TRect;
var
  ABorder: TcxBorder;
begin
  Result := ClientRect;
  for ABorder := Low(ABorder) to High(ABorder) do
    case ABorder of
      bLeft:
        Inc(Result.Left, BorderWidths[ABorder]);
      bTop:
        Inc(Result.Top, BorderWidths[ABorder]);
      bRight:
        Dec(Result.Right, BorderWidths[ABorder]);
      bBottom:
        Dec(Result.Bottom, BorderWidths[ABorder]);
    end;
end;

function TcxPopupWindow.GetFrameWidth(ABorder: TcxBorder): Integer;
begin
  case FBorderStyle of
    pbsUltraFlat:
      Result := 1;
    pbsFlat:
      Result := 1;
    pbs3D:
      Result := 2;
  else
    Result := 0;
  end;
end;

function TcxPopupWindow.GetOwnerScreenBounds: TRect;
begin
  Result := OwnerBounds;
  with Result do
  begin
    TopLeft := OwnerParent.ClientToScreen(TopLeft);
    BottomRight := OwnerParent.ClientToScreen(BottomRight);
  end;
end;

procedure TcxPopupWindow.InitPopup;
begin
  if FOwnerParent <> nil then
    Font := TControlAccess(FOwnerParent).Font;
end;

function TcxPopupWindow.IsSkinnable: Boolean;
begin
  Result := False;
end;

procedure TcxPopupWindow.RestoreControlsBounds;
var
  I: Integer;
  ABounds: TRect;
begin
  for I := 0 to ControlCount - 1 do
  begin
    ABounds := Controls[I].BoundsRect;
    OffsetRect(ABounds, -BorderWidths[bLeft], -BorderWidths[bTop]);
    Controls[I].BoundsRect := ABounds;
  end;
end;

procedure TcxPopupWindow.DrawFrame;
var
  R: TRect;

  procedure DrawUltraFlatBorder;
  begin
    Canvas.FrameRect(R, FrameColor);
  end;

  procedure DrawFlatBorder;
  begin
    Canvas.DrawEdge(R, False, False);
  end;

  procedure Draw3DBorder;
  begin
    Canvas.DrawEdge(R, False, True);
    InflateRect(R, -1, -1);
    Canvas.DrawEdge(R, False, False);
  end;

begin
  R := Bounds(0, 0, Width, Height);
  case FBorderStyle of
    pbsUltraFlat:
      DrawUltraFlatBorder;
    pbsFlat:
      DrawFlatBorder;
    pbs3D:
      Draw3DBorder;
  end;
end;

procedure TcxPopupWindow.CloseUp;
begin
  Hide;
end;

procedure TcxPopupWindow.Popup;

begin
  InitPopup;
  CalculateSize;
  Left := CalculatePosition.X;
  Top := CalculatePosition.Y;
  Show;
end;

{ TcxCustomDragImage }

constructor TcxCustomDragImage.Create;
begin
  inherited;
  SetBounds(0, 0, 0, 0);
  AlphaBlend := True;
  AlphaBlendValue := cxDragAndDropWindowTransparency;
{$IFDEF DELPHI9}
  PopupMode := pmExplicit;
{$ENDIF}
end;

{$IFDEF DELPHI9}
destructor TcxCustomDragImage.Destroy;
begin
  PopupMode := pmNone;
  inherited;
end;
{$ENDIF}

function TcxCustomDragImage.GetAlphaBlended: Boolean;
begin
  Result := AlphaBlend and
    Assigned(SetLayeredWindowAttributes);
end;

function TcxCustomDragImage.GetVisible: Boolean;
begin
  Result := HandleAllocated and IsWindowVisible(Handle);
end;

procedure TcxCustomDragImage.SetVisible(Value: Boolean);
begin
  if Visible <> Value then
    if Value then
      Show
    else
      Hide;
end;

procedure TcxCustomDragImage.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TcxCustomDragImage.WMNCHitTest(var Message: TWMNCHitTest);
begin
  Message.Result := HTTRANSPARENT;
end;

procedure TcxCustomDragImage.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if PopupParent <> nil then
    Params.WndParent := PopupParent.Handle
  else
    if Screen.ActiveForm <> nil then
      Params.WndParent := Screen.ActiveForm.Handle;
// #AI: see B185455
//  with Params.WindowClass do
//    Style := Style or CS_SAVEBITS;
end;

procedure TcxCustomDragImage.Init(const ASourceBounds: TRect; const ASourcePoint: TPoint);

  function CalculatePositionOffset: TPoint;
  begin
    Result.X := ASourcePoint.X - ASourceBounds.Left;
    Result.Y := ASourcePoint.Y - ASourceBounds.Top;
  end;

begin
  Width := ASourceBounds.Right - ASourceBounds.Left;
  Height := ASourceBounds.Bottom - ASourceBounds.Top;
  PositionOffset := CalculatePositionOffset;
end;

function TcxCustomDragImage.IsSkinnable: Boolean;
begin
  Result := False;
end;

procedure TcxCustomDragImage.MoveTo(const APosition: TPoint);
begin
  HandleNeeded;  // so that later CreateHandle won't reset Left and Top
  SetBounds(APosition.X - PositionOffset.X, APosition.Y - PositionOffset.Y, Width, Height);
end;

procedure TcxCustomDragImage.Show(ACmdShow: Integer = SW_SHOWNA);
begin
  ShowWindow(Handle, ACmdShow);
  Update;
end;

procedure TcxCustomDragImage.Hide;
begin
  if HandleAllocated then
    ShowWindow(Handle, SW_HIDE);
end;

{ TcxDragImage }

constructor TcxDragImage.Create;
begin
  inherited;
  FImage := TcxBitmap.Create;
end;

destructor TcxDragImage.Destroy;
begin
  FreeAndNil(FImage);
  inherited;
end;

function TcxDragImage.GetImageCanvas: TcxCanvas;
begin
  Result := Image.cxCanvas;
end;

function TcxDragImage.GetWindowCanvas: TcxCanvas;
begin
  Result := inherited Canvas;
end;

procedure TcxDragImage.Paint;
begin
  inherited;
  WindowCanvas.Draw(0, 0, Image);
end;

procedure TcxDragImage.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  if Image <> nil then
    Image.SetSize(Width, Height);
end;

{ TcxSizeFrame }

constructor TcxSizeFrame.Create(AFrameWidth: Integer = 2);
begin
  inherited Create;
  AlphaBlend := False;
  FFrameWidth := AFrameWidth;
  FRegion := TcxRegion.Create;
  Canvas.Brush.Bitmap := AllocPatternBitmap(clBlack, clWhite);
end;

destructor TcxSizeFrame.Destroy;
begin
  FreeAndNil(FRegion);
  inherited;
end;

procedure TcxSizeFrame.Paint;
begin
  Canvas.Canvas.FillRect(ClientRect);
end;

procedure TcxSizeFrame.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if HandleAllocated and (AWidth > FrameWidth * 2) and (AHeight > FrameWidth * 2) then
  begin
    if not FillSelection then
      InitializeFrameRegion;
    SetWindowRegion;
  end;
end;

procedure TcxSizeFrame.DrawSizeFrame(const ARect: TRect);
begin
  FRegion.Combine(cxRectBounds(0, 0, cxRectWidth(ARect), cxRectHeight(ARect)), roSet);
  SetBounds(ARect.Left, ARect.Top, cxRectWidth(ARect), cxRectHeight(ARect));
end;

procedure TcxSizeFrame.DrawSizeFrame(const ARect: TRect; const ARegion: TcxRegion);
begin
  FRegion.Combine(ARegion, roSet, False);
  SetBounds(ARect.Left, ARect.Top, cxRectWidth(ARect), cxRectHeight(ARect));
end;

procedure TcxSizeFrame.InitializeFrameRegion;

  procedure OffsetFrameRegion(AFrameRegion: TcxRegion; AOffsetX, AOffsetY: Integer);
  var
    ARegion: TcxRegion;
  begin
    ARegion := TcxRegion.Create;
    try
      ARegion.Combine(AFrameRegion, roSet, False);
      ARegion.Offset(AOffsetX, AOffsetY);
      AFrameRegion.Combine(ARegion, roIntersect, False);
    finally
      ARegion.Free;
    end;
  end;

var
  AFrameRegion: TcxRegion;
begin
  AFrameRegion := TcxRegion.Create;
  try
    AFrameRegion.Combine(FRegion, roSet, False);

    OffsetFrameRegion(AFrameRegion, FrameWidth, 0);
    OffsetFrameRegion(AFrameRegion, 0, FrameWidth);
    OffsetFrameRegion(AFrameRegion, -FrameWidth, 0);
    OffsetFrameRegion(AFrameRegion, 0, -FrameWidth);

    FRegion.Combine(AFrameRegion, roSubtract, False);
  finally
    AFrameRegion.Free;
  end;
end;

procedure TcxSizeFrame.SetWindowRegion;
var
  ANewWindowRegion, AOldWindowRegion: TcxRegion;
begin
  ANewWindowRegion := TcxRegion.Create;
  AOldWindowRegion := TcxRegion.Create;
  try
    ANewWindowRegion.Combine(FRegion, roSet, False);
    GetWindowRgn(Handle, AOldWindowRegion.Handle);
    if not ANewWindowRegion.IsEqual(AOldWindowRegion) then
    begin
      SetWindowRgn(Handle, ANewWindowRegion.Handle, True);
      ANewWindowRegion.Handle := 0;
    end;
  finally
    AOldWindowRegion.Free;
    ANewWindowRegion.Free;
  end;
end;

{ TcxDragDropArrow }

constructor TcxDragAndDropArrow.Create(ATransparent: Boolean);
begin
  inherited Create;
  FTransparent := ATransparent;
  AlphaBlend := False;
  if Transparent then
  begin
    TransparentColorValue := ImageBackColor;
    TransparentColor := True;
  end;
end;

function TcxDragAndDropArrow.GetTransparent: Boolean;
begin
  Result := FTransparent and
    Assigned(SetLayeredWindowAttributes);
end;

function TcxDragAndDropArrow.GetImageBackColor: TColor;
begin
  Result := clFuchsia;
end;

procedure TcxDragAndDropArrow.Init(AOwner: TControl; const AAreaBounds, AClientRect: TRect;
  APlace: TcxArrowPlace);
var
  AOrigin: TPoint;
begin
  if AOwner <> nil then
    AOrigin := AOwner.ClientOrigin
  else
    AOrigin := cxNullPoint;
  Init(AOrigin, AAreaBounds, AClientRect, APlace);
end;

procedure TcxDragAndDropArrow.Init(const AOwnerOrigin: TPoint; const AAreaBounds, AClientRect: TRect;
  APlace: TcxArrowPlace);

  procedure DrawArrow;
  begin
    Canvas.Brush.Color := ImageBackColor;
    Canvas.FillRect(ClientRect);
    DrawDragAndDropArrow(Canvas, ClientRect, APlace);
  end;

  procedure SetArrowRegion;
  var
    APoints: TPointArray;
    ARegion: HRGN;
  begin
    GetDragAndDropArrowPoints(ClientRect, APlace, APoints, True);
    ARegion := CreatePolygonRgn(APoints[0], Length(APoints), WINDING);
    SetWindowRgn(Handle, ARegion, True);
  end;

var
  R: TRect;
begin
  R := GetDragAndDropArrowBounds(AAreaBounds, AClientRect, APlace);
  R := cxRectOffset(R, AOwnerOrigin);
  HandleNeeded;  // so that later CreateHandle won't reset Left and Top
  BoundsRect := R;
  DrawArrow;
  if not Transparent then
    SetArrowRegion;
end;

{ TcxDesignController }

procedure TcxDesignController.DesignerModified(AForm: TCustomForm);
begin
  if not (IsDesignerModifiedLocked or (dsDesignerModifying in FState)) then
  begin
    Include(FState, dsDesignerModifying);
    try
      SetDesignerModified(AForm);
    finally
      Exclude(FState, dsDesignerModifying);
    end;
  end;
end;

function TcxDesignController.IsDesignerModifiedLocked: Boolean;
begin
  Result := FLockDesignerModifiedCount > 0;
end;

procedure TcxDesignController.LockDesignerModified;
begin
  Inc(FLockDesignerModifiedCount);
end;

procedure TcxDesignController.UnLockDesignerModified;
begin
  if FLockDesignerModifiedCount > 0 then
    Dec(FLockDesignerModifiedCount);
end;

{ TcxWindowProcLinkedObject }

constructor TcxWindowProcLinkedObject.Create(AControl: TControl);
begin
  inherited Create;
  FControl := AControl;
end;

constructor TcxWindowProcLinkedObject.Create(AHandle: THandle);
begin
  inherited Create;
  FHandle := AHandle;
end;

procedure TcxWindowProcLinkedObject.DefaultProc(
  var Message: TMessage);
begin
  TcxWindowProcLinkedObject(Prev).WindowProc(Message);
end;

{ TcxVCLSubclassingHelper }

constructor TcxVCLSubclassingHelper.Create(
  AControl: TControl);
begin
  inherited Create;
  FControl := AControl;
end;

function TcxVCLSubclassingHelper.CreateLinkedObject: TcxDoublyLinkedObject;
begin
  Result := TcxWindowProcLinkedObject.Create(FControl);
end;

procedure TcxVCLSubclassingHelper.RestoreDefaultProc;
begin
  FControl.WindowProc := FDefaultWindowProc;
end;

procedure TcxVCLSubclassingHelper.StoreAndReplaceDefaultProc(AWndProc: TWndMethod);
begin
  FDefaultWindowProc := FControl.WindowProc;
  FControl.WindowProc := AWndProc;
end;

{ TcxWin32SubclassingHelper }

constructor TcxWin32SubclassingHelper.Create(
  AHandle: THandle);
begin
  inherited Create;
  FHandle := AHandle;
end;

function TcxWin32SubclassingHelper.CreateLinkedObject: TcxDoublyLinkedObject;
begin
  Result := TcxWindowProcLinkedObject.Create(FHandle);
end;

procedure TcxWin32SubclassingHelper.DefaultWndProc(
  var Message: TMessage);
begin
  Message.Result := CallWindowProc(FAPIDefaultWndProc, FHandle,
    Message.Msg, Message.WParam, Message.LParam);
end;

procedure TcxWin32SubclassingHelper.RestoreDefaultProc;
begin
  dxSetWindowProc(FHandle, FAPIDefaultWndProc);
  Classes.FreeObjectInstance(FAPIWndProc);
end;

procedure TcxWin32SubclassingHelper.StoreAndReplaceDefaultProc(AWndProc: TWndMethod);
begin
  FAPIWndProc := Classes.MakeObjectInstance(AWndProc);
  FAPIDefaultWndProc := dxSetWindowProc(FHandle, FAPIWndProc);
  FDefaultWindowProc := DefaultWndProc;
end;

{ TcxWindowProcLinkedObjectList }

constructor TcxWindowProcLinkedObjectList.Create(AControl: TControl);
begin
  inherited Create;
  FHelper := TcxVCLSubclassingHelper.Create(AControl);
  FControl := AControl;
  Initialize;
end;

constructor TcxWindowProcLinkedObjectList.Create(AHandle: THandle);
begin
  inherited Create;
  FHandle := AHandle;
  FHelper := TcxWin32SubclassingHelper.Create(AHandle);
  Initialize;
end;

destructor TcxWindowProcLinkedObjectList.Destroy;
begin
  FHelper.RestoreDefaultProc;
  FreeAndNil(FHelper);
  inherited Destroy;
end;

function TcxWindowProcLinkedObjectList.AddProc(AWndProc: TWndMethod): TcxWindowProcLinkedObject;
begin
  Result := TcxWindowProcLinkedObject(inherited Add);
  Result.WindowProc := AWndProc;
end;

function TcxWindowProcLinkedObjectList.CreateLinkedObject: TcxDoublyLinkedObject;
begin
  Result := FHelper.CreateLinkedObject;
end;

procedure TcxWindowProcLinkedObjectList.Initialize;
begin
  FHelper.StoreAndReplaceDefaultProc(WndProc);
  AddProc(FHelper.DefaultWindowProc);
end;

function TcxWindowProcLinkedObjectList.IsEmpty: Boolean;
begin
  Result := Last.Prev = nil;
end;

procedure TcxWindowProcLinkedObjectList.WndProc(
  var Message: TMessage);
begin
  TcxWindowProcLinkedObject(Last).WindowProc(Message);
end;

{ TcxWindowProcController }

constructor TcxWindowProcController.Create;
begin
  inherited Create;
  FWindowProcObjects := TcxObjectList.Create;
end;

destructor TcxWindowProcController.Destroy;
begin
  FreeAndNil(FWindowProcObjects);
  inherited Destroy;
end;

function TcxWindowProcController.Add(AControl: TControl;
  AWndProc: TWndMethod): TcxWindowProcLinkedObject;
var
  AControlWindowProcObjects: TcxWindowProcLinkedObjectList;
begin
  Result := nil;
  if AControl = nil then
    Exit;
  AControlWindowProcObjects := GetControlWindowProcObjects(AControl);
  if AControlWindowProcObjects = nil then
  begin
    AControlWindowProcObjects := TcxWindowProcLinkedObjectList.Create(AControl);
    FWindowProcObjects.Add(AControlWindowProcObjects);
  end;
  Result := TcxWindowProcLinkedObject(AControlWindowProcObjects.AddProc(AWndProc));
end;

function TcxWindowProcController.Add(AHandle: THandle; AWndProc: TWndMethod): TcxWindowProcLinkedObject;
var
  AControlWindowProcObjects: TcxWindowProcLinkedObjectList;
begin
  Result := nil;
  if AHandle = 0 then
    Exit;
  AControlWindowProcObjects := GetControlWindowProcObjects(AHandle);
  if AControlWindowProcObjects = nil then
  begin
    AControlWindowProcObjects := TcxWindowProcLinkedObjectList.Create(AHandle);
    FWindowProcObjects.Add(AControlWindowProcObjects);
  end;
  Result := TcxWindowProcLinkedObject(AControlWindowProcObjects.AddProc(AWndProc));
end;

procedure TcxWindowProcController.Remove(var AWndProcObject: TcxWindowProcLinkedObject);
var
  AControlWindowProcObjects: TcxWindowProcLinkedObjectList;
begin
  if AWndProcObject = nil then
    Exit;
  if AWndProcObject.Control <> nil then
    AControlWindowProcObjects := GetControlWindowProcObjects(AWndProcObject.Control)
  else
    AControlWindowProcObjects := GetControlWindowProcObjects(AWndProcObject.Handle);
  if AControlWindowProcObjects <> nil then
  begin
    AControlWindowProcObjects.Remove(TcxDoublyLinkedObject(AWndProcObject));
    if AControlWindowProcObjects.IsEmpty then
      FWindowProcObjects.FreeAndRemove(AControlWindowProcObjects);
  end;
end;

function TcxWindowProcController.GetControlWindowProcObjects(
  AControl: TControl): TcxWindowProcLinkedObjectList;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FWindowProcObjects.Count - 1 do
    if TcxWindowProcLinkedObjectList(FWindowProcObjects[I]).Control = AControl then
    begin
      Result := TcxWindowProcLinkedObjectList(FWindowProcObjects[I]);
      Break;
    end;
end;

function TcxWindowProcController.GetControlWindowProcObjects(AHandle: THandle): TcxWindowProcLinkedObjectList;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FWindowProcObjects.Count - 1 do
    if TcxWindowProcLinkedObjectList(FWindowProcObjects[I]).Handle = AHandle then
    begin
      Result := TcxWindowProcLinkedObjectList(FWindowProcObjects[I]);
      Break;
    end;
end;

{ TcxLockedStateImageOptions }

constructor TcxLockedStateImageOptions.Create(AOwner: TComponent);
begin
  inherited Create;
  FColor := clNone;
  FOwner := AOwner;
  FFont := TFont.Create;
  FEnabled := True;
  FEffect := lsieNone;
  FText := cxGetResourceString(@scxLockedStateText);
end;

destructor TcxLockedStateImageOptions.Destroy;
begin
  FreeAndNil(FFont);
  inherited Destroy;
end;

procedure TcxLockedStateImageOptions.AfterConstruction;
begin
  inherited AfterConstruction;
  FFont.Assign(GetFont);
  FFont.OnChange := FontChanged;
end;

procedure TcxLockedStateImageOptions.Assign(Source: TPersistent);
begin
  if Source is TcxLockedStateImageOptions then
  begin
    Color := TcxLockedStateImageOptions(Source).Color;
    Effect := TcxLockedStateImageOptions(Source).Effect;
    Enabled := TcxLockedStateImageOptions(Source).Enabled;
    Font := TcxLockedStateImageOptions(Source).Font;
    ShowText := TcxLockedStateImageOptions(Source).ShowText;
    Text := TcxLockedStateImageOptions(Source).Text;
  end
  else
    inherited Assign(Source);
end;

procedure TcxLockedStateImageOptions.SetAssignedValues(
  const Value: TcxLockedStateImageAssignedValues);
begin
  if FAssignedValues <> Value then
  begin
    FAssignedValues := Value;
    if not (lsiavFont in AssignedValues) then
    begin
      FFont.Assign(GetFont);
      Exclude(FAssignedValues, lsiavFont);
    end;
    if not (lsiavColor in AssignedValues) then
      FColor := clNone; 
  end;
end;

procedure TcxLockedStateImageOptions.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Include(FAssignedValues, lsiavColor);
  end;
end;

procedure TcxLockedStateImageOptions.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TcxLockedStateImageOptions.FontChanged(Sender: TObject);
begin
  Include(FAssignedValues, lsiavFont);
end;

function TcxLockedStateImageOptions.IsFontStored: Boolean;
begin
  Result := lsiavFont in FAssignedValues;
end;

function TcxLockedStateImageOptions.IsTextStored: Boolean;
begin
  Result := FText <> cxGetResourceString(@scxLockedStateText);
end;

procedure TcxLockedStateImageOptions.UpdateFont(AFont: TFont);
begin
  if not (lsiavFont in AssignedValues) then
  begin
    FFont.Assign(AFont);
    AssignedValues := AssignedValues - [lsiavFont];
  end;
end;

{ TcxLockedStatePaintHelper }

constructor TcxLockedStatePaintHelper.Create(AOwner: TComponent);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor TcxLockedStatePaintHelper.Destroy;
begin
  FreeAndNil(FBitmap);
  inherited Destroy;
end;

procedure TcxLockedStatePaintHelper.BeginLockedPaint(AMode: TcxLockedStateImageShowingMode);
begin
  Inc(FCount); 
  if FCount = 1 then
  begin
    if (AMode <> lsimNever) and CanControlPaint and CanCreateLockedImage then
    begin
      CreateImage;
      if AMode = lsimImmediate then
        RedrawWindow(Control.Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW or RDW_ALLCHILDREN);
    end;
  end;
end;

procedure TcxLockedStatePaintHelper.EndLockedPaint;
begin
  Dec(FCount);
  if FCount = 0 then
  begin
    FreeAndNil(FBitmap);
    if FIsImageReady then
    begin
      FIsImageReady := False;
      if CanControlPaint then
        Control.InvalidateWithChildren;
    end;
  end;
end;

function TcxLockedStatePaintHelper.GetActiveCanvas: TcxCanvas;
begin
  if IsImageReady then
    Result := Bitmap.cxCanvas
  else
    Result := Control.ActiveCanvas;
end;

function TcxLockedStatePaintHelper.CanCreateLockedImage: Boolean;
begin
  Result := Assigned(Options) and Options.Enabled and
    ([csLoading, csDestroying] * Owner.ComponentState = []);
end;

function TcxLockedStatePaintHelper.CanControlPaint: Boolean;
begin
  Result := Control.HandleAllocated and Control.Visible;
end;

function TcxLockedStatePaintHelper.DoPrepareImage: Boolean;
begin
  Result := False;
end;

procedure TcxLockedStatePaintHelper.CreateImage;
begin
  if Assigned(FBitmap) then
    FBitmap.SetSize(Control.ClientRect)
  else
    FBitmap := TcxBitmap32.CreateSize(Control.ClientRect);
  FCreatingImage := True;
  try
    cxPaintToBitmap(Control, FBitmap);
    Control.Update;
  finally
    FCreatingImage := False;
  end;
end;

procedure TcxLockedStatePaintHelper.DrawText;
var
  H: Integer;
  R: TRect;
  ASize: TSize;
begin
  if not Options.ShowText or (Text = '') then Exit;
  R := Bitmap.ClientRect;
  ASize := cxTextExtent(Font, Text);
  H := ASize.cy;
  Inc(ASize.cx, H * 3);
  Inc(ASize.cy, H * 2);
  R := cxRectCenter(Bitmap.ClientRect, ASize);
  if cxRectContain(Bitmap.ClientRect, R) then
    Painter.DrawMessageBox(Bitmap.cxCanvas, R, Text, Font, Color);
end;

function TcxLockedStatePaintHelper.GetImage: TcxBitmap32;
begin
  if IsActive then
  begin
    ValidateImage;
    Result := Bitmap;
  end
  else
    Result := nil;
end;

function TcxLockedStatePaintHelper.GetColor: TColor;
begin
  Result := Options.Color;
end;

function TcxLockedStatePaintHelper.GetEffect: TcxLockedStateImageEffect;
begin
  Result := Options.Effect;
end;

function TcxLockedStatePaintHelper.GetFont: TFont;
begin
  Result := Options.Font;
end;

function TcxLockedStatePaintHelper.GetPainter: TcxCustomLookAndFeelPainter;
begin
  Result := Control.LookAndFeelPainter;
end;

function TcxLockedStatePaintHelper.GetText: string;
begin
  Result := Options.Text;
end;

function TcxLockedStatePaintHelper.IsActive: Boolean;
begin
  Result := Assigned(Bitmap) and not CreatingImage;
end;

procedure TcxLockedStatePaintHelper.PrepareImage;
begin
  if not DoPrepareImage then
  begin
    case Effect of
      lsieLight: Bitmap.Lighten(40);
      lsieDark: Bitmap.Darken(60);
    end;
    DrawText;
  end;
end;

procedure TcxLockedStatePaintHelper.ValidateImage;
begin
  if not FIsImageReady then
  try
    PrepareImage;
  finally
    FIsImageReady := True;
  end;
end;

{ TcxDesignSelector }

constructor TcxDesignSelector.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetBounds(Left, Top, cxDesignSelectorSize, cxDesignSelectorSize);
end;

procedure TcxDesignSelector.BoundsChanged;
begin
  inherited BoundsChanged;
  if HandleAllocated then
    SetWindowRgn(Handle, CreateRegion, True);
end;

function TcxDesignSelector.CreateRegion: TcxRegionHandle;
var
  ARgn: TcxRegionHandle;
begin
  Result := CreateRectRgnIndirect(DesignRect);
  ARgn := CreateRectRgnIndirect(cxRectOffset(DesignRect, 1, 1));
  CombineRgn(Result, Result, ARgn, RGN_OR);
  DeleteObject(ARgn);
end;

procedure TcxDesignSelector.Paint;
begin
  cxDrawDesignRect(Canvas, DesignRect, Selected);
end;

function TcxDesignSelector.GetDesignRect: TRect;
begin
  Result := cxRectInflate(ClientRect, 0, 0, -1, -1);
end;

function TcxDesignSelector.GetSelected: Boolean;
begin
  Result := False;
end;

//

procedure RegisterAssistants;
begin
  if IsWinVistaOrLater then
    BufferedPaintInit;
end;

procedure UnregisterAssistants;
begin
  if IsWinVistaOrLater then
    BufferedPaintUnInit;
end;

initialization
  FUnitIsFinalized := False; // D10 bug
  Screen.Cursors[crDragCopy] := LoadCursor(HInstance, 'CX_DRAGCOPYCURSOR');
  Screen.Cursors[crFullScroll] := LoadCursor(HInstance, 'CX_FULLSCROLLCURSOR');
  Screen.Cursors[crHorScroll] := LoadCursor(HInstance, 'CX_HORSCROLLCURSOR');
  Screen.Cursors[crVerScroll] := LoadCursor(HInstance, 'CX_VERSCROLLCURSOR');
  Screen.Cursors[crUpScroll] := LoadCursor(HInstance, 'CX_UPSCROLLCURSOR');
  Screen.Cursors[crRightScroll] := LoadCursor(HInstance, 'CX_RIGHTSCROLLCURSOR');
  Screen.Cursors[crDownScroll] := LoadCursor(HInstance, 'CX_DOWNSCROLLCURSOR');
  Screen.Cursors[crLeftScroll] := LoadCursor(HInstance, 'CX_LEFTSCROLLCURSOR');
  Screen.Cursors[crcxRemove] := LoadCursor(HInstance, 'CX_REMOVECURSOR');
  Screen.Cursors[crcxVertSize] := LoadCursor(HInstance, 'CX_VERTSIZECURSOR');
  Screen.Cursors[crcxHorzSize] := LoadCursor(HInstance, 'CX_HORZSIZECURSOR');
  Screen.Cursors[crcxDragMulti] := LoadCursor(HInstance, 'CX_MULTIDRAGCURSOR');
  Screen.Cursors[crcxNoDrop] := LoadCursor(HInstance, 'CX_NODROPCURSOR');
  Screen.Cursors[crcxDrag] := LoadCursor(HInstance, 'CX_DRAGCURSOR');
  Screen.Cursors[crcxHandPoint] := LoadCursor(0{HInstance}, IDC_HAND{'CX_HANDPOINTCURSOR'});
  Screen.Cursors[crcxColorPicker] := LoadCursor(HInstance, 'CX_COLORPICKERCURSOR');
  Screen.Cursors[crcxMultiDragCopy] := LoadCursor(HInstance, 'CX_MULTIDRAGCOPYCURSOR');
  Screen.Cursors[crcxHand] := LoadCursor(HInstance, 'CX_HANDCURSOR');
  Screen.Cursors[crcxHandDrag] := LoadCursor(HInstance, 'CX_HANDDRAGCURSOR');

  //StartClassGroup(TControl);
  GroupDescendentsWith(TcxControlChildComponent, TControl);

  FSystemController := TcxSystemController.Create;
  dxUnitsLoader.AddUnit(@RegisterAssistants, @UnregisterAssistants);

finalization
  FUnitIsFinalized := True;
  dxUnitsLoader.RemoveUnit(@UnregisterAssistants);

  FreeAndNil(FSystemController);
  FreeAndNil(FDesignController);
  if FMouseTrackingTimerList <> nil then
  begin
    if FMouseTrackingTimerList.Count <> 0 then
      raise EdxException.Create('MouseTrackingTimerList.Count <> 0');
    FreeAndNil(FMouseTrackingTimerList);
  end;

  FreeAndNil(FcxMessageWindow);
  FreeAndNil(FcxWindowProcController);
  FreeAndNil(FMessagesController);
  FreeAndNil(FdxSystemInfo);
end.
