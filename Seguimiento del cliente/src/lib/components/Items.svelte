<svelte:options runes />

<script>
  let { items } = $props();

  const pct = (item) =>
    Math.min(100, Math.max(0, (item.printed_quantity / item.quantity) * 100));
</script>

<section class="items">
  <h2 class="items-title">Piezas del pedido</h2>
  <ul class="items-list">
    {#each items as item}
      <li class="item">
        <div class="item-info">
          <div class="item-name">
            {item.product_name}{#if item.color}
              · {item.color}{/if}
          </div>
          <div class="item-progress-text">
            {item.printed_quantity} de {item.quantity} impresas
          </div>
        </div>
        <div class="item-progress">
          <div class="item-bar" style:width={pct(item) + '%'}></div>
        </div>
        <span class="item-state" data-state={item.state}>{item.state}</span>
      </li>
    {/each}
  </ul>
</section>

<style>
  .items {
    margin-top: 1rem;
  }
  .items-title {
    font-size: 0.875rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.06em;
    color: var(--nv-text-muted, #6b7280);
    margin-bottom: 0.6rem;
  }
  .items-list {
    display: flex;
    flex-direction: column;
    gap: 0.6rem;
  }
  .item {
    display: flex;
    flex-direction: column;
    gap: 0.4rem;
  }
  .item-info {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    gap: 0.5rem;
  }
  .item-name {
    font-size: 0.9375rem;
    font-weight: 700;
    color: var(--nv-text, #0b132b);
    min-width: 0;
  }
  .item-progress-text {
    font-size: 0.8rem;
    color: var(--nv-text-muted, #6b7280);
    white-space: nowrap;
  }
  .item-progress {
    width: 100%;
    height: 8px;
    background: #e5e7eb;
    border-radius: 4px;
    overflow: hidden;
  }
  .item-bar {
    height: 100%;
    background: var(--nv-accent, #00ff87);
    border-radius: 4px;
    transition: width 0.3s ease;
  }
  .item-state {
    display: inline-block;
    font-size: 0.7rem;
    font-weight: 800;
    letter-spacing: 0.04em;
    text-transform: uppercase;
    padding: 0.12rem 0.5rem;
    border-radius: 999px;
    color: #ffffff;
    width: fit-content;
  }
  .item-state[data-state='printing'] {
    background: var(--nv-primary, #0b132b);
  }
  .item-state[data-state='queued'] {
    background: #6b7280;
  }
  .item-state[data-state='printed'] {
    background: var(--nv-accent, #00ff87);
    color: #000;
  }
  .item-state[data-state='pending'] {
    background: #9ca3af;
    color: #000;
  }
  .item-state[data-state='failed'] {
    background: #ef4444;
  }
</style>
