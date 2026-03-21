<template>
	<Layout>
		<div class="layout-container" style="width: 100%">
			<div class="page-header">
				<div class="container" style="text-align: center">
					<h1 class="page-header-title">{{ $t('product.pageTitle') }}</h1>
					<p class="page-header-subtitle">{{ $t('product.pageSubtitle') }}</p>
				</div>
			</div>
		</div>
		
		<div class="section">
			<div class="container" style="max-width: 1160px">
				<div class="section--header">
					<h2 class="section--title">{{ $t('product.sectionTitle') }}</h2>
					<p class="section--description">{{ $t('product.sectionDesc') }}</p>
				</div>
				
				<!-- Google-style chip tabs -->
				<div class="chip-tabs-wrapper">
					<div class="chip-tabs">
						<button
							class="chip"
							:class="{ 'chip--active': selectedType === -1 }"
							@click="changeTab(-1)"
						>{{ $t('product.tabAll') }}</button>
						<button
							v-for="(tab, index) in tabList"
							:key="index"
							class="chip"
							:class="{ 'chip--active': selectedType === tab.typeId }"
							@click="changeTab(tab.typeId)"
						>{{ localeName(tab.typeName) }}</button>
					</div>
				</div>

				<!-- Product Grid -->
				<div class="product-grid" v-if="goodsList.length > 0">
					<div
						class="product-card"
						v-for="(goods, index) in goodsList"
						:key="index"
						@click="handleDetails(goods.productId)"
					>
						<div class="product-card__img-wrap">
							<img :src="goods.cover" :alt="localeName(goods.name)" />
						</div>
						<div class="product-card__body">
							<h3 class="product-card__name">{{ localeName(goods.name) }}</h3>
						</div>
					</div>
				</div>
				<div v-else class="product-empty">
					<i class="am-icon-inbox"></i>
					<p>{{ $t('product.noProducts') }}</p>
				</div>
			</div>
		</div>
		
	</Layout>
</template>

<script>
import Layout from "@/components/common/Layout";
export default {
	name: "ProductView",
	components: {Layout},
	data(){
		return{
			tabList:[],
			selectedType: -1,
			goodsList:[],
		}
	},
	mounted() {
		this.getTabList()
		this.getAllProducts()
	},
	methods:{
		localeName(name) {
			if (!name) return ''
			const parts = name.split('/')
			if (parts.length < 2) return name
			if (this.$i18n.locale === 'zh') return parts[0].trim()
			return parts[1].trim()
		},
		getTabList(){
			this.getRequest("/findAllType").then(resp =>{
				if (resp){
					this.tabList = resp.data.data
				}
			})
		},
		changeTab(typeId){
			this.selectedType = typeId
			if (typeId === -1) {
				this.getAllProducts()
			} else {
				this.getProductsByType(typeId)
			}
		},
		getAllProducts(){
			this.getRequest("/productList").then(resp =>{
				if (resp){
					this.goodsList = resp.data.data
				}
			})
		},
		getProductsByType(typeId){
			this.getRequest(`/productListByType/${typeId}`).then(resp =>{
				if (resp){
					this.goodsList = resp.data.data
				}
			})
		},
		handleDetails(productId){
			this.$router.push({path:`/product/productId/${productId}`})
		}
	}
}
</script>

<style scoped>
/* ====== Chip Tabs (Google Style) ====== */
.chip-tabs-wrapper {
	margin: 32px 0 40px;
	overflow-x: auto;
	-webkit-overflow-scrolling: touch;
	scrollbar-width: none;
}

.chip-tabs-wrapper::-webkit-scrollbar {
	display: none;
}

.chip-tabs {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 10px;
	padding: 0 4px;
}

.chip {
	display: inline-flex;
	align-items: center;
	padding: 10px 22px;
	border-radius: 999px;
	border: 1.5px solid #dadce0;
	background: #fff;
	color: #3c4043;
	font-size: 14px;
	font-weight: 500;
	cursor: pointer;
	transition: all 0.2s ease;
	white-space: nowrap;
	letter-spacing: 0.01em;
	outline: none;
	box-shadow: 0 1px 3px rgba(0,0,0,0.04);
}

.chip:hover {
	background: #f1f3f4;
	border-color: #c6c9cc;
	box-shadow: 0 1px 4px rgba(0,0,0,0.08);
}

