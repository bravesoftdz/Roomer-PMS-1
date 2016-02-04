{***************************************************************************}
{ TMS Unicode Component Pack                                                }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ Copyright � 2007 by TMS software                                          }
{ Email : info@tmssoftware.com                                              }
{ Web : http://www.tmssoftware.com                                          }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit TntShlObj;

{$INCLUDE TntCompilers.inc}

interface

uses
  Windows, ActiveX, CommCtrl, ShellAPI, RegStr, Messages, WinInet, UrlMon;

{$HPPEMIT '// If problems occur when compiling win32 structs, records, or'}
{$HPPEMIT '// unions, please define NO_WIN32_LEAN_AND_MEAN to force inclusion'}
{$HPPEMIT '// of Windows header files. '}

{$IFDEF COMPILER_9_UP}

{$HPPEMIT '#if defined(NO_WIN32_LEAN_AND_MEAN)'}
{$HPPEMIT '#include <ole2.h>'}
{$HPPEMIT '#include <prsht.h>'}
{$HPPEMIT '#include <commctrl.h>   // for LPTBBUTTON'}
{$HPPEMIT '#include <shlguid.h>'}
{$HPPEMIT '#include <shlobj.h>'}
{$HPPEMIT '#include <shldisp.h>'}
{$HPPEMIT '#endif'}

{$ENDIF}

{ IFileDialogEvents }

const
{$IFDEF COMPILER_9_UP}
{$HPPEMIT '#if !defined(NO_WIN32_LEAN_AND_MEAN)'}
{$ENDIF}
{$HPPEMIT 'interface DECLSPEC_UUID("b4db1657-70d7-485e-8e3e-6fcb5a5c1802") IModalWindow;'}
{$HPPEMIT 'interface DECLSPEC_UUID("70629033-e363-4a28-a567-0db78006e6d7") IEnumShellItems;'}
{$HPPEMIT 'interface DECLSPEC_UUID("43826d1e-e718-42ee-bc55-a1e261c37bfe") IShellItem;'}
{$HPPEMIT 'interface DECLSPEC_UUID("2659B475-EEB8-48b7-8F07-B378810F48CF") IShellItemFilter;'}
{$HPPEMIT 'interface DECLSPEC_UUID("b63ea76d-1f85-456f-a19c-48159efa858b") IShellItemArray;'}
{$HPPEMIT 'interface DECLSPEC_UUID("886d8eeb-8cf2-4446-8d02-cdba1dbdcf99") IPropertyStore;'}
{$HPPEMIT 'interface DECLSPEC_UUID("1f9fc1d0-c39b-4b26-817f-011967d3440e") IPropertyDescriptionList;'}
{$HPPEMIT 'interface DECLSPEC_UUID("04b0f1a7-9490-44bc-96e1-4296a31252e2") IFileOperationProgressSink;'}
{$HPPEMIT 'interface DECLSPEC_UUID("e6fdd21a-163f-4975-9c8c-a69f1ba37034") IFileDialogCustomize;'}
{$HPPEMIT 'interface DECLSPEC_UUID("973510db-7d7f-452b-8975-74a85828d354") IFileDialogEvents;'}
{$HPPEMIT 'interface DECLSPEC_UUID("36116642-D713-4b97-9B83-7484A9D00433") IFileDialogControlEvents;'}
{$HPPEMIT 'interface DECLSPEC_UUID("42f85136-db7e-439c-85f1-e4075d135fc8") IFileDialog;'}
{$HPPEMIT 'interface DECLSPEC_UUID("d57c7288-d4ad-4768-be02-9d969532d960") IFileOpenDialog;'}
{$HPPEMIT 'interface DECLSPEC_UUID("84bccd23-5fde-4cdb-aea4-af64b83d78ab") IFileSaveDialog;'}

{$IFDEF COMPILER_9_UP}
{$HPPEMIT '#endif'}
{$ENDIF}

  SID_IModalWindow       = '{b4db1657-70d7-485e-8e3e-6fcb5a5c1802}';
  SID_IEnumShellItem     = '{70629033-e363-4a28-a567-0db78006e6d7}';
  SID_IShellItem         = '{43826d1e-e718-42ee-bc55-a1e261c37bfe}';
  SID_IShellItemFilter   = '{2659B475-EEB8-48b7-8F07-B378810F48CF}';
  SID_IShellItemArray    = '{b63ea76d-1f85-456f-a19c-48159efa858b}';
  SID_IPropertyStore     = '{886d8eeb-8cf2-4446-8d02-cdba1dbdcf99}';
  SID_IPropertyDescriptionList = '{1f9fc1d0-c39b-4b26-817f-011967d3440e}';
  SID_IFileOperationProgressSink = '{04b0f1a7-9490-44bc-96e1-4296a31252e2}';
  SID_IFileDialogCustomize = '{e6fdd21a-163f-4975-9c8c-a69f1ba37034}';
  SID_IFileDialogEvents  = '{973510db-7d7f-452b-8975-74a85828d354}';
  SID_IFileDialogControlEvents = '{36116642-D713-4b97-9B83-7484A9D00433}';
  SID_IFileDialog        = '{42f85136-db7e-439c-85f1-e4075d135fc8}';
  SID_IFileOpenDialog    = '{d57c7288-d4ad-4768-be02-9d969532d960}';
  SID_IFileSaveDialog    = '{84bccd23-5fde-4cdb-aea4-af64b83d78ab}';

  {$EXTERNALSYM CLSID_ShelllItem}
  CLSID_ShelllItem: TGUID = (
    D1:$43826d1e; D2:$e718; D3:$42ee; D4:($bc,$55,$a1,$e2,$61,$c3,$7b,$fe));
  {$EXTERNALSYM CLSID_FileOpenDialog}
  CLSID_FileOpenDialog: TGUID = (
    D1:$DC1C5A9C; D2:$E88A; D3:$4DDE; D4:($A5,$A1,$60,$F8,$2A,$20,$AE,$F7));
  {$EXTERNALSYM CLSID_FileSaveDialog}
  CLSID_FileSaveDialog: TGUID = (
    D1:$C0B4E2F3; D2:$BA21; D3:$4773; D4:($8D,$BA,$33,$5E,$C9,$46,$EB,$8B));

  {$EXTERNALSYM FDEOR_DEFAULT}
  FDEOR_DEFAULT       = 0;
  {$EXTERNALSYM FDEOR_ACCEPT}
  FDEOR_ACCEPT        = $1;
  {$EXTERNALSYM FDEOR_REFUSE}
  FDEOR_REFUSE        = $2;

  {$EXTERNALSYM FDESVR_DEFAULT}
  FDESVR_DEFAULT      = 0;
  {$EXTERNALSYM FDESVR_ACCEPT}
  FDESVR_ACCEPT       = $1;
  {$EXTERNALSYM FDESVR_REFUSE}
  FDESVR_REFUSE       = $2;

  {$EXTERNALSYM FDAP_BOTTOM}
  FDAP_BOTTOM         = 0;
  {$EXTERNALSYM FDAP_TOP}
  FDAP_TOP            = $1;

  { IShellItem }

  {$EXTERNALSYM SIGDN_NORMALDISPLAY}
  SIGDN_NORMALDISPLAY                 = 0;
  {$EXTERNALSYM SIGDN_PARENTRELATIVEPARSING}
  SIGDN_PARENTRELATIVEPARSING         = $80018001;
  {$EXTERNALSYM SIGDN_DESKTOPABSOLUTEPARSING}
  SIGDN_DESKTOPABSOLUTEPARSING        = $80028000;
  {$EXTERNALSYM SIGDN_PARENTRELATIVEEDITING}
  SIGDN_PARENTRELATIVEEDITING         = $80031001;
  {$EXTERNALSYM SIGDN_DESKTOPABSOLUTEEDITING}
  SIGDN_DESKTOPABSOLUTEEDITING        = $8004c000;
  {$EXTERNALSYM SIGDN_FILESYSPATH}
  SIGDN_FILESYSPATH                   = $80058000;
  {$EXTERNALSYM SIGDN_URL}
  SIGDN_URL                           = $80068000;
  {$EXTERNALSYM SIGDN_PARENTRELATIVEFORADDRESSBAR}
  SIGDN_PARENTRELATIVEFORADDRESSBAR   = $8007c001;
  {$EXTERNALSYM SIGDN_PARENTRELATIVE}
  SIGDN_PARENTRELATIVE                = $80080001;

  {$EXTERNALSYM SICHINT_DISPLAY}
  SICHINT_DISPLAY                     = 0;
  {$EXTERNALSYM SICHINT_ALLFIELDS}
  SICHINT_ALLFIELDS                   = $80000000;
  {$EXTERNALSYM SICHINT_CANONICAL}
  SICHINT_CANONICAL                   = $10000000;

  { IShellItemArray }
  {$EXTERNALSYM SIATTRIBFLAGS_AND}
  SIATTRIBFLAGS_AND           = $1;
  {$EXTERNALSYM SIATTRIBFLAGS_OR}
  SIATTRIBFLAGS_OR            = $2;
  {$EXTERNALSYM SIATTRIBFLAGS_APPCOMPAT}
  SIATTRIBFLAGS_APPCOMPAT     = $3;
  {$EXTERNALSYM SIATTRIBFLAGS_MASK}
  SIATTRIBFLAGS_MASK          = $3;

  { IFileDialogCustomize }
  {$EXTERNALSYM CDCS_INACTIVE}
  CDCS_INACTIVE               = $0;
  {$EXTERNALSYM CDCS_ENABLED}
  CDCS_ENABLED                = $1;
  {$EXTERNALSYM CDCS_VISIBLE}
  CDCS_VISIBLE                = $2;


//
// Sample use for IFileDialogCustomize interface use
//
// procedure ShowOpenDialog;
// var
//    FileDialog: IFileDialog;
//    FileDialogCustomize: IFileDialogCustomize;
// begin
//    CoCreateInstance(CLSID_FileOpenDialog, nil, CLSCTX_INPROC_SERVER,
//      IFileOpenDialog, FileDialog);
//    FileDialog.QueryInterface(
//     StringToGUID('{8016B7B3-3D49-4504-A0AA-2A37494E606F}'),
//     FileDialogCustomize);
//    FileDialogCustomize.AddText(1000, 'My first Test');
//    FileDialog.Show();
// end;

  { IFileOpenDialog }
  {$EXTERNALSYM FOS_OVERWRITEPROMPT}
  FOS_OVERWRITEPROMPT         = $2;
  {$EXTERNALSYM FOS_STRICTFILETYPES}
  FOS_STRICTFILETYPES         = $4;
  {$EXTERNALSYM FOS_NOCHANGEDIR}
  FOS_NOCHANGEDIR             = $8;
  {$EXTERNALSYM FOS_PICKFOLDERS}
  FOS_PICKFOLDERS             = $20;
  {$EXTERNALSYM FOS_FORCEFILESYSTEM}
  FOS_FORCEFILESYSTEM         = $40;
  {$EXTERNALSYM FOS_ALLNONSTORAGEITEMS}
  FOS_ALLNONSTORAGEITEMS      = $80;
  {$EXTERNALSYM FOS_NOVALIDATE}
  FOS_NOVALIDATE              = $100;
  {$EXTERNALSYM FOS_ALLOWMULTISELECT}
  FOS_ALLOWMULTISELECT        = $200;
  {$EXTERNALSYM FOS_PATHMUSTEXIST}
  FOS_PATHMUSTEXIST           = $800;
  {$EXTERNALSYM FOS_FILEMUSTEXIST}
  FOS_FILEMUSTEXIST           = $1000;
  {$EXTERNALSYM FOS_CREATEPROMPT}
  FOS_CREATEPROMPT            = $2000;
  {$EXTERNALSYM FOS_SHAREAWARE}
  FOS_SHAREAWARE              = $4000;
  {$EXTERNALSYM FOS_NOREADONLYRETURN}
  FOS_NOREADONLYRETURN        = $8000;
  {$EXTERNALSYM FOS_NOTESTFILECREATE}
  FOS_NOTESTFILECREATE        = $10000;
  {$EXTERNALSYM FOS_HIDEMRUPLACES}
  FOS_HIDEMRUPLACES           = $20000;
  {$EXTERNALSYM FOS_HIDEPINNEDPLACES}
  FOS_HIDEPINNEDPLACES        = $40000;
  {$EXTERNALSYM FOS_NODEREFERENCELINKS}
  FOS_NODEREFERENCELINKS      = $100000;
  {$EXTERNALSYM FOS_DONTADDTORECENT}
  FOS_DONTADDTORECENT         = $2000000;
  {$EXTERNALSYM FOS_FORCESHOWHIDDEN}
  FOS_FORCESHOWHIDDEN         = $10000000;
  {$EXTERNALSYM FOS_DEFAULTNOMINIMODE}
  FOS_DEFAULTNOMINIMODE       = $20000000;
  {$EXTERNALSYM FOS_FORCEPREVIEWPANEON}
  FOS_FORCEPREVIEWPANEON      = $40000000;


type

{$IFNDEF DELPHI_UNICODE}
{$IFDEF COMPILER_9_UP}
{$HPPEMIT '#if !defined(NO_WIN32_LEAN_AND_MEAN)'}
{$ENDIF}
{$HPPEMIT 'struct _tagpropertykey;'}
{$HPPEMIT 'struct PROPERTYKEY;'}
{$HPPEMIT 'struct _COMDLG_FILTERSPEC;'}
{$HPPEMIT 'struct COMDLG_FILTERSPEC;'}
{$IFDEF COMPILER_9_UP}
{$HPPEMIT '#endif'}
{$ENDIF}
{$ENDIF}

  {$EXTERNALSYM _tagpropertykey}
  _tagpropertykey = packed record
    fmtid: TGUID;
    pid: DWORD;
  end;
  {$EXTERNALSYM PROPERTYKEY}
  PROPERTYKEY = _tagpropertykey;
  PPropertyKey = ^TPropertyKey;
  TPropertyKey = _tagpropertykey;

  {$EXTERNALSYM _COMDLG_FILTERSPEC}
  _COMDLG_FILTERSPEC = packed record
    pszName: LPCWSTR;
    pszSpec: LPCWSTR;
  end;
  {$EXTERNALSYM COMDLG_FILTERSPEC}
  COMDLG_FILTERSPEC = _COMDLG_FILTERSPEC;
  PComdlgFilterSpec = ^TComdlgFilterSpec;
  TComdlgFilterSpec = COMDLG_FILTERSPEC;

  { IModalWindow }

  {$EXTERNALSYM IModalWindow}
  {$HPPEMIT 'typedef System::DelphiInterface<IModalWindow> _di_IModalWindow;'}
  IModalWindow = interface(IUnknown)
    [SID_IModalWindow]
    function Show(hwndParent: HWND): HResult; stdcall;
  end;

  { IEnumShellItems }

  {$EXTERNALSYM IEnumShellItems}
  {$HPPEMIT 'typedef System::DelphiInterface<IEnumShellItems> _di_IEnumShellItems;'}
  IEnumShellItems = interface(IUnknown)
    [SID_IEnumShellItem]
    function Next(celt: ULONG; out rgelt; pceltFetched: PLongint): HResult; stdcall;
    function Skip(celt: ULONG): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumShellItems): HResult; stdcall;
  end;

  {$EXTERNALSYM IShellItem}
  {$HPPEMIT 'typedef System::DelphiInterface<IShellItem> _di_IShellItem;'}
  IShellItem = interface(IUnknown)
    [SID_IShellItem]
    function BindToHandler(const pbc: IBindCtx; const bhid: TGUID;
      const riid: TIID; out ppv): HResult; stdcall;
    function GetParent(var ppsi: IShellItem): HResult; stdcall;
    function GetDisplayName(sigdnName: DWORD; var ppszName: LPWSTR): HResult; stdcall;
    function GetAttributes(sfgaoMask: DWORD; var psfgaoAttribs: DWORD): HResult; stdcall;
    function Compare(const psi: IShellItem; hint: DWORD;
      var piOrder: Integer): HResult; stdcall;
  end;

  { IShellItemFilter }

  {$EXTERNALSYM IShellItemFilter}
  {$HPPEMIT 'typedef System::DelphiInterface<IShellItemFilter> _di_IShellItemFilter;'}
  IShellItemFilter = interface(IUnknown)
    [SID_IShellItemFilter]
    function IncludeItem(const psi: IShellItem): HResult; stdcall;
    function GetEnumFlagsForItem(const psi: IShellItem;
      var pgrfFlags: DWORD): HResult; stdcall;
  end;

  {$EXTERNALSYM IShellItemArray}
  {$HPPEMIT 'typedef System::DelphiInterface<IShellItemArray> _di_IShellItemArray;'}
  IShellItemArray = interface(IUnknown)
    [SID_IShellItemArray]
    function BindToHandler(const pbc: IBindCtx; const rbhid: TGUID;
      const riid: TIID; out ppvOut): HResult; stdcall;
    function GetPropertyStore(flags: DWORD; const riid: TIID; out ppv): HResult; stdcall;
    function GetPropertyDescriptionList(const keyType: TPropertyKey;
      const riid: TIID; out ppv): HResult; stdcall;
    function GetAttributes(dwAttribFlags: DWORD; sfgaoMask: DWORD;
      var psfgaoAttribs: DWORD): HResult; stdcall;
    function GetCount(var pdwNumItems: DWORD): HResult; stdcall;
    function GetItemAt(dwIndex: DWORD; var ppsi: IShellItem): HResult; stdcall;
    function EnumItems(var ppenumShellItems: IEnumShellItems): HResult; stdcall;
  end;

  {$HPPEMIT 'typedef System::DelphiInterface<IFileDialog> _di_IFileDialog;'}
  IFileDialog = interface;
  {$EXTERNALSYM IFileDialogCustomize}
  {$HPPEMIT 'typedef System::DelphiInterface<IFileDialogCustomize> _di_IFileDialogCustomize;'}
  IFileDialogCustomize = interface(IUnknown)
    [SID_IFileDialogCustomize]
    function EnableOpenDropDown(dwIDCtl: DWORD): HResult; stdcall;
    function AddMenu(dwIDCtl: DWORD; pszLabel: LPCWSTR): HResult; stdcall;
    function AddPushButton(dwIDCtl: DWORD; pszLabel: LPCWSTR): HResult; stdcall;
    function AddComboBox(dwIDCtl: DWORD): HResult; stdcall;
    function AddRadioButtonList(dwIDCtl: DWORD): HResult; stdcall;
    function AddCheckButton(dwIDCtl: DWORD; pszLabel: LPCWSTR; bChecked: BOOL): HResult; stdcall;
    function AddEditBox(dwIDCtl: DWORD; pszLabel: LPCWSTR): HResult; stdcall;
    function AddSeparator(dwIDCtl: DWORD): HResult; stdcall;
    function AddText(dwIDCtl: DWORD; pszText: LPCWSTR): HResult; stdcall;
    function SetControlLabel(dwIDCtl: DWORD; pszLabel: LPCWSTR): HResult; stdcall;
    function GetControlState(dwIDCtl: DWORD; out pdwState: DWORD): HResult; stdcall;
    function SetControlState(dwIDCtl: DWORD; dwState: DWORD): HResult; stdcall;
    function GetEditBoxText(dwIDCtl: DWORD; out ppszText: LPCWSTR): HResult; stdcall;
    function SetEditBoxText(dwIDCtl: DWORD; pszText: LPCWSTR): HResult; stdcall;
    function GetCheckButtonState(dwIDCtl: DWORD; out pbChecked: BOOL): HResult; stdcall;
    function SetCheckButtonState(dwIDCtl: DWORD; bChecked: BOOL): HResult; stdcall;
    function AddControlItem(dwIDCtl: DWORD; dwIDItem: DWORD; pszLabel: LPCWSTR): HResult; stdcall;
    function RemoveControlItem(dwIDCtl: DWORD; dwIDItem: DWORD): HResult; stdcall;
    function RemoveAllControlItems(dwIDCtl: DWORD): HResult; stdcall;
    function GetControlItemState(dwIDCtl: DWORD; dwIDItem: DWORD; out pdwState: DWORD): HResult; stdcall;
    function SetControlItemState(dwIDCtl: DWORD; dwIDItem: DWORD; dwState: DWORD): HResult; stdcall;
    function GetSelectedControlItem(dwIDCtl: DWORD; out pdwIDItem: DWORD): HResult; stdcall;
    function SetSelectedControlItem(dwIDCtl: DWORD; dwIDItem: DWORD): HResult; stdcall;
    function StartVisualGroup(dwIDCtl: DWORD; pszLabel: LPCWSTR): HResult; stdcall;
    function EndVisualGroup(): HResult; stdcall;
    function MakeProminent(dwIDCtl: DWORD): HResult; stdcall;
  end;

  {$EXTERNALSYM IFileDialogEvents}
  {$HPPEMIT 'typedef System::DelphiInterface<IFileDialogEvents> _di_IFileDialogEvents;'}
  IFileDialogEvents = interface(IUnknown)
    [SID_IFileDialogEvents]
    function OnFileOk(const pfd: IFileDialog): HResult; stdcall;
    function OnFolderChanging(const pfd: IFileDialog;
      const psiFolder: IShellItem): HResult; stdcall;
    function OnFolderChange(const pfd: IFileDialog): HResult; stdcall;
    function OnSelectionChange(const pfd: IFileDialog): HResult; stdcall;
    function OnShareViolation(const pfd: IFileDialog; const psi: IShellItem;
      out pResponse: DWORD): HResult; stdcall;
    function OnTypeChange(const pfd: IFileDialog): HResult; stdcall;
    function OnOverwrite(const pfd: IFileDialog; const psi: IShellItem;
      out pResponse: DWORD): HResult; stdcall;
  end;

  { IFileDialog }

  TComdlgFilterSpecArray = array of TComdlgFilterSpec;

  {$EXTERNALSYM IFileDialog}
  IFileDialog = interface(IModalWindow)
    [SID_IFileDialog]
    function SetFileTypes(cFileTypes: UINT; rgFilterSpec: TComdlgFilterSpecArray): HResult; stdcall;
    function SetFileTypeIndex(iFileType: UINT): HResult; stdcall;
    function GetFileTypeIndex(var piFileType: UINT): HResult; stdcall;
    function Advise(const pfde: IFileDialogEvents; var pdwCookie: DWORD): HResult; stdcall;
    function Unadvise(dwCookie: DWORD): HResult; stdcall;
    function SetOptions(fos: DWORD): HResult; stdcall;
    function GetOptions(var pfos: DWORD): HResult; stdcall;
    function SetDefaultFolder(const psi: IShellItem): HResult; stdcall;
    function SetFolder(const psi: IShellItem): HResult; stdcall;
    function GetFolder(var ppsi: IShellItem): HResult; stdcall;
    function GetCurrentSelection(var ppsi: IShellItem): HResult; stdcall;
    function SetFileName(pszName: LPCWSTR): HResult; stdcall;
    function GetFileName(var pszName: LPCWSTR): HResult; stdcall;
    function SetTitle(pszTitle: LPCWSTR): HResult; stdcall;
    function SetOkButtonLabel(pszText: LPCWSTR): HResult; stdcall;
    function SetFileNameLabel(pszLabel: LPCWSTR): HResult; stdcall;
    function GetResult(var ppsi: IShellItem): HResult; stdcall;
    function AddPlace(const psi: IShellItem; fdap: DWORD): HResult; stdcall;
    function SetDefaultExtension(pszDefaultExtension: LPCWSTR): HResult; stdcall;
    function Close(hr: HResult): HResult; stdcall;
    function SetClientGuid(const guid: TGUID): HResult; stdcall;
    function ClearClientData: HResult; stdcall;
    function SetFilter(const pFilter: IShellItemFilter): HResult; stdcall;
  end;

  {$EXTERNALSYM IPropertyStore}
  {$HPPEMIT 'typedef System::DelphiInterface<IPropertyStore> _di_IPropertyStore;'}
  IPropertyStore = interface(IUnknown)
    [SID_IPropertyStore]
    function GetCount(out cProps: DWORD): HResult; stdcall;
    function GetAt(iProp: DWORD; out pkey: TPropertyKey): HResult; stdcall;
    function GetValue(const key: TPropertyKey; out pv: TPropVariant): HResult; stdcall;
    function SetValue(const key: TPropertyKey; const propvar: TPropVariant): HResult; stdcall;
    function Commit: HResult; stdcall;
  end;

  {$EXTERNALSYM IPropertyDescriptionList}
  {$HPPEMIT 'typedef System::DelphiInterface<IPropertyDescriptionList> _di_IPropertyDescriptionList;'}
  IPropertyDescriptionList = interface(IUnknown)
    [SID_IPropertyDescriptionList]
    function GetCount(out pcElem: UINT): HResult; stdcall;
    function GetAt(iElem: UINT; const riid: TIID; out ppv): HResult; stdcall;
  end;

  {$EXTERNALSYM IFileOperationProgressSink}
  {$HPPEMIT 'typedef System::DelphiInterface<IFileOperationProgressSink> _di_IFileOperationProgressSink;'}
  IFileOperationProgressSink = interface(IUnknown)
    [SID_IFileOperationProgressSink]
    function StartOperations: HResult; stdcall;
    function FinishOperations(hrResult: HResult): HResult; stdcall;
    function PreRenameItem(dwFlags: DWORD; const psiItem: IShellItem;
      pszNewName: LPCWSTR): HResult; stdcall;
    function PostRenameItem(dwFlags: DWORD; const psiItem: IShellItem;
      pszNewName: LPCWSTR; hrRename: HResult; const psiNewlyCreated: IShellItem): HResult; stdcall;
    function PreMoveItem(dwFlags: DWORD; const psiItem: IShellItem;
      const psiDestinationFolder: IShellItem; pszNewName: LPCWSTR): HResult; stdcall;
    function PostMoveItem(dwFlags: DWORD; const psiItem: IShellItem;
      const psiDestinationFolder: IShellItem; pszNewName: LPCWSTR;
      hrMove: HResult; const psiNewlyCreated: IShellItem): HResult; stdcall;
    function PreCopyItem(dwFlags: DWORD; const psiItem: IShellItem;
      const psiDestinationFolder: IShellItem; pszNewName: LPCWSTR): HResult; stdcall;
    function PostCopyItem(dwFlags: DWORD; const psiItem: IShellItem;
      const psiDestinationFolder: IShellItem; pszNewName: LPCWSTR;
      hrCopy: HResult; const psiNewlyCreated: IShellItem): HResult; stdcall;
    function PreDeleteItem(dwFlags: DWORD; const psiItem: IShellItem): HResult; stdcall;
    function PostDeleteItem(dwFlags: DWORD; const psiItem: IShellItem; hrDelete: HResult;
      const psiNewlyCreated: IShellItem): HResult; stdcall;
    function PreNewItem(dwFlags: DWORD; const psiDestinationFolder: IShellItem;
      pszNewName: LPCWSTR): HResult; stdcall;
    function PostNewItem(dwFlags: DWORD; const psiDestinationFolder: IShellItem;
      pszNewName: LPCWSTR; pszTemplateName: LPCWSTR; dwFileAttributes: DWORD;
      hrNew: HResult; const psiNewItem: IShellItem): HResult; stdcall;
    function UpdateProgress(iWorkTotal: UINT; iWorkSoFar: UINT): HResult; stdcall;
    function ResetTimer: HResult; stdcall;
    function PauseTimer: HResult; stdcall;
    function ResumeTimer: HResult; stdcall;
  end;

  {$EXTERNALSYM IFileOpenDialog}
  {$HPPEMIT 'typedef System::DelphiInterface<IFileOpenDialog> _di_IFileOpenDialog;'}
  IFileOpenDialog = interface(IFileDialog)
    [SID_IFileOpenDialog]
    function GetResults(var ppenum: IShellItemArray): HResult; stdcall;
    function GetSelectedItems(var ppsai: IShellItemArray): HResult; stdcall;
  end;

  { IFileSaveDialog }

  {$EXTERNALSYM IFileSaveDialog}
  {$HPPEMIT 'typedef System::DelphiInterface<IFileSaveDialog> _di_IFileSaveDialog;'}
  IFileSaveDialog = interface(IFileDialog)
    [SID_IFileSaveDialog]
    function SetSaveAsItem(const psiIShellItem): HResult; stdcall;
    function SetProperties(const pStore: IPropertyStore): HResult; stdcall;
    function SetCollectedProperties(const pList: IPropertyDescriptionList;
      fAppendDefault: BOOL): HResult; stdcall;
    function GetProperties(out ppStore: IPropertyStore): HResult; stdcall;
    function ApplyProperties(const psi: IShellItem;
      const pStore: IPropertyStore; hwnd: HWND;
      const pSink: IFileOperationProgressSink): HResult; stdcall;
  end;

