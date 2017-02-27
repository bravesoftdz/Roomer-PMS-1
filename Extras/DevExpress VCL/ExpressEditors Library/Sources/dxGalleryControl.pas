
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressEditors                                               }
{                                                                    }
{       Copyright (c) 1998-2014 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSEDITORS AND ALL                }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
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

unit dxGalleryControl;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI17}
  UITypes,
{$ENDIF}
  Windows, SysUtils, Classes, Types, Graphics, Forms, Controls, StdCtrls, Messages, ImgList,
  dxCore, dxCoreClasses, cxClasses, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxGraphics, cxGeometry, dxGallery;

type
  TdxCustomGalleryControl = class;
  TdxGalleryControlGroup = class;
  TdxGalleryControlItem = class;
  TdxGalleryControlPainter = class;
  TdxGalleryControlPainterClass = class of TdxGalleryControlPainter;
  TdxGalleryControlOptionsItemImage = class;
  TdxGalleryControlOptionsItemText = class;
  TdxGalleryControlOptionsView = class;

  TdxGalleryControlItemEvent = procedure(Sender: TObject; AItem: TdxGalleryControlItem) of object;

  TdxGalleryControlItemMatrix = array of array of TdxGalleryControlItem;

  { TdxGalleryPersistent }

  TdxGalleryPersistent = class(TcxOwnedPersistent)
  private
    function GetOwnerControl: TdxCustomGalleryControl;
  protected
    property Owner: TdxCustomGalleryControl read GetOwnerControl;
  public
    constructor Create(AOwner: TdxCustomGalleryControl); reintroduce; virtual;
  end;

  { TdxGalleryCustomViewInfo }

  TdxGalleryCustomViewInfo = class(TObject)
  private
    function GetContentOffset: TRect; {$IFDEF DELPHI9}inline;{$ENDIF}
    function GetContentOffsetGroups: TRect; {$IFDEF DELPHI9}inline;{$ENDIF}
    function GetContentOffsetItems: TRect; {$IFDEF DELPHI9}inline;{$ENDIF}
    function GetOptionsItemImage: TdxGalleryControlOptionsItemImage; {$IFDEF DELPHI9}inline;{$ENDIF}
    function GetOptionsItemText: TdxGalleryControlOptionsItemText; {$IFDEF DELPHI9}inline;{$ENDIF}
    function GetOptionsView: TdxGalleryControlOptionsView; {$IFDEF DELPHI9}inline;{$ENDIF}
    function GetPainter: TdxGalleryControlPainter;
  protected
    FBounds: TRect;
    procedure DrawContent(ACanvas: TcxCanvas); virtual; abstract;
    function GetGalleryControl: TdxCustomGalleryControl; virtual; abstract;
  public
    procedure Calculate(AType: TdxChangeType; const ABounds: TRect); virtual; abstract;
    procedure Draw(ACanvas: TcxCanvas);
    //
    property Bounds: TRect read FBounds;
    property ContentOffset: TRect read GetContentOffset;
    property ContentOffsetGroups: TRect read GetContentOffsetGroups;
    property ContentOffsetItems: TRect read GetContentOffsetItems;
    property GalleryControl: TdxCustomGalleryControl read GetGalleryControl;
    property OptionsItemImage: TdxGalleryControlOptionsItemImage read GetOptionsItemImage;
    property OptionsItemText: TdxGalleryControlOptionsItemText read GetOptionsItemText;
    property OptionsView: TdxGalleryControlOptionsView read GetOptionsView;
    property Painter: TdxGalleryControlPainter read GetPainter;
  end;

  { TdxGalleryItemViewInfo }

  TdxGalleryItemViewInfo = class(TdxGalleryCustomViewInfo)
  private
    FCacheGlyph: TcxBitmap32;
    FItem: TdxGalleryControlItem;
    function GetCacheGlyph: TcxBitmap32;
    function GetCaption: string;
    function GetDescription: string;
    function GetGlyphSize: TSize;
  protected
    FCaptionRect: TRect;
    FCaptionSize: TSize;
    FCellPositionInGroup: TPoint;
    FContentBounds: TRect;
    FDescriptionRect: TRect;
    FDescriptionSize: TSize;
    FGlyphFrameRect: TRect;
    FGlyphRect: TRect;
    FState: TdxGalleryItemViewState;
    FTextArea: TRect;
    procedure CalculateGlyphArea(const AGlyphSize: TSize); virtual;
    procedure CalculateTextArea(const ATextAreaSize: TSize); virtual;
    procedure CalculateTextAreaContent(const ABounds: TRect); virtual;
    procedure DrawContent(ACanvas: TcxCanvas); override;
    function GetDescriptionOffset: Integer; virtual;
    function GetGalleryControl: TdxCustomGalleryControl; override;
    function GetTextAreaSize: TSize; virtual;
    procedure ResetCache; virtual;
  public
    constructor Create(AItem: TdxGalleryControlItem); virtual;
    destructor Destroy; override;
    procedure Calculate(AType: TdxChangeType; const ABounds: TRect); override;
    procedure CalculateTextAreaSizeLimitedByRowCount(ACanvas: TcxCanvas; ARowCount: Integer); virtual;
    procedure CalculateTextAreaSizeLimitedByWidth(ACanvas: TcxCanvas; AMaxWidth: Integer); virtual;

    property CacheGlyph: TcxBitmap32 read GetCacheGlyph;
    property Caption: string read GetCaption;
    property CaptionRect: TRect read FCaptionRect;
    property CaptionSize: TSize read FCaptionSize;
    property CellPositionInGroup: TPoint read FCellPositionInGroup;
    property ContentBounds: TRect read FContentBounds;
    property Description: string read GetDescription;
    property DescriptionOffset: Integer read GetDescriptionOffset;
    property DescriptionRect: TRect read FDescriptionRect;
    property DescriptionSize: TSize read FDescriptionSize;
    property GlyphFrameRect: TRect read FGlyphFrameRect;
    property GlyphRect: TRect read FGlyphRect;
    property GlyphSize: TSize read GetGlyphSize;
    property Item: TdxGalleryControlItem read FItem;
    property State: TdxGalleryItemViewState read FState;
    property TextArea: TRect read FTextArea;
    property TextAreaSize: TSize read GetTextAreaSize;
  end;

  { TdxGalleryControlItem }

  TdxGalleryControlItem = class(TdxGalleryItem)
  private
    FViewInfo: TdxGalleryItemViewInfo;
    function GetGroup: TdxGalleryControlGroup;
    function GetGalleryControl: TdxCustomGalleryControl;
    function GetImages: TCustomImageList;
  protected
    function CreateViewInfo: TdxGalleryItemViewInfo; virtual;

    property GalleryControl: TdxCustomGalleryControl read GetGalleryControl;
    property Images: TCustomImageList read GetImages;
    property ViewInfo: TdxGalleryItemViewInfo read FViewInfo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Group: TdxGalleryControlGroup read GetGroup;
  published
    property Caption;
    property Checked;
    property Description;
    property Enabled;
    property Glyph;
    property Hint;
    property ImageIndex;
  end;

  { TdxGalleryControlItems }

  TdxGalleryControlItems = class(TdxGalleryItems)
  private
    function GetItem(AIndex: Integer): TdxGalleryControlItem;
    procedure SetItem(AIndex: Integer; AValue: TdxGalleryControlItem);
  public
    function Add: TdxGalleryControlItem;
    function GetItemAtPos(const P: TPoint): TdxGalleryControlItem;

    property Items[AIndex: Integer]: TdxGalleryControlItem read GetItem write SetItem; default;
  end;

  { TdxGalleryGroupViewInfo }

  TdxGalleryGroupViewInfo = class(TdxGalleryCustomViewInfo)
  private
    FGroup: TdxGalleryControlGroup;
    function GetCaption: string;
    function GetSize: TSize;
  protected
    FCaptionRect: TRect;
    FCaptionTextRect: TRect;
    FColumnCount: Integer;
    FItemsRect: TRect;
    FRowCount: Integer;
    procedure CalculateCaption; virtual;
    procedure CalculateItems(AType: TdxChangeType); virtual;
    procedure DrawContent(ACanvas: TcxCanvas); override;
    function GetCaptionHeight: Integer; virtual;
    function GetCaptionTextOffsets: TRect; virtual;
    function GetFont: TFont; virtual;
    function GetGalleryControl: TdxCustomGalleryControl; override;
    procedure PlaceItem(AItem: TdxGalleryControlItem;
      AChangeType: TdxChangeType; const AItemsArea: TRect; ACellIndex: Integer);
  public
    constructor Create(AGroup: TdxGalleryControlGroup); virtual;
    procedure Calculate(AType: TdxChangeType; const ABounds: TRect); override;
    function GetMaxColumnCount: Integer; virtual;
    //
    property Caption: string read GetCaption;
    property CaptionRect: TRect read FCaptionRect;
    property CaptionTextOffsets: TRect read GetCaptionTextOffsets;
    property CaptionTextRect: TRect read FCaptionTextRect;
    property ColumnCount: Integer read FColumnCount;
    property Font: TFont read GetFont;
    property Group: TdxGalleryControlGroup read FGroup;
    property ItemSize: TSize read GetSize;
    property ItemsRect: TRect read FItemsRect;
    property RowCount: Integer read FRowCount;
  end;

  { TdxGalleryControlGroup }

  TdxGalleryControlGroup = class(TdxGalleryGroup)
  private
    FViewInfo: TdxGalleryGroupViewInfo;
    function GetGalleryControl: TdxCustomGalleryControl;
    function GetItems: TdxGalleryControlItems;
  protected
    function CreateViewInfo: TdxGalleryGroupViewInfo; virtual;
    function GetGalleryItemClass: TdxGalleryItemClass; override;
    function GetGalleryItemsClass: TdxGalleryItemsClass; override;

    property GalleryControl: TdxCustomGalleryControl read GetGalleryControl;
    property ViewInfo: TdxGalleryGroupViewInfo read FViewInfo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //
    property Items: TdxGalleryControlItems read GetItems;
  published
    property Caption;
    property ShowCaption default True;
    property Visible default True;
  end;

  { TdxGalleryControlGroups }

  TdxGalleryControlGroups = class(TdxGalleryGroups)
  private
    function GetGroup(AIndex: Integer): TdxGalleryControlGroup;
    procedure SetGroup(AIndex: Integer; AValue: TdxGalleryControlGroup);
  public
    function Add: TdxGalleryControlGroup;
    function FindByCaption(const ACaption: string; out AGroup: TdxGalleryControlGroup): Boolean;
    function GetItemAtPos(const P: TPoint): TdxGalleryControlItem;

    property Groups[AIndex: Integer]: TdxGalleryControlGroup read GetGroup write SetGroup; default;
  end;

  { TdxGalleryControlStructure }

  TdxGalleryControlStructure = class(TdxGallery)
  private
    function GetGroups: TdxGalleryControlGroups;
  protected
    function GetGroupClass: TdxGalleryGroupClass; override;
    function GetGroupsClass: TdxGalleryGroupsClass; override;
  public
    function GetCheckedItem: TdxGalleryControlItem;
    function GetFirstItem: TdxGalleryControlItem;

    property Groups: TdxGalleryControlGroups read GetGroups;
  end;

  { TdxGalleryControlPainter }

  TdxGalleryControlPainter = class(TdxGalleryPersistent)
  private
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainter; {$IFDEF DELPHI9}inline;{$ENDIF}
  protected
    function DrawItemSelectionFirst: Boolean; virtual;
    function GetGroupCaptionTextColor: TColor; virtual;
    function GetItemCaptionTextColor(const AState: TdxGalleryItemViewState): TColor; virtual;
    function GetItemDescriptionTextColor(const AState: TdxGalleryItemViewState): TColor; virtual;
  public
    procedure DrawBackground(ACanvas: TcxCanvas; const ABounds: TRect); virtual;
    // Group
    procedure DrawGroupHeader(ACanvas: TcxCanvas; const AViewInfo: TdxGalleryGroupViewInfo); virtual;
    procedure DrawGroupHeaderText(ACanvas: TcxCanvas; const AViewInfo: TdxGalleryGroupViewInfo); virtual;
    function GetGroupHeaderContentOffsets: TRect; virtual;
    // Items
    procedure DrawItem(ACanvas: TcxCanvas; AViewInfo: TdxGalleryItemViewInfo); virtual;
    procedure DrawItemImage(ACanvas: TcxCanvas; AViewInfo: TdxGalleryItemViewInfo); virtual;
    procedure DrawItemSelection(ACanvas: TcxCanvas; AViewInfo: TdxGalleryItemViewInfo); virtual;
    procedure DrawItemText(ACanvas: TcxCanvas; AViewInfo: TdxGalleryItemViewInfo); virtual;
    //
    property LookAndFeelPainter: TcxCustomLookAndFeelPainter read GetLookAndFeelPainter;
  end;

  { TdxGalleryControlViewInfo }

  TdxGalleryControlViewInfo = class(TdxGalleryCustomViewInfo)
  private
    FGalleryControl: TdxCustomGalleryControl;
    function GetAutoHeight: Boolean;
    function GetAutoWidth: Boolean;
    function GetColumnAutoWidth: Boolean;
    function GetFont: TFont;  {$IFDEF DELPHI9}inline;{$ENDIF}
    function GetGroups: TdxGalleryControlGroups; {$IFDEF DELPHI9}inline;{$ENDIF}
    function GetMaxColumnCount: Integer;
    function GetRowCount: Integer;
  protected
    FColumnCount: Integer;
    FContentBounds: TRect;
    FImageSize: TSize;
    FItemSize: TSize;
    FTextAreaSize: TSize;
    procedure CalculateColumnCount; virtual;
    procedure CalculateContentBounds(AType: TdxChangeType); virtual;
    procedure CalculateItemSize; virtual;
    function CalculateMaxItemImageSize: TSize; virtual;
    function CalculateMaxItemTextAreaSize(const AImageSize: TSize): TSize; virtual;
    function CalculateMaxItemTextAreaSizeLimitedByRowCount(ARowCount: Integer): TSize; virtual;
    function CalculateMaxItemTextAreaSizeLimitedByWidth(AMaxWidth: Integer): TSize; virtual;
    function DoCalculateItemSize: TSize; virtual;
    procedure DrawContent(ACanvas: TcxCanvas); override;
    function GetAvailableGroupsAreaWidth: Integer; virtual;
    function GetBorderWidths: TRect; virtual;
    function GetGalleryControl: TdxCustomGalleryControl; override;
    function GetTextAreaMaxRowCount(const AImageSize: TSize): Integer; virtual;
    function GetTextAreaMaxWidth(const AImageSize: TSize): Integer; virtual;
  public
    constructor Create(AGalleryControl: TdxCustomGalleryControl); virtual;
    procedure Calculate(AType: TdxChangeType; const ABounds: TRect); override;
    //
    property AutoHeight: Boolean read GetAutoHeight;
    property AutoWidth: Boolean read GetAutoWidth;
    property BorderWidths: TRect read GetBorderWidths;
    property ColumnAutoWidth: Boolean read GetColumnAutoWidth;
    property ColumnCount: Integer read FColumnCount;
    property ContentBounds: TRect read FContentBounds;
    property Font: TFont read GetFont;
    property Groups: TdxGalleryControlGroups read GetGroups;
    property ImageSize: TSize read FImageSize;
    property ItemSize: TSize read FItemSize;
    property MaxColumnCount: Integer read GetMaxColumnCount;
    property RowCount: Integer read GetRowCount;
    property TextAreaSize: TSize read FTextAreaSize;
  end;

  { TdxGalleryControlNavigationMatrix }

  TdxGalleryControlNavigationMatrix = class(TObject)
  private
    FColumnCount: Integer;
    FRowCount: Integer;
    FValues: TdxGalleryControlItemMatrix;
    function GetValue(ACol, ARow: Integer): TdxGalleryControlItem;
    procedure SetValue(ACol, ARow: Integer; const AValue: TdxGalleryControlItem);
  protected
    procedure Populate(AViewInfo: TdxGalleryControlViewInfo); virtual;
  public
    constructor Create(AViewInfo: TdxGalleryControlViewInfo);
    destructor Destroy; override;
    function GetRightMostItemIndex(ARow: Integer): Integer;
    //
    property ColumnCount: Integer read FColumnCount;
    property RowCount: Integer read FRowCount;
    property Values[ACol, ARow: Integer]: TdxGalleryControlItem read GetValue write SetValue;
  end;

  { TdxGalleryControlController }

  TdxGalleryControlController = class(TdxGalleryPersistent)
  private
    FKeyPressed: Boolean;
    FKeySelectedItem: TdxGalleryControlItem;
    FMouseHoveredItem: TdxGalleryControlItem;
    FMousePressed: Boolean;
    FNavigationMatrix: TdxGalleryControlNavigationMatrix;

    function GetGallery: TdxGalleryControlStructure; {$IFDEF DELPHI9}inline;{$ENDIF}
    function GetNavigationMatrix: TdxGalleryControlNavigationMatrix;
    function GetViewInfo: TdxGalleryControlViewInfo; {$IFDEF DELPHI9}inline;{$ENDIF}
    procedure SetKeyPressed(AValue: Boolean);
    procedure SetKeySelectedItem(AItem: TdxGalleryControlItem);
    procedure SetMouseHoveredItem(AItem: TdxGalleryControlItem);
    procedure SetMousePressed(AValue: Boolean);
  protected
    function GetItemAtPos(const P: TPoint): TdxGalleryControlItem;
    function GetItemPosition(AItem: TdxGalleryControlItem): TPoint; virtual;
    function GetItemViewState(AItem: TdxGalleryControlItem): TdxGalleryItemViewState;
    procedure InvalidateItem(AItem: TdxGalleryControlItem);
    procedure MakeItemVisible(AItem: TdxGalleryControlItem); virtual;
    procedure UpdateItemViewState(AItem: TdxGalleryControlItem);
    procedure UpdateMouseHoveredItem(const P: TPoint); virtual;

    // Navigation
    function CreateNavigationMatrix: TdxGalleryControlNavigationMatrix; virtual;
    procedure GetNextItem(var AItemPos: TPoint; ADirectionX, ADirectionY: Integer); virtual;
    function GetStartItemForKeyboardNavigation: TdxGalleryControlItem; virtual;
    procedure SelectNextItem(AItem: TdxGalleryControlItem; ADirectionX, ADirectionY: Integer); virtual;

    procedure ProcessItemClick(AItem: TdxGalleryControlItem; X, Y: Integer); virtual;
  public
    procedure CheckSelectedItem; virtual;
    procedure LayoutChanged; virtual;
    // Keyboard
    procedure FocusEnter; virtual;
    procedure FocusLeave; virtual;
    procedure KeyDown(AKey: Word; AShift: TShiftState); virtual;
    procedure KeyUp(AKey: Word; AShift: TShiftState); virtual;
    // Mouse
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseLeave; virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    //
    property Gallery: TdxGalleryControlStructure read GetGallery;
    property KeyPressed: Boolean read FKeyPressed write SetKeyPressed;
    property KeySelectedItem: TdxGalleryControlItem read FKeySelectedItem write SetKeySelectedItem;
    property MouseHoveredItem: TdxGalleryControlItem read FMouseHoveredItem write SetMouseHoveredItem;
    property MousePressed: Boolean read FMousePressed write SetMousePressed;
    property NavigationMatrix: TdxGalleryControlNavigationMatrix read GetNavigationMatrix;
    property ViewInfo: TdxGalleryControlViewInfo read GetViewInfo;
  end;

  { TdxGalleryControlCustomOptions }

  TdxGalleryControlCustomOptions = class(TdxGalleryPersistent)
  protected
    procedure Changed(AType: TdxChangeType = ctHard);
  end;

  { TdxGalleryControlOptionsBehavior }

  TdxGalleryControlOptionsBehavior = class(TdxGalleryControlCustomOptions)
  private
    FItemShowHint: Boolean;
    function GetItemCheckMode: TdxGalleryItemCheckMode;
    procedure SetItemCheckMode(const Value: TdxGalleryItemCheckMode);
  protected
    procedure DoAssign(Source: TPersistent); override;
  published
    property ItemCheckMode: TdxGalleryItemCheckMode read GetItemCheckMode write SetItemCheckMode default icmNone;
    property ItemShowHint: Boolean read FItemShowHint write FItemShowHint default False;
  end;

  { TdxGalleryControlOptionsItemImage }

  TdxGalleryControlOptionsItemImage = class(TdxGalleryControlCustomOptions)
  private
    FShowFrame: Boolean;
    FSize: TcxSize;
    procedure ChangeHandler(Sender: TObject);
    procedure SetShowFrame(const Value: Boolean);
    procedure SetSize(const Value: TcxSize);
  protected
    procedure DoAssign(Source: TPersistent); override;
  public
    constructor Create(AOwner: TdxCustomGalleryControl); override;
    destructor Destroy; override;
  published
    property ShowFrame: Boolean read FShowFrame write SetShowFrame default True;
    property Size: TcxSize read FSize write SetSize;
  end;

  { TdxGalleryControlOptionsItemText }

  TdxGalleryControlOptionsItemText = class(TdxGalleryControlCustomOptions)
  private
    FAlignHorz: TAlignment;
    FAlignVert: TcxAlignmentVert;
    FPosition: TcxPosition;
    FWordWrap: Boolean;
    procedure SetAlignHorz(const Value: TAlignment);
    procedure SetAlignVert(const Value: TcxAlignmentVert);
    procedure SetPosition(const Value: TcxPosition);
    procedure SetWordWrap(const Value: Boolean);
  protected
    procedure DoAssign(Source: TPersistent); override;
  public
    constructor Create(AOwner: TdxCustomGalleryControl); override;
  published
    property AlignHorz: TAlignment read FAlignHorz write SetAlignHorz default taCenter;
    property AlignVert: TcxAlignmentVert read FAlignVert write SetAlignVert default vaTop;
    property Position: TcxPosition read FPosition write SetPosition default posNone;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default True;
  end;

  { TdxGalleryControlOptionsItem }

  TdxGalleryControlOptionsItem = class(TdxGalleryControlCustomOptions)
  private
    FImage: TdxGalleryControlOptionsItemImage;
    FText: TdxGalleryControlOptionsItemText;
    procedure SetImage(AValue: TdxGalleryControlOptionsItemImage);
    procedure SetText(AValue: TdxGalleryControlOptionsItemText);
  protected
    function CreateImage: TdxGalleryControlOptionsItemImage; virtual;
    function CreateText: TdxGalleryControlOptionsItemText; virtual;
    procedure DoAssign(Source: TPersistent); override;
  public
    constructor Create(AOwner: TdxCustomGalleryControl); override;
    destructor Destroy; override;
  published
    property Image: TdxGalleryControlOptionsItemImage read FImage write SetImage;
    property Text: TdxGalleryControlOptionsItemText read FText write SetText;
  end;

  { TdxGalleryControlOptionsView }

  TdxGalleryControlOptionsView = class(TdxGalleryControlCustomOptions)
  private
    FColumnAutoWidth: Boolean;
    FColumnCount: Integer;
    FContentOffset: TcxMargin;
    FContentOffsetGroups: TcxMargin;
    FContentOffsetItems: TcxMargin;
    FItem: TdxGalleryControlOptionsItem;
    procedure ChangeHandler(Sender: TObject);
    procedure SetColumnAutoWidth(AValue: Boolean);
    procedure SetColumnCount(AValue: Integer);
    procedure SetContentOffset(const Value: TcxMargin);
    procedure SetContentOffsetGroups(const Value: TcxMargin);
    procedure SetContentOffsetItems(const Value: TcxMargin);
    procedure SetItem(const Value: TdxGalleryControlOptionsItem);
  protected
    function CreateItem: TdxGalleryControlOptionsItem; virtual;
    procedure DoAssign(Source: TPersistent); override;
  public
    constructor Create(AOwner: TdxCustomGalleryControl); override;
    destructor Destroy; override;
  published
    property ColumnAutoWidth: Boolean read FColumnAutoWidth write SetColumnAutoWidth default False;
    property ColumnCount: Integer read FColumnCount write SetColumnCount default 0;
    property ContentOffset: TcxMargin read FContentOffset write SetContentOffset;
    property ContentOffsetGroups: TcxMargin read FContentOffsetGroups write SetContentOffsetGroups;
    property ContentOffsetItems: TcxMargin read FContentOffsetItems write SetContentOffsetItems;
    property Item: TdxGalleryControlOptionsItem read FItem write SetItem;
  end;

  { TdxCustomGalleryControl }

  TdxCustomGalleryControl = class(TcxScrollingControl, IdxSkinSupport, IdxGalleryOwner)
  private
    FController: TdxGalleryControlController;
    FGallery: TdxGalleryControlStructure;
    FImages: TCustomImageList;
    FLockCount: Integer;
    FOptionsBehavior: TdxGalleryControlOptionsBehavior;
    FOptionsView: TdxGalleryControlOptionsView;
    FPainter: TdxGalleryControlPainter;
    FViewInfo: TdxGalleryControlViewInfo;

    FOnItemClick: TdxGalleryControlItemEvent;

    function GetColumnCount: Integer;
    function GetContentOffset: TcxMargin;
    function GetContentOffsetGroups: TcxMargin;
    function GetContentOffsetItems: TcxMargin;
    function GetItemCheckMode: TdxGalleryItemCheckMode;
    function GetItemCount: Integer;
    function GetItemImageSize: TcxSize;
    function GetItemShowHint: Boolean;
    function GetItemShowImageFrame: Boolean;
    function GetItemTextPosition: TcxPosition;
    procedure SetColumnCount(AValue: Integer);
    procedure SetContentOffset(AValue: TcxMargin);
    procedure SetContentOffsetGroups(AValue: TcxMargin);
    procedure SetContentOffsetItems(AValue: TcxMargin);
    procedure SetGallery(AValue: TdxGalleryControlStructure);
    procedure SetImages(Value: TCustomImageList);
    procedure SetItemCheckMode(AValue: TdxGalleryItemCheckMode);
    procedure SetItemImageSize(AValue: TcxSize);
    procedure SetItemShowHint(const Value: Boolean);
    procedure SetItemShowImageFrame(AValue: Boolean);
    procedure SetItemTextPosition(AValue: TcxPosition);
    procedure SetOptionsBehavior(const Value: TdxGalleryControlOptionsBehavior);
    procedure SetOptionsView(const Value: TdxGalleryControlOptionsView);

    procedure GalleryChangeHandler(ASender: TObject; AChangeType: TdxGalleryChangeType);
    procedure GalleryItemClickHandler(ASender: TObject; AItem: TdxGalleryItem);

    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
  protected
    function CreateController: TdxGalleryControlController; virtual;
    function CreateGallery: TdxGalleryControlStructure; virtual;
    function CreateOptionsBehavior: TdxGalleryControlOptionsBehavior; virtual;
    function CreateOptionsView: TdxGalleryControlOptionsView; virtual;
    function CreatePainter: TdxGalleryControlPainter; virtual;
    function CreateViewInfo: TdxGalleryControlViewInfo; virtual;

    //Keyb operations
    procedure FocusEnter; override;
    procedure FocusLeave; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;

    // Mouse operations
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseLeave(AControl: TControl); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    // TWinControl
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;

    // TcxScrollingControl
    function GetContentSize: TSize; override;
    procedure Calculate(AType: TdxChangeType); override;
    procedure LayoutChanged(AType: TdxChangeType = ctHard); override;

    // TcxControl
    procedure SetAutoSizeMode(AValue: TdxAutoSizeMode); override;

    // TdxCustomGalleryControl
    procedure DoClickItem(AItem: TdxGalleryItem); virtual;
    function GetItemAtPos(const P: TPoint): TdxGalleryControlItem;
    function IsUpdateLocked: Boolean;
    procedure BeginUpdate;
    procedure EndUpdate;

    // IdxGalleryOwner
    function GetGallery: IdxGallery;

    property Controller: TdxGalleryControlController read FController;
    property Painter: TdxGalleryControlPainter read FPainter;
    property ViewInfo: TdxGalleryControlViewInfo read FViewInfo;

    property Gallery: TdxGalleryControlStructure read FGallery write SetGallery;
    property Images: TCustomImageList read FImages write SetImages;
    property OptionsBehavior: TdxGalleryControlOptionsBehavior read FOptionsBehavior write SetOptionsBehavior;
    property OptionsView: TdxGalleryControlOptionsView read FOptionsView write SetOptionsView;
    // Obsolete
    property ColumnCount: Integer read GetColumnCount write SetColumnCount;
    property ContentOffset: TcxMargin read GetContentOffset write SetContentOffset;
    property ContentOffsetGroups: TcxMargin read GetContentOffsetGroups write SetContentOffsetGroups;
    property ContentOffsetItems: TcxMargin read GetContentOffsetItems write SetContentOffsetItems;
    property ItemCheckMode: TdxGalleryItemCheckMode read GetItemCheckMode write SetItemCheckMode;
    property ItemImageSize: TcxSize read GetItemImageSize write SetItemImageSize;
    property ItemShowHint: Boolean read GetItemShowHint write SetItemShowHint;
    property ItemShowImageFrame: Boolean read GetItemShowImageFrame write SetItemShowImageFrame;
    property ItemTextPosition: TcxPosition read GetItemTextPosition write SetItemTextPosition;

    property OnItemClick: TdxGalleryControlItemEvent read FOnItemClick write FOnItemClick;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  end;

  { TdxGalleryControl }

  TdxGalleryControl = class(TdxCustomGalleryControl)
  published
    property Align;
    property Anchors;
    property Enabled;
    property Font;
    property PopupMenu;
    property Visible;

    property AutoSizeMode default asNone;
    property BorderStyle default cxcbsDefault;
    property Gallery;
    property Images;
    property LookAndFeel;
    property OptionsBehavior;
    property OptionsView;

    // Obsolete
    property ColumnCount stored False;
    property ContentOffset stored False;
    property ContentOffsetGroups stored False;
    property ContentOffsetItems stored False;
    property ItemCheckMode stored False;
    property ItemImageSize stored False;
    property ItemShowHint stored False;
    property ItemShowImageFrame stored False;
    property ItemTextPosition stored False;

    property OnClick;
    property OnDblClick;
    property OnContextPopup;
    property OnItemClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

