<template>
	<Layout>
		<!-- ====== Hero Banner ====== -->
		<div style="width: 100%">
			<div class="index-page">
				<div data-am-widget="tabs" class="am-tabs am-tabs-default">
					<div class="am-tabs-bd">
						<div
							class="am-tab-panel am-active"
							style="background-image: url('/images/products/homeIndex.png')">
							<div class="index-banner">
								<div class="index-mask">
									<div class="container">
										<div class="am-g">
											<div class="am-u-md-10 am-u-sm-centered" style="text-align: center">
												<h1 class="slide_simple--title">{{ $t('index.heroTitle') }}</h1>
												<p class="slide_simple--text am-text-left" style="display: flex;justify-content: center">
													{{ $t('index.heroText') }}
												</p>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- ====== Main Business ====== -->
		<div class="section">
			<div class="container" style="max-width: 1160px;">
				<div class="section--header">
					<h2 class="section--title">{{ $t('index.bizTitle') }}</h2>
					<p class="section--description">{{ $t('index.bizDesc') }}</p>
				</div>

				<div class="biz-grid">
					<!-- Components -->
					<div class="biz-card">
						<div class="biz-card__badge">01</div>
						<h3 class="biz-card__title">
							<i class="am-icon-cogs"></i>
							{{ $t('index.biz1Title') }}
						</h3>
						<p class="biz-card__text">{{ $t('index.biz1Desc') }}</p>
						<div class="biz-card__tags">
							<span>CNC</span><span>Sheet Metal</span><span>Stamping</span><span>Welding</span>
						</div>
					</div>
					<!-- Communication Products -->
					<div class="biz-card">
						<div class="biz-card__badge">02</div>
						<h3 class="biz-card__title">
							<i class="am-icon-signal"></i>
							{{ $t('index.biz2Title') }}
						</h3>
						<p class="biz-card__text">{{ $t('index.biz2Desc') }}</p>
						<div class="biz-card__tags">
							<span>0.1-20GHz</span><span>Antenna</span><span>Microwave</span><span>64-Probe</span>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- ====== Hot Products Showcase ====== -->
		<div class="section">
			<div class="container" style="max-width: 1160px;">
				<div class="section--header">
					<h2 class="section--title">{{ $t('index.hotProductsTitle') }}</h2>
					<p class="section--description">{{ $t('index.hotProductsDesc') }}</p>
				</div>

				<div class="product-grid">
					<div class="product-item" v-for="(prod, i) in products" :key="'prod'+i">
						<div class="product-item__img" :style="{ backgroundImage: `url(${prod.img})` }"></div>
					</div>
				</div>
			</div>
		</div>

		<!-- ====== Equipment Showcase ====== -->
		<div class="section" style="background: linear-gradient(180deg, #f7faff 0%, #eef3fb 100%)">
			<div class="container" style="max-width: 1160px;">
				<div class="section--header">
					<h2 class="section--title">{{ $t('index.equipTitle') }}</h2>
					<p class="section--description">{{ $t('index.equipDesc') }}</p>
				</div>

				<div class="equip-grid">
					<div class="equip-item" v-for="(item, index) in equipList" :key="index">
						<div class="equip-item__img" :style="{ backgroundImage: `url(${item.img})` }">
							<div class="equip-item__overlay">
								<span class="equip-item__label">{{ item.label }}</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- ====== Partners ====== -->
		<div class="section">
			<div class="container" style="max-width: 1160px;">
				<div class="section--header">
					<h2 class="section--title">{{ $t('index.partnerTitle') }}</h2>
					<p class="section--description">{{ $t('index.partnerDesc') }}</p>
				</div>

				<div class="partner-grid">
					<div class="partner-card" v-for="(p, i) in partners" :key="i">
						<img v-if="p.img" :src="p.img" alt="partner logo" class="partner-logo">
						<span class="partner-en" v-if="!p.img">{{ p.en }}</span>
						<span class="partner-zh" v-if="!p.img && p.zh">{{ p.zh }}</span>
					</div>
				</div>
			</div>
		</div>

		<!-- ====== Motto ====== -->
		<div class="motto-section">
			<div class="container" style="max-width: 900px;">
				<div class="motto-icon">💎</div>
				<h2 class="motto-title">{{ $t('index.mottoTitle') }}</h2>
				<p class="motto-text">{{ $t('index.mottoText') }}</p>
			</div>
		</div>
	</Layout>
</template>

