shader_type canvas_item;

uniform sampler2D noise:repeat_enable;

void fragment() {
	vec3 noise_color = texture(noise,SCREEN_UV+TIME*0.1).rgb;
	COLOR.rgb = noise_color.rgb;
}
