shader_type canvas_item;

uniform vec2 center = vec2(0.5);
uniform float power: hint_range(0.1, 10.0, 0.01) = 1.0;
uniform float radius: hint_range(0.0, 1.0, 0.01) = 0.3;

void fragment() {
    vec2 uv = UV;
    vec2 resolution = 1.0 / TEXTURE_PIXEL_SIZE; 
    vec2 aspect_uv = uv;
    aspect_uv.x *= resolution.x / resolution.y;
    vec2 eye_uv = center;
    eye_uv.x *= resolution.x / resolution.y;
    float dist = distance(eye_uv, aspect_uv);
    if (dist < radius) {
        float warp = pow(dist / radius, 0.5);
        float mag_factor = pow(warp, 1.0 / power);
        uv = center + (uv - center) * mag_factor;
    }
    COLOR = texture(TEXTURE, uv);
}