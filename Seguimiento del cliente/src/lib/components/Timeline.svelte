<svelte:options runes />

<script>
  let { order, status = order?.status } = $props();

  import { labelFor, ORDER_TIMELINE } from '$lib/types';

  const steps =
    status === 'cancelled' ? ['confirmed', 'cancelled'] : ORDER_TIMELINE;

  const currentIndex = steps.indexOf(status);
</script>

<section class="timeline">
  <h2 class="timeline-title">Estado del pedido</h2>
  <ol class="timeline-list">
    {#each steps as step, i}
      <li
        class="step"
        data-state={i < currentIndex
          ? 'done'
          : i === currentIndex
            ? 'current'
            : 'upcoming'}
      >
        <span class="badge">{i + 1}</span>
        <div class="content">
          <span class="text">{labelFor(step)}</span>
          {#each order?.history as h}
            {#if h.status === step}
              <span class="at"
                >{new Date(h.occurred_at).toLocaleString('es-MX', {
                  day: 'numeric',
                  month: 'short',
                  hour: '2-digit',
                  minute: '2-digit',
                })}</span
              >
            {/if}
          {/each}
        </div>
        {#if i < steps.length - 1}
          <span
            class="connector"
            class:hidden={i >= currentIndex && i !== currentIndex - 1}
          ></span>
        {/if}
      </li>
    {/each}
  </ol>
</section>

<style>
  .timeline {
    margin-top: 1rem;
  }
  .timeline-title {
    font-size: 0.875rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.06em;
    color: var(--nv-text-muted, #6b7280);
    margin-bottom: 0.75rem;
  }
  .timeline-list {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
  .step {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    position: relative;
  }
  .badge {
    width: 24px;
    height: 24px;
    border-radius: 50%;
    display: grid;
    place-items: center;
    font-size: 0.75rem;
    font-weight: 800;
    flex-shrink: 0;
    background: var(--nv-bg, #ffffff);
    color: var(--nv-text-muted, #9ca3af);
    border: 1px solid #e5e7eb;
  }
  .content {
    flex: 1;
    min-width: 0;
  }
  .text {
    font-size: 0.9375rem;
    font-weight: 600;
    color: var(--nv-text, #0b132b);
  }
  .at {
    font-size: 0.8rem;
    color: var(--nv-text-muted, #6b7280);
    margin-left: 0.5rem;
    white-space: nowrap;
  }
  .connector {
    width: 1px;
    height: 20px;
    background: #e5e7eb;
    margin-left: 11.5px;
    flex-shrink: 0;
  }
  .connector.hidden {
    display: none;
  }

  .step[data-state='done'] .badge {
    background: var(--nv-accent, #00ff87);
    color: #000;
    border-color: var(--nv-accent, #00ff87);
  }
  .step[data-state='done'] .text {
    color: var(--nv-text-muted, #6b7280);
  }
  .step[data-state='current'] .badge {
    background: var(--nv-primary, #0b132b);
    color: #fff;
    border-color: var(--nv-primary, #0b132b);
    box-shadow: 0 0 0 3px rgba(11, 19, 43, 0.15);
  }
  .step[data-state='current'] .text {
    color: var(--nv-primary, #0b132b);
  }
</style>
