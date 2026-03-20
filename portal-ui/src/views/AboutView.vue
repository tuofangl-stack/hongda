<template>
	<Layout>
		<!-- Page Header -->
		<div class="layout-container" style="width: 100%">
			<div class="page-header">
				<div class="container" style="text-align: center">
					<h1 class="page-header-title">{{ $t('about.pageTitle') }}</h1>
					<p class="page-header-subtitle">{{ $t('about.pageSubtitle') }}</p>
				</div>
			</div>
		</div>

		<!-- Company Profile -->
		<div class="section">
			<div class="container" style="max-width: 1160px">
				<div class="section--header">
					<h2 class="section--title">{{ $t('about.companyTitle') }}</h2>
				</div>

				<div class="about-profile">
					<p class="about-text">{{ $t('about.companyText1') }}</p>
					<p class="about-text">{{ $t('about.companyText2') }}</p>
					<p class="about-text about-text--highlight">{{ $t('about.companyText3') }}</p>

					<!-- Certifications -->
					<div class="cert-row">
						<div class="cert-badge">
							<span class="cert-icon">✅</span>
							<span>ISO 9001</span>
						</div>
						<div class="cert-badge">
							<span class="cert-icon">🌿</span>
							<span>ISO 14001</span>
						</div>
						<div class="cert-badge">
							<span class="cert-icon">🛡️</span>
							<span>ISO 45001</span>
						</div>
						<div class="cert-badge">
							<span class="cert-icon">🏆</span>
							<span>National High-tech</span>
						</div>
						<div class="cert-badge">
							<span class="cert-icon">⭐</span>
							<span>{{ $i18n.locale === 'zh' ? '专精特新' : 'SME Innovation' }}</span>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Philosophy & Culture -->
		<div class="section" style="background: linear-gradient(180deg, #f7faff 0%, #eef3fb 100%)">
			<div class="container" style="max-width: 1160px">
				<div class="values-grid">
					<div class="value-card">
						<div class="value-icon">🤝</div>
						<h3 class="value-title">{{ $t('about.philosophyTitle') }}</h3>
						<p class="value-text">{{ $t('about.philosophy') }}</p>
					</div>
					<div class="value-card">
						<div class="value-icon">💡</div>
						<h3 class="value-title">{{ $t('about.cultureTitle') }}</h3>
						<p class="value-text">{{ $t('about.culture') }}</p>
					</div>
				</div>
			</div>
		</div>

		<!-- Main Business -->
		<div class="section">
			<div class="container" style="max-width: 1160px">
				<div class="section--header">
					<h2 class="section--title">{{ $t('about.bizTitle') }}</h2>
				</div>

				<div class="biz-grid">
					<div class="biz-card">
						<div class="biz-num">01</div>
						<h3 class="biz-title"><i class="am-icon-cogs"></i> {{ $t('about.biz1Title') }}</h3>
						<p class="biz-desc">{{ $t('about.biz1Desc') }}</p>
					</div>
					<div class="biz-card">
						<div class="biz-num">02</div>
						<h3 class="biz-title"><i class="am-icon-signal"></i> {{ $t('about.biz2Title') }}</h3>
						<p class="biz-desc">{{ $t('about.biz2Desc') }}</p>
					</div>
				</div>
			</div>
		</div>
	</Layout>
</template>

<script>
import Layout from "@/components/common/Layout";
export default {
	name: "AboutView",
	components: {Layout}
}
</script>

<style scoped>
/* Profile Section */
.about-profile {
	max-width: 900px;
	margin: 40px auto 0;
}

.about-text {
	font-size: 16px;
	line-height: 2;
	color: #4a5b6e;
	margin-bottom: 20px;
	text-indent: 2em;
}

.about-text--highlight {
	position: relative;
	padding: 20px 24px;
	background: linear-gradient(135deg, rgba(57, 195, 255, 0.06), rgba(111, 123, 255, 0.06));
	border-left: 4px solid #2d6db5;
	border-radius: 0 12px 12px 0;
	font-weight: 500;
	color: #1a2b42;
}

/* Certifications */
.cert-row {
	display: flex;
	flex-wrap: wrap;
	gap: 14px;
	margin-top: 32px;
	justify-content: center;
}

.cert-badge {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	padding: 10px 20px;
	border-radius: 999px;
	background: #fff;
	border: 1px solid #e5ecf4;
	font-size: 14px;
	font-weight: 600;
	color: #2d6db5;
	box-shadow: 0 2px 8px rgba(0,0,0,0.03);
	transition: all 0.3s ease;
}

.cert-badge:hover {
	transform: translateY(-3px);
	box-shadow: 0 8px 20px rgba(0,0,0,0.06);
	border-color: rgba(57, 195, 255, 0.3);
}

.cert-icon {
	font-size: 18px;
}

/* Values Grid */
.values-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 28px;
}

.value-card {
	text-align: center;
	padding: 48px 32px;
	background: #fff;
	border-radius: 20px;
	border: 1px solid #eef2f7;
	box-shadow: 0 2px 12px rgba(0,0,0,0.03);
	transition: all 0.35s ease;
}

.value-card:hover {
	transform: translateY(-6px);
	box-shadow: 0 18px 44px rgba(0,0,0,0.07);
}

.value-icon {
	font-size: 48px;
	margin-bottom: 16px;
}

.value-title {
	font-size: 22px;
	font-weight: 700;
	color: #1a2b42;
	margin-bottom: 14px;
	letter-spacing: 0.04em;
}

.value-text {
	font-size: 18px;
	color: #5a6d82;
	line-height: 1.7;
	letter-spacing: 0.08em;
}

/* Business Grid */
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
	overflow: hidden;
	transition: all 0.35s ease;
	box-shadow: 0 2px 12px rgba(0,0,0,0.03);
}

.biz-card:hover {
	transform: translateY(-6px);
	box-shadow: 0 20px 50px rgba(0,0,0,0.08);
	border-color: rgba(57, 195, 255, 0.25);
}

.biz-num {
	position: absolute;
	top: 16px;
	right: 24px;
	font-size: 52px;
	font-weight: 900;
	color: rgba(57, 195, 255, 0.08);
	line-height: 1;
}

.biz-title {
	font-size: 20px;
	font-weight: 700;
	color: #1a2b42;
	margin-bottom: 16px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.biz-title i {
	width: 40px;
	height: 40px;
	border-radius: 12px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	font-size: 18px;
	background: linear-gradient(135deg, rgba(57, 195, 255, 0.12), rgba(111, 123, 255, 0.15));
	color: #2d6db5;
}

.biz-desc {
	font-size: 15px;
	line-height: 1.85;
	color: #5a6d82;
}

/* Responsive */
@media screen and (max-width: 640px) {
	.values-grid,
	.biz-grid {
		grid-template-columns: 1fr;
	}

	.cert-row {
		gap: 10px;
	}

	.cert-badge {
		padding: 8px 14px;
		font-size: 12px;
	}
}
</style>
