import Vue from 'vue'
import VueI18n from 'vue-i18n'
import en from './en'
import zh from './zh'
import fr from './fr'

Vue.use(VueI18n)

const i18n = new VueI18n({
  locale: localStorage.getItem('portal_lang') || 'en',
  fallbackLocale: 'en',
  messages: { en, zh, fr }
})

export default i18n
