Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA93311CF57
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 15:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfLLOIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 09:08:04 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:43142 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbfLLOIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:08:02 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 402AC200A94;
        Thu, 12 Dec 2019 14:08:00 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id D393A20B6E; Thu, 12 Dec 2019 15:07:57 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fs: remove ksys_dup()
Date:   Thu, 12 Dec 2019 15:07:52 +0100
Message-Id: <20191212140752.347520-3-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191212140752.347520-1-linux@dominikbrodowski.net>
References: <20191212140752.347520-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ksys_dup() is used only at one place in the kernel, namely to duplicate
fd 0 of /dev/console to stdout and stderr. The same functionality can be
achieved by using functions already available within the kernel namespace.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/file.c                |  7 +------
 include/linux/syscalls.h |  1 -
 init/main.c              | 26 ++++++++++++++++++++------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 3da91a112bab..2f4fcf985079 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -960,7 +960,7 @@ SYSCALL_DEFINE2(dup2, unsigned int, oldfd, unsigned int, newfd)
 	return ksys_dup3(oldfd, newfd, 0);
 }
 
-int ksys_dup(unsigned int fildes)
+SYSCALL_DEFINE1(dup, unsigned int, fildes)
 {
 	int ret = -EBADF;
 	struct file *file = fget_raw(fildes);
@@ -975,11 +975,6 @@ int ksys_dup(unsigned int fildes)
 	return ret;
 }
 
-SYSCALL_DEFINE1(dup, unsigned int, fildes)
-{
-	return ksys_dup(fildes);
-}
-
 int f_dupfd(unsigned int from, struct file *file, unsigned flags)
 {
 	int err;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index d0391cc2dae9..517dd0bd3939 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1234,7 +1234,6 @@ asmlinkage long sys_ni_syscall(void);
 int ksys_mount(const char __user *dev_name, const char __user *dir_name,
 	       const char __user *type, unsigned long flags, void __user *data);
 int ksys_umount(char __user *name, int flags);
-int ksys_dup(unsigned int fildes);
 int ksys_chroot(const char __user *filename);
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
 int ksys_chdir(const char __user *filename);
diff --git a/init/main.c b/init/main.c
index 2cd736059416..b397ab7aad2c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -93,6 +93,7 @@
 #include <linux/rodata_test.h>
 #include <linux/jump_label.h>
 #include <linux/mem_encrypt.h>
+#include <linux/file.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -1157,13 +1158,26 @@ static int __ref kernel_init(void *unused)
 
 void console_on_rootfs(void)
 {
-	/* Open the /dev/console as stdin, this should never fail */
-	if (ksys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
-		pr_err("Warning: unable to open an initial console.\n");
+	struct file *file;
+	unsigned int i;
+
+	/* Open /dev/console in kernelspace, this should never fail */
+	file = filp_open((const char *) "/dev/console", O_RDWR, 0);
+	if (!file)
+		goto err_out;
+
+	/* create stdin/stdout/stderr, this should never fail */
+	for (i = 0; i < 3; i++) {
+		if (f_dupfd(i, file, 0) != i)
+			goto err_out;
+	}
+
+	return;
 
-	/* create stdout/stderr */
-	(void) ksys_dup(0);
-	(void) ksys_dup(0);
+err_out:
+	/* no panic -- this might not be fatal */
+	pr_err("Warning: unable to open an initial console.\n");
+	return;
 }
 
 static noinline void __init kernel_init_freeable(void)
-- 
2.24.1

