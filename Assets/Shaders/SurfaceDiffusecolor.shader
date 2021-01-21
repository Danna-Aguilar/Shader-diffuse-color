Shader "Custom/SurfaceDiffusecolor"
{
    properties
    {
        _Albedo("Albedo color", color)=(1,1,1,1) //rgba // colores
    }

    Subshader 
    {
        Tags //tipo de render
        {
            "Queue" = "Geometry" //cola y tipo de cola
            "RenderType" = "Opaque"
        }

        CGPROGRAM
            float4 _Albedo;
            #pragma surface surf Lambert  
            struct Input 
            {
                float2 uv_Maintex; 
            };
        void surf (Input IN, inout SurfaceOutput o )
        {
            o.Albedo = _Albedo; 
        }
        ENDCG
    }
}