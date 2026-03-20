<template>
	<Layout>
		<div class="layout-container" style="width: 100%">
			<div class="page-header">
				<div class="container" style="text-align: center">
					<h1 class="page-header-title">{{ $t('example.pageTitle') }}</h1>
					<p class="page-header-subtitle">{{ $t('example.pageSubtitle') }}</p>
				</div>
			</div>
		</div>
		
		<div class="section">
			<div class="container" style="max-width: 1160px; margin: 0 auto">
				<div class="section--header">
					<h2 class="section--title">{{ $t('example.sectionTitle') }}</h2>
					<p class="section--description">{{ $t('example.sectionDesc') }}</p>
				</div>
				
				<div class="partner-grid">
					<div class="partner-card" v-for="(partner, index) in partners" :key="index">
						<div class="partner-logo">
							<span class="partner-name-en">{{ partner.nameEn }}</span>
							<span class="partner-name-zh" v-if="partner.nameZh">{{ partner.nameZh }}</span>
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
	name: "ExampleView",
	components: {Layout},
	data(){
		return{
			partners: [
				{ nameEn: 'CICT Mobile', nameZh: '中信科移动' },
				{ nameEn: 'ZTE', nameZh: '中兴' },
				{ nameEn: 'CETC', nameZh: '普天科技' },
				{ nameEn: 'Comba', nameZh: '京信通信' },
				{ nameEn: 'ZTT', nameZh: '中天科技' },
				{ nameEn: 'TONGYU', nameZh: '通宇通讯' },
				{ nameEn: 'FRD', nameZh: '' },
				{ nameEn: 'GRENTECH', nameZh: '国人通信' },
				{ nameEn: 'BROADRADIO', nameZh: '' },
				{ nameEn: 'KBT', nameZh: '' },
				{ nameEn: 'YUKE', nameZh: '邮科通信' },
				{ nameEn: 'AFX', nameZh: '安飞信' },
			]
		}
	}
}
</script>

<style scoped>
.partner-grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 24px;
	margin-top: 48px;
}

.partner-card {
	background: #fff;
	border: 1px solid #eef2f7;
	border-radius: 16px;
	padding: 36px 20px;
	display: flex;
	align-items: center;
	justify-content: center;
	transition: all 0.35s ease;
	cursor: default;
	box-shadow: 0 2px 8px rgba(0,0,0,0.03);
}

.partner-card:hover {
	transform: translateY(-6px);
	box-shadow: 0 16px 40px rgba(0,0,0,0.08);
	border-color: rgba(57, 195, 255, 0.3);
}

.partner-logo {
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: 8px;
	text-align: center;
}

.partner-name-en {
	font-size: 22px;
	font-weight: 800;
	letter-spacing: 0.08em;
	background: linear-gradient(135deg, #1a3a5c, #2d6db5);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
}

.partner-name-zh {
	font-size: 14px;
	color: #6b7c93;
	font-weight: 500;
	letter-spacing: 0.12em;
}

@media screen and (max-width: 1024px) {
	.partner-grid {
		grid-template-columns: repeat(3, 1fr);
		gap: 18px;
	}
}

@media screen and (max-width: 640px) {
	.partner-grid {
		grid-template-columns: repeat(2, 1fr);
		gap: 14px;
	}
	.partner-card {
		padding: 24px 14px;
	}
	.partner-name-en {
		font-size: 16px;
	}
}
</style>
