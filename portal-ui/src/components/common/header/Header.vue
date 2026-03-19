<template>
	<div class="header-wrapper">
		<div class="header" :class="{ 'header--compact': isScrolled }">
			<div class="header-left">
				<div class="brand-mark">
					<img src="../../../assets/images/hongdalogo.png" alt="汨罗市鸿达制冷">
				</div>
				<div class="brand-copy">
					<span class="brand-copy__eyebrow">HONGDA REFRIGERATION</span>
					<strong>精密制造 · 品质制冷配件</strong>
					<p>专注汽车空调铜件与配件工艺，打造更稳定的交付能力。</p>
				</div>
			</div>
			<div class="header-mid">
				<div class="header-item">
					<span class="contact-icon am-icon-phone"></span>
					<div class="item">
						<span class="item-label">服务热线</span>
						<strong>15111129199</strong>
						<span>周一 ~ 周五，08:30 - 17:30</span>
					</div>
				</div>
				<div class="header-item">
					<span class="contact-icon am-icon-map-marker"></span>
					<div class="item">
						<span class="item-label">生产基地</span>
						<strong>湖南省汨罗市大荆镇</strong>
						<span>汨罗市鸿达制冷制造中心</span>
					</div>
				</div>
			</div>
			<div class="header-right">
				<a href="tel:+15111129199" class="header-cta">联系我们</a>
			</div>
		</div>

		<div class="nav-wrapper header-default" :class="{ sticky: isScrolled }">
			<div class="nav">
				<ul class="am-nav am-nav-pills am-nav-justify">
					<li><router-link class="router" to="/index">网站首页</router-link></li>
					<li><router-link class="router" to="/product">产品中心</router-link></li>
					<li><router-link class="router" to="/example">客户案例</router-link></li>
					<li><router-link class="router" to="/news">公司动态</router-link></li>
					<li><router-link class="router" to="/about">关于我们</router-link></li>
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
		}
	},
	methods: {
		toggleStickyHeader() {
			const scrolled = document.documentElement.scrollTop || document.body.scrollTop;
			this.isScrolled = scrolled > 100;
		},
	},
	created() {
		window.addEventListener('scroll', this.toggleStickyHeader);
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
	padding: 22px 24px 18px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 24px;
	transition: transform .3s ease, opacity .3s ease;
}

.header--compact{
	transform: translateY(-6px);
}

.header-left{
	display: flex;
	align-items: center;
	gap: 18px;
	min-width: 0;
}

.brand-mark{
	width: 72px;
	height: 72px;
	border-radius: 22px;
	background: rgba(7, 18, 32, 0.78);
	border: 1px solid rgba(112, 166, 255, 0.24);
	box-shadow: 0 18px 40px rgba(7, 18, 32, 0.18);
	backdrop-filter: blur(14px);
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 12px;
}

.brand-mark img{
	width: 100%;
	height: auto;
}

.brand-copy{
	display: flex;
	flex-direction: column;
	gap: 4px;
	color: #dbe7ff;
}

.brand-copy__eyebrow{
	font-size: 12px;
	letter-spacing: .28em;
	text-transform: uppercase;
	color: rgba(135, 192, 255, 0.72);
}

.brand-copy strong{
	font-size: 22px;
	line-height: 1.2;
	color: #ffffff;
}

.brand-copy p{
	margin: 0;
	font-size: 13px;
	line-height: 1.7;
	color: rgba(219, 231, 255, 0.68);
}

.header-mid{
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 16px;
	flex-wrap: wrap;
}

.header-item{
	display: flex;
	align-items: center;
	gap: 14px;
	padding: 14px 18px;
	border-radius: 20px;
	background: rgba(7, 18, 32, 0.6);
	border: 1px solid rgba(120, 154, 255, 0.18);
	box-shadow: 0 12px 30px rgba(5, 12, 24, 0.12);
	backdrop-filter: blur(14px);
}

.contact-icon{
	width: 44px;
	height: 44px;
	border-radius: 14px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	font-size: 22px;
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
	font-size: 12px;
	letter-spacing: .16em;
	text-transform: uppercase;
	color: rgba(147, 176, 221, 0.72);
}

.item strong{
	font-size: 16px;
	color: #f7fbff;
}

.item span{
	font-size: 12px;
	line-height: 1.6;
	color: rgba(208, 221, 241, 0.72);
}

.header-right{
	flex-shrink: 0;
}

.header-cta{
	display: inline-flex;
	align-items: center;
	justify-content: center;
	padding: 14px 26px;
	border-radius: 999px;
	background: linear-gradient(135deg, #39c3ff 0%, #6f7bff 100%);
	box-shadow: 0 16px 32px rgba(65, 149, 255, 0.28);
	color: #fff;
	font-size: 14px;
	font-weight: 600;
	letter-spacing: .08em;
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
