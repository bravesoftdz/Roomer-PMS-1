{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressNavBar                                               }
{                                                                   }
{       Copyright (c) 2002-2014 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSNAVBAR AND ALL ACCOMPANYING   }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
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

unit dxNavBar;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI16}
  System.UITypes,
{$ENDIF}
  Classes, Types, IniFiles, Registry, Windows, Messages,
  Graphics, Forms, Controls, ImgList, StdCtrls, ExtCtrls, Contnrs,
  dxCore, cxScrollBar, cxClasses, cxGraphics, cxGeometry, cxLookAndFeelPainters, dxCoreClasses,
  cxControls, dxThemeManager, cxLookAndFeels, cxAccessibility, cxLibraryConsts, dxCustomHint,
  dxNavBarBase, dxNavBarCollns, dxNavBarStyles, dxNavBarConsts;

type
  TdxNavBarDragDropFlag = (fAllowDragLink, fAllowDropLink, fAllowDragGroup, fAllowDropGroup);
  TdxNavBarDragDropFlags = set of TdxNavBarDragDropFlag;
  TdxNavBarObjectState = (sActive, sDisabled, sExpanded, sHotTracked, sPressed, sSelected, sSpecial, sFocused);
  TdxNavBarObjectStates = set of TdxNavBarObjectState;
  TdxNavBarChildKind = (nbckGroup, nbckItem, nbckStyle, nbckGroupControl);
  TdxNavBarViewCategory = (nbvcExplorerBar, nbvcSideBar);
  TdxNavBarViewCategories = set of TdxNavBarViewCategory;

const
  nbNone = -1;
  dxNavBarDefaultDragDropFlags = [fAllowDragLink, fAllowDropLink, fAllowDragGroup, fAllowDropGroup];
  dxNavBarHintWindowSizeCorrection = 6;
  dxNavBarHintWindowTextOffset: TPoint = (X: 2; Y: 2);
  dxNavBarAllCategories = [nbvcExplorerBar, nbvcSideBar];

type
  TdxCustomNavBar = class;
  TdxNavBarViewInfo = class;
  TdxNavBarGroupViewInfo = class;
  TdxNavBarPainter = class;
  TdxNavBarHintWindow = class;
  TdxNavBarScrollBar = class;
  TdxNavBarController = class;
  TdxNavBarControllerClass = class of TdxNavBarController;

  { TdxNavBarPersistent }

  TdxNavBarPersistent = class(TPersistent)
  private
    FNavBar: TdxCustomNavBar;
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(ANavBar: TdxCustomNavBar); virtual;
    property NavBar: TdxCustomNavBar read FNavBar;
  end;

  TdxNavBarCustomViewInfo = class
  protected
    FNavBar: TdxCustomNavBar;
    FPainter: TdxNavBarPainter;
    FRatio: Double;
    property Ratio: Double read FRatio;
    function GetRevisedValue(AValue: Integer): Integer;
  public
    constructor Create;

    property NavBar: TdxCustomNavBar read FNavBar;
    property Painter: TdxNavBarPainter read FPainter;
  end;

  TdxNavBarCustomItemViewInfo = class(TdxNavBarCustomViewInfo)
  protected
    FCaptionFont: TFont;
    FCaptionRect: TRect;
    FCaptionVisible: Boolean;
    FDesignRect: TRect;
    FImageRect: TRect;
    FImageVisible: Boolean;
    FFocusRect: TRect;
    FRect: TRect;

    FViewInfo: TdxNavBarViewInfo;

    procedure CalcDesignRect(const AItemRect: TRect; AMarkSize: Integer);
    function GetNavBarItem: TdxNavBarCustomItem; virtual; abstract;
    function GetImageList: TCustomImageList; virtual;
    function GetState: TdxNavBarObjectStates; virtual;
    function IsEnabled: Boolean;
    function IsFocused: Boolean;
    function IsSelected: Boolean;
    function UseDisabledImages: Boolean; virtual;
    function UseHotImages: Boolean; virtual;
    function UseLargeImages: Boolean; virtual;
  public
    constructor Create(AViewInfo: TdxNavBarViewInfo);
    destructor Destroy; override;

    procedure CorrectBounds(dX, dY: Integer); virtual;
    function ImageIndex: Integer; virtual;

    // Rectangles
    property CaptionRect: TRect read FCaptionRect;
    property DesignRect: TRect read FDesignRect;
    property ImageRect: TRect read FImageRect;
    property FocusRect: TRect read FFocusRect;
    property Rect: TRect read FRect;

    property ImageList: TCustomImageList read GetImageList;
    property State: TdxNavBarObjectStates read GetState;
    property ViewInfo: TdxNavBarViewInfo read FViewInfo;
  end;

  TdxNavBarLinkViewInfo = class(TdxNavBarCustomItemViewInfo)
  private
    FGroupViewInfo: TdxNavBarGroupViewInfo;
    FLink: TdxNavBarItemLink;
    FItem: TdxNavBarItem;
  protected
    function GetNavBarItem: TdxNavBarCustomItem; override;
    function GetState: TdxNavBarObjectStates; override;
  public
    constructor Create(AGroupViewInfo: TdxNavBarGroupViewInfo; ALink: TdxNavBarItemLink; ACaptionVisible, AImageVisisble: Boolean);

    // Calculation
    procedure CalculateBounds(X, Y: Integer); virtual;

    // Sizes
    function GetCaptionHeight: Integer; virtual;
    function GetDrawEdgeFlag: Integer; virtual;
    function GetImageHeight: Integer; virtual;
    function GetImageWidth: Integer; virtual;
    
    // Conditions
    function IsCaptionVisible: Boolean;
    function IsImageVisible: Boolean;
    function IsWholeVisible: Boolean;
    function UseLargeImages: Boolean; override;

    // Style attributes
    function StyleItem: TdxNavBarStyleItem; virtual;
    function Style: TdxNavBarBaseStyle; virtual;
    function Font: TFont; virtual;
    function FontColor: TColor; virtual;
    function SeparatorColor: TColor; virtual;

    // Rectangles
    function SelectionRect: TRect; virtual;
    function SeparatorRect: TRect; virtual;

    // Object links
    property Link: TdxNavBarItemLink read FLink;
    property Item: TdxNavBarItem read FItem;
    property GroupViewInfo: TdxNavBarGroupViewInfo read FGroupViewInfo;
  end;
  TdxNavBarLinkViewInfoClass = class of TdxNavBarLinkViewInfo;

  TdxNavBarGroupViewInfo = class(TdxNavBarCustomItemViewInfo)
  private
    FItems: TList;
    FGroup: TdxNavBarGroup;
    FItemsVisible: Boolean;

    function GetControl: TdxNavBarGroupControl;
    function GetControlBackColor: TColor;
    function GetControlBackColor2: TColor;
    function GetItemCount: Integer;
    function GetItem(Index: Integer): TdxNavBarLinkViewInfo;
    function IsDefaultControlStyle: Boolean;
  protected
    FCaptionSignRect: TRect;
    FCaptionTextRect: TRect;
    FItemsRect: TRect;

    procedure AddLink(AViewInfo: TdxNavBarViewInfo; ALink: TdxNavBarItemLink; ACaptionVisible, AImageVisisble: Boolean);
    procedure ClearItems;
    procedure DoCreateItemsInfo; virtual;

    function GetBorderOffsets: TRect;
    function GetControlRect: TRect; virtual;
    function GetImageIndent: Integer; virtual;

    procedure AdjustControlBounds; virtual;
    function GetNavBarItem: TdxNavBarCustomItem; override;
    function GetState: TdxNavBarObjectStates; override;
    function HasEnoughSpaceForScrollButtons: Boolean;
  public
    constructor Create(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup; ACaptionVisible, AItemsVisible: Boolean);
    destructor Destroy; override;

    // Calculation
    procedure CreateInfo; virtual;
    procedure CreateItemsInfo;
    procedure CalculateBounds(var X, Y: Integer); virtual;
    procedure CorrectBounds(dX, dY: Integer); override;
    procedure CorrectActiveGroupBounds(dX, dY: Integer); virtual;

    function GetLinkViewInfoByLink(ALink: TdxNavBarItemLink): TdxNavBarLinkViewInfo;
    function IndexOfLinkViewInfo(AViewInfo: TdxNavBarLinkViewInfo): Integer;

    // Sizes
    function GetCaptionHeight: Integer; virtual;
    function GetDrawEdgeFlag: Integer; virtual;
    function GetImageHeight: Integer; virtual;
    function GetImageWidth: Integer; virtual;

    // Conditions
    function IsCaptionVisible: Boolean;
    function IsCaptionImageVisible: Boolean;
    function IsCaptionSignVisible: Boolean;
    function IsCaptionUseSmallImages: Boolean;
    function IsItemsVisible: Boolean;
    function IsLinksUseSmallImages: Boolean;
    function IsViewAsIconView: Boolean;

    // Styles attributes
    function BorderColor: TColor; virtual;
    function BgImage: TPicture; virtual;
    function BgBackColor: TColor; virtual;
    function BgBackColor2: TColor; virtual;
    function BgAlphaBlend: Byte; virtual;
    function BgAlphaBlend2: Byte; virtual;
    function BgGradientMode: TdxBarStyleGradientMode; virtual;
    function CaptionStyleItem: TdxNavBarStyleItem; virtual;
    function CaptionStyle: TdxNavBarBaseStyle; virtual;
    function CaptionImage: TPicture; virtual;
    function CaptionBorderColor: TColor; virtual;
    function CaptionBackColor: TColor; virtual;
    function CaptionBackColor2: TColor; virtual;
    function CaptionAlphaBlend: Byte; virtual;
    function CaptionAlphaBlend2: Byte; virtual;
    function CaptionGradientMode: TdxBarStyleGradientMode; virtual;
    function CaptionFont: TFont; virtual;
    function CaptionFontColor: TColor; virtual;
    function CaptionSignColor: TColor; virtual;
    function CaptionHAlignment: TdxBarStyleHAlignment; virtual;
    function CaptionVAlignment: TdxBarStyleVAlignment; virtual;
    function ControlImage: TPicture; virtual;
    function ControlBackColor: TColor; virtual;
    function ControlBackColor2: TColor; virtual;
    function ControlAlphaBlend: Byte; virtual;
    function ControlAlphaBlend2: Byte; virtual;
    function ControlGradientMode: TdxBarStyleGradientMode; virtual;
    function UseLargeImages: Boolean; override;
    
    // Rectangles
    property CaptionImageRect: TRect read FImageRect;
    property CaptionSignRect: TRect read FCaptionSignRect;
    property CaptionTextRect: TRect read FCaptionTextRect;
    property ControlRect: TRect read GetControlRect;
    property ItemsRect: TRect read FItemsRect;    

    // Object links
    property Control: TdxNavBarGroupControl read GetControl;
    property ItemCount: Integer read GetItemCount;
    property Items[Index: Integer]: TdxNavBarLinkViewInfo read GetItem;
    property Group: TdxNavBarGroup read FGroup;
  end;
  TdxNavBarGroupViewInfoClass = class of TdxNavBarGroupViewInfo;

  TdxNavBarCalcHintEvent = procedure (AItem: TObject; var ARect: TRect) of object;
  TdxNavBarViewInfo = class(TdxNavBarCustomViewInfo)
  private
    FGroups: TObjectList;
    FHeaderFont: TFont;
    FTopScrollButtonRect: TRect;
    FBottomScrollButtonRect: TRect;
    FHintRect: TRect;
    FHintText: string;

    function GetGroupCount: Integer;
    function GetGroup(Index: Integer): TdxNavBarGroupViewInfo;
    function GetBottomScrollButtonState: TdxNavBarObjectStates;
    function GetTopScrollButtonState: TdxNavBarObjectStates;
  protected
    // Colors
    procedure CreateColors; virtual;
    procedure RefreshColors; virtual;
    procedure ReleaseColors; virtual;

    function ClientHeight: Integer;
    function ClientWidth: Integer;
    function GetSpaceBetweenGroups: Integer;
    function GetLargeImageHeight: Integer;
    function GetLargeImageWidth: Integer;
    function GetSmallImageHeight: Integer;
    function GetSmallImageWidth: Integer;

    // Group
    function GetGroupBorderOffsets: TRect; virtual;
    function GetGroupCaptionHeightAddon: Integer; virtual;
    class function GetGroupCaptionTextIndent: Integer; virtual;
    class function GetGroupCaptionImageIndent: Integer; virtual;
    function GetGroupCaptionImageOffsets: TRect; virtual;
    function GetGroupSeparatorWidth: Integer; virtual;
    function GetGroupCaptionSignSize: TSize; virtual;
    function GetGroupEdges: TPoint; virtual;
    class function GetGroupCaptionSeparatorWidth: Integer; virtual;

    // Link
    class function GetLinksLargeSeparatorWidth: Integer; virtual;
    class function GetLinksSmallSeparatorWidth: Integer; virtual;
    class function GetLinksIconViewSeparatorWidth: Integer; virtual;
    function GetLinksImageEdges: TRect; virtual;

    // Sizes
    class function GetDragArrowHeight: Integer; virtual;
    class function GetDragArrowWidth: Integer; virtual;
    function GetHeaderHeightAddon: Integer; virtual;
    function GetNavBarCollapsedWidth: Integer; virtual;
    function GetNavBarMinExpandedWidth: Integer; virtual;
    class function GetScrollButtonVerticalEdge: Integer; virtual;
    class function GetScrollButtonHorizontalEdge: Integer; virtual;
    class function GetScrollButtonVerticalSize: Integer; virtual;
    class function GetScrollButtonHorizontalSize: Integer; virtual;

    // Conditions
    function CanCollapse: Boolean; virtual;
    function CanHasActiveGroup: Boolean; virtual;
    function CanHasSpecialGroup: Boolean; virtual;
    function CanHasScrollButtonInGroupCaption: Boolean; virtual;
    function CanHasImageInGroupCaption: Boolean; virtual;
    function CanHasSignInGroupCaption: Boolean; virtual;
    function CanHasGroupViewAsIconView: Boolean; virtual;
    function CanHasGroupWithNoCaption: Boolean; virtual;
    function CanHasVisibleItemsInGroup(AGroup: TdxNavBarGroup): Boolean; virtual;
    function CanGroupCaptionBoundsByImage: Boolean; virtual;
    function CanGroupsUseLargeImages: Boolean; virtual;
    function CanLinksUseLargeImages: Boolean; virtual;
    function CanSelectLinkByRect: Boolean; virtual;

    procedure AddGroup(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup; ACaptionVisible, AItemsVisible: Boolean);
    procedure RemoveGroup(AGroupViewInfo: TdxNavBarGroupViewInfo);
    procedure ClearGroups;

    // Correction
    procedure AdjustControlsBounds; virtual;
    procedure CorrectBounds; virtual;

    function GetBoundsUpdateType: TdxNavBarChangeType; virtual;
    function GetTopScrollButtonRect: TRect; virtual;
    function GetBottomScrollButtonRect: TRect; virtual;

    // Calculations
    procedure DoCreateGroupsInfo; virtual;
    procedure DoCalculateBounds(X, Y: Integer); virtual;

    function IsGroupActive(AGroup: TdxNavBarGroup): Boolean; virtual;
    procedure DoGroupActiveToggle(AGroup: TdxNavBarGroup); virtual;
    procedure DoGroupActivate(AGroup: TdxNavBarGroup); virtual;
    procedure DoGroupDeactivate(AGroup: TdxNavBarGroup); virtual;
    procedure MakeLinkVisible(ALink: TdxNavBarItemLink; ATop: Boolean = True); virtual;
    procedure MakeGroupVisible(AGroup: TdxNavBarGroup;
      AExpandGroup: Boolean = True; ATop: Boolean = True); virtual;
  public
    constructor Create(APainter: TdxNavBarPainter); virtual;
    destructor Destroy; override;
    // Calculation
    procedure CreateInfo; virtual;
    procedure CreateGroupsInfo;
    procedure CalculateBounds;
    procedure CalculateScrollButtonsBounds; virtual;
    procedure ClearRects; virtual;
    // Styles attributes
    function BgImage: TPicture; virtual;
    function BgBackColor: TColor; virtual;
    function BgBackColor2: TColor; virtual;
    function BgAlphaBlend: Byte; virtual;
    function BgAlphaBlend2: Byte; virtual;
    function BgGradientMode: TdxBarStyleGradientMode; virtual;
    function BorderColor: TColor; virtual;
    function BottomScrollButtonStyleItem: TdxNavBarStyleItem; virtual;
    function BottomScrollButtonStyle: TdxNavBarBaseStyle; virtual;
    function BottomScrollButtonImage: TPicture; virtual;
    function BottomScrollButtonBackColor: TColor; virtual;
    function BottomScrollButtonBackColor2: TColor; virtual;
    function BottomScrollButtonAlphaBlend: Byte; virtual;
    function BottomScrollButtonAlphaBlend2: Byte; virtual;
    function BottomScrollButtonGradientMode: TdxBarStyleGradientMode; virtual;
    function TopScrollButtonStyleItem: TdxNavBarStyleItem; virtual;
    function TopScrollButtonStyle: TdxNavBarBaseStyle; virtual;
    function TopScrollButtonImage: TPicture; virtual;
    function TopScrollButtonBackColor: TColor; virtual;
    function TopScrollButtonBackColor2: TColor; virtual;
    function TopScrollButtonAlphaBlend: Byte; virtual;
    function TopScrollButtonAlphaBlend2: Byte; virtual;
    function TopScrollButtonGradientMode: TdxBarStyleGradientMode; virtual;
    function HintImage: TPicture; virtual;
    function HintBackColor: TColor; virtual;
    function HintBackColor2: TColor; virtual;
    function HintAlphaBlend: Byte; virtual;
    function HintAlphaBlend2: Byte; virtual;
    function HintGradientMode: TdxBarStyleGradientMode; virtual;
    function HintFont: TFont; virtual;
    function DragDropItemTargetBackColor: TColor; virtual;
    function DragDropGroupTargetBackColor: TColor; virtual;
    function DragDropGroupTargetBackColor2: TColor; virtual;
    function DragDropGroupTargetAlphaBlend: Byte; virtual;
    function DragDropGroupTargetAlphaBlend2: Byte; virtual;
    function DragDropGroupTargetGradient: TdxBarStyleGradientMode; virtual;
    function HeaderImage: TPicture; virtual;
    function HeaderBackColor: TColor; virtual;
    function HeaderBackColor2: TColor; virtual;
    function HeaderAlphaBlend: Byte; virtual;
    function HeaderAlphaBlend2: Byte; virtual;
    function HeaderGradientMode: TdxBarStyleGradientMode; virtual;
    function HeaderFont: TFont; virtual;
    function HeaderFontColor: TColor; virtual;
    function HeaderHAlignment: TdxBarStyleHAlignment; virtual;
    function HeaderVAlignment: TdxBarStyleVAlignment; virtual;
    function HeaderDrawEdgeFlag: Integer;
    function OverflowPanelImage: TPicture; virtual;
    function OverflowPanelBackColor: TColor; virtual;
    function OverflowPanelBackColor2: TColor; virtual;
    function OverflowPanelAlphaBlend: Byte; virtual;
    function OverflowPanelAlphaBlend2: Byte; virtual;
    function OverflowPanelGradientMode: TdxBarStyleGradientMode; virtual;
    function OverflowPanelFont: TFont; virtual;
    function OverflowPanelFontColor: TColor; virtual;
    function SplitterBackColor: TColor; virtual;
    function SplitterBackColor2: TColor; virtual;
    function SplitterAlphaBlend: Byte; virtual;
    function SplitterAlphaBlend2: Byte; virtual;
    function SplitterGradientMode: TdxBarStyleGradientMode; virtual;
    // Default styles
    procedure AssignDefaultBackgroundStyle; virtual;
    procedure AssignDefaultButtonStyle; virtual;
    procedure AssignDefaultButtonPressedStyle; virtual;
    procedure AssignDefaultButtonHotTrackedStyle; virtual;
    procedure AssignDefaultGroupControlStyle; virtual;
    procedure AssignDefaultGroupBackgroundStyle; virtual;
    procedure AssignDefaultGroupHeaderStyle; virtual;
    procedure AssignDefaultGroupHeaderActiveStyle; virtual;
    procedure AssignDefaultGroupHeaderActiveHotTrackedStyle; virtual;
    procedure AssignDefaultGroupHeaderActivePressedStyle; virtual;
    procedure AssignDefaultGroupHeaderHotTrackedStyle; virtual;
    procedure AssignDefaultGroupHeaderPressedStyle; virtual;
    procedure AssignDefaultHintStyle; virtual;
    procedure AssignDefaultItemStyle; virtual;
    procedure AssignDefaultItemDisabledStyle; virtual;
    procedure AssignDefaultItemHotTrackedStyle; virtual;
    procedure AssignDefaultItemPressedStyle; virtual;
    procedure AssignDefaultDropTargetGroupStyle; virtual;
    procedure AssignDefaultDropTargetLinkStyle; virtual;
    procedure AssignDefaultNavigationPaneHeaderStyle; virtual;
    // Groups
    function ActiveGroupViewInfo: TdxNavBarGroupViewInfo; 
    function GetGroupViewInfoByGroup(AGroup: TdxNavBarGroup): TdxNavBarGroupViewInfo;
    function GetLinkViewInfoByLink(ALink: TdxNavBarItemLink): TdxNavBarLinkViewInfo;
    function IndexOfGroupViewInfo(AViewInfo: TdxNavBarGroupViewInfo): Integer;
    // Hit tests
    function GetGroupViewInfoAtPos(const pt: TPoint): TdxNavBarGroupViewInfo;
    function GetGroupViewInfoAtCaptionPos(const pt: TPoint): TdxNavBarGroupViewInfo; virtual;
    function GetGroupViewInfoAtItemsPos(const pt: TPoint): TdxNavBarGroupViewInfo; virtual;
    function GetGroupAtCaptionPos(const pt: TPoint): TdxNavBarGroup;
    function GetGroupAtItemsPos(const pt: TPoint): TdxNavBarGroup;

    function GetLinkViewInfoAtPos(const pt: TPoint): TdxNavBarLinkViewInfo; virtual;
    function GetLinkViewInfoAtSelectedPos(const pt: TPoint): TdxNavBarLinkViewInfo; virtual;
    function GetLinkAtPos(const pt: TPoint): TdxNavBarItemLink; virtual;
    function GetLinkAtSelectedPos(const pt: TPoint): TdxNavBarItemLink;
    function GetViewInfoAtDragPosition(const pt: TPoint; var ItemGroup: TdxNavBarGroupViewInfo;
        var Item1, Item2: TdxNavBarLinkViewInfo): Integer; virtual;
    function GetViewInfoAtDragPositionWhenIconView(const pt: TPoint; var ItemGroup: TdxNavBarGroupViewInfo;
        var Item1, Item2: TdxNavBarLinkViewInfo): Integer; virtual;
    function GetLinksAtDragPosition(const pt: TPoint; var ItemGroup: TdxNavBarGroup;
        var Item1, Item2: TdxNavBarItemLink): Integer;
    function IsPtGroupDesignRect(const pt: TPoint): Boolean;
    function IsPtItemDesignRect(const pt: TPoint): Boolean;
//    function IsPtNavigationPaneHeader(const pt: TPoint): Boolean; virtual;
//    function IsPtNavigationPaneSplitter(const pt: TPoint): Boolean; virtual;
//    function IsPtNavigationPaneOverflowPanel(const pt: TPoint): Boolean; virtual;
//    function GetNavigationPaneOverflowPanelItemIndexAtPos(const pt: TPoint): Integer; virtual;
//    function GetNavigationPaneOverflowPanelGroupAtPos(const pt: TPoint): TdxNavBarGroup; virtual;
    // Scroll buttons
    function IsTopScrollButtonVisible: Boolean;
    function IsBottomScrollButtonVisible: Boolean;
    function IsPtTopScrollButton(const pt: TPoint): Boolean;
    function IsPtBottomScrollButton(const pt: TPoint): Boolean;
    property TopScrollButtonRect: TRect read FTopScrollButtonRect;
    property BottomScrollButtonRect: TRect read FBottomScrollButtonRect;
    property TopScrollButtonState: TdxNavBarObjectStates read GetTopScrollButtonState;
    property BottomScrollButtonState: TdxNavBarObjectStates read GetBottomScrollButtonState;
    // Hint
    property HintRect: TRect read FHintRect write FHintRect;
    property HintText: string read FHintText write FHintText;
    // Accelerators
    function FindGroupWithAccel(AKey: Word): TdxNavBarGroup; virtual;
    function FindLinkWithAccel(AKey: Word): TdxNavBarItemLink; virtual;

    property GroupCount: Integer read GetGroupCount;
    property Groups[Index: Integer]: TdxNavBarGroupViewInfo read GetGroup;
  end;
  TdxNavBarViewInfoClass = class of TdxNavBarViewInfo;

  { TdxNavBarItemCalculators }

  TdxNavBarItemCalculator = class(TdxNavBarCustomGroupItemCalculator)
  public
    class procedure CalculateBounds(X, Y: Integer; var ALinkViewInfo); override;
  end;

  TdxNavBarSeparatorCalculator = class(TdxNavBarCustomGroupItemCalculator)
  public
    class procedure CalculateBounds(X, Y: Integer; var ALinkViewInfo); override;
  end;

  TdxNavBarPainter = class(TdxNavBarPersistent, IUnknown)
  private
    FNeedRecreateViewInfo: Boolean;
    FNeedRecalculateViewInfo: Boolean;
    FViewInfo: TdxNavBarViewInfo;
    FController: TdxNavBarController;

    function GetCanvas: TCanvas;
    function GetcxCanvas: TcxCanvas;
  protected
    { IUnknown }
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;

    function GetMasterLookAndFeel: TcxLookAndFeel; virtual;
    procedure CheckDrawParamChanges;
    procedure CheckViewInfo;
    class function Reregistered: Boolean; virtual;
    // View infos
    function CreateViewInfo: TdxNavBarViewInfo; virtual;
    function CreateGroupViewInfo(AViewInfo: TdxNavBarViewInfo; AGroup:
      TdxNavBarGroup; ACaptionVisible, AItemsVisible: Boolean): TdxNavBarGroupViewInfo; virtual;
    function CreateLinkViewInfo(AViewInfo: TdxNavBarGroupViewInfo; ALink: TdxNavBarItemLink;
      ACaptionVisible, AImageVisisble: Boolean): TdxNavBarLinkViewInfo; virtual;
    class function GetViewInfoClass: TdxNavBarViewInfoClass; virtual;
    class function GetGroupViewInfoClass: TdxNavBarGroupViewInfoClass; virtual;
    class function GetLinkViewInfoClass: TdxNavBarLinkViewInfoClass; virtual;

    procedure RecreateViewInfo;
    procedure RecalculateViewInfo;
    procedure RedrawCanvas;

    // Controller
    function CreateController: TdxNavBarController;
    function GetControllerClass: TdxNavBarControllerClass; virtual;
    // ScrollBar
    function CreatecxScrollBarHelper(AOwner: TdxNavBarScrollBar): TcxControlScrollBarHelper; virtual;
    function GetcxScrollBarHelperClass: TcxControlScrollBarHelperClass; virtual;
    function NeedScrollBar: Boolean; virtual;
    procedure UpdateScrollBarLookAndFeel(ALookAndFeel: TcxLookAndFeel); virtual;

    function GetOwner: TPersistent; override;
    function IsViewInfoValid: Boolean;
    // Drawing
    procedure DoDrawHint(ACanvas: TCanvas; const ARect: TRect); virtual;
    procedure DrawSolidFocusRect(ARect: TRect; AColor: TColor);
  public
    constructor Create(ANavBar: TdxCustomNavBar); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    function DC: HDC;
    // Drawing
    procedure DrawNavBarControl; virtual;
    procedure DrawBackground; virtual;
    procedure DrawGroup(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupBackground(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupBorder(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupCaption(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupCaptionButton(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupCaptionText(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupCaptionImage(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupCaptionSign(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupControl(ACanvas: TCanvas; ARect: TRect; AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupDesignRect(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupItems(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupFocusRect(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawItem(ALinkViewInfo: TdxNavBarLinkViewInfo); virtual;
    procedure DrawItemCaption(ALinkViewInfo: TdxNavBarLinkViewInfo); virtual;
    procedure DrawItemDesignRect(ALinkViewInfo: TdxNavBarLinkViewInfo); virtual;
    procedure DrawItemFocusRect(ALinkViewInfo: TdxNavBarLinkViewInfo); virtual;
    procedure DrawItemImage(ALinkViewInfo: TdxNavBarLinkViewInfo); virtual;
    procedure DrawItemSelection(ALinkViewInfo: TdxNavBarLinkViewInfo); virtual;
    procedure DrawItemsRect(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawSeparator(ALinkViewInfo: TdxNavBarLinkViewInfo); virtual;
    procedure DrawScrollButtons; virtual;
    procedure DrawBottomScrollButton; virtual;
    procedure DrawTopScrollButton; virtual;
    procedure DrawDropTargetGroupSelection; virtual;
    procedure DrawDropTargetLinkSelection; virtual;
    procedure DrawHintWindow(AHintWindow: TdxNavBarHintWindow); virtual;
    procedure DrawGroupHintWindow(ACanvas: TCanvas; const ARect: TRect); virtual;
    procedure DrawLinkHintWindow(ACanvas: TCanvas; const ARect: TRect); virtual;

    procedure InvalidateViewInfo(AType: TdxNavBarChangeType);
    procedure InvalidateScrollButtons;
    procedure Paint;
    class function GetCategories: TdxNavBarViewCategories; virtual;

    property Canvas: TCanvas read GetCanvas;
    property cxCanvas: TcxCanvas read GetcxCanvas;
    property Controller: TdxNavBarController read FController;
    property ViewInfo: TdxNavBarViewInfo read FViewInfo;
  end;
  TdxNavBarPainterClass = class of TdxNavBarPainter;

  { TdxNavBarCursors }

  TdxNavBarCursors = class(TdxNavBarPersistent)
  private
    FDragCopyCursor: TCursor;
    FHotTrackedGroupCursor: TCursor;
    FHotTrackedLinkCursor: TCursor;

    function GetCursor: TCursor;
    function GetDragCursor: TCursor;
    procedure SetCursor(Value: TCursor);
    procedure SetDragCursor(Value: TCursor);
  public
    constructor Create(ANavBar: TdxCustomNavBar); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Cursor: TCursor read GetCursor write SetCursor default crDefault;
    property DragCursor: TCursor read GetDragCursor write SetDragCursor default dxNavBarDragCursor;
    property DragCopyCursor: TCursor read FDragCopyCursor write FDragCopyCursor default dxNavBarDragCopyCursor;
    property HotTrackedGroupCursor: TCursor read FHotTrackedGroupCursor write FHotTrackedGroupCursor default crDefault;
    property HotTrackedLinkCursor: TCursor read FHotTrackedLinkCursor write FHotTrackedLinkCursor default dxNavBarLinksCursor;
  end;

  { TdxNavBarCustomDraw }

  TdxNavBarCustomDrawEvent = procedure(Sender: TObject; ACanvas: TCanvas;
      AViewInfo: TdxNavBarViewInfo; var AHandled: Boolean) of object;
  TdxNavBarCustomDrawGroupEvent = procedure(Sender: TObject; ACanvas: TCanvas;
      AViewInfo: TdxNavBarGroupViewInfo; var AHandled: Boolean) of object;
  TdxNavBarCustomDrawGroupHintEvent = procedure(Sender: TObject; ACanvas: TCanvas;
      AGroup: TdxNavBarGroup; AHint: string; R: TRect; var AHandled: Boolean) of object;
  TdxNavBarCustomDrawLinkEvent = procedure(Sender: TObject; ACanvas: TCanvas;
      AViewInfo: TdxNavBarLinkViewInfo; var AHandled: Boolean) of object;
  TdxNavBarCustomDrawLinkHintEvent = procedure(Sender: TObject; ACanvas: TCanvas;
      ALink: TdxNavBarItemLink; AHint: string; R: TRect; var AHandled: Boolean) of object;

  TdxNavBarCustomDrawEvents = class(TdxNavBarPersistent)
  private
    FBackground: TdxNavBarCustomDrawEvent;
    FBottomScrollButton: TdxNavBarCustomDrawEvent;
    FTopScrollButton: TdxNavBarCustomDrawEvent;
    FGroupCaption: TdxNavBarCustomDrawGroupEvent;
    FGroupClientBackground: TdxNavBarCustomDrawGroupEvent;
    FGroupClientForeground: TdxNavBarCustomDrawGroupEvent;
    FGroupHint: TdxNavBarCustomDrawGroupHintEvent;
    FLink: TdxNavBarCustomDrawLinkEvent;
    FLinkHint: TdxNavBarCustomDrawLinkHintEvent;
    FNavigationPaneHeader: TdxNavBarCustomDrawEvent;
    FNavigationPaneSplitter: TdxNavBarCustomDrawEvent;
    FNavigationPaneOverflowPanel: TdxNavBarCustomDrawEvent;
    FNavigationPaneOverflowPanelHint: TdxNavBarCustomDrawGroupHintEvent;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Background: TdxNavBarCustomDrawEvent read FBackground write FBackground;
    property GroupCaption: TdxNavBarCustomDrawGroupEvent read FGroupCaption write FGroupCaption;
    property GroupClientBackground: TdxNavBarCustomDrawGroupEvent read FGroupClientBackground write FGroupClientBackground;
    property GroupClientForeground: TdxNavBarCustomDrawGroupEvent read FGroupClientForeground write FGroupClientForeground;
    property GroupHint: TdxNavBarCustomDrawGroupHintEvent read FGroupHint write FGroupHint;
    property Link: TdxNavBarCustomDrawLinkEvent read FLink write FLink;
    property LinkHint: TdxNavBarCustomDrawLinkHintEvent read FLinkHint write FLinkHint;
    property BottomScrollButton: TdxNavBarCustomDrawEvent read FBottomScrollButton write FBottomScrollButton;
    property TopScrollButton: TdxNavBarCustomDrawEvent read FTopScrollButton write FTopScrollButton;
    property NavigationPaneHeader: TdxNavBarCustomDrawEvent read FNavigationPaneHeader write FNavigationPaneHeader;
    property NavigationPaneSplitter: TdxNavBarCustomDrawEvent read FNavigationPaneSplitter write FNavigationPaneSplitter;
    property NavigationPaneOverflowPanel: TdxNavBarCustomDrawEvent read FNavigationPaneOverflowPanel write FNavigationPaneOverflowPanel;
    property NavigationPaneOverflowPanelHint: TdxNavBarCustomDrawGroupHintEvent read FNavigationPaneOverflowPanelHint write FNavigationPaneOverflowPanelHint;
  end;

  { TdxNavBarCustomCustomizationForm }

  TdxNavBarCustomCustomizationForm = class(TForm)
  private
    FNavBar: TdxCustomNavBar;
    FLockCount: Integer;
    procedure SetNavBar(Value: TdxCustomNavBar);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoClose(var Action: TCloseAction); override;

    procedure CreateControls;
    procedure DoCreateControls; virtual;
    procedure Init; virtual;
    procedure Localize; virtual;

    procedure DoRefreshItems; virtual;
    procedure RefreshItems;

    procedure CreateLink(AItem: TdxNavBarItem; AGroup: TdxNavBarGroup; AIndex: Integer);
    procedure MoveLink(ALink: TdxNavBarItemLink; AGroup: TdxNavBarGroup; AIndex: Integer);
    procedure RemoveLink(ALink: TdxNavBarItemLink);

    function CanProcessDropItem(Target: TObject; X, Y: Integer): Boolean; virtual;
    procedure DoProcessDropItem(Target: TObject; X, Y: Integer); virtual;
    procedure ProcessDropItem(Target: TObject; X, Y: Integer);
  public
    destructor Destroy; override;

    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure EndUpdate;

    property NavBar: TdxCustomNavBar read FNavBar write SetNavBar;
  end;
  TdxNavBarCustomCustomizationFormClass = class of TdxNavBarCustomCustomizationForm;

  { TdxNavBarCustomization }

  TdxNavBarCustomization = class(TdxNavBarPersistent)
  private
    FForm: TdxNavBarCustomCustomizationForm;
    FFormBounds: TRect;
    function GetVisible: Boolean;
    procedure SetVisible(Value: Boolean);
  protected
    function CalculateFormBounds: TRect; virtual;
    procedure CreateForm; virtual;
    procedure EndDrag(Target: TObject; X, Y: Integer); virtual;
    function GetFormClass: TdxNavBarCustomCustomizationFormClass; virtual;
    procedure RefreshItems;
  public
    destructor Destroy; override;

    property Visible: Boolean read GetVisible write SetVisible;
    property Form: TdxNavBarCustomCustomizationForm read FForm;
    property FormBounds: TRect read FFormBounds write FFormBounds;
  end;
  TdxNavBarCustomizationClass = class of TdxNavBarCustomization;

  { TdxNavBarOptions }

  { TdxNavBarBehaviorOptions }

  TdxNavBarCommonBehaviorOptions = class(TdxNavBarPersistent)
  private
    FAllowSelectLinks: Boolean;
    FDragDropFlags: TdxNavBarDragDropFlags;
    FEachGroupHasSelectedLink: Boolean;
    FShowGroupsHint: Boolean;
    FShowLinksHint: Boolean;
    procedure SetAllowSelectLinks(Value: Boolean);
    procedure SetEachGroupHasSelectedLink(Value: Boolean);
  public
    constructor Create(ANavBar: TdxCustomNavBar); override;
    procedure Assign(Source: TPersistent); override;
  published
    property AllowSelectLinks: Boolean read FAllowSelectLinks write SetAllowSelectLinks default False;
    property DragDropFlags: TdxNavBarDragDropFlags read FDragDropFlags write FDragDropFlags default dxNavBarDefaultDragDropFlags;
    property EachGroupHasSelectedLink: Boolean read FEachGroupHasSelectedLink write SetEachGroupHasSelectedLink default False;
    property ShowGroupsHint: Boolean read FShowGroupsHint write FShowGroupsHint default False;
    property ShowLinksHint: Boolean read FShowLinksHint write FShowLinksHint default False;
  end;

  TdxNavBarNavigationPaneBehaviorOptions = class(TdxNavBarPersistent)
  private
    FAdjustWidthByPopup: Boolean;
    FAllowCustomizing: Boolean;
    FCollapsible: Boolean;
    FCollapsed: Boolean;
    FShowOverflowPanelHints: Boolean;

    procedure SetCollapsible(Value: Boolean);
    procedure SetCollapsed(Value: Boolean);
  public
    constructor Create(ANavBar: TdxCustomNavBar); override;
    procedure Assign(Source: TPersistent); override;
  published
    property AdjustWidthByPopup: Boolean read FAdjustWidthByPopup write FAdjustWidthByPopup default False;
    property AllowCustomizing: Boolean read FAllowCustomizing write FAllowCustomizing default True;
    property Collapsible: Boolean read FCollapsible write SetCollapsible default False;
    property Collapsed: Boolean read FCollapsed write SetCollapsed default False;
    property ShowOverflowPanelHints: Boolean read FShowOverflowPanelHints write FShowOverflowPanelHints default True;
  end;

  TdxNavBarSideBarBehaviorOptions = class(TdxNavBarPersistent)
  private
    function GetAllowSelectLinks: Boolean;
    function GetEachGroupHasSelectedLink: Boolean;
    procedure SetAllowSelectLinks(Value: Boolean);
    procedure SetEachGroupHasSelectedLink(Value: Boolean);
  public
    procedure Assign(Source: TPersistent); override;
  published
    property AllowSelectLinks: Boolean read GetAllowSelectLinks write SetAllowSelectLinks stored False;
    property EachGroupHasSelectedLink: Boolean read GetEachGroupHasSelectedLink write SetEachGroupHasSelectedLink stored False;
  end;

  TdxNavBarBehaviorOptions = class(TdxNavBarPersistent)
  private
    FCommon: TdxNavBarCommonBehaviorOptions;
    FNavigationPane: TdxNavBarNavigationPaneBehaviorOptions;
    FSideBar: TdxNavBarSideBarBehaviorOptions;

    procedure SetCommon(AValue: TdxNavBarCommonBehaviorOptions);
    procedure SetNavigationPane(AValue: TdxNavBarNavigationPaneBehaviorOptions);
    procedure SetSideBar(AValue: TdxNavBarSideBarBehaviorOptions);
  public
    constructor Create(ANavBar: TdxCustomNavBar); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Common: TdxNavBarCommonBehaviorOptions read FCommon write SetCommon;
    property NavigationPane: TdxNavBarNavigationPaneBehaviorOptions read FNavigationPane write SetNavigationPane;
    property SideBar: TdxNavBarSideBarBehaviorOptions read FSideBar write SetSideBar stored False;
  end;

  { TdxNavBarViewOptions }

  TdxNavBarCommonViewOptions = class(TdxNavBarPersistent)
  private
    FShowGroupCaptions: Boolean;

    procedure SetShowGroupCaptions(AValue: Boolean);
  public
    constructor Create(ANavBar: TdxCustomNavBar); override;
    procedure Assign(Source: TPersistent); override;
  published
    property ShowGroupCaptions: Boolean read FShowGroupCaptions write SetShowGroupCaptions default True;
  end;

  TdxNavBarExplorerBarViewOptions = class(TdxNavBarPersistent)
  private
    FShowSpecialGroup: Boolean;
    FSpaceBetweenGroups: Integer;

    procedure SetShowSpecialGroup(Value: Boolean);
    procedure SetSpaceBetweenGroups(Value: Integer);
  public
    procedure Assign(Source: TPersistent); override;
  published
    property ShowSpecialGroup: Boolean read FShowSpecialGroup write SetShowSpecialGroup default False;
    property SpaceBetweenGroups: Integer read FSpaceBetweenGroups write SetSpaceBetweenGroups default 0;
  end;

  TdxNavBarNavigationPaneViewOptions = class(TdxNavBarPersistent)
  private
    FMaxVisibleGroups: Integer;
    FOverflowPanelUseSmallImages: Boolean;
    FShowActiveGroupCaptionWhenCollapsed: Boolean;
    FShowHeader: Boolean;
    FShowOverflowPanel: Boolean;

    procedure SetMaxVisibleGroups(Value: Integer);
    procedure SetOverflowPanelUseSmallImages(Value: Boolean);
    procedure SetShowActiveGroupCaptionWhenCollapsed(Value: Boolean);
    procedure SetShowHeader(Value: Boolean);
    procedure SetShowOverflowPanel(Value: Boolean);
  public
    constructor Create(ANavBar: TdxCustomNavBar); override;
    procedure Assign(Source: TPersistent); override;
  published
    property MaxVisibleGroups: Integer read FMaxVisibleGroups write SetMaxVisibleGroups default -1;
    property OverflowPanelUseSmallImages: Boolean read FOverflowPanelUseSmallImages write SetOverflowPanelUseSmallImages default True;
    property ShowActiveGroupCaptionWhenCollapsed: Boolean read FShowActiveGroupCaptionWhenCollapsed write SetShowActiveGroupCaptionWhenCollapsed default False;
    property ShowHeader: Boolean read FShowHeader write SetShowHeader default True;
    property ShowOverflowPanel: Boolean read FShowOverflowPanel write SetShowOverflowPanel default True;
  end;

  TdxNavBarViewOptions = class(TdxNavBarPersistent)
  private
    FCommon: TdxNavBarCommonViewOptions;
    FExplorerBar: TdxNavBarExplorerBarViewOptions;
    FNavigationPane: TdxNavBarNavigationPaneViewOptions;

    procedure SetCommon(AValue: TdxNavBarCommonViewOptions);
    procedure SetExplorerBar(AValue: TdxNavBarExplorerBarViewOptions);
    procedure SetNavigationPane(AValue: TdxNavBarNavigationPaneViewOptions);
  public
    constructor Create(ANavBar: TdxCustomNavBar); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Common: TdxNavBarCommonViewOptions read FCommon write SetCommon;
    property ExplorerBar: TdxNavBarExplorerBarViewOptions read FExplorerBar write SetExplorerBar;
    property NavigationPane: TdxNavBarNavigationPaneViewOptions read FNavigationPane write SetNavigationPane;
  end;

  { TdxNavBarImageOptions }

  TdxNavBarImageOptions = class(TdxNavBarNexusPersistent)
  private
    FDisabledSmallImages: TCustomImageList;
    FDisabledLargeImages: TCustomImageList;
    FHotSmallImages: TCustomImageList;
    FHotLargeImages: TCustomImageList;
    FLargeImages: TCustomImageList;
    FSmallImages: TCustomImageList;
    FDisabledLargeChangeLink: TChangeLink;
    FDisabledSmallChangeLink: TChangeLink;
    FHotLargeChangeLink: TChangeLink;
    FHotSmallChangeLink: TChangeLink;
    FLargeChangeLink: TChangeLink;
    FSmallChangeLink: TChangeLink;
    procedure SetImageList(var ANewValue, AOldValue: TCustomImageList; const AChangeLink: TChangeLink);
    procedure SetDisabledLargeImages(Value: TCustomImageList);
    procedure SetDisabledSmallImages(Value: TCustomImageList);
    procedure SetHotLargeImages(Value: TCustomImageList);
    procedure SetHotSmallImages(Value: TCustomImageList);
    procedure SetLargeImages(Value: TCustomImageList);
    procedure SetSmallImages(Value: TCustomImageList);
  protected
    procedure FreeNotification(AComponent: TComponent); override;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property DisabledLargeImages: TCustomImageList read FDisabledLargeImages write SetDisabledLargeImages;
    property DisabledSmallImages: TCustomImageList read FDisabledSmallImages write SetDisabledSmallImages;
    property HotLargeImages: TCustomImageList read FHotLargeImages write SetHotLargeImages;
    property HotSmallImages: TCustomImageList read FHotSmallImages write SetHotSmallImages;
    property LargeImages: TCustomImageList read FLargeImages write SetLargeImages;
    property SmallImages: TCustomImageList read FSmallImages write SetSmallImages;
  end;

  { TdxNavBarController }

  TdxNavBarPart = record
    MajorPartIndex: Integer;
    MinorPartIndex: Integer;
  end;

  TdxNavBarController = class
  private
    FHotPart: TdxNavBarPart;
    FPressedPart: TdxNavBarPart;

    function GetPainter: TdxNavBarPainter;
    function GetScrollBarHelper: TcxControlScrollBarHelper;
    function GetViewInfo: TdxNavBarViewInfo;

    procedure CalcGroupHintRect(AItem: TObject; var ARect: TRect);
    procedure CalcLinkHintRect(AItem: TObject; var ARect: TRect);

    procedure SetHotPart(APart: TdxNavBarPart);
    procedure SetPressedPart(APart: TdxNavBarPart);
    procedure UpdateHotTrack(AShift: TShiftState = []); overload;
    procedure UpdateHotTrack(AShift: TShiftState; const APoint: TPoint); overload;
  protected
    FNavBar: TdxCustomNavBar;

    function CanFocusOnClick(const APoint: TPoint): Boolean; virtual;
    function GetCursor: HIcon; virtual;
    function GetItemHintRect(ANavBarItem: TObject; ACalcHintProc: TdxNavBarCalcHintEvent): TRect;
    function GetPartAtPos(const APoint: TPoint): TdxNavBarPart; virtual;

    procedure DoClick(const APart: TdxNavBarPart); virtual;
    procedure DoCheckBounds(var ALeft, ATop, AWidth, AHeight: Integer); virtual;
    procedure DoLinkClick(ANavBar: TdxCustomNavBar; ALink: TdxNavBarItemLink); virtual;
    procedure DoLinkHotTrack(ANavBar: TdxCustomNavBar; ALink: TdxNavBarItemLink); virtual;
    procedure DoLinkPress(ANavBar: TdxCustomNavBar; ALink: TdxNavBarItemLink); virtual;
    procedure DoMouseDown(AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint); virtual;
    procedure DoMouseUp(AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint); virtual;
    procedure DoMouseMove(AShift: TShiftState; const APoint: TPoint); virtual;
    procedure DoMouseLeave; virtual;
    function DoMouseWheel(AShift: TShiftState; AWheelDelta: Integer; const APoint: TPoint): Boolean; virtual;
    function DoScrollDown: Boolean;
    function DoScrollUp: Boolean;
    procedure DoSetHotPart(const APart: TdxNavBarPart); virtual;
    procedure DoSetPressedPart(const APart: TdxNavBarPart); virtual;
    procedure DoShowHint(var AHintInfo: THintInfo); virtual;

    procedure DoShowGroupHint(var AHintInfo: THintInfo; AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DoShowLinkHint(var AHintInfo: THintInfo; ALinkViewInfo: TdxNavBarLinkViewInfo); virtual;
    function GetGroupHintRect(AGroup: TdxNavBarGroup): TRect; virtual;
    function GetGroupHintText(AGroup: TdxNavBarGroup): string; virtual;
    function GetLinkHintRect(ALink: TdxNavBarItemLink): TRect; virtual;
    function GetLinkHintText(ALink: TdxNavBarItemLink): string; virtual;

    property NavBar: TdxCustomNavBar read FNavBar;
    property ScrollBarHelper: TcxControlScrollBarHelper read GetScrollBarHelper;
  public
    constructor Create(ANavBar: TdxCustomNavBar); virtual;
    destructor Destroy; override;
    procedure CheckBounds(var ALeft, ATop, AWidth, AHeight: Integer);
    procedure InvalidateAll(AType: TdxNavBarChangeType);
    procedure MouseDown(AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint);
    procedure MouseUp(AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint);
    procedure MouseMove(AShift: TShiftState; const APoint: TPoint);
    procedure MouseLeave;
    function MouseWheel(AShift: TShiftState; AWheelDelta: Integer; const APoint: TPoint): Boolean;
    procedure ShowHint(var AHintInfo: THintInfo; out ACanShow: Boolean);

    property HotPart: TdxNavBarPart read FHotPart write SetHotPart;
    property PressedPart: TdxNavBarPart read FPressedPart write SetPressedPart;
    property Painter: TdxNavBarPainter read GetPainter;
    property ViewInfo: TdxNavBarViewInfo read GetViewInfo;
  end;

  TdxNavBarGroupEvent = procedure(Sender: TObject; AGroup: TdxNavBarGroup) of object;
  TdxNavBarGroupChangingEvent = procedure(Sender: TObject; ANewGroup: TdxNavBarGroup; var AAllowChange: Boolean) of object;
  TdxNavBarLinkEvent = procedure(Sender: TObject; ALink: TdxNavBarItemLink) of object;
  TdxNavBarCalcGroupHintRectEvent = procedure(Sender: TObject; AGroup: TdxNavBarGroup;
      AViewInfo: TdxNavBarViewInfo; var R: TRect) of object;
  TdxNavBarCalcLinkHintRectEvent = procedure(Sender: TObject; ALink: TdxNavBarItemLink;
      AViewInfo: TdxNavBarViewInfo; var R: TRect) of object;
  TdxNavBarCalcGroupClientHeightEvent = procedure(Sender: TObject; AViewInfo: TdxNavBarGroupViewInfo;
      var AHeight: Integer) of object;
  TdxNavBarGetGroupHintEvent = procedure(Sender: TObject; AGroup: TdxNavBarGroup;
      var AHint: string) of object;
  TdxNavBarGetLinkHintEvent = procedure(Sender: TObject; ALink: TdxNavBarItemLink;
      var AHint: string) of object;

  TdxNavBarInternalState = (nbisKeyDowned, nbisDragging, nbisAlreadyCollapsed, nbisAfterLoading);
  TdxNavBarInternalStates = set of TdxNavBarInternalState;

  TdxNavBarLookAndFeelSchemes = class(TdxNavBarPersistent)
  private
    FViews: array [TcxLookAndFeelStyle] of Integer;
    function GetRealView(Index: Integer): Integer;
    function GetView(Index: TcxLookAndFeelStyle): Integer;
    procedure SetRealView(Index: Integer; const Value: Integer);
    procedure SetView(Index: TcxLookAndFeelStyle; const Value: Integer);
  protected
    procedure Changed; virtual;
  public
    constructor Create(ANavBar: TdxCustomNavBar); override;
    procedure Assign(Source: TPersistent); override;
    property Views[Index: TcxLookAndFeelStyle]: Integer read GetView write SetView;
  published
    property Flat: Integer index lfsFlat read GetRealView write SetRealView default dxNavBarFlatView;
    property Standard: Integer index lfsStandard read GetRealView write SetRealView default dxNavBarBaseView;
    property UltraFlat: Integer index lfsUltraFlat read GetRealView write SetRealView default dxNavBarFlatView;
    property Native: Integer index lfsNative read GetRealView write SetRealView default dxNavBarOffice12NavigatorPaneView;
    property Office11: Integer index lfsOffice11 read GetRealView write SetRealView default dxNavBarOffice11NavigatorPaneView;
    property Skin: Integer index lfsSkin read GetRealView write SetRealView default dxNavBarSkinNavigatorPaneView;
  end;

  TdxCustomNavBar = class(TcxControl, IcxDesignSelectionChanged{, IcxMouseTrackingCaller})
  private
    FActiveGroup: TdxNavBarGroup;
    FActiveGroupIndex: Integer;
    FBorderStyle: TBorderStyle;
    FCursors: TdxNavBarCursors;
    FCustomization: TdxNavBarCustomization;
    FDragObject: TDragControlObject;
    FGroups: TdxNavBarGroups;
    FInternalState: TdxNavBarInternalStates;
    FIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    FIsBoundsCheckingLockCount: Integer;
    FIsCollapseStateChecking: Boolean;
    FIsLookAndFeelDependent: Boolean;
    FItems: TdxNavBarItems;
    FLookAndFeelSchemes: TdxNavBarLookAndFeelSchemes;
    FPainter: TdxNavBarPainter;
    FViewReal: Integer;
    FScrollBar: TdxNavBarScrollBar;
    FThemeNotificator: TdxThemeChangedNotificator;
    FUpdateLock: Integer;
    FView: Integer;

    FOptionsBehavior: TdxNavBarBehaviorOptions;
    FOptionsImage: TdxNavBarImageOptions;
    FOptionsStyle: TdxNavBarStyleOptions;
    FOptionsView: TdxNavBarViewOptions;

    FOnCustomDraw: TdxNavBarCustomDrawEvents;
    FOnActiveGroupChanged: TNotifyEvent;
    FOnActiveGroupChanging: TdxNavBarGroupChangingEvent;
    FOnCalcGroupHintRect: TdxNavBarCalcGroupHintRectEvent;
    FOnCalcGroupClientHeight: TdxNavBarCalcGroupClientHeightEvent;
    FOnCalcLinkHintRect: TdxNavBarCalcLinkHintRectEvent;
    FOnCalcNavigationPaneOverflowPanelHintRect: TdxNavBarCalcGroupHintRectEvent;
    FOnCollapseStateChanged: TNotifyEvent;
    FOnGetGroupHint: TdxNavBarGetGroupHintEvent;
    FOnGetLinkHint: TdxNavBarGetLinkHintEvent;
    FOnGroupClick: TdxNavBarGroupEvent;
    FOnGroupHotTrack: TdxNavBarGroupEvent;
    FOnGroupPress: TdxNavBarGroupEvent;
    FOnLinkClick: TdxNavBarLinkEvent;
    FOnLinkHotTrack: TdxNavBarLinkEvent;
    FOnLinkPress: TdxNavBarLinkEvent;
    FOnNavigationPaneCollapsed: TNotifyEvent;
    FOnNavigationPaneExpanded: TNotifyEvent;

    FActivateGroupTimer: TcxTimer;
    FScrollTimer: TcxTimer;

    FActiveGroupCandidate: TdxNavBarGroup;
    FFocusedAccessibleObject: IdxNavBarAccessibilityHelper;
    FSourcePoint: TPoint;
    FSourceShift: TShiftState;
    FSourceGroup: TdxNavBarGroup;
    FSourceLink: TdxNavBarItemLink;
    FTargetPoint: TPoint;
    FHotTrackedGroup: TdxNavBarGroup;
    FHotTrackedLink: TdxNavBarItemLink;
    FOriginalWidth: Integer;
    FPressedGroup: TdxNavBarGroup;
    FPressedLink: TdxNavBarItemLink;
    FScrollButtonDownIsDown: Boolean;
    FScrollButtonUpIsDown: Boolean;

    function GetController: TdxNavBarController;
    function GetPainter: TdxNavBarPainter;
    function GetViewInfo: TdxNavBarViewInfo;

    function GetActiveGroup: TdxNavBarGroup;
    function GetActiveGroupIndex: Integer;
    function GetNavigationPaneOverflowPanelItemCount: Integer;
    function GetEnableDragging: Boolean;
    function GetIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    function GetScrollPosition: Integer;
    function GetSourceGroup: TdxNavBarGroup;
    function GetSourceLink: TdxNavBarItemLink;
    function GetSourceItem: TdxNavBarItem;
    function GetTargetGroup: TdxNavBarGroup;
    function GetTargetLink1: TdxNavBarItemLink;
    function GetTargetLink2: TdxNavBarItemLink;
    function GetTargetLinkIndex: Integer;
    function GetVisibleGroupCount: Integer;
    procedure SetActiveGroup(Value: TdxNavBarGroup);
    procedure SetActiveGroupIndex(Value: Integer);
    procedure SetBorderStyle(const Value: TBorderStyle);
    procedure SetFocusedAccessibleObject(Value: IdxNavBarAccessibilityHelper);

    // Cursors
    function GetDragCopyCursor: TCursor;
    function GetHotTrackedGroupCursor: TCursor;
    function GetHotTrackedLinkCursor: TCursor;
    procedure SetCursors(Value: TdxNavBarCursors);
    procedure SetDragCopyCursor(Value: TCursor);
    procedure SetHotTrackedGroupCursor(Value: TCursor);
    procedure SetHotTrackedLinkCursor(Value: TCursor);

    // ViewStyle
    procedure CheckViewReal;
    function IsViewRealStored: Boolean;
    function IsViewStored: Boolean;
    function GetViewStyle: TdxNavBarPainter;
    procedure SetLookAndFeelSchemes(const Value: TdxNavBarLookAndFeelSchemes);
    procedure SetViewReal(Value: Integer);
    procedure SetView(Value: Integer);
    procedure SetViewStyle(Value: TdxNavBarPainter);
    procedure UpdateViewReal;

    // OptionsImage
    function GetLargeImages: TCustomImageList;
    function GetSmallImages: TCustomImageList;
    procedure SetOptionsImage(Value: TdxNavBarImageOptions);
    procedure SetLargeImages(const Value: TCustomImageList);
    procedure SetSmallImages(const Value: TCustomImageList);

    // Options
    procedure SetOptionsView(Value: TdxNavBarViewOptions);
    procedure SetOptionsBehavior(Value: TdxNavBarBehaviorOptions);
    // Common
    function GetDragDropFlags: TdxNavBarDragDropFlags;
    function GetShowGroupCaptions: Boolean;
    function GetShowGroupsHint: Boolean;
    function GetShowLinksHint: Boolean;
    procedure SetDragDropFlags(Value: TdxNavBarDragDropFlags);
    procedure SetShowGroupsHint(const Value: Boolean);
    procedure SetShowLinksHint(const Value: Boolean);
    procedure SetShowGroupCaptions(Value: Boolean);
    // ExplorerStyle
    function GetShowSpecialGroup: Boolean;
    function GetSpaceBetweenGroups: Integer;
    procedure SetShowSpecialGroup(const Value: Boolean);
    procedure SetSpaceBetweenGroups(Value: Integer);
    // NavigationStyle
    function GetAllowSelectLinks: Boolean;
    function GetEachGroupHasSelectedLink: Boolean;
    procedure SetAllowSelectLinks(const Value: Boolean);
    procedure SetEachGroupHasSelectedLink(const Value: Boolean);
    // NavitationPane
    function GetNavigationPaneMaxVisibleGroups: Integer;
    function GetNavigationPaneOverflowPanelUseSmallImages: Boolean;
    function GetShowNavigationPaneOverflowPanelHints: Boolean;
    procedure SetNavigationPaneMaxVisibleGroups(Value: Integer);
    procedure SetNavigationPaneOverflowPanelUseSmallImages(const Value: Boolean);
    procedure SetShowNavigationPaneOverflowPanelHints(const Value: Boolean);

    // CustomDraw
    function GetOnCustomDrawBackground: TdxNavBarCustomDrawEvent;
    function GetOnCustomDrawBottomScrollButton: TdxNavBarCustomDrawEvent;
    function GetOnCustomDrawGroupCaption: TdxNavBarCustomDrawGroupEvent;
    function GetOnCustomDrawGroupClientBackground: TdxNavBarCustomDrawGroupEvent;
    function GetOnCustomDrawGroupClientForeground: TdxNavBarCustomDrawGroupEvent;
    function GetOnCustomDrawGroupHint: TdxNavBarCustomDrawGroupHintEvent;
    function GetOnCustomDrawLink: TdxNavBarCustomDrawLinkEvent;
    function GetOnCustomDrawLinkHint: TdxNavBarCustomDrawLinkHintEvent;
    function GetOnCustomDrawNavigationPaneHeader: TdxNavBarCustomDrawEvent;
    function GetOnCustomDrawNavigationPaneOverflowPanel: TdxNavBarCustomDrawEvent;
    function GetOnCustomDrawNavigationPaneOverflowPanelHint: TdxNavBarCustomDrawGroupHintEvent;
    function GetOnCustomDrawNavigationPaneSplitter: TdxNavBarCustomDrawEvent;
    function GetOnCustomDrawTopScrollButton: TdxNavBarCustomDrawEvent;
    procedure SetOnCustomDraw(Value: TdxNavBarCustomDrawEvents);
    procedure SetOnCustomDrawBackground(const Value: TdxNavBarCustomDrawEvent);
    procedure SetOnCustomDrawBottomScrollButton(const Value: TdxNavBarCustomDrawEvent);
    procedure SetOnCustomDrawGroupCaption(const Value: TdxNavBarCustomDrawGroupEvent);
    procedure SetOnCustomDrawGroupClientBackground(const Value: TdxNavBarCustomDrawGroupEvent);
    procedure SetOnCustomDrawGroupClientForeground(const Value: TdxNavBarCustomDrawGroupEvent);
    procedure SetOnCustomDrawGroupHint(const Value: TdxNavBarCustomDrawGroupHintEvent);
    procedure SetOnCustomDrawLink(const Value: TdxNavBarCustomDrawLinkEvent);
    procedure SetOnCustomDrawLinkHint(const Value: TdxNavBarCustomDrawLinkHintEvent);
    procedure SetOnCustomDrawNavigationPaneHeader(const Value: TdxNavBarCustomDrawEvent);
    procedure SetOnCustomDrawNavigationPaneOverflowPanel(const Value: TdxNavBarCustomDrawEvent);
    procedure SetOnCustomDrawNavigationPaneOverflowPanelHint(const Value: TdxNavBarCustomDrawGroupHintEvent);
    procedure SetOnCustomDrawNavigationPaneSplitter(const Value: TdxNavBarCustomDrawEvent);
    procedure SetOnCustomDrawTopScrollButton(const Value: TdxNavBarCustomDrawEvent);

    // Styles
    function GetDefaultStyles: TdxNavBarDefaultStyles;
    function GetNavBarCustomStyle(Index: Integer): TdxNavBarStyleItem;
    function GetStyles: TdxNavBarStyleRepository;
    procedure SetDefaultStyles(Value: TdxNavBarDefaultStyles);
    procedure SetNavBarCustomStyle(Index: Integer; const Value: TdxNavBarStyleItem);
    procedure SetOptionsStyle(Value: TdxNavBarStyleOptions);

    procedure DragDone;
    function IsAllowDragLink: Boolean;
    function IsAllowDropLink: Boolean;
    function IsAllowDragGroup: Boolean;
    function IsAllowDropGroup: Boolean;
    // Notifications
    procedure OnGroupsChanged(Sender: TObject; AItem: TcxComponentCollectionItem;
      AAction: TcxComponentCollectionNotification);
    procedure OnItemsChanged(Sender: TObject; AItem: TcxComponentCollectionItem;
      AAction: TcxComponentCollectionNotification);
    procedure OnStylesChanged(Sender: TObject);
    procedure OnImagesChanged(Sender: TObject);
    procedure OnLinksChanged(Sender: TObject; ALink: TdxNavBarItemLink);
    procedure OnThemeChanged;
    // Timers
    procedure DoActivateGroupTimer(Sender: TObject);
    procedure DoScrollTimer(Sender: TObject);
    // Messages
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMWindowPosChanging(var Message: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
  protected
    FDesignHelper: IcxDesignHelper;

    procedure AccessibleObjectOwnerObjectDestroyedNotification(
      Sender: TObject); virtual;
    procedure BoundsChanged; override;
    procedure CheckBounds(var ALeft, ATop, AWidth, AHeight: Integer);
    procedure CheckCollapseState;
    procedure CheckFocusedAccessibleObject;
    procedure CollapseStateChanged;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetClientOffsets: TRect; override;
    function GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean; override;
    function GetViewReal: Integer;
    procedure FocusChanged; override;
    function HasNonClientArea: Boolean; override;
    function IsDoubleBufferedNeeded: Boolean; override;
    procedure Loaded; override;
    procedure MouseEnter(AControl: TControl); override;
    procedure MouseLeave(AControl: TControl); overload; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure PaintNonClientArea(ACanvas: TcxCanvas); override;
    procedure ReadOriginalWidth(Reader: TReader);
    procedure RequestAlign; override;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure WriteOriginalWidth(Writer: TWriter);
    // IdxGestureClient
    function AllowPan(AScrollKind: TScrollBarKind): Boolean; override;
    procedure GestureScroll(ADeltaX, ADeltaY: Integer); override;
    //
    function CanFocusOnClick(X, Y: Integer): Boolean; override;
    procedure DoEnter; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint): Boolean; override;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DoStartDrag(var DragObject: TDragObject); override;

    procedure DoActiveGroupChanged; virtual;
    procedure DoActiveGroupChanging(ANewGroup: TdxNavBarGroup; var AAllowChange: Boolean); virtual;
    procedure DoCollapseStateChanged;
    procedure DoGroupDragDrop(Group: TdxNavBarGroup); virtual;
    procedure DoGroupDragOver(Group: TdxNavBarGroup; var Accept: Boolean); virtual;
    procedure DoGroupHotTrack(Group: TdxNavBarGroup); virtual;
    procedure DoGroupMouseDown(Group: TdxNavBarGroup); virtual;
    procedure DoGroupMouseUp(Group: TdxNavBarGroup); virtual;
    procedure DoLinkDragDrop(Link: TdxNavBarItemLink); virtual;
    procedure DoLinkDragOver(Link: TdxNavBarItemLink; var Accept: Boolean); virtual;
    procedure DoLinkHotTrack(Link: TdxNavBarItemLink); virtual;
    procedure DoLinkMouseDown(Link: TdxNavBarItemLink); virtual;
    procedure DoLinkMouseUp(Link: TdxNavBarItemLink); virtual;
    procedure DoNavigationPaneCollapsed;
    procedure DoNavigationPaneExpanded;
    procedure DoItemDragDrop(Item: TdxNavBarItem); virtual;
    procedure DoItemDragOver(Item: TdxNavBarItem; var Accept: Boolean); virtual;
    procedure DoBottomScrollButtonDown; virtual;
    procedure DoBottomScrollButtonUp; virtual;
    procedure DoTopScrollButtonDown; virtual;
    procedure DoTopScrollButtonUp; virtual;
//    procedure DoOverflowPanelMouseUp; virtual;
    procedure DoUpdateScrollBarStyle; virtual;
    procedure DoScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);

    // Painting
    procedure Paint; override;
    procedure InvalidateScrollButtons;
    // Load/Save layout
    procedure LoadFromRegIni(AStorage: TCustomIniFile; LoadStyles: Boolean); virtual;
    procedure SaveToRegIni(AStorage: TCustomIniFile; SaveStyles: Boolean); virtual;

    function CreatePainter: TdxNavBarPainter; virtual;
    function GetAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass; virtual;
    function GetCustomizationClass: TdxNavBarCustomizationClass; virtual;
    function GetGroupClass: TdxNavBarGroupClass; virtual;
    function GetItemClass: TdxNavBarItemClass; virtual;

    function IsCollapsed: Boolean;
    // popupcontrol
    function GetMasterNavBar: TdxCustomNavBar; virtual;
    function IsInternal: Boolean; virtual;

    property FocusedAccessibleObject: IdxNavBarAccessibilityHelper read
      FFocusedAccessibleObject write SetFocusedAccessibleObject;
    property UpdateLock: Integer read FUpdateLock;

    property OriginalWidth: Integer read FOriginalWidth write FOriginalWidth;
    property OnCollapseStateChanged: TNotifyEvent read FOnCollapseStateChanged write FOnCollapseStateChanged;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanFocus: Boolean; override;
    procedure DeSelectLinks;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;

    procedure InitiateAction; override;
    procedure Invalidate; override;
    procedure InvalidateAll(AType: TdxNavBarChangeType); overload;
    procedure InvalidateAll(AItem: TcxComponentCollectionItem;
      AAction: TcxComponentCollectionNotification); overload;
    // Layout store/restore
    procedure AssignDefaultStyles;
    procedure LoadFromIniFile(AFileName: string; LoadStyles: Boolean = True);
    procedure LoadFromRegistry(ARegistryPath: string; LoadStyles: Boolean = True);
    procedure LoadFromStream(AStream: TStream; LoadStyles: Boolean = True);
    procedure SaveToIniFile(AFileName: string; SaveStyles: Boolean = True);
    procedure SaveToRegistry(ARegistryPath: string; SaveStyles: Boolean = True);
    procedure SaveToStream(AStream: TStream; SaveStyles: Boolean = True);
    // ViewInfo
    function GetGroupAtCaptionPos(const pt: TPoint): TdxNavBarGroup;
    function GetGroupAtItemsPos(const pt: TPoint): TdxNavBarGroup;
    function GetLinkAtPos(const pt: TPoint): TdxNavBarItemLink; virtual;
    function GetLinkAtSelectedPos(const pt: TPoint): TdxNavBarItemLink;
    function IsPtGroupDesignRect(const pt: TPoint): Boolean;
    function IsPtItemDesignRect(const pt: TPoint): Boolean;
    function IsPtTopScrollButton(const pt: TPoint): Boolean;
    function IsPtBottomScrollButton(const pt: TPoint): Boolean;
    function IsTopScrollButtonVisible: Boolean;
    function IsBottomScrollButtonVisible: Boolean;
//    function IsPtNavigationPaneHeader(const pt: TPoint): Boolean;
//    function IsPtNavigationPaneSplitter(const pt: TPoint): Boolean;
//    function IsPtNavigationPaneOverflowPanel(const pt: TPoint): Boolean;
    // Groups and links visibility
    procedure MakeLinkVisible(ALink: TdxNavBarItemLink);
    procedure MakeGroupVisible(AGroup: TdxNavBarGroup);
    // Updates lock
    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure EndUpdate;
    // NavigationPane
    function CanDecNavigationPaneOverflowPanelItemCount: Boolean;
    function CanIncNavigationPaneOverflowPanelItemCount: Boolean;
    procedure DoDecNavigationPaneOverflowPanelItemCount;
    procedure DoIncNavigationPaneOverflowPanelItemCount;
    // Designer
    function DesignerIsSelected(AObject: TPersistent): Boolean;
    procedure DesignerModified;
    procedure DesignerSelect(AObject: TPersistent);
    // IcxDesignSelectionChanged
    procedure DesignSelectionChanged(ASelection: TList);
    // IdxLocalizerListener
    procedure TranslationChanged; override;

    property Controller: TdxNavBarController read GetController;
    property Customization: TdxNavBarCustomization read FCustomization;
    property Painter: TdxNavBarPainter read GetPainter;
    property ViewInfo: TdxNavBarViewInfo read GetViewInfo;

    property EnableDragging: Boolean read GetEnableDragging;
    property IAccessibilityHelper: IdxNavBarAccessibilityHelper
      read GetIAccessibilityHelper;
    property ScrollBar: TdxNavBarScrollBar read FScrollBar;
    property SourcePoint: TPoint read FSourcePoint;
    property SourceGroup: TdxNavBarGroup read GetSourceGroup;
    property SourceLink: TdxNavBarItemLink read GetSourceLink;
    property SourceItem: TdxNavBarItem read GetSourceItem;
    property TargetPoint: TPoint read FTargetPoint;
    property TargetGroup: TdxNavBarGroup read GetTargetGroup;
    property TargetLink1: TdxNavBarItemLink read GetTargetLink1;
    property TargetLink2: TdxNavBarItemLink read GetTargetLink2;
    property TargetLinkIndex: Integer read GetTargetLinkIndex;
    property HotTrackedGroup: TdxNavBarGroup read FHotTrackedGroup;
    property HotTrackedLink: TdxNavBarItemLink read FHotTrackedLink;
    property PressedGroup: TdxNavBarGroup read FPressedGroup;
    property PressedLink: TdxNavBarItemLink read FPressedLink;

    property NavigationPaneOverflowPanelItemCount: Integer read GetNavigationPaneOverflowPanelItemCount;
//    property NavigationPaneOverflowPanelHotTrackedIndex: Integer read FNavigationPaneOverflowPanelHotTrackedIndex;
//    property NavigationPaneOverflowPanelPressedIndex: Integer read FNavigationPaneOverflowPanelPressedIndex;
//    property NavigationPaneOverflowPanelSignPressed: Boolean read FNavigationPaneOverflowPanelSignPressed;
//    property NavigationPaneOverflowPanelSignHotTracked: Boolean read FNavigationPaneOverflowPanelSignHotTracked;

    property ScrollButtonDownIsDown: Boolean read FScrollButtonDownIsDown;
    property ScrollButtonUpIsDown: Boolean read FScrollButtonUpIsDown;
    property ScrollPosition: Integer read GetScrollPosition;

    property ActiveGroupIndex: Integer read GetActiveGroupIndex write SetActiveGroupIndex;
    property ActiveGroup: TdxNavBarGroup read GetActiveGroup write SetActiveGroup;
    property Groups: TdxNavBarGroups read FGroups;
    property Items: TdxNavBarItems read FItems;
    property VisibleGroupCount: Integer read GetVisibleGroupCount;

    // Cursors
    property Cursors: TdxNavBarCursors read FCursors write SetCursors;
    property DragCopyCursor: TCursor read GetDragCopyCursor write SetDragCopyCursor;
    property HotTrackedGroupCursor: TCursor read GetHotTrackedGroupCursor write SetHotTrackedGroupCursor;
    property HotTrackedLinkCursor: TCursor read GetHotTrackedLinkCursor write SetHotTrackedLinkCursor;

    // ViewStyle
    property LookAndFeelSchemes: TdxNavBarLookAndFeelSchemes read FLookAndFeelSchemes write SetLookAndFeelSchemes;
    property View: Integer read FView write SetView stored IsViewStored;
    property ViewReal: Integer read FViewReal write SetViewReal stored IsViewRealStored;
    property ViewStyle: TdxNavBarPainter read GetViewStyle write SetViewStyle;

    // OptionsImage
    property OptionsImage: TdxNavBarImageOptions read FOptionsImage write SetOptionsImage;
    property LargeImages: TCustomImageList read GetLargeImages write SetLargeImages;
    property SmallImages: TCustomImageList read GetSmallImages write SetSmallImages;

    // OptionsStyle
    property OptionsStyle: TdxNavBarStyleOptions read FOptionsStyle write SetOptionsStyle;
    property DefaultStyles: TdxNavBarDefaultStyles read GetDefaultStyles write SetDefaultStyles;
    property Styles: TdxNavBarStyleRepository read GetStyles;
    property StyleBackground: TdxNavBarStyleItem index 0 read GetNavBarCustomStyle write SetNavBarCustomStyle;
    property StyleHint: TdxNavBarStyleItem index 1 read GetNavBarCustomStyle write SetNavBarCustomStyle;
    property StyleDropTargetGroup: TdxNavBarStyleItem index 2 read GetNavBarCustomStyle write SetNavBarCustomStyle;
    property StyleDropTargetLink: TdxNavBarStyleItem index 3 read GetNavBarCustomStyle write SetNavBarCustomStyle;
    property StyleButton: TdxNavBarStyleItem index 4 read GetNavBarCustomStyle write SetNavBarCustomStyle;
    property StyleButtonHotTracked: TdxNavBarStyleItem index 5 read GetNavBarCustomStyle write SetNavBarCustomStyle;
    property StyleButtonPressed: TdxNavBarStyleItem index 6 read GetNavBarCustomStyle write SetNavBarCustomStyle;
    property StyleNavigationPaneHeader: TdxNavBarStyleItem index 7 read GetNavBarCustomStyle write SetNavBarCustomStyle;

    // Options
    property OptionsView: TdxNavBarViewOptions read FOptionsView write SetOptionsView;
    property OptionsBehavior: TdxNavBarBehaviorOptions read FOptionsBehavior write SetOptionsBehavior;
    // Common
    property DragDropFlags: TdxNavBarDragDropFlags read GetDragDropFlags write SetDragDropFlags;
    property ShowGroupsHint: Boolean read GetShowGroupsHint write SetShowGroupsHint;
    property ShowLinksHint: Boolean read GetShowLinksHint write SetShowLinksHint;
    property ShowGroupCaptions: Boolean read GetShowGroupCaptions write SetShowGroupCaptions;
    // ExplorerStyle
    property ShowSpecialGroup: Boolean read GetShowSpecialGroup write SetShowSpecialGroup;
    property SpaceBetweenGroups: Integer read GetSpaceBetweenGroups write SetSpaceBetweenGroups;
    // NavigationStyle
    property AllowSelectLinks: Boolean read GetAllowSelectLinks write SetAllowSelectLinks;
    property EachGroupHasSelectedLink: Boolean read GetEachGroupHasSelectedLink write SetEachGroupHasSelectedLink;
    // NavigationPane
    property NavigationPaneMaxVisibleGroups: Integer read GetNavigationPaneMaxVisibleGroups write SetNavigationPaneMaxVisibleGroups;
    property NavigationPaneOverflowPanelUseSmallImages: Boolean read GetNavigationPaneOverflowPanelUseSmallImages write SetNavigationPaneOverflowPanelUseSmallImages;
    property ShowNavigationPaneOverflowPanelHints: Boolean read GetShowNavigationPaneOverflowPanelHints write SetShowNavigationPaneOverflowPanelHints;

    property OnActiveGroupChanged: TNotifyEvent read FOnActiveGroupChanged write FOnActiveGroupChanged;
    property OnActiveGroupChanging: TdxNavBarGroupChangingEvent read FOnActiveGroupChanging write FOnActiveGroupChanging;
    property OnCalcGroupClientHeight: TdxNavBarCalcGroupClientHeightEvent read FOnCalcGroupClientHeight write FOnCalcGroupClientHeight;
    property OnCalcGroupHintRect: TdxNavBarCalcGroupHintRectEvent read FOnCalcGroupHintRect write FOnCalcGroupHintRect;
    property OnCalcLinkHintRect: TdxNavBarCalcLinkHintRectEvent read FOnCalcLinkHintRect write FOnCalcLinkHintRect;
    property OnCalcNavigationPaneOverflowPanelHintRect: TdxNavBarCalcGroupHintRectEvent read FOnCalcNavigationPaneOverflowPanelHintRect write FOnCalcNavigationPaneOverflowPanelHintRect;

    property OnCustomDraw: TdxNavBarCustomDrawEvents read FOnCustomDraw write SetOnCustomDraw;
    property OnCustomDrawBackground: TdxNavBarCustomDrawEvent read GetOnCustomDrawBackground write SetOnCustomDrawBackground;
    property OnCustomDrawGroupCaption: TdxNavBarCustomDrawGroupEvent read GetOnCustomDrawGroupCaption write SetOnCustomDrawGroupCaption;
    property OnCustomDrawGroupClientBackground: TdxNavBarCustomDrawGroupEvent read GetOnCustomDrawGroupClientBackground write SetOnCustomDrawGroupClientBackground;
    property OnCustomDrawGroupClientForeground: TdxNavBarCustomDrawGroupEvent read GetOnCustomDrawGroupClientForeground write SetOnCustomDrawGroupClientForeground;
    property OnCustomDrawGroupHint: TdxNavBarCustomDrawGroupHintEvent read GetOnCustomDrawGroupHint write SetOnCustomDrawGroupHint;
    property OnCustomDrawLink: TdxNavBarCustomDrawLinkEvent read GetOnCustomDrawLink write SetOnCustomDrawLink;
    property OnCustomDrawLinkHint: TdxNavBarCustomDrawLinkHintEvent read GetOnCustomDrawLinkHint write SetOnCustomDrawLinkHint;
    property OnCustomDrawBottomScrollButton: TdxNavBarCustomDrawEvent read GetOnCustomDrawBottomScrollButton write SetOnCustomDrawBottomScrollButton;
    property OnCustomDrawTopScrollButton: TdxNavBarCustomDrawEvent read GetOnCustomDrawTopScrollButton write SetOnCustomDrawTopScrollButton;
    property OnCustomDrawNavigationPaneHeader: TdxNavBarCustomDrawEvent read GetOnCustomDrawNavigationPaneHeader write SetOnCustomDrawNavigationPaneHeader;
    property OnCustomDrawNavigationPaneSplitter: TdxNavBarCustomDrawEvent read GetOnCustomDrawNavigationPaneSplitter write SetOnCustomDrawNavigationPaneSplitter;
    property OnCustomDrawNavigationPaneOverflowPanel: TdxNavBarCustomDrawEvent read GetOnCustomDrawNavigationPaneOverflowPanel write SetOnCustomDrawNavigationPaneOverflowPanel;
    property OnCustomDrawNavigationPaneOverflowPanelHint: TdxNavBarCustomDrawGroupHintEvent read GetOnCustomDrawNavigationPaneOverflowPanelHint write SetOnCustomDrawNavigationPaneOverflowPanelHint;

    property OnNavigationPaneCollapsed: TNotifyEvent read FOnNavigationPaneCollapsed write FOnNavigationPaneCollapsed;
    property OnNavigationPaneExpanded: TNotifyEvent read FOnNavigationPaneExpanded write FOnNavigationPaneExpanded;

    property OnGetGroupHint: TdxNavBarGetGroupHintEvent read FOnGetGroupHint write FOnGetGroupHint;
    property OnGetLinkHint: TdxNavBarGetLinkHintEvent read FOnGetLinkHint write FOnGetLinkHint;
    property OnGroupClick: TdxNavBarGroupEvent read FOnGroupClick write FOnGroupClick;
    property OnGroupHotTrack: TdxNavBarGroupEvent read FOnGroupHotTrack write FOnGroupHotTrack;
    property OnGroupPress: TdxNavBarGroupEvent read FOnGroupPress write FOnGroupPress;
    property OnLinkClick: TdxNavBarLinkEvent read FOnLinkClick write FOnLinkClick;
    property OnLinkHotTrack: TdxNavBarLinkEvent read FOnLinkHotTrack write FOnLinkHotTrack;
    property OnLinkPress: TdxNavBarLinkEvent read FOnLinkPress write FOnLinkPress;
  published
    property Align;
    property Anchors;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsNone;
    property Color;
    property Constraints;
    property Ctl3D;
    property Enabled;
    property Font;
    property PopupMenu;
    property Visible;

    property OnContextPopup;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TdxNavBarDragObject = class
  private
    FNavBar: TdxCustomNavBar;
    FSourceGroup: TdxNavBarGroup;
    FSourceLink: TdxNavBarItemLink;
    FSourceItem: TdxNavBarItem;
    FTargetGroup: TdxNavBarGroup;
    FTargetLink1: TdxNavBarItemLink;
    FTargetLink2: TdxNavBarItemLink;
    FTargetLinkIndex: Integer;
    function GetSourceItem: TdxNavBarItem;
  protected
    procedure UpdateTargets; virtual;
  public
    constructor Create(ANavBar: TdxCustomNavBar;
      var DragObject: TDragObject {deprecated}; ASourceGroup: TdxNavBarGroup;
      ASourceLink: TdxNavBarItemLink; ASourceItem: TdxNavBarItem);
    property NavBar: TdxCustomNavBar read FNavBar;
    property SourceGroup: TdxNavBarGroup read FSourceGroup;
    property SourceLink: TdxNavBarItemLink read FSourceLink;
    property SourceItem: TdxNavBarItem read GetSourceItem;
    property TargetGroup: TdxNavBarGroup read FTargetGroup;
    property TargetLink1: TdxNavBarItemLink read FTargetLink1;
    property TargetLink2: TdxNavBarItemLink read FTargetLink2;
    property TargetLinkIndex: Integer read FTargetLinkIndex;
  end;

  TdxNavBarScrollBar = class(TcxIUnknownObject, IcxScrollBarOwner)
  private
    FKind: TScrollBarKind;
    FLookAndFeel: TcxLookAndFeel;
    FParent: TWinControl;
    FScrollBar: TcxControlScrollBarHelper;
    FScrollInfo: TScrollInfo;

    FLargeChange: Integer;
    FSmallChange: Integer;

    FOnScroll: TScrollEvent;

    procedure CorrectPos(var APos: Integer; AMin, AMax, APageSize: Integer);
    function GetBounds: TRect;
    function GetHeight: Integer;
    function GetMax: Integer;
    function GetMin: Integer;
    function GetNavBarPainter: TdxNavBarPainter;
    function GetPageSize: Integer;
    function GetPosition: Integer;
    function GetVisible: Boolean;
    function GetWidth: Integer;
    procedure SetBounds(const AValue: TRect);
    procedure SetMax(const Value: Integer);
    procedure SetMin(const Value: Integer);
    procedure SetPageSize(const Value: Integer);
    procedure SetPosition(const Value: Integer);
    procedure SetVisible(const Value: Boolean);

    procedure DestroyInternalScrollBar;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues);
    procedure VisibleChanged;
  protected
    procedure CheckScrollBarClass;
    procedure Paint(ACanvas: TcxCanvas);
    procedure RecreatecxScrollBar;
    procedure ResetScrollInfo;
    procedure Scroll(Sender: TObject; AScrollCode: TScrollCode; var AScrollPos: Integer);
    procedure UpdateStyle;

    // IcxScrollBarOwner
    function GetControl: TWinControl;
    function GetLookAndFeel: TcxLookAndFeel;

    property LookAndFeel: TcxLookAndFeel read FLookAndFeel;
    property NavBarPainter: TdxNavBarPainter read GetNavBarPainter;
    property ScrollBar: TcxControlScrollBarHelper read FScrollBar;
  public
    constructor Create(AParent: TWinControl; AKind: TScrollBarKind);
    destructor Destroy; override;
    procedure SetScrollParams(AMin, AMax, APosition, APageSize: Integer; ARedraw: Boolean = True);

    property Bounds: TRect read GetBounds write SetBounds;
    property Height: Integer read GetHeight;
    property Max: Integer read GetMax write SetMax;
    property Min: Integer read GetMin write SetMin;
    property PageSize: Integer read GetPageSize write SetPageSize;
    property Position: Integer read GetPosition write SetPosition;
    property Visible: Boolean read GetVisible write SetVisible;
    property Width: Integer read GetWidth;
    property LargeChange: Integer read FLargeChange write FLargeChange;
    property SmallChange: Integer read FSmallChange write FSmallChange;
    property OnScroll: TScrollEvent read FOnScroll write FOnScroll;
  end;

  TdxNavBarHintWindow = class(TcxBaseHintWindow)
  protected
    FNavBar: TdxCustomNavBar;
    procedure Paint; override;
  public
    function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect; override;
  end;

  TdxNavBar = class(TdxCustomNavBar)
  private
    FCustomDrawEvents: TNotifyEvent;
  published
    property ActiveGroupIndex;
    property TabOrder;
    property TabStop default False;

    // Cursors
    property Cursors;
    property Cursor stored False;
    property DragCopyCursor stored False;
    property DragCursor stored False;
    property HotTrackedGroupCursor stored False;
    property HotTrackedLinkCursor stored False;

    // ViewStyle
    property LookAndFeel;
    property LookAndFeelSchemes;
    property View;
    property ViewReal;
    property ViewStyle;

    // Options
    property OptionsBehavior;
    property OptionsImage;
    property OptionsStyle;
    property OptionsView;
      // Common
    property DragDropFlags stored False;
    property ShowGroupsHint stored False;
    property ShowLinksHint stored False;
    property ShowGroupCaptions stored False;
      // ExplorerStyle
    property ShowSpecialGroup stored False;
    property SpaceBetweenGroups stored False;
      // NavigationStyle
    property AllowSelectLinks stored False;
    property EachGroupHasSelectedLink stored False;
      // NavigationPane
    property NavigationPaneMaxVisibleGroups stored False;
    property NavigationPaneOverflowPanelUseSmallImages stored False;
    property ShowNavigationPaneOverflowPanelHints stored False;
      // Image
    property LargeImages stored False;
    property SmallImages stored False;
      // Style
    property DefaultStyles stored False;
    property StyleBackground stored False;
    property StyleHint stored False;
    property StyleDropTargetGroup stored False;
    property StyleDropTargetLink stored False;
    property StyleButton stored False;
    property StyleButtonHotTracked stored False;
    property StyleButtonPressed stored False;
    property StyleNavigationPaneHeader stored False;

    property OnActiveGroupChanged;
    property OnActiveGroupChanging;
    property OnCalcGroupClientHeight;
    property OnCalcGroupHintRect;
    property OnCalcNavigationPaneOverflowPanelHintRect;
    property OnCalcLinkHintRect;

    // CustomDrawEvents
    property OnCustomDraw;
    property CustomDrawEvents: TNotifyEvent read FCustomDrawEvents write FCustomDrawEvents;
    property OnCustomDrawBackground stored False;
    property OnCustomDrawGroupCaption stored False;
    property OnCustomDrawGroupClientBackground stored False;
    property OnCustomDrawGroupClientForeground stored False;
    property OnCustomDrawGroupHint stored False;
    property OnCustomDrawLink stored False;
    property OnCustomDrawLinkHint stored False;
    property OnCustomDrawBottomScrollButton stored False;
    property OnCustomDrawTopScrollButton stored False;
    property OnCustomDrawNavigationPaneHeader stored False;
    property OnCustomDrawNavigationPaneSplitter stored False;
    property OnCustomDrawNavigationPaneOverflowPanel stored False;
    property OnCustomDrawNavigationPaneOverflowPanelHint stored False;

    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnGetGroupHint;
    property OnGetLinkHint;
    property OnGroupClick;
    property OnGroupHotTrack;
    property OnGroupPress;
    property OnLinkClick;
    property OnLinkHotTrack;
    property OnLinkPress;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnNavigationPaneCollapsed;
    property OnNavigationPaneExpanded;
    property OnStartDrag;
  end;

var
  dxNavBarDragObject: TdxNavBarDragObject;
  DrawIconsAsEnabled: Boolean;
  FOnRegisterNavBar, FOnUnRegisterNavBar: TcxNotifyProcedure;

function dxNavBarPart(AMajorPartIndex: Integer; AMinorPartIndex: Integer = nbNone): TdxNavBarPart;
function IsdxNavBarPartsEqual(const APart1, APart2: TdxNavBarPart): Boolean;

procedure dxNavBarRegisterCustomizationFormClass(AClass: TdxNavBarCustomCustomizationFormClass);
procedure dxNavBarUnregisterCustomizationFormClass(AClass: TdxNavBarCustomCustomizationFormClass);

implementation

{$R *.res}

uses
  Consts, Math, SysUtils, dxUxTheme, dxNavBarGraphics,
  dxNavBarViewsFact, dxNavBarAccessibility, dxNavBarCustomization,
// Views:
  dxNavBarBaseViews, dxNavBarXPViews,
  dxNavBarOfficeViews, dxNavBarOffice11Views, dxNavBarOffice12Views,
  dxNavBarVSToolBoxViews, dxNavBarExplorerViews, dxNavBarVistaViews;

type
  TdxNavBarItemAccess = class(TdxNavBarItem);

  { TdxNavBarCustomizeFormManager }

  TdxNavBarCustomizeFormManager = class
  private
    FList: TList;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    function GetDefaultCustomizationFormClass: TdxNavBarCustomCustomizationFormClass;
    procedure Register(AClass: TdxNavBarCustomCustomizationFormClass);
    procedure Unregister(AClass: TdxNavBarCustomCustomizationFormClass);
  end;

var
  FUnitIsFinalized: Boolean;
  FNavBarCustomizeFormManager: TdxNavBarCustomizeFormManager;

function dxNavBarCustomizeFormManager: TdxNavBarCustomizeFormManager;
begin
  if not FUnitIsFinalized and (FNavBarCustomizeFormManager = nil) then
    FNavBarCustomizeFormManager := TdxNavBarCustomizeFormManager.Create;
  Result := FNavBarCustomizeFormManager;
end;

function dxNavBarPart(AMajorPartIndex: Integer; AMinorPartIndex: Integer = nbNone): TdxNavBarPart;
begin
  Result.MajorPartIndex := AMajorPartIndex;
  Result.MinorPartIndex := AMinorPartIndex;
end;

function IsdxNavBarPartsEqual(const APart1, APart2: TdxNavBarPart): Boolean;
begin
  Result := (APart1.MajorPartIndex = APart2.MajorPartIndex) and (APart1.MinorPartIndex = APart2.MinorPartIndex);
end;

procedure dxNavBarRegisterCustomizationFormClass(AClass: TdxNavBarCustomCustomizationFormClass);
begin
  if dxNavBarCustomizeFormManager <> nil then
    dxNavBarCustomizeFormManager.Register(AClass);
end;

procedure dxNavBarUnregisterCustomizationFormClass(AClass: TdxNavBarCustomCustomizationFormClass);
begin
  if dxNavBarCustomizeFormManager <> nil then
    dxNavBarCustomizeFormManager.Unregister(AClass);
end;

{ TdxNavBarCustomizeFormManager }

constructor TdxNavBarCustomizeFormManager.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TdxNavBarCustomizeFormManager.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TdxNavBarCustomizeFormManager.GetDefaultCustomizationFormClass: TdxNavBarCustomCustomizationFormClass;
begin
  Result := TdxNavBarCustomCustomizationFormClass(FList.Last);
end;

procedure TdxNavBarCustomizeFormManager.Register(AClass: TdxNavBarCustomCustomizationFormClass);
begin
  FList.Add(AClass);
end;

procedure TdxNavBarCustomizeFormManager.Unregister(AClass: TdxNavBarCustomCustomizationFormClass);
begin
  FList.Remove(AClass);
end;

{ TdxNavBarCustomDrawEvents }

procedure TdxNavBarCustomDrawEvents.Assign(Source: TPersistent);
var
  ASourceEvents: TdxNavBarCustomDrawEvents;
begin
  if Source is TdxNavBarCustomDrawEvents then
  begin
    ASourceEvents := TdxNavBarCustomDrawEvents(Source);
    Background := ASourceEvents.Background;
    GroupCaption := ASourceEvents.GroupCaption;
    GroupClientBackground := ASourceEvents.GroupClientBackground;
    GroupClientForeground := ASourceEvents.GroupClientForeground;
    GroupHint := ASourceEvents.GroupHint;
    Link := ASourceEvents.Link;
    LinkHint := ASourceEvents.LinkHint;
    BottomScrollButton := ASourceEvents.BottomScrollButton;
    TopScrollButton := ASourceEvents.TopScrollButton;
    NavigationPaneHeader := ASourceEvents.NavigationPaneHeader;
    NavigationPaneSplitter := ASourceEvents.NavigationPaneSplitter;
    NavigationPaneOverflowPanel := ASourceEvents.NavigationPaneOverflowPanel;
    NavigationPaneOverflowPanelHint := ASourceEvents.NavigationPaneOverflowPanelHint;
  end
  else
    inherited;
end;

{ TdxNavBarCustomCustomizationForm }

destructor TdxNavBarCustomCustomizationForm.Destroy;
begin
  NavBar := nil;
  cxDialogsMetricsStore.StoreMetrics(Self);
  inherited;
end;

procedure TdxNavBarCustomCustomizationForm.BeginUpdate;
begin
  Inc(FLockCount);
end;

procedure TdxNavBarCustomCustomizationForm.CancelUpdate;
begin
  Dec(FLockCount);
end;

procedure TdxNavBarCustomCustomizationForm.EndUpdate;
begin
  Dec(FLockCount);
  RefreshItems;
end;

procedure TdxNavBarCustomCustomizationForm.CreateParams(var Params: TCreateParams);
const
  StyleMap: array[Boolean] of DWORD = (WS_POPUP, WS_CHILD);
begin
  inherited;
  with Params do
  begin
    Style := Style or StyleMap[Parent <> nil];
    if Parent <> nil then
      WndParent := Parent.Handle
    else
      if (NavBar <> nil) and not NavBar.IsDestroying then
        WndParent := NavBar.Handle
      else
        WndParent := 0;
  end;
end;

procedure TdxNavBarCustomCustomizationForm.DoClose(var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TdxNavBarCustomCustomizationForm.CreateControls;
begin
  DoCreateControls;
  Localize;
end;

procedure TdxNavBarCustomCustomizationForm.DoCreateControls;
begin
//do nothing
end;

procedure TdxNavBarCustomCustomizationForm.Init;
var
  I: Integer;
const
  UnusedItems: array[0..4, 0..1] of Integer =
    ((7, MF_BYPOSITION), (5, MF_BYPOSITION), (SC_MAXIMIZE, MF_BYCOMMAND),
    (SC_MINIMIZE, MF_BYCOMMAND), (SC_RESTORE, MF_BYCOMMAND));
  BorderStyleMap: array[Boolean] of TFormBorderStyle = (bsNone, bsSizeToolWin);
begin
  BorderStyle := BorderStyleMap[Parent = nil];
  BorderIcons := [biSystemMenu];
  Font.Assign(NavBar.Font);
  Color := clBtnFace;
  for I := 0 to High(UnusedItems) do
    DeleteMenu(GetSystemMenu(Handle, False), UnusedItems[I, 0], UnusedItems[I, 1]);
end;

procedure TdxNavBarCustomCustomizationForm.Localize;
begin
//do nothing
end;

procedure TdxNavBarCustomCustomizationForm.DoRefreshItems;
begin
end;

procedure TdxNavBarCustomCustomizationForm.RefreshItems;
begin
  if FLockCount = 0 then
    DoRefreshItems;
end;

procedure TdxNavBarCustomCustomizationForm.CreateLink(AItem: TdxNavBarItem; AGroup: TdxNavBarGroup; AIndex: Integer);
begin
  AGroup.CreateLink(AItem).Index := AIndex;
end;

procedure TdxNavBarCustomCustomizationForm.MoveLink(ALink: TdxNavBarItemLink; AGroup: TdxNavBarGroup; AIndex: Integer);
begin
  if ALink.Group = AGroup then
    ALink.Index := AIndex
  else
  begin
    CreateLink(ALink.Item, AGroup, AIndex);
    RemoveLink(ALink);
  end;
end;

procedure TdxNavBarCustomCustomizationForm.RemoveLink(ALink: TdxNavBarItemLink);
begin
  ALink.Group.RemoveLink(ALink.Index);
end;

function TdxNavBarCustomCustomizationForm.CanProcessDropItem(Target: TObject; X, Y: Integer): Boolean;
begin
  Result := False;
end;

procedure TdxNavBarCustomCustomizationForm.DoProcessDropItem(Target: TObject; X, Y: Integer);
begin
//do nothing
end;

procedure TdxNavBarCustomCustomizationForm.ProcessDropItem(Target: TObject; X, Y: Integer);
begin
  if CanProcessDropItem(Target, X, Y) then
    DoProcessDropItem(Target, X, Y);
end;

procedure TdxNavBarCustomCustomizationForm.SetNavBar(Value: TdxCustomNavBar);

  procedure RestoreMetrics;
  begin
    if EqualRect(NavBar.Customization.FormBounds, cxNullRect) then
      BoundsRect := NavBar.Customization.CalculateFormBounds
    else
      BoundsRect := NavBar.Customization.FormBounds;
    cxDialogsMetricsStore.DefaultPosition := poDesigned;
    cxDialogsMetricsStore.InitDialog(Self);
  end;

begin
  if FNavBar <> Value then
  begin
    FNavBar := Value;
    if NavBar <> nil then
    begin
      RestoreMetrics;
      Init;
    end;
    RecreateWnd;
  end;
end;

{ TdxNavBarCustomization }

destructor TdxNavBarCustomization.Destroy;
begin
  FreeAndNil(FForm);
  inherited;
end;

function TdxNavBarCustomization.CalculateFormBounds: TRect;
const
  AFormWidth = 100;
  AFormHeight = 150;
begin
  if Form <> nil then
    Result := Rect(0, 0, Form.Width, Form.Height)
  else
    Result := Rect(0, 0, AFormWidth, AFormHeight);
  with NavBar do
    Result := cxRectOffset(Result, cxPointOffset(ClientToScreen(ClientBounds.BottomRight), Result.BottomRight, False));
end;

procedure TdxNavBarCustomization.CreateForm;
begin
  FForm := GetFormClass.Create(nil);
  FForm.FreeNotification(NavBar);
  FForm.NavBar := NavBar;
  FForm.CreateControls;
  FForm.RefreshItems;
  FForm.Show;
end;

procedure TdxNavBarCustomization.EndDrag(Target: TObject; X, Y: Integer);
begin
  if Form <> nil then
    Form.ProcessDropItem(Target, X, Y);
end;

function TdxNavBarCustomization.GetFormClass: TdxNavBarCustomCustomizationFormClass;
begin
  Result := dxNavBarCustomizeFormManager.GetDefaultCustomizationFormClass;
end;

procedure TdxNavBarCustomization.RefreshItems;
begin
  if Form <> nil then
    Form.RefreshItems;
end;

function TdxNavBarCustomization.GetVisible: Boolean;
begin
  Result := FForm <> nil;
end;

procedure TdxNavBarCustomization.SetVisible(Value: Boolean);
begin
  if Visible <> Value then
  begin
    if Value then
      CreateForm
    else
      FreeAndNil(FForm);
  end;
end;

{ TdxNavBarCommonViewOptions }

constructor TdxNavBarCommonViewOptions.Create(ANavBar: TdxCustomNavBar);
begin
  inherited;
  FShowGroupCaptions := True;
end;

procedure TdxNavBarCommonViewOptions.Assign(Source: TPersistent);
var
  ASourceOptions: TdxNavBarCommonViewOptions;
begin
  if Source is TdxNavBarCommonViewOptions then
  begin
    ASourceOptions := TdxNavBarCommonViewOptions(Source);
    ShowGroupCaptions := ASourceOptions.ShowGroupCaptions;
  end
  else
    inherited;
end;

procedure TdxNavBarCommonViewOptions.SetShowGroupCaptions(AValue: Boolean);
begin
  if ShowGroupCaptions <> AValue then
  begin
    FShowGroupCaptions := AValue;
    NavBar.InvalidateAll(doRecreate);
  end;
end;

{ TdxNavBarPainter }

constructor TdxNavBarPainter.Create(ANavBar: TdxCustomNavBar);
begin
  inherited;
  FViewInfo := CreateViewInfo;
  FController := CreateController;
  FNeedRecreateViewInfo := True;
  FNeedRecalculateViewInfo := True;
end;

destructor TdxNavBarPainter.Destroy;
begin
  FreeAndNil(FController);
  FreeAndNil(FViewInfo);
  inherited;
end;

procedure TdxNavBarPainter.Assign(Source: TPersistent);
begin
  if not (Source is TdxNavBarPainter) then
    inherited;
end;

function TdxNavBarPainter.DC: HDC;
begin
  Result := Canvas.Handle;
end;

procedure TdxNavBarPainter.InvalidateViewInfo(AType: TdxNavBarChangeType);
begin
  if AType = doRecreate then
    FNeedRecreateViewInfo := True
  else
    if AType = doRecalc then
      FNeedRecalculateViewInfo := True;
end;

procedure TdxNavBarPainter.Paint;
begin
  if NavBar.UpdateLock = 0 then
    RedrawCanvas;
end;

procedure TdxNavBarPainter.InvalidateScrollButtons;
begin
  if ViewInfo.IsTopScrollButtonVisible then
  begin
    Windows.InvalidateRect(NavBar.Handle, @ViewInfo.TopScrollButtonRect, True);
    InvalidateViewInfo(doRedraw);
  end;
  if ViewInfo.IsBottomScrollButtonVisible then
  begin
    Windows.InvalidateRect(NavBar.Handle, @ViewInfo.BottomScrollButtonRect, True);
    InvalidateViewInfo(doRedraw);
  end;
end;

function TdxNavBarPainter.CreateViewInfo: TdxNavBarViewInfo;
begin
  Result := GetViewInfoClass.Create(Self);
end;

function TdxNavBarPainter.CreateGroupViewInfo(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup;
  ACaptionVisible, AItemsVisible: Boolean): TdxNavBarGroupViewInfo;
begin
  Result := GetGroupViewInfoClass.Create(AViewInfo, AGroup, ACaptionVisible, AItemsVisible);
end;

function TdxNavBarPainter.CreateLinkViewInfo(AViewInfo: TdxNavBarGroupViewInfo; ALink: TdxNavBarItemLink;
  ACaptionVisible, AImageVisisble: Boolean): TdxNavBarLinkViewInfo;
begin
  Result := GetLinkViewInfoClass.Create(AViewInfo, ALink, ACaptionVisible, AImageVisisble);
end;

class function TdxNavBarPainter.GetViewInfoClass: TdxNavBarViewInfoClass;
begin
  Result := TdxNavBarViewInfo;
end;

class function TdxNavBarPainter.GetGroupViewInfoClass: TdxNavBarGroupViewInfoClass;
begin
  Result := TdxNavBarGroupViewInfo;
end;

class function TdxNavBarPainter.GetLinkViewInfoClass: TdxNavBarLinkViewInfoClass;
begin
  Result := TdxNavBarLinkViewInfo;
end;

procedure TdxNavBarPainter.RecreateViewInfo;
begin
  if FNeedRecreateViewInfo then
  begin
    ViewInfo.CreateInfo;
    FNeedRecreateViewInfo := False;
    FNeedRecalculateViewInfo := True;
  end;
end;

procedure TdxNavBarPainter.RecalculateViewInfo;
begin
  if FNeedRecalculateViewInfo then
  begin
    ViewInfo.CalculateBounds;
    NavBar.CheckFocusedAccessibleObject;
    FNeedRecalculateViewInfo := False;
  end;
end;

procedure TdxNavBarPainter.RedrawCanvas;
begin
  DrawNavBarControl;
end;

function TdxNavBarPainter.CreateController: TdxNavBarController;
begin
  Result := GetControllerClass.Create(NavBar);
end;

function TdxNavBarPainter.GetControllerClass: TdxNavBarControllerClass;
begin
  Result := TdxNavBarController;
end;

function TdxNavBarPainter.CreatecxScrollBarHelper(AOwner: TdxNavBarScrollBar): TcxControlScrollBarHelper;
begin
  Result := GetcxScrollBarHelperClass.Create(AOwner);
end;

function TdxNavBarPainter.GetcxScrollBarHelperClass: TcxControlScrollBarHelperClass;
begin
  Result := TcxControlScrollBarHelper;
end;

function TdxNavBarPainter.NeedScrollBar: Boolean;
begin
  Result := False;
end;

procedure TdxNavBarPainter.UpdateScrollBarLookAndFeel(ALookAndFeel: TcxLookAndFeel);
begin
end;

function TdxNavBarPainter.GetCanvas: TCanvas;
begin
  Result := cxCanvas.Canvas;
end;

function TdxNavBarPainter.GetcxCanvas: TcxCanvas;
begin
  Result := NavBar.Canvas;
end;

function TdxNavBarPainter._AddRef: Integer;
begin
  Result := -1;
end;

function TdxNavBarPainter._Release: Integer;
begin
  Result := -1;
end;

function TdxNavBarPainter.QueryInterface(
  const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

class function TdxNavBarPainter.GetCategories: TdxNavBarViewCategories;
begin
  Result := [];
end;

function TdxNavBarPainter.GetMasterLookAndFeel: TcxLookAndFeel;
begin
  Result := nil;
end;

procedure TdxNavBarPainter.CheckDrawParamChanges;
begin
  if (NavBar.UpdateLock = 0) and NavBar.HandleAllocated then
  begin
    NavBar.BeginUpdate;
    CheckViewInfo;
    NavBar.CancelUpdate;
    NavBar.CheckCollapseState;
  end;
end;

procedure TdxNavBarPainter.CheckViewInfo;
begin
  RecreateViewInfo;
  RecalculateViewInfo;
end;

class function TdxNavBarPainter.Reregistered: Boolean;
begin
  Result := False;
end;

function TdxNavBarPainter.GetOwner: TPersistent;
begin
  Result := FNavBar;
end;

function TdxNavBarPainter.IsViewInfoValid: Boolean;
begin
  Result := not FNeedRecalculateViewInfo and not FNeedRecreateViewInfo;
end;

procedure TdxNavBarPainter.DoDrawHint(ACanvas: TCanvas; const ARect: TRect);
begin
// do nothing
end;

procedure TdxNavBarPainter.DrawSolidFocusRect(ARect: TRect;
  AColor: TColor);

  procedure DrawFocusLine(X, Y, ALength: Integer; AHorz: Boolean;
    ABrush: HBRUSH);
  var
    ADC: HDC;
    AFillPixel: Boolean;
    DX, DY, I: Integer;
    R: TRect;
  begin
    ADC := DC;
    AFillPixel := Odd(X + Y);

    R := Bounds(X, Y, 1, 1);
    DX := IfThen(AHorz, 1, 0);
    DY := IfThen(AHorz, 0, 1);

    for I := 1 to ALength do
    begin
      if AFillPixel then
        FillRect(ADC, R, ABrush);
      AFillPixel := not AFillPixel;
      OffsetRect(R, DX, DY);
    end;
  end;

var
  ABrush: HBRUSH;
begin
  if not IsRectEmpty(ARect) then
  begin
    ABrush := CreateSolidBrush(ColorToRGB(AColor));
    try
      InflateRect(ARect, -1, -1);
      DrawFocusLine(ARect.Left, ARect.Top, cxRectWidth(ARect), True, ABrush);
      DrawFocusLine(ARect.Left, ARect.Top, cxRectHeight(ARect), False, ABrush);
      DrawFocusLine(ARect.Right-1, ARect.Top, cxRectHeight(ARect), False, ABrush);
      DrawFocusLine(ARect.Left, ARect.Bottom-1, cxRectWidth(ARect), True, ABrush);
    finally
      DeleteObject(ABrush);
    end;
  end;
end;

procedure TdxNavBarPainter.DrawNavBarControl;
var
  I: Integer;
  AHandled: Boolean;
begin
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawBackground) then
    NavBar.OnCustomDrawBackground(NavBar, Canvas, ViewInfo, AHandled);
  if not AHandled then DrawBackground;
  for I := 0 to ViewInfo.GroupCount - 1 do
    if RectVisible(Canvas.Handle, ViewInfo.Groups[I].Rect) then
      DrawGroup(ViewInfo.Groups[I]);
  DrawScrollButtons;
  DrawDropTargetGroupSelection;
  DrawDropTargetLinkSelection;
end;

procedure TdxNavBarPainter.DrawBackground;
begin
// do nothing
end;

procedure TdxNavBarPainter.DrawDropTargetLinkSelection;
begin
// do nothing
end;

procedure TdxNavBarPainter.DrawHintWindow(AHintWindow: TdxNavBarHintWindow);
begin
  if NavBar.HotTrackedGroup <> nil then
    DrawGroupHintWindow(AHintWindow.Canvas, AHintWindow.ClientRect)
  else
    if NavBar.HotTrackedLink <> nil then
      DrawLinkHintWindow(AHintWindow.Canvas, AHintWindow.ClientRect)
    else
      DoDrawHint(AHintWindow.Canvas, AHintWindow.ClientRect);
end;

procedure TdxNavBarPainter.DrawGroupHintWindow(ACanvas: TCanvas; const ARect: TRect);
var
  AHandled: Boolean;
begin
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawGroupHint) then
    NavBar.OnCustomDrawGroupHint(NavBar, ACanvas, NavBar.HotTrackedGroup,
      ViewInfo.HintText, ARect, AHandled);
  if not AHandled then
    DoDrawHint(ACanvas, ARect);
end;

procedure TdxNavBarPainter.DrawLinkHintWindow(ACanvas: TCanvas; const ARect: TRect);
var
  AHandled: Boolean;
begin
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawLinkHint) then
    NavBar.OnCustomDrawLinkHint(NavBar, ACanvas, NavBar.HotTrackedLink,
      ViewInfo.HintText, ARect, AHandled);
  if not AHandled then
    DoDrawHint(ACanvas, ARect);
end;

procedure TdxNavBarPainter.DrawGroup(AGroupViewInfo: TdxNavBarGroupViewInfo);
var
  AHandled: Boolean;
begin
  DrawItemsRect(AGroupViewInfo);
  if AGroupViewInfo.IsCaptionVisible then
  begin
    AHandled := False;
    if Assigned(NavBar.OnCustomDrawGroupCaption) then
      NavBar.OnCustomDrawGroupCaption(NavBar, Canvas, AGroupViewInfo, AHandled);
    if not AHandled then
      DrawGroupCaption(AGroupViewInfo);
    DrawGroupFocusRect(AGroupViewInfo);
    DrawGroupDesignRect(AGroupViewInfo);
  end;
end;

procedure TdxNavBarPainter.DrawGroupBackground(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
// do nothing
end;

procedure TdxNavBarPainter.DrawGroupBorder(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
// do nothing
end;

procedure TdxNavBarPainter.DrawGroupCaption(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  DrawGroupCaptionButton(AGroupViewInfo);
  DrawGroupCaptionText(AGroupViewInfo);
  if AGroupViewInfo.IsCaptionImageVisible then
    DrawGroupCaptionImage(AGroupViewInfo);
  if AGroupViewInfo.IsCaptionSignVisible then
    DrawGroupCaptionSign(AGroupViewInfo);
end;

procedure TdxNavBarPainter.DrawGroupCaptionButton(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
// do nothing
end;

procedure TdxNavBarPainter.DrawGroupCaptionText(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  with AGroupViewInfo do
  begin
    Canvas.Font := CaptionFont;
    Canvas.Font.Color := CaptionFontColor;
    cxDrawText(Canvas, Group.Caption, CaptionTextRect, GetDrawEdgeFlag);
  end;
end;

procedure TdxNavBarPainter.DrawGroupCaptionImage(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
// do nothing
end;

procedure TdxNavBarPainter.DrawGroupCaptionSign(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
// do nothing
end;

procedure TdxNavBarPainter.DrawGroupControl(ACanvas: TCanvas; ARect: TRect; AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
// do nothing
end;

procedure TdxNavBarPainter.DrawGroupDesignRect(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  cxDrawDesignRect(cxCanvas, AGroupViewInfo.DesignRect, NavBar.DesignerIsSelected(AGroupViewInfo.Group));
end;

procedure TdxNavBarPainter.DrawGroupItems(AGroupViewInfo: TdxNavBarGroupViewInfo);
var
  I: Integer;
  ALinkViewInfo: TdxNavBarLinkViewInfo;
begin
  cxCanvas.SaveClipRegion;
  try
    cxCanvas.SetClipRegion(TcxRegion.Create(AGroupViewInfo.ItemsRect), roIntersect);
  for I := 0 to AGroupViewInfo.ItemCount - 1 do
  begin
    ALinkViewInfo := AGroupViewInfo.Items[I];
      if (ALinkViewInfo.Rect.Top >= AGroupViewInfo.ItemsRect.Top) and
        (ALinkViewInfo.Rect.Top <= AGroupViewInfo.ItemsRect.Bottom) then
      begin
        ALinkViewInfo.Item.Draw(Self, ALinkViewInfo);
      end;
    end;
  finally
    cxCanvas.RestoreClipRegion;
  end;
end;

procedure TdxNavBarPainter.DrawGroupFocusRect(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  with AGroupViewInfo do
    DrawSolidFocusRect(FocusRect, CaptionFontColor);
end;

procedure TdxNavBarPainter.DrawItem(ALinkViewInfo: TdxNavBarLinkViewInfo);
var
  AHandled: Boolean;
begin
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawLink) then
    NavBar.OnCustomDrawLink(NavBar, Canvas, ALinkViewInfo, AHandled);
  if not AHandled then
  begin
    DrawItemSelection(ALinkViewInfo);
    if (ALinkViewInfo.ImageList <> nil) and (0 <= ALinkViewInfo.ImageIndex) and
      (ALinkViewInfo.ImageIndex < ALinkViewInfo.ImageList.Count) then
    begin
      if ALinkViewInfo.IsImageVisible then
        DrawItemImage(ALinkViewInfo);
    end;
    DrawItemCaption(ALinkViewInfo);
  end;
  DrawItemFocusRect(ALinkViewInfo);
  DrawItemDesignRect(ALinkViewInfo);
end;

procedure TdxNavBarPainter.DrawItemCaption(ALinkViewInfo: TdxNavBarLinkViewInfo);
begin
  with ALinkViewInfo do
  begin
    Canvas.Font := Font;
    Canvas.Font.Color := FontColor;
    cxDrawText(Canvas, Item.Caption, CaptionRect, GetDrawEdgeFlag or DT_END_ELLIPSIS);
  end;
end;

procedure TdxNavBarPainter.DrawItemDesignRect(ALinkViewInfo: TdxNavBarLinkViewInfo);
begin
  cxDrawDesignRect(cxCanvas, ALinkViewInfo.DesignRect, NavBar.DesignerIsSelected(ALinkViewInfo.Item));
end;

procedure TdxNavBarPainter.DrawItemFocusRect(ALinkViewInfo: TdxNavBarLinkViewInfo);
begin
  with ALinkViewInfo do
    DrawSolidFocusRect(FocusRect, FontColor);
end;

procedure TdxNavBarPainter.DrawItemImage(ALinkViewInfo: TdxNavBarLinkViewInfo);
begin
// do nothing
end;

procedure TdxNavBarPainter.DrawItemSelection(ALinkViewInfo: TdxNavBarLinkViewInfo);
begin
// do nothing
end;

procedure TdxNavBarPainter.DrawItemsRect(AGroupViewInfo: TdxNavBarGroupViewInfo);
var
  AHandled: Boolean;
begin
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawGroupClientBackground) then
    NavBar.OnCustomDrawGroupClientBackground(NavBar, Canvas, AGroupViewInfo, AHandled);
  if not AHandled then
  begin
    DrawGroupBackground(AGroupViewInfo);
    if not cxRectIsNull(AGroupViewInfo.GetBorderOffsets) then
      DrawGroupBorder(AGroupViewInfo);
  end;
  if AGroupViewInfo.Control = nil then
  begin
    AHandled := False;
    if Assigned(NavBar.OnCustomDrawGroupClientForeground) then
      NavBar.OnCustomDrawGroupClientForeground(NavBar, Canvas, AGroupViewInfo, AHandled);
    if not AHandled then
      DrawGroupItems(AGroupViewInfo);
  end;
end;

procedure TdxNavBarPainter.DrawSeparator(ALinkViewInfo: TdxNavBarLinkViewInfo);
begin
  cxCanvas.FillRect(ALinkViewInfo.SeparatorRect, ALinkViewInfo.SeparatorColor);
end;

procedure TdxNavBarPainter.DrawScrollButtons;
var
  AHandled: Boolean;
begin
  if ViewInfo.IsTopScrollButtonVisible then
  begin
    AHandled := False;
    if Assigned(NavBar.OnCustomDrawTopScrollButton) then
      NavBar.OnCustomDrawTopScrollButton(NavBar, Canvas, ViewInfo, AHandled);
    if not AHandled then DrawTopScrollButton;
  end;
  if ViewInfo.IsBottomScrollButtonVisible then
  begin
    AHandled := False;  
    if Assigned(NavBar.OnCustomDrawBottomScrollButton) then
      NavBar.OnCustomDrawBottomScrollButton(NavBar, Canvas, ViewInfo, AHandled);
    if not AHandled then DrawBottomScrollButton;
  end;
end;

procedure TdxNavBarPainter.DrawBottomScrollButton;
begin
// do nothing
end;

procedure TdxNavBarPainter.DrawTopScrollButton;
begin
// do nothing
end;

procedure TdxNavBarPainter.DrawDropTargetGroupSelection;
begin
// do nothing
end;

{ TdxNavBarViewInfo }

constructor TdxNavBarViewInfo.Create(APainter: TdxNavBarPainter);
begin
  inherited Create;
  FPainter := APainter;
  FNavBar := FPainter.NavBar;
  FGroups := TObjectList.Create;
  FHeaderFont := TFont.Create;
  CreateColors;
end;

destructor TdxNavBarViewInfo.Destroy;
begin
  ReleaseColors;
  FHeaderFont.Free;
  ClearGroups;
  FGroups.Free;
  inherited Destroy;
end;

function TdxNavBarViewInfo.ActiveGroupViewInfo: TdxNavBarGroupViewInfo;
begin
  if (NavBar.ActiveGroup <> nil) then
    Result := GetGroupViewInfoByGroup(NavBar.ActiveGroup)
  else Result := nil;
end;

function TdxNavBarViewInfo.GetGroupViewInfoByGroup(AGroup: TdxNavBarGroup): TdxNavBarGroupViewInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to GroupCount - 1 do
    if Groups[I].Group = AGroup then
    begin
      Result := Groups[I];
      break;
    end;
end;

function TdxNavBarViewInfo.GetLinkViewInfoByLink(ALink: TdxNavBarItemLink): TdxNavBarLinkViewInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to GroupCount - 1 do
  begin
    Result := Groups[I].GetLinkViewInfoByLink(ALink);
    if Result <> nil then break;
  end;
end;

function TdxNavBarViewInfo.IndexOfGroupViewInfo(AViewInfo: TdxNavBarGroupViewInfo): Integer;
begin
  Result := FGroups.IndexOf(AViewInfo);
end;

function TdxNavBarViewInfo.GetGroupViewInfoAtPos(const pt: TPoint): TdxNavBarGroupViewInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to GroupCount - 1 do
    if PtInRect(Groups[I].Rect, pt) then
    begin
      Result := Groups[I];
      Break;
    end;
end;

function TdxNavBarViewInfo.GetGroupViewInfoAtCaptionPos(const pt: TPoint): TdxNavBarGroupViewInfo;
begin
  Result := GetGroupViewInfoAtPos(pt);
  if (Result <> nil) and not PtInRect(Result.CaptionRect, pt) then
    Result := nil;
end;

function GetValidGroup(AViewInfo: TdxNavBarGroupViewInfo): TdxNavBarGroup;
begin
  if (AViewInfo <> nil) and (AViewInfo.Group <> nil) and not AViewInfo.Group.IsDestroying then
    Result := AViewInfo.Group
  else
    Result := nil;
end;

function TdxNavBarViewInfo.GetGroupViewInfoAtItemsPos(const pt: TPoint): TdxNavBarGroupViewInfo;
begin
  Result := GetGroupViewInfoAtPos(pt);
  if (Result <> nil) and PtInRect(Result.CaptionRect, pt) then
    Result := nil;
end;

function TdxNavBarViewInfo.GetGroupAtCaptionPos(const pt: TPoint): TdxNavBarGroup;
begin
  Result := GetValidGroup(GetGroupViewInfoAtCaptionPos(pt));
end;

function TdxNavBarViewInfo.GetGroupAtItemsPos(const pt: TPoint): TdxNavBarGroup;
begin
  Result := GetValidGroup(GetGroupViewInfoAtItemsPos(pt));
end;

function TdxNavBarViewInfo.GetLinkViewInfoAtPos(const pt: TPoint): TdxNavBarLinkViewInfo;
var
  I: Integer;
  AGroupViewInfo: TdxNavBarGroupViewInfo;
begin
  Result := nil;
  AGroupViewInfo := GetGroupViewInfoAtItemsPos(pt);
  if AGroupViewInfo <> nil then
    for I := 0 to AGroupViewInfo.ItemCount - 1 do
      if PtInRect(AGroupViewInfo.Items[I].Rect, pt) then
      begin
        Result := AGroupViewInfo.Items[I];
        Break;
      end;
end;

function TdxNavBarViewInfo.GetLinkViewInfoAtSelectedPos(const pt: TPoint): TdxNavBarLinkViewInfo;
var
  ACaptionRect: TRect;
begin
  Result := nil;
  if not (IsPtBottomScrollButton(pt) or IsPtTopScrollButton(pt)) then
  begin
    Result := GetLinkViewInfoAtPos(pt);
    if (Result <> nil) and not Result.Link.CanSelect then
      Result := nil
    else
      if (Result <> nil) and not CanSelectLinkByRect then
      begin
        ACaptionRect := Result.CaptionRect;
        if Result.GroupViewInfo.IsLinksUseSmallImages then
          ACaptionRect.Left := Result.ImageRect.Right
        else
          ACaptionRect.Top := Result.ImageRect.Bottom;
        if not(PtInRect(Result.ImageRect, pt) or PtInRect(ACaptionRect, pt)) then
          Result := nil;
      end;
  end;
end;

function GetValidLink(AViewInfo: TdxNavBarLinkViewInfo): TdxNavBarItemLink;
begin
  if (AViewInfo <> nil) and (AViewInfo.Link <> nil) and
    (AViewInfo.Link.Group <> nil) and (AViewInfo.Link.Item <> nil) then
    Result := AViewInfo.Link
  else
    Result := nil;
end;

function TdxNavBarViewInfo.GetLinkAtPos(const pt: TPoint): TdxNavBarItemLink;
begin
  Result := GetValidLink(GetLinkViewInfoAtPos(pt));
end;

function TdxNavBarViewInfo.GetLinkAtSelectedPos(const pt: TPoint): TdxNavBarItemLink;
begin
  Result := GetValidLink(GetLinkViewInfoAtSelectedPos(pt));
end;

function TdxNavBarViewInfo.GetViewInfoAtDragPosition(const pt: TPoint; var ItemGroup: TdxNavBarGroupViewInfo;
    var Item1, Item2: TdxNavBarLinkViewInfo): Integer;
var
  Index: Integer;
  ALinkViewInfo: TdxNavBarLinkViewInfo;
begin
  ItemGroup := nil;
  Item1 := nil;
  Item2 := nil;
  ItemGroup := GetGroupViewInfoAtItemsPos(pt);
  if ItemGroup <> nil then
  begin
    if ItemGroup.IsViewAsIconView then
      Result := GetViewInfoAtDragPositionWhenIconView(pt, ItemGroup, Item1, Item2)
    else
    begin
      ALinkViewInfo := GetLinkViewInfoAtPos(pt);
      if ALinkViewInfo <> nil then
      begin
        Index := ItemGroup.IndexOfLinkViewInfo(ALinkViewInfo);
        if (ALinkViewInfo.Rect.Top + ALinkViewInfo.Rect.Bottom) div 2 > pt.y then
        begin
          if Index > 0 then
            Item1 := ItemGroup.Items[Index - 1];
          Item2 := ALinkViewInfo
        end
        else
        begin
          Item1 := ALinkViewInfo;
          if Index < ItemGroup.ItemCount - 1 then
            Item2 := ItemGroup.Items[Index + 1];
        end;
      end
      else
        if ItemGroup.ItemCount > 0 then
          if pt.Y < ItemGroup.Items[0].Rect.Top then
            Item2 := ItemGroup.Items[0]
          else
            Item1 := ItemGroup.Items[ItemGroup.ItemCount - 1];
      if (Item1 <> nil) and (Item2 <> nil) then
        Result := Item2.Link.Index
      else
        if Item1 <> nil then
        Result := ItemGroup.Group.LinkCount
        else
          Result := 0;
    end;
  end
  else
  begin
    ItemGroup := GetGroupViewInfoAtCaptionPos(pt);
    if ItemGroup <> nil then
    begin
      if ItemGroup.ItemCount > 0 then
        Item2 := ItemGroup.Items[0];
      Result := 0;
    end
    else Result := -1;
  end;
end;

function TdxNavBarViewInfo.GetViewInfoAtDragPositionWhenIconView(const pt: TPoint; var ItemGroup: TdxNavBarGroupViewInfo;
    var Item1, Item2: TdxNavBarLinkViewInfo): Integer;
var
  I, Index: Integer;
  ALinkViewInfo: TdxNavBarLinkViewInfo;
begin
  ItemGroup := nil;
  Item1 := nil;
  Item2 := nil;
  ItemGroup := GetGroupViewInfoAtItemsPos(pt);
  if ItemGroup <> nil then
  begin
    ALinkViewInfo := GetLinkViewInfoAtPos(pt);
    if ALinkViewInfo <> nil then
    begin
      Index := ItemGroup.IndexOfLinkViewInfo(ALinkViewInfo);
      if (ALinkViewInfo.Rect.Left + (ALinkViewInfo.Rect.Right - ALinkViewInfo.Rect.Left) div 2) > pt.x then
      begin
        if Index > 0 then
          Item1 := ItemGroup.Items[Index - 1];
        Item2 := ALinkViewInfo
      end
      else
      begin
        Item1 := ALinkViewInfo;
        if Index < ItemGroup.ItemCount - 1 then
          Item2 := ItemGroup.Items[Index + 1];
      end;
    end
    else
    begin
      if ItemGroup.ItemCount > 0 then
      begin
        if pt.Y < ItemGroup.Items[0].Rect.Top then
          Item2 := ItemGroup.Items[0]
        else if pt.Y > ItemGroup.Items[ItemGroup.ItemCount - 1].Rect.Top then
          Item1 := ItemGroup.Items[ItemGroup.ItemCount - 1]
        else for I := 0 to ItemGroup.ItemCount - 1 do
          if (pt.y > ItemGroup.Items[I].Rect.Top) and (pt.y < ItemGroup.Items[I].Rect.Bottom) then
          begin
            if pt.x > ItemGroup.Items[I].Rect.Right then
            begin
              Item1 := ItemGroup.Items[I];
              if I < ItemGroup.ItemCount - 1 then
                Item2 := ItemGroup.Items[I + 1];
            end
            else if pt.x < ItemGroup.Items[I].Rect.Right then
            begin
              Item2 := ItemGroup.Items[I];
              if I > 0 then
                Item1 := ItemGroup.Items[I - 1];
            end
          end;
      end;
    end;
    if (Item1 <> nil) and (Item2 <> nil) then
      Result := Item2.Link.Index
    else if Item1 <> nil then
      Result := ItemGroup.Group.LinkCount
    else Result := 0;
  end
  else Result := -1;
end;

function TdxNavBarViewInfo.GetLinksAtDragPosition(const pt: TPoint; var ItemGroup: TdxNavBarGroup;
    var Item1, Item2: TdxNavBarItemLink): Integer;
var
  AGroupViewInfo: TdxNavBarGroupViewInfo;
  ALinkViewInfo1, ALinkViewInfo2: TdxNavBarLinkViewInfo;
begin
  Result := GetViewInfoAtDragPosition(pt, AGroupViewInfo, ALinkViewInfo1, ALinkViewInfo2);
  if (AGroupViewInfo <> nil) and (AGroupViewInfo.Group <> nil) and
    not AGroupViewInfo.Group.IsDestroying then
    ItemGroup := AGroupViewInfo.Group
  else ItemGroup := nil;
  if (ALinkViewInfo1 <> nil) and (ALinkViewInfo1.Link <> nil) and
    (ALinkViewInfo1.Link.Group <> nil) and ((ALinkViewInfo1.Link.Item <> nil)) then
    Item1 := ALinkViewInfo1.Link
  else Item1 := nil;
  if (ALinkViewInfo2 <> nil) and (ALinkViewInfo2.Link <> nil) and
    (ALinkViewInfo2.Link.Group <> nil) and ((ALinkViewInfo2.Link.Item <> nil)) then
    Item2 := ALinkViewInfo2.Link
  else Item2 := nil;
end;

function TdxNavBarViewInfo.IsTopScrollButtonVisible: Boolean;
begin
  Result := not cxRectIsEmpty(FTopScrollButtonRect) and (ActiveGroupViewInfo <> nil) and
    ActiveGroupViewInfo.HasEnoughSpaceForScrollButtons;
end;

function TdxNavBarViewInfo.IsBottomScrollButtonVisible: Boolean;
begin
  Result := not cxRectIsEmpty(FBottomScrollButtonRect) and (ActiveGroupViewInfo <> nil) and
    ActiveGroupViewInfo.HasEnoughSpaceForScrollButtons;
end;

function TdxNavBarViewInfo.IsPtTopScrollButton(const pt: TPoint): Boolean;
begin
  Result := PtInRect(FTopScrollButtonRect, pt);
end;

function TdxNavBarViewInfo.IsPtBottomScrollButton(const pt: TPoint): Boolean;
begin
  Result := PtInRect(FBottomScrollButtonRect, pt);
end;

function TdxNavBarViewInfo.IsPtGroupDesignRect(const pt: TPoint): Boolean;
var
  AGroupViewInfo: TdxNavBarGroupViewInfo;
begin
  AGroupViewInfo := GetGroupViewInfoAtCaptionPos(pt);
  Result := (AGroupViewInfo <> nil) and PtInRect(AGroupViewInfo.DesignRect, pt);
end;

function TdxNavBarViewInfo.IsPtItemDesignRect(const pt: TPoint): Boolean;
var
  ALinkViewInfo: TdxNavBarLinkViewInfo;
begin
  ALinkViewInfo := GetLinkViewInfoAtPos(pt);
  Result := (ALinkViewInfo <> nil) and PtInRect(ALinkViewInfo.DesignRect, pt);
end;

function TdxNavBarViewInfo.BgImage: TPicture;
begin
  if (NavBar.StyleBackground <> nil) and (savImage in NavBar.StyleBackground.Style.AssignedValues) then
    Result := NavBar.StyleBackground.Style.Image
  else Result := NavBar.DefaultStyles.Background.Image;
end;

function TdxNavBarViewInfo.BgBackColor: TColor;
begin
  if (NavBar.StyleBackground <> nil) and (savBackColor in NavBar.StyleBackground.Style.AssignedValues) then
    Result := NavBar.StyleBackground.Style.BackColor
  else Result := NavBar.DefaultStyles.Background.BackColor;
end;

function TdxNavBarViewInfo.BgBackColor2: TColor;
begin
  if (NavBar.StyleBackground <> nil) and (savBackColor2 in NavBar.StyleBackground.Style.AssignedValues) then
    Result := NavBar.StyleBackground.Style.BackColor2
  else Result := NavBar.DefaultStyles.Background.BackColor2;
end;

function TdxNavBarViewInfo.BgAlphaBlend: Byte;
begin
  if (NavBar.StyleBackground <> nil) and (savAlphaBlending in NavBar.StyleBackground.Style.AssignedValues) then
    Result := NavBar.StyleBackground.Style.AlphaBlending
  else Result := NavBar.DefaultStyles.Background.AlphaBlending;
end;

function TdxNavBarViewInfo.BgAlphaBlend2: Byte;
begin
  if (NavBar.StyleBackground <> nil) and (savAlphaBlending2 in NavBar.StyleBackground.Style.AssignedValues) then
    Result := NavBar.StyleBackground.Style.AlphaBlending2
  else Result := NavBar.DefaultStyles.Background.AlphaBlending2;
end;

function TdxNavBarViewInfo.BgGradientMode: TdxBarStyleGradientMode;
begin
  if (NavBar.StyleBackground <> nil) and (savGradientMode in NavBar.StyleBackground.Style.AssignedValues) then
    Result := NavBar.StyleBackground.Style.GradientMode
  else Result := NavBar.DefaultStyles.Background.GradientMode;
end;

function TdxNavBarViewInfo.BorderColor: TColor;
begin
  Result := clNone;
end;

function TdxNavBarViewInfo.BottomScrollButtonStyleItem: TdxNavBarStyleItem;
begin
  if NavBar.ScrollButtonUpIsDown then
    Result := NavBar.StyleButtonPressed
  else if IsPtBottomScrollButton(NavBar.TargetPoint) then
    Result := NavBar.StyleButtonHotTracked
  else Result := NavBar.StyleButton;
end;

function TdxNavBarViewInfo.BottomScrollButtonStyle: TdxNavBarBaseStyle;
begin
  if NavBar.ScrollButtonUpIsDown then
    Result := NavBar.DefaultStyles.ButtonPressed
  else if IsPtBottomScrollButton(NavBar.TargetPoint) then
    Result := NavBar.DefaultStyles.ButtonHotTracked
  else Result := NavBar.DefaultStyles.Button;
end;

function TdxNavBarViewInfo.BottomScrollButtonImage: TPicture;
begin
  if (BottomScrollButtonStyleItem <> nil) and (savImage in BottomScrollButtonStyleItem.Style.AssignedValues) then
    Result := BottomScrollButtonStyleItem.Style.Image
  else Result := BottomScrollButtonStyle.Image;
end;

function TdxNavBarViewInfo.BottomScrollButtonBackColor: TColor;
begin
  if (BottomScrollButtonStyleItem <> nil) and (savBackColor in BottomScrollButtonStyleItem.Style.AssignedValues) then
    Result := BottomScrollButtonStyleItem.Style.BackColor
  else Result := BottomScrollButtonStyle.BackColor;
end;

function TdxNavBarViewInfo.BottomScrollButtonBackColor2: TColor;
begin
  if (BottomScrollButtonStyleItem <> nil) and (savBackColor2 in BottomScrollButtonStyleItem.Style.AssignedValues) then
    Result := BottomScrollButtonStyleItem.Style.BackColor2
  else Result := BottomScrollButtonStyle.BackColor2;
end;

function TdxNavBarViewInfo.BottomScrollButtonAlphaBlend: Byte;
begin
  if (BottomScrollButtonStyleItem <> nil) and (savAlphaBlending in BottomScrollButtonStyleItem.Style.AssignedValues) then
    Result := BottomScrollButtonStyleItem.Style.AlphaBlending
  else Result := BottomScrollButtonStyle.AlphaBlending;
end;

function TdxNavBarViewInfo.BottomScrollButtonAlphaBlend2: Byte;
begin
  if (BottomScrollButtonStyleItem <> nil) and (savAlphaBlending2 in BottomScrollButtonStyleItem.Style.AssignedValues) then
    Result := BottomScrollButtonStyleItem.Style.AlphaBlending2
  else Result := BottomScrollButtonStyle.AlphaBlending2;
end;

function TdxNavBarViewInfo.BottomScrollButtonGradientMode: TdxBarStyleGradientMode;
begin
  if (BottomScrollButtonStyleItem <> nil) and (savGradientMode in BottomScrollButtonStyleItem.Style.AssignedValues) then
    Result := BottomScrollButtonStyleItem.Style.GradientMode
  else Result := BottomScrollButtonStyle.GradientMode;
end;

function TdxNavBarViewInfo.TopScrollButtonStyleItem: TdxNavBarStyleItem;
begin
  if NavBar.ScrollButtonUpIsDown then
    Result := NavBar.StyleButtonPressed
  else if IsPtTopScrollButton(NavBar.TargetPoint) then
    Result := NavBar.StyleButtonHotTracked
  else Result := NavBar.StyleButton;
end;

function TdxNavBarViewInfo.TopScrollButtonStyle: TdxNavBarBaseStyle;
begin
  if NavBar.ScrollButtonUpIsDown then
    Result := NavBar.DefaultStyles.ButtonPressed
  else if IsPtTopScrollButton(NavBar.TargetPoint) then
    Result := NavBar.DefaultStyles.ButtonHotTracked
  else Result := NavBar.DefaultStyles.Button;
end;

function TdxNavBarViewInfo.TopScrollButtonImage: TPicture;
begin
  if (TopScrollButtonStyleItem <> nil) and (savImage in TopScrollButtonStyleItem.Style.AssignedValues) then
    Result := TopScrollButtonStyleItem.Style.Image
  else Result := TopScrollButtonStyle.Image;
end;

function TdxNavBarViewInfo.TopScrollButtonBackColor: TColor;
begin
  if (TopScrollButtonStyleItem <> nil) and (savBackColor in TopScrollButtonStyleItem.Style.AssignedValues) then
    Result := TopScrollButtonStyleItem.Style.BackColor
  else Result := TopScrollButtonStyle.BackColor;
end;

function TdxNavBarViewInfo.TopScrollButtonBackColor2: TColor;
begin
  if (TopScrollButtonStyleItem <> nil) and (savBackColor2 in TopScrollButtonStyleItem.Style.AssignedValues) then
    Result := TopScrollButtonStyleItem.Style.BackColor2
  else Result := TopScrollButtonStyle.BackColor2;
end;

function TdxNavBarViewInfo.TopScrollButtonAlphaBlend: Byte;
begin
  if (TopScrollButtonStyleItem <> nil) and (savAlphaBlending in TopScrollButtonStyleItem.Style.AssignedValues) then
    Result := TopScrollButtonStyleItem.Style.AlphaBlending
  else Result := TopScrollButtonStyle.AlphaBlending;
end;

function TdxNavBarViewInfo.TopScrollButtonAlphaBlend2: Byte;
begin
  if (TopScrollButtonStyleItem <> nil) and (savAlphaBlending2 in TopScrollButtonStyleItem.Style.AssignedValues) then
    Result := TopScrollButtonStyleItem.Style.AlphaBlending2
  else Result := TopScrollButtonStyle.AlphaBlending2;
end;

function TdxNavBarViewInfo.TopScrollButtonGradientMode: TdxBarStyleGradientMode;
begin
  if (TopScrollButtonStyleItem <> nil) and (savGradientMode in TopScrollButtonStyleItem.Style.AssignedValues) then
    Result := TopScrollButtonStyleItem.Style.GradientMode
  else Result := TopScrollButtonStyle.GradientMode;
end;

function TdxNavBarViewInfo.HintImage: TPicture;
begin
  if (NavBar.StyleHint <> nil) and (savImage in NavBar.StyleHint.Style.AssignedValues) then
    Result := NavBar.StyleHint.Style.Image
  else Result := NavBar.DefaultStyles.Hint.Image
end;

function TdxNavBarViewInfo.HintBackColor: TColor;
begin
  if (NavBar.StyleHint <> nil) and (savBackColor in NavBar.StyleHint.Style.AssignedValues) then
    Result := NavBar.StyleHint.Style.BackColor
  else Result := NavBar.DefaultStyles.Hint.BackColor;
end;

function TdxNavBarViewInfo.HintBackColor2: TColor;
begin
  if (NavBar.StyleHint <> nil) and (savBackColor2 in NavBar.StyleHint.Style.AssignedValues) then
    Result := NavBar.StyleHint.Style.BackColor2
  else Result := NavBar.DefaultStyles.Hint.BackColor2;
end;

function TdxNavBarViewInfo.HintAlphaBlend: Byte;
begin
  if (NavBar.StyleHint <> nil) and (savAlphaBlending in NavBar.StyleHint.Style.AssignedValues) then
    Result := NavBar.StyleHint.Style.AlphaBlending
  else Result := NavBar.DefaultStyles.Hint.AlphaBlending;
end;

function TdxNavBarViewInfo.HintAlphaBlend2: Byte;
begin
  if (NavBar.StyleHint <> nil) and (savAlphaBlending2 in NavBar.StyleHint.Style.AssignedValues) then
    Result := NavBar.StyleHint.Style.AlphaBlending2
  else Result := NavBar.DefaultStyles.Hint.AlphaBlending2;
end;

function TdxNavBarViewInfo.HintGradientMode: TdxBarStyleGradientMode;
begin
  if (NavBar.StyleHint <> nil) and (savGradientMode in NavBar.StyleHint.Style.AssignedValues) then
    Result := NavBar.StyleHint.Style.GradientMode
  else Result := NavBar.DefaultStyles.Hint.GradientMode;
end;

function TdxNavBarViewInfo.HintFont: TFont;
begin
  if (NavBar.StyleHint <> nil) and (savFont in NavBar.StyleHint.Style.AssignedValues) then
    Result := NavBar.StyleHint.Style.Font
  else Result := NavBar.DefaultStyles.Hint.Font;
end;

function TdxNavBarViewInfo.DragDropItemTargetBackColor: TColor;
begin
  if (NavBar.StyleDropTargetLink <> nil) and (savBackColor in NavBar.StyleDropTargetLink.Style.AssignedValues) then
    Result := NavBar.StyleDropTargetLink.Style.BackColor
  else Result := NavBar.DefaultStyles.DropTargetLink.BackColor;
end;

function TdxNavBarViewInfo.DragDropGroupTargetBackColor: TColor;
begin
  if (NavBar.StyleDropTargetGroup <> nil) and (savBackColor in NavBar.StyleDropTargetGroup.Style.AssignedValues) then
    Result := NavBar.StyleDropTargetGroup.Style.BackColor
  else Result := NavBar.DefaultStyles.DropTargetGroup.BackColor;
end;

function TdxNavBarViewInfo.DragDropGroupTargetBackColor2: TColor;
begin
  if (NavBar.StyleDropTargetGroup <> nil) and (savBackColor2 in NavBar.StyleDropTargetGroup.Style.AssignedValues) then
    Result := NavBar.StyleDropTargetGroup.Style.BackColor2
  else Result := NavBar.DefaultStyles.DropTargetGroup.BackColor2;
end;

function TdxNavBarViewInfo.DragDropGroupTargetAlphaBlend: Byte;
begin
  if (NavBar.StyleDropTargetGroup <> nil) and (savAlphaBlending in NavBar.StyleDropTargetGroup.Style.AssignedValues) then
    Result := NavBar.StyleDropTargetGroup.Style.AlphaBlending
  else Result := NavBar.DefaultStyles.DropTargetGroup.AlphaBlending;
end;

function TdxNavBarViewInfo.DragDropGroupTargetAlphaBlend2: Byte;
begin
  if (NavBar.StyleDropTargetGroup <> nil) and (savAlphaBlending2 in NavBar.StyleDropTargetGroup.Style.AssignedValues) then
    Result := NavBar.StyleDropTargetGroup.Style.AlphaBlending2
  else   Result := NavBar.DefaultStyles.DropTargetGroup.AlphaBlending2;
end;

function TdxNavBarViewInfo.DragDropGroupTargetGradient: TdxBarStyleGradientMode;
begin
  if (NavBar.StyleDropTargetGroup <> nil) and (savGradientMode in NavBar.StyleDropTargetGroup.Style.AssignedValues) then
    Result := NavBar.StyleDropTargetGroup.Style.GradientMode
  else Result := NavBar.DefaultStyles.DropTargetGroup.GradientMode;
end;

function TdxNavBarViewInfo.HeaderImage: TPicture;
begin
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savImage in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result := NavBar.StyleNavigationPaneHeader.Style.Image
  else Result := NavBar.DefaultStyles.NavigationPaneHeader.Image
end;

function TdxNavBarViewInfo.HeaderBackColor: TColor;
begin
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savBackColor in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result := NavBar.StyleNavigationPaneHeader.Style.BackColor
  else Result := NavBar.DefaultStyles.NavigationPaneHeader.BackColor;
end;

function TdxNavBarViewInfo.HeaderBackColor2: TColor;
begin
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savBackColor2 in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result := NavBar.StyleNavigationPaneHeader.Style.BackColor2
  else Result := NavBar.DefaultStyles.NavigationPaneHeader.BackColor2;
end;

function TdxNavBarViewInfo.HeaderAlphaBlend: Byte;
begin
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savAlphaBlending in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result := NavBar.StyleNavigationPaneHeader.Style.AlphaBlending
  else Result := NavBar.DefaultStyles.NavigationPaneHeader.AlphaBlending;
end;

function TdxNavBarViewInfo.HeaderAlphaBlend2: Byte;
begin
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savAlphaBlending2 in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result := NavBar.StyleNavigationPaneHeader.Style.AlphaBlending2
  else   Result := NavBar.DefaultStyles.NavigationPaneHeader.AlphaBlending2;
end;

function TdxNavBarViewInfo.HeaderGradientMode: TdxBarStyleGradientMode;
begin
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savGradientMode in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result := NavBar.StyleNavigationPaneHeader.Style.GradientMode
  else Result := NavBar.DefaultStyles.NavigationPaneHeader.GradientMode;
end;

function TdxNavBarViewInfo.HeaderFont: TFont;
begin
  Result := FHeaderFont;
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savFont in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result.Assign(NavBar.StyleNavigationPaneHeader.Style.Font)
  else
    Result.Assign(NavBar.DefaultStyles.NavigationPaneHeader.Font);
end;

function TdxNavBarViewInfo.HeaderFontColor: TColor;
begin
  Result := HeaderFont.Color;
end;

function TdxNavBarViewInfo.HeaderHAlignment: TdxBarStyleHAlignment;
begin
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savHAlignment in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result := NavBar.StyleNavigationPaneHeader.Style.HAlignment
  else Result := NavBar.DefaultStyles.NavigationPaneHeader.HAlignment;
end;

function TdxNavBarViewInfo.HeaderVAlignment: TdxBarStyleVAlignment;
begin
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savVAlignment in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result := NavBar.StyleNavigationPaneHeader.Style.VAlignment
  else Result := NavBar.DefaultStyles.NavigationPaneHeader.VAlignment;
end;

function TdxNavBarViewInfo.HeaderDrawEdgeFlag: Integer;
const
  dxHAlignment: array[TdxBarStyleHAlignment] of Integer = (DT_LEFT, DT_CENTER, DT_RIGHT);
  dxVAlignment: array[TdxBarStyleVAlignment] of Integer = (DT_TOP, DT_VCENTER, DT_BOTTOM);
begin
  Result := dxHAlignment[HeaderHAlignment] or dxVAlignment[HeaderVAlignment] or
    DT_SINGLELINE or DT_END_ELLIPSIS;
end;

function TdxNavBarViewInfo.OverflowPanelImage: TPicture;
begin
  Result := NavBar.DefaultStyles.GroupHeader.Image;
end;

function TdxNavBarViewInfo.OverflowPanelBackColor: TColor;
begin
  Result := NavBar.DefaultStyles.GroupHeader.BackColor;
end;

function TdxNavBarViewInfo.OverflowPanelBackColor2: TColor;
begin
  Result := NavBar.DefaultStyles.GroupHeader.BackColor2;
end;

function TdxNavBarViewInfo.OverflowPanelAlphaBlend: Byte;
begin
  Result := NavBar.DefaultStyles.GroupHeader.AlphaBlending;
end;

function TdxNavBarViewInfo.OverflowPanelAlphaBlend2: Byte;
begin
  Result := NavBar.DefaultStyles.GroupHeader.AlphaBlending2;
end;

function TdxNavBarViewInfo.OverflowPanelGradientMode: TdxBarStyleGradientMode;
begin
  Result := NavBar.DefaultStyles.GroupHeader.GradientMode;
end;

function TdxNavBarViewInfo.OverflowPanelFont: TFont;
begin
  Result := NavBar.DefaultStyles.GroupHeader.Font;
end;

function TdxNavBarViewInfo.OverflowPanelFontColor: TColor;
begin
  Result := NavBar.DefaultStyles.GroupHeader.Font.Color;
end;

function TdxNavBarViewInfo.SplitterBackColor: TColor;
begin
  Result := HeaderBackColor;
end;

function TdxNavBarViewInfo.SplitterBackColor2: TColor;
begin
  Result := HeaderBackColor2;
end;

function TdxNavBarViewInfo.SplitterAlphaBlend: Byte;
begin
  Result := HeaderAlphaBlend;
end;

function TdxNavBarViewInfo.SplitterAlphaBlend2: Byte;
begin
  Result := HeaderAlphaBlend2;
end;

function TdxNavBarViewInfo.SplitterGradientMode: TdxBarStyleGradientMode;
begin
  Result := HeaderGradientMode;
end;

procedure TdxNavBarViewInfo.AssignDefaultBackgroundStyle;
begin
  NavBar.DefaultStyles.Background.ResetValues;
  NavBar.DefaultStyles.Background.BackColor := clAppWorkSpace;
  NavBar.DefaultStyles.Background.BackColor2 := clAppWorkSpace;
end;

procedure TdxNavBarViewInfo.AssignDefaultButtonStyle;
begin
  NavBar.DefaultStyles.Button.ResetValues;
  NavBar.DefaultStyles.Button.BackColor := clBtnFace;
  NavBar.DefaultStyles.Button.BackColor2 := clBtnFace;
end;

procedure TdxNavBarViewInfo.AssignDefaultButtonPressedStyle;
begin
  NavBar.DefaultStyles.ButtonPressed.Assign(NavBar.DefaultStyles.Button);
end;

procedure TdxNavBarViewInfo.AssignDefaultButtonHotTrackedStyle;
begin
  NavBar.DefaultStyles.ButtonHotTracked.Assign(NavBar.DefaultStyles.Button);
end;

procedure TdxNavBarViewInfo.AssignDefaultGroupControlStyle;
begin
  NavBar.DefaultStyles.GroupControl.ResetValues;
  NavBar.DefaultStyles.GroupControl.BackColor := clNone;
  NavBar.DefaultStyles.GroupControl.BackColor2 := clNone;
end;

procedure TdxNavBarViewInfo.AssignDefaultGroupBackgroundStyle;
begin
  NavBar.DefaultStyles.GroupBackground.ResetValues;
  NavBar.DefaultStyles.GroupBackground.BackColor := clAppWorkSpace;
  NavBar.DefaultStyles.GroupBackground.BackColor2 := clAppWorkSpace;
end;

procedure TdxNavBarViewInfo.AssignDefaultGroupHeaderStyle;
begin
  NavBar.DefaultStyles.GroupHeader.ResetValues;
  NavBar.DefaultStyles.GroupHeader.BackColor := clBtnFace;
  NavBar.DefaultStyles.GroupHeader.BackColor2 := clBtnFace;
  NavBar.DefaultStyles.GroupHeader.Font.Color := clBtnText;
  NavBar.DefaultStyles.GroupHeader.HAlignment := haCenter;
end;

procedure TdxNavBarViewInfo.AssignDefaultGroupHeaderActiveStyle;
begin
  NavBar.DefaultStyles.GroupHeaderActive.Assign(NavBar.DefaultStyles.GroupHeader);
end;

procedure TdxNavBarViewInfo.AssignDefaultGroupHeaderActiveHotTrackedStyle;
begin
  NavBar.DefaultStyles.GroupHeaderActiveHotTracked.Assign(NavBar.DefaultStyles.GroupHeaderActive);
end;

procedure TdxNavBarViewInfo.AssignDefaultGroupHeaderActivePressedStyle;
begin
  NavBar.DefaultStyles.GroupHeaderActivePressed.Assign(NavBar.DefaultStyles.GroupHeaderActive);
end;

procedure TdxNavBarViewInfo.AssignDefaultGroupHeaderHotTrackedStyle;
begin
  NavBar.DefaultStyles.GroupHeaderHotTracked.Assign(NavBar.DefaultStyles.GroupHeader);
end;

procedure TdxNavBarViewInfo.AssignDefaultGroupHeaderPressedStyle;
begin
  NavBar.DefaultStyles.GroupHeaderPressed.Assign(NavBar.DefaultStyles.GroupHeader);
end;

procedure TdxNavBarViewInfo.AssignDefaultHintStyle;
begin
  NavBar.DefaultStyles.Hint.ResetValues;
  NavBar.DefaultStyles.Hint.BackColor := clInfoBk;
  NavBar.DefaultStyles.Hint.BackColor2 := clInfoBk;
  NavBar.DefaultStyles.Hint.Font.Color := clInfoText;
  NavBar.DefaultStyles.Hint.HAlignment := haCenter;
end;

procedure TdxNavBarViewInfo.AssignDefaultItemStyle;
begin
  NavBar.DefaultStyles.Item.ResetValues;
  NavBar.DefaultStyles.Item.Font.Color := clBtnHighlight;
  NavBar.DefaultStyles.Item.HAlignment := haCenter;
end;

procedure TdxNavBarViewInfo.AssignDefaultItemDisabledStyle;
begin
  NavBar.DefaultStyles.ItemDisabled.Assign(NavBar.DefaultStyles.Item);
  NavBar.DefaultStyles.ItemDisabled.Font.Color := clBtnText;
end;

procedure TdxNavBarViewInfo.AssignDefaultItemHotTrackedStyle;
begin
  NavBar.DefaultStyles.ItemHotTracked.Assign(NavBar.DefaultStyles.Item);
end;

procedure TdxNavBarViewInfo.AssignDefaultItemPressedStyle;
begin
  NavBar.DefaultStyles.ItemPressed.Assign(NavBar.DefaultStyles.Item);
end;

procedure TdxNavBarViewInfo.AssignDefaultDropTargetGroupStyle;
begin
  NavBar.DefaultStyles.DropTargetGroup.ResetValues;
  NavBar.DefaultStyles.DropTargetGroup.BackColor := clHighlight;
  NavBar.DefaultStyles.DropTargetGroup.BackColor2 := clHighlight;
  NavBar.DefaultStyles.DropTargetGroup.AlphaBlending := 60;
  NavBar.DefaultStyles.DropTargetGroup.AlphaBlending2 := 60;
end;

procedure TdxNavBarViewInfo.AssignDefaultDropTargetLinkStyle;
begin
  NavBar.DefaultStyles.DropTargetLink.ResetValues;
  NavBar.DefaultStyles.DropTargetLink.BackColor := clBlack;
end;

procedure TdxNavBarViewInfo.AssignDefaultNavigationPaneHeaderStyle;
begin
  NavBar.DefaultStyles.NavigationPaneHeader.ResetValues;
end;

function TdxNavBarViewInfo.GetLargeImageHeight: Integer;
begin
  if (NavBar.LargeImages <> nil) then
    Result := NavBar.LargeImages.Height
  else Result := dxNavBarDefaultLargeImageHeight;
end;

function TdxNavBarViewInfo.GetLargeImageWidth: Integer;
begin
  if (NavBar.LargeImages <> nil) then
    Result := NavBar.LargeImages.Width
  else Result := dxNavBarDefaultLargeImageWidth;
end;

function TdxNavBarViewInfo.GetSmallImageHeight: Integer;
begin
  if (NavBar.SmallImages <> nil) then
    Result := NavBar.SmallImages.Height
  else Result := dxNavBarDefaultSmallImageHeight;
end;

function TdxNavBarViewInfo.GetSmallImageWidth: Integer;
begin
  if (NavBar.SmallImages <> nil) then
    Result := NavBar.SmallImages.Width
  else Result := dxNavBarDefaultSmallImageWidth;
end;

procedure TdxNavBarViewInfo.CreateColors;
begin
end;

procedure TdxNavBarViewInfo.RefreshColors;
begin
end;

procedure TdxNavBarViewInfo.ReleaseColors;
begin
end;

function TdxNavBarViewInfo.ClientHeight: Integer;
begin
  Result := NavBar.ClientHeight;
end;

function TdxNavBarViewInfo.ClientWidth: Integer;
begin
  Result := NavBar.ClientWidth;
end;

function TdxNavBarViewInfo.GetSpaceBetweenGroups: Integer;
begin
  if NavBar.SpaceBetweenGroups > 0 then
    Result := NavBar.SpaceBetweenGroups
  else
    Result := GetGroupSeparatorWidth;
end;

function TdxNavBarViewInfo.GetGroupBorderOffsets: TRect;
begin
  Result := cxNullRect;
end;

function TdxNavBarViewInfo.GetGroupCaptionHeightAddon: Integer;
begin
  Result := 6;
end;

class function TdxNavBarViewInfo.GetGroupCaptionTextIndent: Integer;
begin
  Result := 4;
end;

class function TdxNavBarViewInfo.GetGroupCaptionImageIndent: Integer;
begin
  Result := 0;
end;

function TdxNavBarViewInfo.GetGroupCaptionImageOffsets: TRect;
begin
  Result := Rect(GetGroupCaptionImageIndent, 0, GetGroupCaptionImageIndent, 0);
end;

function TdxNavBarViewInfo.GetGroupSeparatorWidth: Integer;
begin
  Result := 0;
end;

function TdxNavBarViewInfo.GetGroupCaptionSignSize: TSize;
begin
  Result := cxSize(16, 16);
end;

function TdxNavBarViewInfo.GetGroupEdges: TPoint;
begin
  Result := cxNullPoint;
end;

class function TdxNavBarViewInfo.GetGroupCaptionSeparatorWidth: Integer;
begin
  Result := 8;
end;

class function TdxNavBarViewInfo.GetLinksLargeSeparatorWidth: Integer;
begin
  Result := 6;
end;

class function TdxNavBarViewInfo.GetLinksSmallSeparatorWidth: Integer;
begin
  Result := 6;
end;

class function TdxNavBarViewInfo.GetLinksIconViewSeparatorWidth: Integer;
begin
  Result := 4;
end;

function TdxNavBarViewInfo.GetLinksImageEdges: TRect;
begin
  Result := cxRect(4, 4, 4, 4);
end;

class function TdxNavBarViewInfo.GetDragArrowHeight: Integer;
begin
  Result := 8;
end;

class function TdxNavBarViewInfo.GetDragArrowWidth: Integer;
begin
  Result := 6;
end;

function TdxNavBarViewInfo.GetHeaderHeightAddon: Integer;
begin
  Result := 8;
end;

function TdxNavBarViewInfo.GetNavBarCollapsedWidth: Integer;
begin
  Result := 0;
end;

function TdxNavBarViewInfo.GetNavBarMinExpandedWidth: Integer;
begin
  Result := 0;
end;

class function TdxNavBarViewInfo.GetScrollButtonVerticalEdge: Integer;
begin
  Result := 6;
end;

class function TdxNavBarViewInfo.GetScrollButtonHorizontalEdge: Integer;
begin
  Result := 6;
end;

class function TdxNavBarViewInfo.GetScrollButtonVerticalSize: Integer;
begin
  Result := 16;
end;

class function TdxNavBarViewInfo.GetScrollButtonHorizontalSize: Integer;
begin
  Result := 16;
end;

function TdxNavBarViewInfo.CanCollapse: Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.CanHasActiveGroup: Boolean;
begin
  Result := True;
end;

function TdxNavBarViewInfo.CanHasSpecialGroup: Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.CanHasScrollButtonInGroupCaption: Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.CanHasImageInGroupCaption: Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.CanHasSignInGroupCaption: Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.CanHasGroupViewAsIconView: Boolean;
begin
  Result := True;
end;

function TdxNavBarViewInfo.CanHasGroupWithNoCaption: Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.CanHasVisibleItemsInGroup(AGroup: TdxNavBarGroup): Boolean;
begin
  Result := AGroup = NavBar.ActiveGroup;
end;

function TdxNavBarViewInfo.CanGroupCaptionBoundsByImage: Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.CanGroupsUseLargeImages: Boolean;
begin
  Result := True;
end;

function TdxNavBarViewInfo.CanLinksUseLargeImages: Boolean;
begin
  Result := True;
end;

function TdxNavBarViewInfo.CanSelectLinkByRect: Boolean;
begin
  Result := False;
end;

procedure TdxNavBarViewInfo.DoCreateGroupsInfo;
var
  I: Integer;
begin
  if NavBar.ShowGroupCaptions then
  begin
    for I := 0 to NavBar.Groups.Count - 1 do
      if NavBar.Groups[I].Visible then
        AddGroup(Self, NavBar.Groups[I], True, True);
  end
  else
    if NavBar.ActiveGroup <> nil then
      AddGroup(Self, NavBar.ActiveGroup, True, True);
end;

procedure TdxNavBarViewInfo.DoCalculateBounds(X, Y: Integer);
var
  I: Integer;
begin
  for I := 0 to GroupCount - 1 do
    Groups[I].CalculateBounds(X, Y);
end;

function TdxNavBarViewInfo.FindGroupWithAccel(AKey: Word): TdxNavBarGroup;
var
  AIndex: Integer;
  AGroup: TdxNavBarGroup;
begin
  Result := nil;
  for AIndex := 0 to GroupCount - 1 do
  begin
    AGroup := Groups[AIndex].Group;
    if IsAccel(AKey, AGroup.Caption) then
    begin
      Result := AGroup;
      Break;
    end
  end;
end;

function TdxNavBarViewInfo.FindLinkWithAccel(AKey: Word): TdxNavBarItemLink;
var
  AGroupIndex, ALinkIndex: Integer;
  AGroupViewInfo: TdxNavBarGroupViewInfo;
  ALinkViewInfo: TdxNavBarLinkViewInfo;
begin
  Result := nil;
  for AGroupIndex := 0 to GroupCount - 1 do
  begin
    AGroupViewInfo := Groups[AGroupIndex];
    for ALinkIndex := 0 to AGroupViewInfo.ItemCount - 1 do
    begin
      ALinkViewInfo := AGroupViewInfo.Items[ALinkIndex];
      if IsAccel(AKey, ALinkViewInfo.Item.Caption) then
      begin
        Result := ALinkViewInfo.Link;
        Break;
      end;
    end;
  end;
end;

procedure TdxNavBarViewInfo.DoGroupActiveToggle(AGroup: TdxNavBarGroup);
begin
  if IsGroupActive(AGroup) then
    DoGroupDeactivate(AGroup)
  else
    DoGroupActivate(AGroup);
end;

procedure TdxNavBarViewInfo.DoGroupActivate(AGroup: TdxNavBarGroup);
begin
end;

procedure TdxNavBarViewInfo.DoGroupDeactivate(AGroup: TdxNavBarGroup);
begin
end;

function TdxNavBarViewInfo.IsGroupActive(AGroup: TdxNavBarGroup): Boolean;
begin
  Result := False;
end;

procedure TdxNavBarViewInfo.MakeLinkVisible(ALink: TdxNavBarItemLink; ATop: Boolean = True);
begin
end;

procedure TdxNavBarViewInfo.MakeGroupVisible(AGroup: TdxNavBarGroup;
  AExpandGroup: Boolean = True; ATop: Boolean = True);
begin
end;

procedure TdxNavBarViewInfo.AdjustControlsBounds;
var
  I: Integer;
  AGroup: TdxNavBarGroup;
  AControl: TdxNavBarGroupControl;
  AViewInfo: TdxNavBarGroupViewInfo;
begin
  for I := 0 to NavBar.Groups.Count - 1 do
  begin
    AGroup := NavBar.Groups[I];
    AControl := AGroup.Control;
    if (AControl <> nil) and (AControl.Parent = NavBar) then
    begin
      AViewInfo := GetGroupViewInfoByGroup(AGroup);
      if AViewInfo <> nil then
        AViewInfo.AdjustControlBounds
      else
        AControl.AdjustControl(cxRectOffset(NavBar.BoundsRect,
          cxPointInvert(NavBar.BoundsRect.TopLeft)), False);
    end;
  end;
end;

procedure TdxNavBarViewInfo.CorrectBounds;
begin
// do nothing
end;

function TdxNavBarViewInfo.GetBoundsUpdateType: TdxNavBarChangeType;
begin
  Result := doRecalc;
end;

procedure TdxNavBarViewInfo.CreateInfo;
begin
  CreateGroupsInfo;
end;

procedure TdxNavBarViewInfo.CreateGroupsInfo;
begin
  ClearGroups;
  DoCreateGroupsInfo;
end;

procedure TdxNavBarViewInfo.CalculateBounds;
begin
  ClearRects;
  DoCalculateBounds(GetGroupEdges.X, GetGroupEdges.Y);
  CorrectBounds;
  AdjustControlsBounds;
end;

procedure TdxNavBarViewInfo.CalculateScrollButtonsBounds;
begin
  if ActiveGroupViewInfo = nil then exit;
  FTopScrollButtonRect := GetTopScrollButtonRect;
  FBottomScrollButtonRect := GetBottomScrollButtonRect;
end;

procedure TdxNavBarViewInfo.ClearRects;
begin
  SetRectEmpty(FTopScrollButtonRect);
  SetRectEmpty(FBottomScrollButtonRect);
  SetRectEmpty(FHintRect);
end;

function TdxNavBarViewInfo.GetTopScrollButtonRect: TRect;
begin
  SetRectEmpty(Result);
  if not (sDisabled in TopScrollButtonState) then
  begin
    Result := ActiveGroupViewInfo.ItemsRect;
    Result.Left := Result.Right - GetScrollButtonHorizontalSize;
    Result.Bottom := Result.Top + GetScrollButtonVerticalSize;
    OffSetRect(Result, - GetScrollButtonHorizontalEdge, GetScrollButtonVerticalEdge);
  end;
end;

function TdxNavBarViewInfo.GetBottomScrollButtonRect: TRect;
begin
  SetRectEmpty(Result);
  if not (sDisabled in BottomScrollButtonState) then
  begin
    Result := ActiveGroupViewInfo.ItemsRect;
    Result.Left := Result.Right - GetScrollButtonHorizontalSize;
    Result.Bottom := Result.Top + GetScrollButtonVerticalSize;
    OffSetRect(Result, - GetScrollButtonHorizontalEdge, - GetScrollButtonVerticalEdge);
    OffSetRect(Result, 0, ActiveGroupViewInfo.ItemsRect.Bottom -
      ActiveGroupViewInfo.ItemsRect.Top - GetScrollButtonVerticalSize);
  end;
end;

function TdxNavBarViewInfo.GetGroupCount: Integer;
begin
  Result := FGroups.Count;
end;

function TdxNavBarViewInfo.GetGroup(Index: Integer): TdxNavBarGroupViewInfo;
begin
  Result := TdxNavBarGroupViewInfo(FGroups.Items[Index]);
end;

procedure TdxNavBarViewInfo.AddGroup(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup; ACaptionVisible, AItemsVisible: Boolean);
begin
  FGroups.Add(Painter.CreateGroupViewInfo(AViewInfo, AGroup, ACaptionVisible, AItemsVisible));
end;

procedure TdxNavBarViewInfo.RemoveGroup(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  FGroups.Remove(AGroupViewInfo);
end;

procedure TdxNavBarViewInfo.ClearGroups;
begin
  FGroups.Clear;
end;

function TdxNavBarViewInfo.GetBottomScrollButtonState: TdxNavBarObjectStates;
begin
  Result := [];
  if not NavBar.IsDesigning then
  begin
    if NavBar.ScrollButtonDownIsDown then
      Result := Result + [sPressed];
    if IsPtBottomScrollButton(NavBar.TargetPoint) then
      Result := Result + [sHotTracked];
  end;
  if not ((ActiveGroupViewInfo <> nil) and (ActiveGroupViewInfo.ItemCount > 0) and
    (ActiveGroupViewInfo.Items[ActiveGroupViewInfo.ItemCount - 1].Rect.Bottom >
    ActiveGroupViewInfo.Rect.Bottom) and
    (ActiveGroupViewInfo.Group.TopVisibleLinkIndex < ActiveGroupViewInfo.ItemCount - 1)) then
    Result := Result + [sDisabled];
end;

function TdxNavBarViewInfo.GetTopScrollButtonState: TdxNavBarObjectStates;
begin
  Result := [];
  if not NavBar.IsDesigning then
  begin
    if NavBar.ScrollButtonUpIsDown then
      Result := Result + [sPressed];
    if IsPtTopScrollButton(NavBar.TargetPoint) then
      Result := Result + [sHotTracked];
  end;
  if not ((ActiveGroupViewInfo <> nil) and (ActiveGroupViewInfo.ItemCount > 0) and
    (ActiveGroupViewInfo.Items[0].Rect.Top <
    ActiveGroupViewInfo.ItemsRect.Top) and
    (ActiveGroupViewInfo.Group.TopVisibleLinkIndex > 0)) then
    Result := Result + [sDisabled];
end;

{ TdxNavBarImageOptions }

constructor TdxNavBarImageOptions.Create(AOwner: TPersistent);
begin
  inherited;
  FDisabledLargeChangeLink := TChangeLink.Create;
  FDisabledSmallChangeLink := TChangeLink.Create;
  FHotLargeChangeLink := TChangeLink.Create;
  FHotSmallChangeLink := TChangeLink.Create;
  FLargeChangeLink := TChangeLink.Create;
  FSmallChangeLink := TChangeLink.Create;
end;

destructor TdxNavBarImageOptions.Destroy;
begin
  FreeAndNil(FDisabledLargeChangeLink);
  FreeAndNil(FDisabledSmallChangeLink);
  FreeAndNil(FHotLargeChangeLink);
  FreeAndNil(FHotSmallChangeLink);
  FreeAndNil(FSmallChangeLink);
  FreeAndNil(FLargeChangeLink);
  inherited;
end;

procedure TdxNavBarImageOptions.Assign(Source: TPersistent);
var
  ASourceOptions: TdxNavBarImageOptions;
begin
  if Source is TdxNavBarImageOptions then
  begin
    ASourceOptions := TdxNavBarImageOptions(Source);
    SmallImages := ASourceOptions.SmallImages;
    LargeImages := ASourceOptions.LargeImages;
    HotSmallImages := ASourceOptions.HotSmallImages;
    HotLargeImages := ASourceOptions.HotLargeImages;
    DisabledSmallImages := ASourceOptions.DisabledSmallImages;
    DisabledLargeImages := ASourceOptions.DisabledLargeImages;
  end
  else
    inherited;
end;

procedure TdxNavBarImageOptions.FreeNotification(AComponent: TComponent);
begin
  if AComponent = DisabledSmallImages then
    DisabledSmallImages := nil;
  if AComponent = DisabledLargeImages then
    DisabledLargeImages := nil;
  if AComponent = HotSmallImages then
    HotSmallImages := nil;
  if AComponent = HotLargeImages then
    HotLargeImages := nil;
  if AComponent = SmallImages then
    SmallImages := nil;
  if AComponent = LargeImages then
    LargeImages := nil;
end;

procedure TdxNavBarImageOptions.SetImageList(var ANewValue, AOldValue: TCustomImageList; const AChangeLink: TChangeLink);
begin
  cxSetImageList(ANewValue, AOldValue, AChangeLink, FNotifyComponent);
end;

procedure TdxNavBarImageOptions.SetDisabledLargeImages(Value: TCustomImageList);
begin
  SetImageList(Value, FDisabledLargeImages, FDisabledLargeChangeLink);
end;

procedure TdxNavBarImageOptions.SetDisabledSmallImages(Value: TCustomImageList);
begin
  SetImageList(Value, FDisabledSmallImages, FDisabledSmallChangeLink);
end;

procedure TdxNavBarImageOptions.SetHotLargeImages(Value: TCustomImageList);
begin
  SetImageList(Value, FHotLargeImages, FHotLargeChangeLink);
end;

procedure TdxNavBarImageOptions.SetHotSmallImages(Value: TCustomImageList);
begin
  SetImageList(Value, FHotSmallImages, FHotSmallChangeLink);
end;

procedure TdxNavBarImageOptions.SetLargeImages(Value: TCustomImageList);
begin
  SetImageList(Value, FLargeImages, FLargeChangeLink);
end;

procedure TdxNavBarImageOptions.SetSmallImages(Value: TCustomImageList);
begin
  SetImageList(Value, FSmallImages, FSmallChangeLink);
end;

{ TdxNavBarHintWindow }

function TdxNavBarHintWindow.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect;
var
  AHintInfo: THintInfo;
begin
  AHintInfo := PHintInfo(AData)^;
  FNavBar := TdxCustomNavBar(AHintInfo.HintControl);
  Result := FNavBar.ViewInfo.HintRect;
end;

procedure TdxNavBarHintWindow.Paint;
begin
  if FNavBar <> nil then
    FNavBar.Painter.DrawHintWindow(Self)
  else
    inherited Paint;
end;

{ TdxNavBarGroupViewInfo }

constructor TdxNavBarGroupViewInfo.Create(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup;
  ACaptionVisible, AItemsVisible: Boolean);
begin
  inherited Create(AViewInfo);
  FGroup := AGroup;
  FCaptionVisible := ACaptionVisible;
  FItemsVisible := AItemsVisible;

  FItems := TList.Create;
  CreateInfo;
end;

destructor TdxNavBarGroupViewInfo.Destroy;
begin
  ClearItems;
  FItems.Free;
  inherited Destroy;
end;

function TdxNavBarGroupViewInfo.GetLinkViewInfoByLink(ALink: TdxNavBarItemLink): TdxNavBarLinkViewInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ItemCount - 1 do
    if Items[I].Link = ALink then
    begin
      Result := Items[I];
      break;
    end;
end;

function TdxNavBarGroupViewInfo.IndexOfLinkViewInfo(AViewInfo: TdxNavBarLinkViewInfo): Integer;
begin
  Result := FItems.IndexOf(AViewInfo);
end;

function TdxNavBarGroupViewInfo.BorderColor: TColor;
begin
  Result := CaptionBackColor2;
end;

function TdxNavBarGroupViewInfo.BgImage: TPicture;
begin
  if (Group.StyleBackground <> nil) and (savImage in Group.StyleBackground.Style.AssignedValues) then
    Result := Group.StyleBackground.Style.Image
  else Result := NavBar.DefaultStyles.GroupBackground.Image;
end;

function TdxNavBarGroupViewInfo.BgBackColor: TColor;
begin
  if (Group.StyleBackground <> nil) and (savBackColor in Group.StyleBackground.Style.AssignedValues) then
    Result := Group.StyleBackground.Style.BackColor
  else Result := NavBar.DefaultStyles.GroupBackground.BackColor;
end;

function TdxNavBarGroupViewInfo.BgBackColor2: TColor;
begin
  if (Group.StyleBackground <> nil) and (savBackColor2 in Group.StyleBackground.Style.AssignedValues) then
    Result := Group.StyleBackground.Style.BackColor2
  else Result := NavBar.DefaultStyles.GroupBackground.BackColor2;
end;

function TdxNavBarGroupViewInfo.BgAlphaBlend: Byte;
begin
  if (Group.StyleBackground <> nil) and (savAlphaBlending in Group.StyleBackground.Style.AssignedValues) then
    Result := Group.StyleBackground.Style.AlphaBlending
  else Result := NavBar.DefaultStyles.GroupBackground.AlphaBlending;
end;

function TdxNavBarGroupViewInfo.BgAlphaBlend2: Byte;
begin
  if (Group.StyleBackground <> nil) and (savAlphaBlending2 in Group.StyleBackground.Style.AssignedValues) then
    Result := Group.StyleBackground.Style.AlphaBlending2
  else
    Result := NavBar.DefaultStyles.GroupBackground.AlphaBlending2;
end;

function TdxNavBarGroupViewInfo.BgGradientMode: TdxBarStyleGradientMode;
begin
  if (Group.StyleBackground <> nil) and (savGradientMode in Group.StyleBackground.Style.AssignedValues) then
    Result := Group.StyleBackground.Style.GradientMode
  else
    Result := NavBar.DefaultStyles.GroupBackground.GradientMode;
end;

function TdxNavBarGroupViewInfo.CaptionStyleItem: TdxNavBarStyleItem;
begin
  if (sActive in State) or (sSpecial in State) then
  begin
    if sPressed in State then
      Result := Group.StyleHeaderActivePressed
    else
      if sHotTracked in State then
        Result := Group.StyleHeaderActiveHotTracked
      else
        Result := Group.StyleHeaderActive;
  end
  else
    if sPressed in State then
      Result := Group.StyleHeaderPressed
    else
      if sHotTracked in State then
        Result := Group.StyleHeaderHotTracked
      else
        Result := Group.StyleHeader;
end;

function TdxNavBarGroupViewInfo.CaptionStyle: TdxNavBarBaseStyle;
begin
  if (sActive in State) or (sSpecial in State) then
  begin
    if sPressed in State then
      Result := NavBar.DefaultStyles.GroupHeaderActivePressed
    else
      if sHotTracked in State then
        Result := NavBar.DefaultStyles.GroupHeaderActiveHotTracked
      else
        Result := NavBar.DefaultStyles.GroupHeaderActive;
  end
  else
    if sPressed in State then
      Result := NavBar.DefaultStyles.GroupHeaderPressed
    else
      if sHotTracked in State then
        Result := NavBar.DefaultStyles.GroupHeaderHotTracked
      else
        Result := NavBar.DefaultStyles.GroupHeader;
end;

function TdxNavBarGroupViewInfo.CaptionImage: TPicture;
begin
  if (CaptionStyleItem <> nil) and (savImage in CaptionStyleItem.Style.AssignedValues) then
    Result := CaptionStyleItem.Style.Image
  else
    Result := CaptionStyle.Image;
end;

function TdxNavBarGroupViewInfo.CaptionBorderColor: TColor;
begin
  Result := clNone;
end;

function TdxNavBarGroupViewInfo.CaptionBackColor: TColor;
begin
  if (CaptionStyleItem <> nil) and (savBackColor in CaptionStyleItem.Style.AssignedValues) then
    Result := CaptionStyleItem.Style.BackColor
  else Result := CaptionStyle.BackColor;
end;

function TdxNavBarGroupViewInfo.CaptionBackColor2: TColor;
begin
  if (CaptionStyleItem <> nil) and (savBackColor2 in CaptionStyleItem.Style.AssignedValues) then
    Result := CaptionStyleItem.Style.BackColor2
  else Result := CaptionStyle.BackColor2;
end;

function TdxNavBarGroupViewInfo.CaptionAlphaBlend: Byte;
begin
  if (CaptionStyleItem <> nil) and (savAlphaBlending in CaptionStyleItem.Style.AssignedValues) then
    Result := CaptionStyleItem.Style.AlphaBlending
  else Result := CaptionStyle.AlphaBlending;
end;

function TdxNavBarGroupViewInfo.CaptionAlphaBlend2: Byte;
begin
  if (CaptionStyleItem <> nil) and (savAlphaBlending2 in CaptionStyleItem.Style.AssignedValues) then
    Result := CaptionStyleItem.Style.AlphaBlending2
  else Result := CaptionStyle.AlphaBlending2;
end;

function TdxNavBarGroupViewInfo.CaptionGradientMode: TdxBarStyleGradientMode;
begin
  if (CaptionStyleItem <> nil) and (savGradientMode in CaptionStyleItem.Style.AssignedValues) then
    Result := CaptionStyleItem.Style.GradientMode
  else Result := CaptionStyle.GradientMode;
end;

function TdxNavBarGroupViewInfo.CaptionFont: TFont;
begin
  Result := FCaptionFont;
  if (CaptionStyleItem <> nil) and (savFont in CaptionStyleItem.Style.AssignedValues) then
    Result.Assign(CaptionStyleItem.Style.Font)
  else Result.Assign(CaptionStyle.Font);
end;

function TdxNavBarGroupViewInfo.CaptionFontColor: TColor;
begin
  Result := CaptionFont.Color;
end;

function TdxNavBarGroupViewInfo.CaptionSignColor: TColor;
begin
  Result := CaptionFontColor;
end;

function TdxNavBarGroupViewInfo.CaptionHAlignment: TdxBarStyleHAlignment;
begin
  if (CaptionStyleItem <> nil) and (savHAlignment in CaptionStyleItem.Style.AssignedValues) then
    Result := CaptionStyleItem.Style.HAlignment
  else Result := CaptionStyle.HAlignment;
end;

function TdxNavBarGroupViewInfo.CaptionVAlignment: TdxBarStyleVAlignment;
begin
  if (CaptionStyleItem <> nil) and (savVAlignment in CaptionStyleItem.Style.AssignedValues) then
    Result := CaptionStyleItem.Style.VAlignment
  else Result := CaptionStyle.VAlignment;
end;

function TdxNavBarGroupViewInfo.ControlImage: TPicture;
begin
  if (Group.StyleControl <> nil) and (savImage in Group.StyleControl.Style.AssignedValues) then
    Result := Group.StyleControl.Style.Image
  else Result := NavBar.DefaultStyles.GroupControl.Image;
end;

function TdxNavBarGroupViewInfo.ControlBackColor: TColor;
begin
  if IsDefaultControlStyle then
    Result := BgBackColor
  else Result := GetControlBackColor;
end;

function TdxNavBarGroupViewInfo.ControlBackColor2: TColor;
begin
  if IsDefaultControlStyle then
    Result := BgBackColor2
  else Result := GetControlBackColor2;
end;

function TdxNavBarGroupViewInfo.ControlAlphaBlend: Byte;
begin
  if IsDefaultControlStyle then
    Result := BgAlphaBlend
  else if (Group.StyleControl <> nil) and (savAlphaBlending in Group.StyleControl.Style.AssignedValues) then
    Result := Group.StyleControl.Style.AlphaBlending
  else Result := NavBar.DefaultStyles.GroupControl.AlphaBlending;
end;

function TdxNavBarGroupViewInfo.ControlAlphaBlend2: Byte;
begin
  if IsDefaultControlStyle then
    Result := BgAlphaBlend2
  else if (Group.StyleControl <> nil) and (savAlphaBlending2 in Group.StyleControl.Style.AssignedValues) then
    Result := Group.StyleControl.Style.AlphaBlending2
  else Result := NavBar.DefaultStyles.GroupControl.AlphaBlending2;
end;

function TdxNavBarGroupViewInfo.ControlGradientMode: TdxBarStyleGradientMode;
begin
  if IsDefaultControlStyle then
    Result := BgGradientMode
  else if (Group.StyleControl <> nil) and (savGradientMode in Group.StyleControl.Style.AssignedValues) then
    Result := Group.StyleControl.Style.GradientMode
  else Result := NavBar.DefaultStyles.GroupControl.GradientMode;
end;

function TdxNavBarGroupViewInfo.UseLargeImages: Boolean;
begin
  Result := not IsCaptionUseSmallImages;
end;

function TdxNavBarGroupViewInfo.GetState: TdxNavBarObjectStates;
begin
  Result := inherited GetState;
  if (Group = NavBar.PressedGroup) and (Group = NavBar.HotTrackedGroup) or Group.CaptionPanelIAccessibilityHelper.IsPressed then
    Include(Result, sPressed);
  if Group = NavBar.HotTrackedGroup then
    Include(Result, sHotTracked);
  if Group.Expanded then
    Include(Result, sExpanded);
  if (Group = NavBar.ActiveGroup) and ViewInfo.CanHasActiveGroup then
    Include(Result, sActive);
  if (Group = NavBar.ActiveGroup) and ViewInfo.CanHasSpecialGroup and NavBar.ShowSpecialGroup then
    Include(Result, sSpecial);
  if Group.CaptionPanelIAccessibilityHelper.IsFocused then
    Include(Result, sFocused);
end;

function TdxNavBarGroupViewInfo.HasEnoughSpaceForScrollButtons: Boolean;
begin
  Result := cxRectHeight(ItemsRect) >
    2*(ViewInfo.GetScrollButtonVerticalSize + ViewInfo.GetScrollButtonVerticalEdge);
end;

function TdxNavBarGroupViewInfo.GetCaptionHeight: Integer;
begin
  Result := ViewInfo.GetGroupCaptionHeightAddon;
  Inc(Result, cxTextHeight(CaptionFont));
  dxAdjustToTouchableSize(Result);
end;

function TdxNavBarGroupViewInfo.GetDrawEdgeFlag: Integer;
const
  dxHAlignment: array[TdxBarStyleHAlignment] of Integer = (DT_LEFT, DT_CENTER, DT_RIGHT);
  dxVAlignment: array[TdxBarStyleVAlignment] of Integer = (DT_TOP, DT_VCENTER, DT_BOTTOM);
begin
  Result := dxHAlignment[CaptionHAlignment] or dxVAlignment[CaptionVAlignment] or
    DT_SINGLELINE or DT_END_ELLIPSIS;
end;

function TdxNavBarGroupViewInfo.GetImageHeight: Integer;
begin
  if IsCaptionUseSmallImages then
    Result := ViewInfo.GetSmallImageHeight
  else Result := ViewInfo.GetLargeImageHeight;
end;

function TdxNavBarGroupViewInfo.GetImageWidth: Integer;
begin
  if IsCaptionUseSmallImages then
    Result := ViewInfo.GetSmallImageWidth
  else Result := ViewInfo.GetLargeImageWidth;
end;

function TdxNavBarGroupViewInfo.IsCaptionVisible: Boolean;
begin
  Result := FCaptionVisible and NavBar.ShowGroupCaptions and
    (Group.ShowCaption or not ViewInfo.CanHasGroupWithNoCaption);
end;

function TdxNavBarGroupViewInfo.IsCaptionImageVisible: Boolean;
begin
  Result := ViewInfo.CanHasImageInGroupCaption and
    (CaptionImageRect.Left >= CaptionRect.Left) and
    (CaptionImageRect.Right <= CaptionRect.Right) and
    (not ViewInfo.CanHasSignInGroupCaption or
    (CaptionImageRect.Right < CaptionSignRect.Left));
end;

function TdxNavBarGroupViewInfo.IsCaptionSignVisible: Boolean;
begin
  Result := ViewInfo.CanHasSignInGroupCaption and
    (FCaptionSignRect.Left >= FCaptionRect.Left) and
    (FCaptionSignRect.Right <= FCaptionRect.Right);
end;

function TdxNavBarGroupViewInfo.IsCaptionUseSmallImages: Boolean;
begin
  Result := not ViewInfo.CanGroupsUseLargeImages or Group.UseSmallImages;
end;

function TdxNavBarGroupViewInfo.IsItemsVisible: Boolean;
begin
  Result := FItemsVisible and ViewInfo.CanHasVisibleItemsInGroup(Group);
end;

function TdxNavBarGroupViewInfo.IsLinksUseSmallImages: Boolean;
begin
  Result := not ViewInfo.CanLinksUseLargeImages or Group.LinksUseSmallImages;
end;

function TdxNavBarGroupViewInfo.IsViewAsIconView: Boolean;
begin
  Result := ViewInfo.CanHasGroupViewAsIconView and Group.ShowAsIconView;
end;

procedure TdxNavBarGroupViewInfo.AdjustControlBounds;
begin
  if IsItemsVisible and Group.ShowControl then
    Group.Control.AdjustControl(ControlRect, True)
  else
    Group.Control.AdjustControl(Group.Control.BoundsRect, False);
end;

function TdxNavBarGroupViewInfo.GetNavBarItem: TdxNavBarCustomItem;
begin
  Result := Group;
end;

procedure TdxNavBarGroupViewInfo.CreateInfo;
begin
  CreateItemsInfo;
end;

procedure TdxNavBarGroupViewInfo.CreateItemsInfo;
begin
  ClearItems;
  if Group <> nil then
    DoCreateItemsInfo;
end;

procedure TdxNavBarGroupViewInfo.CalculateBounds(var X, Y: Integer);

  function HasScrollButtonInGroupCaption: Boolean;
  var
    AActiveIndex, AIndex: Integer;
  begin
    AIndex := ViewInfo.IndexOfGroupViewInfo(Self);
    AActiveIndex := ViewInfo.IndexOfGroupViewInfo(ViewInfo.ActiveGroupViewInfo);
    Result := ViewInfo.CanHasScrollButtonInGroupCaption and
      ((AIndex = AActiveIndex) or (AIndex = AActiveIndex + 1));
  end;

  procedure CalcImageRect;
  var
    ADelta, AHeightAddon: Integer;
  begin
    if ViewInfo.CanHasImageInGroupCaption then
    begin
      FImageRect.Left := FCaptionRect.Left + GetImageIndent;
      FImageRect.Bottom := FCaptionRect.Bottom;
      FImageRect.Right := FImageRect.Left + GetImageWidth;
      FImageRect.Top := FImageRect.Bottom - GetImageHeight;
      if ViewInfo.CanGroupCaptionBoundsByImage then
        AHeightAddon := ViewInfo.GetGroupCaptionHeightAddon
      else
        AHeightAddon := 0;
      if FImageRect.Top - 2 * AHeightAddon < FCaptionRect.Top then
      begin
        ADelta := FCaptionRect.Top + 2 * AHeightAddon - FImageRect.Top;
        Inc(FCaptionRect.Bottom, ADelta);
        Inc(FCaptionTextRect.Bottom, ADelta);
        if not ViewInfo.CanGroupCaptionBoundsByImage then
        begin
          Inc(FCaptionRect.Top, ADelta);
          Inc(FCaptionTextRect.Top, ADelta);
        end;
        OffsetRect(FImageRect, 0, ADelta - AHeightAddon);
      end
      else
      begin
        ADelta := cxRectHeight(FCaptionRect) div 2 - GetImageWidth div 2;
        OffsetRect(FImageRect, 0, -ADelta);
      end;
      FCaptionTextRect.Left := FImageRect.Right + ViewInfo.GetGroupCaptionTextIndent;
    end
    else
      FImageRect := cxNullRect;
  end;

  procedure CalcSignRect;
  var
    ASignZone: TRect;
  begin
    if ViewInfo.CanHasSignInGroupCaption then
    begin
      ASignZone := FCaptionRect;
      ASignZone.Left := FCaptionRect.Right - cxRectHeight(FCaptionRect);
      FCaptionSignRect := cxRectCenter(ASignZone, ViewInfo.GetGroupCaptionSignSize);
      FCaptionTextRect.Right := ASignZone.Left;
    end
    else
      FCaptionSignRect := cxNullRect;
  end;

  procedure CalcCaptionRect;
  begin
    FCaptionRect.Left := X;
    FCaptionRect.Top := Y;
    FCaptionRect.Right := ViewInfo.ClientWidth - X;
    if HasScrollButtonInGroupCaption then
      FCaptionRect.Right := FCaptionRect.Right - GetCaptionHeight - 2;

    if IsCaptionVisible then
    begin
      FCaptionRect.Bottom := Y + GetCaptionHeight;
      FCaptionTextRect := FCaptionRect;
      InflateRect(FCaptionTextRect, -2, -1);
      CalcImageRect;
      CalcSignRect;
    end
    else
      FCaptionRect.Bottom := FCaptionRect.Top;
  end;

  procedure CalcClientRect;
  var
    I: Integer;
    AItemStartX, AItemStartY, AItemsRectBottom, AClientHeight: Integer;
  begin
    FRect.TopLeft := FCaptionRect.TopLeft;
    FRect.Right := ViewInfo.ClientWidth - X;
    if IsItemsVisible then
    begin
      if Control <> nil then
        FRect.Bottom := FCaptionRect.Bottom + Max(Control.OriginalHeight, Control.GetMinHeight) +
          GetBorderOffsets.Top + GetBorderOffsets.Bottom
      else
      begin
        AItemsRectBottom := FCaptionRect.Bottom + ViewInfo.GetGroupCaptionSeparatorWidth;
        AItemStartX := X;
        AItemStartY := AItemsRectBottom;
        for I := 0 to ItemCount - 1 do
        begin
          Items[I].CalculateBounds(AItemStartX, AItemStartY);
          if IsViewAsIconView then
          begin
            if (Items[I].Rect.Right > FCaptionRect.Right) and (I > 0) then
            begin
              AItemStartX := X;
              AItemStartY := Items[I - 1].Rect.Bottom;
              Items[I].CalculateBounds(AItemStartX, AItemStartY);
            end;
            AItemStartX := Items[I].Rect.Right;
          end
          else
            AItemStartY := Items[I].Rect.Bottom;
          AItemsRectBottom := Items[I].Rect.Bottom;
        end;
        FRect.Bottom := AItemsRectBottom + ViewInfo.GetGroupCaptionSeparatorWidth;
      end;
    end
    else
      FRect.Bottom := FCaptionRect.Bottom;
    if Group.Expanded and Assigned(NavBar.OnCalcGroupClientHeight) then
    begin
      AClientHeight := cxRectHeight(FRect) - cxRectHeight(FCaptionRect);
      NavBar.OnCalcGroupClientHeight(NavBar, Self, AClientHeight);
      FRect.Bottom := FRect.Top + AClientHeight + cxRectHeight(FCaptionRect);
    end;
  end;

  procedure CalcItemsRect;
  begin
    FItemsRect.Left := FCaptionRect.Left;
    FItemsRect.Top := FCaptionRect.Bottom;
    FItemsRect.BottomRight := FRect.BottomRight;
  end;

  procedure CalcFocusRect;
  begin
    if IsFocused then
      FFocusRect := cxRectContent(CaptionRect, cxRect(2, 2, 2, 2))
    else
      SetRectEmpty(FFocusRect);
  end;

begin
  CalcCaptionRect;
  CalcDesignRect(CaptionRect, 14);
  CalcFocusRect;
  CalcClientRect;
  CalcItemsRect;
  Y := Rect.Bottom + ViewInfo.GetSpaceBetweenGroups;
end;

procedure TdxNavBarGroupViewInfo.CorrectBounds(dX, dY: Integer);
var
  I: Integer;
begin
  inherited;
  OffsetRect(FItemsRect, dX, dY);
  OffsetRect(FCaptionTextRect, dX, dY);
  OffsetRect(FCaptionSignRect, dX, dY);
  for I := 0 to ItemCount - 1 do
    Items[I].CorrectBounds(dX, dY);
end;

procedure TdxNavBarGroupViewInfo.CorrectActiveGroupBounds(dX, dY: Integer);
var
  I, AOffsetY: Integer;
begin
  Inc(FRect.Right, dX);
  Inc(FRect.Bottom, dY);
  Inc(FItemsRect.Right, dX);
  Inc(FItemsRect.Bottom, dY);
  AOffsetY := 0;
  if ItemCount > 0 then
    AOffsetY := Items[Min(Group.TopVisibleLinkIndex, ItemCount - 1)].Rect.Top - Items[0].Rect.Top;
  for I := 0 to ItemCount - 1 do
    Items[I].CorrectBounds(0, - AOffsetY);
end;

function TdxNavBarGroupViewInfo.GetControl: TdxNavBarGroupControl;
begin
  if Group.ShowControl then
    Result := Group.Control
  else Result := nil;
end;

function TdxNavBarGroupViewInfo.GetControlBackColor: TColor;
begin
  if (Group.StyleControl <> nil) and (savBackColor in Group.StyleControl.Style.AssignedValues) then
    Result := Group.StyleControl.Style.BackColor
  else Result := NavBar.DefaultStyles.GroupControl.BackColor;
end;

function TdxNavBarGroupViewInfo.GetControlBackColor2: TColor;
begin
  if (Group.StyleControl <> nil) and (savBackColor2 in Group.StyleControl.Style.AssignedValues) then
    Result := Group.StyleControl.Style.BackColor2
  else Result := NavBar.DefaultStyles.GroupControl.BackColor2;
end;

function TdxNavBarGroupViewInfo.GetItemCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxNavBarGroupViewInfo.GetItem(Index: Integer): TdxNavBarLinkViewInfo;
begin
  Result := TdxNavBarLinkViewInfo(FItems.Items[Index]);
end;

function TdxNavBarGroupViewInfo.IsDefaultControlStyle: Boolean;
begin
  Result := (GetControlBackColor = clNone) or (GetControlBackColor2 = clNone);
end;

procedure TdxNavBarGroupViewInfo.AddLink(AViewInfo: TdxNavBarViewInfo; ALink: TdxNavBarItemLink; ACaptionVisible, AImageVisisble: Boolean);
begin
  FItems.Add(Painter.CreateLinkViewInfo(self, ALink, ACaptionVisible, AImageVisisble));
end;

procedure TdxNavBarGroupViewInfo.ClearItems;
var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do Items[I].Free;
  FItems.Clear;
end;

procedure TdxNavBarGroupViewInfo.DoCreateItemsInfo;
var
  I: Integer;
begin
  if IsItemsVisible and (Control = nil) then
    for I := 0 to Group.LinkCount - 1 do
      if (Group.Links[I].Item <> nil) and Group.Links[I].Item.Visible then
        AddLink(ViewInfo, Group.Links[I], True, True);
end;

function TdxNavBarGroupViewInfo.GetBorderOffsets: TRect;
begin
  Result := ViewInfo.GetGroupBorderOffsets;
  if IsCaptionVisible then
    Result.Top := 0;
end;

function TdxNavBarGroupViewInfo.GetControlRect: TRect;
begin
  Result := cxRectContent(ItemsRect, GetBorderOffsets);
end;

function TdxNavBarGroupViewInfo.GetImageIndent: Integer;
begin
  Result := ViewInfo.GetGroupCaptionImageOffsets.Left;
end;

{ TdxNavBarScrollBar }

constructor TdxNavBarScrollBar.Create(AParent: TWinControl; AKind: TScrollBarKind);
begin
  inherited Create;
  FParent := AParent;
  FKind := AKind;
  FLookAndFeel := TcxLookAndFeel.Create(nil);
  FLookAndFeel.OnChanged := LookAndFeelChanged;
  RecreatecxScrollBar;
end;

destructor TdxNavBarScrollBar.Destroy;
begin
  DestroyInternalScrollBar;
  FreeAndNil(FLookAndFeel);
  inherited Destroy;
end;

procedure TdxNavBarScrollBar.SetScrollParams(AMin, AMax, APosition, APageSize: Integer; ARedraw:
  Boolean = True);
var
  AClientRect: TRect;
begin
  if (AMax < AMin) or (AMax < APageSize) then
    raise EInvalidOperation.Create(SScrollBarRange);

  CorrectPos(APosition, AMin, AMax, APageSize);
  AClientRect := FParent.ClientRect;

  if (Min <> AMin) or (Max <> AMax) or (PageSize <> APageSize) or (Position <> APosition) then
  begin
    FScrollInfo.nMin := AMin;
    FScrollInfo.nMax := AMax;
    FScrollInfo.nPage := APageSize;
    FScrollInfo.nPos := APosition;
    with FScrollInfo do
      FScrollBar.SetScrollParams(nMin, nMax, APosition, APageSize, ARedraw);
    FLargeChange := FScrollInfo.nPage;
  end;
end;

procedure TdxNavBarScrollBar.CheckScrollBarClass;
begin
  if FScrollBar.ClassType <> NavBarPainter.GetcxScrollBarHelperClass then
    RecreatecxScrollBar;
end;

procedure TdxNavBarScrollBar.Paint(ACanvas: TcxCanvas);
begin
  ScrollBar.Paint(ACanvas);
end;

procedure TdxNavBarScrollBar.RecreatecxScrollBar;
var
  AWasVisible: Boolean;
begin
  AWasVisible := (FScrollBar <> nil) and FScrollBar.Visible;
  DestroyInternalScrollBar;
  FScrollBar := NavBarPainter.CreatecxScrollBarHelper(Self);
  TdxNavBar(FParent).ScrollBarsManager.RegisterScrollBar(FScrollBar);
  FScrollBar.Kind := FKind;
  FScrollBar.OnScroll := Scroll;
  FScrollBar.IsNonClient := True;
  ResetScrollInfo;
  if AWasVisible then
    VisibleChanged;
end;

procedure TdxNavBarScrollBar.ResetScrollInfo;
begin
  ZeroMemory(@FScrollInfo, FScrollInfo.cbSize);
  FScrollInfo.cbSize := SizeOf(FScrollInfo);
  FScrollInfo.fMask := SIF_ALL;
  FScrollInfo.nMax := 100;
end;

procedure TdxNavBarScrollBar.Scroll(Sender: TObject; AScrollCode: TScrollCode; var AScrollPos: Integer);

  procedure DoScroll(AScrollCode: TScrollCode; var AScrollPos: Integer);
  begin
    if Assigned(OnScroll) then
      OnScroll(Self, AScrollCode, AScrollPos);
  end;

var
  ANewPos: Integer;
begin
  ANewPos := Position;
  case AScrollCode of
    scLineUp: Dec(ANewPos, SmallChange);
    scLineDown: Inc(ANewPos, SmallChange);
    scPageUp: Dec(ANewPos, LargeChange);
    scPageDown: Inc(ANewPos, LargeChange);
    scPosition, scTrack: ANewPos := AScrollPos;
    scTop: ANewPos := Min;
    scBottom: ANewPos := Max;
  end;
  Position := ANewPos;
  AScrollPos := ANewPos;
  DoScroll(AScrollCode, AScrollPos);
end;

procedure TdxNavBarScrollBar.UpdateStyle;

  procedure SetLookAndFeelKind(AKind: TcxLookAndFeelKind);
  begin
    LookAndFeel.NativeStyle := False;
    LookAndFeel.SkinName := '';
    LookAndFeel.Kind := AKind;
  end;

begin
  if not NavBarPainter.NeedScrollBar then
    Visible := False;
  CheckScrollBarClass;
  case TdxCustomNavBar(FParent).GetViewReal of
    dxNavBarXP1View, dxNavBarXP2View, dxNavBarXPExplorerBarView, dxNavBarAdvExplorerBarView,
    dxNavBarOffice11ExplorerBarView, dxNavBarVistaExplorerBarView:
      LookAndFeel.NativeStyle := True;
    dxNavBarBaseView:
      SetLookAndFeelKind(lfStandard);
    dxNavBarOffice1View, dxNavBarOffice2View, dxNavBarOffice3View, dxNavBarFlatView:
      SetLookAndFeelKind(lfFlat);
    dxNavBarUltraFlatExplorerView, dxNavBarExplorerBarView:
      SetLookAndFeelKind(lfUltraFlat);
    dxNavBarOffice11TaskPaneView, dxNavBarOffice11NavigatorPaneView:
      SetLookAndFeelKind(lfOffice11);
  else
    NavBarPainter.UpdateScrollBarLookAndFeel(LookAndFeel);
  end;
end;

function TdxNavBarScrollBar.GetControl: TWinControl;
begin
  Result := FParent;
end;

function TdxNavBarScrollBar.GetLookAndFeel: TcxLookAndFeel;
begin
  Result := FLookAndFeel;
end;

procedure TdxNavBarScrollBar.CorrectPos(var APos: Integer;  AMin, AMax, APageSize: Integer);
begin
  if APos < AMin then
    APos := AMin;
  if APos > AMax - APageSize then
    APos := AMax - APageSize;
end;

function TdxNavBarScrollBar.GetBounds: TRect;
begin
  Result := ScrollBar.BoundsRect;
end;

function TdxNavBarScrollBar.GetHeight: Integer;
begin
  Result := FParent.ClientHeight;
end;

function TdxNavBarScrollBar.GetMax: Integer;
begin
  Result := FScrollInfo.nMax;
end;

function TdxNavBarScrollBar.GetMin: Integer;
begin
  Result := FScrollInfo.nMin;
end;

function TdxNavBarScrollBar.GetNavBarPainter: TdxNavBarPainter;
begin
  Result := TdxCustomNavBar(FParent).Painter;
end;

function TdxNavBarScrollBar.GetPageSize: Integer;
begin
  Result := FScrollInfo.nPage
end;

function TdxNavBarScrollBar.GetPosition: Integer;
begin
  Result := FScrollInfo.nPos;
end;

function TdxNavBarScrollBar.GetVisible: Boolean;
begin
  Result := FScrollBar.Visible;
end;

function TdxNavBarScrollBar.GetWidth: Integer;
begin
  Result := GetScrollBarSize.cx;
end;

procedure TdxNavBarScrollBar.SetBounds(const AValue: TRect);
begin
  ScrollBar.BoundsRect := AValue;
  ScrollBar.Calculate;
end;

procedure TdxNavBarScrollBar.SetMax(const Value: Integer);
begin
  SetScrollParams(Min, Value, Position, PageSize);
end;

procedure TdxNavBarScrollBar.SetMin(const Value: Integer);
begin
  SetScrollParams(Value, Max, Position, PageSize);
end;

procedure TdxNavBarScrollBar.SetPageSize(const Value: Integer);
begin
  SetScrollParams(Min, Max, Position, Value);
end;

procedure TdxNavBarScrollBar.SetPosition(const Value: Integer);
begin
  SetScrollParams(Min, Max, Value, PageSize);
end;

procedure TdxNavBarScrollBar.SetVisible(const Value: Boolean);
begin
  if Visible <> Value then
  begin
    FScrollBar.Visible := Value;
    VisibleChanged;
  end;
end;

procedure TdxNavBarScrollBar.DestroyInternalScrollBar;
begin
  TdxNavBar(FParent).ScrollBarsManager.UnRegisterScrollBar(FScrollBar);
  FreeAndNil(FScrollBar);
end;

procedure TdxNavBarScrollBar.LookAndFeelChanged(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
  ScrollBar.Repaint;
end;

procedure TdxNavBarScrollBar.VisibleChanged;
begin
  SetWindowPos(FParent.Handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOMOVE or
    SWP_NOZORDER or SWP_NOACTIVATE or SWP_NOSIZE);
  RedrawWindow(FParent.Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_ALLCHILDREN or
    RDW_FRAME or RDW_INTERNALPAINT);
end;

{ TdxNavBarItemCalculators }

class procedure TdxNavBarItemCalculator.CalculateBounds(X, Y: Integer; var ALinkViewInfo);

  procedure PriorCalcImageRect(ALeft, ATop: Integer);
  begin
    with TdxNavBarLinkViewInfo(ALinkViewInfo) do
      FImageRect := cxRectBounds(ALeft, ATop, GetImageWidth, GetImageHeight);
  end;

  procedure PriorCalcCaptionRect(ALeft, ATop, ARightPosition: Integer);
  var
    ARect: TRect;
  begin
    with TdxNavBarLinkViewInfo(ALinkViewInfo) do
    begin
      Dec(ARightPosition, ViewInfo.GetGroupBorderOffsets.Right + 1);
      ARect := cxRect(ALeft, ATop, ARightPosition, ATop + GetCaptionHeight);
      cxScreenCanvas.Canvas.Font := Font;
      cxDrawText(cxScreenCanvas.Handle, Item.Caption, ARect, GetDrawEdgeFlag or DT_CALCRECT);
      cxScreenCanvas.Dormant;
      ARect.Right := Min(ARect.Right, ARightPosition);
      FCaptionRect := ARect;
    end;
  end;

  procedure CalcRect(ARight, ABottom: Integer);
  begin
    TdxNavBarLinkViewInfo(ALinkViewInfo).FRect := cxRect(X, Y, ARight, ABottom);
  end;

  procedure CalcSmallBounds(ARightPosition: Integer);
  var
    AHeight: Integer;
  begin
    with TdxNavBarLinkViewInfo(ALinkViewInfo) do
    begin
      PriorCalcImageRect(X + ViewInfo.GetLinksImageEdges.Left, Y);
      PriorCalcCaptionRect(FImageRect.Right + ViewInfo.GetLinksImageEdges.Right, Y, ARightPosition - 1);
      AHeight := Max(cxRectHeight(ImageRect), cxRectHeight(CaptionRect)) + ViewInfo.GetLinksSmallSeparatorWidth;
      dxAdjustToTouchableSize(AHeight);
      CalcRect(ARightPosition, Y + AHeight);

      OffsetRect(FImageRect, 0, (cxRectHeight(Rect) - cxRectHeight(ImageRect)) div 2);
      OffsetRect(FCaptionRect, 0, (cxRectHeight(Rect) div 2) - (cxRectHeight(CaptionRect) div 2));
    end;
  end;

  procedure CalcLargeBounds(ARightPosition: Integer);
  begin
    with TdxNavBarLinkViewInfo(ALinkViewInfo) do
    begin
      PriorCalcImageRect(X, Y + ViewInfo.GetLinksLargeSeparatorWidth div 2);
      PriorCalcCaptionRect(X + 1, FImageRect.Bottom + ViewInfo.GetLinksImageEdges.Bottom, ARightPosition - 1);

      CalcRect(ARightPosition, CaptionRect.Bottom + ViewInfo.GetLinksLargeSeparatorWidth div 2);

      OffsetRect(FImageRect, (cxRectWidth(Rect) - cxRectWidth(ImageRect)) div 2, 0);
      OffsetRect(FCaptionRect, (cxRectWidth(Rect) - cxRectWidth(CaptionRect)) div 2, 0);
    end;
  end;

  procedure CalcFocusRect;
  begin
    with TdxNavBarLinkViewInfo(ALinkViewInfo) do
      if IsFocused then
        cxRectIntersect(FFocusRect, Rect, cxRectInflate(CaptionRect, 2, 0, 2, 0))
      else
        SetRectEmpty(FFocusRect);
  end;

var
  ARightPosition: Integer;
begin
  with TdxNavBarLinkViewInfo(ALinkViewInfo) do
  begin
    if GroupViewInfo.IsViewAsIconView then
    begin
      PriorCalcImageRect(X + ViewInfo.GetLinksImageEdges.Left,
        Y + ViewInfo.GetLinksImageEdges.Top);

      SetRectEmpty(FCaptionRect);

      CalcRect(FImageRect.Right + ViewInfo.GetLinksImageEdges.Right,
        FImageRect.Bottom + ViewInfo.GetLinksImageEdges.Bottom);
    end
    else
    begin
      ARightPosition := ViewInfo.ClientWidth - X;
      if GroupViewInfo.IsLinksUseSmallImages then
        CalcSmallBounds(ARightPosition)
      else
        CalcLargeBounds(ARightPosition);
    end;
    CalcFocusRect;
    CalcDesignRect(FRect, 10);
  end;
end;

class procedure TdxNavBarSeparatorCalculator.CalculateBounds(X, Y: Integer; var ALinkViewInfo);
const
  ASeparatorHeight = 3;
begin
  with TdxNavBarLinkViewInfo(ALinkViewInfo) do
  begin
    FRect := cxRect(X, Y, X + ViewInfo.ClientWidth - 2 * ViewInfo.GetGroupEdges.X, Y + ASeparatorHeight);
    FImageRect := cxRectBounds(FRect.Left + ViewInfo.GetLinksImageEdges.Left, FRect.Top, GetImageWidth, ASeparatorHeight);
    FCaptionRect := FRect;
    if not UseLargeImages then
      FCaptionRect.Left := FImageRect.Right + ViewInfo.GetLinksImageEdges.Right;
  end;
end;

{ TdxNabBarDragObject }

constructor TdxNavBarDragObject.Create(ANavBar: TdxCustomNavBar;
    var DragObject: TDragObject {deprecated};
    ASourceGroup: TdxNavBarGroup; ASourceLink: TdxNavBarItemLink; ASourceItem: TdxNavBarItem);
begin
  inherited Create;
  FNavBar := ANavBar;
  FSourceLink := ASourceLink;
  FSourceGroup := ASourceGroup;
  FSourceItem := ASourceItem;
end;

procedure TdxNavBarDragObject.UpdateTargets;
begin
  if SourceGroup <> nil then
  begin
    FTargetGroup := NavBar.ViewInfo.GetGroupAtCaptionPos(NavBar.TargetPoint);
    if FTargetGroup = nil then
      FTargetGroup := NavBar.ViewInfo.GetGroupAtItemsPos(NavBar.TargetPoint);
  end
  else if (SourceLink <> nil) or (SourceItem <> nil) then
    FTargetLinkIndex := NavBar.ViewInfo.GetLinksAtDragPosition(NavBar.TargetPoint,
      FTargetGroup, FTargetLink1, FTargetLink2);
end;

function TdxNavBarDragObject.GetSourceItem: TdxNavBarItem;
begin
  if FSourceItem <> nil then
    Result := FSourceItem
  else if (GetKeyState(VK_CONTROL) < 0) and (FSourceLink <> nil) then
    Result := FSourceLink.Item
  else Result := nil;
end;

{ TdxNavBarController }

constructor TdxNavBarController.Create(ANavBar: TdxCustomNavBar);
begin
  inherited Create;
  FNavBar := ANavBar;
  FHotPart := dxNavBarPart(nbNone);
  FPressedPart := dxNavBarPart(nbNone);
end;

destructor TdxNavBarController.Destroy;
begin
  cxClearObjectLinks(Self);
  inherited;
end;

procedure TdxNavBarController.CheckBounds(var ALeft, ATop, AWidth, AHeight: Integer);
begin
  DoCheckBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TdxNavBarController.InvalidateAll(AType: TdxNavBarChangeType);
begin
  FNavBar.InvalidateAll(AType);
end;

procedure TdxNavBarController.MouseDown(AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint);
begin
  DoMouseDown(AButton, AShift, APoint);
end;

procedure TdxNavBarController.MouseUp(AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint);
begin
  DoMouseUp(AButton, AShift, APoint);
end;

procedure TdxNavBarController.MouseMove(AShift: TShiftState; const APoint: TPoint);
begin
  DoMouseMove(AShift, APoint);
end;

procedure TdxNavBarController.MouseLeave;
begin
  DoMouseLeave;
end;

function TdxNavBarController.MouseWheel(AShift: TShiftState; AWheelDelta: Integer; const APoint: TPoint): Boolean;
begin
  Result := DoMouseWheel(AShift, AWheelDelta, APoint);
end;

procedure TdxNavBarController.ShowHint(var AHintInfo: THintInfo; out ACanShow: Boolean);
begin
  ACanShow := not NavBar.EnableDragging;
  if ACanShow then
  begin
    if AHintInfo.HintWindowClass = THintWindow then
      AHintInfo.HintWindowClass := TdxNavBarHintWindow;
    AHintInfo.HintData := @AHintInfo;
    ViewInfo.HintText := '';
    DoShowHint(AHintInfo);
    AHintInfo.HintStr := ViewInfo.HintText;
    ACanShow := AHintInfo.HintStr <> '';
  end;
end;

function TdxNavBarController.CanFocusOnClick(const APoint: TPoint): Boolean;
begin
  Result := not (NavBar.IsPtTopScrollButton(APoint) or NavBar.IsPtBottomScrollButton(APoint));
end;

function TdxNavBarController.GetCursor: HIcon;
begin
  Result := 0;
end;

function TdxNavBarController.GetItemHintRect(ANavBarItem: TObject;
  ACalcHintProc: TdxNavBarCalcHintEvent): TRect;
const
  AFlagsMap: array [Boolean] of DWORD = (0, DT_WORDBREAK);
begin
  Result := Rect(0, 0, Max(ViewInfo.ClientWidth, NavBar.OriginalWidth), 0);
  cxScreenCanvas.Font := ViewInfo.HintFont;
  cxDrawText(cxScreenCanvas.Handle, ViewInfo.HintText, Result, DT_CALCRECT or DT_LEFT or
    DT_NOPREFIX or AFlagsMap[ANavBarItem <> nil]);
  cxScreenCanvas.Dormant;
  Inc(Result.Right, dxNavBarHintWindowSizeCorrection);
  Inc(Result.Bottom, dxNavBarHintWindowSizeCorrection);
  if Assigned(ACalcHintProc) then
    ACalcHintProc(ANavBarItem, Result);
  OffsetRect(Result, 20, 0);
end;

function TdxNavBarController.GetPartAtPos(const APoint: TPoint): TdxNavBarPart;
begin
  Result := dxNavBarPart(nbNone);
end;

procedure TdxNavBarController.DoClick(const APart: TdxNavBarPart);
begin
// do nothing
end;

procedure TdxNavBarController.DoCheckBounds(var ALeft, ATop, AWidth, AHeight: Integer);
begin
// do nothing
end;

procedure TdxNavBarController.DoLinkClick(ANavBar: TdxCustomNavBar; ALink: TdxNavBarItemLink);
var
  AItem: TdxNavBarItem;
begin
  AItem := ALink.Item;
  ALink.Selected := ANavBar.AllowSelectLinks;
  if Assigned(AItem.OnClick) then
    AItem.OnClick(AItem)
  else
    if AItem.Action <> nil then
      AItem.ActionLink.Execute(AItem)
    else
      if Assigned(ANavBar.OnLinkClick) then
        ANavBar.OnLinkClick(ANavBar, ALink);
end;

procedure TdxNavBarController.DoLinkHotTrack(ANavBar: TdxCustomNavBar; ALink: TdxNavBarItemLink);
begin
  if Assigned(ANavBar.OnLinkHotTrack) then
    ANavBar.OnLinkHotTrack(ANavBar, ALink);
end;

procedure TdxNavBarController.DoLinkPress(ANavBar: TdxCustomNavBar; ALink: TdxNavBarItemLink);
begin
  if Assigned(ANavBar.OnLinkPress) then
    ANavBar.OnLinkPress(ANavBar, ALink);
end;

procedure TdxNavBarController.DoMouseDown(AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint);
var
  AGroup: TdxNavBarGroup;
  ALink: TdxNavBarItemLink;
begin
  with FNavBar do
    if ssLeft in AShift then
    begin
      if IsPtTopScrollButton(APoint) then
        DoTopScrollButtonDown
      else
        if IsPtBottomScrollButton(APoint) then
          DoBottomScrollButtonDown
        else
        begin
          AGroup := GetGroupAtCaptionPos(APoint);
          if AGroup <> nil then
            DoGroupMouseDown(AGroup)
          else
          begin
            if IsDesigning then
              ALink := GetLinkAtPos(APoint)
            else
              ALink := GetLinkAtSelectedPos(APoint);
            if ALink <> nil then
              DoLinkMouseDown(ALink);
          end;
        end;
    end
    else
      if (FHotTrackedGroup <> nil) or (FHotTrackedLink <> nil) then
        UpdateHotTrack(AShift, APoint);
end;

procedure TdxNavBarController.DoMouseUp(AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint);

  procedure InternalDoMouseUp;
  begin
    with FNavBar do
      if IsPtTopScrollButton(FSourcePoint) or ScrollButtonUpIsDown then
        DoTopScrollButtonUp
      else
        if IsPtBottomScrollButton(FSourcePoint) or ScrollButtonDownIsDown then
          DoBottomScrollButtonUp
        else
        begin
          FScrollButtonDownIsDown := False;
          FScrollButtonUpIsDown := False;
          if (FSourceGroup <> nil) and ((FSourceGroup = FHotTrackedGroup) or NavBar.IsDesigning) then
            DoGroupMouseUp(FSourceGroup);
          if (FSourceLink <> nil) and ((FSourceLink = FHotTrackedLink) or NavBar.IsDesigning) then
            DoLinkMouseUp(FSourceLink);
        end;
  end;

var
  APart: TdxNavBarPart;
begin
  APart := GetPartAtPos(APoint);
  SetHotPart(APart);

  if IsdxNavBarPartsEqual(APart, FPressedPart) then
  begin
    PressedPart := dxNavBarPart(nbNone);
    DoClick(APart);
  end
  else
    PressedPart := dxNavBarPart(nbNone);

  if IsdxNavBarPartsEqual(APart, dxNavBarPart(nbNone)) then
    InternalDoMouseUp;
end;

procedure TdxNavBarController.DoMouseMove(AShift: TShiftState; const APoint: TPoint);
begin
  UpdateHotTrack(AShift, FNavBar.TargetPoint);
end;

procedure TdxNavBarController.DoMouseLeave;
begin
end;

function TdxNavBarController.DoMouseWheel(AShift: TShiftState; AWheelDelta: Integer; const APoint: TPoint): Boolean;

  function IsScrollBarsPresent(AControl: TWinControl): Boolean;
  var
    AScrollInfo: TScrollInfo;
  begin
    ZeroMemory(@AScrollInfo, SizeOf(TScrollInfo));
    AScrollInfo.fMask := SIF_ALL;
    AScrollInfo.cbSize := SizeOf(TScrollInfo);
    GetScrollInfo(AControl.Handle, SB_VERT, AScrollInfo);
    Result := (AScrollInfo.nPage > 0) and (AScrollInfo.nMax >= Integer(AScrollInfo.nPage));
  end;

  function CheckOverlaidControl: Boolean;
  var
    AControl: TWinControl;
    AMessage: TWMMouseWheel;
  begin
    Result := False;
    AControl := FindControl(WindowFromPoint(Mouse.CursorPos));
    if (AControl <> nil) and (AControl <> NavBar) and IsScrollBarsPresent(AControl) then
    begin
      AMessage.Msg := WM_MOUSEWHEEL;
      AMessage.Keys := ShiftStateToKeys(AShift);
      AMessage.WheelDelta := AWheelDelta;
      AMessage.Pos := PointToSmallPoint(APoint);

      AControl.DefaultHandler(AMessage);
      Result := AMessage.Result = 1;
    end;
  end;

const
  AScrollCodes: array[Boolean, Boolean] of TScrollCode = ((scLineUp, scPageUp), (scLineDown, scPageDown));
var
  AScrollPos: Integer;
  AWindowRect: TRect;
begin
  Result := False;
  AWindowRect := cxGetWindowRect(NavBar);
  if PtInRect(AWindowRect, Mouse.CursorPos) then
  begin
    if NavBar.ScrollBar.Visible then
    begin
      if not CheckOverlaidControl then
      begin
        AScrollPos := NavBar.ScrollBar.Position;
        NavBar.ScrollBar.Scroll(NavBar.ScrollBar, AScrollCodes[AWheelDelta < 0, ssCtrl in AShift], AScrollPos);
        Result := True;
      end;
    end
    else
      if AWheelDelta > 0 then
      begin
        if not (sDisabled in ViewInfo.TopScrollButtonState) then
          Result := DoScrollUp;
      end
      else
        if not (sDisabled in ViewInfo.BottomScrollButtonState) then
          Result := DoScrollDown;
    if not NavBar.IsDesigning and Result and not NavBar.EnableDragging then
      UpdateHotTrack(AShift, NavBar.ScreenToClient(APoint));
  end;
end;

function TdxNavBarController.DoScrollDown: Boolean;

  procedure InternalScrollDown;
  var
    I: Integer;
    ATop, ATopVisibleIndex: Integer;
    AActiveGroup: TdxNavBarGroup;
    AActiveGroupViewInfo: TdxNavBarGroupViewInfo;
  begin
    AActiveGroupViewInfo := ViewInfo.ActiveGroupViewInfo;
    AActiveGroup := AActiveGroupViewInfo.Group;
    ATopVisibleIndex := Min(AActiveGroup.TopVisibleLinkIndex, AActiveGroupViewInfo.ItemCount - 1);
    ATop := AActiveGroupViewInfo.Items[ATopVisibleIndex].Rect.Top;
    for I := ATopVisibleIndex + 1 to AActiveGroupViewInfo.ItemCount - 1 do
      if AActiveGroupViewInfo.Items[I].Rect.Top > ATop then
      begin
        AActiveGroup.TopVisibleLinkIndex := I;
        Break;
      end;
  end;

begin
  Result := ViewInfo.ActiveGroupViewInfo <> nil;
  if Result then
    InternalScrollDown;
end;

function TdxNavBarController.DoScrollUp: Boolean;

  procedure InternalScrollUp;
  var
    I: Integer;
    ATop, ATopVisibleIndex: Integer;
    AActiveGroup: TdxNavBarGroup;
    AActiveGroupViewInfo: TdxNavBarGroupViewInfo;
  begin
    AActiveGroupViewInfo := ViewInfo.ActiveGroupViewInfo;
    AActiveGroup := AActiveGroupViewInfo.Group;
    ATopVisibleIndex := Min(AActiveGroup.TopVisibleLinkIndex, AActiveGroupViewInfo.ItemCount - 1);
    ATop := AActiveGroupViewInfo.Items[ATopVisibleIndex].Rect.Top;
    for I := ATopVisibleIndex - 1 downto 0 do
      if AActiveGroupViewInfo.Items[I].Rect.Top < ATop then
      begin
        AActiveGroup.TopVisibleLinkIndex := I;
        Break;
      end;
  end;

begin
  Result := ViewInfo.ActiveGroupViewInfo <> nil;
  if Result then
    InternalScrollUp;
end;

procedure TdxNavBarController.DoSetHotPart(const APart: TdxNavBarPart);
begin
// do nothing
end;

procedure TdxNavBarController.DoSetPressedPart(const APart: TdxNavBarPart);
begin
// do nothing
end;

procedure TdxNavBarController.DoShowHint(var AHintInfo: THintInfo);
var
  AGroupViewInfo: TdxNavBarGroupViewInfo;
  ALinkViewInfo: TdxNavBarLinkViewInfo;
begin
  AGroupViewInfo := ViewInfo.GetGroupViewInfoAtCaptionPos(AHintInfo.CursorPos);
  if AGroupViewInfo <> nil then
  begin
    if NavBar.ShowGroupsHint then
      DoShowGroupHint(AHintInfo, AGroupViewInfo);
  end
  else
  begin
    ALinkViewInfo := ViewInfo.GetLinkViewInfoAtSelectedPos(AHintInfo.CursorPos);
    if ALinkViewInfo <> nil then
    begin
      if NavBar.ShowLinksHint then
        DoShowLinkHint(AHintInfo, ALinkViewInfo);
    end
  end;
end;

procedure TdxNavBarController.DoShowGroupHint(var AHintInfo: THintInfo; AGroupViewInfo: TdxNavBarGroupViewInfo);
var
  AGroup: TdxNavBarGroup;
begin
  AGroup := AGroupViewInfo.Group;
  ViewInfo.HintText := GetGroupHintText(AGroup);
  ViewInfo.HintRect := GetGroupHintRect(AGroup);
  AHintInfo.CursorRect := AGroupViewInfo.CaptionRect;
end;

procedure TdxNavBarController.DoShowLinkHint(var AHintInfo: THintInfo; ALinkViewInfo: TdxNavBarLinkViewInfo);
var
  ALink: TdxNavBarItemLink;
begin
  ALink := ViewInfo.GetLinkAtSelectedPos(AHintInfo.CursorPos);
  ViewInfo.HintText := GetLinkHintText(ALink);
  ViewInfo.HintRect := GetLinkHintRect(ALink);
  AHintInfo.CursorRect := ALinkViewInfo.Rect;
end;

function TdxNavBarController.GetGroupHintRect(AGroup: TdxNavBarGroup): TRect;
begin
  Result := GetItemHintRect(AGroup, CalcGroupHintRect);
end;

function TdxNavBarController.GetLinkHintRect(ALink: TdxNavBarItemLink): TRect;
begin
  Result := GetItemHintRect(ALink, CalcLinkHintRect);
end;

function TdxNavBarController.GetGroupHintText(AGroup: TdxNavBarGroup): string;
begin
  Result := AGroup.Hint;
  if Assigned(NavBar.OnGetGroupHint) then
    NavBar.OnGetGroupHint(NavBar, AGroup, Result);
  Result := GetShortHint(Result);
end;

function TdxNavBarController.GetLinkHintText(ALink: TdxNavBarItemLink): string;
begin
  Result := ALink.Item.Hint;
  if Assigned(NavBar.OnGetLinkHint) then
    NavBar.OnGetLinkHint(NavBar, ALink, Result);
  Result := GetShortHint(Result);
end;

function TdxNavBarController.GetPainter: TdxNavBarPainter;
begin
  Result := FNavBar.Painter;
end;

function TdxNavBarController.GetScrollBarHelper: TcxControlScrollBarHelper;
begin
  Result := FNavBar.ScrollBar.ScrollBar;
end;

function TdxNavBarController.GetViewInfo: TdxNavBarViewInfo;
begin
  Result := FNavBar.ViewInfo;
end;

procedure TdxNavBarController.CalcGroupHintRect(AItem: TObject; var ARect: TRect);
begin
  if Assigned(NavBar.OnCalcGroupHintRect) then
    NavBar.OnCalcGroupHintRect(NavBar, TdxNavBarGroup(AItem), ViewInfo, ARect);
end;

procedure TdxNavBarController.CalcLinkHintRect(AItem: TObject; var ARect: TRect);
begin
  if Assigned(NavBar.OnCalcLinkHintRect) then
    NavBar.OnCalcLinkHintRect(NavBar, TdxNavBarItemLink(AItem), ViewInfo, ARect);
end;

procedure TdxNavBarController.SetHotPart(APart: TdxNavBarPart);
begin
  if not IsdxNavBarPartsEqual(FHotPart, APart) then
  begin
    FHotPart := APart;
    DoSetHotPart(APart);
  end;
end;

procedure TdxNavBarController.SetPressedPart(APart: TdxNavBarPart);
begin
  if not IsdxNavBarPartsEqual(FPressedPart, APart) then
  begin
    FPressedPart := APart;
    DoSetPressedPart(APart);
  end;
end;

procedure TdxNavBarController.UpdateHotTrack(AShift: TShiftState = []);
begin
  UpdateHotTrack(AShift, NavBar.ScreenToClient(GetMouseCursorPos));
end;

procedure TdxNavBarController.UpdateHotTrack(AShift: TShiftState; const APoint: TPoint);
var
  ALink: TdxNavBarItemLink;
  AGroup: TdxNavBarGroup;
begin
  ALink := ViewInfo.GetLinkAtSelectedPos(APoint);
  if ALink <> NavBar.HotTrackedLink then
    NavBar.DoLinkHotTrack(ALink);
  AGroup := ViewInfo.GetGroupAtCaptionPos(APoint);
  if AGroup <> NavBar.HotTrackedGroup then
    NavBar.DoGroupHotTrack(AGroup);
end;

const
  DefaultLookAndFeelSchemes: array [TcxLookAndFeelStyle] of Integer =
    (dxNavBarFlatView, dxNavBarBaseView, dxNavBarFlatView,
     dxNavBarOffice12NavigatorPaneView, dxNavBarOffice11NavigatorPaneView,
     dxNavBarSkinNavigatorPaneView);

{ TdxNavBarLookAndFeelSchemes }

constructor TdxNavBarLookAndFeelSchemes.Create(ANavBar: TdxCustomNavBar);
var
  ALookAndFeelStyle: TcxLookAndFeelStyle;
begin
  inherited Create(ANavBar);
  for ALookAndFeelStyle := Low(TcxLookAndFeelStyle) to High(TcxLookAndFeelStyle) do
    FViews[ALookAndFeelStyle] := DefaultLookAndFeelSchemes[ALookAndFeelStyle];
end;

procedure TdxNavBarLookAndFeelSchemes.Assign(Source: TPersistent);
var
  ASource: TdxNavBarLookAndFeelSchemes;
  ALookAndFeelStyle: TcxLookAndFeelStyle;
begin
  if Source is TdxNavBarLookAndFeelSchemes then
  begin
    ASource := TdxNavBarLookAndFeelSchemes(Source);
    for ALookAndFeelStyle := Low(TcxLookAndFeelStyle) to High(TcxLookAndFeelStyle) do
      FViews[ALookAndFeelStyle] := ASource.FViews[ALookAndFeelStyle];
    Changed;
  end
  else
    inherited;
end;

procedure TdxNavBarLookAndFeelSchemes.Changed;
begin
  NavBar.CheckViewReal;
end;

function TdxNavBarLookAndFeelSchemes.GetRealView(Index: Integer): Integer;
begin
  Result := FViews[TcxLookAndFeelStyle(Index)];
end;

function TdxNavBarLookAndFeelSchemes.GetView(Index: TcxLookAndFeelStyle): Integer;
begin
  Result := FViews[Index];
end;

procedure TdxNavBarLookAndFeelSchemes.SetRealView(Index: Integer;
  const Value: Integer);
begin
  SetView(TcxLookAndFeelStyle(Index), Value);
end;

procedure TdxNavBarLookAndFeelSchemes.SetView(Index: TcxLookAndFeelStyle; const Value: Integer);
begin
  if FViews[Index] <> Value then
  begin
    FViews[Index] := Value;
    Changed;
  end;
end;

{ TdxNavBarPersistent }

constructor TdxNavBarPersistent.Create(ANavBar: TdxCustomNavBar);
begin
  inherited Create;
  FNavBar := ANavBar;
end;

function TdxNavBarPersistent.GetOwner: TPersistent;
begin
  Result := NavBar;
end;

{ TdxCustomNavBar }

constructor TdxCustomNavBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  TabStop := False;

  FView := dxNavBarDefaultView;
  UpdateViewReal;
  FScrollBar := TdxNavBarScrollBar.Create(Self, sbVertical);
  FScrollBar.OnScroll := DoScroll;
  Keys := [kArrows];

  FActivateGroupTimer := cxCreateTimer(DoActivateGroupTimer, dxNavBarActivateGroupInterval, False);
  FScrollTimer := cxCreateTimer(DoScrollTimer, dxNavBarScrollInterval, False);

  FCursors := TdxNavBarCursors.Create(Self);
  FOnCustomDraw := TdxNavBarCustomDrawEvents.Create(Self);

  FCustomization := GetCustomizationClass.Create(Self);

  FOptionsStyle := TdxNavBarStyleOptions.Create(Self);
  FOptionsStyle.OnChange := OnStylesChanged;
  FOptionsBehavior := TdxNavBarBehaviorOptions.Create(Self);
  FOptionsView := TdxNavBarViewOptions.Create(Self);
  FOptionsImage := TdxNavBarImageOptions.Create(Self);
  OptionsImage.FDisabledSmallChangeLink.OnChange := OnImagesChanged;
  OptionsImage.FDisabledLargeChangeLink.OnChange := OnImagesChanged;
  OptionsImage.FHotSmallChangeLink.OnChange := OnImagesChanged;
  OptionsImage.FHotLargeChangeLink.OnChange := OnImagesChanged;
  OptionsImage.FLargeChangeLink.OnChange := OnImagesChanged;
  OptionsImage.FSmallChangeLink.OnChange := OnImagesChanged;

  FGroups := TdxNavBarGroups.Create(Self, GetGroupClass);
  FGroups.OnChange := OnGroupsChanged;
  FGroups.OnLinksChange := OnLinksChanged;
  FItems := TdxNavBarItems.Create(Self, GetItemClass);
  FItems.OnChange := OnItemsChanged;

  FThemeNotificator := TdxThemeChangedNotificator.Create;
  FThemeNotificator.OnThemeChanged := OnThemeChanged;

  FLookAndFeelSchemes := TdxNavBarLookAndFeelSchemes.Create(Self);

//  FNavigationPaneOverflowPanelHotTrackedIndex := -1;
//  FNavigationPaneOverflowPanelPressedIndex := -1;

  BevelInner := bvNone;
  BevelOuter := bvNone;
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption]  + [csActionClient];
  Height := 300;
  Width := 150;
  ShowHint := True;

  AssignDefaultStyles;
  if Assigned(FOnRegisterNavBar) then
    FOnRegisterNavBar(Self);
end;

destructor TdxCustomNavBar.Destroy;
begin
  Customization.Visible := False;
  if Assigned(FOnUnRegisterNavBar) then
    FOnUnRegisterNavBar(Self);
  NavBarAccessibleObjectOwnerObjectDestroyed(FIAccessibilityHelper);

  FreeAndNil(FActivateGroupTimer);
  FreeAndNil(FScrollTimer);

  FreeAndNil(FScrollBar);

  FreeAndNil(FLookAndFeelSchemes);

  FreeAndNil(FThemeNotificator);

  FreeAndNil(FItems);
  FreeAndNil(FGroups);

  FreeAndNil(FOptionsImage);
  FreeAndNil(FOptionsView);
  FreeAndNil(FOptionsBehavior);
  FreeAndNil(FOptionsStyle);

  FreeAndNil(FCustomization);
  
  FreeAndNil(FOnCustomDraw);
  FreeAndNil(FCursors);
  FreeAndNil(FPainter);
  cxClearObjectLinks(Self);
  inherited;
end;

function TdxCustomNavBar.CanFocus: Boolean;
begin
  Result := inherited CanFocus and TabStop;
end;

procedure TdxCustomNavBar.DeSelectLinks;
var
  I: Integer;
begin
  for I := 0 to Groups.Count - 1 do
    Groups[I].SelectedLinkIndex := -1;
end;

procedure TdxCustomNavBar.DragDrop(Source: TObject; X, Y: Integer);
begin
  if FPressedGroup <> nil then
  begin
    FPressedGroup := nil;
    InvalidateAll(doRedraw);
  end;
  if FPressedLink <> nil then
  begin
    FPressedLink := nil;
    InvalidateAll(doRedraw);
  end;
  FTargetPoint := Point(X, Y);
  FHotTrackedLink := GetLinkAtSelectedPos(FTargetPoint);
  FHotTrackedGroup := GetGroupAtCaptionPos(FTargetPoint);
  if dxNavBarDragObject <> nil then
  begin
    dxNavBarDragObject.UpdateTargets;
    if (SourceItem <> nil) and IsAllowDropLink then
      DoItemDragDrop(SourceItem)
    else if (SourceLink <> nil) and IsAllowDropLink then
      DoLinkDragDrop(SourceLink)
    else if (SourceGroup <> nil) and IsAllowDropGroup then
      DoGroupDragDrop(SourceGroup)
  end;
  inherited DragDrop(Source, X, Y);
  DragDone;
end;

procedure TdxCustomNavBar.Loaded;
begin
  inherited;
  if FIsLookAndFeelDependent then
    View := -1;
  if InRange(FActiveGroupIndex, 0, Groups.Count - 1) then
    FActiveGroup := Groups[FActiveGroupIndex];
  DefaultStyles.AssignDefaultValues(True);
  if OptionsBehavior.NavigationPane.Collapsed then
    Include(FInternalState, nbisAlreadyCollapsed);
  DoUpdateScrollBarStyle;
  InvalidateAll(doRecalc);
end;

procedure TdxCustomNavBar.MouseEnter(AControl: TControl);
begin
  if AControl <> Self then Exit;
  inherited;
  InvalidateAll(doRedraw);
end;

procedure TdxCustomNavBar.MouseLeave(AControl: TControl);
begin
  if AControl <> Self then Exit;
  FTargetPoint := cxInvalidPoint;
  Controller.UpdateHotTrack;
  if dxNavBarDragObject <> nil then
    dxNavBarDragObject.UpdateTargets;
  inherited;
  Controller.MouseLeave;
  InvalidateAll(doRecalc);
end;

procedure TdxCustomNavBar.AccessibleObjectOwnerObjectDestroyedNotification(
  Sender: TObject);
begin
  if (FFocusedAccessibleObject <> nil) and
    (FFocusedAccessibleObject.GetHelper = Sender) then
      FFocusedAccessibleObject := nil;
end;

procedure TdxCustomNavBar.BoundsChanged;
begin
  InvalidateAll(ViewInfo.GetBoundsUpdateType);
  inherited;
end;

procedure TdxCustomNavBar.CheckBounds(var ALeft, ATop, AWidth, AHeight: Integer);
begin
  Inc(FIsBoundsCheckingLockCount);
  Controller.CheckBounds(ALeft, ATop, AWidth, AHeight);
  Dec(FIsBoundsCheckingLockCount);
end;

procedure TdxCustomNavBar.CheckCollapseState;

  function AlreadyCollapsed: Boolean;
  begin
    Result := nbisAlreadyCollapsed in FInternalState;
  end;

  procedure SetSpecificWidth(AWidth: Integer);
  begin
    Width := AWidth;
  end;

  procedure CheckWidth;
  begin
    if IsCollapsed then
    begin
      if Width <> ViewInfo.GetNavBarCollapsedWidth then
        SetSpecificWidth(ViewInfo.GetNavBarCollapsedWidth)
    end
    else
      if AlreadyCollapsed then
        SetSpecificWidth(FOriginalWidth)
      else
        if OptionsBehavior.NavigationPane.Collapsible and ViewInfo.CanCollapse and
          (Width < ViewInfo.GetNavBarMinExpandedWidth) then
          SetSpecificWidth(ViewInfo.GetNavBarMinExpandedWidth);
  end;

  procedure DoCollapseStateChanged;
  var
    ANeedCollapse, ANeedExpand: Boolean;
  begin
    ANeedCollapse := IsCollapsed and not AlreadyCollapsed;
    ANeedExpand := not IsCollapsed and AlreadyCollapsed;
    if ANeedExpand or ANeedCollapse then
      if ANeedCollapse then
      begin
        Include(FInternalState, nbisAlreadyCollapsed);
        DoNavigationPaneCollapsed;
      end
      else
      begin
        Exclude(FInternalState, nbisAlreadyCollapsed);
        DoNavigationPaneExpanded;
      end;
  end;

begin
  dxTestCheck((Painter <> nil) and Painter.IsViewInfoValid, 'CheckCollapseState');
  if FIsCollapseStateChecking then Exit;
  FIsCollapseStateChecking := True;
  try
    if FIsBoundsCheckingLockCount = 0 then
      CheckWidth;
    DoCollapseStateChanged;
  finally
    FIsCollapseStateChecking := False;
  end;
end;

procedure TdxCustomNavBar.CheckFocusedAccessibleObject;
begin
  if (FocusedAccessibleObject <> nil) and not FocusedAccessibleObject.CanFocus(False) then
    FocusedAccessibleObject.RemoveFocus;
end;

procedure TdxCustomNavBar.CollapseStateChanged;
begin
  if OptionsBehavior.NavigationPane.Collapsed and not IsLoading then
    OriginalWidth := Max(Width, ViewInfo.GetNavBarMinExpandedWidth);
  InvalidateAll(doRecreate);
end;

procedure TdxCustomNavBar.CreateParams(var Params: TCreateParams);
const
  ABorderStylesMap: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ABorderStylesMap[BorderStyle];
  if NewStyleControls and Ctl3D and (BorderStyle = bsSingle) then
  begin
    Params.Style := Params.Style and not WS_BORDER;
    Params.ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
  end;
  Params.WindowClass.style := Params.WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TdxCustomNavBar.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited CreateWindowHandle(Params);
  ScrollBar.ResetScrollInfo;
  InvalidateAll(doRecalc);
end;

procedure TdxCustomNavBar.DefineProperties(Filer: TFiler);

  function NeedWriteOriginalWidth: Boolean;
  begin
    Result := OptionsBehavior.NavigationPane.Collapsed;
    if Filer.Ancestor is TdxCustomNavBar then
      Result := Result and (OriginalWidth <> TdxCustomNavBar(Filer.Ancestor).OriginalWidth);
  end;

begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('OriginalWidth', ReadOriginalWidth, WriteOriginalWidth,
    NeedWriteOriginalWidth);
end;

function TdxCustomNavBar.GetClientOffsets: TRect;
begin
  Result := inherited GetClientOffsets;
  Inc(Result.Right, IfThen(ScrollBar.Visible, ScrollBar.Width));
end;

function TdxCustomNavBar.GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean;
begin
  Result := inherited GetDesignHitTest(X, Y, Shift) or
    IsPtGroupDesignRect(Point(X,Y)) or IsPtItemDesignRect(Point(X, Y)) or
    IsPtTopScrollButton(Point(X,Y)) or IsPtBottomScrollButton(Point(X,Y));
end;

function TdxCustomNavBar.GetViewReal: Integer;
begin
  if dxNavBarViewsFactory.IsViewRegistered(FViewReal) then
    Result := FViewReal
  else
    Result := dxNavBarViewsFactory.IDs[dxNavBarViewsFactory.Count - 1];
end;

procedure TdxCustomNavBar.FocusChanged;
begin
  inherited;
  if FocusedAccessibleObject <> nil then
    FocusedAccessibleObject.FocusedChanged(False);
end;

function TdxCustomNavBar.HasNonClientArea: Boolean;
begin
  Result := True;
end;

function TdxCustomNavBar.IsDoubleBufferedNeeded: Boolean;
begin
  Result := True;
end;

procedure TdxCustomNavBar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (Customization <> nil) and (Customization.Form = AComponent) then
    Customization.FForm := nil;
end;

procedure TdxCustomNavBar.PaintNonClientArea(ACanvas: TcxCanvas);
begin
  if ScrollBar.Visible then
    ScrollBar.Paint(ACanvas);
end;

procedure TdxCustomNavBar.ReadOriginalWidth(Reader: TReader);
begin
  FOriginalWidth := Reader.ReadInteger;
end;

procedure TdxCustomNavBar.RequestAlign;
begin
  inherited;
  Invalidate;
end;

procedure TdxCustomNavBar.SetChildOrder(Child: TComponent; Order: Integer);
var
  AChildKind: TdxNavBarChildKind;
  AOrder, I: Integer;
begin
  AOrder := Order;
  for AChildKind := Low(TdxNavBarChildKind) to High(TdxNavBarChildKind) do
    case AChildKind of
      nbckGroup:
        begin
          if Child is TdxNavBarGroup then
          begin
            TdxNavBarGroup(Child).Index := AOrder;
            Exit;
          end;
          Dec(AOrder, Groups.Count);
        end;
      nbckItem:
        begin
          if Child is TdxNavBarItem then
          begin
            TdxNavBarItem(Child).Index := AOrder;
            Exit;
          end;
          Dec(AOrder, Items.Count);
        end;
      nbckStyle:
        begin
          if Child is TdxNavBarStyleItem then
          begin
            TdxNavBarStyleItem(Child).Index := AOrder;
            Exit;
          end;
          Dec(AOrder, Styles.Count);
        end;
      nbckGroupControl:
        for I := 0 to Groups.Count - 1 do
          if Groups[I].Control <> nil then
            Dec(AOrder);
    end;
  inherited SetChildOrder(Child, Order);
end;

procedure TdxCustomNavBar.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  AChildKind: TdxNavBarChildKind;
  I: Integer;
begin
  for AChildKind := Low(TdxNavBarChildKind) to High(TdxNavBarChildKind) do
    case AChildKind of
      nbckGroup:
        for I := 0 to Groups.Count - 1 do
          if Groups[I].Owner = Root then
            Proc(Groups[I]);
      nbckItem:
        for I := 0 to Items.Count - 1 do
          if Items[I].Owner = Root then
            Proc(Items[I]);
      nbckStyle:
        for I := 0 to Styles.Count - 1 do
          if Styles[I].Owner = Root then
            Proc(Styles[I]);
      nbckGroupControl:
        for I := 0 to Groups.Count - 1 do
          if (Groups[I].Control <> nil) and (Groups[I].Control.Owner = Root) then
            Proc(Groups[I].Control);
    end;
end;

procedure TdxCustomNavBar.SetName(const NewName: TComponentName);
var
  OldName, NewItemName: string;
  I, L: Integer;

  procedure UpdateName(AComponent: TComponent);
  begin
    NewItemName := AComponent.Name;
    if Pos(OldName, NewItemName) = 1 then
    begin
      Delete(NewItemName, 1, L);
      Insert(Name, NewItemName, 1);
      try
        AComponent.Name := NewItemName;
      except
        on EComponentError do ; {Ignore rename errors }
      end;
    end;
  end;

begin
  OldName := Name;
  L := Length(OldName);
  inherited;
  if IsDesigning then
  begin
    for I := 0 to Groups.Count - 1 do
       UpdateName(Groups[I]);
    for I := 0 to Items.Count - 1 do
       UpdateName(Items[I]);
    for I := 0 to Styles.Count - 1 do
       UpdateName(Styles[I]);
  end;
end;

procedure TdxCustomNavBar.WriteOriginalWidth(Writer: TWriter);
begin
  Writer.WriteInteger(FOriginalWidth);
end;

function TdxCustomNavBar.AllowPan(AScrollKind: TScrollBarKind): Boolean;
begin
  Result := (AScrollKind = sbVertical) and ScrollBar.Visible;
end;

procedure TdxCustomNavBar.GestureScroll(ADeltaX, ADeltaY: Integer);
var
  ANewPos: Integer;
begin
  if ScrollBar.Visible then
  begin
    ANewPos := ScrollBar.Position - ADeltaY;
    if ADeltaY <> 0 then
    begin
      GestureHelper.CheckOverpan(ScrollBar.ScrollBar.Kind, ANewPos,
         ScrollBar.Min, ScrollBar.Max - ScrollBar.PageSize + 1, ADeltaX, ADeltaY);
      ScrollBar.Scroll(ScrollBar, scPosition, ANewPos);
    end;
  end;
end;

function TdxCustomNavBar.CanFocusOnClick(X, Y: Integer): Boolean;
begin
  Result := inherited CanFocusOnClick(X, Y) and Controller.CanFocusOnClick(Point(X, Y));
end;

procedure TdxCustomNavBar.DoEnter;
begin
  inherited DoEnter;
  if FocusedAccessibleObject = nil then
    FocusedAccessibleObject := IAccessibilityHelper.GetNextObjectForNavigation(
      dirNone);
end;

procedure TdxCustomNavBar.KeyDown(var Key: Word; Shift: TShiftState);

  function GetNavigationDirection: TcxDirection;
  begin
    case Key of
      VK_LEFT:
        Result := dirLeft;
      VK_UP:
        Result := dirUp;
      VK_RIGHT:
        Result := dirRight;
      VK_DOWN:
        Result := dirDown;
    else
      Result := dirNone;
    end;
  end;

  function GetNewFocusedAccessibleObject: IdxNavBarAccessibilityHelper;
  begin
    if FocusedAccessibleObject = nil then
      Result := IAccessibilityHelper.GetNextObjectForNavigation(dirDown)
    else
      Result := FocusedAccessibleObject.GetNextObjectForNavigation(
        GetNavigationDirection);
  end;

var
  ANewFocusedAccessibleObject: IdxNavBarAccessibilityHelper;
begin
  Include(FInternalState, nbisKeyDowned);
  inherited KeyDown(Key, Shift);
  if GetNavigationDirection <> dirNone then
  begin
    ANewFocusedAccessibleObject := GetNewFocusedAccessibleObject;
    if ANewFocusedAccessibleObject <> nil then
      FocusedAccessibleObject := ANewFocusedAccessibleObject;
  end
  else
    if (Key <> 0) and (FocusedAccessibleObject <> nil) then
      FocusedAccessibleObject.KeyDown(Key, Shift);
end;

procedure TdxCustomNavBar.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (Key <> #0) and (FocusedAccessibleObject <> nil) then
    FocusedAccessibleObject.KeyPress(Key);
end;

procedure TdxCustomNavBar.KeyUp(var Key: Word; Shift: TShiftState);
var
  ALinkSelf: TcxObjectLink;
begin
  inherited KeyUp(Key, Shift);
  if (nbisKeyDowned in FInternalState) and (Key <> 0) and (Key <> VK_RETURN) and
    (FocusedAccessibleObject <> nil) then
  begin
    Exclude(FInternalState, nbisKeyDowned);
    ALinkSelf := cxAddObjectLink(Self);
    try
      FocusedAccessibleObject.KeyUp(Key, Shift);
      if ALinkSelf.Ref = nil then
        Key := 0;
    finally
      cxRemoveObjectLink(ALinkSelf);
    end;
  end;
end;

function TdxCustomNavBar.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint): Boolean;
begin
  Result := Controller.MouseWheel(Shift, WheelDelta, MousePos);
end;

procedure TdxCustomNavBar.LookAndFeelChanged(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
  CheckViewReal;
  InvalidateAll(doRecalc);
end;

procedure TdxCustomNavBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  AAccessibleObject: IdxNavBarAccessibilityHelper;
begin
  if IsPtBottomScrollButton(Point(X, Y)) or IsPtTopScrollButton(Point(X, Y)) then
    AAccessibleObject := nil
  else
    AAccessibleObject := NavBarGetFocusableAccessibleObjectAtPos(
      IAccessibilityHelper, ClientToScreen(Point(X, Y)));
    
  inherited MouseDown(Button, Shift, X, Y);
{$IFDEF DELPHI14}
  Shift := Shift - [ssPen, ssTouch];
{$ENDIF}
  FSourceShift := Shift;
  FSourcePoint := Point(X, Y);
  Controller.MouseDown(Button, Shift, FSourcePoint);
  if (AAccessibleObject <> nil) and AAccessibleObject.GetHelper.IsOwnerObjectLive and
    AAccessibleObject.CanFocus(False) then
      FocusedAccessibleObject := AAccessibleObject;
end;

procedure TdxCustomNavBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ALinkSelf: TcxObjectLink;
begin
  if EnableDragging then exit;
  inherited MouseUp(Button, Shift, X, Y);
  FSourcePoint := Point(X, Y);
  ALinkSelf := cxAddObjectLink(Self);
  try
    Controller.MouseUp(Button, Shift, FSourcePoint);
    if ALinkSelf.Ref <> nil then
    begin
      FSourceShift := [];
      FPressedGroup := nil;
      FPressedLink := nil;
      FSourceGroup := nil;
      FSourceLink := nil;
    end;
  finally
    cxRemoveObjectLink(ALinkSelf);
  end;
end;

procedure TdxCustomNavBar.MouseMove(Shift: TShiftState; X, Y: Integer);

  function IsDragBegining: Boolean;
  begin
    Result := (Abs(FSourcePoint.X - X) > 3) or (Abs(FSourcePoint.Y - Y) > 3);
  end;

  function CanDrag: Boolean;
  begin
    Result := (IsAllowDragGroup and (FSourceGroup <> nil)) or
      (IsAllowDragLink and (FSourceLink <> nil) and FSourceLink.Item.Enabled);
  end;
  
begin
  dxTestCheck(Painter.IsViewInfoValid, 'MouseMove: not IsViewInfoValid');
  if IsDesigning then
    inherited MouseMove(Shift, X, Y)
  else
  begin
    FTargetPoint := Point(X, Y);
    if IsTopScrollButtonVisible or IsBottomScrollButtonVisible then
      InvalidateScrollButtons;
    if CanDrag and IsDragBegining then
    begin
      FSourceShift := [];
      Include(FInternalState, nbisDragging);
      DragMode := dmAutomatic;
      BeginDrag(True);
    end
    else
    begin
      inherited MouseMove(Shift, X, Y);
      Controller.MouseMove(Shift, FTargetPoint);
    end;
  end;
end;

procedure TdxCustomNavBar.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := False;
  FTargetPoint := Point(X, Y);
  FScrollButtonDownIsDown := False;
  FScrollButtonUpIsDown := False;
  if FPressedGroup <> nil then
  begin
    FPressedGroup := nil;
    InvalidateAll(doRedraw);
  end;
  if FPressedLink <> nil then
  begin
    FPressedLink := nil;
    InvalidateAll(doRedraw);
  end;
  if IsTopScrollButtonVisible or IsBottomScrollButtonVisible then
    InvalidateScrollButtons;
  if dxNavBarDragObject <> nil then
  begin
    dxNavBarDragObject.UpdateTargets;
    if (SourceItem <> nil) and IsAllowDropLink then
      DoItemDragOver(SourceItem, Accept)
    else if (SourceLink <> nil) and IsAllowDropLink then
      DoLinkDragOver(SourceLink, Accept)
    else if (SourceGroup <> nil) and IsAllowDropGroup then
      DoGroupDragOver(SourceGroup, Accept);
  end;
  if Assigned(OnDragOver) then
    OnDragOver(Self, Source, X, Y, State, Accept);
{$IFDEF DELPHI10}
  if (State = dsDragLeave) and
    not (WindowFromPoint(GetMouseCursorPos) = Self.Handle) then
  begin
    FTargetPoint := cxInvalidPoint;
    FHotTrackedGroup := nil;
    FHotTrackedLink := nil;
    InvalidateAll(doRecalc);
  end;
{$ENDIF}
end;

procedure TdxCustomNavBar.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited DoEndDrag(Target, X, Y);
  Customization.EndDrag(Target, X, Y);
  FreeAndNil(FDragObject);
  DragDone;
end;

type
  TdxDragObject = class(TDragControlObject)
  protected
    function GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor; override;
  end;

function TdxDragObject.GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor;
var
  Wnd: TWinControl;
begin
  Wnd := FindVCLWindow(Point(X, Y));
  if Accepted and (Wnd is TdxCustomNavBar) then
  begin
    if dxNavBarDragObject.SourceItem <> nil then
      Result := TdxCustomNavBar(Wnd).DragCopyCursor
    else Result := TdxCustomNavBar(Wnd).DragCursor;
 end
 else Result := inherited GetDragCursor(Accepted, X, Y);
end;

procedure TdxCustomNavBar.DoStartDrag(var DragObject: TDragObject);
begin
  if dxNavBarDragObject = nil then
    dxNavBarDragObject := TdxNavBarDragObject.Create(Self, DragObject {deprecated}, FSourceGroup, FSourceLink, nil);
  FDragObject := TdxDragObject.Create(Self);
  DragObject := FDragObject;
  DoLinkHotTrack(nil);
  DoGroupHotTrack(nil);
  inherited DoStartDrag(DragObject);
end;

procedure TdxCustomNavBar.DoActivateGroupTimer(Sender: TObject);
var
  Group: TdxNavBarGroup;
begin
  Group := ViewInfo.GetGroupAtCaptionPos(FTargetPoint);
  if Group = FActiveGroupCandidate then
      ViewInfo.DoGroupActivate(Group);
  FActivateGroupTimer.Enabled := False;
end;

procedure TdxCustomNavBar.DoScrollTimer(Sender: TObject);
begin
  FScrollButtonUpIsDown := IsPtTopScrollButton(TargetPoint);
  FScrollButtonDownIsDown := IsPtBottomScrollButton(TargetPoint);
  if ScrollButtonUpIsDown or ScrollButtonDownIsDown then
  begin
   if ScrollButtonUpIsDown and not (sDisabled in ViewInfo.TopScrollButtonState) then
      ActiveGroup.TopVisibleLinkIndex := ActiveGroup.TopVisibleLinkIndex - 1;
    if ScrollButtonDownIsDown and not (sDisabled in ViewInfo.BottomScrollButtonState) then
      ActiveGroup.TopVisibleLinkIndex := ActiveGroup.TopVisibleLinkIndex + 1;
  end
  else FScrollTimer.Enabled := False;
end;

procedure TdxCustomNavBar.DoGroupDragDrop(Group: TdxNavBarGroup);
begin
  if TargetGroup <> nil then
    Group.Index := TargetGroup.Index;
end;

procedure TdxCustomNavBar.DoGroupDragOver(Group: TdxNavBarGroup; var Accept: Boolean);
begin
  Accept := (Group <> TargetGroup) and (TargetGroup <> nil);
  InvalidateAll(doRedraw);
end;

procedure TdxCustomNavBar.DoGroupHotTrack(Group: TdxNavBarGroup);
begin
  if FHotTrackedGroup <> nil then
    InvalidateAll(doRecalc);
  FHotTrackedGroup := Group;
  if FHotTrackedGroup <> nil then
    InvalidateAll(doRecalc);
  if Assigned(FOnGroupHotTrack) then
    FOnGroupHotTrack(Self, FHotTrackedGroup);
end;

procedure TdxCustomNavBar.DoGroupMouseDown(Group: TdxNavBarGroup);
begin
  if not IsDesigning or (ssDouble in FSourceShift) then
  begin
    FSourceGroup := Group;
    FPressedGroup := Group;
    if Assigned(FOnGroupPress) then
      FOnGroupPress(Self, FPressedGroup);
    InvalidateAll(doRecalc);
  end
  else
    DesignerSelect(Group);
end;

procedure TdxCustomNavBar.DoGroupMouseUp(Group: TdxNavBarGroup);
begin
  if not IsDesigning or (ssDouble in FSourceShift) then
  begin
    FSourceGroup := nil;
    if Assigned(Group.OnClick) then
      Group.OnClick(Group)
    else if Assigned(FOnGroupClick) then
      FOnGroupClick(Self, Group);
    ViewInfo.DoGroupActiveToggle(Group);
    FPressedGroup := nil;
    InvalidateAll(doRecalc);
  end;
end;

procedure TdxCustomNavBar.DoLinkDragDrop(Link: TdxNavBarItemLink);
var
  AIndex: Integer;
  ASourceLink: TdxNavBarItemLink;
begin
  AIndex := TargetLinkIndex;
  if AIndex > -1 then
  begin
    if (TargetGroup = Link.Group) and (AIndex > Link.Index) then Dec(AIndex);
    if Link.Group <> TargetGroup then
    begin
      Link.Group.SelectedLinkIndex := -1;
      ASourceLink := TargetGroup.CreateLink(Link.Item);
      ASourceLink.Index := AIndex;
      Link.Group.RemoveLink(Link.Index);
    end
    else ASourceLink := Link;
    ASourceLink.Index := AIndex;
  end;
end;

procedure TdxCustomNavBar.DoLinkDragOver(Link: TdxNavBarItemLink; var Accept: Boolean);
var
  Group: TdxNavBarGroup;
begin
  Accept := True;
  if IsPtTopScrollButton(TargetPoint) or IsPtBottomScrollButton(TargetPoint) then
    FScrollTimer.Enabled := True
  else
  begin
    Group := ViewInfo.GetGroupAtCaptionPos(FTargetPoint);
    if Group <> nil then
    begin
      FActivateGroupTimer.Enabled := False;
      FActiveGroupCandidate := Group;
      FActivateGroupTimer.Enabled := True;
    end;
    Accept := (TargetGroup <> nil) and (TargetLink1 <> Link) and (TargetLink2 <> Link);
    InvalidateAll(doRedraw);
  end;
end;

procedure TdxCustomNavBar.DoLinkHotTrack(Link: TdxNavBarItemLink);
begin
  FHotTrackedLink := Link;
  InvalidateAll(doRecalc);
  Controller.DoLinkHotTrack(Self, Link);
end;

procedure TdxCustomNavBar.DoLinkMouseDown(Link: TdxNavBarItemLink);
begin
  if not IsDesigning then
  begin
    FSourceLink := Link;
    if (Link.Group.SelectedLinkIndex > -1) then
      InvalidateAll(doRecalc);
    if Link.CanSelect then
    begin
      FPressedLink := Link;
      Controller.DoLinkPress(Self, Link);
      InvalidateAll(doRecalc);
    end;
  end
  else
    DesignerSelect(Link.Item);
end;

procedure TdxCustomNavBar.DoLinkMouseUp(Link: TdxNavBarItemLink);
var
  ALinkSelf: TcxObjectLink;
begin
  FSourceLink := nil;
  if Link.CanSelect then
  begin
    ALinkSelf := cxAddObjectLink(Self);
    try
      Controller.DoLinkClick(Self, Link);
      if ALinkSelf.Ref <> nil then
      begin
        FPressedLink := nil;
        InvalidateAll(doRecalc);
      end;
    finally
      cxRemoveObjectLink(ALinkSelf);
    end;
  end;
end;

procedure TdxCustomNavBar.DoNavigationPaneCollapsed;
begin
  DoCollapseStateChanged;
  CallNotify(OnNavigationPaneCollapsed, Self);
end;

procedure TdxCustomNavBar.DoNavigationPaneExpanded;
begin
  DoCollapseStateChanged;
  CallNotify(OnNavigationPaneExpanded, Self);
end;

procedure TdxCustomNavBar.DoItemDragDrop(Item: TdxNavBarItem);
begin
  if TargetGroup <> nil then
  begin
    with TargetGroup.CreateLink(Item) do
      Index := TargetLinkIndex;
  end;
end;

procedure TdxCustomNavBar.DoItemDragOver(Item: TdxNavBarItem; var Accept: Boolean);
var
  Group: TdxNavBarGroup;
begin
  Accept := True;
  if IsPtTopScrollButton(FTargetPoint) or IsPtBottomScrollButton(FTargetPoint) then
    FScrollTimer.Enabled := True
  else
  begin
    Group := GetGroupAtCaptionPos(FTargetPoint);
    if Group <> nil then
    begin
      FActivateGroupTimer.Enabled := False;
      FActiveGroupCandidate := Group;
      FActivateGroupTimer.Enabled := True;
    end;
    Accept := TargetGroup <> nil;
    InvalidateAll(doRedraw);
  end;
end;

procedure TdxCustomNavBar.DoBottomScrollButtonDown;
begin
  if not (sDisabled in ViewInfo.BottomScrollButtonState) then
  begin
    FScrollButtonUpIsDown := False;
    FScrollButtonDownIsDown := True;
    FScrollTimer.Enabled := True;
    if Controller.DoScrollDown then
      DesignerModified;
    InvalidateScrollButtons;
  end;
end;

procedure TdxCustomNavBar.DoBottomScrollButtonUp;
begin
  FScrollButtonDownIsDown := False;
  FScrollTimer.Enabled := False;
  InvalidateScrollButtons;
end;

procedure TdxCustomNavBar.DoTopScrollButtonDown;
begin
  if not (sDisabled in ViewInfo.TopScrollButtonState) then
  begin
    FScrollButtonDownIsDown := False;
    FScrollButtonUpIsDown := True;
    FScrollTimer.Enabled := True;
    if Controller.DoScrollUp then
      DesignerModified;
    InvalidateScrollButtons;
  end;
end;

procedure TdxCustomNavBar.DoTopScrollButtonUp;
begin
  FScrollButtonUpIsDown := False;
  FScrollTimer.Enabled := False;
  InvalidateScrollButtons;
end;

procedure TdxCustomNavBar.DoUpdateScrollBarStyle;
begin
  FScrollBar.UpdateStyle;
end;

procedure TdxCustomNavBar.DoScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
  InvalidateAll(doRecalc);
  Update;
end;

function TdxCustomNavBar.DesignerIsSelected(AObject: TPersistent): Boolean;
begin
  Result := (FDesignHelper <> nil) and FDesignHelper.IsObjectSelected(Self, AObject);
end;

procedure TdxCustomNavBar.DesignerModified;
begin
  if FDesignHelper <> nil then
    FDesignHelper.Modified;
end;

procedure TdxCustomNavBar.DesignerSelect(AObject: TPersistent);
begin
  if FDesignHelper <> nil then
    FDesignHelper.SelectObject(Self, AObject, True, False);
end;

procedure TdxCustomNavBar.DesignSelectionChanged(ASelection: TList);
begin
  InvalidateAll(doRedraw);
end;

procedure TdxCustomNavBar.TranslationChanged;
begin
  InvalidateAll(doRecreate);
end;

procedure TdxCustomNavBar.OnGroupsChanged(Sender: TObject; AItem: TcxComponentCollectionItem;
  AAction: TcxComponentCollectionNotification);

  procedure DoGroupDestroying;
  begin
    if AItem = FHotTrackedGroup then
      FHotTrackedGroup := nil;
    if AItem = FPressedGroup then
      FPressedGroup := nil;
    if AItem = FActiveGroup then
      FActiveGroup := nil;
  end;

  procedure GroupsDestroying;
  begin
    FHotTrackedGroup := nil;
    FPressedGroup := nil;
    FActiveGroup := nil;
  end;


begin
  case AAction of
    ccnExtracted:
      DoGroupDestroying;
    ccnChanged:
      if Groups.Count = 0 then
        GroupsDestroying;
  end;

  Customization.RefreshItems;
  if NavigationPaneMaxVisibleGroups <> -1 then
    InvalidateAll(doRecreate)
  else
    InvalidateAll(AItem, AAction);
//  if AAction = ccnChanged then //#DG ?
//    DesignerModified;
end;

procedure TdxCustomNavBar.OnItemsChanged(Sender: TObject; AItem: TcxComponentCollectionItem;
  AAction: TcxComponentCollectionNotification);
begin
  Customization.RefreshItems;
  InvalidateAll(AItem, AAction);
end;

procedure TdxCustomNavBar.OnStylesChanged(Sender: TObject);
begin
  InvalidateAll(doRecreate);
end;

procedure TdxCustomNavBar.OnImagesChanged(Sender: TObject);
begin
  InvalidateAll(doRecreate);
end;

procedure TdxCustomNavBar.OnLinksChanged(Sender: TObject; ALink: TdxNavBarItemLink);
begin
  if FHotTrackedLink = ALink then
    FHotTrackedLink := nil;
  if FPressedLink = ALink then
    FPressedLink := nil;
end;

procedure TdxCustomNavBar.OnThemeChanged;
begin
  if FPainter.Reregistered then
    ViewStyle := CreatePainter
  else
  begin
    ViewInfo.RefreshColors;
    InvalidateAll(doRecreate);
  end;
end;

procedure TdxCustomNavBar.DoActiveGroupChanged;
begin
  if not IsLoading and not IsDestroying then
    CallNotify(OnActiveGroupChanged, Self);
end;

procedure TdxCustomNavBar.DoActiveGroupChanging(ANewGroup: TdxNavBarGroup; var AAllowChange: Boolean);
begin
  if not IsLoading and not IsDestroying and Assigned(OnActiveGroupChanging) then
    OnActiveGroupChanging(Self, ANewGroup, AAllowChange);
end;

procedure TdxCustomNavBar.DoCollapseStateChanged;
begin
  CallNotify(OnCollapseStateChanged, Self);
end;

procedure TdxCustomNavBar.Paint;
begin
  Painter.Paint;
end;

procedure TdxCustomNavBar.InitiateAction;
begin
  inherited;
  Groups.InitiateActions;
end;

procedure TdxCustomNavBar.Invalidate;
begin
  if FPainter <> nil then
    Painter.InvalidateViewInfo(doRedraw);
  inherited Invalidate;
end;

procedure TdxCustomNavBar.InvalidateAll(AType: TdxNavBarChangeType);

  procedure InvalidateWithChildren;
  begin
    if HandleAllocated then
    begin
      if AType = doRecreate then
        RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ALLCHILDREN); 
      Invalidate;
    end;
  end;

begin
  if not IsLoading and not IsDestroying then
  begin
    if FPainter <> nil then
    begin
      Painter.InvalidateViewInfo(AType);
      Painter.CheckDrawParamChanges;
    end;
    InvalidateWithChildren;
  end;
end;

procedure TdxCustomNavBar.InvalidateAll(AItem: TcxComponentCollectionItem;
  AAction: TcxComponentCollectionNotification);

  function GetUpdateType(AItem: TcxComponentCollectionItem;
    AAction: TcxComponentCollectionNotification): TdxNavBarChangeType;
  begin
    if (AItem <> nil) and (AAction = ccnChanged) then
      Result := doRecalc
    else
      Result := doRecreate;
  end;

begin
  InvalidateAll(GetUpdateType(AItem, AAction));
end;

procedure TdxCustomNavBar.InvalidateScrollButtons;
begin
  if IsDestroying then exit;
  if HandleAllocated then Painter.InvalidateScrollButtons;
end;

procedure TdxCustomNavBar.LoadFromRegIni(AStorage: TCustomIniFile; LoadStyles: Boolean);

  procedure ReadStyle(AIndex: Integer);
  var
    ASection, ABuffer, AText: string;
    AStream: TStringStream;
    AGraphicClass: TGraphicClass;
    AGraphic: TGraphic;
    AStyleItem: TdxNavBarStyleItem;
  begin
    with AStorage do
    begin
      ASection := 'Style' + IntToStr(AIndex);
      AStyleItem := Styles.Add;
      with AStyleItem.Style do
      begin
        BackColor := ReadInteger(ASection, 'BackColor', BackColor);
        BackColor2 := ReadInteger(ASection, 'BackColor2', BackColor2);
        AlphaBlending := ReadInteger(ASection, 'AlphaBlending', AlphaBlending);
        AlphaBlending2 := ReadInteger(ASection, 'AlphaBlending2', AlphaBlending2);
        Font.Charset := ReadInteger(ASection, 'FontCharset', Font.Charset);
        Font.Color := ReadInteger(ASection, 'FontColor', Font.Color);
        Font.Height :=ReadInteger(ASection, 'FontHeight', Font.Height);
        Font.Name := ReadString(ASection, 'FontName', Font.Name);
        Font.Pitch := TFontPitch(ReadInteger(ASection, 'FontPitch', Integer(Font.Pitch)));
        Font.Size := ReadInteger(ASection, 'FontSize', Font.Size);
        if ReadBool(ASection, 'FontStyleBold', fsBold in Font.Style) then
          Font.Style := Font.Style + [fsBold];
        if ReadBool(ASection, 'FontStyleItalic', fsItalic in Font.Style) then
          Font.Style := Font.Style + [fsItalic];
        if ReadBool(ASection, 'FontStyleUnderline', fsUnderline in Font.Style) then
          Font.Style := Font.Style + [fsUnderline];
        if ReadBool(ASection, 'FontStyleStrikeOut', fsStrikeOut in Font.Style) then
          Font.Style := Font.Style + [fsStrikeOut];
        GradientMode := TdxBarStyleGradientMode(ReadInteger(ASection, 'GradientMode', Integer(GradientMode)));
        if ValueExists(ASection, 'Image') then
        begin
          AText := ReadString(ASection, 'Image', '');
          SetLength(ABuffer, Length(AText) div 2);
          HexToBin(PChar(AText), PChar(ABuffer), Length(AText) div 2);
          AStream := TStringStream.Create(ABuffer);
          try
            AStream.Position := 0;
            AGraphicClass := TGraphicClass(GetClass(ReadString(ASection, 'ImageClass', '')));
            if AGraphicClass <> nil then
            begin
              AGraphic := AGraphicClass.Create;
              try
                AGraphic.LoadFromStream(AStream);
                Image.Graphic := AGraphic;
              finally
                AGraphic.Free;
              end;
            end;
          finally
            AStream.Free;
          end;
        end;
        HAlignment := TdxBarStyleHAlignment(ReadInteger(ASection, 'HAlignment', Integer(HAlignment)));
        VAlignment := TdxBarStyleVAlignment(ReadInteger(ASection, 'VAlignment', Integer(VAlignment)));
        AStyleItem.Tag := ReadInteger(ASection, 'Tag', AStyleItem.Tag);
      end;
    end;
  end;

  function GetCustomItem(ACollection: TdxNavBarCustomItems; const ASection: string): TdxNavBarCustomItem;
  var
    AItemIdentifier: string;
  begin
    Result := nil;
    AItemIdentifier := AStorage.ReadString(ASection, 'Name', '');
    if AItemIdentifier <> '' then
      Result := TdxNavBarCustomItem(ACollection.ItemByName(AItemIdentifier))
    else
    begin
      AItemIdentifier := AStorage.ReadString(ASection, 'Caption', '');
      if AItemIdentifier <> '' then
        Result := ACollection.ItemByCaption(AItemIdentifier);
    end;
    if Result = nil then
      Result := ACollection.Add;
  end;

  procedure ReadItem(AIndex: Integer);
  var
    AItem: TdxNavBarItem;
    ASection: string;
  begin
    ASection := 'Item' + IntToStr(AIndex);
    AItem := TdxNavBarItem(GetCustomItem(Items, ASection));
    AItem.Caption := AStorage.ReadString(ASection, 'Caption', AItem.Caption);
    AItem.Enabled := AStorage.ReadBool(ASection, 'Enabled', AItem.Enabled);
    AItem.Hint := AStorage.ReadString(ASection, 'Hint', AItem.Hint);
    AItem.LargeImageIndex := AStorage.ReadInteger(ASection, 'LargeImageIndex',
      AItem.LargeImageIndex);
    AItem.SmallImageIndex := AStorage.ReadInteger(ASection, 'SmallImageIndex',
      AItem.SmallImageIndex);
    if LoadStyles and (Styles.Count > 0) then
    begin
      if AStorage.ValueExists(ASection, 'StyleStyleIndex') then
        AItem.Style := Styles[AStorage.ReadInteger(ASection, 'StyleStyleIndex', 0)];
      if AStorage.ValueExists(ASection, 'StyleDisabledStyleIndex') then
        AItem.StyleDisabled := Styles[AStorage.ReadInteger(ASection, 'StyleDisabledStyleIndex', 0)];
      if AStorage.ValueExists(ASection, 'StyleHotTrackedStyleIndex') then
        AItem.StyleHotTracked := Styles[AStorage.ReadInteger(ASection, 'StyleHotTrackedStyleIndex', 0)];
      if AStorage.ValueExists(ASection, 'StylePressedStyleIndex') then
        AItem.StylePressed := Styles[AStorage.ReadInteger(ASection, 'StylePressedStyleIndex', 0)];
    end;
    AItem.Tag := AStorage.ReadInteger(ASection, 'Tag', AItem.Tag);
    AItem.Visible := AStorage.ReadBool(ASection, 'Visible', AItem.Visible);
    if AItem.Action <> nil then
      TdxNavBarItemAccess(AItem).ActionChange(AItem.Action, False);
  end;
  
  procedure ReadGroup(AIndex: Integer);
  var
    J, ALinkCount: Integer;
    ASection: string;
    AGroup: TdxNavBarGroup;
    AUseControl: Boolean;
    AControlName: string;
    AControl: TCustomControl;
    AItemIndex: Integer;
  begin
    ASection := 'Group' + IntToStr(AIndex);
    AGroup := TdxNavBarGroup(GetCustomItem(Groups, ASection));
    with AGroup do
    begin
      Caption := AStorage.ReadString(ASection, 'Caption', Caption);
      Expanded := AStorage.ReadBool(ASection, 'Expanded', Expanded);
      Hint := AStorage.ReadString(ASection, 'Hint', Hint);
      LargeImageIndex := AStorage.ReadInteger(ASection, 'LargeImageIndex', LargeImageIndex);
      LinksUseSmallImages := AStorage.ReadBool(ASection, 'LinksUseSmallImages', LinksUseSmallImages);
      ClearLinks;
      ALinkCount := AStorage.ReadInteger(ASection, 'LinkCount', 0);
      for J := 0 to ALinkCount - 1 do
      begin
        AItemIndex :=
          AStorage.ReadInteger(ASection, 'Link' + IntToStr(J) + 'ItemIndex', -1);
        if (AItemIndex >= 0) and (AItemIndex < Items.Count) then
          CreateLink(Items[AItemIndex]);
      end;
      SelectedLinkIndex := AStorage.ReadInteger(ASection, 'SelectedLinkIndex', SelectedLinkIndex);
      ShowAsIconView := AStorage.ReadBool(ASection, 'ShowAsIconView', ShowAsIconView);
      ShowExpandButton := AStorage.ReadBool(ASection, 'ShowExpandButton', ShowExpandButton);
      SmallImageIndex := AStorage.ReadInteger(ASection, 'SmallImageIndex', SmallImageIndex);
      if LoadStyles and (Styles.Count > 0) then
      begin
        if AStorage.ValueExists(ASection, 'StyleBackgroundStyleIndex') then
          StyleBackground := Styles[AStorage.ReadInteger(ASection, 'StyleBackgroundStyleIndex', 0)];
        if AStorage.ValueExists(ASection, 'StyleHeaderStyleIndex') then
          StyleHeader := Styles[AStorage.ReadInteger(ASection, 'StyleHeaderStyleIndex', 0)];
        if AStorage.ValueExists(ASection, 'StyleHeaderActiveStyleIndex') then
          StyleHeaderActive := Styles[AStorage.ReadInteger(ASection, 'StyleHeaderActiveStyleIndex', 0)];
        if AStorage.ValueExists(ASection, 'StyleHeaderHotTrackedStyleIndex') then
          StyleHeaderHotTracked := Styles[AStorage.ReadInteger(ASection, 'StyleHeaderHotTrackedStyleIndex', 0)];
        if AStorage.ValueExists(ASection, 'StyleHeaderPressedStyleIndex') then
          StyleHeaderPressed := Styles[AStorage.ReadInteger(ASection, 'StyleHeaderPressedStyleIndex', 0)];
      end;
      Tag := AStorage.ReadInteger(ASection, 'Tag', Tag);
      TopVisibleLinkIndex := AStorage.ReadInteger(ASection, 'TopVisibleLinkIndex', TopVisibleLinkIndex);
      UseSmallImages := AStorage.ReadBool(ASection, 'UseSmallImages', UseSmallImages);
      Visible := AStorage.ReadBool(ASection, 'Visible', Visible);

      AUseControl := AStorage.ReadBool(ASection, 'UseControl', UseControl);
      if AUseControl then
      begin
        AControlName := AStorage.ReadString(ASection, 'ControlName', '');
        AControl := TCustomControl(Owner.FindComponent(AControlName));
        if AControl is TdxNavBarGroupControl then
        begin
          AGroup.AcceptControl(AControl as TdxNavBarGroupControl);
          UseControl := AUseControl;
          ShowControl := AStorage.ReadBool(ASection, 'ShowControl', ShowControl);
        end;
      end;
      if Control = nil then
        UseControl := False;
    end;
    AGroup.Index := AIndex;
  end;

type
  TdxNavBarGroupControlState = record
    Group: TdxNavBarGroup;
    Control: TdxNavBarGroupControl;
  end;

var
  AActiveGroupIndex, ACount, I: Integer;
  AGroup: TdxNavBarGroup;
  AGroupControl: TdxNavBarGroupControl;
  AGroupControlStates: array of TdxNavBarGroupControlState;
begin
  View := AStorage.ReadInteger('Layout', 'View', View);

  if LoadStyles and AStorage.ValueExists('Layout', 'StyleCount') then
  begin
    Styles.Clear;
    ACount := AStorage.ReadInteger('Layout', 'StyleCount', Styles.Count);
    for I := 0 to ACount - 1 do
      ReadStyle(I);
  end;

  if AStorage.ValueExists('Layout', 'ItemCount') then
  begin
    ACount := AStorage.ReadInteger('Layout', 'ItemCount', Items.Count);
    for I := 0 to ACount - 1 do
      ReadItem(I);
  end;

  if AStorage.ValueExists('Layout', 'GroupCount') then
  begin
      for I := 0 to Groups.Count - 1 do
        if Groups[I].UseControl and (Groups[I].Control <> nil) then
        begin
          SetLength(AGroupControlStates, Length(AGroupControlStates) + 1);
          with AGroupControlStates[High(AGroupControlStates)] do
          begin
            Group := Groups[I];
            Control := Groups[I].Control;
          end;
          Groups[I].ReleaseControl;
        end;
      ACount := AStorage.ReadInteger('Layout', 'GroupCount', Groups.Count);

      for I := 0 to ACount - 1 do
        ReadGroup(I);
      for I := 0 to High(AGroupControlStates) do
      begin
        AGroupControl := AGroupControlStates[I].Control;
        AGroup := AGroupControlStates[I].Group;
        if AGroupControl.Group = nil then
          if AGroup.UseControl and (AGroup.Control = nil) then
            AGroup.AcceptControl(AGroupControl)
          else
            AGroupControl.Free;
      end;
  end;
  AActiveGroupIndex := AStorage.ReadInteger('Layout', 'ActiveGroup', ActiveGroupIndex);
  if (0 <= AActiveGroupIndex) and (AActiveGroupIndex < Groups.Count) then
    ActiveGroupIndex := AActiveGroupIndex;
  NavigationPaneMaxVisibleGroups := AStorage.ReadInteger('Layout',
    'NavigationPaneMaxVisibleGroups', NavigationPaneMaxVisibleGroups);

  if LoadStyles and (Styles.Count > 0) then
  begin
    if AStorage.ValueExists('Layout', 'StyleBackgroundStyleIndex') then
      StyleBackground := Styles[AStorage.ReadInteger('Layout', 'StyleBackgroundStyleIndex', 0)];
    if AStorage.ValueExists('Layout', 'StyleButtonStyleIndex') then
      StyleButton := Styles[AStorage.ReadInteger('Layout', 'StyleButtonStyleIndex', 0)];
    if AStorage.ValueExists('Layout', 'StyleButtonHotTrackedStyleIndex') then
      StyleButtonHotTracked := Styles[AStorage.ReadInteger('Layout', 'StyleButtonHotTrackedStyleIndex', 0)];
    if AStorage.ValueExists('Layout', 'StyleButtonPressedStyleIndex') then
      StyleButtonPressed := Styles[AStorage.ReadInteger('Layout', 'StyleButtonPressedStyleIndex', 0)];
    if AStorage.ValueExists('Layout', 'StyleDropTargetGroupStyleIndex') then
      StyleDropTargetGroup := Styles[AStorage.ReadInteger('Layout', 'StyleDropTargetGroupStyleIndex', 0)];
    if AStorage.ValueExists('Layout', 'StyleDropTargetLinkStyleIndex') then
      StyleDropTargetLink := Styles[AStorage.ReadInteger('Layout', 'StyleDropTargetLinkStyleIndex', 0)];
    if AStorage.ValueExists('Layout', 'StyleHintStyleIndex') then
      StyleHint := Styles[AStorage.ReadInteger('Layout', 'StyleHintPressedStyleIndex', 0)];
    if AStorage.ValueExists('Layout', 'StyleNavigationPaneHeaderStyleIndex') then
      StyleNavigationPaneHeader := Styles[AStorage.ReadInteger('Layout', 'StyleNavigationPaneHeaderStyleIndex', 0)];
  end;
end;

procedure TdxCustomNavBar.SaveToRegIni(AStorage: TCustomIniFile; SaveStyles: Boolean);

  procedure WriteStyle(AStyleItem: TdxNavBarStyleItem);
  var
    ASection, AText: string;
    AStream: TStringStream;
  begin
    with AStorage do
    begin
      ASection := 'Style' + IntToStr(AStyleItem.Index);
      with AStyleItem.Style do
      begin
        if savBackColor in AssignedValues then
          WriteInteger(ASection, 'BackColor', BackColor);
        if savBackColor2 in AssignedValues then
          WriteInteger(ASection, 'BackColor2', BackColor2);
        if savAlphaBlending in AssignedValues then
          WriteInteger(ASection, 'AlphaBlending', AlphaBlending);
        if savAlphaBlending2 in AssignedValues then
          WriteInteger(ASection, 'AlphaBlending2', AlphaBlending2);
        if savFont in AssignedValues then
        begin
          WriteInteger(ASection, 'FontCharset', Integer(Font.Charset));
          WriteInteger(ASection, 'FontColor', Font.Color);
          WriteInteger(ASection, 'FontHeight', Font.Height);
          WriteString(ASection, 'FontName', Font.Name);
          WriteInteger(ASection, 'FontPitch', Integer(Font.Pitch));
          WriteInteger(ASection, 'FontSize', Font.Size);
          WriteBool(ASection, 'FontStyleBold', fsBold in Font.Style);
          WriteBool(ASection, 'FontStyleItalic', fsItalic in Font.Style);
          WriteBool(ASection, 'FontStyleUnderline', fsUnderline in Font.Style);
          WriteBool(ASection, 'FontStyleStrikeOut', fsStrikeOut in Font.Style);
        end;
        if savGradientMode in AssignedValues then
          WriteInteger(ASection, 'GradientMode', Integer(GradientMode));
        if (savImage in AssignedValues) and (Image.Graphic <> nil) and
          not Image.Graphic.Empty then
        begin
          AStream := TStringStream.Create('');
          try
            Image.Graphic.SaveToStream(AStream);
            AStream.Position := 0;
            SetLength(AText, Length(AStream.DataString) * 2);
            BinToHex(PChar(AStream.DataString), PChar(AText), Length(AStream.DataString));
            WriteString(ASection, 'ImageClass', Image.Graphic.ClassName);
            WriteString(ASection, 'Image', AText);
          finally
            AStream.Free;
          end;
        end;
        if savHAlignment in AssignedValues then
          WriteInteger(ASection, 'HAlignment', Integer(HAlignment));
        if savVAlignment in AssignedValues then
          WriteInteger(ASection, 'VAlignment', Integer(VAlignment));
        WriteInteger(ASection, 'Tag', AStyleItem.Tag);
      end;
    end;
  end;
  
  procedure WriteItem(AItem: TdxNavBarItem);
  var
    ASection: string;
  begin
    ASection := 'Item' + IntToStr(AItem.Index);
    AStorage.WriteString(ASection, 'Caption', AItem.Caption);
    AStorage.WriteBool(ASection, 'Enabled', AItem.Enabled);
    AStorage.WriteString(ASection, 'Hint', AItem.Hint);
    AStorage.WriteInteger(ASection, 'LargeImageIndex', AItem.LargeImageIndex);
    AStorage.WriteString(ASection, 'Name', AItem.Name);
    AStorage.WriteInteger(ASection, 'SmallImageIndex', AItem.SmallImageIndex);
    if SaveStyles and (Styles.Count > 0) then
    begin
      if AItem.Style <> nil then
        AStorage.WriteInteger(ASection, 'StyleStyleIndex', AItem.Style.Index);
      if AItem.StyleDisabled <> nil then
        AStorage.WriteInteger(ASection, 'StyleDisabledStyleIndex', AItem.StyleDisabled.Index);
      if AItem.StyleHotTracked <> nil then
        AStorage.WriteInteger(ASection, 'StyleHotTrackedStyleIndex', AItem.StyleHotTracked.Index);
      if AItem.StylePressed <> nil then
        AStorage.WriteInteger(ASection, 'StylePressedStyleIndex', AItem.StylePressed.Index);
    end;
    AStorage.WriteInteger(ASection, 'Tag', AItem.Tag);
    AStorage.WriteBool(ASection, 'Visible', AItem.Visible);
  end;
  
  procedure WriteGroup(AGroup: TdxNavBarGroup);
  var
    J: Integer;
    ASection: string;
  begin
    with AStorage do
    begin
      ASection := 'Group' + IntToStr(AGroup.Index);
      with AGroup do
      begin
        WriteString(ASection, 'Caption', Caption);
        WriteBool(ASection, 'Expanded', Expanded);
        WriteString(ASection, 'Hint', Hint);
        WriteInteger(ASection, 'LargeImageIndex', LargeImageIndex);
        WriteInteger(ASection, 'LinkCount', LinkCount);
        for J := 0 to LinkCount - 1 do
          if Links[J].Item <> nil then
            WriteInteger(ASection, 'Link' + IntToStr(J) + 'ItemIndex', Links[J].Item.Index);
        WriteBool(ASection, 'LinksUseSmallImages', LinksUseSmallImages);
        WriteString(ASection, 'Name', Name);
        WriteInteger(ASection, 'SelectedLinkIndex', SelectedLinkIndex);
        WriteBool(ASection, 'ShowControl', ShowControl);
        WriteBool(ASection, 'ShowAsIconView', ShowAsIconView);
        WriteBool(ASection, 'ShowExpandButton', ShowExpandButton);
        WriteInteger(ASection, 'SmallImageIndex', SmallImageIndex);
        if SaveStyles and (Styles.Count > 0) then
        begin
          if StyleBackground <> nil then
            WriteInteger(ASection, 'StyleBackgroundStyleIndex', StyleBackground.Index);
          if StyleHeader <> nil then
            WriteInteger(ASection, 'StyleHeaderStyleIndex', StyleHeader.Index);
          if StyleHeaderActive <> nil then
            WriteInteger(ASection, 'StyleHeaderActiveStyleIndex', StyleHeaderActive.Index);
          if StyleHeaderHotTracked <> nil then
            WriteInteger(ASection, 'StyleHeaderHotTrackedStyleIndex', StyleHeaderHotTracked.Index);
          if StyleHeaderPressed <> nil then
            WriteInteger(ASection, 'StyleHeaderPressedStyleIndex', StyleHeaderPressed.Index);
        end;
        WriteInteger(ASection, 'Tag', Tag);
        WriteInteger(ASection, 'TopVisibleLinkIndex', TopVisibleLinkIndex);
        WriteBool(ASection, 'UseSmallImages', UseSmallImages);
        WriteBool(ASection, 'Visible', Visible);

        WriteBool(ASection, 'UseControl', UseControl);
        if UseControl then
        begin
          WriteBool(ASection, 'ShowControl', ShowControl);
          if Control <> nil then
            WriteString(ASection, 'ControlName', Control.Name);
        end;
      end;
    end;
  end;
  
var
  I: Integer;
  ASections: TStringList;
begin
  with AStorage do
  begin
    ASections := TStringList.Create;
    try
      ReadSections(ASections);
      for I := 0 to ASections.Count - 1 do
        if (Pos('Layout', ASections[I]) > 0) or (Pos('Group', ASections[I]) > 0) or
          (Pos('Item', ASections[I]) > 0) or (Pos('Style', ASections[I]) > 0) then
        EraseSection(ASections[I]);
    finally
      ASections.Free;
    end;

    WriteInteger('Layout', 'View', View);
    if SaveStyles then
    begin
      WriteInteger('Layout', 'StyleCount', Styles.Count);
      for I := 0 to Styles.Count - 1 do
        WriteStyle(Styles[I]);
    end;
    WriteInteger('Layout', 'ItemCount', Items.Count);
    for I := 0 to Items.Count - 1 do
      WriteItem(Items[I]);
    WriteInteger('Layout', 'GroupCount', Groups.Count);
    for I := 0 to Groups.Count - 1 do
      WriteGroup(Groups[I]);
    if SaveStyles and (Styles.Count > 0) then
    begin
      if StyleBackground <> nil then
        WriteInteger('Layout', 'StyleBackgroundStyleIndex', StyleBackground.Index);
      if StyleButton <> nil then
        WriteInteger('Layout', 'StyleButtonStyleIndex', StyleButton.Index);
      if StyleButtonHotTracked <> nil then
        WriteInteger('Layout', 'StyleButtonHotTrackedStyleIndex', StyleButtonHotTracked.Index);
      if StyleButtonPressed <> nil then
        WriteInteger('Layout', 'StyleButtonPressedStyleIndex', StyleButtonPressed.Index);
      if StyleDropTargetGroup <> nil then
        WriteInteger('Layout', 'StyleDropTargetGroupStyleIndex', StyleDropTargetGroup.Index);
      if StyleDropTargetLink <> nil then
        WriteInteger('Layout', 'StyleDropTargetLinkStyleIndex', StyleDropTargetLink.Index);
      if StyleHint <> nil then
        WriteInteger('Layout', 'StyleHintStyleIndex', StyleHint.Index);
      if StyleNavigationPaneHeader <> nil then
        WriteInteger('Layout', 'StyleNavigationPaneHeaderStyleIndex', StyleNavigationPaneHeader.Index);
    end;
    WriteInteger('Layout', 'ActiveGroup', ActiveGroupIndex);
    WriteInteger('Layout', 'NavigationPaneMaxVisibleGroups', NavigationPaneMaxVisibleGroups);
  end;
end;

function TdxCustomNavBar.CreatePainter: TdxNavBarPainter;
begin
  Result := dxNavBarViewsFactory.PainterClasses[dxNavBarViewsFactory.IndexOfID(GetViewReal)].Create(Self);
end;

function TdxCustomNavBar.GetAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass;
begin
  Result := TdxNavBarAccessibilityHelper;
end;

function TdxCustomNavBar.GetCustomizationClass: TdxNavBarCustomizationClass;
begin
  Result := TdxNavBarCustomization;
end;

function TdxCustomNavBar.GetGroupClass: TdxNavBarGroupClass;
begin
  Result := TdxNavBarGroup;
end;

function TdxCustomNavBar.GetItemClass: TdxNavBarItemClass;
begin
  Result := TdxNavBarItem;
end;

function TdxCustomNavBar.IsCollapsed: Boolean;
begin
  Result := OptionsBehavior.NavigationPane.Collapsed and ViewInfo.CanCollapse;
end;

function TdxCustomNavBar.GetMasterNavBar: TdxCustomNavBar;
begin
  Result := nil;
end;

function TdxCustomNavBar.IsInternal: Boolean;
begin
  Result := GetMasterNavBar <> nil;
end;

function TdxCustomNavBar.GetController: TdxNavBarController;
begin
  Result := Painter.Controller;
end;

function TdxCustomNavBar.GetPainter: TdxNavBarPainter;
begin
  if FPainter = nil then
    FPainter := CreatePainter;
  Result := FPainter;
end;

function TdxCustomNavBar.GetViewInfo: TdxNavBarViewInfo;
begin
  if Painter <> nil then
    Result := Painter.ViewInfo
  else
    Result := nil;
end;

function TdxCustomNavBar.GetActiveGroup: TdxNavBarGroup;
var
  I: Integer;
  AGroup: TdxNavBarGroup;
begin
  if (Groups = nil) or (Groups.Count = 0) then
    Result := nil
  else if (FActiveGroup = nil) or not FActiveGroup.Visible then
  begin
    AGroup := nil;
    for I := 0 to Groups.Count - 1 do
      if Groups[I].Visible then
      begin
        AGroup := Groups[I];
        break;
      end;
    if FActiveGroup = nil then
      FActiveGroup := AGroup;
    Result := AGroup;
  end
  else Result := FActiveGroup;
end;

function TdxCustomNavBar.GetActiveGroupIndex: Integer;
begin
  if ActiveGroup <> nil then
    Result := ActiveGroup.Index
  else Result := -1;
end;

function TdxCustomNavBar.GetNavigationPaneOverflowPanelItemCount: Integer;
begin
  if IsLoading then
    Result := 0
  else
    if NavigationPaneMaxVisibleGroups = -1 then
      Result := 0
    else
      Result := Max(0, VisibleGroupCount - NavigationPaneMaxVisibleGroups);
end;

function TdxCustomNavBar.GetEnableDragging: Boolean;
begin
  Result := (dxNavBarDragObject <> nil) or (nbisDragging in FInternalState);
end;

function TdxCustomNavBar.GetIAccessibilityHelper: IdxNavBarAccessibilityHelper;
begin
// Requires
  Assert(not (IsDestroying and (FIAccessibilityHelper = nil)));
//
  if FIAccessibilityHelper = nil then
    FIAccessibilityHelper := NavBarGetAccessibilityHelper(
      GetAccessibilityHelperClass.Create(Self, Self));
  Result := FIAccessibilityHelper;
end;

function TdxCustomNavBar.GetScrollPosition: Integer;
begin
  if (FScrollBar <> nil) and FScrollBar.Visible then
    Result := FScrollBar.Position
  else Result := 0;
end;

function TdxCustomNavBar.GetSourceGroup: TdxNavBarGroup;
begin
  if EnableDragging and (dxNavBarDragObject <> nil) then
    Result := dxNavBarDragObject.SourceGroup
  else Result := FSourceGroup;
end;

function TdxCustomNavBar.GetSourceLink: TdxNavBarItemLink;
begin
  if EnableDragging and (dxNavBarDragObject <> nil) then
    Result := dxNavBarDragObject.SourceLink
  else Result := FSourceLink;
end;

function TdxCustomNavBar.GetSourceItem: TdxNavBarItem;
begin
  if EnableDragging and (dxNavBarDragObject <> nil) then
    Result := dxNavBarDragObject.SourceItem
  else Result := nil;
end;

function TdxCustomNavBar.GetTargetGroup: TdxNavBarGroup;
begin
  if dxNavBarDragObject <> nil then
    Result := dxNavBarDragObject.TargetGroup
  else Result := nil;
end;

function TdxCustomNavBar.GetTargetLink1: TdxNavBarItemLink;
begin
  if dxNavBarDragObject <> nil then
    Result := dxNavBarDragObject.TargetLink1
  else Result := nil;
end;

function TdxCustomNavBar.GetTargetLink2: TdxNavBarItemLink;
begin
  if dxNavBarDragObject <> nil then
    Result := dxNavBarDragObject.TargetLink2
  else Result := nil;
end;

function TdxCustomNavBar.GetTargetLinkIndex: Integer;
begin
  if dxNavBarDragObject <> nil then
    Result := dxNavBarDragObject.TargetLinkIndex
  else Result := -1;
end;

function TdxCustomNavBar.GetVisibleGroupCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Groups.Count - 1 do
    if Groups[I].Visible then Inc(Result);
end;

procedure TdxCustomNavBar.SetActiveGroup(Value: TdxNavBarGroup);
var
  AAllowChanging: Boolean;
begin
  if FActiveGroup <> Value then
  begin
    AAllowChanging := True;
    DoActiveGroupChanging(Value, AAllowChanging);
    if AAllowChanging then
    begin
      FActiveGroup := Value;
      InvalidateAll(doRecreate);
      DoActiveGroupChanged;
    end;
  end;
end;

procedure TdxCustomNavBar.SetActiveGroupIndex(Value: Integer);
begin
  if not IsLoading then
  begin
    if (0 <= Value) and (Value < Groups.Count) then
      ActiveGroup := Groups[Value];
  end
  else FActiveGroupIndex := Value;
end;

procedure TdxCustomNavBar.SetBorderStyle(const Value: TBorderStyle);
begin
  if BorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TdxCustomNavBar.SetFocusedAccessibleObject(
  Value: IdxNavBarAccessibilityHelper);

  function GetAccessibilityHelper(
    AAccessibleObject: IdxNavBarAccessibilityHelper): TdxNavBarAccessibilityHelper;
  begin
    if AAccessibleObject <> nil then
      Result := TdxNavBarAccessibilityHelper(AAccessibleObject.GetHelper)
    else
      Result := nil;
  end;

var
  APrevFocusedAccessibleObject: IdxNavBarAccessibilityHelper;
begin
  if GetAccessibilityHelper(FFocusedAccessibleObject) <>
    GetAccessibilityHelper(Value) then
  begin
    APrevFocusedAccessibleObject := FFocusedAccessibleObject;
    FFocusedAccessibleObject := Value;
    if APrevFocusedAccessibleObject <> nil then
      APrevFocusedAccessibleObject.FocusedChanged(True);
    if FFocusedAccessibleObject <> nil then
      FFocusedAccessibleObject.FocusedChanged(True);
  end;
end;

function TdxCustomNavBar.GetDragCopyCursor: TCursor;
begin
  Result := Cursors.DragCopyCursor;
end;

function TdxCustomNavBar.GetHotTrackedGroupCursor: TCursor;
begin
  Result := Cursors.HotTrackedGroupCursor;
end;

function TdxCustomNavBar.GetHotTrackedLinkCursor: TCursor;
begin
  Result := Cursors.HotTrackedLinkCursor;
end;

procedure TdxCustomNavBar.SetCursors(Value: TdxNavBarCursors);
begin
  FCursors.Assign(Value);
end;

procedure TdxCustomNavBar.SetDragCopyCursor(Value: TCursor);
begin
  Cursors.DragCopyCursor := Value;
end;

procedure TdxCustomNavBar.SetHotTrackedGroupCursor(Value: TCursor);
begin
  Cursors.HotTrackedGroupCursor := Value;
end;

procedure TdxCustomNavBar.SetHotTrackedLinkCursor(Value: TCursor);
begin
  Cursors.HotTrackedLinkCursor := Value;
end;

function TdxCustomNavBar.GetNavigationPaneMaxVisibleGroups: Integer;
begin
  Result := OptionsView.NavigationPane.MaxVisibleGroups;
end;

function TdxCustomNavBar.GetNavigationPaneOverflowPanelUseSmallImages: Boolean;
begin
  Result := OptionsView.NavigationPane.OverflowPanelUseSmallImages;
end;

function TdxCustomNavBar.GetShowNavigationPaneOverflowPanelHints: Boolean;
begin
  Result := OptionsBehavior.NavigationPane.ShowOverflowPanelHints;
end;

procedure TdxCustomNavBar.SetNavigationPaneMaxVisibleGroups(Value: Integer);
begin
  OptionsView.NavigationPane.MaxVisibleGroups := Value;
end;

procedure TdxCustomNavBar.SetNavigationPaneOverflowPanelUseSmallImages(const Value: Boolean);
begin
  OptionsView.NavigationPane.OverflowPanelUseSmallImages := Value;
end;

procedure TdxCustomNavBar.SetShowNavigationPaneOverflowPanelHints(const Value: Boolean);
begin
  OptionsBehavior.NavigationPane.ShowOverflowPanelHints := Value;
end;

function TdxCustomNavBar.GetDragDropFlags: TdxNavBarDragDropFlags;
begin
  Result := OptionsBehavior.Common.DragDropFlags;
end;

function TdxCustomNavBar.GetShowGroupsHint: Boolean;
begin
  Result := OptionsBehavior.Common.ShowGroupsHint;
end;

function TdxCustomNavBar.GetShowLinksHint: Boolean;
begin
  Result := OptionsBehavior.Common.ShowLinksHint;
end;

procedure TdxCustomNavBar.SetOptionsBehavior(Value: TdxNavBarBehaviorOptions);
begin
  FOptionsBehavior.Assign(Value);
end;

procedure TdxCustomNavBar.SetDragDropFlags(Value: TdxNavBarDragDropFlags);
begin
  OptionsBehavior.Common.DragDropFlags := Value;
end;

procedure TdxCustomNavBar.SetShowGroupsHint(const Value: Boolean);
begin
  OptionsBehavior.Common.ShowGroupsHint := Value;
end;

procedure TdxCustomNavBar.SetShowLinksHint(const Value: Boolean);
begin
  OptionsBehavior.Common.ShowLinksHint := Value;
end;

procedure TdxCustomNavBar.CheckViewReal;
var
  AViewReal: Integer;
begin
  AViewReal := FViewReal;
  UpdateViewReal;
  if FViewReal <> AViewReal then
    ViewStyle := CreatePainter;
end;

function TdxCustomNavBar.IsViewRealStored: Boolean;
begin
  Result := not IsViewStored;
end;

function TdxCustomNavBar.IsViewStored: Boolean;
begin
  Result := FView = FViewReal;
end;

function TdxCustomNavBar.GetViewStyle: TdxNavBarPainter;
begin
  Result := FPainter;
end;

procedure TdxCustomNavBar.SetLookAndFeelSchemes(const Value: TdxNavBarLookAndFeelSchemes);
begin
  FLookAndFeelSchemes.Assign(Value);
end;

procedure TdxCustomNavBar.SetViewReal(Value: Integer);
begin
  if IsLoading then
  begin
    FViewReal := Value;
    FView := dxNavBarLookAndFeelView;
    ViewStyle := CreatePainter;
  end;
end;

procedure TdxCustomNavBar.SetView(Value: Integer);
begin
  if FView <> Value then
  begin
    if (Value <> dxNavBarLookAndFeelView) and
      not dxNavBarViewsFactory.IsViewRegistered(Value) then
      Value := dxNavBarViewsFactory.IDs[dxNavBarViewsFactory.Count - 1];
    FView := Value;
    UpdateViewReal;
    ViewStyle := CreatePainter;
  end;
end;

procedure TdxCustomNavBar.SetViewStyle(Value: TdxNavBarPainter);
begin
  if Value <> nil then
  begin
    FreeAndNil(FPainter);
    FPainter := Value;
    if not IsLoading then
    begin
      DoUpdateScrollBarStyle;
      AssignDefaultStyles;
      InvalidateAll(doRecreate);
    end;
  end;
end;

procedure TdxCustomNavBar.UpdateViewReal;
begin
  if View = dxNavBarLookAndFeelView then
    FViewReal := FLookAndFeelSchemes.Views[LookAndFeel.ActiveStyle]
  else
    FViewReal := FView;
end;

procedure TdxCustomNavBar.SetOptionsView(Value: TdxNavBarViewOptions);
begin
  FOptionsView.Assign(Value);
end;

function TdxCustomNavBar.GetShowGroupCaptions: Boolean;
begin
  Result := OptionsView.Common.ShowGroupCaptions;
end;

procedure TdxCustomNavBar.SetShowGroupCaptions(Value: Boolean);
begin
  OptionsView.Common.ShowGroupCaptions := Value;
end;

function TdxCustomNavBar.GetShowSpecialGroup: Boolean;
begin
  Result := OptionsView.ExplorerBar.ShowSpecialGroup;
end;

function TdxCustomNavBar.GetSpaceBetweenGroups: Integer;
begin
  Result := OptionsView.ExplorerBar.SpaceBetweenGroups;
end;

procedure TdxCustomNavBar.SetShowSpecialGroup(const Value: Boolean);
begin
  OptionsView.ExplorerBar.ShowSpecialGroup := Value;
end;

procedure TdxCustomNavBar.SetSpaceBetweenGroups(Value: Integer);
begin
  OptionsView.ExplorerBar.SpaceBetweenGroups := Value;
end;

function TdxCustomNavBar.GetAllowSelectLinks: Boolean;
begin
  Result := OptionsBehavior.Common.AllowSelectLinks;
end;

function TdxCustomNavBar.GetEachGroupHasSelectedLink: Boolean;
begin
  Result := OptionsBehavior.Common.EachGroupHasSelectedLink;
end;

procedure TdxCustomNavBar.SetAllowSelectLinks(const Value: Boolean);
begin
  OptionsBehavior.Common.AllowSelectLinks := Value;
end;

procedure TdxCustomNavBar.SetEachGroupHasSelectedLink(const Value: Boolean);
begin
  OptionsBehavior.Common.EachGroupHasSelectedLink := Value;
end;

function TdxCustomNavBar.GetLargeImages: TCustomImageList;
begin
  Result := OptionsImage.LargeImages;
end;

function TdxCustomNavBar.GetSmallImages: TCustomImageList;
begin
  Result := OptionsImage.SmallImages;
end;

procedure TdxCustomNavBar.SetOptionsImage(Value: TdxNavBarImageOptions);
begin
  FOptionsImage.Assign(Value);
end;

procedure TdxCustomNavBar.SetLargeImages(const Value: TCustomImageList);
begin
  OptionsImage.LargeImages := Value;
end;

procedure TdxCustomNavBar.SetSmallImages(const Value: TCustomImageList);
begin
  OptionsImage.SmallImages := Value;
end;

function TdxCustomNavBar.GetOnCustomDrawBackground: TdxNavBarCustomDrawEvent;
begin
  Result := OnCustomDraw.Background;
end;

function TdxCustomNavBar.GetOnCustomDrawBottomScrollButton: TdxNavBarCustomDrawEvent;
begin
  Result := OnCustomDraw.BottomScrollButton;
end;

function TdxCustomNavBar.GetOnCustomDrawGroupCaption: TdxNavBarCustomDrawGroupEvent;
begin
  Result := OnCustomDraw.GroupCaption;
end;

function TdxCustomNavBar.GetOnCustomDrawGroupClientBackground: TdxNavBarCustomDrawGroupEvent;
begin
  Result := OnCustomDraw.GroupClientBackground;
end;

function TdxCustomNavBar.GetOnCustomDrawGroupClientForeground: TdxNavBarCustomDrawGroupEvent;
begin
  Result := OnCustomDraw.GroupClientForeground;
end;

function TdxCustomNavBar.GetOnCustomDrawGroupHint: TdxNavBarCustomDrawGroupHintEvent;
begin
  Result := OnCustomDraw.GroupHint;
end;

function TdxCustomNavBar.GetOnCustomDrawLink: TdxNavBarCustomDrawLinkEvent;
begin
  Result := OnCustomDraw.Link;
end;

function TdxCustomNavBar.GetOnCustomDrawLinkHint: TdxNavBarCustomDrawLinkHintEvent;
begin
  Result := OnCustomDraw.LinkHint;
end;

function TdxCustomNavBar.GetOnCustomDrawNavigationPaneHeader: TdxNavBarCustomDrawEvent;
begin
  Result := OnCustomDraw.NavigationPaneHeader;
end;

function TdxCustomNavBar.GetOnCustomDrawNavigationPaneOverflowPanel: TdxNavBarCustomDrawEvent;
begin
  Result := OnCustomDraw.NavigationPaneOverflowPanel;
end;

function TdxCustomNavBar.GetOnCustomDrawNavigationPaneOverflowPanelHint: TdxNavBarCustomDrawGroupHintEvent;
begin
  Result := OnCustomDraw.NavigationPaneOverflowPanelHint;
end;

function TdxCustomNavBar.GetOnCustomDrawNavigationPaneSplitter: TdxNavBarCustomDrawEvent;
begin
  Result := OnCustomDraw.NavigationPaneSplitter;
end;

function TdxCustomNavBar.GetOnCustomDrawTopScrollButton: TdxNavBarCustomDrawEvent;
begin
  Result := OnCustomDraw.TopScrollButton;
end;

procedure TdxCustomNavBar.SetOnCustomDraw(Value: TdxNavBarCustomDrawEvents);
begin
  FOnCustomDraw.Assign(Value);
end;

procedure TdxCustomNavBar.SetOnCustomDrawBackground(
  const Value: TdxNavBarCustomDrawEvent);
begin
  OnCustomDraw.Background := Value;
end;

procedure TdxCustomNavBar.SetOnCustomDrawBottomScrollButton(
  const Value: TdxNavBarCustomDrawEvent);
begin
  OnCustomDraw.BottomScrollButton := Value;
end;

procedure TdxCustomNavBar.SetOnCustomDrawGroupCaption(
  const Value: TdxNavBarCustomDrawGroupEvent);
begin
  OnCustomDraw.GroupCaption := Value;
end;

procedure TdxCustomNavBar.SetOnCustomDrawGroupClientBackground(
  const Value: TdxNavBarCustomDrawGroupEvent);
begin
  OnCustomDraw.GroupClientBackground := Value;
end;

procedure TdxCustomNavBar.SetOnCustomDrawGroupClientForeground(
  const Value: TdxNavBarCustomDrawGroupEvent);
begin
  OnCustomDraw.GroupClientForeground := Value;
end;

procedure TdxCustomNavBar.SetOnCustomDrawGroupHint(
  const Value: TdxNavBarCustomDrawGroupHintEvent);
begin
  OnCustomDraw.GroupHint := Value;
end;

procedure TdxCustomNavBar.SetOnCustomDrawLink(
  const Value: TdxNavBarCustomDrawLinkEvent);
begin
  OnCustomDraw.Link := Value;
end;

procedure TdxCustomNavBar.SetOnCustomDrawLinkHint(
  const Value: TdxNavBarCustomDrawLinkHintEvent);
begin
  OnCustomDraw.LinkHint := Value;
end;

procedure TdxCustomNavBar.SetOnCustomDrawNavigationPaneHeader(
  const Value: TdxNavBarCustomDrawEvent);
begin
  OnCustomDraw.NavigationPaneHeader := Value;
end;

procedure TdxCustomNavBar.SetOnCustomDrawNavigationPaneOverflowPanel(
  const Value: TdxNavBarCustomDrawEvent);
begin
  OnCustomDraw.NavigationPaneOverflowPanel := Value;
end;

procedure TdxCustomNavBar.SetOnCustomDrawNavigationPaneOverflowPanelHint(
  const Value: TdxNavBarCustomDrawGroupHintEvent);
begin
  OnCustomDraw.NavigationPaneOverflowPanelHint := Value;
end;

procedure TdxCustomNavBar.SetOnCustomDrawNavigationPaneSplitter(
  const Value: TdxNavBarCustomDrawEvent);
begin
  OnCustomDraw.NavigationPaneSplitter := Value;
end;

procedure TdxCustomNavBar.SetOnCustomDrawTopScrollButton(
  const Value: TdxNavBarCustomDrawEvent);
begin
  OnCustomDraw.TopScrollButton := Value;
end;

function TdxCustomNavBar.GetDefaultStyles: TdxNavBarDefaultStyles;
begin
  Result := OptionsStyle.DefaultStyles;
end;

function TdxCustomNavBar.GetNavBarCustomStyle(Index: Integer): TdxNavBarStyleItem;
begin
  Result := OptionsStyle.CustomStyles.Styles[Index];
end;

function TdxCustomNavBar.GetStyles: TdxNavBarStyleRepository;
begin
  Result := OptionsStyle.CustomStyleRepository;
end;

procedure TdxCustomNavBar.SetDefaultStyles(Value: TdxNavBarDefaultStyles);
begin
  OptionsStyle.DefaultStyles := Value;
end;

procedure TdxCustomNavBar.SetNavBarCustomStyle(Index: Integer; const Value: TdxNavBarStyleItem);
begin
  OptionsStyle.CustomStyles.Styles[Index] := Value;
end;

procedure TdxCustomNavBar.SetOptionsStyle(Value: TdxNavBarStyleOptions);
begin
  FOptionsStyle.Assign(Value);
end;

procedure TdxCustomNavBar.AssignDefaultStyles;
begin
  DefaultStyles.AssignDefaultValues(False);
  InvalidateAll(doRecalc);
end;

procedure TdxCustomNavBar.LoadFromIniFile(AFileName: string; LoadStyles: Boolean = True);
var
  AStream: TFileStream;
begin
  if AFileName = '' then exit;
{$IFDEF DELPHI6}
  AStream := TFileStream.Create(AFileName, fmOpenRead, fmShareDenyWrite);
{$ELSE}
  AStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
{$ENDIF}
  try
    LoadFromStream(AStream, LoadStyles);
  finally
    AStream.Free;
  end;
end;

procedure TdxCustomNavBar.LoadFromRegistry(ARegistryPath: string; LoadStyles: Boolean = True);
var
  Storage: TRegistryIniFile;
begin
  if ARegistryPath = '' then exit;
  Storage := TRegistryIniFile.Create(ARegistryPath);
  try
    LoadFromRegIni(Storage, LoadStyles);
  finally
    Storage.Free;
  end;
end;

procedure TdxCustomNavBar.LoadFromStream(AStream: TStream; LoadStyles: Boolean = True);
var
  Storage: TMemIniFile;
  AStrings: TStringList;
begin
  Storage := TMemIniFile.Create('');
  AStrings := TStringList.Create;
  try
    AStrings.LoadFromStream(AStream);
    Storage.SetStrings(AStrings);
    LoadFromRegIni(Storage, LoadStyles);
  finally
    AStrings.Free;
    Storage.Free;
  end;
end;

procedure TdxCustomNavBar.SaveToIniFile(AFileName: string; SaveStyles: Boolean = True);
var
  AStream: TFileStream;
begin
  if AFileName = '' then Exit;
{$IFDEF DELPHI6}
  AStream := TFileStream.Create(AFileName, fmCreate, fmShareExclusive);
{$ELSE}
  AStream := TFileStream.Create(AFileName, fmCreate or fmShareExclusive);
{$ENDIF}
  try
    SaveToStream(AStream, SaveStyles);
  finally
    AStream.Free;
  end;
end;

procedure TdxCustomNavBar.SaveToRegistry(ARegistryPath: string; SaveStyles: Boolean = True);
var
  Storage: TRegistryIniFile;
begin
  if ARegistryPath = '' then exit;
  Storage := TRegistryIniFile.Create(ARegistryPath);
  try
    SaveToRegIni(Storage, SaveStyles);
  finally
    Storage.Free;
  end;
end;

procedure TdxCustomNavBar.SaveToStream(AStream: TStream; SaveStyles: Boolean = True);
var
  Storage: TMemIniFile;
  AStrings: TStringList;
begin
  Storage := TMemIniFile.Create('');
  AStrings := TStringList.Create;
  try
    SaveToRegIni(Storage, SaveStyles);
    Storage.GetStrings(AStrings);
    AStrings.SaveToStream(AStream{$IFDEF DELPHI12}, TEncoding.UTF8{$ENDIF});
  finally
    AStrings.Free;
    Storage.Free;
  end;
end;

function TdxCustomNavBar.GetGroupAtCaptionPos(const pt: TPoint): TdxNavBarGroup;
begin
  Result := ViewInfo.GetGroupAtCaptionPos(pt);
end;

function TdxCustomNavBar.GetGroupAtItemsPos(const pt: TPoint): TdxNavBarGroup;
begin
  Result := ViewInfo.GetGroupAtItemsPos(pt);
end;

function TdxCustomNavBar.GetLinkAtPos(const pt: TPoint): TdxNavBarItemLink;
begin
  Result := ViewInfo.GetLinkAtPos(pt);
end;

function TdxCustomNavBar.IsPtGroupDesignRect(const pt: TPoint): Boolean;
begin
  Result := ViewInfo.IsPtGroupDesignRect(pt);
end;

function TdxCustomNavBar.IsPtItemDesignRect(const pt: TPoint): Boolean;
begin
  Result := ViewInfo.IsPtItemDesignRect(pt);
end;

function TdxCustomNavBar.GetLinkAtSelectedPos(const pt: TPoint): TdxNavBarItemLink;
begin
  Result := ViewInfo.GetLinkAtSelectedPos(pt);
end;

function TdxCustomNavBar.IsPtTopScrollButton(const pt: TPoint): Boolean;
begin
  Result := ViewInfo.IsPtTopScrollButton(pt);
end;

function TdxCustomNavBar.IsPtBottomScrollButton(const pt: TPoint): Boolean;
begin
  Result := ViewInfo.IsPtBottomScrollButton(pt);
end;

function TdxCustomNavBar.IsTopScrollButtonVisible: Boolean;
begin
  Result := ViewInfo.IsTopScrollButtonVisible;
end;

function TdxCustomNavBar.IsBottomScrollButtonVisible: Boolean;
begin
  Result := ViewInfo.IsBottomScrollButtonVisible;
end;

procedure TdxCustomNavBar.MakeLinkVisible(ALink: TdxNavBarItemLink);
begin
  ViewInfo.MakeLinkVisible(ALink);
end;

procedure TdxCustomNavBar.MakeGroupVisible(AGroup: TdxNavBarGroup);
begin
  ViewInfo.MakeGroupVisible(AGroup);
end;

procedure TdxCustomNavBar.BeginUpdate;
begin
  Inc(FUpdateLock);
end;

procedure TdxCustomNavBar.CancelUpdate;
begin
  Dec(FUpdateLock);
end;

procedure TdxCustomNavBar.EndUpdate;
begin
  Dec(FUpdateLock);
  if FUpdateLock = 0 then InvalidateAll(doRecreate);
end;

function TdxCustomNavBar.CanDecNavigationPaneOverflowPanelItemCount: Boolean;
begin
  Result := ShowGroupCaptions and (NavigationPaneOverflowPanelItemCount > 0);
end;

function TdxCustomNavBar.CanIncNavigationPaneOverflowPanelItemCount: Boolean;
begin
  Result := ShowGroupCaptions and (NavigationPaneOverflowPanelItemCount < VisibleGroupCount);
end;

procedure TdxCustomNavBar.DoDecNavigationPaneOverflowPanelItemCount;
begin
  if NavigationPaneMaxVisibleGroups = VisibleGroupCount - 1 then
    NavigationPaneMaxVisibleGroups := -1
  else
    NavigationPaneMaxVisibleGroups := NavigationPaneMaxVisibleGroups + 1;
end;

procedure TdxCustomNavBar.DoIncNavigationPaneOverflowPanelItemCount;
begin
  if (NavigationPaneMaxVisibleGroups = -1) or
    (NavigationPaneMaxVisibleGroups > VisibleGroupCount) then
    NavigationPaneMaxVisibleGroups := VisibleGroupCount - 1
  else
    NavigationPaneMaxVisibleGroups := NavigationPaneMaxVisibleGroups - 1;
end;

procedure TdxCustomNavBar.DragDone;
begin
  dxNavBarDragObject.Free;
  dxNavBarDragObject := nil;
  Exclude(FInternalState, nbisDragging);
  DragMode := dmManual;
  FSourceGroup := nil;
  FSourceLink := nil;
  Controller.UpdateHotTrack;
end;

function TdxCustomNavBar.IsAllowDragLink: Boolean;
begin
  Result := fAllowDragLink in DragDropFlags;
end;

function TdxCustomNavBar.IsAllowDropLink: Boolean;
begin
  Result := fAllowDropLink in DragDropFlags;
end;

function TdxCustomNavBar.IsAllowDragGroup: Boolean;
begin
  Result := fAllowDragGroup in DragDropFlags;
end;

function TdxCustomNavBar.IsAllowDropGroup: Boolean;
begin
  Result := fAllowDropGroup in DragDropFlags;
end;

procedure TdxCustomNavBar.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := Message.Result or DLGC_WANTARROWS;
end;

procedure TdxCustomNavBar.WMNCCalcSize(var Message: TWMNCCalcSize);
var
  ABoundsRect, AScrollBarRect: TRect;
begin
  ABoundsRect := Message.CalcSize_Params^.rgrc[0];
  inherited;
  if ScrollBar.Visible then
  begin
    AScrollBarRect := Message.CalcSize_Params^.rgrc[0];
    AScrollBarRect.Left := AScrollBarRect.Right - ScrollBar.Width;
    Message.CalcSize_Params^.rgrc[0].Right := AScrollBarRect.Left;
    ScrollBar.Bounds := cxRectOffset(AScrollBarRect, ABoundsRect.TopLeft, False);
  end
  else
    ScrollBar.Bounds := cxInvalidRect;
  Message.Result := 0;
end;

procedure TdxCustomNavBar.WMNCHitTest(var Message: TWMNCHitTest);

  function PtInScrollBar(const APoint: TPoint): Boolean;
  begin
    Result := PtInRect(cxRectOffset(ScrollBar.Bounds, cxGetWindowRect(Handle).TopLeft), APoint);
  end;

var
  APoint: TPoint;
begin
  APoint := SmallPointToPoint(Message.Pos);
  if PtInScrollBar(APoint) then
    Message.Result := HTCLIENT
  else
    inherited;
end;

procedure TdxCustomNavBar.WMSetCursor(var Msg: TWMSetCursor);

  function IsCursorAssigned: Boolean;
  var
    AIcon: HIcon;
  begin
    Result := True;
    AIcon := Controller.GetCursor;
    if AIcon <> 0 then
      SetCursor(AIcon)
    else
    begin
      Controller.UpdateHotTrack;
      if FHotTrackedGroup <> nil then
        SetCursor(Screen.Cursors[HotTrackedGroupCursor])
      else
        if HotTrackedLink <> nil then
          SetCursor(Screen.Cursors[HotTrackedLinkCursor])
        else
          Result := False;
    end;
  end;

begin
  if IsDesigning or (Screen.Cursor <> crDefault) or EnableDragging or not IsCursorAssigned then
    inherited;
end;

procedure TdxCustomNavBar.WMVScroll(var Message: TWMVScroll);
var
  AScrollPos: Integer;
begin
  inherited;
  AScrollPos := Message.Pos;
  ScrollBar.Scroll(ScrollBar, TScrollCode(Message.ScrollCode), AScrollPos);
end;

procedure TdxCustomNavBar.WMWindowPosChanging(var Message: TWMWindowPosChanging);

  function IsSizeChanging: Boolean;
  begin
    Result := Message.WindowPos^.flags and SWP_NOSIZE = 0;
  end;

begin
  if (ComponentState * [csReading, csLoading] = []) and
    IsSizeChanging and (FPainter <> nil) then
      with Message.WindowPos^ do
        CheckBounds(x, y, cx, cy);
  inherited;
end;

procedure TdxCustomNavBar.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (BorderStyle = bsSingle) then
    RecreateWnd;
  inherited;
end;

procedure TdxCustomNavBar.CMDialogChar(var Message: TCMDialogChar);
var
  AGroup: TdxNavBarGroup;
  ALink: TdxNavBarItemLink;
begin
  if inherited CanFocus then
  begin
    AGroup := ViewInfo.FindGroupWithAccel(Message.CharCode);
    if AGroup <> nil then
    begin
      DoGroupMouseUp(AGroup);
      Message.Result := 1;
    end
    else
    begin
      ALink := ViewInfo.FindLinkWithAccel(Message.CharCode);
      if (ALink <> nil) and ALink.CanSelect then
      begin
        DoLinkMouseUp(ALink);
        Message.Result := 1;
      end
      else
        inherited;
    end;
  end;
end;

procedure TdxCustomNavBar.CMDialogKey(var Message: TCMDialogKey);
var
  AKey: Word;
begin
  AKey := Message.CharCode;
  if (AKey = VK_RETURN) and Focused and
    (KeyDataToShiftState(Message.KeyData) = []) and
    (FocusedAccessibleObject <> nil) then
  begin
    FocusedAccessibleObject.KeyUp(AKey, []);
    Message.Result := 1;
  end
  else
    inherited;
end;

procedure TdxCustomNavBar.CMHintShow(var Message: TCMHintShow);
const
  AResultMap: array[Boolean] of Integer = (1, 0);
var
  ACanShow: Boolean;
begin
  Controller.ShowHint(Message.HintInfo^, ACanShow);
  Message.Result := AResultMap[ACanShow];
end;

procedure TdxCustomNavBar.CMSysColorChange(var Message: TMessage);
begin
  ViewInfo.RefreshColors;
  InvalidateAll(doRedraw);
end;

{ TdxNavBarCursors }

constructor TdxNavBarCursors.Create(ANavBar: TdxCustomNavBar);
begin
  inherited;
  Cursor := crDefault;
  DragCursor := dxNavBarDragCursor;  
  FDragCopyCursor := dxNavBarDragCopyCursor;
  FHotTrackedGroupCursor := crDefault;
  FHotTrackedLinkCursor := dxNavBarLinksCursor;
end;

procedure TdxNavBarCursors.Assign(Source: TPersistent);
var
  ASourceCursors: TdxNavBarCursors;
begin
  if Source is TdxNavBarCursors then
  begin
    ASourceCursors := TdxNavBarCursors(Source);
    Cursor := ASourceCursors.Cursor;
    DragCopyCursor := ASourceCursors.DragCopyCursor;
    DragCursor := ASourceCursors.DragCursor;
    HotTrackedGroupCursor := ASourceCursors.HotTrackedGroupCursor;
    HotTrackedLinkCursor := ASourceCursors.HotTrackedLinkCursor;
  end
  else
    inherited;
end;

function TdxNavBarCursors.GetCursor: TCursor;
begin
  Result := NavBar.Cursor;
end;

function TdxNavBarCursors.GetDragCursor: TCursor;
begin
  Result := NavBar.DragCursor;
end;

procedure TdxNavBarCursors.SetCursor(Value: TCursor);
begin
  NavBar.Cursor := Value;
end;

procedure TdxNavBarCursors.SetDragCursor(Value: TCursor);
begin
  NavBar.DragCursor := Value;
end;

{ TdxNavBarSideBarBehaviorOptions }

procedure TdxNavBarSideBarBehaviorOptions.Assign(Source: TPersistent);
var
  ASourceOptions: TdxNavBarSideBarBehaviorOptions;
begin
  if Source is TdxNavBarSideBarBehaviorOptions then
  begin
    ASourceOptions := TdxNavBarSideBarBehaviorOptions(Source);
    AllowSelectLinks := ASourceOptions.AllowSelectLinks;
    EachGroupHasSelectedLink := ASourceOptions.EachGroupHasSelectedLink;
  end
  else
    inherited;
end;

function TdxNavBarSideBarBehaviorOptions.GetAllowSelectLinks: Boolean;
begin
  Result := NavBar.OptionsBehavior.Common.AllowSelectLinks;
end;

function TdxNavBarSideBarBehaviorOptions.GetEachGroupHasSelectedLink: Boolean;
begin
  Result := NavBar.OptionsBehavior.Common.EachGroupHasSelectedLink;
end;

procedure TdxNavBarSideBarBehaviorOptions.SetAllowSelectLinks(Value: Boolean);
begin
  NavBar.OptionsBehavior.Common.AllowSelectLinks := Value;
end;

procedure TdxNavBarSideBarBehaviorOptions.SetEachGroupHasSelectedLink(Value: Boolean);
begin
  NavBar.OptionsBehavior.Common.EachGroupHasSelectedLink := Value;
end;

constructor TdxNavBarBehaviorOptions.Create(ANavBar: TdxCustomNavBar);
begin
  inherited;
  FCommon := TdxNavBarCommonBehaviorOptions.Create(ANavBar);
  FNavigationPane := TdxNavBarNavigationPaneBehaviorOptions.Create(ANavBar);
  FSideBar := TdxNavBarSideBarBehaviorOptions.Create(ANavBar);
end;

destructor TdxNavBarBehaviorOptions.Destroy;
begin
  FreeAndNil(FSideBar);
  FreeAndNil(FNavigationPane);
  FreeAndNil(FCommon);
  inherited;
end;

procedure TdxNavBarBehaviorOptions.Assign(Source: TPersistent);
var
  ASourceOptions: TdxNavBarBehaviorOptions;
begin
  if Source is TdxNavBarBehaviorOptions then
  begin
    ASourceOptions := TdxNavBarBehaviorOptions(Source);
    FCommon.Assign(ASourceOptions.Common);
    FNavigationPane.Assign(ASourceOptions.NavigationPane);
    FSideBar.Assign(ASourceOptions.SideBar);
  end
  else
    inherited;
end;

procedure TdxNavBarBehaviorOptions.SetCommon(AValue: TdxNavBarCommonBehaviorOptions);
begin
  if FCommon <> AValue then
    FCommon.Assign(AValue);
end;

procedure TdxNavBarBehaviorOptions.SetNavigationPane(AValue: TdxNavBarNavigationPaneBehaviorOptions);
begin
  if FNavigationPane <> AValue then
    FNavigationPane.Assign(AValue);
end;

procedure TdxNavBarBehaviorOptions.SetSideBar(AValue: TdxNavBarSideBarBehaviorOptions);
begin
  if FSideBar <> AValue then
    FSideBar.Assign(AValue);
end;

{ TdxNavBarExplorerBarViewOptions }

procedure TdxNavBarExplorerBarViewOptions.Assign(Source: TPersistent);
var
  ASourceOptions: TdxNavBarExplorerBarViewOptions;
begin
  if Source is TdxNavBarExplorerBarViewOptions then
  begin
    ASourceOptions := TdxNavBarExplorerBarViewOptions(Source);
    ShowSpecialGroup := ASourceOptions.ShowSpecialGroup;
    SpaceBetweenGroups := ASourceOptions.SpaceBetweenGroups;
  end
  else
    inherited;
end;

procedure TdxNavBarExplorerBarViewOptions.SetShowSpecialGroup(Value: Boolean);
begin
  if ShowSpecialGroup <> Value then
  begin
    FShowSpecialGroup := Value;
    NavBar.InvalidateAll(doRecreate);
  end;
end;

procedure TdxNavBarExplorerBarViewOptions.SetSpaceBetweenGroups(Value: Integer);
begin
  Value := Max(Value, 0);
  if SpaceBetweenGroups <> Value then
  begin
    FSpaceBetweenGroups := Value;
    NavBar.InvalidateAll(doRecalc);
  end;
end;

{ TdxNavBarNavigationPaneViewOptions }

constructor TdxNavBarNavigationPaneViewOptions.Create(ANavBar: TdxCustomNavBar);
begin
  inherited;
  FMaxVisibleGroups := -1;
  FOverflowPanelUseSmallImages := True;
  FShowHeader := True;
  FShowOverflowPanel := True;
end;

procedure TdxNavBarNavigationPaneViewOptions.Assign(Source: TPersistent);
var
  ASourceOptions: TdxNavBarNavigationPaneViewOptions;
begin
  if Source is TdxNavBarNavigationPaneViewOptions then
  begin
    ASourceOptions := TdxNavBarNavigationPaneViewOptions(Source);
    MaxVisibleGroups := ASourceOptions.MaxVisibleGroups;
    OverflowPanelUseSmallImages := ASourceOptions.OverflowPanelUseSmallImages;
    ShowActiveGroupCaptionWhenCollapsed := ASourceOptions.ShowActiveGroupCaptionWhenCollapsed;
    ShowHeader := ASourceOptions.ShowHeader;
    ShowOverflowPanel := ASourceOptions.ShowOverflowPanel;
  end
  else
    inherited;
end;

procedure TdxNavBarNavigationPaneViewOptions.SetMaxVisibleGroups(Value: Integer);
begin
  Value := Max(Value, -1);
  if MaxVisibleGroups <> Value then
  begin
    FMaxVisibleGroups := Value;
    NavBar.InvalidateAll(doRecreate);
  end;
end;

procedure TdxNavBarNavigationPaneViewOptions.SetOverflowPanelUseSmallImages(Value: Boolean);
begin
  if OverflowPanelUseSmallImages <> Value then
  begin
    FOverflowPanelUseSmallImages := Value;
    NavBar.InvalidateAll(doRecreate);
  end;
end;

procedure TdxNavBarNavigationPaneViewOptions.SetShowActiveGroupCaptionWhenCollapsed(Value: Boolean);
begin
  if FShowActiveGroupCaptionWhenCollapsed <> Value then
  begin
    FShowActiveGroupCaptionWhenCollapsed := Value;
    NavBar.InvalidateAll(doRecalc);
  end;
end;

procedure TdxNavBarNavigationPaneViewOptions.SetShowHeader(Value: Boolean);
begin
  if ShowHeader <> Value then
  begin
    FShowHeader := Value;
    NavBar.InvalidateAll(doRecreate);
  end;
end;

procedure TdxNavBarNavigationPaneViewOptions.SetShowOverflowPanel(Value: Boolean);
begin
  if ShowOverflowPanel <> Value then
  begin
    FShowOverflowPanel := Value;
    NavBar.InvalidateAll(doRecreate);
  end;
end;

{ TdxNavBarViewOptions }

constructor TdxNavBarViewOptions.Create(ANavBar: TdxCustomNavBar);
begin
  inherited;
  FCommon := TdxNavBarCommonViewOptions.Create(ANavBar);
  FExplorerBar := TdxNavBarExplorerBarViewOptions.Create(ANavBar);
  FNavigationPane := TdxNavBarNavigationPaneViewOptions.Create(ANavBar);
end;

destructor TdxNavBarViewOptions.Destroy;
begin
  FreeAndNil(FNavigationPane);
  FreeAndNil(FExplorerBar);
  FreeAndNil(FCommon);
  inherited;
end;

procedure TdxNavBarViewOptions.Assign(Source: TPersistent);
var
  ASourceOptions: TdxNavBarViewOptions;
begin
  if Source is TdxNavBarViewOptions then
  begin
    ASourceOptions := TdxNavBarViewOptions(Source);
    FCommon.Assign(ASourceOptions.Common);
    FExplorerBar.Assign(ASourceOptions.ExplorerBar);
    FNavigationPane.Assign(ASourceOptions.NavigationPane);
  end
  else
    inherited;
end;

procedure TdxNavBarViewOptions.SetCommon(AValue: TdxNavBarCommonViewOptions);
begin
  if FCommon <> AValue then
    FCommon.Assign(AValue);
end;

procedure TdxNavBarViewOptions.SetExplorerBar(AValue: TdxNavBarExplorerBarViewOptions);
begin
  if FExplorerBar <> AValue then
    FExplorerBar.Assign(AValue) 
end;

procedure TdxNavBarViewOptions.SetNavigationPane(AValue: TdxNavBarNavigationPaneViewOptions);
begin
  if FNavigationPane <> AValue then
    FNavigationPane.Assign(AValue);
end;

{ TdxNavBarOptions }

constructor TdxNavBarCommonBehaviorOptions.Create(ANavBar: TdxCustomNavBar);
begin
  inherited;
  FDragDropFlags := dxNavBarDefaultDragDropFlags;
end;

procedure TdxNavBarCommonBehaviorOptions.Assign(Source: TPersistent);
var
  ASourceOptions: TdxNavBarCommonBehaviorOptions;
begin
  if Source is TdxNavBarCommonBehaviorOptions then
  begin
    ASourceOptions := TdxNavBarCommonBehaviorOptions(Source);
    AllowSelectLinks := ASourceOptions.AllowSelectLinks;
    DragDropFlags := ASourceOptions.DragDropFlags;
    EachGroupHasSelectedLink := ASourceOptions.EachGroupHasSelectedLink;
    ShowGroupsHint := ASourceOptions.ShowGroupsHint;
    ShowLinksHint := ASourceOptions.ShowLinksHint;
  end
  else
    inherited;
end;

procedure TdxNavBarCommonBehaviorOptions.SetAllowSelectLinks(Value: Boolean);
begin
  if AllowSelectLinks <> Value then
  begin
    FAllowSelectLinks := Value;
    if not FAllowSelectLinks then
      NavBar.DeSelectLinks;
    NavBar.InvalidateAll(doRedraw);
  end;
end;

procedure TdxNavBarCommonBehaviorOptions.SetEachGroupHasSelectedLink(Value: Boolean);
begin
  if EachGroupHasSelectedLink <> Value then
  begin
    FEachGroupHasSelectedLink := Value;
    if not FEachGroupHasSelectedLink then
      NavBar.DeSelectLinks;
    NavBar.InvalidateAll(doRedraw);
  end;
end;

 { TdxNavBarNavigationPaneBehaviorOptions }

constructor TdxNavBarNavigationPaneBehaviorOptions.Create(ANavBar: TdxCustomNavBar);
begin
  inherited;
  FAllowCustomizing := True;
  FShowOverflowPanelHints := True;
end;

procedure TdxNavBarNavigationPaneBehaviorOptions.Assign(Source: TPersistent);
var
  ASourceOptions: TdxNavBarNavigationPaneBehaviorOptions;
begin
  if Source is TdxNavBarNavigationPaneBehaviorOptions then
  begin
    ASourceOptions := TdxNavBarNavigationPaneBehaviorOptions(Source);
    AdjustWidthByPopup := ASourceOptions.AdjustWidthByPopup;
    AllowCustomizing := ASourceOptions.AllowCustomizing;
    Collapsed := ASourceOptions.Collapsed;
    Collapsible := ASourceOptions.Collapsible;
    ShowOverflowPanelHints := ASourceOptions.ShowOverflowPanelHints;
  end
  else
    inherited;
end;

procedure TdxNavBarNavigationPaneBehaviorOptions.SetCollapsible(Value: Boolean);
begin
  if Collapsible <> Value then
  begin
    FCollapsible := Value;
    if not NavBar.IsLoading then
    begin
      Collapsed := FCollapsible and (NavBar.Width < NavBar.ViewInfo.GetNavBarMinExpandedWidth);
      NavBar.InvalidateAll(doRecalc);
    end;
  end;
end;

procedure TdxNavBarNavigationPaneBehaviorOptions.SetCollapsed(Value: Boolean);
begin
  if (Collapsed <> Value) and (not Value or Collapsible or NavBar.IsLoading) then
  begin
    FCollapsed := Value;
    if not NavBar.IsLoading then
      NavBar.CollapseStateChanged;
  end;
end;

{ TdxNavBarCustomViewInfo }

constructor TdxNavBarCustomViewInfo.Create;
begin
  inherited Create;
  FRatio := Max(1, Screen.PixelsPerInch / 96);
end;

function TdxNavBarCustomViewInfo.GetRevisedValue(AValue: Integer): Integer;
begin
  Result := Round(Ratio * AValue);
end;

{ TdxNavBarCustomItemViewInfo }

constructor TdxNavBarCustomItemViewInfo.Create(AViewInfo: TdxNavBarViewInfo);
begin
  inherited Create;
  FCaptionFont := TFont.Create;
  FViewInfo := AViewInfo;
  FPainter := FViewInfo.Painter;
  FNavBar := FViewInfo.NavBar;
end;

destructor TdxNavBarCustomItemViewInfo.Destroy;
begin
  FreeAndNil(FCaptionFont);
  inherited;
end;

procedure TdxNavBarCustomItemViewInfo.CorrectBounds(dX, dY: Integer);
begin
  OffsetRect(FCaptionRect, dX, dY);
  OffsetRect(FDesignRect, dX, dY);
  OffsetRect(FFocusRect, dX, dY);
  OffsetRect(FImageRect, dX, dY);
  OffsetRect(FRect, dX, dY);
end;

function TdxNavBarCustomItemViewInfo.ImageIndex: Integer;
begin
  if UseLargeImages then
    Result := GetNavBarItem.LargeImageIndex
  else
    Result := GetNavBarItem.SmallImageIndex;
end;

procedure TdxNavBarCustomItemViewInfo.CalcDesignRect(const AItemRect: TRect; AMarkSize: Integer);
var
  ADesignArea: TRect;
begin
  if NavBar.IsDesigning then
  begin
    ADesignArea := AItemRect;
    ADesignArea.Left := ADesignArea.Right - 20;
    FDesignRect := cxRectCenter(ADesignArea, AMarkSize, AMarkSize);
  end
  else
    FDesignRect := cxNullRect;
end;

function TdxNavBarCustomItemViewInfo.GetImageList: TCustomImageList;
begin
  if UseLargeImages then
    if UseDisabledImages then
      Result := NavBar.OptionsImage.DisabledLargeImages
    else
      if UseHotImages then
        Result := NavBar.OptionsImage.HotLargeImages
      else
        Result := NavBar.LargeImages
  else
    if UseDisabledImages then
      Result := NavBar.OptionsImage.DisabledSmallImages
    else
      if UseHotImages then
        Result := NavBar.OptionsImage.HotSmallImages
      else
        Result := NavBar.SmallImages;
end;

function TdxNavBarCustomItemViewInfo.GetState: TdxNavBarObjectStates;
begin
  Result := [];
end;

function TdxNavBarCustomItemViewInfo.IsEnabled: Boolean;
begin
  Result := not(sDisabled in State);
end;

function TdxNavBarCustomItemViewInfo.IsFocused: Boolean;
begin
  Result := sFocused in State;
end;

function TdxNavBarCustomItemViewInfo.IsSelected: Boolean;
begin
  Result := [sActive, sHotTracked, sPressed, sSelected] * State <> [];
end;

function TdxNavBarCustomItemViewInfo.UseDisabledImages: Boolean;
begin
  Result := not IsEnabled and
    (not UseLargeImages and (NavBar.OptionsImage.DisabledSmallImages <> nil) or
    UseLargeImages and (NavBar.OptionsImage.DisabledLargeImages <> nil)) ;
end;

function TdxNavBarCustomItemViewInfo.UseHotImages: Boolean;
begin
  Result := IsSelected and
    (not UseLargeImages and (NavBar.OptionsImage.HotSmallImages <> nil) or
    UseLargeImages and (NavBar.OptionsImage.HotLargeImages <> nil));
end;

function TdxNavBarCustomItemViewInfo.UseLargeImages: Boolean;
begin
  Result := False;
end;

{ TdxNavBarLinkViewInfo }

constructor TdxNavBarLinkViewInfo.Create(AGroupViewInfo: TdxNavBarGroupViewInfo; ALink: TdxNavBarItemLink;
  ACaptionVisible, AImageVisisble: Boolean);
begin
  inherited Create(AGroupViewInfo.ViewInfo);
  FGroupViewInfo := AGroupViewInfo;
  FLink := ALink;
  FItem := FLink.Item;
  FCaptionVisible := ACaptionVisible;
  FImageVisible := AImageVisisble;
end;

procedure TdxNavBarLinkViewInfo.CalculateBounds(X, Y: Integer);
begin
  TdxNavBarItemAccess(Item).GetCalculatorClass.CalculateBounds(X, Y, Self);
end;

function TdxNavBarLinkViewInfo.UseLargeImages: Boolean;
begin
  Result := not GroupViewInfo.IsLinksUseSmallImages;
end;

function TdxNavBarLinkViewInfo.SelectionRect: TRect;
begin
  Result := ImageRect;
  InflateRect(Result, 2, 2)
end;

function TdxNavBarLinkViewInfo.SeparatorRect: TRect;
const
  ASeparatorIndent = 8;
begin
  Result := CaptionRect;
  Dec(Result.Right, ASeparatorIndent);
  if UseLargeImages then
    Inc(Result.Left, ASeparatorIndent);
  Result := cxRectCenterVertically(Result, 1);
end;

function TdxNavBarLinkViewInfo.GetNavBarItem: TdxNavBarCustomItem;
begin
  Result := Item;
end;

function TdxNavBarLinkViewInfo.GetState: TdxNavBarObjectStates;
begin
  Result := inherited GetState;
  if not Item.Enabled then
    Include(Result, sDisabled);
  if (Link = NavBar.PressedLink) and (Link = NavBar.HotTrackedLink) then
    Include(Result, sPressed);
  if Link.IsSelected then
    Include(Result, sSelected);
  if NavBar.HotTrackedLink = Link then
    Include(Result, sHotTracked);
  if Link.IAccessibilityHelper.IsFocused then
    Include(Result, sFocused);
end;

function TdxNavBarLinkViewInfo.GetCaptionHeight: Integer;
begin
  Result := 4;
  Inc(Result, cxTextHeight(Font));
end;

function TdxNavBarLinkViewInfo.GetDrawEdgeFlag: Integer;
const
  AFlagMap: array[Boolean] of Integer = (DT_CENTER or DT_WORDBREAK, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
begin
  Result := AFlagMap[GroupViewInfo.IsLinksUseSmallImages];
end;

function TdxNavBarLinkViewInfo.GetImageHeight: Integer;
begin
  if GroupViewInfo.IsLinksUseSmallImages then
    Result := ViewInfo.GetSmallImageHeight
  else Result := ViewInfo.GetLargeImageHeight;
end;

function TdxNavBarLinkViewInfo.GetImageWidth: Integer;
begin
  if GroupViewInfo.IsLinksUseSmallImages then
    Result := ViewInfo.GetSmallImageWidth
  else Result := ViewInfo.GetLargeImageWidth;
end;

function TdxNavBarLinkViewInfo.IsCaptionVisible: Boolean;
begin
  Result := FCaptionVisible and (FCaptionRect.Left > FRect.Left) and (FCaptionRect.Right < FRect.Right);
end;

function TdxNavBarLinkViewInfo.IsImageVisible: Boolean;
begin
  Result := FImageVisible and (FImageRect.Left > FRect.Left) and (FImageRect.Right < FRect.Right);
end;

function TdxNavBarLinkViewInfo.IsWholeVisible: Boolean;
begin
  Result := PtInRect(GroupViewInfo.ItemsRect, Rect.TopLeft) and
    PtInRect(GroupViewInfo.ItemsRect, Rect.BottomRight);
end;

function TdxNavBarLinkViewInfo.StyleItem: TdxNavBarStyleItem;
begin
  if sDisabled in State then
    Result := Item.StyleDisabled
  else
    if sPressed in State then
      Result := Item.StylePressed
    else
      if sHotTracked in State then
        Result := Item.StyleHotTracked
      else
         Result := Item.Style;
end;

function TdxNavBarLinkViewInfo.Style: TdxNavBarBaseStyle;
begin
  if sDisabled in State then
    Result := NavBar.DefaultStyles.ItemDisabled
  else
    if sPressed in State then
      Result := NavBar.DefaultStyles.ItemPressed
    else
      if sHotTracked in State then
        Result := NavBar.DefaultStyles.ItemHotTracked
      else
        if sSelected in State then
          Result := NavBar.DefaultStyles.ItemPressed
        else
          Result := NavBar.DefaultStyles.Item;
end;

function TdxNavBarLinkViewInfo.Font: TFont;
begin
  Result := FCaptionFont;
  if (StyleItem <> nil) and (savFont in StyleItem.Style.AssignedValues) then
    Result.Assign(StyleItem.Style.Font)
  else Result.Assign(Style.Font);
end;

function TdxNavBarLinkViewInfo.FontColor: TColor;
begin
  Result := Font.Color;
end;

function TdxNavBarLinkViewInfo.SeparatorColor: TColor;
begin
  Result := FontColor;
end;

initialization
  FUnitIsFinalized := False;
  RegisterClasses([TdxNavBar]);
  dxNavBarDragObject := nil;
  Screen.Cursors[dxNavBarDragCursor] := LoadCursor(HInstance, 'dxNavBarDragCursor');
  Screen.Cursors[dxNavBarDragCopyCursor] := LoadCursor(HInstance, 'dxNavBarDragCopyCursor');
  Screen.Cursors[dxNavBarLinksCursor] := LoadCursor(HInstance, 'dxNavBarLinksCursor');

finalization
  DestroyCursor(Screen.Cursors[dxNavBarLinksCursor]);
  DestroyCursor(Screen.Cursors[dxNavBarDragCopyCursor]);
  DestroyCursor(Screen.Cursors[dxNavBarDragCursor]);
  FreeAndNil(FNavBarCustomizeFormManager);
  FUnitIsFinalized := True;

end.
