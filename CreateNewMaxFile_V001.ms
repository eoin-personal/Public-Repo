
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------


------- Vray Init ---------

mainVray = "V_Ray_Next__update_3_2"
for r in 1 to (rendererClass.classes).count where matchPattern ((rendererClass.classes)[r] as string) pattern:mainVray do Renderers.Production = RendererClass.Classes[r]()
vr=renderers.current
renderSceneDialog.close()
vr.imageSampler_type = 1	

------- INPUTS ---------

Drive = "L:/"
DriveLetterAbr = Drive[1]
_JobName = "JobName"
_JobID = "Date_Jobcode_" + _JobName
_Project = Drive + _JobID  --  needed for now or script crashes
_Seq = "000"
_Shot = "000"
_VerTakeRen = "v001_t001"
_Format = "169"
_Dept = "ANIMATION"
animStart = 000
animEnd = 600

FS_Shot = #() --Folder Structure Array
FS_Ren = #()

FormatList = #("16:9", "360")



GLOBAL CurProjMain
GLOBAL CurRenProj
GLOBAL SEQSHOT
GLOBAL RenSeqSht
GLOBAL Short_ProjList
GLOBAL DeptListDefined
GLOBAL FS_SHOT
GLOBAL FS_REN
GLOBAL MoGSeqSht
GLOBAL Drive
GLOBAL PrjSeqSht 
GLOBAL animStart
GLOBAL animEnd

/*
GLOBAL JobNameSolo		--	might need these for later script
GLOBAL JobCodeSolo
GLOBAL JobDateSolo
*/

Instructions1 = "1) Select Drive Letter and press Search"
Instructions2 = "2) Set Department"
Instructions3 = "3) Select Project"
Instructions4 = "4) Set Sequence and Shot if needed"
Instructions5 = "5) Set Pass Name if needed - will be ignored if left as unnamed"
Instructions6 = "6) Set Frame Start and Duration if needed"
Instructions7 = "7) Select 16:9 or 360"
Instructions8 = "8) Left click button to create a scene"
Instructions9 = "9) Right click button to create asset"
----------------------------------------
------- ## DEFINE FUNCTIONS ## ---------
----------------------------------------

------- Directory Gen Function ---------

fn CreateFolderStructure _Project _Seq _Shot _Format = 
(
	ProjectName = _Project
	SEQ = _Seq
	SHOT = _Shot
    ShotType = _Format

    CurProjMain = ProjectName + "/" + "01-Projects/3D"
    CurRenProj = ProjectName + "/" + "02-Renders/3D"
	MoGraphRen = ProjectName + "/" + "02-Renders/2D"

	if ShotType == "169" then
	(
		SEQSHOT = "Sc" + SEQ + "_" + "Sh" + SHOT
	)
	if ShotType == "360" then
	(
		SEQSHOT = "Sc" + SEQ
	)

	PrjSeqSht = CurProjMain + "/SCENES/" + SEQSHOT
	RenSeqSht = CurRenProj + "/SCENES/" + SEQSHOT
	MoGSeqSht = MoGraphRen + "/" + SEQSHOT


		--- ## PROJECT ## ---
	append FS_Shot (PrjSeqSht)
	append FS_Shot (PrjSeqSht + "/ENVIRONMENT")
	append FS_Shot (PrjSeqSht + "/MODELS")
	append FS_Shot (PrjSeqSht + "/ANIMATION")
	append FS_Shot (PrjSeqSht + "/FX")
	append FS_Shot (PrjSeqSht + "/_CACHES")
	append FS_Shot (PrjSeqSht + "/CAMERA")
	--append FS_Shot (CurProjMain + "/ASSETS")

		--- ## RENDERS ## ---
	append FS_Ren (RenSeqSht)
	append FS_Ren (RenSeqSht + "/ENVIRONMENT")
	append FS_Ren (RenSeqSht + "/MODELS")
	append FS_Ren (RenSeqSht + "/ANIMATION")
	append FS_Ren (RenSeqSht + "/FX")
	append FS_Ren (RenSeqSht + "/MATTES")
	append FS_Ren (RenSeqSht + "/TESTS")
	
	CacheRemove = "_CACHES"

	DeptListLong = #()
	DeptListDefined = #("--")
	Departments = #()
	
	for i = 1 to FS_Shot.count do
	(
		DeptListLong[i] =  (filterstring (FS_Shot[i]) "/")[7]
		for n = 1 to DeptListLong.count do
		(
			if DeptListLong[n] != undefined and DeptListLong[n] != CacheRemove do
			(
				appendIfUnique  DeptListDefined (DeptListLong[n])
			)
		)
	)
)


