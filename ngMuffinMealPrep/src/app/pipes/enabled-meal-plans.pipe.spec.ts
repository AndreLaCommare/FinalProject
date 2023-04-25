import { EnabledMealPlansPipe } from './enabled-meal-plans.pipe';

describe('EnabledMealPlansPipe', () => {
  it('create an instance', () => {
    const pipe = new EnabledMealPlansPipe();
    expect(pipe).toBeTruthy();
  });
});
