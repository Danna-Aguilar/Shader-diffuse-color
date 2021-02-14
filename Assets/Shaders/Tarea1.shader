Shader "Custom/SurfaceDiffuseStrength"
{
    Properties
    {
        _Albedo("Albedo Color", Color) = (1, 1, 1, 1)
        _MainTex("Main Texture", 2D) = "white" {}
        _NormalTex("Normal Texture", 2D) = "bump" {}
        _NormalStrength("Normal Strength", Range(-5.0, 5.0)) = 1.0
        [HDR] _RimColor("Rim Color", Color) = (1, 0, 0, 1)
        _RimPower("Rim Power", Range(0.0, 8.0)) = 1.0
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque"
        }

        CGPROGRAM

            half4 _Albedo;
            sampler2D _MainTex;
            sampler2D _NormalTex;
            float _NormalStrength;
            half4 _RimColor;//RIMLIGHT
            float _RimPower;//RIMLIGHT

            #pragma surface surf Lambert

            struct Input
            {
                float2 uv_MainTex;
                float2 uv_NormalTex;
                 float3 viewDir;//RIMLIGHT
            };

            void surf(Input IN, inout SurfaceOutput o)
            {
                half4 texColor = tex2D(_MainTex, IN.uv_MainTex);
                o.Albedo = _Albedo * texColor.rgb;
                half4 normalColor = tex2D(_NormalTex, IN.uv_NormalTex);
                half3 normal = UnpackNormal(normalColor);
                normal.z = normal.z / _NormalStrength;
                o.Normal = normalize(normal);
                float3 nVwd = normalize(IN.viewDir);
                float3 NdotV = dot(nVwd, o.Normal);
                half rim = 1 - saturate(NdotV);
                o.Emission = _RimColor.rgb * pow(rim, _RimPower);
            }
        ENDCG
    }
}