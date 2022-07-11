package com.example.controllers;

import com.example.data.dto.PostDto;
import com.example.data.entities.Post;
import com.example.services.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/post")
@RequiredArgsConstructor
public class PostController {

    private final PostService postService;

    @GetMapping
    public ResponseEntity<List<Post>> findPostByUserId(@RequestParam("userId") Long userId, Pageable pageable) {
        return ResponseEntity.ok(postService.findPostByUserId(userId, pageable));
    }

    @PostMapping
    public ResponseEntity<Post> create(@RequestBody PostDto postDto) {
        return ResponseEntity.ok(postService.create(postDto));
    }

    @PutMapping
    public ResponseEntity<Post> update(@RequestBody PostDto postDto) {
        return ResponseEntity.ok(postService.update(postDto));
    }

    @DeleteMapping
    public ResponseEntity<String> delete(@RequestParam("id") Long id) {
        postService.delete(id);
        return ResponseEntity.ok("Success");
    }
}
