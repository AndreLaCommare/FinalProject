import { User } from 'src/app/models/user';
import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit{
  userToDisplay : User | null = null;



  constructor(private authServ: AuthService, private currentRoute : ActivatedRoute){
  }



  ngOnInit(){
    let userId = this.currentRoute.snapshot.paramMap.get("userId");
    if (userId){

      this.getOtherUser(parseInt(userId));
    }else{
      this.getLoggedInUser();
    }
  }

  getLoggedInUser( ){
    this.authServ.getLoggedInUser().subscribe( {
      next: (user) =>{this.userToDisplay = user},
      error: (nojoy)=>{
        console.error(nojoy)
      }});


  }

  getOtherUser(userId: number){
//implement subscribe to userService.getUser()
  }
}
