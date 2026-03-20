<template>
	<div class="header-wrapper">
		<div class="header" :class="{ 'header--compact': isScrolled }">
			<div class="header-left">
				<div class="brand-mark">
					<img src="../../../assets/images/hongdalogo.png" alt="Tiannuo">
				</div>
				<div class="brand-copy">
					<span class="brand-copy__eyebrow">TIANNUO COMMUNICATION</span>
					<strong>{{ $t('header.brandSlogan') }}</strong>
					<p>{{ $t('header.brandDesc') }}</p>
				</div>
			</div>
			<div class="header-mid">
				<div class="header-item">
					<span class="contact-icon am-icon-phone"></span>
					<div class="item">
						<span class="item-label">{{ $t('header.hotline') }}</span>
						<strong>15111129199</strong>
						<span>{{ $t('header.hotlineTime') }}</span>
					</div>
				</div>
				<div class="header-item">
					<span class="contact-icon am-icon-map-marker"></span>
					<div class="item">
						<span class="item-label">{{ $t('header.factory') }}</span>
						<strong>{{ $t('header.factoryAddr') }}</strong>
						<span>{{ $t('header.factoryName') }}</span>
					</div>
				</div>
			</div>
			<div class="header-right">
				<a href="tel:+15111129199" class="header-cta">{{ $t('header.contactUs') }}</a>
				<div class="lang-switcher">
					<span class="lang-btn" @click="langOpen = !langOpen">🌐 {{ $t('lang.' + $i18n.locale) }} ▾</span>
					<ul class="lang-dropdown" v-show="langOpen">
						<li @click="switchLang('en')" :class="{ active: $i18n.locale === 'en' }">English</li>
						<li @click="switchLang('zh')" :class="{ active: $i18n.locale === 'zh' }">中文</li>
						<li @click="switchLang('fr')" :class="{ active: $i18n.locale === 'fr' }">Français</li>
					</ul>
				</div>
			</div>
		</div>

		<div class="nav-wrapper header-default" :class="{ sticky: isScrolled }">
			<div class="nav">
				<ul class="am-nav am-nav-pills am-nav-justify">
					<li><router-link class="router" to="/index">{{ $t('nav.home') }}</router-link></li>
					<li><router-link class="router" to="/product">{{ $t('nav.products') }}</router-link></li>
					<li><router-link class="router" to="/example">{{ $t('nav.cases') }}</router-link></li>
					<li><router-link class="router" to="/news">{{ $t('nav.news') }}</router-link></li>
					<li><router-link class="router" to="/about">{{ $t('nav.about') }}</router-link></li>
				</ul>
			</div>
		</div>
	</div>
</template>

<script>
export default {
	name: "Header",
	data(){
		return{
			isScrolled: false,
			langOpen: false,
		}
	},
	methods: {
		toggleStickyHeader() {
			const scrolled = document.documentElement.scrollTop || document.body.scrollTop;
			this.isScrolled = scrolled > 100;
		},
		switchLang(lang) {
			this.$i18n.locale = lang
			localStorage.setItem('portal_lang', lang)
			this.langOpen = false
		}
	},
	created() {
		window.addEventListener('scroll', this.toggleStickyHeader);
		// close lang dropdown on outside click
		document.addEventListener('click', (e) => {
			if (!e.target.closest('.lang-switcher')) this.langOpen = false
		})
	},
	mounted() {
		this.toggleStickyHeader();
	},
	beforeDestroy() {
		window.removeEventListener('scroll', this.toggleStickyHeader);
	}
}
</script>

<style scoped>
.header-wrapper{
	position: relative;
	z-index: 20;
	width: 100%;
}

.header{
	max-width: 1240px;
	margin: 0 auto;
	padding: 12px 20px 10px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 16px;
	transition: transform .3s ease, opacity .3s ease;
}

.header--compact{
	transform: translateY(-6px);
}

.header-left{
	display: flex;
	align-items: center;
	gap: 12px;
	min-width: 0;
}

.brand-mark{
	width: 52px;
	height: 52px;
	border-radius: 10px;
	background: #ffffff;
	border: none;
	box-shadow: 0 4px 14px rgba(0, 0, 0, 0.15);
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 4px;
	overflow: hidden;
}

.brand-mark img{
	width: 100%;
	height: auto;
}

.brand-copy{
	display: flex;
	flex-direction: column;
	gap: 1px;
	color: #dbe7ff;
}

.brand-copy__eyebrow{
	font-size: 10px;
	letter-spacing: .22em;
	text-transform: uppercase;
	color: rgba(135, 192, 255, 0.72);
}

.brand-copy strong{
	font-size: 16px;
	line-height: 1.3;
	color: #ffffff;
}

.brand-copy p{
	margin: 0;
	font-size: 11px;
	line-height: 1.5;
	color: rgba(219, 231, 255, 0.68);
}

.header-mid{
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
	flex-wrap: wrap;
}

.header-item{
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 8px 14px;
	border-radius: 14px;
	background: rgba(7, 18, 32, 0.6);
	border: 1px solid rgba(120, 154, 255, 0.18);
	box-shadow: 0 6px 16px rgba(5, 12, 24, 0.1);
	backdrop-filter: blur(14px);
}

.contact-icon{
	width: 34px;
	height: 34px;
	border-radius: 10px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	font-size: 16px;
	background: linear-gradient(135deg, rgba(65, 176, 255, 0.18), rgba(122, 100, 255, 0.24));
	color: #88d4ff;
	box-shadow: inset 0 1px 0 rgba(255,255,255,.08);
}

.item{
	display: flex;
	flex-direction: column;
	gap: 2px;
}

.item-label{
	font-size: 10px;
	letter-spacing: .14em;
	text-transform: uppercase;
	color: rgba(147, 176, 221, 0.72);
}

