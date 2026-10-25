shader_type particles;

uniform vec2 spawn_box = vec2(100.0, 100.0);
uniform vec2 spawn_offset = vec2(0.0, 0.0);
uniform float x_speed: hint_range(-250.0, 250.0, 1.0) = -20.0;
uniform float y_speed: hint_range(-250, 250, 1.0) = 20.0;

uniform int color_mode: hint_range(0, 2) = 0;
uniform vec3 color: source_color = vec3(1.0);
// palette must be 1 pixel tall by `palette color count` wide
uniform sampler2D palette: filter_nearest, repeat_disable;
uniform int palette_color_count = 8;
uniform ivec4 palette_color_index_array = ivec4(0, 1, 2, 3);

uniform float speed_stop: hint_range(0.0, 1.0, 0.01) = 0.7;
uniform float fade_start: hint_range(0.0, 1.0, 0.01) = 0.9;
uniform float x_sway_speed: hint_range(0.0, 20.0, 1.0) = 2.0;
uniform float x_sway_amount: hint_range(0.0, 100.0, 1.0) = 40.0;
uniform float rotate_with_sway_amount: hint_range(0.0, 1.0, 0.1) = 0.2;

float hash(vec2 uv) { // magic function for pseudo-random floats
	// returns 0 to 1
	return fract(sin(dot(uv.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

vec4 get_color_from_palette(int index) {
	int clamped_index = clamp(index, 0, palette_color_count - 1);
	float u = (float(clamped_index) + 0.5) / float(palette_color_count);
	return texture(palette, vec2(u, 0.5));
}

void start() {
	// convert NUMBER into something less than 1
	// the decimals don't really matter, they just need to be different
	// we need unique numbers for each particle to hash into 
	// new psueo-random numbers
	float n = fract(float(NUMBER) * 0.01);
	float n2 = fract(float(NUMBER) * 0.02);
	float n3 = fract(float(NUMBER) * 0.03);
	float rand_x = hash(vec2(n, n2));
	float rand_y = hash(vec2(n2, n));
	
	// set the position to a random spot within the spawn box
	vec2 offset = vec2(rand_x, rand_y) * 2.0 - 1.0; // spread out to -1 to 1
	TRANSFORM[3].xy = offset * spawn_box + spawn_offset;
	
	// set the initial velocity
	VELOCITY = vec3(x_speed, y_speed, 0.0);
	
	switch(color_mode){
		case 0: // single color mode
			COLOR.rgb = color;
			COLOR.a = 1.0;
			break;
		case 1: // full palette mode
			// get a random index from the palette for each particle
			int index = int(hash(vec2(n, n3)) * float(palette_color_count));
			COLOR = get_color_from_palette(index);
			break;
		case 2: // palette subset mode
			// get a random index and set it to one of 4 colors of the palette
			int index = int(hash(vec2(n3, n)) * 4.0);
			COLOR = get_color_from_palette(palette_color_index_array[index]);
			break;
	}
	CUSTOM.x = 0.0; // this will hold the time the particle has been alive
}

void process() {
	// Called every frame on existing particles (according to the Fixed FPS property).
	CUSTOM.x += DELTA;
	float life_progress = CUSTOM.x / LIFETIME;
	
	// if at end of life, start fading
	if (life_progress > fade_start) {
		COLOR.a = 1.0 - smoothstep(fade_start, 1.0, life_progress);
	}
	// if after speed stop ratio, pause movement
	if (life_progress > speed_stop) {
		VELOCITY = vec3(0.0);
	} else {
		// implement x sway
		float current_time = TIME + CUSTOM.x;
		TRANSFORM[3].y += y_speed * DELTA;
		TRANSFORM[3].x += sin(current_time * x_sway_speed) * x_sway_amount * DELTA;
		// implement rotation sway
		float rot_sway = sin(current_time * x_sway_speed) * rotate_with_sway_amount;
		TRANSFORM[0].xy = vec2(cos(rot_sway), -sin(rot_sway));
		TRANSFORM[1].xy = vec2(sin(rot_sway), cos(rot_sway));
	}
}