{ For IE >= IE70 }

{$EXTERNALSYM SHCreateItemFromParsingName}
function SHCreateItemFromParsingName(pszPath: LPCWSTR; const pbc: IBindCtx;
  const riid: TIID; out ppv): HResult;

implementation

const
{$IFDEF MSWINDOWS}
  shell32 = 'shell32.dll';
{$ENDIF}
{$IFDEF LINUX}
  shell32 = 'libshell32.borland.so';
{$ENDIF}

var
  Shell32Lib: HModule;

  _SHCreateItemFromParsingName: function(pszPath: LPCWSTR; const pbc: IBindCtx;
    const riid: TIID; out ppv): HResult; stdcall;

procedure InitShlObj; {inline;}
begin
  Shell32Lib := GetModuleHandle(shell32);
end;

function SHCreateItemFromParsingName(pszPath: LPCWSTR; const pbc: IBindCtx;
  const riid: TIID; out ppv): HResult;
begin
  if Assigned(_SHCreateItemFromParsingName) then
    Result := _SHCreateItemFromParsingName(pszPath, pbc, riid, ppv)
  else
  begin
    InitShlObj;
    Result := E_NOTIMPL;
    if Shell32Lib > 0 then
    begin
      _SHCreateItemFromParsingName := GetProcAddress(Shell32Lib, 'SHCreateItemFromParsingName'); // Do not localize
      if Assigned(_SHCreateItemFromParsingName) then
        Result := _SHCreateItemFromParsingName(pszPath, pbc, riid, ppv);
    end;
  end;
end;

end.





