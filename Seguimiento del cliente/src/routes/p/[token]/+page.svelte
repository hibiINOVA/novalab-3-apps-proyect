<svelte:options runes />

<script>
  let { data } = $props();
  import { page } from '$app/stores';
  import { publicApi, ApiError } from '$lib/api';
  import { order, branding, error, loading } from '$lib/stores';
  import { labelFor, DUE_STATE_LABELS } from '$lib/types';
  import Header from '$lib/components/Header.svelte';
  import Timeline from '$lib/components/Timeline.svelte';
  import Items from '$lib/components/Items.svelte';
  import Camera from '$lib/components/Camera.svelte';
  import Shipment from '$lib/components/Shipment.svelte';

  const token = data?.token ?? $page.params.token;

  let brand = $derived($branding);
  let ord = $derived($order);
  let err = $derived($error);
  let loadingState = $derived($loading);
  let pollingTimer = null;

  const primary = $derived(brand?.primary_color ?? '#0B132B');
  const accent = $derived(brand?.accent_color ?? '#00FF87');
  const bg = $derived(brand?.background_color ?? '#FFFFFF');

  function applyTheme() {
    const root = document.documentElement;
    root.style.setProperty('--nv-primary', primary);
    root.style.setProperty('--nv-accent', accent);
    root.style.setProperty('--nv-bg', bg);
    root.style.setProperty('--nv-text', '#0B132B');
    root.style.setProperty('--nv-text-muted', '#6B7280');
    root.style.setProperty('--nv-border', '#E5E7EB');
  }

  $effect(() => applyTheme());

  async function loadOrder() {
    loadingState = true;
    err = null;
    try {
      const o = await publicApi.getTrack(token);
      order.set(o);
      ord = o;
    } catch (e) {
      if (e instanceof ApiError) {
        err =
          e.status === 404
            ? 'No encontramos ese pedido. Verifica que el enlace sea correcto.'
            : 'No se pudo cargar el pedido. Inténtalo de nuevo.';
      } else {
        err = 'No se pudo cargar el pedido. Inténtalo de nuevo.';
      }
    } finally {
      loadingState = false;
    }
  }

  function startPolling() {
    if (pollingTimer) clearInterval(pollingTimer);
    pollingTimer = setInterval(() => {
      if (document.visibilityState === 'visible') loadOrder();
    }, 15000);
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

  $effect(() => {
    const onVisible = () => {
      if (document.visibilityState === 'visible') startPolling();
      else stopPolling();
    };
    document.addEventListener('visibilitychange', onVisible);
    onVisible();
    return () => document.removeEventListener('visibilitychange', onVisible);
  });

  const status = $derived(ord?.status);
  const printing = $derived(status === 'printing' || status === 'queued');
  const promised = $derived(ord?.promised_date);
  const estLabel = $derived(
    promised
      ? new Date(promised).toLocaleDateString('es-MX', {
          weekday: 'long',
          day: 'numeric',
          month: 'long',
          year: 'numeric',
        })
      : null,
  );
</script>

{@render Header()}

{#if loadingState}
  <section class="page">
    <p class="loading">Cargando tu pedido…</p>
  </section>
{:else if err}
  <section class="page">
    <div class="empty">
      <p class="empty-title">¡Ups!</p>
      <p class="empty-msg">{err}</p>
    </div>
  </section>
{:else if ord}
  <section class="page">
    <div class="badge-row">
      <span
        class="status-badge"
        style:background-color={printing
          ? 'var(--nv-primary)'
          : 'var(--nv-accent)'}
        style:color={printing ? '#FFFFFF' : '#000'}
      >
        {labelFor(status)}
      </span>
      {#if estLabel}
        <span class="est-badge">Entrega estimada: {estLabel}</span>
      {/if}
    </div>
    <Timeline {ord} {status} />
    <Items items={ord.items} />
    <Camera {token} {printing} />
    <Shipment shipment={ord.shipment} />
  </section>
{:else}
  <section class="page">
    <div class="empty">
      <p class="empty-title">Pedido no disponible</p>
      <p class="empty-msg">No se pudo obtener la información del pedido.</p>
    </div>
  </section>
{/if}

<style>
  :global(body) {
    transition:
      background-color 0.3s ease,
      color 0.3s ease;
  }
  .page {
    max-width: 480px;
    margin: 0 auto;
  }
  .loading {
    text-align: center;
    padding: 2rem 1rem;
    color: var(--nv-text-muted, #6b7280);
    font-size: 0.95rem;
  }
  .badge-row {
    display: flex;
    gap: 0.6rem;
    flex-wrap: wrap;
    margin-bottom: 1rem;
  }
  .status-badge {
    display: inline-block;
    font-size: 0.8rem;
    font-weight: 800;
    letter-spacing: 0.05em;
    text-transform: uppercase;
    padding: 0.35rem 0.8rem;
    border-radius: 999px;
  }
  .est-badge {
    display: inline-block;
    font-size: 0.8rem;
    font-weight: 600;
    color: var(--nv-text-muted, #6b7280);
    padding: 0.35rem 0.8rem;
    border: 1px solid var(--nv-border, #e5e7eb);
    border-radius: 999px;
    margin-top: 2px;
  }
  .empty {
    text-align: center;
    padding: 3rem 1rem;
  }
  .empty-title {
    font-size: 1.25rem;
    font-weight: 800;
    color: var(--nv-text, #0b132b);
    margin: 0 0 0.5rem;
  }
  .empty-msg {
    font-size: 0.95rem;
    color: var(--nv-text-muted, #6b7280);
    margin: 0;
  }
</style>
