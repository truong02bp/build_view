package com.example.data.repositories;

import com.example.data.entities.Post;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface PostRepository extends JpaRepository<Post, Long> {

    @Query(value = "SELECT post FROM Post post WHERE post.user.id = ?1 ORDER BY post.updatedDate DESC")
    List<Post> findPostByUserId(Long userId, Pageable pageable);
}
