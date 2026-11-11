import { b as ssr_context, g as getContext, c as store_get, d as attr_style, a as attr, e as escape_html, u as unsubscribe_stores, f as ensure_array_like, i as attr_class, j as derived } from "../../../../chunks/index.js";
import "clsx";
import "@sveltejs/kit/internal";
import "../../../../chunks/exports.js";
import "../../../../chunks/utils2.js";
import "@sveltejs/kit/internal/server";
import "../../../../chunks/root.js";
import "../../../../chunks/state.svelte.js";
import { b as branding, p as publicApi, o as order, A as ApiError, e as error, l as loading } from "../../../../chunks/stores.js";
function onDestroy$1(fn) {
  /** @type {SSRContext} */
  ssr_context.r.on_destroy(fn);
}
const getStores = () => {
  const stores = getContext("__svelte__");
  return {
    /** @type {typeof page} */
    page: {
      subscribe: stores.page.subscribe
    },
    /** @type {typeof navigating} */
    navigating: {
      subscribe: stores.navigating.subscribe
    },
    /** @type {typeof updated} */
    updated: stores.updated
  };
};
const page = {
  subscribe(fn) {
    const store = getStores().page;
    return store.subscribe(fn);
  }
};
const ORDER_TIMELINE = [
  "confirmed",
  "queued",
  "printing",
  "printed",
  "packed",
  "shipped",
  "delivered"
];
const STATUS_LABELS = {
  confirmed: "Confirmado",
  queued: "En cola",
  printing: "Imprimiendo",
  printed: "Impreso",
  packed: "Empacado",
  shipped: "Enviado",
  delivered: "Entregado",
  cancelled: "Cancelado"
};
function labelFor(status) {
  return STATUS_LABELS[status ?? ""] ?? status ?? "—";
}
function Header($$renderer) {
  var $$store_subs;
  let brand = store_get($$store_subs ??= {}, "$branding", branding);
  const primary = brand?.primary_color ?? "#0B132B";
  brand?.accent_color ?? "#00FF87";
  const bg = brand?.background_color ?? "#FFFFFF";
  const name = brand?.business_name ?? "NOVALAB";
  $$renderer.push(`<header class="header svelte-1elxaub"${attr_style("", { "background-color": bg })}><div class="wrap svelte-1elxaub">`);
  if (brand?.logo_url) {
    $$renderer.push(`<!--[0--><img class="logo svelte-1elxaub"${attr("src", brand.logo_url)} alt=""/>`);
  } else {
    $$renderer.push(`<!--[-1--><div class="logo-mark svelte-1elxaub"${attr_style("", { "background-color": primary })}></div>`);
  }
  $$renderer.push(`<!--]--> <div class="title svelte-1elxaub">${escape_html(name)}</div></div></header>`);
  if ($$store_subs) unsubscribe_stores($$store_subs);
}
function Timeline($$renderer, $$props) {
  $$renderer.component(($$renderer2) => {
    let { order: order2, status = order2?.status } = $$props;
    const steps = status === "cancelled" ? ["confirmed", "cancelled"] : ORDER_TIMELINE;
    const currentIndex = steps.indexOf(status);
    $$renderer2.push(`<section class="timeline svelte-112n2zp"><h2 class="timeline-title svelte-112n2zp">Estado del pedido</h2> <ol class="timeline-list svelte-112n2zp"><!--[-->`);
    const each_array = ensure_array_like(steps);
    for (let i = 0, $$length = each_array.length; i < $$length; i++) {
      let step = each_array[i];
      $$renderer2.push(`<li class="step svelte-112n2zp"${attr("data-state", i < currentIndex ? "done" : i === currentIndex ? "current" : "upcoming")}><span class="badge svelte-112n2zp">${escape_html(i + 1)}</span> <div class="content svelte-112n2zp"><span class="text svelte-112n2zp">${escape_html(labelFor(step))}</span> <!--[-->`);
      const each_array_1 = ensure_array_like(order2?.history);
      for (let $$index = 0, $$length2 = each_array_1.length; $$index < $$length2; $$index++) {
        let h = each_array_1[$$index];
        if (h.status === step) {
          $$renderer2.push(`<!--[0--><span class="at svelte-112n2zp">${escape_html(new Date(h.occurred_at).toLocaleString("es-MX", {
            day: "numeric",
            month: "short",
            hour: "2-digit",
            minute: "2-digit"
          }))}</span>`);
        } else {
          $$renderer2.push("<!--[-1-->");
        }
        $$renderer2.push(`<!--]-->`);
      }
      $$renderer2.push(`<!--]--></div> `);
      if (i < steps.length - 1) {
        $$renderer2.push(`<!--[0--><span${attr_class("connector svelte-112n2zp", void 0, { "hidden": i >= currentIndex && i !== currentIndex - 1 })}></span>`);
      } else {
        $$renderer2.push("<!--[-1-->");
      }
      $$renderer2.push(`<!--]--></li>`);
    }
    $$renderer2.push(`<!--]--></ol></section>`);
  });
}
function Items($$renderer, $$props) {
  let { items } = $$props;
  const pct = (item) => Math.min(100, Math.max(0, item.printed_quantity / item.quantity * 100));
  $$renderer.push(`<section class="items svelte-12rxxcg"><h2 class="items-title svelte-12rxxcg">Piezas del pedido</h2> <ul class="items-list svelte-12rxxcg"><!--[-->`);
  const each_array = ensure_array_like(items);
  for (let $$index = 0, $$length = each_array.length; $$index < $$length; $$index++) {
    let item = each_array[$$index];
    $$renderer.push(`<li class="item svelte-12rxxcg"><div class="item-info svelte-12rxxcg"><div class="item-name svelte-12rxxcg">${escape_html(item.product_name)}`);
    if (item.color) {
      $$renderer.push(`<!--[0-->· ${escape_html(item.color)}`);
    } else {
      $$renderer.push("<!--[-1-->");
    }
    $$renderer.push(`<!--]--></div> <div class="item-progress-text svelte-12rxxcg">${escape_html(item.printed_quantity)} de ${escape_html(item.quantity)} impresas</div></div> <div class="item-progress svelte-12rxxcg"><div class="item-bar svelte-12rxxcg"${attr_style("", { width: pct(item) + "%" })}></div></div> <span class="item-state svelte-12rxxcg"${attr("data-state", item.state)}>${escape_html(item.state)}</span></li>`);
  }
  $$renderer.push(`<!--]--></ul></section>`);
}
function Camera($$renderer, $$props) {
  $$renderer.component(($$renderer2) => {
    onDestroy$1(() => {
    });
    $$renderer2.push(`<section class="camera svelte-1j8if0l" aria-label="Vista de impresión"><h2 class="camera-title svelte-1j8if0l">Vista de impresión</h2> `);
    {
      $$renderer2.push(`<!--[-1--><p class="camera-empty svelte-1j8if0l">La cámara se mostrará aquí mientras se imprime tu pedido.</p>`);
    }
    $$renderer2.push(`<!--]--></section>`);
  });
}
function Shipment($$renderer, $$props) {
  $$renderer.component(($$renderer2) => {
    let { shipment } = $$props;
    if (shipment) {
      $$renderer2.push(`<!--[0--><section class="shipment svelte-1lclfu" aria-label="Envío"><h2 class="shipment-title svelte-1lclfu">Envío</h2> <ul class="shipment-list svelte-1lclfu"><li class="svelte-1lclfu"><span class="label svelte-1lclfu">Paquetería</span> <span class="value svelte-1lclfu">${escape_html(shipment.carrier)}</span></li> `);
      if (shipment.tracking_number) {
        $$renderer2.push(`<!--[0--><li class="svelte-1lclfu"><span class="label svelte-1lclfu">Número de guía</span> <span class="value svelte-1lclfu">${escape_html(shipment.tracking_number)}</span></li> `);
        if (shipment.tracking_url) {
          $$renderer2.push(`<!--[0--><li class="svelte-1lclfu"><a${attr("href", shipment.tracking_url)} target="_blank" rel="noopener" class="track-btn svelte-1lclfu">Rastrear en Estafeta</a></li>`);
        } else {
          $$renderer2.push("<!--[-1-->");
        }
        $$renderer2.push(`<!--]-->`);
      } else {
        $$renderer2.push("<!--[-1-->");
      }
      $$renderer2.push(`<!--]--> `);
      if (shipment.shipped_at) {
        $$renderer2.push(`<!--[0--><li class="svelte-1lclfu"><span class="label svelte-1lclfu">Enviado</span> <span class="value svelte-1lclfu">${escape_html(new Date(shipment.shipped_at).toLocaleDateString("es-MX", { day: "numeric", month: "short", year: "numeric" }))}</span></li>`);
      } else {
        $$renderer2.push("<!--[-1-->");
      }
      $$renderer2.push(`<!--]--> `);
      if (shipment.delivered_at) {
        $$renderer2.push(`<!--[0--><li class="svelte-1lclfu"><span class="label svelte-1lclfu">Entregado</span> <span class="value svelte-1lclfu">${escape_html(new Date(shipment.delivered_at).toLocaleDateString("es-MX", { day: "numeric", month: "short", year: "numeric" }))}</span></li>`);
      } else {
        $$renderer2.push("<!--[-1-->");
      }
      $$renderer2.push(`<!--]--></ul></section>`);
    } else {
      $$renderer2.push("<!--[-1-->");
    }
    $$renderer2.push(`<!--]-->`);
  });
}
function _page($$renderer, $$props) {
  $$renderer.component(($$renderer2) => {
    var $$store_subs;
    let { data } = $$props;
    const token = data?.token ?? store_get($$store_subs ??= {}, "$page", page).params.token;
    let brand = derived(() => store_get($$store_subs ??= {}, "$branding", branding));
    let ord = derived(() => store_get($$store_subs ??= {}, "$order", order));
    let err = derived(() => store_get($$store_subs ??= {}, "$error", error));
    let loadingState = derived(() => store_get($$store_subs ??= {}, "$loading", loading));
    let pollingTimer = null;
    const primary = derived(() => brand()?.primary_color ?? "#0B132B");
    const accent = derived(() => brand()?.accent_color ?? "#00FF87");
    const bg = derived(() => brand()?.background_color ?? "#FFFFFF");
    function applyTheme() {
      const root = document.documentElement;
      root.style.setProperty("--nv-primary", primary());
      root.style.setProperty("--nv-accent", accent());
      root.style.setProperty("--nv-bg", bg());
      root.style.setProperty("--nv-text", "#0B132B");
      root.style.setProperty("--nv-text-muted", "#6B7280");
      root.style.setProperty("--nv-border", "#E5E7EB");
    }
    async function loadOrder() {
      loadingState(true);
      err(null);
      try {
        const o = await publicApi.getTrack(token);
        order.set(o);
        ord(o);
      } catch (e) {
        if (e instanceof ApiError) {
          err(e.status === 404 ? "No encontramos ese pedido. Verifica que el enlace sea correcto." : "No se pudo cargar el pedido. Inténtalo de nuevo.");
        } else {
          err("No se pudo cargar el pedido. Inténtalo de nuevo.");
        }
      } finally {
        loadingState(false);
      }
    }
    function startPolling() {
      if (pollingTimer) clearInterval(pollingTimer);
      pollingTimer = setInterval(
        () => {
          if (document.visibilityState === "visible") loadOrder();
        },
        15e3
      );
    }
    function stopPolling() {
      if (pollingTimer) clearInterval(pollingTimer);
    }
    onMount(() => {
      applyTheme();
      loadOrder();
      startPolling();
    });
    onDestroy(() => stopPolling());
    const status = derived(() => ord()?.status);
    const printing = derived(() => status() === "printing" || status() === "queued");
    const promised = derived(() => ord()?.promised_date);
    const estLabel = derived(() => promised() ? new Date(promised()).toLocaleDateString("es-MX", {
      weekday: "long",
      day: "numeric",
      month: "long",
      year: "numeric"
    }) : null);
    Header($$renderer2);
    $$renderer2.push(`<!----> `);
    if (loadingState()) {
      $$renderer2.push(`<!--[0--><section class="page svelte-1n544vx"><p class="loading svelte-1n544vx">Cargando tu pedido…</p></section>`);
    } else if (err()) {
      $$renderer2.push(`<!--[1--><section class="page svelte-1n544vx"><div class="empty svelte-1n544vx"><p class="empty-title svelte-1n544vx">¡Ups!</p> <p class="empty-msg svelte-1n544vx">${escape_html(err())}</p></div></section>`);
    } else if (ord()) {
      $$renderer2.push(`<!--[2--><section class="page svelte-1n544vx"><div class="badge-row svelte-1n544vx"><span class="status-badge svelte-1n544vx"${attr_style("", {
        "background-color": printing() ? "var(--nv-primary)" : "var(--nv-accent)",
        color: printing() ? "#FFFFFF" : "#000"
      })}>${escape_html(labelFor(status()))}</span> `);
      if (estLabel()) {
        $$renderer2.push(`<!--[0--><span class="est-badge svelte-1n544vx">Entrega estimada: ${escape_html(estLabel())}</span>`);
      } else {
        $$renderer2.push("<!--[-1-->");
      }
      $$renderer2.push(`<!--]--></div> `);
      Timeline($$renderer2, { ord: ord(), status: status() });
      $$renderer2.push(`<!----> `);
      Items($$renderer2, { items: ord().items });
      $$renderer2.push(`<!----> `);
      Camera($$renderer2, { printing: printing() });
      $$renderer2.push(`<!----> `);
      Shipment($$renderer2, { shipment: ord().shipment });
      $$renderer2.push(`<!----></section>`);
    } else {
      $$renderer2.push(`<!--[-1--><section class="page svelte-1n544vx"><div class="empty svelte-1n544vx"><p class="empty-title svelte-1n544vx">Pedido no disponible</p> <p class="empty-msg svelte-1n544vx">No se pudo obtener la información del pedido.</p></div></section>`);
    }
    $$renderer2.push(`<!--]-->`);
    if ($$store_subs) unsubscribe_stores($$store_subs);
  });
}
export {
  _page as default
};
