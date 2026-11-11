<svelte:options runes />

<script>
  import { publicApi } from '$lib/api';
  import { error } from '$lib/stores';
  import { goto } from '$app/navigation';

  let folio = $state('');
  let phone = $state('');
  let busy = $state(false);
  let err = $state(null);

  async function handleLookup(e) {
    e.preventDefault();
    err = null;
    const last4 = phone.replace(/\D/g, '').slice(-4);
    if (!folio || last4.length !== 4) {
      err = 'Ingresa el folio y los últimos 4 dígitos de tu teléfono.';
      return;
    }
    busy = true;
    try {
      const { tracking_token } = await publicApi.lookup({
        folio,
        phone_last4: last4,
      });
      goto(`/p/${tracking_token}`);
    } catch (e) {
      if (e.status === 429) {
        err = 'Demasiados intentos. Espera un momento e inténtalo de nuevo.';
      } else if (e.status === 404) {
        err = 'No encontramos un pedido con ese folio y teléfono.';
      } else {
        err = 'No se pudo consultar el pedido. Inténtalo de nuevo.';
      }
    } finally {
      busy = false;
    }
  }
</script>

<main class="page">
  <section class="card">
    <h1 class="card-title">Buscar tu pedido</h1>
    <p class="card-sub">
      Ingresa el folio de tu pedido y los últimos 4 dígitos del teléfono con el
      que se realizó.
    </p>

    {#if err}
      <div class="alert alert-error">{err}</div>
    {/if}

    <form onsubmit={handleLookup} class="form">
      <div class="field">
        <label class="label" for="folio">Folio del pedido</label>
        <input
          id="folio"
          type="text"
          bind:value={folio}
          placeholder="NL-0001"
          required
          autocomplete="off"
        />
      </div>
      <div class="field">
        <label class="label" for="phone">Últimos 4 dígitos del teléfono</label>
        <input
          id="phone"
          type="tel"
          bind:value={phone}
          maxlength="4"
          inputmode="numeric"
          required
          placeholder="1234"
          autocomplete="off"
        />
      </div>
      <button type="submit" class="btn btn-primary" disabled={busy}>
        {busy ? 'Buscando…' : 'Buscar pedido'}
      </button>
    </form>
    <p class="hint">
      ¿Tienes un enlace directo? Ábrelo para ver tu pedido sin buscar.
    </p>
  </section>
</main>

<style>
  .page {
    max-width: 460px;
    margin: 0 auto;
  }
  .card {
    border: 1px solid var(--nv-border, #e5e7eb);
    border-radius: 16px;
    padding: 1.5rem;
    background: #ffffff;
  }
  .card-title {
    font-size: 1.5rem;
    font-weight: 800;
    color: var(--nv-text, #0b132b);
    margin: 0 0 0.5rem;
    letter-spacing: -0.02em;
  }
  .card-sub {
    font-size: 0.95rem;
    color: var(--nv-text-muted, #6b7280);
    margin: 0 0 1.25rem;
  }
  .alert {
    padding: 0.75rem 1rem;
    border-radius: 10px;
    margin-bottom: 1rem;
    font-size: 0.9rem;
  }
  .alert-error {
    background: #fef2f2;
    border: 1px solid #fecaca;
    color: #b91c1c;
  }
  .form {
    display: flex;
    flex-direction: column;
    gap: 0.9rem;
  }
  .field {
    display: flex;
    flex-direction: column;
    gap: 0.4rem;
  }
  .label {
    font-size: 0.8rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: var(--nv-text-muted, #6b7280);
  }
  input {
    width: 100%;
    padding: 0.7rem 0.9rem;
    border: 1px solid var(--nv-border, #d1d5db);
    border-radius: 10px;
    font-size: 1rem;
    background: #ffffff;
    color: var(--nv-text, #0b132b);
    box-sizing: border-box;
  }
  input:focus {
    outline: 2px solid var(--nv-accent, #00ff87);
    border-color: transparent;
  }
  .btn {
    width: 100%;
    padding: 0.85rem;
    border-radius: 10px;
    border: none;
    font-size: 1rem;
    font-weight: 800;
    cursor: pointer;
  }
  .btn:disabled {
    opacity: 0.6;
    cursor: not-allowed;
  }
  .btn-primary {
    background: var(--nv-primary, #0b132b);
    color: #ffffff;
  }
  .btn-primary:not(:disabled):hover {
    opacity: 0.9;
  }
  .hint {
    margin-top: 1rem;
    font-size: 0.85rem;
    color: var(--nv-text-muted, #6b7280);
    text-align: center;
  }
</style>