<script>
import Layout from "@/components/common/Layout";
export default {
	name: "IndexView",
	components: {Layout},
	data(){
		return{
			tabIndex: 0,
			slideshow:[],
			products: [
				{ img: '/images/products/prod_1.png' },
				{ img: '/images/products/prod_2.png' },
				{ img: '/images/products/prod_3.png' },
				{ img: '/images/products/prod_4.png' },
				{ img: '/images/products/prod_5.jpg' },
				{ img: '/images/products/prod_6.jpg' },
				{ img: '/images/products/prod_7.jpg' },
				{ img: '/images/products/prod_8.jpg' },
				{ img: '/images/products/prod_9.jpg' },
				{ img: '/images/products/prod_10.jpg' },
				{ img: '/images/products/prod_11.jpg' },
				{ img: '/images/products/prod_12.jpg' },
			],
			equipList: [
				{ label: 'CNC Punching', img: '/images/equip/equip_1.png' },
				{ label: 'Laser Cutting', img: '/images/equip/equip_2.png' },
				{ label: 'CNC Bending', img: '/images/equip/equip_3.png' },
				{ label: 'Robotic Welding', img: '/images/equip/equip_4.png' },
				{ label: 'CNC Lathe', img: '/images/equip/equip_5.png' },
				{ label: 'Hydraulic Press', img: '/images/equip/equip_6.png' },
			],
			partners: [
				{ en: 'CICT Mobile', zh: '中信科移动', img: '/images/partners/partner_1.png' },
				{ en: 'ZTE', zh: '中兴', img: '/images/partners/partner_2.png' },
				{ en: 'CETC', zh: '普天科技', img: '/images/partners/partner_3.png' },
				{ en: 'Comba', zh: '京信通信', img: '/images/partners/partner_4.png' },
				{ en: 'ZTT', zh: '中天科技', img: '/images/partners/partner_5.png' },
				{ en: 'TONGYU', zh: '通宇通讯', img: '/images/partners/partner_6.png' },
				{ en: 'FRD', zh: '', img: '/images/partners/partner_7.png' },
				{ en: 'GRENTECH', zh: '国人通信', img: '/images/partners/partner_8.png' },
				{ en: 'BROADRADIO', zh: '', img: '/images/partners/partner_9.png' },
				{ en: 'KBT', zh: '', img: '/images/partners/partner_10.png' },
				{ en: 'YUKE', zh: '邮科通信', img: '/images/partners/partner_11.png' },
				{ en: 'AFX', zh: '安飞信', img: '/images/partners/partner_12.png' },
			]
		}
	},
	mounted() {
		this.getSlideshow()
	},
	methods:{
		getSlideshow(){
			this.getRequest("/findAllSlideshow").then(resp =>{
				if (resp){
					this.slideshow = resp.data.data
				}
			})
		}
	},
}
</script>

<style scoped>
/* ====== Main Business Cards ====== */
.biz-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 28px;
	margin-top: 48px;
}

.biz-card {
	position: relative;
	background: #fff;
	border: 1px solid #eef2f7;
	border-radius: 20px;
	padding: 40px 32px 32px;
	transition: all 0.35s ease;
	overflow: hidden;
	box-shadow: 0 2px 12px rgba(0,0,0,0.03);
}

.biz-card:hover {
	transform: translateY(-6px);
	box-shadow: 0 20px 50px rgba(0,0,0,0.08);
	border-color: rgba(57, 195, 255, 0.25);
}

.biz-card__badge {
	position: absolute;
	top: 20px;
	right: 24px;
	font-size: 48px;
	font-weight: 900;
	color: rgba(57, 195, 255, 0.08);
	line-height: 1;
}

.biz-card__title {
	font-size: 22px;
	font-weight: 700;
	color: #1a2b42;
	margin-bottom: 16px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.biz-card__title i {
	width: 42px;
	height: 42px;
	border-radius: 12px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	font-size: 20px;
	background: linear-gradient(135deg, rgba(57, 195, 255, 0.12), rgba(111, 123, 255, 0.15));
	color: #2d6db5;
}

.biz-card__text {
	font-size: 15px;
	line-height: 1.85;
	color: #5a6d82;
	margin-bottom: 20px;
}

.biz-card__tags {
	display: flex;
	flex-wrap: wrap;
	gap: 8px;
}

.biz-card__tags span {
	padding: 5px 14px;
	border-radius: 999px;
	font-size: 12px;
	font-weight: 600;
	letter-spacing: 0.04em;
	background: linear-gradient(135deg, rgba(57, 195, 255, 0.08), rgba(111, 123, 255, 0.08));
	color: #2d6db5;
	border: 1px solid rgba(57, 195, 255, 0.15);
}

/* ====== Product Grid ====== */
.product-grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 20px;
	margin-top: 48px;
}

.product-item {
	border-radius: 12px;
	overflow: hidden;
	position: relative;
	background: #fff;
	border: 1px solid #eef2f7;
	transition: all 0.35s ease;
}