implementation

uses
  Math, cxScrollBar, cxDrawTextUtils;

const
  dxcItemGlyphFrameOffset = 2;
  dxcItemIndentBetweenGlyphAndText = 4;

type
  TdxGalleryAccess = class(TdxGallery);

function GetCombinedSize(const AMasterSize, ASlaveSize: TSize): TSize;
begin
  if AMasterSize.cx <> 0 then
    Result.cx := AMasterSize.cx
  else
    Result.cx := ASlaveSize.cx;

  if AMasterSize.cy <> 0 then
    Result.cy := AMasterSize.cy
  else
    Result.cy := ASlaveSize.cy;
end;

{ TdxGalleryPersistent }

constructor TdxGalleryPersistent.Create(AOwner: TdxCustomGalleryControl);
begin
  inherited Create(AOwner);
end;

function TdxGalleryPersistent.GetOwnerControl: TdxCustomGalleryControl;
begin
  Result := inherited Owner as TdxCustomGalleryControl;
end;

{ TdxGalleryCustomViewInfo }

procedure TdxGalleryCustomViewInfo.Draw(ACanvas: TcxCanvas);
begin
  if ACanvas.RectVisible(Bounds) then
    DrawContent(ACanvas);
end;

function TdxGalleryCustomViewInfo.GetContentOffset: TRect;
begin
  Result := OptionsView.ContentOffset.Margin;