.item strong{
	font-size: 14px;
	color: #f7fbff;
}

.item span{
	font-size: 11px;
	line-height: 1.4;
	color: rgba(208, 221, 241, 0.72);
}

.header-right{
	flex-shrink: 0;
	display: flex;
	align-items: center;
	gap: 8px;
}

.lang-switcher {
	position: relative;
}

.lang-btn {
	display: inline-flex;
	align-items: center;
	padding: 7px 12px;
	border-radius: 999px;
	background: rgba(7, 18, 32, 0.6);
	border: 1px solid rgba(120, 154, 255, 0.18);
	color: rgba(226, 235, 255, 0.85);
	font-size: 12px;
	cursor: pointer;
	transition: all 0.3s ease;
	backdrop-filter: blur(14px);
	letter-spacing: 0.04em;
}

.lang-btn:hover {
	background: rgba(7, 18, 32, 0.8);
	border-color: rgba(120, 154, 255, 0.36);
}

.lang-dropdown {
	position: absolute;
	top: calc(100% + 6px);
	right: 0;
	list-style: none;
	margin: 0;
	padding: 6px 0;
	min-width: 140px;
	background: rgba(10, 20, 38, 0.95);
	border: 1px solid rgba(120, 154, 255, 0.2);
	border-radius: 12px;
	box-shadow: 0 12px 30px rgba(0,0,0,0.3);
	backdrop-filter: blur(18px);
	z-index: 10000;
}

.lang-dropdown li {
	padding: 10px 18px;
	font-size: 14px;
	color: rgba(226, 235, 255, 0.75);
	cursor: pointer;
	transition: all 0.2s;
}

.lang-dropdown li:hover {
	background: rgba(57, 195, 255, 0.1);
	color: #fff;
}

.lang-dropdown li.active {
	color: #39c3ff;
	font-weight: 600;
}

.header-cta{
	display: inline-flex;
	align-items: center;
	justify-content: center;
	padding: 9px 20px;
	border-radius: 999px;
	background: linear-gradient(135deg, #39c3ff 0%, #6f7bff 100%);
	box-shadow: 0 8px 20px rgba(65, 149, 255, 0.22);
	color: #fff;
	font-size: 13px;
	font-weight: 600;
	letter-spacing: .06em;
	text-decoration: none;
	transition: transform .3s ease, box-shadow .3s ease, filter .3s ease;
}

.header-cta:hover{
	transform: translateY(-3px);
	box-shadow: 0 22px 40px rgba(65, 149, 255, 0.32);
	filter: brightness(1.05);
}

.nav-wrapper{
	width: calc(100% - 48px);
	max-width: 1240px;
	margin: 0 auto;
	border: 1px solid rgba(122, 148, 193, 0.14);
	border-radius: 24px;
	background: rgba(7, 18, 32, 0.58);
	box-shadow: 0 12px 28px rgba(5, 12, 24, 0.14);
	backdrop-filter: blur(18px);
	transition: transform .3s ease, background-color .3s ease, box-shadow .3s ease, border-color .3s ease;
}

.nav{
	max-width: 1180px;
	margin: 0 auto;
	padding: 0 18px;
}

.nav .am-nav li{
	padding: 20px 0;
}

.nav .am-nav li .router{
	position: relative;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	padding: 0;
	font-size: 15px;
	font-weight: 600;
	letter-spacing: .08em;
	color: rgba(226, 235, 255, 0.76);
	background: transparent !important;
	transition: color .3s ease, transform .3s ease;
}

.nav .am-nav li .router::after{
	content: "";
	position: absolute;
	left: 50%;
	bottom: -12px;
	width: 0;
	height: 3px;
	border-radius: 999px;
	background: linear-gradient(135deg, #39c3ff 0%, #6f7bff 100%);
	box-shadow: 0 0 16px rgba(91, 161, 255, 0.48);
	transform: translateX(-50%);
	transition: width .3s ease;
}

.nav .am-nav li .router:hover,
.router.router-link-active{
	color: #ffffff;
	transform: translateY(-2px);
}

.nav .am-nav li .router:hover::after,
.router.router-link-active::after{
	width: 100%;
}

.sticky{
	position: fixed;
	top: 18px;
	left: 50%;
	transform: translateX(-50%);
	z-index: 9999;
	background: rgba(6, 16, 30, 0.86);
	border-color: rgba(109, 140, 255, 0.26);
	box-shadow: 0 24px 48px rgba(4, 10, 20, 0.28);
}

@media screen and (max-width: 1024px) {
	.header{
		padding: 18px 18px 16px;
		flex-direction: column;
		align-items: stretch;
	}

	.header-left,
	.header-mid{
		justify-content: center;
	}

	.header-right{
		align-self: center;
	}

	.nav-wrapper{
		width: calc(100% - 32px);
	}
}

@media screen and (max-width: 640px) {
	.header{
		padding: 16px 14px 14px;
		gap: 16px;
	}

	.header-left{
		flex-direction: column;
		text-align: center;
	}

	.brand-mark{
		width: 64px;
		height: 64px;
	}

	.brand-copy strong{
		font-size: 18px;
	}

	.brand-copy p{
		font-size: 12px;
	}

	.header-mid{
		width: 100%;
		gap: 12px;
	}

	.header-item{
		width: 100%;
		justify-content: flex-start;
	}

	.nav-wrapper{
		width: calc(100% - 20px);
		border-radius: 18px;
	}

	.nav{
		padding: 0 6px;
	}

	.nav .am-nav li{
		padding: 14px 0;
	}

	.nav .am-nav li .router{
		font-size: 13px;
		letter-spacing: .03em;
	}

	.sticky{
		top: 10px;
	}
}
</style>
