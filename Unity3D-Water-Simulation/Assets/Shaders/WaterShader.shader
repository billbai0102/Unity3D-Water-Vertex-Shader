Shader "Custom/WaterShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0

        _Scale ("Scale", float) = 1
		_Speed ("Speed", float) = 1
		_Frequency ("Frequency", float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
		#pragma surface surf Standard fullforwardshadows vertex:vert
		#pragma target 4.0

        sampler2D _MainTex;

        float _Scale, _Speed, _Frequency;
        float _WaveAmp1, _WaveAmp2, _WaveAmp3, _WaveAmp4, _WaveAmp5, _WaveAmp6, _WaveAmp7, _WaveAmp8;
        float _OffsetX1, _OffsetX2, _OffsetX3, _OffsetX4, _OffsetX5, _OffsetX6, _OffsetX7, _OffsetX8;
        float _OffsetZ1, _OffsetZ2, _OffsetZ3, _OffsetZ4, _OffsetZ5, _OffsetZ6, _OffsetZ7, _OffsetZ8;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void vert(inout appdata_full v){
            half offsetvert = (v.vertex.x * v.vertex.x) + (v.vertex.z * v.vertex.z);
            
            half value1 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX1) + (v.vertex.z * _OffsetZ1));
            half value2 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX2) + (v.vertex.z * _OffsetZ2));
            half value3 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX3) + (v.vertex.z * _OffsetZ3));
            half value4 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX4) + (v.vertex.z * _OffsetZ4));
            half value5 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX5) + (v.vertex.z * _OffsetZ5));
            half value6 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX6) + (v.vertex.z * _OffsetZ6));
            half value7 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX7) + (v.vertex.z * _OffsetZ7));
            half value8 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX8) + (v.vertex.z * _OffsetZ8));

            v.vertex.y += value1 * _WaveAmp1;
            v.normal.x += value1 * _WaveAmp1;
            
            v.vertex.y += value2 * _WaveAmp2;
            v.normal.x += value2 * _WaveAmp2;
            
            v.vertex.y += value3 * _WaveAmp3;
            v.normal.x += value3 * _WaveAmp3;
            
            v.vertex.y += value4 * _WaveAmp4;
            v.normal.x += value4 * _WaveAmp4;
            
            v.vertex.y += value5 * _WaveAmp5;
            v.normal.x += value5 * _WaveAmp5;
            
            v.vertex.y += value6 * _WaveAmp6;
            v.normal.x += value6 * _WaveAmp6;
            
            v.vertex.y += value7 * _WaveAmp7;
            v.normal.x += value7 * _WaveAmp7;
            
            v.vertex.y += value8 * _WaveAmp8;
            v.normal.x += value8 * _WaveAmp8;
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
