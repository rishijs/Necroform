shader_type canvas_item;

uniform sampler2D noise:repeat_enable;
uniform float speed:hint_range(0.0, 1.0, 0.01) = 0.1;

void fragment() {
	vec3 noise_color = texture(noise,SCREEN_UV+TIME*speed).rgb;
	COLOR.rgb = noise_color.rgb;
}
