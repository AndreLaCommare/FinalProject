import { TestBed } from '@angular/core/testing';

import { MealReviewService } from './meal-review.service';

describe('MealReviewService', () => {
  let service: MealReviewService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MealReviewService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
