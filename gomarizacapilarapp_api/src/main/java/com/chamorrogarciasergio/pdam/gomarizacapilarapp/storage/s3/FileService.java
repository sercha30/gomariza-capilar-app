package com.chamorrogarciasergio.pdam.gomarizacapilarapp.storage.s3;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.S3ObjectInputStream;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.errors.exceptions.storage.StorageException;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.nio.file.Files;
import java.time.LocalDateTime;
import java.util.Objects;

@Service
@RequiredArgsConstructor
public class FileService {

    private static final Logger LOG = LoggerFactory.getLogger(FileService.class);

    private final AmazonS3 amazonS3;

    @Value("${s3.bucket.name}")
    private String s3BucketName;

    @Value("${s3.bucket.url}")
    private String s3BucketUrl;

    public String save(MultipartFile multipartFile) {
        String oldFilename = StringUtils.cleanPath(Objects.requireNonNull(multipartFile.getOriginalFilename()));
        String newFilename;
        try {
            if (multipartFile.isEmpty()) {
                throw new StorageException("Archivo vacío");
            }

            newFilename = oldFilename;
            while (amazonS3.doesObjectExist(s3BucketName, newFilename)) {
                String extension = StringUtils.getFilenameExtension(newFilename);
                String name = newFilename.replace("."+ extension,"");

                String suffix = Long.toString(System.currentTimeMillis());
                suffix = suffix.substring(suffix.length()-6);

                newFilename = name + "_" + suffix + "." + extension;
            }
            return storeAmazonByteArray(multipartFile.getBytes(), newFilename, multipartFile.getContentType());
        } catch (IOException e) {
            throw new StorageException("Error al guardar el archivo" + multipartFile.getOriginalFilename(), e);
        }
    }

    private String storeAmazonByteArray(byte[] image, String filename, String contentType) throws IOException{
        try (InputStream inputStream = new ByteArrayInputStream(image)) {
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentLength(image.length);
            metadata.setContentType(contentType);
            PutObjectRequest request = new PutObjectRequest(s3BucketName, filename, inputStream, metadata);

            amazonS3.putObject(request);

            return s3BucketUrl + filename;
        }
    }

    public boolean deleteObject(String key) {
        try {
            amazonS3.deleteObject(s3BucketName, key);
            return true;
        } catch (AmazonServiceException e) {
            throw new StorageException("Error al borrar el archivo" + key, e);
        }
    }
}