end;

function TdxGalleryCustomViewInfo.GetContentOffsetGroups: TRect;
begin
  Result := OptionsView.ContentOffsetGroups.Margin;
end;

function TdxGalleryCustomViewInfo.GetContentOffsetItems: TRect;
begin
  Result := OptionsView.ContentOffsetItems.Margin;
end;

function TdxGalleryCustomViewInfo.GetOptionsItemImage: TdxGalleryControlOptionsItemImage;
begin
  Result := OptionsView.Item.Image;
end;

function TdxGalleryCustomViewInfo.GetOptionsItemText: TdxGalleryControlOptionsItemText;
begin
  Result := OptionsView.Item.Text;
end;

function TdxGalleryCustomViewInfo.GetOptionsView: TdxGalleryControlOptionsView;
begin
  Result := GalleryControl.OptionsView;
end;

function TdxGalleryCustomViewInfo.GetPainter: TdxGalleryControlPainter;
begin
  Result := GalleryControl.Painter;
end;

{ TdxGalleryItemViewInfo }

constructor TdxGalleryItemViewInfo.Create(AItem: TdxGalleryControlItem);
begin
  inherited Create;
  FItem := AItem;
end;

destructor TdxGalleryItemViewInfo.Destroy;
begin
  FreeAndNil(FCacheGlyph);
  inherited Destroy;
end;

procedure TdxGalleryItemViewInfo.Calculate(AType: TdxChangeType; const ABounds: TRect);
begin
  if AType <> ctLight then
    ResetCache;

  FBounds := ABounds;
  FState := GalleryControl.Controller.GetItemViewState(Item);
  FContentBounds := cxRectContent(Bounds, ContentOffsetItems);
  CalculateTextArea(GalleryControl.ViewInfo.TextAreaSize);
  CalculateGlyphArea(GlyphSize);
end;

procedure TdxGalleryItemViewInfo.CalculateTextAreaSizeLimitedByRowCount(ACanvas: TcxCanvas; ARowCount: Integer);
var
  R: TRect;
begin
  if OptionsItemText.WordWrap then
    FCaptionSize := cxSize(cxGetTextRect(ACanvas.Handle, Caption, ARowCount))
  else
    FCaptionSize := cxTextSize(ACanvas.Handle, Caption);

  if Caption <> '' then
  begin
    R := cxRect(0, 0, FCaptionSize.cx, 1);
    cxDrawText(ACanvas.Handle, Description, R, DT_CALCRECT or DT_WORDBREAK);
    FDescriptionSize := cxSize(R);
  end
  else
    FDescriptionSize := cxSize(cxGetTextRect(ACanvas.Handle, Description, ARowCount));
end;

procedure TdxGalleryItemViewInfo.CalculateTextAreaSizeLimitedByWidth(ACanvas: TcxCanvas; AMaxWidth: Integer);
const
  WordWrapMap: array[Boolean] of Integer = (0, DT_WORDBREAK);
var
  R: TRect;
begin
  R := cxRect(0, 0, AMaxWidth, 1);
  cxDrawText(ACanvas.Handle, Caption, R, DT_CALCRECT or WordWrapMap[OptionsItemText.WordWrap]);
  FCaptionSize := cxSize(R);

  R := cxRect(0, 0, AMaxWidth, 1);
  cxDrawText(ACanvas.Handle, Description, R, DT_CALCRECT or DT_WORDBREAK);
  FDescriptionSize := cxSize(R)
end;

procedure TdxGalleryItemViewInfo.CalculateGlyphArea(const AGlyphSize: TSize);

 function MinOffset(const ARect: TRect): Integer;
 begin
   Result := Min(ARect.Left, ARect.Right);
   Result := Min(Result, ARect.Top);
   Result := Min(Result, ARect.Bottom);
 end;

var
  AGlyphFrameOffset: Integer;
