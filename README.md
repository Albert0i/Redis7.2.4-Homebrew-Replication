### Redis7.2.4-Homebrew-Replication

Rename `dotenv` to `.env` and set parameters accordingly. 

```
md data 
cd data 
md 6379 6380 6381 
```

![alt make](make.JPG)

The rest is history... 

---

Strangely enough, It seems that *sentinels* have to use `default` user to promote slave upon master failure even I add `masteruser` to `redis.conf`. That also means adding
```
user default off 
```

in `acl.conf` would impede the failover. `acl genpass` is used to generate a strong password to mend this hole... 
