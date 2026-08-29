shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D palette_texture : filter_nearest;

uniform float color_levels : hint_range(1.0, 64.0, 1.0) = 32.0;
uniform float contrast : hint_range(0.1, 3.0) = 1.0;
uniform float shift : hint_range(-1.0, 1.0) = 0.0;

uniform float tolerance : hint_range(0.0, 1.0) = 0.01;
const int MAX_COLORS = 32;
uniform int active_colors : hint_range(0, 16) = 0;
uniform vec4 old_colors[4] : source_color;
uniform vec4 new_colors[4] : source_color;

void fragment() {
	vec4 col = texture(screen_texture, SCREEN_UV);
	float brightness = dot(col.rgb, vec3(0.3, 0.6, 0.1));
	brightness = (brightness - 0.5) * contrast + 0.5 + shift;
	brightness = clamp(brightness, 0.0, 0.999);
	float compressed_brightness = (floor(brightness * color_levels) + 0.5) / color_levels;
	
	vec4 final_color = texture(palette_texture, vec2(compressed_brightness, 0.5));
	
	for (int i = 0; i < MAX_COLORS; i++)
	{
		if(i >= active_colors)
		{
			break;
		}
		
		if(distance(final_color.rgb, old_colors[i].rgb) <= tolerance)
		{
			final_color = new_colors[i];
			break;
		}
	}
	COLOR = vec4(final_color.rgb, col.a);
}
