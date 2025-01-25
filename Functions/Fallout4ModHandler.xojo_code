#tag Module
Protected Module Fallout4ModHandler
	#tag Method, Flags = &h0
		Sub ApplyDLCOrder()
		  Var modListBox As DesktopListBox= MainScreen.lsb_ModOrderList
		  Var enabledToFile As String
		  Var dlcItem As String
		  Var actualdlc() As Variant= App.dlcList.Keys
		  
		  For Each dlcName As Variant In actualdlc
		    dlcItem= dlcName.StringValue
		    If(dlcItem.BeginsWith("DLC")) Then
		      Utils.WriteFile(App.modsFile_DLC,_
		      dlcItem+EndOfLine,False)
		    End
		  Next
		  
		  For rowNum As Integer= 0 To modListBox.RowCount-1
		    If(modListBox.CellTextAt(rowNum,App.COL_ID)="-1") Then
		      Continue
		    Else
		      If(modListBox.CellTextAt(rowNum,App.COL_ENABLED)="Y") Then
		        enabledToFile= modListBox.CellTextAt(rowNum,App.COL_NAME)+ EndOfLine
		      Else
		        Continue
		      End
		      
		      Utils.WriteFile(App.modsFile_DLC,_
		      enabledToFile,False)
		    End
		  Next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ApplyPluginOrder()
		  Var modListBox As DesktopListBox= MainScreen.lsb_ModOrderList
		  Var enabledToFile As String
		  
		  Utils.WriteFile(App.modsFile_Plugins,_
		  "# This file is used by Fallout 4 to keep track of your downloaded content.",True)
		  Utils.WriteFile(App.modsFile_Plugins,_
		  "# Please do not modify this file." + EndOfLine,False)
		  
		  For rowNum As Integer= 0 To modListBox.RowCount-1
		    If(modListBox.CellTextAt(rowNum,App.COL_ID)="-1") Then
		      Continue
		    Else
		      If(modListBox.CellTextAt(rowNum,App.COL_ENABLED)="Y") Then
		        enabledToFile= "*"+ modListBox.CellTextAt(rowNum,App.COL_NAME)+ EndOfLine
		      Else
		        enabledToFile= modListBox.CellTextAt(rowNum,App.COL_NAME)+ EndOfLine
		      End
		      
		      Utils.WriteFile(App.modsFile_Plugins,_
		      enabledToFile,False)
		    End
		  Next
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ApplyUserDlContentOrder()
		  Var modListBox As DesktopListBox= MainScreen.lsb_ModOrderList
		  Var enabledToFile As String
		  Var dlcItem As String
		  
		  Utils.WriteFile(App.modsFile_UserDlContent,_
		  "# This file is used by Fallout 4 to keep track of your downloaded content.",True)
		  Utils.WriteFile(App.modsFile_UserDlContent,_
		  "# Please do not modify this file." + EndOfLine,False)
		  
		  Var actualdlc() As Variant= App.dlcList.Keys
		  
		  For Each dlcName As Variant In actualdlc
		    dlcItem= dlcName.StringValue
		    Utils.WriteFile(App.modsFile_UserDlContent,_
		    "*"+dlcItem+EndOfLine,False)
		  Next
		  
		  For rowNum As Integer= 0 To modListBox.RowCount-1
		    If(modListBox.CellTextAt(rowNum,App.COL_ID)="-1") Then
		      Continue
		    Else
		      If(modListBox.CellTextAt(rowNum,App.COL_ENABLED)="Y") Then
		        enabledToFile= "*"+ modListBox.CellTextAt(rowNum,App.COL_NAME)+ EndOfLine
		      Else
		        enabledToFile= modListBox.CellTextAt(rowNum,App.COL_NAME)+ EndOfLine
		      End
		      
		      Utils.WriteFile(App.modsFile_UserDlContent,_
		      enabledToFile,False)
		    End
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BatchInstallMods(zipModFolder as folderItem, modType as integer = 0)
		  Var installed As Boolean= False
		  Var installCount As Integer= 0
		  
		  For Each child As FolderItem In zipModFolder.Children
		    installed= False
		    
		    If(child.IsFolder Or child.IsAlias) Then
		      Continue
		    Else
		      installed= Fallout4ModHandler.InstallMod(child,True)
		      If(installed) Then
		        installCount= installCount+1
		      End
		    End
		    
		  Next
		  
		  Utils.GeneratePopup(1,"Batch install completed!",_
		  "Mods probably installed: " + installCount.ToString)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CheckForFomod(modToInstall as folderItem) As Boolean
		  Var isFomod As Boolean= False
		  Var tempTestDir As folderItem= Utils.CreateFolderStructure(SpecialFolder.UserHome,_
		  ".config/AlwaysOfflineSoftware/FO4LinuxModder/temp/")
		  
		  Var TestDir As String = """"+SpecialFolder.Resources.NativePath _
		  + "7zzs"" x % -o" + """"+tempTestDir.NativePath+""" -y"
		  
		  Utils.ShellCommand(TestDir.Replace("%",""""+modToInstall.NativePath+""""), False, False)
		  
		  For Each item As FolderItem In tempTestDir.Children
		    If(item.IsFolder And item.Name.Lowercase.Contains("fomod")) Then
		      isFomod= True
		      item.RemoveFolderAndContents
		      Continue
		    End
		    
		    If(item.IsFolder) Then
		      item.RemoveFolderAndContents
		      Continue
		    End
		    
		    item.Remove
		  Next
		  
		  If(isFomod) Then
		    Utils.GeneratePopup(3,"Fomod Detected!",_
		    "The installer doesn't support Fomods (yet). Please manually install this one")
		  End
		  
		  Return isFomod
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InstallMod(modToInstall as folderitem, batchmode as boolean = False, modType as integer = 0) As Boolean
		  Var itemArr() As String= modToInstall.Name.Split(".")
		  Var last As Integer= itemArr.LastIndex
		  Var isFomod As Boolean= CheckForFomod(modToInstall)
		  
		  // System.DebugLog(itemArr(last))
		  If(Not isFomod) Then
		    If(itemArr(last)="zip") Then
		      modToInstall.Unzip(App.falloutData)
		      Return True
		    ElseIf(itemArr(last)="7z") Then
		      // System.DebugLog(App.command7Zip.Replace("%",""""+modToInstall.NativePath+""""))
		      Utils.ShellCommand(App.command7Zip.Replace("%",""""+modToInstall.NativePath+""""), False, False)
		      Return True
		    ElseIf(itemArr(last)="rar") Then
		      // System.DebugLog(App.command7Zip.Replace("%",""""+modToInstall.NativePath+""""))
		      Utils.ShellCommand(App.command7Zip.Replace("%",""""+modToInstall.NativePath+""""), False, False)
		      Return True
		    Else
		      
		      If(Not batchmode) Then
		        Utils.GeneratePopup(3,"Unsupported archive format",_
		        "Please extract manually and archive as a zip file")
		      End
		      
		    End
		  End
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReloadMods()
		  //Enabled    ID    Mod Name    Load Order
		  MainScreen.lsb_ModOrderList.RemoveAllRows
		  App.manualItemList= Utils.ReadFile(App.modsFile_Plugins).Split(EndOfLine)
		  
		  Var modID As String
		  Var tempName As String
		  Var loadedOrder As Integer= 0
		  Var scannedNames() As String
		  Var addedNames() As String
		  Var newNames() As String
		  Var matched As Boolean= False
		  
		  MainScreen.lsb_ModOrderList.AddRowAt(App.COL_ENABLED,"Y")
		  MainScreen.lsb_ModOrderList.CellTextAt(0, App.COL_ID)= "-1"
		  MainScreen.lsb_ModOrderList.CellTextAt(0, App.COL_NAME)= "base game files..."
		  MainScreen.lsb_ModOrderList.CellTextAt(0, App.COL_ORDER)= "-1"
		  
		  scannedNames= ScanDataFolder
		  
		  For Each modline As String In App.manualItemList
		    // System.DebugLog(modline.Replace("*",""))
		    If(modline.Left(1)<>"#" And modline.Left(1)<>""_
		       And App.dlcList.Lookup(modline.Replace("*",""),True)) Then
		      // System.DebugLog(modline.Trim + "= " + modline.Trim.Replace(modline.Left(1),""))
		      tempName= modline.Trim.Replace("*","").Replace(".esp","").Replace(".esl","").Replace(".esm","")
		      modID= tempName.Left(2).Lowercase + tempName.Right(2).Lowercase +_
		      tempName.Length.ToString
		      If(modline.Left(1)="*") Then
		        MainScreen.lsb_ModOrderList.AddRow("Y",modID,_
		        modline.Trim.Replace("*",""),loadedOrder.ToString)
		        addedNames.add(modline.Trim.Replace("*",""))
		      Else
		        MainScreen.lsb_ModOrderList.AddRow(" ",modID,_
		        modline.Trim,loadedOrder.ToString)
		        addedNames.add(modline.Trim)
		      End
		      loadedOrder= loadedOrder+1
		    End
		    
		  Next
		  
		  For i As Integer=0 To scannedNames.count-1
		    For k As Integer=0 To addedNames.count-1
		      If(scannedNames(i)= addedNames(k)) Then
		        matched= True
		        Exit
		      End
		    Next
		    If(Not Matched) Then
		      newNames.Add(scannedNames(i))
		    End
		    matched= False
		  Next
		  
		  If(newNames.count>0) Then
		    For v As Integer=0 To newNames.count-1
		      tempName= newNames(v).Trim.Replace("*","").Replace(".esp","").Replace(".esl","").Replace(".esm","")
		      modID= tempName.Left(2).Lowercase + tempName.Right(2).Lowercase +_
		      tempName.Length.ToString
		      
		      MainScreen.lsb_ModOrderList.AddRow(" ",modID,_
		      newNames(v).Trim,loadedOrder.ToString)
		      loadedOrder= loadedOrder+1
		    Next
		  End
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ScanDataFolder() As String()
		  Var espNames() As String
		  
		  For Each item As folderitem In App.falloutData.Children
		    If(Not item.IsFolder) Then
		      If(item.Name.Contains(".esp")) Then
		        espNames.Add(item.Name)
		      End
		    End
		  Next
		  
		  return espNames
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Startup()
		  // ~/.local/share/Steam/steamapps/compatdata/377160/pfx/drive_c/users/steamuser/AppData/Local/Fallout4
		  
		  App.configsFolder= Utils.CreateFolderStructure(SpecialFolder.UserHome,_
		  ".config/AlwaysOfflineSoftware/FO4LinuxModder/")
		  App.savedSettings= App.configsFolder.child("settings.ini")
		  App.dependsFile= App.configsFolder.child("dependancies.ini")
		  App.modIDMap= New Dictionary
		  
		  If(App.savedSettings.Exists) Then
		    Var rawSettings As String= Utils.ReadFile(App.savedSettings)
		    If(rawSettings.Trim<> "") Then
		      SharedModTools.LoadSettings(rawSettings)
		    End
		  Else
		    Utils.WriteFile(App.savedSettings,"", True)
		    
		    If( Utils.ValidatePath(SpecialFolder.UserHome.NativePath+ _
		      ".local/share/Steam/steamapps/compatdata/377160/pfx/drive_c/users/steamuser/AppData/Local/Fallout4") And _
		      Utils.ValidatePath(SpecialFolder.UserHome.NativePath+ _
		      ".local/share/Steam/steamapps/common/Fallout 4/Data")) Then
		      
		      App.BaseDir= SpecialFolder.UserHome.child(".local").child("share").child("Steam")_
		      .child("steamapps").child("compatdata").child("377160").child("pfx").child("drive_c")_
		      .child("users").child("steamuser").child("AppData").child("Local").child("Fallout4")
		      
		      // ~/.local/share/Steam/steamapps/common/Fallout 4/Data
		      App.falloutData= SpecialFolder.UserHome.child(".local").child("share").child("Steam")_
		      .child("steamapps").child("common").child("Fallout 4").child("Data")
		    Else
		      App.BaseDir= Nil
		      App.falloutData= Nil
		      App.launchCommand= ""
		    End
		  End
		  
		  If(App.BaseDir<> Nil And App.falloutData<> Nil) Then
		    App.command7Zip= """"+SpecialFolder.Resources.NativePath _
		    + "7zzs"" x % -o" + """"+App.falloutData.NativePath+""" -y"
		    
		    App.modsFile_Plugins= App.BaseDir.child("Plugins.txt")
		    App.modsFile_UserDlContent= App.BaseDir.child("UserDownloadedContent.txt")
		    App.modsFile_DLC= App.BaseDir.child("DLCList.txt")
		    
		    If(App.modsFile_Plugins=Nil) Then
		      Utils.WriteFile(App.modsFile_Plugins,_
		      "# This file is used by Fallout4 to keep track of your downloaded content.",False)
		      Utils.WriteFile(App.modsFile_Plugins,_
		      "# Please do not modify this file." + EndOfLine,False)
		    End
		    
		    If(App.modsFile_UserDlContent=Nil) Then
		      Utils.WriteFile(App.modsFile_UserDlContent,_
		      "# This file is used by Fallout4 to keep track of your downloaded content.",False)
		      Utils.WriteFile(App.modsFile_UserDlContent,_
		      "# Please do not modify this file." + EndOfLine,False)
		    End
		    
		    If(App.modsFile_DLC=Nil) Then
		      Utils.WriteFile(App.modsFile_DLC,"",False)
		    End
		    
		    If(utils.ValidatePath(App.falloutData.NativePath + "/F4SE/Plugins")) Then
		      App.f4seFolder= App.falloutData.child("F4SE")
		    Else
		      Call Utils.CreateFolderStructure(App.falloutData,"F4SE/Plugins/")
		      App.f4seFolder= App.falloutData.child("F4SE")
		    End
		    
		    SharedModTools.BackupOriginal
		    SharedModTools.SaveSettings
		    MainScreen.Show
		    OpeningScreen.Close
		  Else
		    App.setupNotAutomatic= True
		    Utils.GeneratePopup(1,"Steam Directory was not detected",_
		    "Please point to all the relevant directories")
		  End
		  
		  Exception err As RuntimeException
		    Utils.GeneratePopup(3,"Something went wrong!",err.message + " (Probably the dev's fault)")
		    Return
		    
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
