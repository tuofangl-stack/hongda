<template>
	<Layout>
		<div class="gallery-box" v-if="product">
			
			<div class="layout-container" style="width: 100%">
				<div class="solution-page">
					<div class="container">
						<h2>{{product.name}}</h2>
						<p>{{product.description}}</p>
					</div>
				</div>
			</div>
			
			<div class="gallery" v-if="photos.length > 0">
				<div class="active-photo" :style="'background-image: url('+ photos[activePhoto]+');'">
					<button type="button"
						aria-label="Previous Photo"
						class="previous"
						@click="previousPhoto()">
						◀
					</button>
					<button type="button"
						aria-label="Next Photo"
						class="next"
						@click="nextPhoto()">
						▶
					</button>
				</div>
				<div class="thumbnails">
					<div v-for="(photo, index) in photos"
						:key="index"
						:src="photo"
						@click="activePhoto = index"
						:class="{'active': activePhoto === index}"
						:style="'background-image: url('+photo+')'">
					</div>
				</div>
			</div>

			<div class="product-info" v-if="product.price">
				<span class="product-detail-price">¥{{Number(product.price).toLocaleString()}}</span>
				<span class="product-detail-sales" v-if="product.sales">{{ $t('productDetail.sold') }} {{product.sales}} {{ $t('productDetail.unit') }}</span>
				<span class="product-detail-views" v-if="product.views">{{ $t('productDetail.views') }} {{product.views}} {{ $t('productDetail.times') }}</span>
			</div>
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
			activePhoto: 0,
			photos: []
		}
	},
	mounted() {
		this.getProductById(this.$route.params.productId)
	},
	methods:{
		getProductById(productId){
			this.getRequest(`/productDetail/${productId}`).then(resp =>{
				if (resp){
					const data = resp.data.data
					this.product = data
					
					// 构建图片列表
					const photos = [];
					if (data.cover) photos.push(data.cover)
					// 解析images JSON数组
					if (data.images) {
						try {
							const imgs = JSON.parse(data.images)
							imgs.forEach(img => {
								if (img && !photos.includes(img)) photos.push(img)
							})
						} catch(e) {
							// images不是JSON，当作单个URL
							if (!photos.includes(data.images)) photos.push(data.images)
						}
					}
					this.photos = photos
				}
			})
		},
		nextPhoto () {
			this.activePhoto = ( this.activePhoto+1 < this.photos.length ? this.activePhoto+1 : 0 )
		},
		previousPhoto () {
			this.activePhoto = ( this.activePhoto-1 >= 0 ? this.activePhoto-1 : this.photos.length-1 )
		}
	}
}
</script>

<style scoped>
* { outline: none; box-sizing: border-box; }

.gallery-box {
	display: flex;
	flex-direction: column;
	align-items: center;
	overflow: auto;
	text-align: center;
	width: 100%;
}

.gallery-box .gallery {
	width: 80%;
	display: flex;
	flex-direction: column;
	background-color: #ffffff;
	padding: 4px 4px 6px;
	border-radius: 8px;
	margin-bottom: 30px;
}
.gallery-box .gallery .active-photo {
	width: 100%;
	margin-bottom: 5px;
	padding-bottom: 65%;
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
	border: 2px solid #fff;
	position: relative;
}

.gallery-box .gallery .active-photo button {
	border: none;
	background-color: transparent;
	font-size: 30px;
	color: #59bcdb;
	opacity: 0.5;
	position: absolute;
	outline: none;
	height: 100%;
}

.gallery-box .gallery .active-photo:hover { opacity: 1; }
.gallery-box .gallery .active-photo .previous {
	padding: 0 1em 0 0.7em;
	left: 0;
	background: linear-gradient(to right, rgba(0,0,0,0.5) 0%,rgba(0,0,0,0) 100%);
}
.gallery-box .gallery .active-photo .next {
	padding: 0 0.7em 0 1em;
	right: 0;
	background: linear-gradient(to right, rgba(0,0,0,0) 0%,rgba(0,0,0,0.5) 100%);
}

.gallery-box .gallery .thumbnails {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
	grid-gap: 4px;
}
.thumbnails div {
	border: 2px solid #fff;
	outline: 2px solid #fff;
	cursor: pointer;
	padding-bottom: 65%;
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
}
.thumbnails .active { outline-color: #59bcdb; opacity: 0.6; }

.product-info {
	display: flex;
	gap: 24px;
	align-items: baseline;
	padding: 16px 0 40px;
}
.product-detail-price {
	font-size: 28px;
	font-weight: 700;
	color: #e74c3c;
}
.product-detail-sales,
.product-detail-views {
	font-size: 14px;
	color: #999;
}
</style>
