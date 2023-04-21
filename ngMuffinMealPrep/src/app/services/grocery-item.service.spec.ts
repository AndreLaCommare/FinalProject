import { TestBed } from '@angular/core/testing';

import { GroceryItemService } from './grocery-item.service';

describe('GroceryItemService', () => {
  let service: GroceryItemService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(GroceryItemService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
