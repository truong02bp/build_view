package com.example.services;

import com.example.data.dto.PostDto;
import com.example.data.entities.Post;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface PostService {
    List<Post> findPostByUserId(Long userId, Pageable pageable);

    Post create(PostDto postDto);

    Post update(PostDto postDto);

    void delete(Long id);
}
