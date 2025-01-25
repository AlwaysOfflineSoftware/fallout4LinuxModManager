#tag Class
Protected Class App
Inherits DesktopApplication
	#tag Event
		Sub Opening()
		  App.dlcList= New Dictionary
		  App.dlcList.Value("DLCRobot.esm")=False
		  App.dlcList.Value("DLCworkshop01.esm")=False
		  App.dlcList.Value("DLCCoast.esm")=False
		  App.dlcList.Value("DLCworkshop02.esm")=False
		  App.dlcList.Value("DLCworkshop03.esm")=False
		  App.dlcList.Value("DLCNukaWorld.esm")=False
		  App.dlcList.Value("ccBGSFO4044-HellfirePowerArmor.esl")=False
		  App.dlcList.Value("ccBGSFO4115-X02.esl")=False
		  App.dlcList.Value("ccBGSFO4116-HeavyFlamer.esl")=False
		  App.dlcList.Value("ccBGSFO4110-WS_Enclave.esl")=False
		  App.dlcList.Value("ccBGSFO4096-AS_Enclave.esl")=False
		  App.dlcList.Value("ccFSVFO4007-Halloween.esl")=True
		  App.dlcList.Value("ccBGSFO4046-TesCan.esl")=False
		  App.dlcList.Value("ccSBJFO4003-Grenade.esl")=False
		  App.dlcList.Value("ccOTMFO4001-Remnants.esl")=False
		  // FomodHandler.RunFomod(_
		  // "/home/hopelessdecoy/Projects/Xojo/DesktopApps/fo4LinuxModManager/Assets/ModuleConfig2.xml")
		  Fallout4ModHandler.Startup
		End Sub
	#tag EndEvent


	#tag Property, Flags = &h0
		BaseDir As folderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		command7Zip As String
	#tag EndProperty

	#tag Property, Flags = &h0
		configsFolder As Folderitem
	#tag EndProperty

	#tag Property, Flags = &h0
		dependsFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		dependsMap As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		dlcList As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		enabledModsFile As Folderitem
	#tag EndProperty

	#tag Property, Flags = &h0
		f4seFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		falloutData As folderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		launchCommand As String
	#tag EndProperty

	#tag Property, Flags = &h0
		manualItemList() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		modIDMap As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		modsFile_DLC As Folderitem
	#tag EndProperty

	#tag Property, Flags = &h0
		modsFile_Plugins As Folderitem
	#tag EndProperty

	#tag Property, Flags = &h0
		modsFile_UserDlContent As Folderitem
	#tag EndProperty

	#tag Property, Flags = &h0
		savedSettings As Folderitem
	#tag EndProperty

	#tag Property, Flags = &h0
		setupNotAutomatic As Boolean = False
	#tag EndProperty


	#tag Constant, Name = COL_DEPENDS, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = COL_ENABLED, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = COL_ID, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = COL_NAME, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = COL_ORDER, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoQuit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowHiDPI"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BugVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Copyright"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastWindowIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MajorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NonReleaseVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RegionCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StageCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Version"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_CurrentEventTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="command7Zip"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="setupNotAutomatic"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="launchCommand"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
