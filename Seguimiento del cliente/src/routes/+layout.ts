import { publicApi } from '$lib/api';
import { branding } from '$lib/stores';
import type { Branding } from '$lib/types';

const DEFAULT_TITLE = 'Seguimiento de pedido — NOVALAB';

export const load = async ({ parent }) => {
  const _parent = await parent();
  let brand: Branding | null = null;
  try {
    brand = await publicApi.getBranding();
    branding.set(brand);
  } catch {
    brand = null;
  }
  return {
    ..._parent,
    title: brand?.business_name
      ? `${brand.business_name} — Seguimiento`
      : DEFAULT_TITLE,
    brand,
  };
};