.chip--active {
	background: linear-gradient(135deg, #1a73e8, #4285f4);
	color: #fff;
	border-color: transparent;
	box-shadow: 0 2px 8px rgba(26, 115, 232, 0.3);
}

.chip--active:hover {
	background: linear-gradient(135deg, #1765cc, #3b78e0);
	border-color: transparent;
	box-shadow: 0 3px 12px rgba(26, 115, 232, 0.35);
}

/* ====== Product Grid ====== */
.product-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 24px;
}

.product-card {
	background: #fff;
	border-radius: 16px;
	border: 1px solid #e8eaed;
	overflow: hidden;
	cursor: pointer;
	transition: all 0.25s ease;
	box-shadow: 0 1px 4px rgba(0,0,0,0.04);
}

.product-card:hover {
	transform: translateY(-4px);
	box-shadow: 0 8px 28px rgba(0,0,0,0.1);
	border-color: #d2e3fc;
}

/* Use padding-bottom hack instead of aspect-ratio for compatibility */
.product-card__img-wrap {
	width: 100%;
	height: 0;
	padding-bottom: 80%;
	position: relative;
	overflow: hidden;
	background: linear-gradient(145deg, #f8f9fa, #eef1f5);
}

.product-card__img-wrap img {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	max-width: 85%;
	max-height: 85%;
	width: auto;
	height: auto;
	object-fit: contain;
	transition: transform 0.35s ease;
}

.product-card:hover .product-card__img-wrap img {
	transform: translate(-50%, -50%) scale(1.06);
}

.product-card__body {
	padding: 14px 16px 18px;
	text-align: center;
}

.product-card__name {
	font-size: 14px;
	font-weight: 600;
	color: #202124;
	margin: 0;
	line-height: 1.5;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
}

/* ====== Empty State ====== */
.product-empty {
	text-align: center;
	padding: 80px 0;
	color: #9aa0a6;
}

.product-empty i {
	font-size: 56px;
	display: block;
	margin-bottom: 12px;
}

.product-empty p {
	font-size: 15px;
	margin: 0;
}

/* ====== Responsive ====== */
@media screen and (max-width: 1024px) {
	.product-grid {
		grid-template-columns: repeat(3, 1fr);
		gap: 16px;
	}
}

@media screen and (max-width: 768px) {
	.chip-tabs-wrapper {
		margin: 14px 0 14px !important;
	}

	.chip-tabs {
		flex-wrap: nowrap !important;
		justify-content: flex-start !important;
		gap: 8px !important;
		padding: 0 12px !important;
	}

	.chip {
		padding: 7px 14px !important;
		font-size: 12px !important;
		flex-shrink: 0 !important;
	}

	/* Amazon-style: 2 columns, compact square cards */
	.product-grid {
		grid-template-columns: repeat(2, 1fr) !important;
		gap: 8px !important;
		padding: 0 !important;
	}

	.product-card {
		border-radius: 8px !important;
		display: block !important;
		border: 1px solid #e0e0e0 !important;
		box-shadow: none !important;
	}

	.product-card:hover {
		transform: none !important;
		box-shadow: none !important;
	}

	.product-card__img-wrap {
		width: 100% !important;
		height: 0 !important;
		padding-bottom: 100% !important;
		position: relative !important;
		overflow: hidden !important;
		background: #fff !important;
	}

	.product-card__img-wrap img {
		position: absolute !important;
		top: 50% !important;
		left: 50% !important;
		transform: translate(-50%, -50%) !important;
		width: auto !important;
		height: auto !important;
		max-width: 80% !important;
		max-height: 80% !important;
		object-fit: contain !important;
		padding: 0 !important;
	}

	.product-card:hover .product-card__img-wrap img {
		transform: translate(-50%, -50%) !important;
	}

	.product-card__body {
		padding: 8px 10px 12px !important;
		text-align: left !important;
		display: block !important;
		border-top: 1px solid #f0f0f0;
	}

	.product-card__name {
		font-size: 13px !important;
		font-weight: 500 !important;
		line-height: 1.4 !important;
		color: #0f1111 !important;
		-webkit-line-clamp: 2 !important;
		display: -webkit-box !important;
		-webkit-box-orient: vertical !important;
		overflow: hidden !important;
	}
}

@media screen and (max-width: 480px) {
	.chip {
		padding: 6px 11px !important;
		font-size: 11px !important;
	}

	.product-card__img-wrap {
		padding-bottom: 90% !important;
	}

	.product-card__body {
		padding: 6px 8px 10px !important;
	}

	.product-card__name {
		font-size: 12px !important;
	}
}
</style>

