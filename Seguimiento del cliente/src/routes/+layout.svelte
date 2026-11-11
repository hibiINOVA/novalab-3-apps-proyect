import type {LayoutData} from './$types'; import Footer from '$lib/components/Footer.svelte';
export let data: LayoutData;

<svelte:head>
  <title>{data.title ?? 'Seguimiento de pedido — NOVALAB'}</title>
</svelte:head>

<div class="app">
  <main>
    <slot />
  </main>
  <Footer />
</div>

<style>
  :global(html) {
    font-family:
      ui-sans-serif,
      system-ui,
      -apple-system,
      Segoe UI,
      Roboto,
      Helvetica Neue,
      Arial,
      sans-serif;
    line-height: 1.5;
    -webkit-tap-highlight-color: transparent;
  }
  :global(body) {
    margin: 0;
    color: var(--nv-text, #0b132b);
    background: var(--nv-bg, #ffffff);
  }
  .app {
    min-height: 100dvh;
    display: flex;
    flex-direction: column;
  }
  main {
    flex: 1;
    padding: env(safe-area-inset-top, 0) 1rem env(safe-area-inset-bottom, 0)
      1rem;
  }
</style>
