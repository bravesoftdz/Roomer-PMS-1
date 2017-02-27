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

unit cxEditPropEditors;

{$I cxVer.inc}

interface

uses
{$IFNDEF CBUILDER10}
  DBReg,
{$ENDIF}
  DesignEditors, DesignIntf, VCLEditors,
  Types,
{$IFDEF DELPHI10}
  WideStrings,
{$ENDIF}
  Windows, Forms, Classes, Controls, DB, Graphics, ImgList, TypInfo, cxContainer,
  cxDateUtils, cxDataStorage, cxEdit, cxEditRepositoryItems, cxLookAndFeels, cxPropEditors,
  cxDesignWindows, dxCoreReg, cxLibraryReg, ActnList, dxAlertWindow, dxBreadcrumbEdit;

const
  cxEditorsLibraryProductName = 'ExpressEditors Library';
  cxEditorsLibraryProductPage = 'Express Editors';
  cxEditorsDBLibraryProductPage = 'Express DBEditors';
  cxEditorsUtilitiesProductPage = cxLibraryUtilitiesProductPage;

type
{$IFDEF DELPHI15}
  TdxValues = TStrings;
  TdxValueList = TStringList;
{$ELSE}
  TdxValues = {$IFDEF DELPHI10}TWideStrings{$ELSE}TStrings{$ENDIF};
  TdxValueList = {$IFDEF DELPHI10}TWideStringList{$ELSE}TStringList{$ENDIF};
{$ENDIF}

  { TDBStringProperty }

  TDBStringProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(AList: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

{$IFDEF CBUILDER10}
  { TcxDataFieldProperty }

  TcxDataFieldProperty = class(TDBStringProperty)
  public
    function GetDataSourcePropName: string; virtual;
    procedure GetValueList(AList: TStrings); override;
  end;
{$ELSE}
  TcxDataFieldProperty = class(TDataFieldProperty)
  public
    procedure GetValueList(List: TdxValues); override;
  end;
{$ENDIF}

  { TcxDateProperty }

  TcxDateProperty = class(DesignEditors.TDateProperty)
  public
    function GetValue: string; override;
  end;

  { TcxValueTypeProperty }

  TcxValueTypeProperty = class(TStringProperty)
  protected
    function IsValueTypeClassValid(AValueTypeClass: TcxValueTypeClass): Boolean; virtual;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  { TFieldNameProperty }

  TFieldNameProperty = class(TDBStringProperty)
  public
    function GetDataSource: TDataSource; virtual;
    function GetDataSourcePropName: string; virtual;
    procedure GetValueList(AList: TStrings); override;
  end;

  { TcxCustomEditorsLibraryComponentEditor }

  TcxCustomEditorsLibraryComponentEditor = class(TdxComponentEditor)
  protected
    function GetProductName: string; override;
  end;

  { TcxEditComponentEditor }

  TcxEditComponentEditor = class(TcxCustomEditorsLibraryComponentEditor)
  private
    function GetEdit: TcxCustomEdit;
  protected
    function InternalGetVerb(Index: Integer): string; override;
    function InternalGetVerbCount: Integer; override;
    procedure InternalExecuteVerb(AIndex: Integer); override;
  public
    procedure Edit; override;
  end;

  { TcxEditRepositoryItemProperty }

  TcxEditRepositoryItemProperty = class(TComponentProperty)
  private
    FStrProc: TGetStrProc;
    procedure StrProc(const S: string);
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  { TcxLookupEditListSourceProperty }

  TcxLookupEditListSourceProperty = class(TcxDataFieldProperty)
  public
    function GetDataSourcePropName: string; override;
  end;

  { TcxEditPropertiesEventEditor }

  TcxEditPropertiesEventEditor = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  public
    function GetName: string; override;
  end;

  { TcxEditRepositoryItemPropertiesEventEditor }

  TcxEditRepositoryItemPropertiesEventEditor = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  public
    function GetName: string; override;
  end;

  { TcxNavigatorButtonsEventEditor }

  TcxNavigatorButtonsEventEditor = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  public
    function GetName: string; override;
  end;

  { TcxNavigatorInfoPanelEventEditor }

  TcxNavigatorInfoPanelEventEditor = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  public
    function GetName: string; override;
  end;

  { TcxGetPropertiesImageIndexProperty }

  TcxGetPropertiesImageIndexProperty = class(TImageIndexProperty)
  public
    function GetImages: TCustomImageList; override;
  end;

  { TcxGetItemImageIndexProperty }

  TcxGetItemImageIndexProperty = class(TImageIndexProperty)
  public
    function GetImages: TCustomImageList; override;
  end;

  { TdxGalleryControlItemImageIndexProperty }

  TdxGalleryControlItemImageIndexProperty = class(TImageIndexProperty)
  public
    function GetImages: TCustomImageList; override;
  end;

  { TcxEditorsLibraryComponentEditorEx }

  TcxEditorsLibraryComponentEditorEx = class(TcxCustomEditorsLibraryComponentEditor)
  protected
    function GetEditItemCaption: string; virtual;
    procedure ExecuteEditAction; virtual; abstract;

    function InternalGetVerb(AIndex: Integer): string; override;
    function InternalGetVerbCount: Integer; override;
    procedure InternalExecuteVerb(AIndex: Integer); override;
  end;

  { TcxEditRepositoryComponentEditor }

  TcxEditRepositoryComponentEditor = class(TcxEditorsLibraryComponentEditorEx)
  private
    function GetEditRepository: TcxEditRepository;
  protected
    procedure ExecuteEditAction; override;
  end;

  { TcxEditMaskProperty }

  TcxEditMaskProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  { TcxTextProperty }

  TcxTextProperty = class(TStringProperty)
  private
    function CanShowDialog: Boolean;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  { TGraphicClassNameProperty }

  TGraphicClassNameProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TcxControlSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TcxCustomEditSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TcxButtonSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  { TcxFilterControlComponentEditor }

  TcxFilterControlComponentEditor = class(TcxDefaultEditor)
  protected
    function GetProductName: string; override;
  end;

  { TcxNavigatorControlProperty }

  TcxNavigatorControlProperty = class(TComponentProperty)
  private
    FStrProc: TGetStrProc;
    procedure StrProc(const S: string);
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  { TcxEditorsLibraryComponentEditor }

  TcxEditorsLibraryComponentEditor = class(TcxEditorsLibraryComponentEditorEx)
  public
    procedure Edit; override;
  end;

  { TcxEditorsLibraryComponentWithStylesEditor }

  TcxEditorsLibraryComponentWithStylesEditor = class(TcxEditorsLibraryComponentEditor)
  protected
    function GetEditItemCaption: string; override;
    procedure ExecuteEditAction; override;
    procedure RestoreStyles; virtual; abstract;
  end;

  { TcxEditorsLibraryComponentWithoutStylesEditor }

  TcxEditorsLibraryComponentWithoutStylesEditor = class(TcxEditorsLibraryComponentEditor)
  protected
    function GetEditItemCaption: string; override;
    procedure ExecuteEditAction; override;
    function GetLookAndFeel: TcxLookAndFeel; virtual; abstract;
  end;

  { TcxEditorsLibraryCXControlComponentEditor }

  TcxEditorsLibraryCXControlComponentEditor = class(TcxEditorsLibraryComponentWithoutStylesEditor)
  protected
    function GetLookAndFeel: TcxLookAndFeel; override;
  end;

  { TcxBreadcrumbEditComponentEditor }

  TcxBreadcrumbEditComponentEditor = class(TcxEditorsLibraryCXControlComponentEditor)
  protected
    function InternalGetVerb(AIndex: Integer): string; override;
    function InternalGetVerbCount: Integer; override;
    procedure InternalExecuteVerb(AIndex: Integer); override;
  public
    procedure Edit; override;
  end;

  { TdxBreadcrumbEditSelectedPathPropertyEditor }

  TdxBreadcrumbEditSelectedPathPropertyEditor = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  { TdxBevelComponentEditor }

  TdxBevelComponentEditor = class(TcxEditorsLibraryComponentWithoutStylesEditor)
  protected
    function GetLookAndFeel: TcxLookAndFeel; override;
  end;

  { TcxEditStyleControllerEditor }

  TcxEditStyleControllerEditor = class(TcxEditorsLibraryComponentWithStylesEditor)
  protected
    procedure RestoreStyles; override;
  public
    procedure Edit; override;
  end;

  { TcxDefaultEditStyleControllerEditor }

  TcxDefaultEditStyleControllerEditor = class(TcxEditorsLibraryComponentWithStylesEditor)
  protected
    procedure RestoreStyles; override;
  public
    procedure Edit; override;
  end;

  { TcxCustomButtonComponentEditor }

  TcxCustomButtonComponentEditor = class(TcxEditorsLibraryComponentWithoutStylesEditor)
  protected
    function GetLookAndFeel: TcxLookAndFeel; override;
  end;

  { TdxAlertWindowComponentEditor }

  TdxAlertWindowComponentEditor = class(TcxEditorsLibraryComponentWithoutStylesEditor)
  protected
    function GetLookAndFeel: TcxLookAndFeel; override;
  end;

  { TcxRadioButtonComponentEditor }

  TcxRadioButtonComponentEditor = class(TcxEditorsLibraryComponentWithoutStylesEditor)
  protected
    function GetLookAndFeel: TcxLookAndFeel; override;
  end;

  { TcxContainerComponentEditor }

  TcxContainerComponentEditor = class(TcxEditorsLibraryComponentWithStylesEditor)
  protected
    procedure RestoreStyles; override;
  end;

  { TcxCustomNavigatorComponentEditor }

  TcxCustomNavigatorComponentEditor = class(TcxEditorsLibraryCXControlComponentEditor)
  protected
    function InternalGetVerb(AIndex: Integer): string; override;
    function InternalGetVerbCount: Integer; override;
    procedure InternalExecuteVerb(AIndex: Integer); override;
  public
    procedure Edit; override;
  end;

  { TdxGalleryControlComponentEditor }

  TdxGalleryControlComponentEditor = class(TcxEditorsLibraryComponentEditorEx)
  protected
    procedure ExecuteEditAction; override;
  end;

  { TdxSliderImageComponentEditor }

  TdxSliderImageComponentEditor = class(TcxEditorsLibraryCXControlComponentEditor)
  public
    procedure Edit; override;
  end;

  { TcxCustomImagePropertiesProperty }

  TcxCustomImagePropertiesProperty = class(TcxEditPropertiesEventEditor)
  private
    FProc: TGetPropProc;
    procedure GetPropProc(const Prop: IProperty);
  public
    procedure GetProperties(Proc: TGetPropProc); override;
  end;

  { TcxEditPropertiesAssignedValuesProperty }

  TcxEditPropertiesAssignedValuesProperty = class(TClassProperty)
  private
    FProc: TGetPropProc;
    procedure GetPropProc(const Prop: IProperty);
    function IsVisibleProperty(const APropertyName: string): Boolean;
  public
    procedure GetProperties(Proc: TGetPropProc); override;
    function GetValue: string; override;
  end;

  { TcxDefaultEditStyleControllerStyleProperty }

  TcxDefaultEditStyleControllerStyleProperty = class(TcxStyleControllerStyleProperty)
  protected
    function GetStyle: TcxContainerStyle; override;
    function IsPropertyVisible(const APropertyName: string): Boolean; override;
  end;

  { TcxNavigatorButtonImageIndexProperty }

  TcxNavigatorButtonImageIndexProperty = class(TImageIndexProperty)
  public
    function GetImages: TCustomImageList; override;
  end;

  { TcxNavigatorCustomButtonImageIndexProperty }

  TcxNavigatorCustomButtonImageIndexProperty = class(TImageIndexProperty)
  public
    function GetImages: TCustomImageList; override;
  end;

  { TcxEditButtonImageIndexProperty }

  TcxEditButtonImageIndexProperty = class(TImageIndexProperty)
  public
    function GetImages: TCustomImageList; override;
  end;

  { TcxButtonImageIndexProperty }

  TcxButtonImageIndexProperty = class(TImageIndexProperty)
  public
    function GetImages: TCustomImageList; override;
  end;

  { TdxAlertWindowButtonImageIndexProperty }

  TdxAlertWindowButtonImageIndexProperty = class(TImageIndexProperty)
  public
    function GetImages: TCustomImageList; override;
  end;

  { TdxBreadcrumbEditButtonImageIndexProperty }

  TdxBreadcrumbEditButtonImageIndexProperty = class(TImageIndexProperty)
  public
    function GetImages: TCustomImageList; override;
  end;

  { TdxBreadcrumbEditRecentPathImageIndexProperty }

  TdxBreadcrumbEditRecentPathImageIndexProperty = class(TImageIndexProperty)
  public
    function GetImages: TCustomImageList; override;
    function GetPathEditorProperties: TdxBreadcrumbEditPathEditorProperties;
  end;

  {$IFDEF DELPHI10}
  TcxEditGuidelines = class(TWinControlGuidelines)
  private
    function GetEdit: TcxCustomEdit;
  protected
    function GetCount: Integer; override;
    function GetDesignerGuideOffset(Index: Integer): Integer; override;
    function GetDesignerGuideType(Index: Integer): TDesignerGuideType; override;
    property Edit: TcxCustomEdit read GetEdit;
  end;
{$ENDIF}

  { TdxDataControllerMultithreadedSortingPropertyEditor }

  TdxDataControllerMultithreadedSortingPropertyEditor = class(TdxDefaultBooleanPropertyEditor)
  protected
    function GetDefaultValue: Boolean; override;
  end;

  { TdxDataControllerMultithreadedFilteringPropertyEditor }

  TdxDataControllerMultithreadedFilteringPropertyEditor = class(TdxDefaultBooleanPropertyEditor)
  protected
    function GetDefaultValue: Boolean; override;
  end;

implementation

uses
  SysUtils, cxButtons, cxClasses, cxControls, cxEditMaskEditor,
  cxEditRepositoryEditor, cxImage, cxImageComboBox, cxListBox, cxMaskEdit,
  cxMaskEditTextEditor, cxNavigator, cxRadioGroup, dxCore, cxScrollBox,
  cxCalendar, dxBreadcrumbEditEditor, dxGalleryDesigner, dxGalleryControl, dxBevel,
  cxCustomData;

const
  cxEditComponentEditorVerbA: array[0..1] of string = (
    'Restore properties',
    'Restore styles');

  cxEditRepositoryEditorVerb = 'Edit...';

  cxCustomEditControlEditorVerbA: array[0..1] of string = (
    'Restore LookAndFeel',
    'Restore Styles'
  );

  cxCustomNavigatorEditorVerb = 'Restore Buttons';

  ADefaultMethodParams: array[0..0] of TMethodParam =
    ((Flags: [pfAddress]; Name: 'Sender'; TypeName: 'TObject'));

  cxNavigatorButtonsOnButtonClickEventParams: array[0..2] of TMethodParam = (
    (Flags: [pfAddress]; Name: 'Sender'; TypeName: 'TObject'),
    (Flags: [pfAddress]; Name: 'AButtonIndex'; TypeName: 'Integer'),
    (Flags: [pfVar]; Name: 'ADone'; TypeName: 'Boolean')
  );

type
  TcxControlAccess = class(TcxControl);
  TcxCustomEditAccess = class(TcxCustomEdit);
  TcxCustomEditPropertiesAccess = class(TcxCustomEditProperties);
  TcxCustomMaskEditPropertiesAccess = class(TcxCustomMaskEditProperties);
  TcxCustomNavigatorAccess = class(TcxCustomNavigator);
  TcxButtonImageOptionsAccess = class(TcxButtonImageOptions);
  TdxCustomBreadcrumbEditPropertiesAccess = class(TdxCustomBreadcrumbEditProperties);
  TdxBreadcrumbEditPathEditorPropertiesAccess = class(TdxBreadcrumbEditPathEditorProperties);
  TdxGalleryControlItemAccess = class(TdxGalleryControlItem);
  TdxCustomGalleryControlAccess = class(TdxCustomGalleryControl);

{ TDBStringProperty }

function TDBStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TDBStringProperty.GetValueList(AList: TStrings);
begin
end;

procedure TDBStringProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{$IFDEF CBUILDER10}

{ TcxDataFieldProperty }

function TcxDataFieldProperty.GetDataSourcePropName: string;
begin
  Result := 'DataSource';
end;

procedure TcxDataFieldProperty.GetValueList(AList: TStrings);
var
  DataSource: TDataSource;
  AAggList: TStringList;
begin
  DataSource := GetObjectProp(GetComponent(0), GetDataSourcePropName) as TDataSource;
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
  begin
  {$WARN SYMBOL_DEPRECATED OFF}
    DataSource.DataSet.GetFieldNames(AList);
  {$WARN SYMBOL_DEPRECATED ON}
    if DataSource.DataSet.AggFields.Count > 0 then
    begin
      AAggList := TStringList.Create;
      try
        DataSource.DataSet.AggFields.GetFieldNames(AAggList);
        AList.AddStrings(AAggList);
      finally
        AAggList.Free;
      end;
    end;
  end;
end;

{$ELSE}
{ TcxDataFieldProperty }

procedure TcxDataFieldProperty.GetValueList(List: TdxValues);
var
  DataSource: TDataSource;
  AAggList: TdxValues;
begin
  DataSource := GetObjectProp(GetComponent(0), GetDataSourcePropName) as TDataSource;
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
  begin
    inherited GetValueList(List);
    if DataSource.DataSet.AggFields.Count > 0 then
    begin
      AAggList := TdxValueList.Create;
      try
        DataSource.DataSet.AggFields.GetFieldNames(AAggList);
        List.AddStrings(AAggList);
      finally
        AAggList.Free;
      end;
    end;
  end;
end;

{$ENDIF}

{ TcxDateProperty }

function TcxDateProperty.GetValue: string;
var
  DT: TDateTime;
begin
  DT := GetFloatValue;
  if DT <> NullDate then
    Result := inherited GetValue
  else
    Result := StringReplace(DateTimeToStr(MinDateTime), '1', '0', [rfReplaceAll])
end;

{ TcxValueTypeProperty }

function TcxValueTypeProperty.IsValueTypeClassValid(AValueTypeClass: TcxValueTypeClass): Boolean;
begin
  Result := True;
end;

function TcxValueTypeProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paMultiSelect, paSortList, paRevertable];
end;

