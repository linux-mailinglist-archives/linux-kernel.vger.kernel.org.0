Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D55B6E766
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 16:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfGSOc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 10:32:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:41232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729754AbfGSOc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:32:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC6FBAFF1;
        Fri, 19 Jul 2019 14:32:27 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 4/4] ceph: fix buffer free while holding i_ceph_lock in fill_inode()
Date:   Fri, 19 Jul 2019 15:32:22 +0100
Message-Id: <20190719143222.16058-5-lhenriques@suse.com>
In-Reply-To: <20190719143222.16058-1-lhenriques@suse.com>
References: <20190719143222.16058-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling ceph_buffer_put() in fill_inode() may result in freeing the
i_xattrs.blob buffer while holding the i_ceph_lock.  This can be fixed by
postponing the call until later, when the lock is released.

The following backtrace was triggered by fstests generic/070.

  BUG: sleeping function called from invalid context at mm/vmalloc.c:2283
  in_atomic(): 1, irqs_disabled(): 0, pid: 3852, name: kworker/0:4
  6 locks held by kworker/0:4/3852:
   #0: 000000004270f6bb ((wq_completion)ceph-msgr){+.+.}, at: process_one_work+0x1b8/0x5f0
   #1: 00000000eb420803 ((work_completion)(&(&con->work)->work)){+.+.}, at: process_one_work+0x1b8/0x5f0
   #2: 00000000be1c53a4 (&s->s_mutex){+.+.}, at: dispatch+0x288/0x1476
   #3: 00000000559cb958 (&mdsc->snap_rwsem){++++}, at: dispatch+0x2eb/0x1476
   #4: 000000000d5ebbae (&req->r_fill_mutex){+.+.}, at: dispatch+0x2fc/0x1476
   #5: 00000000a83d0514 (&(&ci->i_ceph_lock)->rlock){+.+.}, at: fill_inode.isra.0+0xf8/0xf70
  CPU: 0 PID: 3852 Comm: kworker/0:4 Not tainted 5.2.0+ #441
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
  Workqueue: ceph-msgr ceph_con_workfn
  Call Trace:
   dump_stack+0x67/0x90
   ___might_sleep.cold+0x9f/0xb1
   vfree+0x4b/0x60
   ceph_buffer_release+0x1b/0x60
   fill_inode.isra.0+0xa9b/0xf70
   ceph_fill_trace+0x13b/0xc70
   ? dispatch+0x2eb/0x1476
   dispatch+0x320/0x1476
   ? __mutex_unlock_slowpath+0x4d/0x2a0
   ceph_con_workfn+0xc97/0x2ec0
   ? process_one_work+0x1b8/0x5f0
   process_one_work+0x244/0x5f0
   worker_thread+0x4d/0x3e0
   kthread+0x105/0x140
   ? process_one_work+0x5f0/0x5f0
   ? kthread_park+0x90/0x90
   ret_from_fork+0x3a/0x50

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 791f84a13bb8..18500edefc56 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -736,6 +736,7 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 	int issued, new_issued, info_caps;
 	struct timespec64 mtime, atime, ctime;
 	struct ceph_buffer *xattr_blob = NULL;
+	struct ceph_buffer *old_blob = NULL;
 	struct ceph_string *pool_ns = NULL;
 	struct ceph_cap *new_cap = NULL;
 	int err = 0;
@@ -881,7 +882,7 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 	if ((ci->i_xattrs.version == 0 || !(issued & CEPH_CAP_XATTR_EXCL))  &&
 	    le64_to_cpu(info->xattr_version) > ci->i_xattrs.version) {
 		if (ci->i_xattrs.blob)
-			ceph_buffer_put(ci->i_xattrs.blob);
+			old_blob = ci->i_xattrs.blob;
 		ci->i_xattrs.blob = xattr_blob;
 		if (xattr_blob)
 			memcpy(ci->i_xattrs.blob->vec.iov_base,
@@ -1022,8 +1023,8 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 out:
 	if (new_cap)
 		ceph_put_cap(mdsc, new_cap);
-	if (xattr_blob)
-		ceph_buffer_put(xattr_blob);
+	ceph_buffer_put(old_blob);
+	ceph_buffer_put(xattr_blob);
 	ceph_put_string(pool_ns);
 	return err;
 }
