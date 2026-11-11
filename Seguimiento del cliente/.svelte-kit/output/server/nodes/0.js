import * as universal from '../entries/pages/_layout.ts.js';

export const index = 0;
let component_cache;
export const component = async () => component_cache ??= (await import('../entries/pages/_layout.svelte.js')).default;
export { universal };
export const universal_id = "src/routes/+layout.ts";
export const imports = ["_app/immutable/nodes/0.lVo8C_6i.js","_app/immutable/chunks/Ddu68dre.js","_app/immutable/chunks/_-9lldnV.js","_app/immutable/chunks/CpAVKEU9.js","_app/immutable/chunks/DxfDdzAL.js"];
export const stylesheets = ["_app/immutable/assets/0.Bc0o1fj6.css"];
export const fonts = [];
