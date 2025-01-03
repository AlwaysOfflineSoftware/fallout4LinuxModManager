#tag Module
Protected Module FomodHandler
	#tag Method, Flags = &h21
		Private Sub GenerateFomodder()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseFomodFile(modXml As folderitem)
		  If(modxml.Extension="xml") Then
		    Var xmlContent As String= Utils.ReadFile(modXml)
		    Var xmlContentGroups() As String= xmlContent.Split("<group")
		    Var xmlContentPlugins() As String
		    Var xmlContentPluginLines() As String
		    Var pluginName As String
		    Var pluginDesc As String
		    Var descTrigger As Boolean= False
		    Var pluginImg As String
		    Var pluginFile As String
		    Var pluginPath As String
		    Var fileTrigger As Boolean= False
		    // System.DebugLog(xmlContentGroups(1))
		    
		    For i As Integer = xmlContentGroups.FirstIndex To xmlContentGroups.LastIndex
		      // System.DebugLog("<group" + xmlContentGroups(i))
		      xmlContentPlugins= xmlContentGroups(i).Split("<plugin ")
		      If(i=xmlContentGroups.FirstIndex) Then
		        Continue
		      Else
		        For k As Integer = xmlContentPlugins.FirstIndex To xmlContentPlugins.LastIndex
		          // System.DebugLog("<plugin " + xmlContentPlugins(k))
		          xmlContentPluginLines= xmlContentPlugins(k).Split(EndOfLine)
		          
		          For Each line As String In xmlContentPluginLines
		            Var tempArr() As String
		            Var slimLine As String= line.Trim
		            // System.DebugLog(line.Trim)
		            
		            If(line.Contains("name=") And Not line.Contains("<") And Not line.Contains(" type=")) Then
		              tempArr= line.Split(Chr(34))
		              pluginName= tempArr(1).Trim
		              System.DebugLog(pluginName)
		              
		            ElseIf(slimLine.Contains("<description>") Or descTrigger) Then
		              If(slimLine= "<description>" Or descTrigger) Then
		                If(descTrigger) Then
		                  pluginDesc= slimLine
		                  System.DebugLog(pluginDesc)
		                  descTrigger= False
		                Else
		                  descTrigger= True
		                End
		              Else
		                tempArr= slimline.Split(Chr(34))
		                pluginDesc= tempArr(1).Trim
		                System.DebugLog(pluginDesc)
		              End
		              
		            ElseIf(slimLine.Contains("<image path=")) Then
		              tempArr= slimline.Split(Chr(34))
		              pluginImg= tempArr(1).Trim
		              System.DebugLog(pluginImg)
		              
		            ElseIf(slimline="<files>" Or fileTrigger) Then
		              If(fileTrigger) Then
		                tempArr= slimline.Split(Chr(34))
		                If(tempArr(0).contains("destination=")) Then
		                  pluginFile= tempArr(1).Trim
		                  System.DebugLog(pluginFile)
		                Else
		                  pluginFile= tempArr(3).Trim
		                  System.DebugLog(pluginFile)
		                End
		                
		                If(tempArr(3).contains("destination=")) Then
		                  pluginPath= tempArr(1).Trim
		                  System.DebugLog(pluginPath)
		                Else
		                  pluginPath= tempArr(3).Trim
		                  System.DebugLog(pluginPath)
		                End
		                fileTrigger= False
		              Else
		                fileTrigger= True
		              End
		              
		            End
		          Next
		        Next
		      End
		    Next
		  End
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RunFomod(fomodXml as String)
		  ParseFomodFile(new folderitem(fomodXml))
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private installerPackage(30,30) As FomodSchema
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