begin
  FGlyphRect := cxNullRect;
  FGlyphFrameRect := cxNullRect;
  if not cxSizeIsEmpty(AGlyphSize) then
  begin
    AGlyphFrameOffset := Min(dxcItemGlyphFrameOffset, MinOffset(ContentOffsetItems));

    FGlyphRect := ContentBounds;
    case OptionsItemText.Position of
      posLeft:
        FGlyphRect.Left := TextArea.Right + AGlyphFrameOffset + dxcItemIndentBetweenGlyphAndText;
      posRight:
        FGlyphRect.Right := TextArea.Left - AGlyphFrameOffset - dxcItemIndentBetweenGlyphAndText;
      posBottom:
        FGlyphRect.Bottom := TextArea.Top - AGlyphFrameOffset - dxcItemIndentBetweenGlyphAndText;
      posTop:
        FGlyphRect.Top := TextArea.Bottom + AGlyphFrameOffset + dxcItemIndentBetweenGlyphAndText;
    end;
    FGlyphRect := cxGetImageRect(GlyphRect, GlyphSize, ifmFit);

    if OptionsItemImage.ShowFrame then
      FGlyphFrameRect := cxRectInflate(GlyphRect, AGlyphFrameOffset, AGlyphFrameOffset);
  end;
end;

procedure TdxGalleryItemViewInfo.CalculateTextArea(const ATextAreaSize: TSize);
var
  R: TRect;
begin
  case OptionsItemText.Position of
    posLeft:
      FTextArea := cxRectSetWidth(ContentBounds, ATextAreaSize.cx);
    posRight:
      FTextArea := cxRectSetRight(ContentBounds, ContentBounds.Right, ATextAreaSize.cx);
    posBottom:
      FTextArea := cxRectSetBottom(ContentBounds, ContentBounds.Bottom, ATextAreaSize.cy);
    posTop:
      FTextArea := cxRectSetHeight(ContentBounds, ATextAreaSize.cy);
  else
    FTextArea := cxNullRect;
  end;

  case OptionsItemText.AlignVert of
    vaBottom:
      R := cxRectSetBottom(TextArea, TextArea.Bottom, TextAreaSize.cy);
    vaCenter:
      R := cxRectCenterVertically(TextArea, TextAreaSize.cy);
  else
    R := cxRectSetHeight(TextArea, TextAreaSize.cy);
  end;

  CalculateTextAreaContent(R);
end;

procedure TdxGalleryItemViewInfo.CalculateTextAreaContent(const ABounds: TRect);
begin
  FCaptionRect := cxRectSetSize(ABounds, cxRectWidth(ABounds), CaptionSize.cy);
  FDescriptionRect := cxRectSetTop(ABounds, CaptionRect.Bottom + DescriptionOffset, DescriptionSize.cy);
  FDescriptionRect := cxRectSetWidth(DescriptionRect, cxRectWidth(ABounds));
end;

procedure TdxGalleryItemViewInfo.DrawContent(ACanvas: TcxCanvas);
begin
  Painter.DrawItem(ACanvas, Self);
end;

function TdxGalleryItemViewInfo.GetDescription: string;
begin
  Result := Item.Description;
end;

function TdxGalleryItemViewInfo.GetGalleryControl: TdxCustomGalleryControl;
begin
  Result := Item.GalleryControl;
end;

function TdxGalleryItemViewInfo.GetTextAreaSize: TSize;
begin
  Result.cx := Max(CaptionSize.cx, DescriptionSize.cx);
  Result.cy := CaptionSize.cy + DescriptionSize.cy + DescriptionOffset;
end;

procedure TdxGalleryItemViewInfo.ResetCache;
begin
  FreeAndNil(FCacheGlyph);
end;

function TdxGalleryItemViewInfo.GetCacheGlyph: TcxBitmap32;
begin
  if FCacheGlyph = nil then
  begin
    FCacheGlyph := TcxBitmap32.CreateSize(GlyphRect, True);
    cxDrawImage(FCacheGlyph.cxCanvas, FCacheGlyph.ClientRect, Item.Glyph,
      Item.Images, Item.ImageIndex, ifmFit, EnabledImageDrawModeMap[State.Enabled]);
  end;
  Result := FCacheGlyph;
end;

function TdxGalleryItemViewInfo.GetCaption: string;
begin
  Result := Item.Caption;
end;

function TdxGalleryItemViewInfo.GetDescriptionOffset: Integer;
begin
  if (CaptionSize.cy > 0) and (DescriptionSize.cy > 0) then
    Result := cxTextOffset
  else
    Result := 0;
end;

function TdxGalleryItemViewInfo.GetGlyphSize: TSize;
begin
  Result := dxGetImageSize(Item.Glyph, Item.Images, Item.ImageIndex);
end;

{ TdxGalleryControlItem }

constructor TdxGalleryControlItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FViewInfo := CreateViewInfo;
end;

destructor TdxGalleryControlItem.Destroy;
begin
  FreeAndNil(FViewInfo);
  inherited Destroy;
end;

function TdxGalleryControlItem.CreateViewInfo: TdxGalleryItemViewInfo;
begin
  Result := TdxGalleryItemViewInfo.Create(Self);
end;

function TdxGalleryControlItem.GetGroup: TdxGalleryControlGroup;
begin
  Result := inherited Group as TdxGalleryControlGroup;
end;

function TdxGalleryControlItem.GetImages: TCustomImageList;
begin
  Result := GalleryControl.Images;
end;

function TdxGalleryControlItem.GetGalleryControl: TdxCustomGalleryControl;
begin
  Result := Gallery.GetParentComponent as TdxCustomGalleryControl
end;

{ TdxGalleryControlItems }

function TdxGalleryControlItems.Add: TdxGalleryControlItem;
begin
  Result := inherited Add as TdxGalleryControlItem;
end;

function TdxGalleryControlItems.GetItemAtPos(const P: TPoint): TdxGalleryControlItem;
var
  AItem: TdxGalleryControlItem;
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
  begin
    AItem := Items[I];
    if cxRectPtIn(AItem.ViewInfo.Bounds, P) then
    begin
      Result := AItem;
      Break;
    end;
  end;
end;

function TdxGalleryControlItems.GetItem(AIndex: Integer): TdxGalleryControlItem;
begin
  Result := inherited Items[AIndex] as TdxGalleryControlItem;
end;

procedure TdxGalleryControlItems.SetItem(AIndex: Integer; AValue: TdxGalleryControlItem);
begin
  inherited Items[AIndex] := AValue;
end;

{ TdxGalleryGroupViewInfo }

constructor TdxGalleryGroupViewInfo.Create(AGroup: TdxGalleryControlGroup);
begin
  inherited Create;
  FGroup := AGroup;
end;

procedure TdxGalleryGroupViewInfo.Calculate(AType: TdxChangeType; const ABounds: TRect);
begin
  FBounds := ABounds;
  if Group.Visible then
  begin
    CalculateCaption;
    FColumnCount := GalleryControl.ViewInfo.ColumnCount;
    FRowCount := Group.ItemCount div ColumnCount + Ord(Group.ItemCount mod ColumnCount <> 0);
    FItemsRect := cxRect(Bounds.Left, CaptionRect.Bottom, 0, 0);
    FItemsRect := cxRectContent(ItemsRect, ContentOffsetGroups);
    FItemsRect := cxRectSetSize(ItemsRect, ColumnCount * ItemSize.cx, RowCount * ItemSize.cy);
    CalculateItems(AType);
    FBounds.Bottom := ItemsRect.Bottom + ContentOffsetGroups.Bottom;
  end
  else
    FBounds.Bottom := FBounds.Top;
end;

function TdxGalleryGroupViewInfo.GetMaxColumnCount: Integer;
begin
  Result := Group.ItemCount;
end;

procedure TdxGalleryGroupViewInfo.CalculateCaption;
begin
  FCaptionRect := cxRectSetHeight(Bounds, GetCaptionHeight);
  FCaptionTextRect := cxRectContent(CaptionRect, CaptionTextOffsets);
end;

procedure TdxGalleryGroupViewInfo.CalculateItems(AType: TdxChangeType);
var
  I: Integer;
begin
  for I := 0 to Group.ItemCount - 1 do
    PlaceItem(Group.Items[I], AType, ItemsRect, I);
end;

procedure TdxGalleryGroupViewInfo.DrawContent(ACanvas: TcxCanvas);
var
  I: Integer;
begin
  if not cxRectIsEmpty(CaptionRect) then
    Painter.DrawGroupHeader(ACanvas, Self);
  for I := 0 to Group.ItemCount - 1 do
    Group.Items[I].ViewInfo.Draw(ACanvas);
end;

function TdxGalleryGroupViewInfo.GetCaptionHeight: Integer;
begin
  if Group.ShowCaption and (Caption <> '') then
    Result := cxTextHeight(Font) + cxMarginsHeight(CaptionTextOffsets)
  else
    Result := 0;
end;

function TdxGalleryGroupViewInfo.GetCaptionTextOffsets: TRect;
begin
  Result := cxGetValueCurrentDPI(Painter.GetGroupHeaderContentOffsets);
end;

function TdxGalleryGroupViewInfo.GetFont: TFont;
begin
  Result := GalleryControl.Font;
end;

function TdxGalleryGroupViewInfo.GetGalleryControl: TdxCustomGalleryControl;
begin
  Result := Group.GalleryControl;
end;

procedure TdxGalleryGroupViewInfo.PlaceItem(AItem: TdxGalleryControlItem;
  AChangeType: TdxChangeType; const AItemsArea: TRect; ACellIndex: Integer);
var
  ARow, AColumn: Integer;
  P: TPoint;
begin
  ARow := ACellIndex div ColumnCount;
  AColumn := ACellIndex - ARow * ColumnCount;
  P := cxPointOffset(AItemsArea.TopLeft, ItemSize.cx * AColumn, ItemSize.cy * ARow);
  AItem.ViewInfo.FCellPositionInGroup := cxPoint(AColumn, ARow);
  AItem.ViewInfo.Calculate(AChangeType, cxRectBounds(P, ItemSize.cx, ItemSize.cy));
end;

function TdxGalleryGroupViewInfo.GetCaption: string;
begin
  Result := Group.Caption;
end;

function TdxGalleryGroupViewInfo.GetSize: TSize;
begin
  Result := GalleryControl.ViewInfo.ItemSize;
end;

{ TdxGalleryGroup }

constructor TdxGalleryControlGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FViewInfo := CreateViewInfo;
end;

destructor TdxGalleryControlGroup.Destroy;
begin
  FreeAndNil(FViewInfo);
  inherited Destroy;
end;

function TdxGalleryControlGroup.CreateViewInfo: TdxGalleryGroupViewInfo;
begin
  Result := TdxGalleryGroupViewInfo.Create(Self);
end;

function TdxGalleryControlGroup.GetGalleryItemClass: TdxGalleryItemClass;
begin
  Result := TdxGalleryControlItem;
end;

function TdxGalleryControlGroup.GetGalleryItemsClass: TdxGalleryItemsClass;
begin
  Result := TdxGalleryControlItems;
end;

function TdxGalleryControlGroup.GetGalleryControl: TdxCustomGalleryControl;
begin
  Result := Gallery.GetParentComponent as TdxCustomGalleryControl
end;

function TdxGalleryControlGroup.GetItems: TdxGalleryControlItems;
begin
  Result := inherited Items as TdxGalleryControlItems;
end;

{ TdxGalleryControlGroups }

function TdxGalleryControlGroups.Add: TdxGalleryControlGroup;
begin
  Result := inherited Add as TdxGalleryControlGroup;
end;

function TdxGalleryControlGroups.FindByCaption(
  const ACaption: string; out AGroup: TdxGalleryControlGroup): Boolean;
begin
  Result := inherited FindByCaption(ACaption, TdxGalleryGroup(AGroup));
end;

function TdxGalleryControlGroups.GetItemAtPos(const P: TPoint): TdxGalleryControlItem;
var
  AGroup: TdxGalleryControlGroup;
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
  begin
    AGroup := Groups[I];
    if AGroup.Visible then
    begin
      Result := AGroup.Items.GetItemAtPos(P);
      if Result <> nil then
        Break;
    end;
  end;
