#tag Class
Protected Class FomodSchema
	#tag Method, Flags = &h0
		Sub Constructor(inName as String, inDescription as String, inEsp as String, inLocation as FolderItem, inIsOptional as Boolean, inImage as FolderItem = nil)
		  Me.name= inName
		  Me.description= inDescription
		  Me.esp= inEsp
		  Me.image= inImage
		  Me.location= inLocation
		  me.isOptional= inIsOptional
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		description As String
	#tag EndProperty

	#tag Property, Flags = &h0
		esp As String
	#tag EndProperty

	#tag Property, Flags = &h0
		image As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		isOptional As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		location As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		name As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="name"
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
		#tag ViewProperty
			Name="description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="esp"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isOptional"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass