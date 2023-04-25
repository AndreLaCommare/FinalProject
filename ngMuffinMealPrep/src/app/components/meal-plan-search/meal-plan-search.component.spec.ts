import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MealPlanSearchComponent } from './meal-plan-search.component';

describe('MealPlanSearchComponent', () => {
  let component: MealPlanSearchComponent;
  let fixture: ComponentFixture<MealPlanSearchComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MealPlanSearchComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MealPlanSearchComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
