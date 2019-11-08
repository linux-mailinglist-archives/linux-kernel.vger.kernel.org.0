Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C577F5A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 22:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbfKHVhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 16:37:01 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:51629 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731097AbfKHVhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:37:00 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MXXdn-1iQ6Au3bOp-00YveV; Fri, 08 Nov 2019 22:36:51 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Colin Ian King <colin.king@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-um@lists.infradead.org
Subject: [PATCH 12/16] hostfs: pass 64-bit timestamps to/from user space
Date:   Fri,  8 Nov 2019 22:32:50 +0100
Message-Id: <20191108213257.3097633-13-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108213257.3097633-1-arnd@arndb.de>
References: <20191108213257.3097633-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Yjh6blzut3U2WoiDT+9caZknQkgK1SpL5j185/SocENaX6KahaJ
 kOL/KPbr4pFe9IK4tNAPuqUZYc9vyuuRJlXa5Jyi5HeOeb/Mqnh0xCaFpV2rdvsfH7y4Wit
 8UNwCPfTSY925fxcJvFdawPFZqCjcSfTBZkeg5nRD1wJtObhSfUCv5bW5Ua7XjmkI40iyLD
 p8Q5pHUIIqdkvM0JmOt5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s6RMSOV+IEU=:WJyWxBiIq8IQCJo/f/EKGK
 nqQ7zcAZIxMF8ulFyWM0BfYcrcDNkXlwNqouT+zyA+QDs28rWHJWnLUgU3IGZV6s4hn9NIDl0
 og/Zgd7ooGGaFdG1Ixujt9uatHRtM/p2mXFQ3y9d+X6bDq2a10m3jJu5E/gleN/fStRntxfjt
 TMgfnaYURyOib+S2OXeg09KikTVqMiBXxamINr30VR6p4wxwrLGOLRpnoCi7B7FF/g2u7bENY
 Jc70Fs4f3erfgcfvzu5NszIBybVltfX5SoCJkff1nM1/30ycy0Ty1kUWdhDwaX3wzPcOSEaGv
 ieVmmTHqFpL+2pwStqHjQfThVawdeEKIp2qKX6AgWIPei04i26CNLIaPNE8OnWYR8xg5st6Ui
 DL9HNF09gu87sO0m45Ffair4klP3nAr52XsUhiOhuyw2orclqBQ7BZaiwqX8h4kCpBuG/RKvB
 45a5ySGCzIdLNbrBSLXjQp3OEVCbz1MQI5Ge8KRvURLrxLta7mN3uzS/bZN/yTvYRrmKOQmrs
 T7IOnOzlgOFPYQFeQgjzjW/4QvQzTi89y/sUvSbuKgej0slGgyvW/kxi1XgEOIaW7Hxjimqua
 n1ioK5aaHnQ4KXmIrXS7zqnikJzS9Dh39KvWoghF0JfkXVGb48p3ZzlnoXOVb88BLqSHuiZsS
 cEoyEbpdO0HCKFTUMxuOFghzD6KBj0kA2D+PA7I79q7eI5gu5nQ5sL1Rp8XM8GWxbN45szYrL
 PLEQ5gOAnsfDyg0iatYRqpwrvGpSOPxHB64nYdAItsP6HnAa2pE0jWVQ1rWrOS5O6lgvy+XtC
 GdFBv5ySckoxO0DoPYjQrhQZRgsWnmu035Pl8oaOzX2VHdSJzmoxST9WIZnKK+GvPp4XwIF55
 4PGIiv/0CL4yDVP7LC1w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of 'struct timespec' is deprecated in the kernel, so we
want to avoid the conversions from/to the proper timespec64
structure.

On the user space side, we have a 'struct timespec' that is defined
by the C library and that will be incompatible with the kernel's
view on 32-bit architectures once they move to a 64-bit time_t,
breaking the shared binary layout of hostfs_iattr and hostfs_stat.

