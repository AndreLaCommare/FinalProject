import { TestBed } from '@angular/core/testing';

import { PlanReviewService } from './plan-review.service';

describe('PlanReviewService', () => {
  let service: PlanReviewService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(PlanReviewService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
