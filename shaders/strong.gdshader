shader_type canvas_item;

// RGB values
uniform vec3 glow_colour: source_color = vec3(0.8, 0.2, 0.3);
uniform float glow_power: hint_range(0.0, 8.0, 0.1) = 2.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR = texture(TEXTURE, UV) * vec4(glow_colour, 1.0) * glow_power;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