procedure TcxValueTypeProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to cxValueTypeClassList.Count - 1 do
    if IsValueTypeClassValid(cxValueTypeClassList[I]) then
      Proc(cxValueTypeClassList[I].Caption);
end;

function TFieldNameProperty.GetDataSource: TDataSource;
begin
  Result := GetObjectProp(GetComponent(0), GetDataSourcePropName) as TDataSource;
end;

function TFieldNameProperty.GetDataSourcePropName: string;
begin
  Result := 'DataSource';
end;

procedure TFieldNameProperty.GetValueList(AList: TStrings);
var
  ADataSource: TDataSource;
begin
  ADataSource := GetDataSource;
  if (ADataSource <> nil) and (ADataSource.DataSet <> nil) then
{$WARN SYMBOL_DEPRECATED OFF}
    ADataSource.DataSet.GetFieldNames(AList);
{$WARN SYMBOL_DEPRECATED ON}
end;

{ TcxCustomEditorsLibraryComponentEditor }

function TcxCustomEditorsLibraryComponentEditor.GetProductName: string;
begin
  Result := cxEditorsLibraryProductName;
end;

{ TcxEditComponentEditor }

procedure TcxEditComponentEditor.Edit;
var
  AEdit: TcxCustomEdit;
  AEventName: string;
  AInstance: TObject;
  AMethodName: string;
  AProperties: TcxCustomEditProperties;
