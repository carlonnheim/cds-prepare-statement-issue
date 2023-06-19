using my from '../db/schema';

service MyService {
    entity IntegerKeyedEntity as projection on my.IntegerKeyedEntity;
    entity StringKeyedEntity as projection on my.StringKeyedEntity;
}