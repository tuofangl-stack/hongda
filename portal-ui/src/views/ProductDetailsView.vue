<template>
	<Layout>
		<div class="layout-container" style="width: 100%">
			<div class="page-header" v-if="product">
				<div class="container" style="text-align: center">
					<h1 class="page-header-title">{{ localeName(product.name) }}</h1>
					<p class="page-header-subtitle">{{ $t('productDetail.specSheet') }}</p>
				</div>
			</div>
		</div>

		<div class="section" v-if="product">
			<div class="container" style="max-width: 1000px">
				<!-- Product Overview: Image + Key Info -->
				<div class="detail-overview">
					<div class="detail-image">
						<img :src="product.cover" :alt="localeName(product.name)">
					</div>
					<div class="detail-summary">
						<h2 class="detail-product-name">{{ localeName(product.name) }}</h2>
						<div class="detail-meta" v-if="product.price && Number(product.price) > 0">
							<span class="detail-price">¥{{ Number(product.price).toLocaleString() }}</span>
						</div>
						<div class="detail-meta" v-if="product.sales">
							<span class="meta-label">{{ $t('productDetail.sold') }}:</span>
							<span>{{ product.sales }} {{ $t('productDetail.unit') }}</span>
						</div>
						<div class="detail-meta" v-if="product.views">
							<span class="meta-label">{{ $t('productDetail.views') }}:</span>
							<span>{{ product.views }} {{ $t('productDetail.times') }}</span>
						</div>
						<a class="detail-back-btn" @click="$router.push('/product')">
							← {{ $t('productDetail.backToList') }}
						</a>
					</div>
				</div>

				<!-- Spec Table -->
				<div class="spec-section">
					<h3 class="spec-title">
						<i class="am-icon-list-alt"></i>
						{{ $t('productDetail.specTitle') }}
					</h3>
					<table class="spec-table">
						<thead>
							<tr>
								<th>{{ $t('productDetail.parameter') }}</th>
								<th>{{ $t('productDetail.value') }}</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="(row, idx) in specRows" :key="idx">
								<td class="spec-label">{{ row.label }}</td>
								<td class="spec-value">{{ row.value }}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<!-- Loading -->
		<div v-if="!product" style="text-align:center;padding:120px 0;color:#999;">
			{{ $t('productDetail.loading') }}
		</div>
	</Layout>
</template>

<script>
import Layout from "@/components/common/Layout";
export default {
	name: "ProductDetailsView",
	components: {Layout},
	data(){
		return{
			product: null,
			specRows: []
		}
	},
	mounted() {
		this.getProductById(this.$route.params.productId)
	},
	methods:{
		localeName(name) {
			if (!name) return ''
			const parts = name.split('/')
			if (parts.length < 2) return name
			if (this.$i18n.locale === 'zh') return parts[0].trim()
			return parts[1].trim()
		},
		parseDescription(desc) {
			if (!desc) return []
			const lines = desc.split('\n').filter(l => l.trim())
			return lines.map(line => {
				// Each line format: "中文标签/EnLabel: value"
				const colonIdx = line.indexOf(':')
				if (colonIdx === -1) return { label: line, value: '' }
				const labelPart = line.substring(0, colonIdx).trim()
				const value = line.substring(colonIdx + 1).trim()
				// Split label by / for bilingual
				const labelParts = labelPart.split('/')
				let label
				if (labelParts.length >= 2) {
					label = this.$i18n.locale === 'zh' ? labelParts[0].trim() : labelParts[1].trim()
				} else {
					label = labelPart
				}
				return { label, value }
			})
		},
		getProductById(productId){
			this.getRequest(`/productDetail/${productId}`).then(resp =>{
				if (resp){
					const data = resp.data.data
					this.product = data
					this.specRows = this.parseDescription(data.description)
				}
			})
		}
	}
}
</script>

<style scoped>
.detail-overview {
	display: flex;
	gap: 48px;
	margin-top: 48px;
	margin-bottom: 48px;
	align-items: flex-start;
}

.detail-image {
	flex: 0 0 380px;
	background: #fff;
	border-radius: 16px;
	border: 1px solid #eef2f7;
	overflow: hidden;
	box-shadow: 0 4px 20px rgba(0,0,0,0.05);
}

.detail-image img {
	width: 100%;
	height: auto;
	display: block;
}

.detail-summary {
	flex: 1;
	padding-top: 12px;
}

.detail-product-name {
	font-size: 28px;
	font-weight: 700;
	color: #1a2b42;
	margin-bottom: 24px;
	line-height: 1.4;
}

.detail-meta {
	font-size: 16px;
	color: #5a6d82;
	margin-bottom: 12px;
	display: flex;
	align-items: center;
	gap: 8px;
}

.meta-label {
	font-weight: 600;
	color: #3a4b5e;
}

.detail-price {
	font-size: 32px;
	font-weight: 700;
	color: #e74c3c;
}

.detail-back-btn {
	display: inline-block;
	margin-top: 24px;
	padding: 10px 24px;
	background: linear-gradient(135deg, #2d6db5, #4a9eff);
	color: #fff;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s ease;
	text-decoration: none;
}

.detail-back-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 20px rgba(45, 109, 181, 0.3);
}

/* Spec Section */
.spec-section {
	margin-bottom: 64px;
}

.spec-title {
	font-size: 22px;
	font-weight: 700;
	color: #1a2b42;
	margin-bottom: 24px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.spec-title i {
	width: 36px;
	height: 36px;
	border-radius: 10px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	font-size: 16px;
	background: linear-gradient(135deg, rgba(57, 195, 255, 0.12), rgba(111, 123, 255, 0.15));
	color: #2d6db5;
}

.spec-table {
	width: 100%;
	border-collapse: collapse;
	background: #fff;
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 2px 12px rgba(0,0,0,0.04);
	border: 1px solid #eef2f7;
}

.spec-table thead th {
	background: linear-gradient(135deg, #1a2b42, #2d3e54);
	color: #fff;
	font-size: 15px;
	font-weight: 600;
	padding: 14px 20px;
	text-align: left;
}

.spec-table thead th:first-child {
	width: 40%;
}

.spec-table tbody tr {
	transition: background 0.2s ease;
}

.spec-table tbody tr:nth-child(even) {
	background: #f9fbfd;
}

.spec-table tbody tr:hover {
	background: rgba(57, 195, 255, 0.06);
}

.spec-table td {
	padding: 13px 20px;
	font-size: 15px;
	border-bottom: 1px solid #f0f3f7;
}

.spec-label {
	font-weight: 600;
	color: #2d3e54;
}

.spec-value {
	color: #5a6d82;
}

/* Responsive */
@media screen and (max-width: 768px) {
	.detail-overview {
		flex-direction: column;
		gap: 24px;
	}

	.detail-image {
		flex: none;
		width: 100%;
	}

	.detail-product-name {
		font-size: 22px;
	}
}
</style>