end;

function TdxGalleryControlGroups.GetGroup(AIndex: Integer): TdxGalleryControlGroup;
begin
  Result := inherited Groups[AIndex] as TdxGalleryControlGroup;
end;

procedure TdxGalleryControlGroups.SetGroup(AIndex: Integer; AValue: TdxGalleryControlGroup);
begin
  Groups[AIndex] := AValue;
end;

{ TdxGalleryControlStructure }

function TdxGalleryControlStructure.GetCheckedItem: TdxGalleryControlItem;
begin
  Result := inherited GetCheckedItem as TdxGalleryControlItem;
end;

function TdxGalleryControlStructure.GetFirstItem: TdxGalleryControlItem;
begin
  Result := inherited GetFirstItem as TdxGalleryControlItem;
end;

function TdxGalleryControlStructure.GetGroupClass: TdxGalleryGroupClass;
begin
  Result := TdxGalleryControlGroup;
end;

function TdxGalleryControlStructure.GetGroupsClass: TdxGalleryGroupsClass;
begin
  Result := TdxGalleryControlGroups;
end;

function TdxGalleryControlStructure.GetGroups: TdxGalleryControlGroups;
begin
  Result := inherited Groups as TdxGalleryControlGroups;
end;

{ TdxGalleryControlPainter }

procedure TdxGalleryControlPainter.DrawBackground(ACanvas: TcxCanvas; const ABounds: TRect);
begin
  LookAndFeelPainter.DrawGalleryBackground(ACanvas, ABounds);
end;

procedure TdxGalleryControlPainter.DrawGroupHeader(ACanvas: TcxCanvas; const AViewInfo: TdxGalleryGroupViewInfo);
begin
  LookAndFeelPainter.DrawGalleryGroupHeader(ACanvas, AViewInfo.CaptionRect);
  DrawGroupHeaderText(ACanvas, AViewInfo);
end;

procedure TdxGalleryControlPainter.DrawGroupHeaderText(ACanvas: TcxCanvas; const AViewInfo: TdxGalleryGroupViewInfo);
var
  ARect: TRect;
begin
  ACanvas.SaveState;
  try
    ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
    ACanvas.Font.Color := GetGroupCaptionTextColor;
    ARect := AViewInfo.CaptionTextRect;
    cxTextOut(ACanvas.Handle, AViewInfo.Caption, ARect, CXTO_CENTER_VERTICALLY or CXTO_END_ELLIPSIS or CXTO_SINGLELINE);
  finally
    ACanvas.RestoreState;
  end;
end;

function TdxGalleryControlPainter.GetGroupHeaderContentOffsets: TRect;
begin
  Result := LookAndFeelPainter.GetGalleryGroupHeaderContentOffsets;
end;

procedure TdxGalleryControlPainter.DrawItem(ACanvas: TcxCanvas; AViewInfo: TdxGalleryItemViewInfo);
begin
  if DrawItemSelectionFirst then
    DrawItemSelection(ACanvas, AViewInfo);
  DrawItemImage(ACanvas, AViewInfo);
  if not DrawItemSelectionFirst then
    DrawItemSelection(ACanvas, AViewInfo);
  DrawItemText(ACanvas, AViewInfo);
end;

procedure TdxGalleryControlPainter.DrawItemImage(ACanvas: TcxCanvas; AViewInfo: TdxGalleryItemViewInfo);
begin
  if not cxRectIsEmpty(AViewInfo.GlyphFrameRect) then
    LookAndFeelPainter.DrawGalleryItemImageFrame(ACanvas, AViewInfo.GlyphFrameRect);
  cxDrawImage(ACanvas, AViewInfo.GlyphRect, AViewInfo.CacheGlyph, nil, -1, ifmNormal, idmNormal);
end;

procedure TdxGalleryControlPainter.DrawItemSelection(ACanvas: TcxCanvas; AViewInfo: TdxGalleryItemViewInfo);
begin
  LookAndFeelPainter.DrawGalleryItemSelection(ACanvas, AViewInfo.Bounds, AViewInfo.State);
end;

procedure TdxGalleryControlPainter.DrawItemText(ACanvas: TcxCanvas; AViewInfo: TdxGalleryItemViewInfo);
const
  TextAlignHorzMap: array[TAlignment] of Integer = (CXTO_LEFT, CXTO_RIGHT, CXTO_CENTER_HORIZONTALLY);
  WordWrapMap: array[Boolean] of Integer = (0, CXTO_WORDBREAK);
var
  R: TRect;
begin
  R := AViewInfo.CaptionRect;
  if ACanvas.RectVisible(R) then
    cxTextOut(ACanvas.Canvas, AViewInfo.Caption, R,
      TextAlignHorzMap[AViewInfo.OptionsItemText.AlignHorz] or
      WordWrapMap[AViewInfo.OptionsItemText.WordWrap] or
      CXTO_PREVENT_LEFT_EXCEED or CXTO_PREVENT_TOP_EXCEED or CXTO_CENTER_VERTICALLY,
      nil, 0, 0, 0, GetItemCaptionTextColor(AViewInfo.State));

  R := AViewInfo.DescriptionRect;
  if ACanvas.RectVisible(R) then
    cxTextOut(ACanvas.Canvas, AViewInfo.Description, R,
      TextAlignHorzMap[AViewInfo.OptionsItemText.AlignHorz] or
      CXTO_WORDBREAK or CXTO_PREVENT_LEFT_EXCEED or CXTO_PREVENT_TOP_EXCEED or CXTO_CENTER_VERTICALLY,
      nil, 0, 0, 0, GetItemDescriptionTextColor(AViewInfo.State));
end;

function TdxGalleryControlPainter.DrawItemSelectionFirst: Boolean;
begin
  Result := LookAndFeelPainter.DrawGalleryItemSelectionFirst;
end;

function TdxGalleryControlPainter.GetGroupCaptionTextColor: TColor;
begin
  Result := LookAndFeelPainter.GetGalleryGroupTextColor;
end;

function TdxGalleryControlPainter.GetItemCaptionTextColor(const AState: TdxGalleryItemViewState): TColor;
begin
  Result := LookAndFeelPainter.GetGalleryItemCaptionTextColor(AState);
end;

function TdxGalleryControlPainter.GetItemDescriptionTextColor(const AState: TdxGalleryItemViewState): TColor;
begin
  Result := LookAndFeelPainter.GetGalleryItemDescriptionTextColor(AState);
end;

function TdxGalleryControlPainter.GetLookAndFeelPainter: TcxCustomLookAndFeelPainter;
begin
  Result := Owner.LookAndFeelPainter;
end;

{ TdxGalleryControlViewInfo }

constructor TdxGalleryControlViewInfo.Create(AGalleryControl: TdxCustomGalleryControl);
begin
  inherited Create;
  FGalleryControl := AGalleryControl;
end;

procedure TdxGalleryControlViewInfo.Calculate(AType: TdxChangeType; const ABounds: TRect);
begin
  FBounds := ABounds;
  if AType <> ctLight then
  begin
    CalculateItemSize;
    CalculateColumnCount;
  end;
  CalculateContentBounds(AType);
end;

procedure TdxGalleryControlViewInfo.CalculateColumnCount;
begin
  FColumnCount := GalleryControl.ColumnCount;
  if ColumnCount = 0 then
  begin
    if AutoWidth then
      FColumnCount := 5
    else
      FColumnCount := GetAvailableGroupsAreaWidth div ItemSize.cx;

    if ColumnAutoWidth then
      FColumnCount := Min(FColumnCount, MaxColumnCount);
    FColumnCount := Max(1, FColumnCount);
  end;
end;

procedure TdxGalleryControlViewInfo.CalculateContentBounds(AType: TdxChangeType);
var
  AContentWidth: Integer;
  AGroupViewInfo: TdxGalleryGroupViewInfo;
  ARect: TRect;
  I: Integer;
begin
  if GalleryControl.HandleAllocated and (Groups.Count > 0) then
  begin
    if ColumnAutoWidth then
      AContentWidth := cxRectWidth(Bounds) - cxMarginsWidth(ContentOffset)
    else
      AContentWidth := ColumnCount * ItemSize.cx + cxMarginsWidth(ContentOffsetGroups);

    FContentBounds.Left := Bounds.Left - GalleryControl.LeftPos + ContentOffset.Left;
    FContentBounds.Top := Bounds.Top - GalleryControl.TopPos + ContentOffset.Top;
    FContentBounds.Right := ContentBounds.Left + AContentWidth;
    FContentBounds.Bottom := MaxInt;

    ARect := ContentBounds;
    for I := 0 to Groups.Count - 1 do
    begin
      AGroupViewInfo := Groups[I].ViewInfo;
      AGroupViewInfo.Calculate(AType, ARect);
      ARect.Top := AGroupViewInfo.Bounds.Bottom;
    end;

    FContentBounds.Bottom := ARect.Top;
  end
  else
    FContentBounds := cxEmptyRect;
end;

procedure TdxGalleryControlViewInfo.CalculateItemSize;
var
  ADeltaSize: Integer;
begin
  FImageSize := CalculateMaxItemImageSize;
  FTextAreaSize := CalculateMaxItemTextAreaSize(ImageSize);

  if (ImageSize.cx = 0) and (TextAreaSize.cx = 0) then
    FImageSize.cx := 16;
  if (ImageSize.cy = 0) and (TextAreaSize.cy = 0) then
    FImageSize.cy := 16;

  if ColumnAutoWidth then
  begin
    FItemSize := DoCalculateItemSize;
    CalculateColumnCount;
    ADeltaSize := (GetAvailableGroupsAreaWidth - ItemSize.cx * ColumnCount) div ColumnCount;
    if OptionsItemText.Position = posNone then
      FImageSize.cx := Max(0, ImageSize.cx + ADeltaSize)
    else
      FTextAreaSize.cx := Max(0, TextAreaSize.cx + ADeltaSize);
  end;

  FTextAreaSize.cy := CalculateMaxItemTextAreaSizeLimitedByWidth(TextAreaSize.cx).cy;
  FItemSize := DoCalculateItemSize;
end;

function TdxGalleryControlViewInfo.CalculateMaxItemImageSize: TSize;

  function GetItemImageSize(AItem: TdxGalleryControlItem): TSize;
  begin
    Result := dxGetImageSize(AItem.Glyph, AItem.Images, AItem.ImageIndex);
  end;

var
  AGroup: TdxGalleryControlGroup;
  I, J: Integer;
begin
  Result := OptionsItemImage.Size.Size;
  if cxSizeIsEmpty(Result) then
  begin
    for I := 0 to Groups.Count - 1 do
    begin
      AGroup := Groups[I];
      for J := 0 to AGroup.ItemCount - 1 do
        Result := cxSizeMax(Result, GetItemImageSize(AGroup.Items[J]));
    end;
  end;
end;

function TdxGalleryControlViewInfo.CalculateMaxItemTextAreaSize(const AImageSize: TSize): TSize;
begin
  case OptionsItemText.Position of
    posTop, posBottom:
      Result := CalculateMaxItemTextAreaSizeLimitedByWidth(GetTextAreaMaxWidth(AImageSize));
    posLeft, posRight:
      Result := CalculateMaxItemTextAreaSizeLimitedByRowCount(GetTextAreaMaxRowCount(AImageSize));
  else
    Result := cxNullSize;
  end;
end;

function TdxGalleryControlViewInfo.CalculateMaxItemTextAreaSizeLimitedByRowCount(ARowCount: Integer): TSize;
var
  AGroup: TdxGalleryControlGroup;
  AItemViewInfo: TdxGalleryItemViewInfo;
  I, J: Integer;