begin
  AEdit := TcxCustomEdit(Component);
  AMethodName := Component.Name;
  if not(AEdit.InnerControl <> nil) and
    (GetPropInfo(PTypeInfo(AEdit.ClassInfo), 'OnClick') <> nil) then
  begin
    AMethodName := AMethodName + 'Click';
    AInstance := AEdit;
    AEventName := 'OnClick';
  end
  else
  begin
    AProperties := TcxCustomEditAccess(AEdit).Properties;
    if GetPropInfo(PTypeInfo(AProperties.ClassInfo), 'OnChange') <> nil then
    begin
      AMethodName := AMethodName + 'PropertiesChange';
      AInstance := AProperties;
      AEventName := 'OnChange';
    end
    else
      Exit;
  end;

  ShowEventMethod(Designer, AInstance, AEventName, AMethodName, ADefaultMethodParams);
end;

function TcxEditComponentEditor.InternalGetVerb(Index: Integer): string;
begin
  Result := cxEditComponentEditorVerbA[Index];
end;

function TcxEditComponentEditor.InternalGetVerbCount: Integer;
begin
  Result := Length(cxEditComponentEditorVerbA);
end;

procedure TcxEditComponentEditor.InternalExecuteVerb(AIndex: Integer);
begin
  case AIndex of
    0:
      TcxCustomEditAccess(GetEdit).Properties.RestoreDefaults;
    1:
      GetEdit.RestoreStyles;
  end;
  Designer.Modified;