fn CreateFolderStructureAsset _Project = 
(
	ProjectName = _Project

    CurProjMain = ProjectName + "/" + "01-Projects/3D/ASSETS"
    CurRenProj = ProjectName + "/" + "02-Renders/3D/ASSETS"
	MoGraphRen = ProjectName + "/" + "02-Renders/2D/ASSETS"

	
	PrjSeqSht = CurProjMain
	RenSeqSht = CurRenProj
	MoGSeqSht = MoGraphRen


		--- ## PROJECT ## ---
	append FS_Shot (PrjSeqSht)
	append FS_Shot (PrjSeqSht + "/ENVIRONMENT")
	append FS_Shot (PrjSeqSht + "/MODELS")
	append FS_Shot (PrjSeqSht + "/ANIMATION")
	append FS_Shot (PrjSeqSht + "/CHARACTERS")
	append FS_Shot (PrjSeqSht + "/FX")


	--- ## RENDERS ## ---
	append FS_Ren (RenSeqSht)
	append FS_Ren (RenSeqSht + "/ENVIRONMENT")
	append FS_Ren (RenSeqSht + "/MODELS")
	append FS_Ren (RenSeqSht + "/ANIMATION")
	append FS_Ren (RenSeqSht + "/FX")
	append FS_Ren (RenSeqSht + "/MATTES")
	append FS_Ren (RenSeqSht + "/TESTS")


)



fn MaxSaveMakeDir FS_Shot FS_Ren MoGSeqSht = 
(
	for n = 1 to FS_Shot.count do
	(
		makeDir(FS_Shot[n])
	)



	for n = 1 to FS_Ren.count do
	(
		makeDir(FS_Ren[n])
		makeDir(MoGSeqSht)
	)

)

------- Max Render Settings Function ---------
fn MaxRenSettings RenSeqSht _Dept _Format _DeptPass _TypeFlag =
(					
	vr.system_region_sequence = 3				-- set to spiral
	vr.system_region_sequence_reverse = 1		-- reverse spiral
	
	if _TypeFlag == 1 do
	(
		RenOutput = RenSeqSht + "/" + _Dept + "/" + _VerTakeRen + "/" + _JobName + "_" + SEQSHOT + "_" + _DeptPass + "_" + _VerTakeRen + ".exr"
	)
	
	if _TypeFlag == 2 do
	(
		RenOutput = RenSeqSht + "/" + _Dept + "/" + _JobName + "_" + SEQSHOT + "_" + _DeptPass + "_" + _VerTakeRen + ".exr"
	)
		
	vr.output_saveRawFile = 1
	vr.output_rawFileName = RenOutput

	RenSize = _Format
	if RenSize == "169" then
	(		
		renderWidth=1920
		renderHeight=1080
		vr.camera_type = 0
		vr.camera_overrideFOV = 0
		vr.twoLevel_bucket_width = 24
		vr.twoLevel_bucket_height = 24
		vr.twoLevel_bucket_lockSize = 1
	)

	if RenSize == "360" then 
	(
		renderWidth=3840
		renderHeight=2160
		vr.camera_type = 1						-- set to spherical
		vr.camera_overrideFOV = 1
		vr.camera_fov = 360
		vr.twoLevel_bucket_width = 48
		vr.twoLevel_bucket_height = 48
		vr.twoLevel_bucket_lockSize = 1
	)

)

------- Max Main Settings Function ---------
fn MaxMainSettings _Format _FStart _FEnd =
(	
	units.SystemType = #Centimeters
	if _Format == "169" then
	(
		framerate = 25
	)
	if _Format == "360" then 
	(
		framerate = 30
	)

	if HDRI_Light != undefined then
	(
		HDRI_Light = vraylight name:"Main_HDRI" type:1 invisible:true multiplier:1
	)
	GLOBAL animStart = _FStart as integer
	GLOBAL animEnd = _FEnd as integer
	animationrange = (interval animStart animEnd)
)

	
------- Max File Save Function ---------
fn MaxSaveFile _Project SEQSHOT _Dept _DeptPass = 
(
	PrjSeqSht = CurProjMain + "/" + SEQSHOT
	RenSeqSht = CurRenProj + "/" + SEQSHOT

	MaxFileToSave = _JobName + "_" + SEQSHOT + "_" + _DeptPass + "_" + "v001_t001" + ".max"

	MaxFTSDir = CurProjMain + "/SCENES/" + SEQSHOT + "/" + _Dept + "/" + MaxFileToSave

	if doesFileExist MaxFTSDir == false then
	(
		saveMaxFile MaxFTSDir
	)
	else messageBox "File Already Exists"
	
)

