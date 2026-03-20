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
				
				<div class="solution-container">
					<div data-am-widget="tabs" class="am-tabs">
						<ul class="am-tabs-nav am-cf">
							<li @click.prevent="changeTab(-1)"
								:class="selectedType === -1 ? 'am-active':''">
								<a href="#">{{ $t('product.tabAll') }}</a>
							</li>
							<li v-for="(tab,index) in tabList"
								:key="index"
								@click.prevent="changeTab(tab.typeId)"
								:class="selectedType === tab.typeId ? 'am-active':''">
								<a href="#">{{ localeName(tab.typeName) }}</a>
							</li>
						</ul>
						<div class="am-tabs-bd">
							<div class="am-tabs-tab">
								<div class="am-tab"
									v-for="(goods,index) in goodsList"
									:key="index"
									@click="handleDetails(goods.productId)">
									<img :src="goods.cover" alt="">
									<p>{{ localeName(goods.name) }}</p>
								</div>
							</div>
							<div v-if="goodsList.length === 0" style="text-align:center;padding:60px 0;color:#999;">
								{{ $t('product.noProducts') }}
							</div>
						</div>
					</div>
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
.product-price {
	display: block;
	color: #e74c3c;
	font-weight: 600;
	font-size: 14px;
	margin-top: 4px;
}
</style>
