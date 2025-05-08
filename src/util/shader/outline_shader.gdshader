shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1);
uniform bool active = true;

uniform bool thick = false;

uniform float alpha : hint_range(0.0, 1.0, 0.1) = 1.0;

void fragment() {

	if (active){
		if (texture(TEXTURE, UV + vec2(TEXTURE_PIXEL_SIZE.x, 0)).a > 0.0 && COLOR.a < 0.1||
			texture(TEXTURE, UV + vec2(-TEXTURE_PIXEL_SIZE.x, 0)).a > 0.0 && COLOR.a < 0.1||
			texture(TEXTURE, UV + vec2(0, TEXTURE_PIXEL_SIZE.y)).a > 0.0 && COLOR.a < 0.1||
			texture(TEXTURE, UV + vec2(0, -TEXTURE_PIXEL_SIZE.y)).a > 0.0 && COLOR.a < 0.1
			){
			COLOR = outline_color;
			COLOR.a = alpha;
		}
		
		if (thick){
			if (texture(TEXTURE, UV + vec2(TEXTURE_PIXEL_SIZE.x, TEXTURE_PIXEL_SIZE.y)).a > 0.0 && COLOR.a < 0.1||
			texture(TEXTURE, UV + vec2(-TEXTURE_PIXEL_SIZE.x, -TEXTURE_PIXEL_SIZE.y)).a > 0.0 && COLOR.a < 0.1||
			texture(TEXTURE, UV + vec2(-TEXTURE_PIXEL_SIZE.x, TEXTURE_PIXEL_SIZE.y)).a > 0.0 && COLOR.a < 0.1||
			texture(TEXTURE, UV + vec2(TEXTURE_PIXEL_SIZE.x, -TEXTURE_PIXEL_SIZE.y)).a > 0.0 && COLOR.a < 0.1
			){
				COLOR = outline_color;
				COLOR.a = alpha;
			}
		}
	}

}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
