CREATE TABLE `users` (
    `uid` int not null primary key auto_increment,
    `gid` varchar(1000) not null unique,
    `name` varchar(200) not null,
    `email` varchar(200) not null,
    `photoUrl` varchar(1000) not null,
    `nationality` varchar(100),
    `type` int not null default 0
);

CREATE TABLE `landmarks` (
    `lid` int not null primary key auto_increment,
    `name` varchar(200) not null,
    `lat` decimal(10,8) not null,
    `lng` decimal(10,8) not null,
    `l_desc` text not null,
    `s_desc` text not null,
    `start_at` TIME not null,
    `end_at` TIME not null,
    `contact_phone` varchar(20),
    `contact_email` varchar(100),
    `lookups` int not null default 0,
    `landscapeTitlePhotoUrl` varchar(1000) not null,
    `portraitTitlePhotoUrl` varchar(1000) not null,
    `createdAt` timestamp not null default current_timestamp
);

CREATE TABLE `landmark_tags` (
    `lid` int not null,
    `tag` varchar(100) not null,
    foreign key (lid) references landmarks(lid)
);

CREATE TABLE `landmark_visited_config` (
    `lid` int not null,
    `uid` int not null,
    `visitedAt` timestamp not null default current_timestamp,
    foreign key (lid) references landmarks(lid),
    foreign key (uid) references users(uid)
);

CREATE TABLE `landmark_pictures` (
    `lid` int not null,
    `photoUrl` varchar(1000) not null,
    foreign key (lid) references landmarks(lid)
);

CREATE TABLE `landmark_reviews` (
    `lid` int not null,
    `uid` int not null,
    `rating` decimal(10,1) not null default 2.5,
    `comments` text not null,
    primary key (lid,uid),
    foreign key (lid) references landmarks(lid),
    foreign key (uid) references users(uid)
);

CREATE TABLE `blog_posts` (
    `bid` int not null primary key auto_increment,
    `uid` int not null,
    `titleText` text not null,
    `titleImg` varchar(1000) not null,
    `shortDesc` text not null,
    `longDesc` text not null,
    foreign key (uid) references users(uid)
);

CREATE TABLE `blog_comments` (
    `cid` int not null primary key auto_increment,
    `bid` int not null,
    `uid` int not null,
    `comment` text not null,
    `createdAt` timestamp not null default current_timestamp,
    foreign key (bid) references blog_posts(bid),
    foreign key (uid) references users(uid)
);

CREATE TABLE `blog_posts_upordown` (
    `bid` int not null,
    `uid` int not null,
    `upOrDown` int not null,
    primary key (bid,uid),
    foreign key (bid) references blog_posts(bid),
    foreign key (uid) references users(uid)
);

CREATE TABLE `blog_comments_upordown` (
    `cid` int not null,
    `uid` int not null,
    `upOrDown` int not null,
    primary key (cid,uid),
    foreign key (cid) references blog_comments(cid),
    foreign key (uid) references users(uid)
);