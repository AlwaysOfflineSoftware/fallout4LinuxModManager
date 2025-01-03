#tag Module
Protected Module F4SEHandler
	#tag Method, Flags = &h21
		Private Sub ClearPluginList()
		  F4SEScreen.lsb_Plugins.RemoveAllRows
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InstallF4SE(f4seArchive as FolderItem, setAsDefault as Boolean)
		  Var archiveCommand As String= """"+SpecialFolder.Resources.NativePath _
		  + "7zzs"" x % -o" + """"+SpecialFolder.CurrentWorkingDirectory.NativePath+""" -y"
		  
		  If(f4seArchive<> Nil And f4seArchive.Name.Lowercase.Contains("f4se")) Then
		    If(f4seArchive.Name.Contains(".zip")) Then
		      f4seArchive.Unzip(App.falloutData)
		    ElseIf(f4seArchive.Name.Contains(".7z")) Then
		      Utils.ShellCommand(archiveCommand.Replace("%",""""+f4seArchive.NativePath+""""), False, False)
		    ElseIf(f4seArchive.Name.Contains(".rar")) Then
		      Utils.ShellCommand(archiveCommand.Replace("%",""""+f4seArchive.NativePath+""""), False, False)
		    Else
		      Utils.GeneratePopup(3,"Unsupported archive format",_
		      "Please extract manually and archive as a zip file")
		    End
		  Else
		    Utils.GeneratePopup(3,"Invalid Archive Name",_
		    f4seArchive.Name + " Doesn't seem to be an f4se Archive. Please Try again.")
		  End
		  
		  For Each item As folderitem In SpecialFolder.CurrentWorkingDirectory.Children
		    If(item.IsFolder And item.Name.Lowercase.Contains("f4se")) Then
		      For Each subitem As folderitem In item.Children
		        subitem.MoveTo(App.falloutData.Parent)
		      Next
		      item.Remove
		      Exit
		    End
		  Next
		  
		  Var f4sePlugins As Folderitem
		  
		  If(setAsDefault) Then
		    If(App.falloutData.Child("F4SE").Exists) Then
		      Utils.WriteFile(App.falloutData.Child("F4SE").Child("F4SE.ini"),"[Loader]" +_
		      EndOfLine + "RuntimeName=Fallout4SE.exe",True)
		    Else
		      f4sePlugins= Utils.CreateFolderStructure(App.falloutData,"/F4SE/Plugins/")
		      Utils.WriteFile(App.falloutData.Child("F4SE").Child("F4SE.ini"),"[Loader]" +_
		      EndOfLine + "RuntimeName=Fallout4SE.exe", True)
		    End
		    App.falloutData.Parent.Child("Fallout4SE.exe").Name="Fallout4SE.exe.bak"
		    App.falloutData.Parent.Child("f4se64_loader.exe").Name="Fallout4SE.exe"
		  End
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadPluginList()
		  Var pluginNames() As String= F4SEHandler.ScanPlugins
		  
		  ClearPluginList
		  
		  For Each plugin As String In pluginNames
		    F4SEScreen.lsb_Plugins.AddRow(plugin.Replace(".dll","").Replace(".bin",""))
		  Next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemovePlugin(pluginName as String)
		  If(App.falloutData.Child("F4SE").child("Plugins").Child(pluginName+".dll").Exists) Then
		    App.falloutData.Child("F4SE").child("Plugins").Child(pluginName+".dll").Remove
		  ElseIf(App.falloutData.Child("F4SE").child("Plugins").Child(pluginName+".bin").Exists) Then
		    App.falloutData.Child("F4SE").child("Plugins").Child(pluginName+".bin").remove
		  End
		  LoadPluginList
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ScanPlugins() As String()
		  Var f4seNames() As String
		  
		  If(App.f4seFolder.Exists) Then
		    If(App.f4seFolder.Child("Plugins").Exists) Then
		      For Each item As folderitem In App.f4seFolder.Child("Plugins").Children
		        If(Not item.IsFolder) Then
		          f4seNames.Add(item.Name)
		        End
		      Next
		    End
		  End
		  
		  Return f4seNames
		End Function
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
