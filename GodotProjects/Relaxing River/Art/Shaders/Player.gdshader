shader_type canvas_item;

uniform vec4 Old_Skin : source_color;
uniform vec4 New_Skin : source_color;
uniform vec4 Old_Hair : source_color;
uniform vec4 New_Hair : source_color;

void fragment() {
	vec4 curr_color = texture(TEXTURE, UV); // Get current color of pixel
	// Check that current pixel color is any of the OLDCOLORs we want to swap
	// If our pixel is an old color then swap COLOR to NEWCOLR
	if (curr_color == Old_Skin)
	{
		COLOR = New_Skin;
	}
	else if (curr_color == Old_Hair)
	{
		COLOR = New_Hair;
	}
	else
	{
		COLOR = curr_color;
	}
}