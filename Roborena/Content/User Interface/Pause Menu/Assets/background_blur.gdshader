shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap;
uniform float amount: hint_range(0.0, 5.0);
uniform float darken_amount: hint_range(0.0, 1.0);

void fragment() {
    // Sample the color from the texture with blur effect
    vec4 texture_color = textureLod(screen_texture, SCREEN_UV, amount);

    // Apply the darkening effect
    vec4 darkened_color = vec4(texture_color.rgb - darken_amount, texture_color.a);

    // Output the final color
    COLOR = darkened_color;
}