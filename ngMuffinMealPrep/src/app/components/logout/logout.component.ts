import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-logout',
  templateUrl: './logout.component.html',
  styleUrls: ['./logout.component.css']
})
export class LogoutComponent {
  logout(){
    console.log("logging out.")
    this.auth.logout();
    this.router.navigateByUrl('/home');
  }

  constructor(private auth : AuthService, private router: Router){

  }
}
