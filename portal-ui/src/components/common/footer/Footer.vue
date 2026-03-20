<template>
	<div class="footer">
		<div class="footer--bg"></div>
		<div class="footer--inner">
			<div class="am-g footer-grid">
				<div class="am-u-md-3 am-u-sm-12">
					<div class="footer_main--column">
						<strong class="footer_main--column_title">{{ $t('footer.coreProducts') }}</strong>
						<ul class="footer_navigation">
							<li class="footer_navigation--item"><router-link to="/product" class="footer_navigation--link">{{ $t('footer.product1') }}</router-link></li>
							<li class="footer_navigation--item"><router-link to="/product" class="footer_navigation--link">{{ $t('footer.product2') }}</router-link></li>
							<li class="footer_navigation--item"><router-link to="/product" class="footer_navigation--link">{{ $t('footer.product3') }}</router-link></li>
						</ul>
					</div>
				</div>
				<div class="am-u-md-5 am-u-sm-12">
					<div class="footer_main--column footer_main--column--brand">
						<span class="footer_badge">HONGDA</span>
						<strong class="footer_main--column_title">{{ $t('footer.aboutHongda') }}</strong>
						<div class="footer_about">
							<p class="footer_about--text">{{ $t('footer.aboutText') }}</p>
							<p class="footer_about--subtext">{{ $t('footer.aboutSubtext') }}</p>
						</div>
					</div>
				</div>
				<div class="am-u-md-4 am-u-sm-12">
					<div class="footer_main--column">
						<strong class="footer_main--column_title">{{ $t('footer.contactDetails') }}</strong>
						<ul class="footer_contact_info">
							<li class="footer_contact_info--item"><i class="am-icon-phone"></i><span>{{ $t('footer.hotlineLabel') }}</span></li>
							<li class="footer_contact_info--item"><i class="am-icon-map-marker"></i><span>{{ $t('footer.addressLabel') }}</span></li>
							<li class="footer_contact_info--item"><i class="am-icon-clock-o"></i><span>{{ $t('footer.hoursLabel') }}</span></li>
						</ul>
						<div class="footer_contact_cta">
							<a href="tel:+15111129199">{{ $t('footer.inquireNow') }}</a>
						</div>
					</div>
				</div>
			</div>
			<div class="footer-bottom">
				<span>{{ $t('footer.copyright') }}</span>
				<span>{{ $t('footer.copyrightSub') }}</span>
			</div>
		</div>
	</div>
</template>

<script>
export default {
	name: "Footer"
}
</script>
