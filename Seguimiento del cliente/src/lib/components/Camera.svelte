<svelte:options runes />

<script>
  import { onMount, onDestroy } from 'svelte';

  let { token, printing = false } = $props();

  let src = $state(null);
  let updatedAgo = $state(null);
  let err = $state(null);
  let timer = null;
  let lastFetch = 0;

  async function fetchSnapshot() {
    if (!token) return;
    try {
      const res = await fetch(
        `/api/public/track/${encodeURIComponent(token)}/camera`,
      );
      if (res.status === 204) {
        src = null;
        err = null;
        return;
      }
      if (!res.ok) {
        src = null;
        err = 'no_disponible';
        return;
      }
      const blob = await res.blob();
      src = URL.createObjectURL(blob);
      lastFetch = Date.now();
      err = null;
      updatedAgo = 'hace unos momentos';
    } catch {
      err = 'error';
    }
  }

  function tick() {
    if (!lastFetch) return;
    const s = Math.floor((Date.now() - lastFetch) / 1000);
    updatedAgo =
      s < 60
        ? `actualizado hace ${s}s`
        : `actualizado hace ${Math.floor(s / 60)}m`;
  }

  onMount(() => {
    fetchSnapshot();
    timer = setInterval(
      () => {
        fetchSnapshot();
        tick();
      },
      printing ? 12000 : 1000,
    );
  });

  onDestroy(() => {
    if (timer) clearInterval(timer);
    if (src) URL.revokeObjectURL(src);
  });

  $effect(() => {
    if (printing) {
      clearInterval(timer);
      timer = setInterval(() => {
        fetchSnapshot();
        tick();
      }, 12000);
    } else {
      clearInterval(timer);
      timer = setInterval(tick, 1000);
    }
  });
</script>

<section class="camera" aria-label="Vista de impresión">
  <h2 class="camera-title">Vista de impresión</h2>
  {#if err === 'no_disponible'}
    <p class="camera-empty">
      No hay imagen de cámara disponible en este momento.
    </p>
  {:else if err === 'error'}
    <p class="camera-empty">No se pudo cargar la imagen de la cámara.</p>
  {:else if src}
    <figure class="camera-figure">
      <img {src} alt="Impresión en curso" class="camera-img" />
      <figcaption class="camera-caption">{updatedAgo}</figcaption>
    </figure>
  {:else}
    <p class="camera-empty">
      La cámara se mostrará aquí mientras se imprime tu pedido.
    </p>
  {/if}
</section>

<style>
  .camera {
    margin-top: 1rem;
    border: 1px solid var(--nv-border, #e5e7eb);
    border-radius: 12px;
    overflow: hidden;
    background: #f3f4f6;
  }
  .camera-title {
    font-size: 0.875rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.06em;
    color: var(--nv-text-muted, #6b7280);
    margin: 0;
    padding: 0.75rem;
    border-bottom: 1px solid var(--nv-border, #e5e7eb);
    background: #f9fafb;
  }
  .camera-figure {
    margin: 0;
    padding: 0.75rem;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.5rem;
  }
  .camera-img {
    width: 100%;
    max-width: 320px;
    height: auto;
    border-radius: 8px;
    background: #ffffff;
    display: block;
  }
  .camera-caption {
    font-size: 0.8rem;
    color: var(--nv-text-muted, #6b7280);
  }
  .camera-empty {
    padding: 1.5rem 1rem;
    text-align: center;
    font-size: 0.9rem;
    color: var(--nv-text-muted, #6b7280);
    margin: 0;
  }
</style>
