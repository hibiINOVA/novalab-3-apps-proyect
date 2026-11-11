<svelte:options runes />

<script>
  import { branding } from '$lib/stores';

  let brand = $branding;

  const primary = brand?.primary_color ?? '#0B132B';
  const accent = brand?.accent_color ?? '#00FF87';
  const bg = brand?.background_color ?? '#FFFFFF';
  const name = brand?.business_name ?? 'NOVALAB';
</script>

<header class="header" style:background-color={bg}>
  <div class="wrap">
    {#if brand?.logo_url}
      <img class="logo" src={brand.logo_url} alt="" />
    {:else}
      <div class="logo-mark" style:background-color={primary}></div>
    {/if}
    <div class="title">{name}</div>
  </div>
</header>

<style>
  .header {
    padding: 1rem 1rem 0.75rem;
    color: #ffffff;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.06);
  }
  .wrap {
    display: flex;
    align-items: center;
    gap: 0.75rem;
  }
  .logo {
    width: 34px;
    height: 34px;
    border-radius: 8px;
    object-fit: cover;
    background: rgba(255, 255, 255, 0.15);
  }
  .logo-mark {
    width: 34px;
    height: 34px;
    border-radius: 8px;
  }
  .title {
    font-size: 1.125rem;
    font-weight: 800;
    letter-spacing: -0.01em;
  }
</style>
