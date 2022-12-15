// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Mitsuboshi Records/Rs WaterShader"
{
	Properties
	{
		_Texture1("Texture 1", 2D) = "white" {}
		[Normal]_NormalTexture1("Normal Texture 1", 2D) = "bump" {}
		_Normal1("Normal 1", Range( -1 , 1)) = 1
		_ScrollSpeed1("Scroll Speed 1", Vector) = (0.05,0.1,0,0)
		[Toggle]_ToggleTexture2("Toggle Texture 2", Float) = 1
		_Texture2("Texture 2", 2D) = "white" {}
		[Normal]_NormalTexture2("Normal Texture 2", 2D) = "bump" {}
		_Normal2("Normal 2", Range( -1 , 1)) = 1
		_ScrollSpeed2("Scroll Speed 2", Vector) = (0.03,0.01,0,0)
		_TextureTiling("Texture Tiling", Float) = 1
		_Color1("Color 1", Color) = (0.3393556,0.4117271,0.7735849,0)
		_Color2("Color 2", Color) = (0.2970363,0.3999404,0.8396226,0)
		_Color3("Color 3", Color) = (0.1180135,0.18264,0.490566,0)
		_ColorOverray("Color Overray", Color) = (0.1073336,0.1489162,0.3396226,0)
		_Metallic("Metallic", Range( 0 , 1)) = 1
		_Smoothness("Smoothness", Range( 0 , 1)) = 1
		_Opacity("Opacity", Range( 0 , 1)) = 1
		_SeashoreTexture("Seashore Texture", 2D) = "white" {}
		_SeashoreColor("Seashore Color", Color) = (1,1,1,0)
		_SeashoreIntensity("Seashore Intensity", Range( 0 , 1)) = 0.2
		_Skybox("Skybox", CUBE) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPos;
			float3 worldRefl;
			INTERNAL_DATA
		};

		uniform float _ToggleTexture2;
		uniform sampler2D _NormalTexture1;
		uniform float2 _ScrollSpeed1;
		uniform float _TextureTiling;
		uniform float _Normal1;
		uniform sampler2D _NormalTexture2;
		uniform float2 _ScrollSpeed2;
		uniform float _Normal2;
		uniform sampler2D _SeashoreTexture;
		uniform float4 _SeashoreColor;
		uniform sampler2D _Texture1;
		uniform float4 _Color1;
		uniform float4 _Color2;
		uniform float4 _Color3;
		uniform float4 _ColorOverray;
		uniform sampler2D _Texture2;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _SeashoreIntensity;
		uniform samplerCUBE _Skybox;
		uniform float _Metallic;
		uniform float _Smoothness;
		uniform float _Opacity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (_TextureTiling).xx;
			float2 uv_TexCoord3 = i.uv_texcoord * temp_cast_0;
			float2 panner37 = ( 1.0 * _Time.y * _ScrollSpeed1 + uv_TexCoord3);
			float2 Tiling171 = panner37;
			float3 tex2DNode29 = UnpackScaleNormal( tex2D( _NormalTexture1, Tiling171 ), _Normal1 );
			float2 panner38 = ( 1.0 * _Time.y * _ScrollSpeed2 + uv_TexCoord3);
			float2 Tiling273 = panner38;
			float3 Normal78 = (( _ToggleTexture2 )?( BlendNormals( tex2DNode29 , UnpackScaleNormal( tex2D( _NormalTexture2, Tiling273 ), _Normal2 ) ) ):( tex2DNode29 ));
			o.Normal = Normal78;
			float4 tex2DNode2 = tex2D( _Texture1, Tiling171 );
			float3 temp_cast_1 = (tex2DNode2.r).xxx;
			float grayscale103 = Luminance(temp_cast_1);
			float3 temp_cast_2 = (tex2DNode2.g).xxx;
			float grayscale104 = Luminance(temp_cast_2);
			float3 temp_cast_3 = (tex2DNode2.b).xxx;
			float grayscale105 = Luminance(temp_cast_3);
			float4 temp_output_121_0 = ( ( grayscale103 * _Color1 ) + ( grayscale104 * _Color2 ) + ( grayscale105 * _Color3 ) + _ColorOverray );
			float4 tex2DNode7 = tex2D( _Texture2, Tiling273 );
			float3 temp_cast_4 = (tex2DNode7.r).xxx;
			float grayscale106 = Luminance(temp_cast_4);
			float3 temp_cast_5 = (tex2DNode7.g).xxx;
			float grayscale107 = Luminance(temp_cast_5);
			float3 temp_cast_6 = (tex2DNode7.b).xxx;
			float grayscale108 = Luminance(temp_cast_6);
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth135 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth135 = abs( ( screenDepth135 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _SeashoreIntensity ) );
			float clampResult136 = clamp( distanceDepth135 , 0.0 , 1.0 );
			float4 lerpResult139 = lerp( ( tex2D( _SeashoreTexture, Tiling273 ) + _SeashoreColor ) , (( _ToggleTexture2 )?( ( temp_output_121_0 + ( ( grayscale106 * _Color3 ) + ( grayscale107 * _Color2 ) + ( grayscale108 * _Color1 ) + _ColorOverray ) ) ):( temp_output_121_0 )) , clampResult136);
			float4 Albedo112 = lerpResult139;
			o.Albedo = Albedo112.rgb;
			float4 Reflection146 = texCUBE( _Skybox, WorldReflectionVector( i , Normal78 ) );
			o.Emission = Reflection146.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
			o.Alpha = _Opacity;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 screenPos : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.screenPos = ComputeScreenPos( o.pos );
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldRefl = -worldViewDir;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				surfIN.screenPos = IN.screenPos;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
640;73;800;644;-273.66;1184.462;1.3;True;False
Node;AmplifyShaderEditor.CommentaryNode;81;-512,-1152;Inherit;False;957.4603;610.1972;Comment;8;41;40;3;73;38;71;37;39;Tiling;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-464,-944;Inherit;False;Property;_TextureTiling;Texture Tiling;9;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;39;-288,-1088;Inherit;False;Property;_ScrollSpeed1;Scroll Speed 1;3;0;Create;True;0;0;0;False;0;False;0.05,0.1;0,-0.01;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;40;-288,-688;Inherit;False;Property;_ScrollSpeed2;Scroll Speed 2;8;0;Create;True;0;0;0;False;0;False;0.03,0.01;0.01,0.01;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-288,-960;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;38;-32,-832;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;37;-32,-1088;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;127;-512,-480;Inherit;False;2357.353;1018.376;Comment;33;137;138;112;139;111;136;126;135;121;125;134;117;122;124;118;120;110;123;106;107;116;104;119;105;103;109;108;7;2;101;102;141;142;Main Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;73;224,-832;Float;False;Tiling2;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;71;224,-1088;Float;False;Tiling1;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;83;-512,608;Inherit;False;1386.134;466.0977;Comment;9;72;78;32;33;75;44;36;29;30;Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-480,768;Inherit;False;Property;_Normal1;Normal 1;2;0;Create;True;0;0;0;False;0;False;1;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-480,960;Inherit;False;Property;_Normal2;Normal 2;7;0;Create;True;0;0;0;False;0;False;1;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;72;-480,672;Inherit;False;71;Tiling1;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;101;-464,128;Inherit;False;73;Tiling2;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;102;-464,-128;Inherit;False;71;Tiling1;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;75;-480,864;Inherit;False;73;Tiling2;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;30;-160,864;Inherit;True;Property;_NormalTexture2;Normal Texture 2;6;1;[Normal];Create;True;0;0;0;False;0;False;-1;488a3f3f9a08cf74aa88870cb7952391;488a3f3f9a08cf74aa88870cb7952391;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;29;-160,672;Inherit;True;Property;_NormalTexture1;Normal Texture 1;1;1;[Normal];Create;True;0;0;0;False;0;False;-1;8943499195315a5418d55a0fb1db5246;8943499195315a5418d55a0fb1db5246;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-272,128;Inherit;True;Property;_Texture2;Texture 2;5;0;Create;True;0;0;0;False;0;False;-1;86a9e3ca6cddcff41b7bc283ab15397c;86a9e3ca6cddcff41b7bc283ab15397c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-272,-240;Inherit;True;Property;_Texture1;Texture 1;0;0;Create;True;0;0;0;False;0;False;-1;b7bb9c59207a5fb46973140a610a70ba;b7bb9c59207a5fb46973140a610a70ba;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCGrayscale;104;48,-208;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCGrayscale;105;48,-128;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;119;-80,-48;Inherit;False;Property;_Color3;Color 3;12;0;Create;True;0;0;0;False;0;False;0.1180135,0.18264,0.490566,0;0.1180133,0.1826398,0.490566,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;109;-464,-48;Inherit;False;Property;_Color1;Color 1;10;0;Create;True;0;0;0;False;0;False;0.3393556,0.4117271,0.7735849,0;0.3393554,0.4117269,0.7735849,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCGrayscale;106;48,128;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCGrayscale;107;48,208;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;36;160,768;Inherit;True;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCGrayscale;103;48,-288;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCGrayscale;108;48,288;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;116;-272,-48;Inherit;False;Property;_Color2;Color 2;11;0;Create;True;0;0;0;False;0;False;0.2970363,0.3999404,0.8396226,0;0.2970361,0.3999402,0.8396226,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;117;272,-240;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;110;272,-336;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;118;272,-144;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;122;272,224;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;120;112,-48;Inherit;False;Property;_ColorOverray;Color Overray;13;0;Create;True;0;0;0;False;0;False;0.1073336,0.1489162,0.3396226,0;0.4565679,0.5043106,0.7169812,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;123;272,128;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;272,320;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;44;448,672;Inherit;False;Property;_ToggleTexture2;Toggle Texture 2;4;0;Create;True;0;0;0;False;0;False;1;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;141;528,-208;Inherit;False;73;Tiling2;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;131;912,608;Inherit;False;1006;303;Comment;4;145;144;143;146;Reflection;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;134;496,336;Float;False;Property;_SeashoreIntensity;Seashore Intensity;19;0;Create;True;0;0;0;False;0;False;0.2;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;125;496,112;Inherit;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;121;496,-112;Inherit;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;78;648,672;Float;False;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DepthFade;135;784,336;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;143;928,672;Inherit;False;78;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;126;720,-48;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;138;496,-384;Float;False;Property;_SeashoreColor;Seashore Color;18;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;137;720,-304;Inherit;True;Property;_SeashoreTexture;Seashore Texture;17;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;136;1040,336;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;111;928,-112;Inherit;False;Property;_ToggleTexture2;Toggle Texture 2;12;0;Create;True;0;0;0;False;0;False;1;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;142;1024,-384;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldReflectionVector;144;1104,672;Inherit;True;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;145;1344,672;Inherit;True;Property;_Skybox;Skybox;20;0;Create;True;0;0;0;False;0;False;-1;None;656a59a5ff93c46498416d97e5c16b66;True;0;False;white;Auto;False;Object;-1;Auto;Cube;8;0;SAMPLERCUBE;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;139;1264,-176;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;112;1504,-176;Float;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;146;1648,672;Float;False;Reflection;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;77;880,-960;Inherit;False;112;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;157;720,-672;Float;False;Property;_Opacity;Opacity;16;0;Create;True;0;0;0;False;0;False;1;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;720,-752;Inherit;False;Property;_Smoothness;Smoothness;15;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;720,-832;Inherit;False;Property;_Metallic;Metallic;14;0;Create;True;0;0;0;False;0;False;1;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;560,-896;Inherit;False;146;Reflection;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;79;720,-928;Inherit;False;78;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1056,-944;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Mitsuboshi Records/Rs WaterShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;41;0
WireConnection;38;0;3;0
WireConnection;38;2;40;0
WireConnection;37;0;3;0
WireConnection;37;2;39;0
WireConnection;73;0;38;0
WireConnection;71;0;37;0
WireConnection;30;1;75;0
WireConnection;30;5;33;0
WireConnection;29;1;72;0
WireConnection;29;5;32;0
WireConnection;7;1;101;0
WireConnection;2;1;102;0
WireConnection;104;0;2;2
WireConnection;105;0;2;3
WireConnection;106;0;7;1
WireConnection;107;0;7;2
WireConnection;36;0;29;0
WireConnection;36;1;30;0
WireConnection;103;0;2;1
WireConnection;108;0;7;3
WireConnection;117;0;104;0
WireConnection;117;1;116;0
WireConnection;110;0;103;0
WireConnection;110;1;109;0
WireConnection;118;0;105;0
WireConnection;118;1;119;0
WireConnection;122;0;107;0
WireConnection;122;1;116;0
WireConnection;123;0;106;0
WireConnection;123;1;119;0
WireConnection;124;0;108;0
WireConnection;124;1;109;0
WireConnection;44;0;29;0
WireConnection;44;1;36;0
WireConnection;125;0;123;0
WireConnection;125;1;122;0
WireConnection;125;2;124;0
WireConnection;125;3;120;0
WireConnection;121;0;110;0
WireConnection;121;1;117;0
WireConnection;121;2;118;0
WireConnection;121;3;120;0
WireConnection;78;0;44;0
WireConnection;135;0;134;0
WireConnection;126;0;121;0
WireConnection;126;1;125;0
WireConnection;137;1;141;0
WireConnection;136;0;135;0
WireConnection;111;0;121;0
WireConnection;111;1;126;0
WireConnection;142;0;137;0
WireConnection;142;1;138;0
WireConnection;144;0;143;0
WireConnection;145;1;144;0
WireConnection;139;0;142;0
WireConnection;139;1;111;0
WireConnection;139;2;136;0
WireConnection;112;0;139;0
WireConnection;146;0;145;0
WireConnection;0;0;77;0
WireConnection;0;1;79;0
WireConnection;0;2;132;0
WireConnection;0;3;48;0
WireConnection;0;4;49;0
WireConnection;0;9;157;0
ASEEND*/
//CHKSM=12D991BBEF6F07BD411F0022035106D78D9EDC91