fn MaxSaveFileAsset _Project _Dept _DeptPass = 
(
	PrjSeqSht = CurProjMain + "/"
	RenSeqSht = CurRenProj + "/"

	MaxFileToSave = _JobName + "_" + _DeptPass + "_" + "v001_t001" + ".max"

	MaxFTSDir = CurProjMain + "/" + _Dept + "/" + MaxFileToSave
	
	if doesFileExist MaxFTSDir == false then
	(
		saveMaxFile MaxFTSDir
	)
	else messageBox "File Already Exists"
	

)

------- Ren Passes Function ---------
fn RenElemGen _renlist =
(
	r = maxOps.GetCurRenderElementMgr()		--	sets Vray to r so that it can be called later in script
	r.removeallrenderelements()

	if _renlist == 1 then 
	(
	_renList = #(VrayDiffuseFilter, VrayDenoiser, VrayCryptomatte, VRayNormals, VrayReflection, VrayRefraction, VrayZdepth, VrayShadows, VRayVelocity, VraySpecular, MultiMatteElement, MultiMatteElement) -- AO too
	)
	--_renList = Main_CG	--	remove this line if more options available for _renList

	for i in _renList do
	(
		r.addRenderElement (i elementname: (i as string))
	)

	n = 0
	for i = 1 to (r.numRenderelements()) do
		(
			if (classof (r.GetRenderElement i)) == MultiMatteElement then
				(
					mm = (r.getrenderelement i)
					mm.ElementName = "MultiMatte_" + ((n + 1) as string)
					mm.MatID = true
					mm.R_gbufID = 1 + (n * 3)
					mm.G_gbufID = 2 + (n * 3)
					mm.B_gbufID = 3 + (n * 3)
					n += 1
				)
			
			if (classof (r.GetRenderElement i)) == VrayZdepth then
				(
					rz = (r.getrenderelement i)
					rz.zdepth_min=0
					rz.zdepth_max=1000
				)
				
			if (classof (r.GetRenderElement i)) == VrayCryptomatte then
				(
					Crypt = (r.getrenderelement i)
					Crypt.id_type=4				--	4 = Layer name
				)
	)
)




fn ReadProjects _Proj = -- Insert number item of project
(
	ABS_ProjList = GetDirectories (Drive + "/*.")
	Short_ProjList = #()
	for i = 1 to ABS_ProjList.count do
	(
		Short_ProjList[i] = (filterstring (ABS_ProjList[i]) "\\")[2]
	)

)


fn RefreshProjects _Drive = -- Insert number item of project
(
	ABS_ProjList = GetDirectories (_Drive + "/*.")
	Short_ProjList = #()
	for i = 1 to ABS_ProjList.count do
	(
		Short_ProjList[i] = (filterstring (ABS_ProjList[i]) "\\")[2]
	)

)

----------------------------------------
------- ## Pre Flight Check ## ---------
----------------------------------------

CreateFolderStructure _Project _Seq _Shot _Format

ReadProjects 1

EmptyFlag = true	




