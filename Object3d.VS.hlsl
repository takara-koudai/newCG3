#include "Object3d.hlsli"


struct TransformationMatrix {
	float32_t4x4 WVP;
	float32_t4x4 World;
	float32_t4x4 WorldInverseTranspose;
};
ConstantBuffer<TransformationMatrix>gTransfomationMatrix : register(b0);

struct VertexShaderInput {
	float32_t4 position : POSITION0;
	float32_t2 texcoord : TEXCOORD0;
	float32_t3 normal : NORMAL0;
};

VertexShaderOutput main(VertexShaderInput input) {
	VertexShaderOutput output;
	output.position = mul(input.position, gTransfomationMatrix.WVP);
	output.texcoord = input.texcoord;

	output.worldPosition = mul(input.position, gTransfomationMatrix.World).xyz;

	output.normal = normalize(mul(input.normal, (float32_t3x3)gTransfomationMatrix.WorldInverseTranspose));

	return output;
}
