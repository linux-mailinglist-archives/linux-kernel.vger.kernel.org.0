Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2AA277AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 10:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfEWIHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 04:07:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfEWIHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:07:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 974FE81106
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 08:07:01 +0000 (UTC)
Received: from zhyan-laptop.redhat.com (ovpn-12-163.pek2.redhat.com [10.72.12.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95B745D9C6;
        Thu, 23 May 2019 08:06:59 +0000 (UTC)
From:   "Yan, Zheng" <zyan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     idryomov@redhat.com, jlayton@redhat.com
Subject: [PATCH 5/8] ceph: fix dir_lease_is_valid()
Date:   Thu, 23 May 2019 16:06:43 +0800
Message-Id: <20190523080646.19632-5-zyan@redhat.com>
In-Reply-To: <20190523080646.19632-1-zyan@redhat.com>
References: <20190523080646.19632-1-zyan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 23 May 2019 08:07:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should call __ceph_dentry_dir_lease_touch() under dentry->d_lock.
Besides, ceph_dentry(dentry) can be NULL when called by LOOKUP_RCU
d_revalidate()

Cc: stable@vger.kernel.org # v5.1+
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/dir.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 0637149fb9f9..1271024a3797 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1512,18 +1512,26 @@ static int __dir_lease_try_check(const struct dentry *dentry)
 static int dir_lease_is_valid(struct inode *dir, struct dentry *dentry)
 {
 	struct ceph_inode_info *ci = ceph_inode(dir);
-	struct ceph_dentry_info *di = ceph_dentry(dentry);
-	int valid = 0;
+	int valid;
+	int shared_gen;
 
 	spin_lock(&ci->i_ceph_lock);
-	if (atomic_read(&ci->i_shared_gen) == di->lease_shared_gen)
-		valid = __ceph_caps_issued_mask(ci, CEPH_CAP_FILE_SHARED, 1);
+	valid = __ceph_caps_issued_mask(ci, CEPH_CAP_FILE_SHARED, 1);
+	shared_gen = atomic_read(&ci->i_shared_gen);
 	spin_unlock(&ci->i_ceph_lock);
-	if (valid)
-		__ceph_dentry_dir_lease_touch(di);
-	dout("dir_lease_is_valid dir %p v%u dentry %p v%u = %d\n",
-	     dir, (unsigned)atomic_read(&ci->i_shared_gen),
-	     dentry, (unsigned)di->lease_shared_gen, valid);
+	if (valid) {
+		struct ceph_dentry_info *di;
+		spin_lock(&dentry->d_lock);
+		di = ceph_dentry(dentry);
+		if (dir == d_inode(dentry->d_parent) &&
+		    di && di->lease_shared_gen == shared_gen)
+			__ceph_dentry_dir_lease_touch(di);
+		else
+			valid = 0;
+		spin_unlock(&dentry->d_lock);
+	}
+	dout("dir_lease_is_valid dir %p v%u dentry %p = %d\n",
+	     dir, (unsigned)atomic_read(&ci->i_shared_gen), dentry, valid);
 	return valid;
 }
 
-- 
2.17.2

