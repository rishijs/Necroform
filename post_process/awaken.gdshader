shader_type canvas_item;

uniform sampler2D screen_texture:hint_screen_texture,repeat_disable,filter_nearest;

void fragment() {
	vec3 screen_color = texture(screen_texture,SCREEN_UV).rgb;
	COLOR.rgb = vec3(screen_color.r,0,0);
}
