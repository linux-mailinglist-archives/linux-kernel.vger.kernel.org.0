Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368AA11D507
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 19:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfLLSOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 13:14:35 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:56744 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbfLLSOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:14:35 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id D8980200A87;
        Thu, 12 Dec 2019 18:14:33 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id E118020B6E; Thu, 12 Dec 2019 19:14:29 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] initrd: use do_mount() instead of ksys_mount()
Date:   Thu, 12 Dec 2019 19:14:19 +0100
Message-Id: <20191212181422.31033-3-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191212181422.31033-1-linux@dominikbrodowski.net>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All three calls to ksys_mount() in initrd-related kernel code can
be switched over to do_mount():
- the first and third arguments are const strings in the kernel,
  and do not need to be copied over from userspace;
- the fifth argument is NULL, and therefore no page needs to be,
  copied over from userspace;
- the second and fourth argument are passed through anyway.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 init/do_mounts_initrd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index a9c6cc56f505..3bf7b74153ab 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -54,7 +54,7 @@ static int init_linuxrc(struct subprocess_info *info, struct cred *new)
 	ksys_dup(0);
 	/* move initrd over / and chdir/chroot in initrd root */
 	ksys_chdir("/root");
-	ksys_mount(".", "/", NULL, MS_MOVE, NULL);
+	do_mount(".", "/", NULL, MS_MOVE, NULL);
 	ksys_chroot(".");
 	ksys_setsid();
 	return 0;
@@ -89,7 +89,7 @@ static void __init handle_initrd(void)
 	current->flags &= ~PF_FREEZER_SKIP;
 
 	/* move initrd to rootfs' /old */
-	ksys_mount("..", ".", NULL, MS_MOVE, NULL);
+	do_mount("..", ".", NULL, MS_MOVE, NULL);
 	/* switch root and cwd back to / of rootfs */
 	ksys_chroot("..");
 
@@ -103,7 +103,7 @@ static void __init handle_initrd(void)
 	mount_root();
 
 	printk(KERN_NOTICE "Trying to move old root to /initrd ... ");
-	error = ksys_mount("/old", "/root/initrd", NULL, MS_MOVE, NULL);
+	error = do_mount("/old", "/root/initrd", NULL, MS_MOVE, NULL);
 	if (!error)
 		printk("okay\n");
 	else {
-- 
2.24.1

