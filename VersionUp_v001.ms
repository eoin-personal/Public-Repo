
fn Padnum _numString _PadVal =
(
	formattedPrint _NumString format:("." + (_Padval as string) + "d")
)

--------- Version Up FileName ---------

GLOBAL _MFVerUp

_MFN = maxFileName
_MFP = maxFilePath

_MFN_List = (filterstring (_MFN) "_")
_VersionOriginal = (_MFN_List[_MFN_List.count - 1])

_VerNum = (substring _VersionOriginal 2 3) as integer

_VerNum += 1
_NewVerNum = "v" + (padnum _VerNum 3)


_MFVerUp = ""

if (_MFN_List.count) == 6 then
(
	_MFVerUp = _MFN_List[1] + "_" + _MFN_List[2] + "_" + _MFN_List[3] + "_" + _MFN_List[4] + "_" + _NewVerNum + "_" + "t001.max"
)
else
(
	_MFVerUp = _MFN_List[1] + "_" + _MFN_List[2] + "_" + _MFN_List[3] + "_" + _MFN_List[4] + "_" + _MFN_List[5] + "_" + _NewVerNum + "_" + "t001.max"
)



DestFileVer = (maxfilepath + _MFVerUp)


--------- Set R Output ---------

vr=renderers.current
renderSceneDialog.close()
_OgOutput = vr.output_rawFileName
_OgOutputSplit = (filterstring (_OgOutput) "\\")

_NewPath = _OgOutputSplit[1] + "\\" + _OgOutputSplit[2] + "\\" + _OgOutputSplit[3] + "\\" + _OgOutputSplit[4] + "\\" + _OgOutputSplit[5] + "\\" + _OgOutputSplit[6] + "\\" + _OgOutputSplit[7] + "\\" + _NewVerNum + "_t001" + "\\"
_NewOutput = _NewPath + _MFVerUp
vr.output_rawFileName = _NewOutput

makeDir _NewPath

--renderSceneDialog.open()
--------------------------------

savemaxfile DestFileVer