try(destroyDialog _GUI)catch()
Rollout _GUI "Create New Shot"
(
	edittext _DriveLetter "(1) Drive Letter:" text:DriveLetterAbr width:150 pos:[10,10]
	button _DriveSelect "(1) Search" width:150 height:20 pos:[10,30]
	listbox _Proj "(3) PROJECT:" items:Short_ProjList width:200 height:16 pos:[10,55]
	edittext _SeqNum "(4) Sequence Number:" text:"-" width:150 pos:[230,60]
	edittext _ShotNum "(4) Shot Number:" text:"-" width:150 pos:[230,80]
	dropdownlist _departmentList "(2) DEPARTMENT:" items:DeptListDefined width:100 pos:[230,10]
	edittext _Passname "(5) Pass Name:" text:"unnamed" width:150 pos:[400,10]
	edittext _FrameStart "(6) FRAME_START:" TEXT:(animStart as string) width:150 pos:[400,30]
	edittext _FrameEnd "(6) FRAME_END:" TEXT:(animEnd as string) width:150 pos:[400,50]
	button _execute "LMB - Create Scene\n RMB - Create Asset" toolTip:"Must have selected, in order:\n(1) Drive\n(2) Department\n(3) Project" width:120 height:80 pos:[470,135]	enabled:false
	radiobuttons _formatList labels:#("16:9","360") width:100 pos:[400,70]
	LABEL _Label_Title0 "** Please only use Dashes (-) and not Underscores or Spaces in Pass Name **" pos:[230,110]
	LABEL _Label_Title1 Instructions1 pos:[230,160]
	LABEL _Label_Title2 Instructions2 pos:[230,175]
	LABEL _Label_Title3 Instructions3 pos:[230,190]
	LABEL _Label_Title4 Instructions4 pos:[230,205]
	LABEL _Label_Title5 Instructions5 pos:[230,220]
	LABEL _Label_Title6 Instructions6 pos:[230,235]
	LABEL _Label_Title7 Instructions7 pos:[230,250]
	LABEL _Label_Title8 Instructions8 pos:[230,265]
	LABEL _Label_Title9 Instructions9 pos:[230,280]

	
	

	on _DriveSelect pressed do			--	Refresh the folder list on new drive input
	(
		driveLetter = _DriveLetter.text
		DrivePath = driveLetter + ":"
		UpperDrivePath = toUpper DrivePath
		RefreshProjects UpperDrivePath
		_Proj.items = Short_ProjList
		Drive = UpperDrivePath + "/"
	)
	

	on _Proj selected itm do
	(
		_Project = Drive + _proj.selected		
		_JobID = _proj.selected
		_Dept = _departmentList.selected
		if _Dept != "--" do
		(
			_execute.enabled = true
		)
	)
	

	on _execute pressed do
	(		
		renderSceneDialog.close()
		_Dept = _departmentList.selected
		SEQ = _SeqNum.text
		SHOT = _ShotNum.text	
		_Seq = SEQ
		_Shot = SHOT
		_FStart = _FrameStart.text
		_FEnd = _FrameEnd.text		
		_JobID = _proj.selected
		_JobNameLong = (filterstring (_JobID) "_")
		_JobName = (_JobNameLong[_JobNameLong.count])		
		SEQSHOT = "Sc" + SEQ + "_" + "Sh" + SHOT
		_DeptPass = _Dept
		
		isPassFilled = _Passname.text

		if isPassFilled != "unnamed" do
		(
			_DeptPass = _Dept + "_" + _Passname.text
		)

		FormatSelection = _formatList.state		
		if FormatSelection == 1 then 
		(
			_Format = "169"
		)
		else if FormatSelection == 2 then 
		(
			_Format = "360"
		)
		
		if SEQ == "-" or SHOT == "-" do
		(
			EmptyFlag = false
		)
		
		if EmptyFlag == true then
		(			
			CreateFolderStructure _Project SEQ SHOT _Format
			
			MaxSaveMakeDir FS_Shot FS_Ren MoGSeqSht
			MaxRenSettings RenSeqSht _Dept _Format _DeptPass 1
			MaxMainSettings _Format _FStart _FEnd
			RenElemGen 1
			MaxSaveFile _Project SEQSHOT _Dept _DeptPass

			VerTakeFolder = CurRenProj + "/SCENES/" + SEQSHOT + "/" + _Dept + "/" + _VerTakeRen 
			
			if doesfileexist VerTakeFolder == false then
			(
				makeDir VerTakeFolder
			)
			else
			(
				messagebox "NOTE: A render folder already exists for this Department for this Sequence and Shot"
			)

			try(destroyDialog _GUI)catch()
			gc()
		)
		else
		(
			messageBox "Please Enter a Sequence and Shot"
		)
		
		renderSceneDialog.open()

		
	)
	
	on _execute rightclick do
	(		
		renderSceneDialog.close()
		_Dept = _departmentList.selected
		_FStart = _FrameStart.text
		_FEnd = _FrameEnd.text		
		_JobID = _proj.selected
		_JobNameLong = (filterstring (_JobID) "_")
		_JobName = (_JobNameLong[_JobNameLong.count])		
		_DeptPass = _Dept + "_" + _Passname.text
		
		FormatSelection = _formatList.state		
		if FormatSelection == 1 then 
		(
			_Format = "169"
		)
		else if FormatSelection == 2 then 
		(
			_Format = "360"
		)
		
		CreateFolderStructureAsset _Project	
		MaxSaveMakeDir FS_Shot FS_Ren MoGSeqSht
		MaxRenSettings RenSeqSht _Dept _Format _DeptPass 2
		MaxMainSettings _Format _FStart _FEnd
		MaxSaveFileAsset _Project  _Dept _DeptPass
		RenElemGen 1

		try(destroyDialog _GUI)catch()
		gc()
		
		renderSceneDialog.open()
	)
)
CreateDialog _GUI width:620 height:300