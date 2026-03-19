<template>
	<main class="page-wrapper">
		<div class="page-background">
			<div class="page-background__orb page-background__orb--primary"></div>
			<div class="page-background__orb page-background__orb--secondary"></div>
			<div class="page-background__grid"></div>
		</div>
		<Header/>

		<div class="main-content">
			<slot></slot>
		</div>

		<Footer/>
	</main>
</template>

<script>
import Header from "@/components/common/header/Header";
import Footer from "@/components/common/footer/Footer";
export default {
	name: "Layout",
	components:{Header, Footer}
}
</script>

<style scoped>
.page-wrapper{
	position: relative;
	width: 100%;
	min-height: 100vh;
	background:
		radial-gradient(circle at top left, rgba(71, 157, 255, 0.18), transparent 32%),
		radial-gradient(circle at 80% 10%, rgba(120, 96, 255, 0.16), transparent 26%),
		linear-gradient(180deg, #07111f 0%, #0b1526 18%, #eef3fb 46%, #f7faff 100%);
	overflow: hidden;
}

.page-background{
	position: absolute;
	inset: 0;
	pointer-events: none;
}

.page-background__orb{
	position: absolute;
	border-radius: 50%;
	filter: blur(10px);
	opacity: 0.7;
}

.page-background__orb--primary{
	width: 420px;
	height: 420px;
	top: 72px;
	left: -140px;
	background: radial-gradient(circle, rgba(70, 173, 255, 0.22) 0%, rgba(70, 173, 255, 0) 72%);
}

.page-background__orb--secondary{
	width: 520px;
	height: 520px;
	top: 320px;
	right: -180px;
	background: radial-gradient(circle, rgba(118, 104, 255, 0.18) 0%, rgba(118, 104, 255, 0) 74%);
}

.page-background__grid{
	position: absolute;
	inset: 0;
	background-image:
		linear-gradient(rgba(255, 255, 255, 0.03) 1px, transparent 1px),
		linear-gradient(90deg, rgba(255, 255, 255, 0.03) 1px, transparent 1px);
	background-size: 36px 36px;
	opacity: 0.3;
	mask-image: linear-gradient(180deg, rgba(0, 0, 0, 0.9), transparent 58%);
}

.main-content{
	position: relative;
	z-index: 1;
	width: 100%;
	display: flex;
	flex-direction: column;
	align-items: center;
}

@media screen and (max-width: 640px) {
	.page-wrapper{
		background:
			radial-gradient(circle at top left, rgba(71, 157, 255, 0.2), transparent 38%),
			radial-gradient(circle at 80% 10%, rgba(120, 96, 255, 0.14), transparent 32%),
			linear-gradient(180deg, #07111f 0%, #0b1526 16%, #f2f6fd 42%, #f7faff 100%);
	}

	.page-background__orb--primary{
		width: 280px;
		height: 280px;
		top: 88px;
		left: -120px;
	}

	.page-background__orb--secondary{
		width: 320px;
		height: 320px;
		top: 400px;
		right: -150px;
	}
}
</style>
