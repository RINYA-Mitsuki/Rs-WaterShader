Shader "Mitsuboshi Records/Rs-WaterShader" {
	Properties {
		_MainColor ("Main Color", color) = (0,0,0,1)
		_Texture1 ("Texture 1", 2D) = "white" {}
		[Normal]_Normal1 ("NormalMap 1", 2D) = "white" {}
		_Alpha ("Alpha", Range( 0.0, 1.0 )) = 1.0
		_Specular ("Specular", Range( 0.0, 1.0 )) = 1.0
	}
	SubShader {
		Tags { "Queue" = "Transparent" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard alpha:fade
		#pragma target 3.0

		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _MainColor;
		fixed _Alpha, _Specular;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			o.Albedo = _MainColor.rgb;
			o.Alpha = _Alpha;
			o.Smoothness = _Specular;
		}
		ENDCG
	}
	FallBack "Diffuse"
}