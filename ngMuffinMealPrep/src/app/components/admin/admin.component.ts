import { Component } from '@angular/core';
import { MealPlanService } from 'src/app/services/meal-plan.service';
import { GroceryItemService } from 'src/app/services/grocery-item.service';
import { AuthService } from './../../services/auth.service';
import { ActivatedRoute } from '@angular/router';
import { MealService } from 'src/app/services/meal.service';
import { UserService } from 'src/app/services/user.service';
import { User } from 'src/app/models/user';
import { Meal } from 'src/app/models/meal';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.css'],
})
export class AdminComponent {
  allUsers: User[] = [];
  displayUsers: boolean = false;
  displayMeals: boolean = false;
  disabledUser: User | null = null;
  disabledMeal: Meal | null = null;
  allMeals: Meal[] = [];

  constructor(
    private authServ: AuthService,
    private currentRoute: ActivatedRoute,
    private mealService: MealService,
    private groceryItemService: GroceryItemService,
    private mealPlanService: MealPlanService,
    private userService: UserService
  ) {}
  ngOnInit() {
    this.getAllUsers();
    this.getAllMeals();
  }

  getAllUsers() {
    this.userService.index().subscribe({
      next: (data) => {
        this.allUsers = data;
        console.log(this.allUsers);
      },
      error: (nojoy) => {
        console.error(nojoy);
      },
    });
  }

  disableUser(userId: number) {
    this.userService.delete(userId).subscribe({
      next: () => {
        this.getAllUsers();
      },
      error: (nojoy) => {
        console.error('error disableing User ' + nojoy);
      },
    });
  }

  disableMeal(mealId: number) {
    this.mealService.adminDelete(mealId).subscribe({
      next: () => {
        this.getAllMeals();
      },
      error: (nojoy) => {
        console.error('error disableing Meal ' + nojoy);
      },
    });
  }

  reenableUser(user: User) {
    this.userService.reactivate(user).subscribe({
      next: () => {
        this.getAllUsers();
      },
      error: (nojoy) => {
        console.error('error reenableing User ' + nojoy);
      },
    });
  }
  reenableMeal(meal: Meal) {
    this.mealService.reactivate(meal).subscribe({
      next: () => {
        this.getAllMeals();
      },
      error: (nojoy) => {
        console.error('error reenableing Meal ' + nojoy);
      },
    });
  }

  getAllMeals(){
    this.mealService.index().subscribe({
      next: (data) => {
        this.allMeals = data;
        console.log(this.allMeals);
      },
      error: (nojoy) => {
        console.error(nojoy);
      },

    })
  }
}
