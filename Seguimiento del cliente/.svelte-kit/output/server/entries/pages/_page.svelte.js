import { a as attr, e as escape_html } from "../../chunks/index.js";
import "@sveltejs/kit/internal";
import "../../chunks/exports.js";
import "../../chunks/utils2.js";
import "@sveltejs/kit/internal/server";
import "../../chunks/root.js";
import "../../chunks/state.svelte.js";
function _page($$renderer, $$props) {
  $$renderer.component(($$renderer2) => {
    let folio = "";
    let phone = "";
    let busy = false;
    $$renderer2.push(`<main class="page svelte-1uha8ag"><section class="card svelte-1uha8ag"><h1 class="card-title svelte-1uha8ag">Buscar tu pedido</h1> <p class="card-sub svelte-1uha8ag">Ingresa el folio de tu pedido y los últimos 4 dígitos del teléfono con el
      que se realizó.</p> `);
    {
      $$renderer2.push("<!--[-1-->");
    }
    $$renderer2.push(`<!--]--> <form class="form svelte-1uha8ag"><div class="field svelte-1uha8ag"><label class="label svelte-1uha8ag" for="folio">Folio del pedido</label> <input id="folio" type="text"${attr("value", folio)} placeholder="NL-0001" required="" autocomplete="off" class="svelte-1uha8ag"/></div> <div class="field svelte-1uha8ag"><label class="label svelte-1uha8ag" for="phone">Últimos 4 dígitos del teléfono</label> <input id="phone" type="tel"${attr("value", phone)} maxlength="4" inputmode="numeric" required="" placeholder="1234" autocomplete="off" class="svelte-1uha8ag"/></div> <button type="submit" class="btn btn-primary svelte-1uha8ag"${attr("disabled", busy, true)}>${escape_html("Buscar pedido")}</button></form> <p class="hint svelte-1uha8ag">¿Tienes un enlace directo? Ábrelo para ver tu pedido sin buscar.</p></section></main>`);
  });
}
export {
  _page as default
};