end;

function TcxEditComponentEditor.GetEdit: TcxCustomEdit;
begin
  Result := Component as TcxCustomEdit;
end;

{ TcxEditRepositoryItemProperty }

function TcxEditRepositoryItemProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  if TcxCustomEdit(GetComponent(0)).RepositoryItem <> nil then
    Include(Result, paNotNestable);
end;

procedure TcxEditRepositoryItemProperty.GetValues(Proc: TGetStrProc);
begin
  FStrProc := Proc;
  Designer.GetComponentNames(GetTypeData(GetPropType), StrProc);
end;

procedure TcxEditRepositoryItemProperty.StrProc(const S: string);
var
  I: Integer;
  ARepositoryItemAcceptable: Boolean;
begin
  ARepositoryItemAcceptable := True;
  for I := 0 to PropCount - 1 do
  if not TcxCustomEdit(GetComponent(I)).IsRepositoryItemAcceptable(
    TcxEditRepositoryItem(Designer.GetComponent(S))) then
  begin
    ARepositoryItemAcceptable := False;
    Break;
  end;
  if ARepositoryItemAcceptable then
    FStrProc(S);
end;

{ TcxLookupEditListSourceProperty }

function TcxLookupEditListSourceProperty.GetDataSourcePropName: string;
begin
  Result := 'ListSource';
