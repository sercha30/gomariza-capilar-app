import { Component, OnInit } from '@angular/core';
import { UserMeResponse } from 'src/app/models/interfaces/user/user';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent implements OnInit {
  loggedUser!: UserMeResponse;

  constructor(private userService: UserService) { }

  ngOnInit(): void {
    this.userService.getLoggedUser().subscribe(response => {
      this.loggedUser = response;
    });
  }

}
