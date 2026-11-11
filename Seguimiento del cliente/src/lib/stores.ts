import type { OrderDetail, Branding } from '$lib/types';
import { derived, type Readable, writable, type Writable } from 'svelte/store';

export const order = writable<OrderDetail | null>(null);
export const branding = writable<Branding | null>(null);
export const error = writable<string | null>(null);
export const loading = writable(false);
export const cameraSrc = writable<string | null>(null);
export const cameraUpdatedAgo = writable<string | null>(null);
export const cameraError = writable<string | null>(null);

export function polling(active: Writable<boolean>): Readable<boolean> {
  return derived(active, ($active) => $active);
}
