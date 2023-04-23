import { Component } from '@angular/core';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.css']
})
export class NavigationComponent {

  isCollapsed: boolean = false;
  adminUser : User | null = null;
  constructor(private auth: AuthService ){}
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


}