.product-item:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 30px rgba(0,0,0,0.06);
	border-color: rgba(57, 195, 255, 0.25);
}

.product-item__img {
	padding-bottom: 100%;
	background-size: contain;
	background-repeat: no-repeat;
	background-position: center;
	background-color: #fff;
}

/* ====== Equipment Grid ====== */
.equip-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 20px;
	margin-top: 48px;
}

.equip-item {
	border-radius: 16px;
	overflow: hidden;
	position: relative;
}

.equip-item__img {
	padding-bottom: 68%;
	background:
		linear-gradient(135deg, rgba(26, 58, 92, 0.06), rgba(45, 109, 181, 0.06)),
		url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect fill="%23f0f4f8" width="100" height="100"/><text x="50" y="52" text-anchor="middle" font-size="20" fill="%23c0cdd8">⚙</text></svg>');
	background-size: cover;
	background-position: center;
	position: relative;
	transition: all 0.35s ease;
}

.equip-item:hover .equip-item__img {
	transform: scale(1.03);
}

.equip-item__overlay {
	position: absolute;
	bottom: 0;
	left: 0;
	right: 0;
	padding: 16px 18px;
	background: linear-gradient(transparent, rgba(10, 22, 40, 0.7));
}

.equip-item__label {
	font-size: 14px;
	font-weight: 600;
	color: #fff;
	letter-spacing: 0.06em;
}

/* ====== Partners Grid ====== */
.partner-grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 20px;
	margin-top: 48px;
}

.partner-card {
	background: #fff;
	border: 1px solid #eef2f7;
	border-radius: 16px;
	padding: 30px 16px;
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: 6px;
	transition: all 0.35s ease;
	box-shadow: 0 2px 8px rgba(0,0,0,0.03);
}

.partner-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 14px 36px rgba(0,0,0,0.07);
	border-color: rgba(57, 195, 255, 0.28);
}

.partner-logo {
	max-width: 100%;
	height: 60px;
	object-fit: contain;
	margin: 0 auto;
}

.partner-en {
	font-size: 20px;
	font-weight: 800;
	letter-spacing: 0.06em;
	background: linear-gradient(135deg, #1a3a5c, #2d6db5);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
}

.partner-zh {
	font-size: 13px;
	color: #7a8da0;
	font-weight: 500;
	letter-spacing: 0.1em;
}

/* ====== Motto Section ====== */
.motto-section {
	padding: 80px 24px;
	text-align: center;
	background:
		radial-gradient(circle at 20% 50%, rgba(57, 195, 255, 0.06), transparent 40%),
		radial-gradient(circle at 80% 50%, rgba(111, 123, 255, 0.06), transparent 40%),
		linear-gradient(180deg, #f7faff, #eef3fb);
}

.motto-icon {
	font-size: 48px;
	margin-bottom: 16px;
}

.motto-title {
	font-size: 36px;
	font-weight: 700;
	color: #1a2b42;
	margin-bottom: 20px;
	letter-spacing: 0.04em;
}

.motto-text {
	font-size: 17px;
	line-height: 1.9;
	color: #5a6d82;
	max-width: 720px;
	margin: 0 auto;
}

/* ====== Responsive ====== */
@media screen and (max-width: 1024px) {
	.biz-grid { grid-template-columns: 1fr; }
	.product-grid { grid-template-columns: repeat(3, 1fr); }
	.equip-grid { grid-template-columns: repeat(2, 1fr); }
	.partner-grid { grid-template-columns: repeat(3, 1fr); }
}

@media screen and (max-width: 640px) {
	.product-grid { grid-template-columns: repeat(2, 1fr); gap: 12px; }
	.equip-grid { grid-template-columns: 1fr; gap: 12px; }
	.partner-grid { grid-template-columns: repeat(2, 1fr); gap: 12px; }
	.motto-title { font-size: 22px; }
	.motto-text { font-size: 14px; line-height: 1.7; }
	.motto-section { padding: 48px 16px; }
	.biz-card { padding: 24px 18px; }
	.biz-card__title { font-size: 18px; }
	.biz-card__text { font-size: 13px; line-height: 1.7; }
	.biz-card__tags span { font-size: 11px; padding: 4px 10px; }
	.partner-en { font-size: 16px; }
	.partner-zh { font-size: 11px; }
	.partner-card { padding: 20px 12px; }
}

@media screen and (max-width: 380px) {
	.partner-grid { grid-template-columns: 1fr; }
	.equip-grid { grid-template-columns: 1fr; }
	.biz-card__title { font-size: 16px; }
	.biz-card__title i { width: 32px; height: 32px; font-size: 16px; }
}
</style>
