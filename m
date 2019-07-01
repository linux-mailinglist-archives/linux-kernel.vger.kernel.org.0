Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD8C31CB48
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 17:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfENPBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 11:01:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42549 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENPBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:01:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id x15so8391646pln.9;
        Tue, 14 May 2019 08:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KHX2jm8h5cQhhSHYMZcd0NuEp1U3hOpgV39qpd13txY=;
        b=epAnV9v1oJsCsTroRdOenuw1LNVvi3uHZmqNxcWmzw9azQ2RZJEuzsE6s4VbFuDlM1
         06WxwynGVP8FWkJOfV5pnztBd97djdPB2F7lOu4/eVSNNqKJ6HwKzlp84iIn6Ysj8dYQ
         tlHMYJOTFRoios0sxf+UgarNIPhCp7MgvP0JiLp8Phyqqfj+MiWoMDjxqfYD1gM8fCvk
         x+qJmA5A6WVQYvpR7jxmr6SjpyKvvewCaiPWp7SbWd0sGO0G76YxygbESHcISwdJNWA1
         6T0HHa6qGP+QU+kNMr6G9ndFA5P9W2dIMvY/t0hrwfoEye3PqYyel+fpZk74GYblkL1z
         cxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KHX2jm8h5cQhhSHYMZcd0NuEp1U3hOpgV39qpd13txY=;
        b=cNv9XMDIqoSDDuaps6KJAfgdz0eHkvxHqEr2+hxWLJ+FIOvNEaJzZhp2IRU7QKtYf5
         oY26W2/l8XYXnMMoYWyTda+ubzfBe7Fciyh9csW+vqoZYPUsjpO9RX9vLu6MoIMAsgNb
         oouIqyMNGTjiAr3S/N54P1yJeDbigKO2a2N8MguhFt3lXoIua4yRLisWVWvkOvVHWsOC
         E0Am6M2+k838iBMM5Ffaj9UQiRQoFDF/XgfC50yq9GK/5FSBvF1C/unThyw7gI04X84v
         QNwQo5r88eJhhFhubol4K6ZZ4G83QtceK1A8cyzs+8UuzHu1XuxpjAfyTn+S9NCEzUvr
         KY2w==
X-Gm-Message-State: APjAAAV/oqhc0q2FFdThY9adW/3W8ZkYZCo6dubigpblB4fjqCzajaDo
        z70KOMOKRb4iota2Vtv3ePE=
X-Google-Smtp-Source: APXvYqyIC9AyQXsRwNDXknePguQdvN5NSJSs67TbQzno0EygQBGG0csr5pCGZjO9l5Ng9XoSAuAnGg==
X-Received: by 2002:a17:902:9a81:: with SMTP id w1mr36547178plp.71.1557846059768;
        Tue, 14 May 2019 08:00:59 -0700 (PDT)
Received: from ubuntu.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id o20sm17674943pgj.70.2019.05.14.08.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 08:00:59 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        benh@kernel.crashing.org, prsood@codeaurora.org,
        mojha@codeaurora.org, gkohli@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        zhaowuyun@wingtech.com
Subject: [PATCH v2] driver core: Fix use-after-free and double free on glue directory
Date:   Tue, 14 May 2019 23:00:27 +0800
Message-Id: <20190514150027.2364-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race condition between removing glue directory and adding a new
device under the glue directory. It can be reproduced in following test:

path 1: Add the child device under glue dir
device_add()
    get_device_parent()
        mutex_lock(&gdp_mutex);
        ....
        /*find parent from glue_dirs.list*/
        list_for_each_entry(k, &dev->class->p->glue_dirs.list, entry)
            if (k->parent == parent_kobj) {
                kobj = kobject_get(k);
                break;
            }
        ....
        mutex_unlock(&gdp_mutex);
        ....
    ....
    kobject_add()
        kobject_add_internal()
            create_dir()
                sysfs_create_dir_ns()
                    if (kobj->parent)
                        parent = kobj->parent->sd;
                    ....
                    kernfs_create_dir_ns(parent)
                        kernfs_new_node()
                            kernfs_get(parent)
                        ....
                        /* link in */
                        rc = kernfs_add_one(kn);
                        if (!rc)
                            return kn;

                        kernfs_put(kn)
                            ....
                            repeat:
                            kmem_cache_free(kn)
                            kn = parent;

                            if (kn) {
                                if (atomic_dec_and_test(&kn->count))
                                    goto repeat;
                            }
                        ....