begin
  Result := cxNullSize;
  if OptionsItemText.Position <> posNone then
  begin
    cxScreenCanvas.Font := Font;
    try
      for I := 0 to Groups.Count - 1 do
      begin
        AGroup := Groups[I];
        for J := 0 to AGroup.ItemCount - 1 do
        begin
          AItemViewInfo := AGroup.Items[J].ViewInfo;
          AItemViewInfo.CalculateTextAreaSizeLimitedByRowCount(cxScreenCanvas, ARowCount);
          Result := cxSizeMax(Result, AItemViewInfo.TextAreaSize);
        end;
      end;
    finally
      cxScreenCanvas.Dormant;
    end;
  end;
end;

function TdxGalleryControlViewInfo.CalculateMaxItemTextAreaSizeLimitedByWidth(AMaxWidth: Integer): TSize;
var
  AGroup: TdxGalleryControlGroup;
  AItemViewInfo: TdxGalleryItemViewInfo;
  I, J: Integer;
begin
  Result := cxNullSize;
  if OptionsItemText.Position <> posNone then
  begin
    AMaxWidth := Max(1, AMaxWidth);
    cxScreenCanvas.Font := Font;
    try
      for I := 0 to Groups.Count - 1 do
      begin
        AGroup := Groups[I];
        for J := 0 to AGroup.ItemCount - 1 do
        begin
          AItemViewInfo := AGroup.Items[J].ViewInfo;
          AItemViewInfo.CalculateTextAreaSizeLimitedByWidth(cxScreenCanvas, AMaxWidth);
          Result := cxSizeMax(Result, AItemViewInfo.TextAreaSize);
        end;
      end;
    finally
      cxScreenCanvas.Dormant;
    end;
  end;
end;

function TdxGalleryControlViewInfo.DoCalculateItemSize: TSize;

  function CalculateItemHeight(AMarginTop, AMarginBottom, ATextHeight, AImageHeight: Integer): Integer;
  begin
    Result := AMarginTop + AMarginBottom + Max(ATextHeight, AImageHeight);
  end;

  function CalculateItemWidth(AMarginLeft, AMarginRight, ATextWidth, AImageWidth: Integer): Integer;
  begin
    Result := AMarginLeft + AMarginRight + ATextWidth + AImageWidth +
      dxcItemIndentBetweenGlyphAndText + Min(Min(AMarginLeft, AMarginRight), dxcItemGlyphFrameOffset);
  end;

begin
  case OptionsItemText.Position of
    posLeft, posRight:
      begin
        Result.cx := CalculateItemWidth(ContentOffsetItems.Left, ContentOffsetItems.Right, TextAreaSize.cx, ImageSize.cx);
        Result.cy := CalculateItemHeight(ContentOffsetItems.Top, ContentOffsetItems.Bottom, TextAreaSize.cy, ImageSize.cy);
      end;

    posTop, posBottom:
      begin
        Result.cx := CalculateItemHeight(ContentOffsetItems.Left, ContentOffsetItems.Right, TextAreaSize.cx, ImageSize.cx);
        Result.cy := CalculateItemWidth(ContentOffsetItems.Top, ContentOffsetItems.Bottom, TextAreaSize.cy, ImageSize.cy);
      end;

  else // posNone
    begin
      Result.cx := ImageSize.cx + cxMarginsWidth(ContentOffsetItems);
      Result.cy := ImageSize.cy + cxMarginsHeight(ContentOffsetItems);
    end;
  end;
end;

procedure TdxGalleryControlViewInfo.DrawContent(ACanvas: TcxCanvas);
var
  AGroup: TdxGalleryControlGroup;
  I: Integer;
begin
  Painter.DrawBackground(ACanvas, Bounds);
  for I := 0 to Groups.Count - 1 do
  begin
    AGroup := Groups[I];
    if AGroup.Visible then
      AGroup.ViewInfo.Draw(ACanvas);
  end;
end;

function TdxGalleryControlViewInfo.GetAvailableGroupsAreaWidth: Integer;
var
  AOffset: Integer;
begin
  AOffset := cxMarginsWidth(BorderWidths) + cxMarginsWidth(ContentOffsetGroups);
  if not AutoHeight then
  begin
    if not ColumnAutoWidth or GalleryControl.VScrollBarVisible then
      Inc(AOffset, GetScrollBarSize.cx);
  end;
  Result := GalleryControl.Width - AOffset;
end;

function TdxGalleryControlViewInfo.GetBorderWidths: TRect;
var
  ABorderSize: Integer;
begin
  Result := ContentOffset;
  ABorderSize := GalleryControl.BorderSize;
  Inc(Result.Bottom, ABorderSize);
  Inc(Result.Left, ABorderSize);
  Inc(Result.Right, ABorderSize);
  Inc(Result.Top, ABorderSize);
end;

function TdxGalleryControlViewInfo.GetGalleryControl: TdxCustomGalleryControl;
begin
  Result := FGalleryControl;
end;

function TdxGalleryControlViewInfo.GetTextAreaMaxRowCount(const AImageSize: TSize): Integer;
begin
  Result := Max(1, AImageSize.cy div cxTextHeight(Font));
end;

function TdxGalleryControlViewInfo.GetTextAreaMaxWidth(const AImageSize: TSize): Integer;
begin
  Result := Max(AImageSize.cx, cxTextWidth(Font, 'W') * 3);
end;

function TdxGalleryControlViewInfo.GetColumnAutoWidth: Boolean;
begin
  Result := OptionsView.ColumnAutoWidth and not AutoWidth;
end;

function TdxGalleryControlViewInfo.GetFont: TFont;
begin
  Result := GalleryControl.Font;
end;

function TdxGalleryControlViewInfo.GetGroups: TdxGalleryControlGroups;
begin
  Result := GalleryControl.Gallery.Groups;
end;

function TdxGalleryControlViewInfo.GetAutoHeight: Boolean;
begin
  Result := GalleryControl.AutoSizeMode in [asAutoHeight, asAutoSize];
end;

function TdxGalleryControlViewInfo.GetAutoWidth: Boolean;
begin
  Result := GalleryControl.AutoSizeMode in [asAutoWidth, asAutoSize];
end;

function TdxGalleryControlViewInfo.GetMaxColumnCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Groups.Count - 1 do
    Result := Max(Result, Groups[I].ViewInfo.GetMaxColumnCount);
end;

function TdxGalleryControlViewInfo.GetRowCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Groups.Count - 1 do
    Inc(Result, Groups[I].ViewInfo.RowCount);
end;

{ TdxGalleryControlNavigationMatrix }

constructor TdxGalleryControlNavigationMatrix.Create(AViewInfo: TdxGalleryControlViewInfo);
begin
  inherited Create;
  FRowCount := AViewInfo.RowCount;
  FColumnCount := AViewInfo.ColumnCount;
  SetLength(FValues, ColumnCount, RowCount);
  Populate(AViewInfo);
end;

destructor TdxGalleryControlNavigationMatrix.Destroy;
begin
  FValues := nil;
  inherited Destroy;
end;

function TdxGalleryControlNavigationMatrix.GetRightMostItemIndex(ARow: Integer): Integer;
var
  AColumn: Integer;
begin
  Result := 0;
  for AColumn := ColumnCount - 1 downto 0 do
    if Values[AColumn, ARow] <> nil then
    begin
      Result := AColumn;
      Break;
    end;
end;

procedure TdxGalleryControlNavigationMatrix.Populate(AViewInfo: TdxGalleryControlViewInfo);

  procedure ProcessGroup(AGroup: TdxGalleryControlGroup; var AIndex: Integer);
  var
    AItem: TdxGalleryControlItem;
    I: Integer;
    P: TPoint;
  begin
    if AGroup.Visible then
    begin
      for I := 0 to AGroup.Items.Count - 1 do
      begin
        AItem := AGroup.Items[I];
        P := AItem.ViewInfo.CellPositionInGroup;
        Values[P.X, P.Y + AIndex] := AItem;
      end;
      Inc(AIndex, AGroup.ViewInfo.RowCount);
    end;
  end;

var
  AIndex, I: Integer;
begin
  AIndex := 0;
  for I := 0 to AViewInfo.Groups.Count - 1 do
    ProcessGroup(AViewInfo.Groups[I], AIndex);
end;

function TdxGalleryControlNavigationMatrix.GetValue(ACol, ARow: Integer): TdxGalleryControlItem;
begin
  Result := FValues[ACol, ARow];
end;

procedure TdxGalleryControlNavigationMatrix.SetValue(ACol, ARow: Integer; const AValue: TdxGalleryControlItem);
begin
  FValues[ACol, ARow] := AValue;
end;

{ TdxGalleryControlController }

procedure TdxGalleryControlController.CheckSelectedItem;
var
  AList: TList;
begin
  AList := TList.Create;
  try
    Gallery.GetAllItems(AList);
    if (KeySelectedItem <> nil) and (AList.IndexOf(KeySelectedItem) < 0) then
      FKeySelectedItem := nil;
    if AList.IndexOf(MouseHoveredItem) < 0 then
    begin
      FMouseHoveredItem := nil;
      UpdateMouseHoveredItem(Owner.GetMouseCursorClientPos);
    end;
  finally
    Alist.Free;
  end;
end;

procedure TdxGalleryControlController.LayoutChanged;
begin
  FreeAndNil(FNavigationMatrix);
end;

function TdxGalleryControlController.CreateNavigationMatrix: TdxGalleryControlNavigationMatrix;
begin
  Result := TdxGalleryControlNavigationMatrix.Create(ViewInfo);
end;

procedure TdxGalleryControlController.FocusEnter;
begin
  // do nothing
end;

procedure TdxGalleryControlController.FocusLeave;
begin
  KeySelectedItem := nil;
end;

procedure TdxGalleryControlController.KeyDown(AKey: Word; AShift: TShiftState);
begin
  case AKey of
    VK_RIGHT:
      SelectNextItem(GetStartItemForKeyboardNavigation, 1, 0);
    VK_LEFT:
      SelectNextItem(GetStartItemForKeyboardNavigation, -1, 0);
    VK_UP:
      SelectNextItem(GetStartItemForKeyboardNavigation, 0, -1);
    VK_DOWN:
      SelectNextItem(GetStartItemForKeyboardNavigation, 0, 1);
    VK_SPACE:
      KeyPressed := True;
  end;
end;

procedure TdxGalleryControlController.KeyUp(AKey: Word; AShift: TShiftState);
begin
  case AKey of
    VK_SPACE:
      begin
        KeyPressed := False;
        Gallery.ClickItem(KeySelectedItem);
      end;
  end;
end;

procedure TdxGalleryControlController.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    UpdateMouseHoveredItem(Point(X, Y));
    MousePressed := True;
  end;
end;

procedure TdxGalleryControlController.MouseLeave;
begin
  MouseHoveredItem := nil;
end;

procedure TdxGalleryControlController.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  UpdateMouseHoveredItem(Point(X, Y));
end;

procedure TdxGalleryControlController.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    UpdateMouseHoveredItem(Point(X, Y));
    if FMousePressed then
    begin
      MousePressed := False;
      ProcessItemClick(MouseHoveredItem, X, Y);
    end;
  end;
end;

function TdxGalleryControlController.GetItemAtPos(const P: TPoint): TdxGalleryControlItem;
begin
  Result := Owner.GetItemAtPos(P);
end;

function TdxGalleryControlController.GetItemPosition(AItem: TdxGalleryControlItem): TPoint;
var
  I: Integer;
begin
  Result := AItem.ViewInfo.CellPositionInGroup;
  for I := 0 to AItem.Group.Index - 1 do
    Inc(Result.Y, ViewInfo.Groups[I].ViewInfo.RowCount);
end;

function TdxGalleryControlController.GetItemViewState(AItem: TdxGalleryControlItem): TdxGalleryItemViewState;
begin
  Result.Enabled := AItem.Enabled;
  Result.Checked := AItem.Checked;
  Result.Hover := AItem = MouseHoveredItem;
  Result.Focused := Owner.Focused and (AItem = KeySelectedItem);
  Result.Pressed := Result.Hover and MousePressed or Result.Focused and Owner.Controller.KeyPressed;
end;

