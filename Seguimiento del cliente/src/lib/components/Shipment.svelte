<svelte:options runes />

<script>
  let { shipment } = $props();
</script>

{#if shipment}
  <section class="shipment" aria-label="Envío">
    <h2 class="shipment-title">Envío</h2>
    <ul class="shipment-list">
      <li>
        <span class="label">Paquetería</span>
        <span class="value">{shipment.carrier}</span>
      </li>
      {#if shipment.tracking_number}
        <li>
          <span class="label">Número de guía</span>
          <span class="value">{shipment.tracking_number}</span>
        </li>
        {#if shipment.tracking_url}
          <li>
            <a
              href={shipment.tracking_url}
              target="_blank"
              rel="noopener"
              class="track-btn">Rastrear en Estafeta</a
            >
          </li>
        {/if}
      {/if}
      {#if shipment.shipped_at}
        <li>
          <span class="label">Enviado</span>
          <span class="value"
            >{new Date(shipment.shipped_at).toLocaleDateString('es-MX', {
              day: 'numeric',
              month: 'short',
              year: 'numeric',
            })}</span
          >
        </li>
      {/if}
      {#if shipment.delivered_at}
        <li>
          <span class="label">Entregado</span>
          <span class="value"
            >{new Date(shipment.delivered_at).toLocaleDateString('es-MX', {
              day: 'numeric',
              month: 'short',
              year: 'numeric',
            })}</span
          >
        </li>
      {/if}
    </ul>
  </section>
{/if}

<style>
  .shipment {
    margin-top: 1rem;
    border: 1px solid var(--nv-border, #e5e7eb);
    border-radius: 12px;
    background: #ffffff;
  }
  .shipment-title {
    font-size: 0.875rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.06em;
    color: var(--nv-text-muted, #6b7280);
    margin: 0;
    padding: 0.75rem;
    border-bottom: 1px solid var(--nv-border, #e5e7eb);
  }
  .shipment-list {
    list-style: none;
    margin: 0;
    padding: 0;
  }
  .shipment-list li {
    display: flex;
    justify-content: space-between;
    padding: 0.65rem 0.75rem;
    border-bottom: 1px solid var(--nv-border, #e5e7eb);
    font-size: 0.9rem;
  }
  .shipment-list li:last-child {
    border-bottom: none;
  }
  .label {
    color: var(--nv-text-muted, #6b7280);
  }
  .value {
    font-weight: 700;
    color: var(--nv-text, #0b132b);
  }
  .track-btn {
    margin-top: 0.5rem;
    display: inline-block;
    background: var(--nv-primary, #0b132b);
    color: #ffffff;
    text-decoration: none;
    font-size: 0.85rem;
    font-weight: 700;
    padding: 0.5rem 0.9rem;
    border-radius: 8px;
    border: none;
    cursor: pointer;
  }
  .track-btn:hover {
    opacity: 0.9;
  }
</style>