path2: Remove last child device under glue dir
device_del()
    cleanup_device_parent()
        cleanup_glue_dir()
            mutex_lock(&gdp_mutex);
            if (!kobject_has_children(glue_dir))
                kobject_del(glue_dir);
            kobject_put(glue_dir);
            mutex_unlock(&gdp_mutex);

Before path2 remove last child device under glue dir, If path1 add a new
device under glue dir, the glue_dir kobject reference count will be
increase to 2 via kobject_get(k) in get_device_parent(). And path1 has
been called kernfs_new_node(), but not call kernfs_get(parent).
Meanwhile, path2 call kobject_del(glue_dir) beacause 0 is returned by
kobject_has_children(). This result in glue_dir->sd is freed and it's
reference count will be 0. Then path1 call kernfs_get(parent) will trigger
a warning in kernfs_get()(WARN_ON(!atomic_read(&kn->count))) and increase
it's reference count to 1. Because glue_dir->sd is freed by path2, the next
call kernfs_add_one() by path1 will fail(This is also use-after-free)
and call atomic_dec_and_test() to decrease reference count. Because the
reference count is decremented to 0, it will also call kmem_cache_free()
to free glue_dir->sd again. This will result in double free.

In order to avoid this happening, we we should not call kobject_del() on
path2 when the reference count of glue_dir is greater than 1. So we add a
conditional statement to fix it.

The following calltrace is captured in kernel 4.14 with the following patch
applied:

commit 726e41097920 ("drivers: core: Remove glue dirs from sysfs earlier")

