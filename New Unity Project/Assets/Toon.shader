Shader "Custom/NewSurfaceShader"
{
   Properties
   {
       _Albedo("Albedo", Color) = (1, 1, 1, 1)
       _MainTex("Main Texture", 2D) = "white"{}
       _RampTex("Ramp Texture", 2D) = "white" {}
   }

   SubShader
   {
        CGPROGRAM
        #pragma surface surf ToonRamp

        float4 _Albedo;
        sampler2D _MainTex;
        sampler2D _RampTex;

        float4 LightingToonRamp(SurfaceOutput s, fixed2 lightDir, fixed atten)
        {
            half diff = dot(s.Normal, lightDir);
            float uv = (diff * 0.5) + 0.5; //-1 hasta +1
            float3 ramp = tex2D(_RampTex, uv).rgb; //La cordenada donde voy a ver el UV.
            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * ramp;
            c.a = s.Alpha;
            return c;
        }

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Albedo.rgb;
        }

        ENDCG

		/*Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				//float3 uv : TEXTCORD0;
				float3 normal : NORMAL;
			};

			ENDCG
		}*/
   }
}