end;

{ TcxEditPropertiesEventEditor }

function TcxEditPropertiesEventEditor.GetName: string;
begin
  Result := 'Properties';
end;

function TcxEditPropertiesEventEditor.GetInstance: TPersistent;
begin
  Result := TcxCustomEditAccess(GetComponent(0)).Properties;
end;

{ TcxEditRepositoryItemPropertiesEventEditor }

function TcxEditRepositoryItemPropertiesEventEditor.GetName: string;
begin
  Result := 'Properties';
end;

function TcxEditRepositoryItemPropertiesEventEditor.GetInstance: TPersistent;
begin
  Result := TcxEditRepositoryItem(GetComponent(0)).Properties;
end;

{ TcxNavigatorButtonsEventEditor }

function TcxNavigatorButtonsEventEditor.GetName: string;
begin
  Result := 'Buttons';
end;

function TcxNavigatorButtonsEventEditor.GetInstance: TPersistent;
begin
  Result := TcxCustomNavigatorAccess(GetComponent(0)).CustomButtons;
end;

{ TcxNavigatorInfoPanelEventEditor }

function TcxNavigatorInfoPanelEventEditor.GetName: string;
begin
  Result := 'InfoPanel';
end;

function TcxNavigatorInfoPanelEventEditor.GetInstance: TPersistent;
begin
  Result := TcxCustomNavigatorAccess(GetComponent(0)).CustomInfoPanel;
end;

{ TcxGetPropertiesImageIndexProperty }

function TcxGetPropertiesImageIndexProperty.GetImages: TCustomImageList;
begin
  Result := nil;
  if GetComponent(0) is TcxImageComboBoxProperties then
    Result := TcxImageComboBoxProperties(GetComponent(0)).Images;
end;

{ TcxGetItemImageIndexProperty }

function TcxGetItemImageIndexProperty.GetImages: TCustomImageList;
begin
  Result := nil;
  if GetComponent(0) is TcxImageComboBoxItem then
  begin
    Result := TcxImageComboBoxProperties(TcxImageComboBoxItems(
      TcxImageComboBoxItem(GetComponent(0)).Collection).Owner).LargeImages;
    if Result = nil then
      Result := TcxImageComboBoxProperties(TcxImageComboBoxItems(
        TcxImageComboBoxItem(GetComponent(0)).Collection).Owner).Images;
  end;
end;

{ TdxGalleryControlItemImageIndexProperty }

function TdxGalleryControlItemImageIndexProperty.GetImages: TCustomImageList;
begin
  Result := nil;
  if GetComponent(0) is TdxGalleryControlItem then
    Result := TdxCustomGalleryControlAccess(TdxGalleryControlItemAccess(GetComponent(0)).GalleryControl).Images;
end;

{ TcxEditorsLibraryComponentEditorEx }

function TcxEditorsLibraryComponentEditorEx.GetEditItemcaption: string;
begin
  Result := cxEditRepositoryEditorVerb;
end;

function TcxEditorsLibraryComponentEditorEx.InternalGetVerb(AIndex: Integer): string;
begin
  Result := GetEditItemCaption;
end;

function TcxEditorsLibraryComponentEditorEx.InternalGetVerbCount: Integer;
begin
  Result := 1;
end;

procedure TcxEditorsLibraryComponentEditorEx.InternalExecuteVerb(AIndex: Integer);
begin
  ExecuteEditAction;
end;

{ TcxEditRepositoryComponentEditor }

procedure TcxEditRepositoryComponentEditor.ExecuteEditAction;
begin
  ShowEditRepositoryEditor(Designer, GetEditRepository);
end;

function TcxEditRepositoryComponentEditor.GetEditRepository: TcxEditRepository;
begin
  Result := Component as TcxEditRepository
end;

{ TcxEditMaskProperty }

function TcxEditMaskProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect];
end;

procedure TcxEditMaskProperty.Edit;
var
  ADialog: TcxEditMaskEditorDlg;
  AMaskEditProperties: TcxCustomMaskEditPropertiesAccess;
  APrevEditMask: string;
  APrevMaskKind: TcxEditMaskKind;
  I: Integer;
begin
  AMaskEditProperties := TcxCustomMaskEditPropertiesAccess(GetComponent(0));
  APrevEditMask := AMaskEditProperties.EditMask;
  APrevMaskKind := AMaskEditProperties.MaskKind;
  ADialog := TcxEditMaskEditorDlg.Create(Application);
  try
    ADialog.MaskEditProperties := AMaskEditProperties;
    if ADialog.ShowModal = mrOk then
      for I := 1 to PropCount - 1 do
        with TcxCustomMaskEditPropertiesAccess(GetComponent(I)) do
        begin
          MaskKind := AMaskEditProperties.MaskKind;
          EditMask := AMaskEditProperties.EditMask;
        end;
    if (APrevMaskKind <> AMaskEditProperties.MaskKind) or
      (APrevEditMask <> AMaskEditProperties.EditMask) then
        Designer.Modified;
  finally
    ADialog.Free;
  end;
