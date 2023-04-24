import { EnabledMealsPipe } from './enabled-meals.pipe';

describe('EnabledMealsPipe', () => {
  it('create an instance', () => {
    const pipe = new EnabledMealsPipe();
    expect(pipe).toBeTruthy();
  });
});
