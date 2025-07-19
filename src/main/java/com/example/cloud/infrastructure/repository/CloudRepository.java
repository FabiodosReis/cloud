package com.example.cloud.infrastructure.repository;

import com.example.cloud.domain.model.Cloud;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CloudRepository extends JpaRepository<Cloud, Long> {
}
