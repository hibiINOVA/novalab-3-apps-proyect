import { describe, expect, it } from 'vitest';
import {
  DUE_STATE_LABELS,
  labelFor,
  ORDER_TIMELINE,
  STATUS_LABELS,
} from './types';

describe('labelFor', () => {
  it('traduce estados conocidos al español', () => {
    expect(labelFor('confirmed')).toBe('Confirmado');
    expect(labelFor('printing')).toBe('Imprimiendo');
    expect(labelFor('delivered')).toBe('Entregado');
  });

  it('usa el valor crudo si no hay traducción', () => {
    expect(labelFor('custom_state')).toBe('custom_state');
  });

  it('tolera undefined', () => {
    expect(labelFor(undefined)).toBe('—');
  });
});

describe('ORDER_TIMELINE', () => {
  it('es la secuencia de estados del pedido (C-02)', () => {
    expect(ORDER_TIMELINE).toEqual([
      'confirmed',
      'queued',
      'printing',
      'printed',
      'packed',
      'shipped',
      'delivered',
    ]);
  });

  it('todos los estados del timeline tienen etiqueta', () => {
    for (const s of ORDER_TIMELINE) {
      expect(STATUS_LABELS[s]).toBeTruthy();
    }
  });
});

describe('DUE_STATE_LABELS', () => {
  it('etiqueta vencimiento para due_soon y overdue', () => {
    expect(DUE_STATE_LABELS.due_soon).toBe('Próximo a vencer');
    expect(DUE_STATE_LABELS.overdue).toBe('Vencido');
    expect(DUE_STATE_LABELS.ok).toBe('');
  });
});
