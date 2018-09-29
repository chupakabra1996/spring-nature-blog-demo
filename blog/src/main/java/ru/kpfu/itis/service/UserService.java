package ru.kpfu.itis.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import ru.kpfu.itis.exceptions.NotFoundException;
import ru.kpfu.itis.exceptions.RegisterUserException;
import ru.kpfu.itis.model.entities.User;
import ru.kpfu.itis.repo.UserAuthorityRepository;
import ru.kpfu.itis.repo.UserRepository;

@Service
public class UserService {

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserAuthorityRepository authorityRepository;

    @Autowired
    private UserRepository userRepository;


    /**
     * Saves user
     * If email or login exists throw RegisterUserException
     * with code  0 - email exists, 1 - login exists
     *
     * @param user - User
     * @throws RegisterUserException
     */
    public void registerNewUserAccount(User user) throws RegisterUserException {
        if (emailExists(user.getEmail())) {
            throw new RegisterUserException("There is an account with that email address: " + user.getEmail(), 0);
        }

        if (loginExists(user.getLogin())) {
            throw new RegisterUserException("There is an account with that login address: " + user.getLogin(), 1);
        }

        String password = passwordEncoder.encode(user.getPassword());

        user.setPassword(password);
        user.setPasswordRepeat(password);

        user.addAuthority(authorityRepository.findByAuthority("ROLE_USER"));

        setDefaultImage(user);  //setting default image

        if (userRepository.save(user) == null) {
            throw new RegisterUserException("Database error! Can't save user!");
        }

    }


    /**
     * Sets user's image to default
     *
     * @param user
     */
    private void setDefaultImage(User user) {
        user.setImage(user.getSex().equalsIgnoreCase("male") ?
                "/assets/images/img/default_user_image_0.png" :
                "/assets/images/img/default_user_image_1.png");
    }


    /**
     * Checks if email exists
     *
     * @param email - user's email
     * @return true - if exist, false - if don't
     */
    private boolean emailExists(String email) {
        return userRepository.findByEmailIgnoreCase(email) != null;
    }


    /**
     * As emailExists() see it.
     *
     * @param login
     * @return
     */
    private boolean loginExists(String login) {
        return userRepository.findByLoginIgnoreCase(login) != null;
    }


    /**
     * Finds user by id
     *
     * @param id - user's is
     * @return User
     */
    public User findUserById(int id) {

        User user = userRepository.findOne(id);

        checkUser(user);

        return user;
    }


    /**
     * Finds user by email.
     *
     * @param email user's email
     * @return user, else if null thow excpetion NotFoundException
     */
    public User findUserByEmail(String email) {

        User user = userRepository.findByEmailIgnoreCase(email);

        checkUser(user);

        return user;
    }


    /**
     * Finds user by login
     *
     * @param login
     * @return user, else if null thow excpetion NotFoundException
     */
    public User findUserByLogin(String login) {

        User user = userRepository.findByLoginIgnoreCase(login);

        checkUser(user);

        return user;
    }


    private void checkUser(User user) {
        if (user == null || !user.isEnabled()) {
            throw new NotFoundException("User profile is not exists or it isn't enabled yet!");
        }
    }
}
