export const manifest = (() => {
function __memo(fn) {
	let value;
	return () => value ??= (value = fn());
}

return {
	appDir: "_app",
	appPath: "_app",
	assets: new Set(["robots.txt"]),
	mimeTypes: {".txt":"text/plain"},
	_: {
		client: {start:"_app/immutable/entry/start.99D1tf0f.js",app:"_app/immutable/entry/app.Dr7xqDE3.js",imports:["_app/immutable/entry/start.99D1tf0f.js","_app/immutable/chunks/DwUwtZeV.js","_app/immutable/chunks/CpAVKEU9.js","_app/immutable/chunks/Drz2e51Y.js","_app/immutable/chunks/-KwtF4oc.js","_app/immutable/entry/app.Dr7xqDE3.js","_app/immutable/chunks/CpAVKEU9.js","_app/immutable/chunks/CXCxljuy.js","_app/immutable/chunks/DxfDdzAL.js","_app/immutable/chunks/-KwtF4oc.js","_app/immutable/chunks/Mvsd7syq.js","_app/immutable/chunks/BiMpjC5Q.js"],stylesheets:[],fonts:[],uses_env_dynamic_public:false},
		nodes: [
			__memo(() => import('./nodes/0.js')),
			__memo(() => import('./nodes/1.js')),
			__memo(() => import('./nodes/2.js')),
			__memo(() => import('./nodes/3.js'))
		],
		remotes: {
			
		},
		routes: [
			{
				id: "/",
				pattern: /^\/$/,
				params: [],
				page: { layouts: [0,], errors: [1,], leaf: 2 },
				endpoint: null
			},
			{
				id: "/p/[token]",
				pattern: /^\/p\/([^/]+?)\/?$/,
				params: [{"name":"token","optional":false,"rest":false,"chained":false}],
				page: { layouts: [0,], errors: [1,], leaf: 3 },
				endpoint: null
			}
		],
		prerendered_routes: new Set([]),
		matchers: async () => {
			
			return {  };
		},
		server_assets: {}
	}
}
})();
