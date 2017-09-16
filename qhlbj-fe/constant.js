export default {
	proxy: (process.env.NODE_ENV === 'development' ? 'http://192.168.31.110:3000' : window.location.origin)
}
