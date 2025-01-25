#tag Module
Protected Module FomodHandler
	#tag Method, Flags = &h21
		Private Sub GenerateFomodder(displayFomod as FomodSchema)
		  FomodScreen.lbl_FomodName.Text= displayFomod.modName
		  FomodScreen.txa_FomodInfo.Text= displayFomod.description
		  // FomodScreen.imv_fomodImage.Image= Utils.LoadPicture(displayFomod.image)
		  
		  FomodScreen.Show
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseFomodFile(modXml As folderitem)
		  If(modxml.Extension="xml") Then
		    Var xmlContent As String= Utils.ReadFile(modXml)
		    If(Not xmlContent.contains("<config xmlns:xsi=")) Then
		      xmlContent= xmlContent.DefineEncoding(Encodings.UTF16).ConvertEncoding(Encodings.UTF8)
		    End
		    // System.DebugLog(xmlContent)
		    // Var xmlContentGroups() As String
		    Var xmlContentPlugins() As String= xmlContent.Split("<plugin ")
		    Var xmlContentPluginLines() As String
		    Var pluginModName As String
		    Var pluginName As String
		    Var pluginDesc As String
		    Var pluginImg As String
		    Var pluginFiles As String
		    Var pluginPath As String
		    Var pluginData As String
		    
		    Var tempArr() As String
		    Var innerTempArr() As String
		    Var innerTempArr2() As String
		    
		    For Each pluginEntry As String In xmlContentPlugins
		      // System.DebugLog(line+ EndOfLine+ "===")
		      If(pluginEntry.contains("http://www.w3.org")) Then
		        tempArr= pluginEntry.Split("<moduleName>")
		        If(tempArr.Count> 1) Then
		          innerTempArr= tempArr(1).Split("</moduleName>")
		          If(innerTempArr.Count> 1) Then
		            pluginModName= innerTempArr(0)
		          End
		        End
		        Continue
		      Else
		        System.DebugLog(pluginModName)
		        tempArr= pluginEntry.Split(Chr(34))
		        If(tempArr.Count> 1) Then
		          pluginName= tempArr(1).Trim
		          System.DebugLog(pluginName)
		        End
		        tempArr= pluginEntry.Split("description>")
		        If(tempArr.Count> 1) Then
		          pluginDesc= tempArr(1).Replace("</","").Trim
		          System.DebugLog(pluginDesc)
		        End
		        tempArr= pluginEntry.Split("<image path=")
		        If(tempArr.Count> 1) Then
		          innerTempArr= tempArr(1).Split(Chr(34))
		          pluginImg= innerTempArr(1).Replace("</","").Trim.ReplaceAll("\","/")
		          System.DebugLog(pluginImg)
		        End
		        tempArr= pluginEntry.Split("<files>")
		        If(tempArr.Count> 1) Then
		          innerTempArr= tempArr(1).Split("</files>")
		          pluginFiles= innerTempArr(0).Trim
		          // System.DebugLog(pluginFiles)
		          innerTempArr= pluginFiles.Split(Chr(34))
		          If(innerTempArr(0).contains("destination")) Then
		            pluginData= innerTempArr(1)
		            System.DebugLog(pluginData)
		            
		            pluginPath= innerTempArr(3).ReplaceAll("\","/")
		            System.DebugLog(pluginPath)
		          Else
		            pluginData= innerTempArr(3)
		            System.DebugLog(pluginData)
		            
		            pluginPath= innerTempArr(1).ReplaceAll("\","/")
		            System.DebugLog(pluginPath)
		          End
		        End
		      End
		      System.DebugLog(EndOfLine)
		      installerPackages.add(New FomodSchema(pluginModName,pluginName,pluginDesc,pluginData, _
		      pluginPath,pluginImg,True))
		    Next
		  End
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RunFomod(fomodXml as String)
		  If(Utils.ValidatePath(fomodXml)) Then
		    ParseFomodFile(New folderitem(fomodXml))
		    GenerateFomodder(installerPackages(1))
		  Else
		    Utils.GeneratePopup(1,"No Fomod XML Detected","An invalid path was provided")
		  End
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private installerPackages() As FomodSchema
	#tag EndProperty

	#tag Property, Flags = &h21
		Private rawXML As String
	#tag EndProperty


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