end;

{ TcxTextProperty }

function TcxTextProperty.GetAttributes: TPropertyAttributes;
begin
  if CanShowDialog then
    Result := [paDialog]
  else
    Result := [paMultiSelect];
end;

procedure TcxTextProperty.Edit;
var
  ADialog: TcxMaskEditTextEditorDlg;
begin
  ADialog := TcxMaskEditTextEditorDlg.Create(Application);
  try
    ADialog.MaskEdit := TcxCustomMaskEdit(GetComponent(0));
    ADialog.ShowModal;
  finally
    ADialog.Free;
  end;
end;

function TcxTextProperty.CanShowDialog: Boolean;
begin
  Result := (PropCount = 1) and
    TcxCustomMaskEdit(GetComponent(0)).ActiveProperties.IsMasked;
end;

{ TGraphicClassNameProperty }

function TGraphicClassNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paRevertable];
end;

procedure TGraphicClassNameProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for i := 0 to GetRegisteredGraphicClasses.Count - 1 do
    Proc(TClass(GetRegisteredGraphicClasses[I]).ClassName);
end;

{ TcxControlSelectionEditor }

procedure TcxControlSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('cxGraphics');
  Proc('cxControls');
  Proc('cxLookAndFeels');
  Proc('cxLookAndFeelPainters');
end;

{ TcxCustomEditSelectionEditor }

procedure TcxCustomEditSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('cxContainer');
  Proc('cxEdit');
end;

{ TcxButtonSelectionEditor }

procedure TcxButtonSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('cxGraphics');
  Proc('cxLookAndFeels');
  Proc('cxLookAndFeelPainters');
{$IFDEF DELPHI16}
  Proc('Vcl.Menus');
{$ELSE}
  Proc('Menus');
{$ENDIF}
end;

{ TcxFilterControlComponentEditor }

function TcxFilterControlComponentEditor.GetProductName: string;
begin
  Result := cxEditorsLibraryProductName;
end;

{ TcxNavigatorControlProperty }

procedure TcxNavigatorControlProperty.GetValues(Proc: TGetStrProc);
begin
  FStrProc := Proc;
  Designer.GetComponentNames(GetTypeData(GetPropType), StrProc);
end;

procedure TcxNavigatorControlProperty.StrProc(const S: string);
var
  AComponent: TComponent;
begin
  AComponent := Designer.GetComponent(S);
  if (AComponent <> nil) and Supports(AComponent, IcxNavigator) then
    FStrProc(S);
end;

{ TcxEditorsLibraryComponentEditor }

procedure TcxEditorsLibraryComponentEditor.Edit;
begin
  ShowEventMethod(Designer, Component, 'OnClick', Component.Name + 'Click',
    ADefaultMethodParams);
end;

{ TcxEditorsLibraryComponentWithStylesEditor }

function TcxEditorsLibraryComponentWithStylesEditor.GetEditItemCaption: string;
begin
  Result := cxCustomEditControlEditorVerbA[1];
end;

procedure TcxEditorsLibraryComponentWithStylesEditor.ExecuteEditAction;
begin
  RestoreStyles;
  Designer.Modified;
end;

{ TcxEditorsLibraryComponentWithoutStylesEditor }

function TcxEditorsLibraryComponentWithoutStylesEditor.GetEditItemCaption: string;
begin
  Result := cxCustomEditControlEditorVerbA[0];
end;

procedure TcxEditorsLibraryComponentWithoutStylesEditor.ExecuteEditAction;
begin
  if GetLookAndFeel.AssignedValues <> [] then
  begin
    GetLookAndFeel.Reset;
    Designer.Modified;
  end;
end;

{ TcxEditorsLibraryCXControlComponentEditor }
 
function TcxEditorsLibraryCXControlComponentEditor.GetLookAndFeel: TcxLookAndFeel;
begin
  Result := TcxControlAccess(Component).LookAndFeel;
end;

{ TcxBreadcrumbEditComponentEditor }

function TcxBreadcrumbEditComponentEditor.InternalGetVerb(AIndex: Integer): string;
begin
  if AIndex = 0 then
    Result := 'Edit...'
  else
    Result := inherited InternalGetVerb(AIndex - 1);
end;

function TcxBreadcrumbEditComponentEditor.InternalGetVerbCount: Integer;
begin
  Result := inherited InternalGetVerbCount + 1;
end;

procedure TcxBreadcrumbEditComponentEditor.InternalExecuteVerb(AIndex: Integer);
begin
  if AIndex = 0 then
    Edit
  else
    inherited InternalExecuteVerb(AIndex - 1);
end;

procedure TcxBreadcrumbEditComponentEditor.Edit;
begin
  dxBreadcrumbEditShowEditor(Component as TdxBreadcrumbEdit);
end;

{ TdxBreadcrumbEditSelectedPathPropertyEditor }

procedure TdxBreadcrumbEditSelectedPathPropertyEditor.Edit;
begin
  dxBreadcrumbEditShowEditor(GetComponent(0) as TdxBreadcrumbEdit);
end;

function TdxBreadcrumbEditSelectedPathPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  if PropCount = 1 then
    Include(Result, paDialog);
end;

{ TdxBevelComponentEditor }

function TdxBevelComponentEditor.GetLookAndFeel: TcxLookAndFeel;
begin
  Result := TdxCustomBevel(Component).LookAndFeel; 