This changes the two structures to use a new hostfs_timespec structure
with fixed 64-bit seconds/nanoseconds for passing the timestamps
between hostfs_kern.c and hostfs_user.c. With a new enough user
space side, this will allow timestamps beyond year 2038.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/hostfs/hostfs.h      | 22 +++++++++++++---------
 fs/hostfs/hostfs_kern.c | 15 +++++++++------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
index f4295aa19350..69cb796f6270 100644
--- a/fs/hostfs/hostfs.h
+++ b/fs/hostfs/hostfs.h
@@ -37,16 +37,20 @@
  * is on, and remove the appropriate bits from attr->ia_mode (attr is a
  * "struct iattr *"). -BlaisorBlade
  */
+struct hostfs_timespec {
+	long long tv_sec;
+	long long tv_nsec;
+};
 
 struct hostfs_iattr {
-	unsigned int	ia_valid;
-	unsigned short	ia_mode;
-	uid_t		ia_uid;
-	gid_t		ia_gid;
-	loff_t		ia_size;
-	struct timespec	ia_atime;
-	struct timespec	ia_mtime;
-	struct timespec	ia_ctime;
+	unsigned int		ia_valid;
+	unsigned short		ia_mode;
+	uid_t			ia_uid;
+	gid_t			ia_gid;
+	loff_t			ia_size;
+	struct hostfs_timespec	ia_atime;
+	struct hostfs_timespec	ia_mtime;
+	struct hostfs_timespec	ia_ctime;
 };
 
 struct hostfs_stat {
@@ -56,7 +60,7 @@ struct hostfs_stat {
 	unsigned int uid;
 	unsigned int gid;
 	unsigned long long size;
-	struct timespec atime, mtime, ctime;
+	struct hostfs_timespec atime, mtime, ctime;
 	unsigned int blksize;
 	unsigned long long blocks;
 	unsigned int maj;
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 5a7eb0c79839..e6b8c49076bb 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -549,9 +549,9 @@ static int read_name(struct inode *ino, char *name)
 	set_nlink(ino, st.nlink);
 	i_uid_write(ino, st.uid);
 	i_gid_write(ino, st.gid);
-	ino->i_atime = timespec_to_timespec64(st.atime);
-	ino->i_mtime = timespec_to_timespec64(st.mtime);
-	ino->i_ctime = timespec_to_timespec64(st.ctime);
+	ino->i_atime = (struct timespec64){ st.atime.tv_sec, st.atime.tv_nsec };
+	ino->i_mtime = (struct timespec64){ st.mtime.tv_sec, st.mtime.tv_nsec };
+	ino->i_ctime = (struct timespec64){ st.ctime.tv_sec, st.ctime.tv_nsec };
 	ino->i_size = st.size;
 	ino->i_blocks = st.blocks;
 	return 0;
@@ -820,15 +820,18 @@ static int hostfs_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 	if (attr->ia_valid & ATTR_ATIME) {
 		attrs.ia_valid |= HOSTFS_ATTR_ATIME;
-		attrs.ia_atime = timespec64_to_timespec(attr->ia_atime);
+		attrs.ia_atime = (struct hostfs_timespec)
+			{ attr->ia_atime.tv_sec, attr->ia_atime.tv_nsec };
 	}
 	if (attr->ia_valid & ATTR_MTIME) {
 		attrs.ia_valid |= HOSTFS_ATTR_MTIME;
-		attrs.ia_mtime = timespec64_to_timespec(attr->ia_mtime);
+		attrs.ia_mtime = (struct hostfs_timespec)
+			{ attr->ia_mtime.tv_sec, attr->ia_mtime.tv_nsec };
 	}
 	if (attr->ia_valid & ATTR_CTIME) {
 		attrs.ia_valid |= HOSTFS_ATTR_CTIME;
-		attrs.ia_ctime = timespec64_to_timespec(attr->ia_ctime);
+		attrs.ia_ctime = (struct hostfs_timespec)
+			{ attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec };
 	}
 	if (attr->ia_valid & ATTR_ATIME_SET) {
 		attrs.ia_valid |= HOSTFS_ATTR_ATIME_SET;
-- 
2.20.0

