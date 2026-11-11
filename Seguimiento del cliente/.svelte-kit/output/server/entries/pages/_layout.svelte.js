import { h as head, e as escape_html, s as slot } from "../../chunks/index.js";
function _layout($$renderer, $$props) {
  head("12qhfyh", $$renderer, ($$renderer2) => {
    $$renderer2.title(($$renderer3) => {
      $$renderer3.push(`<title>${escape_html(data.title ?? "Seguimiento de pedido — NOVALAB")}</title>`);
    });
  });
  $$renderer.push(`<!---->import type ${escape_html(LayoutData)} from './$types'; import Footer from '$lib/components/Footer.svelte';
export let data: LayoutData; <div class="app svelte-12qhfyh"><main class="svelte-12qhfyh"><!--[-->`);
  slot($$renderer, $$props, "default", {});
  $$renderer.push(`<!--]--></main> `);
  Footer($$renderer, {});
  $$renderer.push(`<!----></div>`);
}
export {
  _layout as default
};
