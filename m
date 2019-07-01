Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7756E277A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 10:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfEWIHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 04:07:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65485 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbfEWIG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:06:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCB73C057F2F
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 08:06:58 +0000 (UTC)
Received: from zhyan-laptop.redhat.com (ovpn-12-163.pek2.redhat.com [10.72.12.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26B3A5D9C6;
        Thu, 23 May 2019 08:06:56 +0000 (UTC)
From:   "Yan, Zheng" <zyan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     idryomov@redhat.com, jlayton@redhat.com
Subject: [PATCH 4/8] ceph: close race between d_name_cmp() and update_dentry_lease()
Date:   Thu, 23 May 2019 16:06:42 +0800
Message-Id: <20190523080646.19632-4-zyan@redhat.com>
In-Reply-To: <20190523080646.19632-1-zyan@redhat.com>
References: <20190523080646.19632-1-zyan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 23 May 2019 08:06:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

d_name_cmp() and update_dentry_lease() lock and unlock dentry->d_lock
respectively. Dentry may get renamed between them. The fix is moving
the dentry name compare into update_dentry_lease().

This patch introduce two version of update_dentry_lease(). One version
is for the case that parent inode is locked. It does not need to check
parent/target inode and dentry name. Another version is for the case
that parent inode is not locked. It checks arent/target inode and dentry
name after locking dentry->d_lock.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/inode.c | 164 ++++++++++++++++++++++++++----------------------
 1 file changed, 88 insertions(+), 76 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 8cfece240ffe..e47a25495be5 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1031,59 +1031,38 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 }
 
 /*
- * caller should hold session s_mutex.
+ * caller should hold session s_mutex and dentry->d_lock.
  */
-static void update_dentry_lease(struct dentry *dentry,
-				struct ceph_mds_reply_lease *lease,
-				struct ceph_mds_session *session,
-				unsigned long from_time,
-				struct ceph_vino *tgt_vino,
-				struct ceph_vino *dir_vino)
+static void __update_dentry_lease(struct inode *dir, struct dentry *dentry,
+				  struct ceph_mds_reply_lease *lease,
+				  struct ceph_mds_session *session,
+				  unsigned long from_time,
+				  struct ceph_mds_session **old_lease_session)
 {
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	long unsigned duration = le32_to_cpu(lease->duration_ms);
 	long unsigned ttl = from_time + (duration * HZ) / 1000;
 	long unsigned half_ttl = from_time + (duration * HZ / 2) / 1000;
-	struct inode *dir;
-	struct ceph_mds_session *old_lease_session = NULL;
-
-	/*
-	 * Make sure dentry's inode matches tgt_vino. NULL tgt_vino means that
-	 * we expect a negative dentry.
-	 */
-	if (!tgt_vino && d_really_is_positive(dentry))
-		return;
-
-	if (tgt_vino && (d_really_is_negative(dentry) ||
-			!ceph_ino_compare(d_inode(dentry), tgt_vino)))
-		return;
 
-	spin_lock(&dentry->d_lock);
 	dout("update_dentry_lease %p duration %lu ms ttl %lu\n",
 	     dentry, duration, ttl);
 
-	dir = d_inode(dentry->d_parent);
-
-	/* make sure parent matches dir_vino */
-	if (!ceph_ino_compare(dir, dir_vino))
-		goto out_unlock;
-
 	/* only track leases on regular dentries */
 	if (ceph_snap(dir) != CEPH_NOSNAP)
-		goto out_unlock;
+		return;
 
 	di->lease_shared_gen = atomic_read(&ceph_inode(dir)->i_shared_gen);
 	if (duration == 0) {
 		__ceph_dentry_dir_lease_touch(di);
-		goto out_unlock;
+		return;
 	}
 
 	if (di->lease_gen == session->s_cap_gen &&
 	    time_before(ttl, di->time))
-		goto out_unlock;  /* we already have a newer lease. */
+		return;  /* we already have a newer lease. */
 
 	if (di->lease_session && di->lease_session != session) {
-		old_lease_session = di->lease_session;
+		*old_lease_session = di->lease_session;
 		di->lease_session = NULL;
 	}
 
@@ -1096,6 +1075,62 @@ static void update_dentry_lease(struct dentry *dentry,
 	di->time = ttl;
 
 	__ceph_dentry_lease_touch(di);
+}
+
+static inline void update_dentry_lease(struct inode *dir, struct dentry *dentry,
+					struct ceph_mds_reply_lease *lease,
+					struct ceph_mds_session *session,
+					unsigned long from_time)
+{
+	struct ceph_mds_session *old_lease_session = NULL;
+	spin_lock(&dentry->d_lock);
+	__update_dentry_lease(dir, dentry, lease, session, from_time,
+			      &old_lease_session);
+	spin_unlock(&dentry->d_lock);
+	if (old_lease_session)
+		ceph_put_mds_session(old_lease_session);
+}
+
+/*
+ * update dentry lease without having parent inode locked
+ */
+static void update_dentry_lease_careful(struct dentry *dentry,
+					struct ceph_mds_reply_lease *lease,
+					struct ceph_mds_session *session,
+					unsigned long from_time,
+					char *dname, u32 dname_len,
+					struct ceph_vino *pdvino,
+					struct ceph_vino *ptvino)
+
+{
+	struct inode *dir;
+	struct ceph_mds_session *old_lease_session = NULL;
+
+	spin_lock(&dentry->d_lock);
+	/* make sure dentry's name matches target */
+	if (dentry->d_name.len != dname_len ||
+	    memcmp(dentry->d_name.name, dname, dname_len))
+		goto out_unlock;
+
+	dir = d_inode(dentry->d_parent);
+	/* make sure parent matches dvino */
+	if (!ceph_ino_compare(dir, pdvino))
+		goto out_unlock;
+
+	/* make sure dentry's inode matches target. NULL ptvino means that
+	 * we expect a negative dentry */
+	if (ptvino) {
+		if (d_really_is_negative(dentry))
+			goto out_unlock;
+		if (!ceph_ino_compare(d_inode(dentry), ptvino))
+			goto out_unlock;
+	} else {
+		if (d_really_is_positive(dentry))
+			goto out_unlock;
+	}
+
+	__update_dentry_lease(dir, dentry, lease, session,
+			      from_time, &old_lease_session);
 out_unlock:
 	spin_unlock(&dentry->d_lock);
 	if (old_lease_session)
@@ -1160,19 +1195,6 @@ static int splice_dentry(struct dentry **pdn, struct inode *in)
 	return 0;
 }
 
-static int d_name_cmp(struct dentry *dentry, const char *name, size_t len)
-{
-	int ret;
-
-	/* take d_lock to ensure dentry->d_name stability */
-	spin_lock(&dentry->d_lock);
-	ret = dentry->d_name.len - len;
-	if (!ret)
-		ret = memcmp(dentry->d_name.name, name, len);
-	spin_unlock(&dentry->d_lock);
-	return ret;
-}
-
 /*
  * Incorporate results into the local cache.  This is either just
  * one inode, or a directory, dentry, and possibly linked-to inode (e.g.,
@@ -1375,10 +1397,9 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			} else if (have_lease) {
 				if (d_unhashed(dn))
 					d_add(dn, NULL);
-				update_dentry_lease(dn, rinfo->dlease,
-						    session,
-						    req->r_request_started,
-						    NULL, &dvino);
+				update_dentry_lease(dir, dn,
+						    rinfo->dlease, session,
+						    req->r_request_started);
 			}
 			goto done;
 		}
@@ -1400,11 +1421,9 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		}
 
 		if (have_lease) {
-			tvino.ino = le64_to_cpu(rinfo->targeti.in->ino);
-			tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
-			update_dentry_lease(dn, rinfo->dlease, session,
-					    req->r_request_started,
-					    &tvino, &dvino);
+			update_dentry_lease(dir, dn,
+					    rinfo->dlease, session,
+					    req->r_request_started);
 		}
 		dout(" final dn %p\n", dn);
 	} else if ((req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
@@ -1422,27 +1441,20 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		err = splice_dentry(&req->r_dentry, in);
 		if (err < 0)
 			goto done;
-	} else if (rinfo->head->is_dentry &&
-		   !d_name_cmp(req->r_dentry, rinfo->dname, rinfo->dname_len)) {
+	} else if (rinfo->head->is_dentry && req->r_dentry) {
+		/* parent inode is not locked, be carefull */
 		struct ceph_vino *ptvino = NULL;
-
-		if ((le32_to_cpu(rinfo->diri.in->cap.caps) & CEPH_CAP_FILE_SHARED) ||
-		    le32_to_cpu(rinfo->dlease->duration_ms)) {
-			dvino.ino = le64_to_cpu(rinfo->diri.in->ino);
-			dvino.snap = le64_to_cpu(rinfo->diri.in->snapid);
-
-			if (rinfo->head->is_target) {
-				tvino.ino = le64_to_cpu(rinfo->targeti.in->ino);
-				tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
-				ptvino = &tvino;
-			}
-
-			update_dentry_lease(req->r_dentry, rinfo->dlease,
-				session, req->r_request_started, ptvino,
-				&dvino);
-		} else {
-			dout("%s: no dentry lease or dir cap\n", __func__);
+		dvino.ino = le64_to_cpu(rinfo->diri.in->ino);
+		dvino.snap = le64_to_cpu(rinfo->diri.in->snapid);
+		if (rinfo->head->is_target) {
+			tvino.ino = le64_to_cpu(rinfo->targeti.in->ino);
+			tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
+			ptvino = &tvino;
 		}
+		update_dentry_lease_careful(req->r_dentry, rinfo->dlease,
+					    session, req->r_request_started,
+					    rinfo->dname, rinfo->dname_len,
+					    &dvino, ptvino);
 	}
 done:
 	dout("fill_trace done err=%d\n", err);
@@ -1604,7 +1616,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	/* FIXME: release caps/leases if error occurs */
 	for (i = 0; i < rinfo->dir_nr; i++) {
 		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
-		struct ceph_vino tvino, dvino;
+		struct ceph_vino tvino;
 
 		dname.name = rde->name;
 		dname.len = rde->name_len;
@@ -1705,9 +1717,9 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 
 		ceph_dentry(dn)->offset = rde->offset;
 
-		dvino = ceph_vino(d_inode(parent));
-		update_dentry_lease(dn, rde->lease, req->r_session,
-				    req->r_request_started, &tvino, &dvino);
+		update_dentry_lease(d_inode(parent), dn,
+				    rde->lease, req->r_session,
+				    req->r_request_started);
 
 		if (err == 0 && skipped == 0 && cache_ctl.index >= 0) {
 			ret = fill_readdir_cache(d_inode(parent), dn,
-- 
2.17.2

