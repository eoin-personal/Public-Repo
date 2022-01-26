
fn Padnum _numString _PadVal =
(
	formattedPrint _NumString format:("." + (_Padval as string) + "d")
)

GLOBAL _MFTakeUp

_RendOutputFlag = false

_TestRendOutput = queryBox "Do you want to update Render Output to new take?" title:"Update Render Output?"   

if _TestRendOutput == true do 
(
    _RendOutputFlag = true
)
--------- Take Up FileName ---------


_MFN = maxFileName
_MFP = maxFilePath

_MFN_List = (filterstring (_MFN) "_")
_TakeOriginalExtension = (_MFN_List[_MFN_List.count])
_TakeOriginal = (FilterString (_TakeOriginalExtension) ".")[1]


_TakeNum = (substring _TakeOriginal 2 3) as integer

_TakeNum += 1
_NewTakeNum = "t" + (padnum _TakeNum 3)



_MFTakeUp = ""

if (_MFN_List.count) == 6 then
(
	_MFTakeUp = _MFN_List[1] + "_" + _MFN_List[2] + "_" + _MFN_List[3] + "_" + _MFN_List[4] + "_" + _MFN_List[5] + "_" + _NewTakeNum + ".max"
)
else
(
	_MFTakeUp = _MFN_List[1] + "_" + _MFN_List[2] + "_" + _MFN_List[3] + "_" + _MFN_List[4] + "_" + _MFN_List[5] + "_" + _MFN_List[6] + "_" + _NewTakeNum + ".max"
)



DestFileVer = (maxfilepath + _MFTakeUp)


--------- Set R Output ---------

vr=renderers.current
renderSceneDialog.close()
_OgOutput = vr.output_rawFileName
_OgOutputSplit = (filterstring (_OgOutput) "\\")

_UpdateVerTakeLst = (filterstring _OgOutputSplit[8] "_")

if (_MFN_List.count) == 6 then
(
	_UpdatedVerTake =  _MFN_List[5] + "_" + _NewTakeNum
)
else
(
	_UpdatedVerTake =  _MFN_List[6] + "_" + _NewTakeNum
)

_NewPath = _OgOutputSplit[1] + "\\" + _OgOutputSplit[2] + "\\" + _OgOutputSplit[3] + "\\" + _OgOutputSplit[4] + "\\" + _OgOutputSplit[5] + "\\" + _OgOutputSplit[6] + "\\" + _OgOutputSplit[7] + "\\" + _UpdatedVerTake + "\\"


_NewOutput = _NewPath + _MFTakeUp

if _RendOutputFlag == true do
(
    vr.output_rawFileName = _NewOutput
)

makeDir _NewPath

--renderSceneDialog.open()
--------------------------------

savemaxfile DestFileVer