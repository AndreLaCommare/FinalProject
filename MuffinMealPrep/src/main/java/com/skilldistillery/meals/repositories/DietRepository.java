package com.skilldistillery.meals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.meals.entities.Diet;

public interface DietRepository extends JpaRepository<Diet, Integer> {

}
