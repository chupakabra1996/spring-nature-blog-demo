package ru.kpfu.itis.controllers;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import ru.kpfu.itis.service.PostService;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

@Controller
public class ImageLoaderController {

    private static final Logger log = Logger.getLogger(ImageLoaderController.class);


    @Autowired
    private PostService postService;


    @RequestMapping(method = RequestMethod.GET, value = "/post/featured_image/{id}")
    @ResponseBody
    public byte[] loadPostImage(@PathVariable("id") int id) {

        String path = postService.getIMAGES() + File.separator + postService.findPost(id).getFeaturedImage();

        try {
            return Files.readAllBytes(Paths.get(path));
        } catch (IOException e) {
            log.error("Error occurred when reading the file : " + path, e);
            return new byte[]{};
        }
    }



    @RequestMapping(method = RequestMethod.GET, value = "/user/profile/image/{imageId}")
    @ResponseBody
    public byte[] loadUserImage(@PathVariable("imageId") String imageId) {

        String path = postService.getPROFILES() + File.separator + imageId;

        log.error("path = " + path);

        try {
            return Files.readAllBytes(Paths.get(path));
        } catch (IOException e) {
            log.error("Error occurred when reading the file : " + path, e);
            return new byte[]{};
        }
    }

}
