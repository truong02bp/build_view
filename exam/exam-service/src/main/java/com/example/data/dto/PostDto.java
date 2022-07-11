package com.example.data.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class PostDto {
    private Long postId;
    private String caption;
    private Long userId;
    private String name;
    private String contentType;
    private String url;
    private Long mediaId;
    private byte[] bytes;
}
