#version 430 core

layout (location = 0) in vec3 a_position;
layout (location = 1) in vec2 a_texture;
layout (location = 2) in vec3 a_normal;
layout (location = 3) in vec3 a_tangent;
layout (location = 4) in vec3 a_bitangent;

out VS_OUT 
{
    vec3 vertex_pos;
    vec2 vertex_texture;
    mat3 TBN;
} vs_out;

uniform mat4 u_projection;
uniform mat4 u_transform;
uniform mat4 u_view;

void main()
{
    gl_Position = u_projection * u_view * u_transform * vec4(a_position, 1.0);
    vs_out.vertex_pos = (u_transform * vec4(a_position, 1.0)).xyz;

    vs_out.vertex_texture = a_texture;

    vec3 T = normalize(vec3(u_transform * vec4(a_tangent, 0.0)));
    vec3 B = normalize(vec3(u_transform * vec4(a_bitangent, 0.0)));
    vec3 N = normalize(vec3(u_transform * vec4(a_normal, 0.0)));
    vs_out.TBN = transpose(mat3(T, B, N));
}