end;

{ TcxEditStyleControllerEditor }

procedure TcxEditStyleControllerEditor.Edit;
begin
  ShowEventMethod(Designer, Component, 'OnStyleChanged',
    Component.Name + 'StyleChanged', ADefaultMethodParams);
end;

procedure TcxEditStyleControllerEditor.RestoreStyles;
begin
  TcxEditStyleController(Component).RestoreStyles;
end;

{ TcxDefaultEditStyleControllerEditor }

procedure TcxDefaultEditStyleControllerEditor.Edit;
begin
  ShowEventMethod(Designer, Component, 'OnStyleChanged',
    Component.Name + 'StyleChanged', ADefaultMethodParams);
end;

procedure TcxDefaultEditStyleControllerEditor.RestoreStyles;
begin
  DefaultEditStyleController.RestoreStyles;
end;

{ TcxCustomButtonComponentEditor }

function TcxCustomButtonComponentEditor.GetLookAndFeel: TcxLookAndFeel;
begin
  Result := TcxCustomButton(Component).LookAndFeel;
end;

{ TdxAlertWindowComponentEditor }

function TdxAlertWindowComponentEditor.GetLookAndFeel: TcxLookAndFeel;
begin
  Result := TdxAlertWindowManager(Component).LookAndFeel;
end;

{ TcxRadioButtonComponentEditor }

function TcxRadioButtonComponentEditor.GetLookAndFeel: TcxLookAndFeel;
begin
  Result := TcxRadioButton(Component).LookAndFeel;
end;

{ TcxContainerComponentEditor }

procedure TcxContainerComponentEditor.RestoreStyles;
begin
  TcxContainer(Component).RestoreStyles;
end;

{ TcxCustomNavigatorComponentEditor }

procedure TcxCustomNavigatorComponentEditor.Edit;
var
  AButtons: TcxCustomNavigatorButtons;
begin
  AButtons := TcxCustomNavigatorAccess(Component).CustomButtons;
  ShowEventMethod(Designer, AButtons, 'OnButtonClick',
    Component.Name + 'ButtonsButtonClick', cxNavigatorButtonsOnButtonClickEventParams);
end;

function TcxCustomNavigatorComponentEditor.InternalGetVerb(AIndex: Integer): string;
begin
  if AIndex = 1 then
    Result := cxCustomNavigatorEditorVerb
  else
    Result := inherited InternalGetVerb(AIndex);
end;

function TcxCustomNavigatorComponentEditor.InternalGetVerbCount: Integer;
begin
  Result := 1 + inherited InternalGetVerbCount;
end;

procedure TcxCustomNavigatorComponentEditor.InternalExecuteVerb(AIndex: Integer);
begin
  if AIndex = 1 then
  begin
    TcxCustomNavigator(Component).RestoreButtons;
    Designer.Modified;
  end
  else
    inherited InternalExecuteVerb(AIndex);
end;

{ TdxGalleryControlComponentEditor }

procedure TdxGalleryControlComponentEditor.ExecuteEditAction;
begin
  EditGallery(Component);
end;

{ TdxSliderImageComponentEditor }

procedure TdxSliderImageComponentEditor.Edit;
begin
  ShowEventMethod(Designer, Component, 'OnChange',
    Component.Name + 'Change', ADefaultMethodParams);
end;

{ TcxCustomImagePropertiesProperty }

procedure TcxCustomImagePropertiesProperty.GetProperties(Proc: TGetPropProc);
begin
  FProc := Proc;
  inherited GetProperties(GetPropProc);
end;

procedure TcxCustomImagePropertiesProperty.GetPropProc(const Prop: IProperty);
var
  I: Integer;
begin
  if InternalCompareString(Prop.GetName, 'OnGetGraphicClass', False) then
    for I := 0 to PropCount - 1 do
      if TcxCustomImage(GetComponent(I)).RepositoryItem = nil then
        Exit;
  FProc(Prop);
end;

{ TcxEditPropertiesAssignedValuesProperty }

procedure TcxEditPropertiesAssignedValuesProperty.GetProperties(Proc: TGetPropProc);
begin
  FProc := Proc;
  inherited GetProperties(GetPropProc);
end;

function TcxEditPropertiesAssignedValuesProperty.GetValue: string;
var
  AAssignedValues: TcxCustomEditPropertiesValues;
  APPropList: PPropList;
  APropertyCount: Integer;
  I: Integer;
begin
  Result := '';
  AAssignedValues := TcxCustomEditPropertiesAccess(GetComponent(0)).AssignedValues;
  APropertyCount := GetPropList(GetPropType, [tkUnknown..tkDynArray], nil);
  if APropertyCount > 0 then
  begin
    GetMem(APPropList, APropertyCount * SizeOf(Pointer));
    try
      GetPropList(GetPropType, [tkUnknown..tkDynArray], APPropList);
      for I := 0 to APropertyCount - 1 do
        if Boolean(GetOrdProp(AAssignedValues, APPropList[I])) and
          IsVisibleProperty(dxShortStringToString(APPropList[I].Name)) then
        begin
          if Result <> '' then
            Result := Result + ',';
          Result := Result + dxShortStringToString(APPropList[I].Name);
        end;
    finally
      FreeMem(APPropList);
    end;
  end;
  Result := '[' + Result + ']';
end;

procedure TcxEditPropertiesAssignedValuesProperty.GetPropProc(const Prop: IProperty);
begin
  if IsVisibleProperty(Prop.GetName) then
    FProc(Prop);
