<template>
	<div class="footer">
		<div class="footer--bg"></div>
		<div class="footer--inner">
			<div class="am-g footer-grid">
				<div class="am-u-md-3 am-u-sm-12">
					<div class="footer_main--column">
						<strong class="footer_main--column_title">核心产品</strong>
						<ul class="footer_navigation">
							<li class="footer_navigation--item"><router-link to="/product" class="footer_navigation--link">汽车空调铜件</router-link></li>
							<li class="footer_navigation--item"><router-link to="/product" class="footer_navigation--link">精密制冷配件</router-link></li>
							<li class="footer_navigation--item"><router-link to="/product" class="footer_navigation--link">定制制造服务</router-link></li>
						</ul>
					</div>
				</div>
				<div class="am-u-md-5 am-u-sm-12">
					<div class="footer_main--column footer_main--column--brand">
						<span class="footer_badge">HONGDA</span>
						<strong class="footer_main--column_title">关于鸿达制冷</strong>
						<div class="footer_about">
							<p class="footer_about--text">
								汨罗市鸿达制冷专注汽车空调铜件与精密配件制造，以稳定工艺、严谨品控和持续交付能力服务客户，构建小而专、小而强的制造竞争力。
							</p>
							<p class="footer_about--subtext">
								从材料、工艺到成品检测，持续打磨每一个生产环节，让产品品质和合作效率同步提升。
							</p>
						</div>
					</div>
				</div>
				<div class="am-u-md-4 am-u-sm-12">
					<div class="footer_main--column">
						<strong class="footer_main--column_title">联系详情</strong>
						<ul class="footer_contact_info">
							<li class="footer_contact_info--item"><i class="am-icon-phone"></i><span>服务热线：15111129199</span></li>
							<li class="footer_contact_info--item"><i class="am-icon-map-marker"></i><span>湖南省汨罗市大荆镇 · 鸿达制冷制造中心</span></li>
							<li class="footer_contact_info--item"><i class="am-icon-clock-o"></i><span>周一 ~ 周五 08:30 - 17:30</span></li>
						</ul>
						<div class="footer_contact_cta">
							<a href="tel:+15111129199">立即咨询</a>
						</div>
					</div>
				</div>
			</div>
			<div class="footer-bottom">
				<span>© 2026 汨罗市鸿达制冷 · 精密制造与品质服务</span>
				<span>以稳定工艺支撑长期合作</span>
			</div>
		</div>
	</div>
</template>

<script>
export default {
	name: "Footer"
}
</script>

<style scoped>
.footer-grid{
	position: relative;
	z-index: 1;
	padding: 24px 0 0;
}

.footer_badge{
	display: inline-flex;
	align-items: center;
	padding: 6px 12px;
	margin-bottom: 16px;
	border-radius: 999px;
	background: rgba(57, 195, 255, 0.12);
	border: 1px solid rgba(111, 123, 255, 0.24);
	color: #8ed8ff;
	font-size: 12px;
	font-weight: 700;
	letter-spacing: .2em;
}

.footer_main--column--brand{
	padding-right: 28px;
}

.footer_about--subtext{
	margin: 0;
	font-size: 14px;
	line-height: 1.9;
	color: rgba(223, 234, 255, 0.72);
}

.footer_contact_cta{
	margin-top: 22px;
}

.footer_contact_cta a{
	display: inline-flex;
	align-items: center;
	justify-content: center;
	padding: 12px 20px;
	border-radius: 999px;
	background: linear-gradient(135deg, #39c3ff 0%, #6f7bff 100%);
	color: #fff;
	text-decoration: none;
	font-size: 14px;
	font-weight: 600;
	letter-spacing: .08em;
	box-shadow: 0 14px 26px rgba(65, 149, 255, 0.26);
	transition: transform .3s ease, box-shadow .3s ease;
}

.footer_contact_cta a:hover{
	transform: translateY(-3px);
	box-shadow: 0 18px 32px rgba(65, 149, 255, 0.32);
}

.footer-bottom{
	position: relative;
	z-index: 1;
	max-width: 1140px;
	margin: 32px auto 0;
	padding: 18px 10px 28px;
	border-top: 1px solid rgba(255, 255, 255, 0.08);
	display: flex;
	justify-content: space-between;
	gap: 16px;
	color: rgba(223, 234, 255, 0.56);
	font-size: 13px;
	letter-spacing: .04em;
}

@media screen and (max-width: 640px) {
	.footer_main--column--brand{
		padding-right: 0;
	}

	.footer-bottom{
		flex-direction: column;
		text-align: center;
		padding-bottom: 22px;
	}
}
</style>
