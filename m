Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3962C17AF02
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 20:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgCETf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 14:35:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44836 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgCETfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 14:35:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id n7so8438573wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 11:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38DgGiPjwZSpDF6N7m93SvJVUYapT7VRD+CEpbcc/1g=;
        b=RWxHDXt+4syqnJPIwJ2HB8p/I2BbkFMJ9IUSLJFs2bBxyrKhYsftdIcfkxy8ycJgsG
         J6Iuqm41XaysUCVFVwmyr295oYDY/vFX1MatpGuMVYld7r5GTzn6kiKFU8EWF1hnOC5T
         zRNSuYWUqHZaGQIucodznSpMlpetewcq+pJRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38DgGiPjwZSpDF6N7m93SvJVUYapT7VRD+CEpbcc/1g=;
        b=jKCcgWw9kMpV++8Kiee0dpSkynDimMFZ/qvkEGGYBnXHSdBRTe+1l2EgLbMLOWZYjg
         VbddQX4/RsOYAMMbVLE6Qsw3nQEdX5bv3eZL06n39qW0gcwnk2BhOAXWwsmMkWCMeZPO
         50M2H6JaplFU3F0Fj9TvVQfyw0JNAMGK6SIjEi4WNfjuSvCZrIgI5tiBi7sVwzmfaBt+
         ONlldQk8Ao7JNlcz+CruOlS+Mp4PbawlsgoarTJE/3LG82Gcgx1AN3Z02SX8o9Gx2y+I
         uOU708olP/GNFYGSFMY92+WuKzWOtPW/TP6IrYzPQ83nuJm2q2VpJ1sEp6//cZFutRqp
         ocIQ==
X-Gm-Message-State: ANhLgQ0dFZJznmqTFd/KhW8cGWhQJ8/bRXVQg8IbXifH3BtD9LxgW9BR
        kqSG/unO571153IRF8sJg81HvA==
X-Google-Smtp-Source: ADFU+vu0oJrA1+m4P9vna1RTuRkGjRwiIL6Hy+SKK9W1YqIlpXJU1vl6yJ5AVNo88S4yAen8RpmeqQ==
X-Received: by 2002:a5d:4f03:: with SMTP id c3mr465574wru.336.1583436952398;
        Thu, 05 Mar 2020 11:35:52 -0800 (PST)
Received: from localhost.localdomain ([217.138.62.245])
        by smtp.gmail.com with ESMTPSA id f127sm10751327wma.4.2020.03.05.11.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 11:35:51 -0800 (PST)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH] mnt: add support for non-rootfs initramfs
Date:   Thu,  5 Mar 2020 19:35:11 +0000
Message-Id: <20200305193511.28621-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main need for this is to support container runtimes on stateless Linux
system (pivot_root system call from initramfs).

Normally, the task of initramfs is to mount and switch to a "real" root
filesystem. However, on stateless systems (booting over the network) it is just
convenient to have your "real" filesystem as initramfs from the start.

This, however, breaks different container runtimes, because they usually use
pivot_root system call after creating their mount namespace. But pivot_root does
not work from initramfs, because initramfs runs form rootfs, which is the root
of the mount tree and can't be unmounted.

One can solve this problem from userspace, but it is much more cumbersome. We
either have to create a multilayered archive for initramfs, where the outer
layer creates a tmpfs filesystem and unpacks the inner layer, switches root and
does not forget to properly cleanup the old rootfs. Or we need to use keepinitrd
kernel cmdline option, unpack initramfs to rootfs, run a script to create our
target tmpfs root, unpack the same initramfs there, switch root to it and again
properly cleanup the old root, thus unpacking the same archive twice and also
wasting memory, because kernel stores compressed initramfs image indefinitely.

With this change we can ask the kernel (by specifying nonroot_initramfs kernel
cmdline option) to create a "leaf" tmpfs mount for us and switch root to it
before the initramfs handling code, so initramfs gets unpacked directly into
the "leaf" tmpfs with rootfs being empty and no need to clean up anything.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 fs/namespace.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 85b5f7bea82e..a1ec862e8146 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3701,6 +3701,49 @@ static void __init init_mount_tree(void)
 	set_fs_root(current->fs, &root);
 }
 
+#if IS_ENABLED(CONFIG_TMPFS)
+static int __initdata nonroot_initramfs;
+
+static int __init nonroot_initramfs_param(char *str)
+{
+	if (*str)
+		return 0;
+	nonroot_initramfs = 1;
+	return 1;
+}
+__setup("nonroot_initramfs", nonroot_initramfs_param);
+
+static void __init init_nonroot_initramfs(void)
+{
+	int err;
+
+	if (!nonroot_initramfs)
+		return;
+
+	err = ksys_mkdir("/root", 0700);
+	if (err < 0)
+		goto out;
+
+	err = do_mount("tmpfs", "/root", "tmpfs", 0, NULL);
+	if (err)
+		goto out;
+
+	err = ksys_chdir("/root");
+	if (err)
+		goto out;
+
+	err = do_mount(".", "/", NULL, MS_MOVE, NULL);
+	if (err)
+		goto out;
+
+	err = ksys_chroot(".");
+	if (!err)
+		return;
+out:
+	printk(KERN_WARNING "Failed to create a non-root filesystem for initramfs\n");
+}
+#endif /* IS_ENABLED(CONFIG_TMPFS) */
+
 void __init mnt_init(void)
 {
 	int err;
@@ -3734,6 +3777,10 @@ void __init mnt_init(void)
 	shmem_init();
 	init_rootfs();
 	init_mount_tree();
+
+#if IS_ENABLED(CONFIG_TMPFS)
+	init_nonroot_initramfs();
+#endif
 }
 
 void put_mnt_ns(struct mnt_namespace *ns)
-- 
2.20.1

