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

.product-card__img-wrap {
	width: 100%;
	aspect-ratio: 1 / 1;
	overflow: hidden;
	background: linear-gradient(145deg, #f8f9fa, #eef1f5);
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 16px;
}

.product-card__img-wrap img {
	max-width: 100%;
	max-height: 100%;
	object-fit: contain;
	transition: transform 0.35s ease;
}

.product-card:hover .product-card__img-wrap img {
	transform: scale(1.06);
}

.product-card__body {
	padding: 16px 18px 20px;
	text-align: center;
}

.product-card__name {
	font-size: 15px;
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
		margin: 20px 0 24px;
	}

	.chip-tabs {
		flex-wrap: nowrap;
		justify-content: flex-start;
		gap: 8px;
		padding: 0 16px;
	}

	.chip {
		padding: 8px 18px;
		font-size: 13px;
		flex-shrink: 0;
	}

	.product-grid {
		grid-template-columns: repeat(2, 1fr);
		gap: 12px;
	}

	.product-card {
		border-radius: 12px;
	}

	.product-card__img-wrap {
		aspect-ratio: 4 / 3;
		padding: 10px;
	}

	.product-card__body {
		padding: 10px 10px 14px;
	}

	.product-card__name {
		font-size: 12px;
		line-height: 1.4;
	}
}

@media screen and (max-width: 480px) {
	.chip {
		padding: 7px 14px;
		font-size: 12px;
	}

	.product-grid {
		grid-template-columns: repeat(2, 1fr);
		gap: 10px;
	}

	.product-card__img-wrap {
		aspect-ratio: 1 / 0.85;
		padding: 8px;
	}

	.product-card__body {
		padding: 8px 8px 12px;
	}

	.product-card__name {
		font-size: 11px;
	}

	.product-empty {
		padding: 50px 0;
	}

	.product-empty i {
		font-size: 40px;
	}
}
</style>