procedure TdxGalleryControlController.InvalidateItem(AItem: TdxGalleryControlItem);
begin
  if AItem <> nil then
    Owner.InvalidateRect(AItem.ViewInfo.Bounds, False);
end;

procedure TdxGalleryControlController.MakeItemVisible(AItem: TdxGalleryControlItem);
begin
  if AItem <> nil then
    Owner.MakeVisible(AItem.ViewInfo.Bounds, True);
end;

procedure TdxGalleryControlController.UpdateItemViewState(AItem: TdxGalleryControlItem);

  function IsItemValid(AItem: TdxGalleryControlItem): Boolean;
  begin
    Result := (AItem <> nil) and not (csDestroying in AItem.ComponentState);
  end;

  function IsViewStateEqual(const AViewState1, AViewState2: TdxGalleryItemViewState): Boolean;
  begin
    Result := CompareMem(@AViewState1, @AViewState2, SizeOf(TdxGalleryItemViewState));
  end;

begin
  if IsItemValid(AItem) and not IsViewStateEqual(AItem.ViewInfo.State, GetItemViewState(AItem)) then
  begin
    AItem.ViewInfo.FState := GetItemViewState(AItem);
    AItem.ViewInfo.ResetCache;
    InvalidateItem(AItem);
  end;
end;

procedure TdxGalleryControlController.UpdateMouseHoveredItem(const P: TPoint);
var
  AItem: TdxGalleryControlItem;
begin
  AItem := GetItemAtPos(P);
  if (AItem <> nil) and AItem.Enabled then
    MouseHoveredItem := AItem
  else
    MouseHoveredItem := nil;
end;

procedure TdxGalleryControlController.GetNextItem(var AItemPos: TPoint; ADirectionX, ADirectionY: Integer);
begin
  AItemPos.X := Max(0, Min(AItemPos.X + ADirectionX, NavigationMatrix.ColumnCount - 1));
  AItemPos.Y := Max(0, Min(AItemPos.Y + ADirectionY, NavigationMatrix.RowCount - 1));
  if (ADirectionY <> 0) and (NavigationMatrix.Values[AItemPos.X, AItemPos.Y] = nil) then
    AItemPos.X := NavigationMatrix.GetRightMostItemIndex(AItemPos.Y);
end;

function TdxGalleryControlController.GetStartItemForKeyboardNavigation: TdxGalleryControlItem;
begin
  Result := KeySelectedItem;
  if Result = nil then
    Result := Gallery.GetCheckedItem;
  if Result = nil then
    Result := Gallery.GetFirstItem;
end;

procedure TdxGalleryControlController.SelectNextItem(AItem: TdxGalleryControlItem; ADirectionX, ADirectionY: Integer);
var
  AItemPos: TPoint;
begin
  if AItem <> nil then
  begin
    AItemPos := GetItemPosition(AItem);
    GetNextItem(AItemPos, ADirectionX, ADirectionY);
    if NavigationMatrix.Values[AItemPos.X, AItemPos.Y] <> nil then
      KeySelectedItem := NavigationMatrix.Values[AItemPos.X, AItemPos.Y];
  end
  else
    KeySelectedItem := Gallery.GetFirstItem;
end;

procedure TdxGalleryControlController.ProcessItemClick(AItem: TdxGalleryControlItem; X, Y: Integer);
begin
  Gallery.ClickItem(AItem);
end;

function TdxGalleryControlController.GetGallery: TdxGalleryControlStructure;
begin
  Result := Owner.Gallery;
end;

function TdxGalleryControlController.GetNavigationMatrix: TdxGalleryControlNavigationMatrix;
begin
  if FNavigationMatrix = nil then
    FNavigationMatrix := CreateNavigationMatrix;
  Result := FNavigationMatrix;
end;

function TdxGalleryControlController.GetViewInfo: TdxGalleryControlViewInfo;
begin
  Result := Owner.ViewInfo;
end;

procedure TdxGalleryControlController.SetKeyPressed(AValue: Boolean);
begin
  if FKeyPressed <> AValue then
  begin
    FKeyPressed := AValue;
    UpdateItemViewState(KeySelectedItem);
  end;
end;

procedure TdxGalleryControlController.SetKeySelectedItem(AItem: TdxGalleryControlItem);
begin
  if FKeySelectedItem <> AItem then
  begin
    ExchangePointers(FKeySelectedItem, AItem);
    UpdateItemViewState(AItem);
    UpdateItemViewState(KeySelectedItem);
    MakeItemVisible(KeySelectedItem);
  end;
end;

procedure TdxGalleryControlController.SetMouseHoveredItem(AItem: TdxGalleryControlItem);
begin
  if MouseHoveredItem <> AItem then
  begin
    ExchangePointers(FMouseHoveredItem, AItem);
    UpdateItemViewState(AItem);
    UpdateItemViewState(MouseHoveredItem);
  end;
end;

procedure TdxGalleryControlController.SetMousePressed(AValue: Boolean);
begin
  if MousePressed <> AValue then
  begin
    FMousePressed := AValue;
    UpdateItemViewState(MouseHoveredItem);
  end;
end;

{ TdxGalleryControlCustomOptions }

procedure TdxGalleryControlCustomOptions.Changed(AType: TdxChangeType);
begin
  Owner.LayoutChanged(AType);
end;

{ TdxGalleryControlOptionsBehavior }

procedure TdxGalleryControlOptionsBehavior.DoAssign(Source: TPersistent);
begin
  ItemCheckMode := TdxGalleryControlOptionsBehavior(Source).ItemCheckMode;
  ItemShowHint := TdxGalleryControlOptionsBehavior(Source).ItemShowHint;
end;

function TdxGalleryControlOptionsBehavior.GetItemCheckMode: TdxGalleryItemCheckMode;
begin
  Result := Owner.Gallery.ItemCheckMode;
end;

procedure TdxGalleryControlOptionsBehavior.SetItemCheckMode(const Value: TdxGalleryItemCheckMode);
begin
  Owner.Gallery.ItemCheckMode := Value;
end;

{ TdxGalleryControlOptionsItemImage }

constructor TdxGalleryControlOptionsItemImage.Create(AOwner: TdxCustomGalleryControl);
begin
  inherited Create(AOwner);
  FSize := TcxSize.Create(Self);
  FSize.OnChange := ChangeHandler;
  FShowFrame := True;
end;

destructor TdxGalleryControlOptionsItemImage.Destroy;
begin
  FreeAndNil(FSize);
  inherited Destroy;
end;

procedure TdxGalleryControlOptionsItemImage.DoAssign(Source: TPersistent);
begin
  Size := TdxGalleryControlOptionsItemImage(Source).Size;
  ShowFrame := TdxGalleryControlOptionsItemImage(Source).ShowFrame;
end;

procedure TdxGalleryControlOptionsItemImage.ChangeHandler(Sender: TObject);
begin
  Changed;
end;

procedure TdxGalleryControlOptionsItemImage.SetShowFrame(const Value: Boolean);
begin
  if Value <> FShowFrame then
  begin
    FShowFrame := Value;
    Changed;
  end;
end;

procedure TdxGalleryControlOptionsItemImage.SetSize(const Value: TcxSize);
begin
  FSize.Assign(Value);
end;

{ TdxGalleryControlOptionsItemText }

constructor TdxGalleryControlOptionsItemText.Create(AOwner: TdxCustomGalleryControl);
begin
  inherited Create(AOwner);
  FAlignHorz := taCenter;
  FWordWrap := True;
end;

procedure TdxGalleryControlOptionsItemText.DoAssign(Source: TPersistent);
begin
  AlignHorz := TdxGalleryControlOptionsItemText(Source).AlignHorz;
  AlignVert := TdxGalleryControlOptionsItemText(Source).AlignVert;
  Position := TdxGalleryControlOptionsItemText(Source).Position;
  WordWrap := TdxGalleryControlOptionsItemText(Source).WordWrap;
end;

procedure TdxGalleryControlOptionsItemText.SetAlignHorz(const Value: TAlignment);
begin
  if FAlignHorz <> Value then
  begin
    FAlignHorz := Value;
    Changed(ctLight);
  end;
end;

procedure TdxGalleryControlOptionsItemText.SetAlignVert(const Value: TcxAlignmentVert);
begin
  if FAlignVert <> Value then
  begin
    FAlignVert := Value;
    Changed(ctLight);
  end;
end;

