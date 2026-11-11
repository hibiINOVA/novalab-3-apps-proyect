import { p as publicApi, b as branding } from "../../chunks/stores.js";
const DEFAULT_TITLE = "Seguimiento de pedido — NOVALAB";
const load = async ({ parent }) => {
  const _parent = await parent();
  let brand = null;
  try {
    brand = await publicApi.getBranding();
    branding.set(brand);
  } catch {
    brand = null;
  }
  return {
    ..._parent,
    title: brand?.business_name ? `${brand.business_name} — Seguimiento` : DEFAULT_TITLE,
    brand
  };
};
export {
  load
};
