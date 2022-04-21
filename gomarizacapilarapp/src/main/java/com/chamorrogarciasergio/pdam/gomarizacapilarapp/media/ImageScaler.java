package com.chamorrogarciasergio.pdam.gomarizacapilarapp.media;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.utils.MultipartImage;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;

@Component
public class ImageScaler {

    @Value("${image.avatar.width}")
    private int avatarWidth;

    @Value("${image.avatar.height}")
    private int avatarHeight;

    @Value("${image.post.size}")
    private int postImageSize;

    public MultipartFile resizeAvatarImage(MultipartFile originalImage) throws Exception {
        BufferedImage avatarImage = ImageIO.read(originalImage.getInputStream());
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        Thumbnails.of(avatarImage)
                .size(avatarWidth, avatarHeight)
                .outputFormat("png")
                .outputQuality(1)
                .toOutputStream(outputStream);

        byte[] data = outputStream.toByteArray();

        return MultipartImage.builder()
                .fieldName(originalImage.getName())
                .fileName(originalImage.getOriginalFilename())
                .contentType(originalImage.getContentType())
                .size(originalImage.getSize())
                .bytes(data)
                .build();
    }
}