end;

function TcxEditPropertiesAssignedValuesProperty.IsVisibleProperty(
  const APropertyName: string): Boolean;
begin
  Result := TypInfo.GetPropInfo(TcxCustomEditProperties(GetComponent(0)),
    APropertyName) <> nil;
end;

{ TcxDefaultEditStyleControllerStyleProperty }

function TcxDefaultEditStyleControllerStyleProperty.GetStyle: TcxContainerStyle;
begin
  Result := DefaultEditStyleController.Style;
end;

function TcxDefaultEditStyleControllerStyleProperty.IsPropertyVisible(
  const APropertyName: string): Boolean;
begin
  Result := (APropertyName <> 'StyleController') and
    inherited IsPropertyVisible(APropertyName);
end;

{ TcxNavigatorButtonImageIndexProperty }

function TcxNavigatorButtonImageIndexProperty.GetImages: TCustomImageList;
begin
  Result := TcxNavigatorButton(GetComponent(0)).Buttons.Images;
end;

{ TcxNavigatorCustomButtonImageIndexProperty }

function TcxNavigatorCustomButtonImageIndexProperty.GetImages: TCustomImageList;
begin
  Result := (TcxNavigatorCustomButton(GetComponent(0)).Collection.Owner as TcxCustomNavigatorButtons).Images;
end;

{ TcxEditButtonImageIndexProperty }

function TcxEditButtonImageIndexProperty.GetImages: TCustomImageList;
begin
  Result := TcxCustomEditProperties(TcxEditButtons(TcxEditButton(GetComponent(0)).Collection).Owner).Images;
end;

{ TcxButtonImageIndexProperty }

function TcxButtonImageIndexProperty.GetImages: TCustomImageList;
var
  AOptionsImage: TcxButtonImageOptionsAccess;
  AButton: TcxButton;
begin
  AOptionsImage := TcxButtonImageOptionsAccess(GetComponent(0));
  if AOptionsImage.Images <> nil then
    Result := AOptionsImage.Images
  else
  begin
    AButton := (AOptionsImage.GetOwner as TcxButton);
    if (AButton.Action <> nil) and (AButton.Action is TCustomAction) and
      (TCustomAction(AButton.Action).ActionList <> nil)
    then
      Result := TCustomAction(AButton.Action).ActionList.Images
    else
      Result := nil;
  end;
end;

{ TdxBreadcrumbEditRecentPathImageIndexProperty }

function TdxBreadcrumbEditRecentPathImageIndexProperty.GetImages: TCustomImageList;
begin
  Result := TdxCustomBreadcrumbEditPropertiesAccess(
    TdxBreadcrumbEditPathEditorPropertiesAccess(GetPathEditorProperties).Owner).Images;
end;

function TdxBreadcrumbEditRecentPathImageIndexProperty.GetPathEditorProperties: TdxBreadcrumbEditPathEditorProperties;
begin
  Result := TdxBreadcrumbEditPathEditorProperties(
    TdxBreadcrumbEditRecentPath(GetComponent(0)).Collection.Owner);
end;

{ TdxBreadcrumbEditButtonImageIndexProperty }

function TdxBreadcrumbEditButtonImageIndexProperty.GetImages: TCustomImageList;
begin
  Result := TdxCustomBreadcrumbEditPropertiesAccess(
    TdxBreadcrumbEditButton(GetComponent(0)).Collection.Owner).ButtonImages;
end;

{ TdxAlertWindowButtonImageIndexProperty }

function TdxAlertWindowButtonImageIndexProperty.GetImages: TCustomImageList;
begin
  Result := TdxAlertWindowOptionsButtons(TdxAlertWindowButtons(
    TdxAlertWindowButton(GetComponent(0)).Collection).Owner).Images;
end;

{$IFDEF DELPHI10}
{ TcxEditGuidelines }

function TcxEditGuidelines.GetCount: Integer;
begin
  Result := inherited GetCount;
  if Edit.HasTextBaseLine then
    Inc(Result);
end;

function TcxEditGuidelines.GetDesignerGuideOffset(Index: Integer): Integer;
begin
  if Edit.HasTextBaseLine and (Index = GetCount - 1) then
    Result := Edit.GetTextBaseLine
  else
    Result := inherited GetDesignerGuideOffset(Index);
end;

function TcxEditGuidelines.GetDesignerGuideType(Index: Integer): TDesignerGuideType;
begin
  if Edit.HasTextBaseLine and (Index = GetCount - 1) then
    Result := gtBaseline
  else
    Result := inherited GetDesignerGuideType(Index);
end;

function TcxEditGuidelines.GetEdit: TcxCustomEdit;
begin
  Result := TcxCustomEdit(Component);
end;
{$ENDIF}


{ TdxDataControllerMultithreadedSortingPropertyEditor }

function TdxDataControllerMultithreadedSortingPropertyEditor.GetDefaultValue: Boolean;
begin
  Result := dxDefaultMultiThreadedSorting;
end;

{ TdxDataControllerMultithreadedFilteringPropertyEditor }

function TdxDataControllerMultithreadedFilteringPropertyEditor.GetDefaultValue: Boolean;
begin
  Result := dxDefaultMultiThreadedFiltering;
end;

procedure HideClassProperties(AClass: TClass; APropertyNames: array of string);
var
  I: Integer;
begin
  for I := Low(APropertyNames) to High(APropertyNames) do
    RegisterPropertyEditor(GetPropInfo(AClass, APropertyNames[I]).PropType^,
      AClass, APropertyNames[I], nil);
end;

end.

