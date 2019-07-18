Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 034166CD49
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 13:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfGRLUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 07:20:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35180 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfGRLUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:20:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so13731081plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 04:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D0sC1W3UjMhqj0FoOAEO96bnRmwdpJEmPkuk0v2kCeA=;
        b=tumYPmG56ZJ/LFrQQi9L0UidP/ddDIj9kZYBqjkSuEj/vQhCfMwuYSHpehEFLSPqf8
         JYt/N6G1kXby8TiEANKXUocjKxt7OBGPThfJdXy3/auOdkOSiQponkHwV4cEmLbXRmuf
         D3N1Eq7gwE8KRYxvpkDeq7xx191CKiOZUZDtJerl/tI0VybAkJsXyg2f5FkFXEwwXkRn
         JfEnLho7ymlirE5LIlhc2FT1zBLmFkUfjSQ2P7At0N4IzUdzdIxSeYESCvuUAGtY6oBO
         A0nHNndeAx4BrOxoWy/fSGbcR8yhpv1jEh1CWHhVo3jjursHhKQUxZ8h4XQOplkP9TnX
         Eluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D0sC1W3UjMhqj0FoOAEO96bnRmwdpJEmPkuk0v2kCeA=;
        b=KLiGPyohhUemQIp4ZjiJZjgLYTth7LxeGaF/N3fYWt1K3CQFAD3pQpKP1JuByHmh4b
         gSEGjpzyO+Zs6W8FvpKkbjpKzX4XpQuMC7LTc0KAHoCDS7QdLEDuL0Rv2Wdl4GjUfsN8
         aUWIzNkp5tzu2xHsJMidd2RRoNLmjJsGVx9bkVWu6lI3HY82L7Tneq2jmbYrrf3o7+49
         y7s6HxNwntjS4BdxMj3oKNvGsFgw3d9Sxa3TDzNSF+lY6dilMbdlJoopZhaEpOENhWkm
         cHwbJzZa1tkEjuNSuzSLnJfaBLB8Rp1mtX4m0Vco+JsVaEBjRhXb8XTpXjR0J1/3X3qu
         M4mg==
X-Gm-Message-State: APjAAAX6dgRo8RIBkcl/9PmQTKvOHqCmLX+W87y836l69rOS1fU786fP
        c/dwhGbkaJXOily8PWCIy0o=
X-Google-Smtp-Source: APXvYqwcsmd01CkW73NHBtOcPJARk1r/1diBdA9D4n5Ojjs50SBUrfxub+oCciohBwqdZ6JTIN1sHg==
X-Received: by 2002:a17:902:2be8:: with SMTP id l95mr45384001plb.231.1563448822864;
        Thu, 18 Jul 2019 04:20:22 -0700 (PDT)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id 135sm26382426pfb.137.2019.07.18.04.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 04:20:22 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     benh@kernel.crashing.org, prsood@codeaurora.org,
        mojha@codeaurora.org, gkohli@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] driver core: Fix use-after-free and double free on glue directory
Date:   Thu, 18 Jul 2019 19:19:58 +0800
Message-Id: <20190718111958.17336-1-smuchun@gmail.com>
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

In order to avoid this happening, we also should make sure that kernfs_node
for glue_dir is released in path2 only when refcount for glue_dir kobj is
1 to fix this race.

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

Change in v5:
       1. Revert to the v1 fix.
       2. Add some comment to explain why we need do this in
          cleanup_glue_dir().
Change in v4:
       1. Add some kerneldoc comment.
       2. Remove unlock_if_glue_dir().
       3. Rename get_device_parent_locked_if_glue_dir() to
          get_device_parent_locked.
       4. Update commit message.
Change in v3:
       Add change log.
Change in v2:
       Fix device_move() also.

 drivers/base/core.c | 54 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4aeaa0c92bda..1a67ee325584 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1825,7 +1825,59 @@ static void cleanup_glue_dir(struct device *dev, struct kobject *glue_dir)
 		return;
 
 	mutex_lock(&gdp_mutex);
-	if (!kobject_has_children(glue_dir))
+	/**
+	 * There is a race condition between removing glue directory
+	 * and adding a new device under the glue directory.
+	 *
+	 * path 1: Add the child device under glue dir
+	 * device_add()
+	 *	get_device_parent()
+	 *		mutex_lock(&gdp_mutex);
+	 *		....
+	 *		list_for_each_entry(k, &dev->class->p->glue_dirs.list,
+	 *				    entry)
+	 *		if (k->parent == parent_kobj) {
+	 *			kobj = kobject_get(k);
+	 *			break;
+	 *		}
+	 *		....
+	 *		mutex_unlock(&gdp_mutex);
+	 *		....
+	 *	....
+	 *	kobject_add()
+	 *		kobject_add_internal()
+	 *		create_dir()
+	 *			....
+	 *			if (kobj->parent)
+	 *				parent = kobj->parent->sd;
+	 *			....
+	 *			kernfs_create_dir_ns(parent)
+	 *				....
+	 *
+	 * path2: Remove last child device under glue dir
+	 * device_del()
+	 *	cleanup_glue_dir()
+	 *		....
+	 *		mutex_lock(&gdp_mutex);
+	 *		if (!kobject_has_children(glue_dir))
+	 *			kobject_del(glue_dir);
+	 *		....
+	 *		mutex_unlock(&gdp_mutex);
+	 *
+	 * Before path2 remove last child device under glue dir, if path1 add
+	 * a new device under glue dir, the glue_dir kobject reference count
+	 * will be increase to 2 via kobject_get(k) in get_device_parent().
+	 * And path1 has been called kernfs_create_dir_ns(). Meanwhile,
+	 * path2 call kobject_del(glue_dir) beacause 0 is returned by
+	 * kobject_has_children(). This result in glue_dir->sd is freed.
+	 * Then the path1 will see a stale "empty" but still potentially used
+	 * glue dir around.
+	 *
+	 * In order to avoid this happening, we also should make sure that
+	 * kernfs_node for glue_dir is released in path2 only when refcount
+	 * for glue_dir kobj is 1.
+	 */
+	if (!kobject_has_children(glue_dir) && kref_read(&glue_dir->kref) == 1)
 		kobject_del(glue_dir);
 	kobject_put(glue_dir);
 	mutex_unlock(&gdp_mutex);
-- 
2.17.1