--------------------------------------------------------------------------
[    3.633703] WARNING: CPU: 4 PID: 513 at .../fs/kernfs/dir.c:494
                Here is WARN_ON(!atomic_read(&kn->count) in kernfs_get().
....
[    3.633986] Call trace:
[    3.633991]  kernfs_create_dir_ns+0xa8/0xb0
[    3.633994]  sysfs_create_dir_ns+0x54/0xe8
[    3.634001]  kobject_add_internal+0x22c/0x3f0
[    3.634005]  kobject_add+0xe4/0x118
[    3.634011]  device_add+0x200/0x870
[    3.634017]  _request_firmware+0x958/0xc38
[    3.634020]  request_firmware_into_buf+0x4c/0x70
....
[    3.634064] kernel BUG at .../mm/slub.c:294!
                Here is BUG_ON(object == fp) in set_freepointer().
....
[    3.634346] Call trace:
[    3.634351]  kmem_cache_free+0x504/0x6b8
[    3.634355]  kernfs_put+0x14c/0x1d8
[    3.634359]  kernfs_create_dir_ns+0x88/0xb0
[    3.634362]  sysfs_create_dir_ns+0x54/0xe8
[    3.634366]  kobject_add_internal+0x22c/0x3f0
[    3.634370]  kobject_add+0xe4/0x118
[    3.634374]  device_add+0x200/0x870
[    3.634378]  _request_firmware+0x958/0xc38
[    3.634381]  request_firmware_into_buf+0x4c/0x70
--------------------------------------------------------------------------

Fixes: 726e41097920 ("drivers: core: Remove glue dirs from sysfs earlier")

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 drivers/base/core.c | 47 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4aeaa0c92bda..e7810329223a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1739,8 +1739,9 @@ class_dir_create_and_add(struct class *class, struct kobject *parent_kobj)
 
 static DEFINE_MUTEX(gdp_mutex);
 
-static struct kobject *get_device_parent(struct device *dev,
-					 struct device *parent)
+static struct kobject *__get_device_parent(struct device *dev,
+					   struct device *parent,
+					   bool lock)
 {
 	if (dev->class) {
 		struct kobject *kobj = NULL;
@@ -1779,14 +1780,16 @@ static struct kobject *get_device_parent(struct device *dev,
 			}
 		spin_unlock(&dev->class->p->glue_dirs.list_lock);
 		if (kobj) {
-			mutex_unlock(&gdp_mutex);
+			if (!lock)
+				mutex_unlock(&gdp_mutex);
 			return kobj;
 		}
 
 		/* or create a new class-directory at the parent device */
 		k = class_dir_create_and_add(dev->class, parent_kobj);
 		/* do not emit an uevent for this simple "glue" directory */
-		mutex_unlock(&gdp_mutex);
+		if (!lock || IS_ERR(k))
+			mutex_unlock(&gdp_mutex);
 		return k;
 	}
 
@@ -1799,6 +1802,19 @@ static struct kobject *get_device_parent(struct device *dev,
 	return NULL;
 }
 
+static inline struct kobject *get_device_parent(struct device *dev,
+						struct device *parent)
+{
+	return __get_device_parent(dev, parent, false);
+}
+
+static inline struct kobject *
+get_device_parent_locked_if_glue_dir(struct device *dev,
+				     struct device *parent)
+{
+	return __get_device_parent(dev, parent, true);
+}
+
 static inline bool live_in_glue_dir(struct kobject *kobj,
 				    struct device *dev)
 {
@@ -1831,6 +1847,16 @@ static void cleanup_glue_dir(struct device *dev, struct kobject *glue_dir)
 	mutex_unlock(&gdp_mutex);
 }
 
+static inline void unlock_if_glue_dir(struct device *dev,
+				      struct kobject *glue_dir)
+{
+	/* see if we live in a "glue" directory */
+	if (!live_in_glue_dir(glue_dir, dev))
+		return;
+
+	mutex_unlock(&gdp_mutex);
+}
+
 static int device_add_class_symlinks(struct device *dev)
 {
 	struct device_node *of_node = dev_of_node(dev);
@@ -2040,7 +2066,7 @@ int device_add(struct device *dev)
 	pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
 
 	parent = get_device(dev->parent);
-	kobj = get_device_parent(dev, parent);
+	kobj = get_device_parent_locked_if_glue_dir(dev, parent);
 	if (IS_ERR(kobj)) {
 		error = PTR_ERR(kobj);
 		goto parent_error;
@@ -2055,10 +2081,12 @@ int device_add(struct device *dev)
 	/* first, register with generic layer. */
 	/* we require the name to be set before, and pass NULL */
 	error = kobject_add(&dev->kobj, dev->kobj.parent, NULL);
-	if (error) {
-		glue_dir = get_glue_dir(dev);
+
+	glue_dir = get_glue_dir(dev);
+	unlock_if_glue_dir(dev, glue_dir);
+
+	if (error)
 		goto Error;
-	}
 
 	/* notify platform of device entry */
 	error = device_platform_notify(dev, KOBJ_ADD);
@@ -2972,7 +3000,7 @@ int device_move(struct device *dev, struct device *new_parent,
 
 	device_pm_lock();
 	new_parent = get_device(new_parent);
-	new_parent_kobj = get_device_parent(dev, new_parent);
+	new_parent_kobj = get_device_parent_locked_if_glue_dir(dev, new_parent);
 	if (IS_ERR(new_parent_kobj)) {
 		error = PTR_ERR(new_parent_kobj);
 		put_device(new_parent);
@@ -2982,6 +3010,7 @@ int device_move(struct device *dev, struct device *new_parent,
 	pr_debug("device: '%s': %s: moving to '%s'\n", dev_name(dev),
 		 __func__, new_parent ? dev_name(new_parent) : "<NULL>");
 	error = kobject_move(&dev->kobj, new_parent_kobj);
+	unlock_if_glue_dir(dev, new_parent_kobj);
 	if (error) {
 		cleanup_glue_dir(dev, new_parent_kobj);
 		put_device(new_parent);
-- 
2.17.1

