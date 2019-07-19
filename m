Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 863556E769
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 16:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfGSOcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 10:32:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:41258 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729732AbfGSOc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:32:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03DD9B0BD;
        Fri, 19 Jul 2019 14:32:27 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 3/4] ceph: fix buffer free while holding i_ceph_lock in __ceph_build_xattrs_blob()
Date:   Fri, 19 Jul 2019 15:32:21 +0100
Message-Id: <20190719143222.16058-4-lhenriques@suse.com>
In-Reply-To: <20190719143222.16058-1-lhenriques@suse.com>
References: <20190719143222.16058-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling ceph_buffer_put() in __ceph_build_xattrs_blob() may result in
freeing the i_xattrs.blob buffer while holding the i_ceph_lock.  This can
be fixed by having this function returning the old blob buffer and have
the callers of this function freeing it when the lock is released.

The following backtrace was triggered by fstests generic/117.

  BUG: sleeping function called from invalid context at mm/vmalloc.c:2283
  in_atomic(): 1, irqs_disabled(): 0, pid: 649, name: fsstress
  4 locks held by fsstress/649:
   #0: 00000000a7478e7e (&type->s_umount_key#19){++++}, at: iterate_supers+0x77/0xf0
   #1: 00000000f8de1423 (&(&ci->i_ceph_lock)->rlock){+.+.}, at: ceph_check_caps+0x7b/0xc60
   #2: 00000000562f2b27 (&s->s_mutex){+.+.}, at: ceph_check_caps+0x3bd/0xc60
   #3: 00000000f83ce16a (&mdsc->snap_rwsem){++++}, at: ceph_check_caps+0x3ed/0xc60
  CPU: 1 PID: 649 Comm: fsstress Not tainted 5.2.0+ #439
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
  Call Trace:
   dump_stack+0x67/0x90
   ___might_sleep.cold+0x9f/0xb1
   vfree+0x4b/0x60
   ceph_buffer_release+0x1b/0x60
   __ceph_build_xattrs_blob+0x12b/0x170
   __send_cap+0x302/0x540
   ? __lock_acquire+0x23c/0x1e40
   ? __mark_caps_flushing+0x15c/0x280
   ? _raw_spin_unlock+0x24/0x30
   ceph_check_caps+0x5f0/0xc60
   ceph_flush_dirty_caps+0x7c/0x150
   ? __ia32_sys_fdatasync+0x20/0x20
   ceph_sync_fs+0x5a/0x130
   iterate_supers+0x8f/0xf0
   ksys_sync+0x4f/0xb0
   __ia32_sys_sync+0xa/0x10
   do_syscall_64+0x50/0x1c0
   entry_SYSCALL_64_after_hwframe+0x49/0xbe
  RIP: 0033:0x7fc6409ab617

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/caps.c  |  5 ++++-
 fs/ceph/snap.c  |  4 +++-
 fs/ceph/super.h |  2 +-
 fs/ceph/xattr.c | 11 ++++++++---
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d98dcd976c80..ce0f5658720a 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1301,6 +1301,7 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 {
 	struct ceph_inode_info *ci = cap->ci;
 	struct inode *inode = &ci->vfs_inode;
+	struct ceph_buffer *old_blob = NULL;
 	struct cap_msg_args arg;
 	int held, revoking;
 	int wake = 0;
@@ -1365,7 +1366,7 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 	ci->i_requested_max_size = arg.max_size;
 
 	if (flushing & CEPH_CAP_XATTR_EXCL) {
-		__ceph_build_xattrs_blob(ci);
+		old_blob = __ceph_build_xattrs_blob(ci);
 		arg.xattr_version = ci->i_xattrs.version;
 		arg.xattr_buf = ci->i_xattrs.blob;
 	} else {
@@ -1409,6 +1410,8 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 
 	spin_unlock(&ci->i_ceph_lock);
 
+	ceph_buffer_put(old_blob);
+
 	ret = send_cap_msg(&arg);
 	if (ret < 0) {
 		dout("error sending cap msg, must requeue %p\n", inode);
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 4c6494eb02b5..ccfcc66aaf44 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -465,6 +465,7 @@ void ceph_queue_cap_snap(struct ceph_inode_info *ci)
 	struct inode *inode = &ci->vfs_inode;
 	struct ceph_cap_snap *capsnap;
 	struct ceph_snap_context *old_snapc, *new_snapc;
+	struct ceph_buffer *old_blob = NULL;
 	int used, dirty;
 
 	capsnap = kzalloc(sizeof(*capsnap), GFP_NOFS);
@@ -541,7 +542,7 @@ void ceph_queue_cap_snap(struct ceph_inode_info *ci)
 	capsnap->gid = inode->i_gid;
 
 	if (dirty & CEPH_CAP_XATTR_EXCL) {
-		__ceph_build_xattrs_blob(ci);
+		old_blob = __ceph_build_xattrs_blob(ci);
 		capsnap->xattr_blob =
 			ceph_buffer_get(ci->i_xattrs.blob);
 		capsnap->xattr_version = ci->i_xattrs.version;
@@ -584,6 +585,7 @@ void ceph_queue_cap_snap(struct ceph_inode_info *ci)
 	}
 	spin_unlock(&ci->i_ceph_lock);
 
+	ceph_buffer_put(old_blob);
 	kfree(capsnap);
 	ceph_put_snap_context(old_snapc);
 }
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index d2352fd95dbc..6b9f1ee7de85 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -926,7 +926,7 @@ extern int ceph_getattr(const struct path *path, struct kstat *stat,
 int __ceph_setxattr(struct inode *, const char *, const void *, size_t, int);
 ssize_t __ceph_getxattr(struct inode *, const char *, void *, size_t);
 extern ssize_t ceph_listxattr(struct dentry *, char *, size_t);
-extern void __ceph_build_xattrs_blob(struct ceph_inode_info *ci);
+extern struct ceph_buffer *__ceph_build_xattrs_blob(struct ceph_inode_info *ci);
 extern void __ceph_destroy_xattrs(struct ceph_inode_info *ci);
 extern const struct xattr_handler *ceph_xattr_handlers[];
 
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index c083557b3657..939eab7aa219 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -754,12 +754,15 @@ static int __get_required_blob_size(struct ceph_inode_info *ci, int name_size,
 
 /*
  * If there are dirty xattrs, reencode xattrs into the prealloc_blob
- * and swap into place.
+ * and swap into place.  It returns the old i_xattrs.blob (or NULL) so
+ * that it can be freed by the caller as the i_ceph_lock is likely to be
+ * held.
  */
-void __ceph_build_xattrs_blob(struct ceph_inode_info *ci)
+struct ceph_buffer *__ceph_build_xattrs_blob(struct ceph_inode_info *ci)
 {
 	struct rb_node *p;
 	struct ceph_inode_xattr *xattr = NULL;
+	struct ceph_buffer *old_blob = NULL;
 	void *dest;
 
 	dout("__build_xattrs_blob %p\n", &ci->vfs_inode);
@@ -790,12 +793,14 @@ void __ceph_build_xattrs_blob(struct ceph_inode_info *ci)
 			dest - ci->i_xattrs.prealloc_blob->vec.iov_base;
 
 		if (ci->i_xattrs.blob)
-			ceph_buffer_put(ci->i_xattrs.blob);
+			old_blob = ci->i_xattrs.blob;
 		ci->i_xattrs.blob = ci->i_xattrs.prealloc_blob;
 		ci->i_xattrs.prealloc_blob = NULL;
 		ci->i_xattrs.dirty = false;
 		ci->i_xattrs.version++;
 	}
+
+	return old_blob;
 }
 
 static inline int __get_request_mask(struct inode *in) {
