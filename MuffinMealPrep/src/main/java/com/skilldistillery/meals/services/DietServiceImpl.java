package com.skilldistillery.meals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.meals.entities.Diet;
import com.skilldistillery.meals.repositories.DietRepository;

@Service
public class DietServiceImpl implements DietService {

    @Autowired
    private DietRepository dietRepo;

    @Override
    public List<Diet> findAllDiets() {
        return dietRepo.findAll();
    }
}
