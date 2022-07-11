package com.example.services.impl;

import com.example.data.dto.PostDto;
import com.example.data.entities.Comment;
import com.example.data.entities.Media;
import com.example.data.entities.Post;
import com.example.data.repositories.MediaRepository;
import com.example.data.repositories.PostRepository;
import com.example.data.repositories.UserRepository;
import com.example.services.MinioService;
import com.example.services.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.ByteArrayInputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PostServiceImpl implements PostService {

    private final PostRepository postRepository;
    private final MinioService minioService;
    private final MediaRepository mediaRepository;
    private final UserRepository userRepository;

    @Override
    @Transactional(readOnly = true)
    public List<Post> findPostByUserId(Long userId, Pageable pageable) {
        List<Post> posts = postRepository.findPostByUserId(userId, pageable);
        posts.forEach(post -> {
            final int total = post.getComments().size();
            post.setTotalComment(total);
            post.setComments(post.getComments().stream().filter(Comment::isRoot).collect(Collectors.toList()));
        });
        return posts;
    }

    @Override
    @Transactional
    public Post create(PostDto postDto) {
        Post post = new Post();
        if (postDto.getBytes() != null) {
            final String time = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")).replaceAll("-", "");
            Media media = new Media();
            media.setName(postDto.getName());
            String folder = "/" + time + "/";
            minioService.upload(folder, media.getName(), new ByteArrayInputStream(postDto.getBytes()));
            media.setContentType(media.getName().substring(media.getName().lastIndexOf(".") + 1));
            media.setUrl(folder + media.getName());
            media = mediaRepository.save(media);
            post.setMedia(media);
        }
        post.setCaption(postDto.getCaption());
        post.setUser(userRepository.findById(postDto.getUserId()).orElse(null));
        return postRepository.save(post);
    }

    @Override
    @Transactional
    public Post update(PostDto postDto) {
        Post post = postRepository.findById(postDto.getPostId()).orElse(null);
        if (post == null) {
            return null;
        }
        if (postDto.getMediaId() != null) {
            post.setMedia(null);
            mediaRepository.deleteById(postDto.getMediaId());
        }

        if (postDto.getBytes() != null) {
            final String time = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")).replaceAll("-", "");
            Media media = new Media();
            media.setName(postDto.getName());
            String folder = "/" + time + "/";
            minioService.upload(folder, media.getName(), new ByteArrayInputStream(postDto.getBytes()));
            media.setContentType(media.getName().substring(media.getName().lastIndexOf(".") + 1));
            media.setUrl(folder + media.getName());
            media = mediaRepository.save(media);
            post.setMedia(media);
        }
        if (postDto.getCaption() != null) {
            post.setCaption(postDto.getCaption());
        }
        return postRepository.save(post);
    }

    @Override
    @Transactional
    public void delete(Long id) {
        postRepository.deleteById(id);
    }

}
