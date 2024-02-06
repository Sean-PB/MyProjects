shader_type canvas_item;

uniform vec4 OLDSKIN : source_color;
uniform vec4 NEWSKIN : source_color;

void fragment() {
	vec4 curr_color = texture(TEXTURE, UV); // Get current color of pixel
	// Check that current pixel color is any of the OLDCOLORs we want to swap
	// If our pixel is an old color then swap COLOR to NEWCOLR
	if (curr_color == OLDSKIN)
	{
		COLOR = NEWSKIN;
	}
	else
	{
		COLOR = curr_color;
	}
}