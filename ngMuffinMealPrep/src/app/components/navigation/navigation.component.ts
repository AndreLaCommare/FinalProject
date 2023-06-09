import { Router } from '@angular/router';
import { Component } from '@angular/core';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { MealService } from 'src/app/services/meal.service';
import { MealPlanService } from 'src/app/services/meal-plan.service';

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.css']
})
export class NavigationComponent {

  loginUser: User = new User();
  isCollapsed: boolean = false;
  adminUser : User | null = null;
  mealQuery: string = '';
  mealPlanQuery: string = '';
  constructor(private auth: AuthService, private mealService: MealService, private router: Router, private mealPlanService: MealPlanService){}
  loggedIn() : boolean {
    return this.auth.checkLogin();
  }

  ngOnInit(){
    this.userIsAdmin();
  }

  userIsAdmin() {
    this.auth.getLoggedInUser().subscribe({

      next: (user) =>{if(user.role === "ADMIN"){
        this.adminUser = user;
      }
      },
      error: (nojoy)=>{
        console.error(nojoy)
      }


    })
  }

  setSearch(){

    this.router.navigateByUrl("/meals/search/" + this.mealQuery);
    this.mealQuery = '';
  }
  setPlanSearch(){
    //this.mealPlanService.setQuery(this.mealPlanQuery);

    this.router.navigateByUrl("/mealPlans/search/" + this.mealPlanQuery);

    this.mealPlanQuery = '';
  }

  // mealSearch(){
  //   this.mealService.search(query).subscribe({
  //     next:(resultMeals) => {
  //       this.router.navigateByUrl('/mealSearch')
  //       query = '';
  //     },
  //     error:(err) => {
  //       console.error(err);
  //     }
  //   })
  // }

  login(user: User){
    console.log("Logging in:")
    console.log(user);
    this.auth.login(user.username, user.password).subscribe({
      next: (loggedInUser) => {
        this.router.navigateByUrl('/home');
        this.ngOnInit();
      },
      error: (problem) => {
        console.error('RegisterComponent.register(): Error logging in user:');
        console.error(problem);
      }
    });
  }

  logout(){
    console.log("logging out.")
    this.auth.logout();
    this.router.navigateByUrl('/home');
    this.adminUser = null;
  }


}