procedure TdxGalleryControlOptionsItemText.SetPosition(const Value: TcxPosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    Changed;
  end;
end;

procedure TdxGalleryControlOptionsItemText.SetWordWrap(const Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    Changed
  end;
end;

{ TdxGalleryControlOptionsItem }

constructor TdxGalleryControlOptionsItem.Create(AOwner: TdxCustomGalleryControl);
begin
  inherited Create(AOwner);
  FImage := CreateImage;
  FText := CreateText;
end;

destructor TdxGalleryControlOptionsItem.Destroy;
begin
  FreeAndNil(FText);
  FreeAndNil(FImage);
  inherited Destroy;
end;

function TdxGalleryControlOptionsItem.CreateImage: TdxGalleryControlOptionsItemImage;
begin
  Result := TdxGalleryControlOptionsItemImage.Create(Owner);
end;

function TdxGalleryControlOptionsItem.CreateText: TdxGalleryControlOptionsItemText;
begin
  Result := TdxGalleryControlOptionsItemText.Create(Owner);
end;

procedure TdxGalleryControlOptionsItem.DoAssign(Source: TPersistent);
begin
  Text := TdxGalleryControlOptionsItem(Source).Text;
end;

procedure TdxGalleryControlOptionsItem.SetImage(AValue: TdxGalleryControlOptionsItemImage);
begin
  FImage.Assign(AValue);
end;

procedure TdxGalleryControlOptionsItem.SetText(AValue: TdxGalleryControlOptionsItemText);
begin
  FText.Assign(AValue);
end;

{ TdxGalleryControlOptionsView }

constructor TdxGalleryControlOptionsView.Create(AOwner: TdxCustomGalleryControl);
begin
  inherited Create(AOwner);
  FItem := CreateItem;
  FContentOffset := TcxMargin.Create(Self, 1);
  FContentOffset.OnChange := ChangeHandler;
  FContentOffsetGroups := TcxMargin.Create(Self, 0);
  FContentOffsetGroups.OnChange := ChangeHandler;
  FContentOffsetItems := TcxMargin.Create(Self, 6);
  FContentOffsetItems.OnChange := ChangeHandler;
end;

destructor TdxGalleryControlOptionsView.Destroy;
begin
  FreeAndNil(FContentOffsetItems);
  FreeAndNil(FContentOffsetGroups);
  FreeAndNil(FContentOffset);
  FreeAndNil(FItem);
  inherited Destroy;
end;

function TdxGalleryControlOptionsView.CreateItem: TdxGalleryControlOptionsItem;
begin
  Result := TdxGalleryControlOptionsItem.Create(Owner);
end;

procedure TdxGalleryControlOptionsView.DoAssign(Source: TPersistent);
begin
  ColumnCount := TdxGalleryControlOptionsView(Source).ColumnCount;
  ColumnAutoWidth := TdxGalleryControlOptionsView(Source).ColumnAutoWidth;
  ContentOffset := TdxGalleryControlOptionsView(Source).ContentOffset;
  ContentOffsetGroups := TdxGalleryControlOptionsView(Source).ContentOffsetGroups;
  ContentOffsetItems := TdxGalleryControlOptionsView(Source).ContentOffsetItems;
  Item := TdxGalleryControlOptionsView(Source).Item;
end;

procedure TdxGalleryControlOptionsView.ChangeHandler(Sender: TObject);
begin
  Changed;
end;

procedure TdxGalleryControlOptionsView.SetColumnAutoWidth(AValue: Boolean);
begin
  if FColumnAutoWidth <> AValue then
  begin
    FColumnAutoWidth := AValue;
    Changed;
  end;
end;

procedure TdxGalleryControlOptionsView.SetColumnCount(AValue: Integer);
begin
  AValue := Max(0, AValue);
  if FColumnCount <> AValue then
  begin
    FColumnCount := AValue;
    Changed;
  end;
end;

procedure TdxGalleryControlOptionsView.SetContentOffset(const Value: TcxMargin);
begin
  FContentOffset.Assign(Value);
end;

procedure TdxGalleryControlOptionsView.SetContentOffsetGroups(const Value: TcxMargin);
begin
  FContentOffsetGroups.Assign(Value);
end;

procedure TdxGalleryControlOptionsView.SetContentOffsetItems(const Value: TcxMargin);
begin
  FContentOffsetItems.Assign(Value);
end;

procedure TdxGalleryControlOptionsView.SetItem(const Value: TdxGalleryControlOptionsItem);
begin
  FItem.Assign(Value);
end;

{ TdxCustomGalleryControl }

constructor TdxCustomGalleryControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle - [csParentBackground];

  BorderStyle := cxcbsDefault;
  Width := 150;
  Height := 100;

  FGallery := CreateGallery;
  TdxGalleryAccess(FGallery).OnChange := GalleryChangeHandler;
  TdxGalleryAccess(FGallery).OnItemClick := GalleryItemClickHandler;

  FViewInfo := CreateViewInfo;
  FController := CreateController;
  FPainter := CreatePainter;
  FOptionsBehavior := CreateOptionsBehavior;
  FOptionsView := CreateOptionsView;

  ShowHint := True;
  Keys := [kArrows];
end;

destructor TdxCustomGalleryControl.Destroy;
begin
  FreeAndNil(FOptionsBehavior);
  FreeAndNil(FOptionsView);
  FreeAndNil(FController);
  FreeAndNil(FViewInfo);
  FreeAndNil(FGallery);
  FreeAndNil(FPainter);
  inherited Destroy;
end;

procedure TdxCustomGalleryControl.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  Gallery.GetChildren(Proc, Root);
end;

function TdxCustomGalleryControl.CreateController: TdxGalleryControlController;
begin
  Result := TdxGalleryControlController.Create(Self);
end;

function TdxCustomGalleryControl.CreateGallery: TdxGalleryControlStructure;
begin
  Result := TdxGalleryControlStructure.Create(Self);
end;

function TdxCustomGalleryControl.CreateOptionsBehavior: TdxGalleryControlOptionsBehavior;
begin
  Result := TdxGalleryControlOptionsBehavior.Create(Self);
end;

function TdxCustomGalleryControl.CreateOptionsView: TdxGalleryControlOptionsView;
begin
  Result := TdxGalleryControlOptionsView.Create(Self);
end;

function TdxCustomGalleryControl.CreatePainter: TdxGalleryControlPainter;
begin
  Result := TdxGalleryControlPainter.Create(Self);
end;

function TdxCustomGalleryControl.CreateViewInfo: TdxGalleryControlViewInfo;
begin
  Result := TdxGalleryControlViewInfo.Create(Self);
end;

procedure TdxCustomGalleryControl.FocusEnter;
begin
  inherited FocusEnter;
  Controller.FocusEnter;
end;

procedure TdxCustomGalleryControl.FocusLeave;
begin
  inherited FocusLeave;
  Controller.FocusLeave;
end;

procedure TdxCustomGalleryControl.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  Controller.KeyDown(Key, Shift);
end;

procedure TdxCustomGalleryControl.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
  Controller.KeyUp(Key, Shift);
end;

procedure TdxCustomGalleryControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  Controller.MouseDown(Button, Shift, X, Y);
end;

procedure TdxCustomGalleryControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  Controller.MouseMove(Shift, X, Y);
end;

procedure TdxCustomGalleryControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  Controller.MouseUp(Button, Shift, X, Y);
end;

procedure TdxCustomGalleryControl.MouseLeave(AControl: TControl);
begin
  inherited MouseLeave(AControl);
  Controller.MouseLeave;
end;

function TdxCustomGalleryControl.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := GetItemCount > 0;
  if Result then
  begin
    Calculate(ctHard);
    case AutoSizeMode of
      asAutoSize:
        begin
          NewWidth := cxRectWidth(ViewInfo.ContentBounds) + cxMarginsWidth(ViewInfo.BorderWidths);
          NewHeight := cxRectHeight(ViewInfo.ContentBounds) + cxMarginsHeight(ViewInfo.BorderWidths);
        end;

      asAutoWidth:
        begin
          NewWidth := cxRectWidth(ViewInfo.ContentBounds) + cxMarginsWidth(ViewInfo.BorderWidths);
          if VScrollBarVisible then
            Inc(NewWidth, VScrollBar.Width);
        end;

      asAutoHeight:
        begin
          NewHeight := cxRectHeight(ViewInfo.ContentBounds) + cxMarginsHeight(ViewInfo.BorderWidths);
          if HScrollBarVisible then
            Inc(NewHeight, HScrollBar.Height);
        end;
    end;
  end;
end;

procedure TdxCustomGalleryControl.Loaded;
begin
  inherited Loaded;
  LayoutChanged;
end;

procedure TdxCustomGalleryControl.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil; 
end;

procedure TdxCustomGalleryControl.Paint;
begin
  inherited Paint;
  Canvas.Font := Font;
  ViewInfo.Draw(Canvas);
end;

function TdxCustomGalleryControl.GetContentSize: TSize;
begin
  Result := cxSize(cxRectInflate(ViewInfo.ContentBounds, ContentOffset.Margin));
end;

procedure TdxCustomGalleryControl.Calculate(AType: TdxChangeType);
begin
  ViewInfo.Calculate(AType, ClientBounds);
  if AType <> ctLight then
    Controller.LayoutChanged;
end;

procedure TdxCustomGalleryControl.LayoutChanged(AType: TdxChangeType);
begin
  if not IsUpdateLocked then
    inherited LayoutChanged(AType);
end;

procedure TdxCustomGalleryControl.SetAutoSizeMode(AValue: TdxAutoSizeMode);
begin
  if AutoSizeMode <> AValue then
  begin
    inherited SetAutoSizeMode(AValue);
    LayoutChanged;
  end;
end;

procedure TdxCustomGalleryControl.DoClickItem(AItem: TdxGalleryItem);
begin
  if Assigned(OnItemClick) then
    FOnItemClick(Self, AItem as TdxGalleryControlItem);
end;

function TdxCustomGalleryControl.GetItemAtPos(const P: TPoint): TdxGalleryControlItem;
begin
  Result := Gallery.Groups.GetItemAtPos(P);
end;

function TdxCustomGalleryControl.IsUpdateLocked: Boolean;
begin
  Result := (FLockCount > 0) or IsLoading;
end;

procedure TdxCustomGalleryControl.BeginUpdate;
begin
  Inc(FLockCount);
end;

procedure TdxCustomGalleryControl.EndUpdate;
begin
  Dec(FLockCount);
  if FLockCount = 0 then
    LayoutChanged;
end;

function TdxCustomGalleryControl.GetGallery: IdxGallery;
begin
  Result := Gallery;
end;

function TdxCustomGalleryControl.GetColumnCount: Integer;
begin
  Result := OptionsView.ColumnCount;
end;

function TdxCustomGalleryControl.GetContentOffset: TcxMargin;
begin
  Result := OptionsView.ContentOffset;
end;

function TdxCustomGalleryControl.GetContentOffsetGroups: TcxMargin;
begin
  Result := OptionsView.ContentOffsetGroups;
end;

function TdxCustomGalleryControl.GetContentOffsetItems: TcxMargin;
begin
  Result := OptionsView.ContentOffsetItems;
end;

function TdxCustomGalleryControl.GetItemCheckMode: TdxGalleryItemCheckMode;
begin
  Result := OptionsBehavior.ItemCheckMode;
end;

function TdxCustomGalleryControl.GetItemCount: Integer;
var
  AList: TList;
begin
  AList := TList.Create;
  try
    Gallery.GetAllItems(AList);
    Result := AList.Count;
  finally
    AList.Free;
  end;
end;

function TdxCustomGalleryControl.GetItemImageSize: TcxSize;
begin
  Result := OptionsView.Item.Image.Size;
end;

function TdxCustomGalleryControl.GetItemShowHint: Boolean;
begin
  Result := OptionsBehavior.ItemShowHint;
end;

function TdxCustomGalleryControl.GetItemShowImageFrame: Boolean;
begin
  Result := OptionsView.Item.Image.ShowFrame;
end;

function TdxCustomGalleryControl.GetItemTextPosition: TcxPosition;
begin
  Result := OptionsView.Item.Text.Position;
end;

procedure TdxCustomGalleryControl.SetGallery(AValue: TdxGalleryControlStructure);
begin
  FGallery.Assign(AValue);
end;

procedure TdxCustomGalleryControl.SetColumnCount(AValue: Integer);
begin
  OptionsView.ColumnCount := AValue;
end;

procedure TdxCustomGalleryControl.SetContentOffset(AValue: TcxMargin);
begin
  OptionsView.ContentOffset := AValue;
end;

procedure TdxCustomGalleryControl.SetContentOffsetGroups(AValue: TcxMargin);
begin
  OptionsView.ContentOffsetGroups := AValue;
end;

procedure TdxCustomGalleryControl.SetContentOffsetItems(AValue: TcxMargin);
begin
  OptionsView.ContentOffsetItems := AValue;
end;

procedure TdxCustomGalleryControl.SetImages(Value: TCustomImageList);
begin
  if FImages <> Value then
  begin
    if FImages <> nil then
      FImages.RemoveFreeNotification(Self);
    FImages := Value;
    if FImages <> nil then
      FImages.FreeNotification(Self);
    LayoutChanged;
  end;
end;

procedure TdxCustomGalleryControl.SetItemCheckMode(AValue: TdxGalleryItemCheckMode);
begin
  OptionsBehavior.ItemCheckMode := AValue;
end;

procedure TdxCustomGalleryControl.SetItemImageSize(AValue: TcxSize);
begin
  OptionsView.Item.Image.Size := AValue;
end;

procedure TdxCustomGalleryControl.SetItemTextPosition(AValue: TcxPosition);
begin
  OptionsView.Item.Text.Position := AValue;
end;

procedure TdxCustomGalleryControl.SetItemShowHint(const Value: Boolean);
begin
  OptionsBehavior.ItemShowHint := Value;
end;

procedure TdxCustomGalleryControl.SetItemShowImageFrame(AValue: Boolean);
begin
  OptionsView.Item.Image.ShowFrame := AValue;
end;

procedure TdxCustomGalleryControl.GalleryChangeHandler(ASender: TObject; AChangeType: TdxGalleryChangeType);
begin
  if HandleAllocated and not IsUpdateLocked then
  begin
    LayoutChanged;
    Controller.CheckSelectedItem;
  end;
end;

procedure TdxCustomGalleryControl.GalleryItemClickHandler(ASender: TObject; AItem: TdxGalleryItem);
begin
  DoClickItem(AItem);
end;

procedure TdxCustomGalleryControl.SetOptionsBehavior(const Value: TdxGalleryControlOptionsBehavior);
begin
  FOptionsBehavior.Assign(Value);
end;

procedure TdxCustomGalleryControl.SetOptionsView(const Value: TdxGalleryControlOptionsView);
begin
  FOptionsView.Assign(Value);
end;

procedure TdxCustomGalleryControl.CMFontChanged(var Message: TMessage);
begin
  inherited;
  LayoutChanged;
end;

procedure TdxCustomGalleryControl.CMHintShow(var Message: TCMHintShow);
var
  AItem: TdxGalleryControlItem;
begin
  if ItemShowHint then
  begin
    AItem := GetItemAtPos(Message.HintInfo.CursorPos);
    if (AItem <> nil) and AItem.Enabled and (AItem.Hint <> '') then
    begin
      Message.HintInfo.CursorRect := AItem.ViewInfo.Bounds;
      Message.HintInfo.HintStr := AItem.Hint;
      Message.Result := 0;
    end;
  end;
end;

initialization
  RegisterClasses([TdxGalleryControlItem, TdxGalleryControlGroup]);
end.
