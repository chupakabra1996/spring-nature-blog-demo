package ru.kpfu.itis.repo;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.model.entities.LogInfo;

@Repository
public interface LoggingRepo extends CrudRepository<LogInfo, Integer> {

}
