shader_type canvas_item;

uniform vec4 OLDCOLOR1 : source_color;
uniform vec4 OLDCOLOR2 : source_color;
uniform vec4 OLDCOLOR3 : source_color;
uniform vec4 NEWCOLOR1 : source_color;
uniform vec4 NEWCOLOR2 : source_color;
uniform vec4 NEWCOLOR3 : source_color;

void fragment() {
	vec4 curr_color = texture(TEXTURE, UV); // Get current color of pixel
	// Check that current pixel color is any of the OLDCOLORs we want to swap
	// If our pixel is an old color then swap COLOR to NEWCOLR
	if (curr_color == OLDCOLOR1)
	{
		COLOR = NEWCOLOR1;
	}
	else if (curr_color == OLDCOLOR2)
	{
		COLOR = NEWCOLOR2;
	}
	else if (curr_color == OLDCOLOR3)
	{
		COLOR = NEWCOLOR3;
	}
	else
	{
		COLOR = curr_color;
	}
}