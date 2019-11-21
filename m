Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D98105067
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 11:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfKUKUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 05:20:23 -0500
Received: from snd00014.auone-net.jp ([111.86.247.14]:23395 "EHLO
        dmta0003.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726132AbfKUKUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:20:23 -0500
Received: from ppp.dion.ne.jp by dmta0003.auone-net.jp with ESMTP
          id <20191121102021787.MLMY.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>;
          Thu, 21 Nov 2019 19:20:21 +0900
Date:   Thu, 21 Nov 2019 19:20:21 +0900
From:   Kusanagi Kouichi <slash@ac.auone-net.jp>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] debugfs: Fix !DEBUG_FS debugfs_create_automount
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Message-Id: <20191121102021787.MLMY.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If DEBUG_FS=n, compile fails with the following error:

kernel/trace/trace.c: In function 'tracing_init_dentry':
kernel/trace/trace.c:8658:9: error: passing argument 3 of 'debugfs_create_automount' from incompatible pointer type [-Werror=incompatible-pointer-types]
 8658 |         trace_automount, NULL);
      |         ^~~~~~~~~~~~~~~
      |         |
      |         struct vfsmount * (*)(struct dentry *, void *)
In file included from kernel/trace/trace.c:24:
./include/linux/debugfs.h:206:25: note: expected 'struct vfsmount * (*)(void *)' but argument is of type 'struct vfsmount * (*)(struct dentry *, void *)'
  206 |      struct vfsmount *(*f)(void *),
      |      ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~

Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
---
 include/linux/debugfs.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 58424eb3b329..798f0b9b43ae 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -54,6 +54,8 @@ static const struct file_operations __fops = {				\
 	.llseek  = no_llseek,						\
 }
 
+typedef struct vfsmount *(*debugfs_automount_t)(struct dentry *, void *);
+
 #if defined(CONFIG_DEBUG_FS)
 
 struct dentry *debugfs_lookup(const char *name, struct dentry *parent);
@@ -75,7 +77,6 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);
 struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 				      const char *dest);
 
-typedef struct vfsmount *(*debugfs_automount_t)(struct dentry *, void *);
 struct dentry *debugfs_create_automount(const char *name,
 					struct dentry *parent,
 					debugfs_automount_t f,
@@ -203,7 +204,7 @@ static inline struct dentry *debugfs_create_symlink(const char *name,
 
 static inline struct dentry *debugfs_create_automount(const char *name,
 					struct dentry *parent,
-					struct vfsmount *(*f)(void *),
+					debugfs_automount_t f,
 					void *data)
 {
 	return ERR_PTR(-ENODEV);
-- 
2.24.0

