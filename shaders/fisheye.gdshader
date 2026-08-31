shader_type canvas_item;

uniform vec2 center = vec2(0.5);
uniform float power : hint_range(0.1, 10.0, 0.01) = 1.0;
uniform float radius : hint_range(0.0, 1.0, 0.01) = 0.3;

uniform float pixel_size : hint_range(1.0, 100.0, 1.0) = 8.0;

void fragment() {
	ivec2 tex_size = textureSize(TEXTURE, 0);
	vec2 resolution = vec2(float(tex_size.x), float(tex_size.y));
	
	vec2 grid_factor = resolution / pixel_size;
	vec2 pixelated_uv = (floor(UV * grid_factor) + 0.5) / grid_factor;
	
	vec2 aspect_uv = pixelated_uv;
	aspect_uv.x *= resolution.x / resolution.y;
	
	vec2 eye_uv = center;
	eye_uv.x *= resolution.x / resolution.y;
	
	vec2 final_uv = pixelated_uv;
	float dist = distance(eye_uv, aspect_uv);
	
	if (dist < radius) {
		float warp = pow(dist / radius, 0.5);
		float mag_factor = pow(warp, 1.0 / power);
		final_uv = center + (pixelated_uv - center) * mag_factor;
		
		final_uv = (floor(final_uv * grid_factor) + 0.5) / grid_factor;
	}
	
	COLOR = texture(TEXTURE, final_uv);
}