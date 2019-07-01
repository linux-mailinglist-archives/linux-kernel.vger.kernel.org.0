Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B27B9277A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 10:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfEWIHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 04:07:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730051AbfEWIHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:07:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF98E99DDE
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 08:07:04 +0000 (UTC)
Received: from zhyan-laptop.redhat.com (ovpn-12-163.pek2.redhat.com [10.72.12.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 432315D9C6;
        Thu, 23 May 2019 08:07:01 +0000 (UTC)
From:   "Yan, Zheng" <zyan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     idryomov@redhat.com, jlayton@redhat.com
Subject: [PATCH 6/8] ceph: use READ_ONCE to access d_parent in RCU critical section
Date:   Thu, 23 May 2019 16:06:44 +0800
Message-Id: <20190523080646.19632-6-zyan@redhat.com>
In-Reply-To: <20190523080646.19632-1-zyan@redhat.com>
References: <20190523080646.19632-1-zyan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 23 May 2019 08:07:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/mds_client.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 60e8ddbdfdc5..870754e9d572 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -913,7 +913,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 		struct inode *dir;
 
 		rcu_read_lock();
-		parent = req->r_dentry->d_parent;
+		parent = READ_ONCE(req->r_dentry->d_parent);
 		dir = req->r_parent ? : d_inode_rcu(parent);
 
 		if (!dir || dir->i_sb != mdsc->fsc->sb) {
@@ -2131,8 +2131,8 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 		if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
 			dout("build_path path+%d: %p SNAPDIR\n",
 			     pos, temp);
-		} else if (stop_on_nosnap && inode && dentry != temp &&
-			   ceph_snap(inode) == CEPH_NOSNAP) {
+		} else if (stop_on_nosnap && dentry != temp &&
+			   inode && ceph_snap(inode) == CEPH_NOSNAP) {
 			spin_unlock(&temp->d_lock);
 			pos++; /* get rid of any prepended '/' */
 			break;
@@ -2145,7 +2145,7 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 			memcpy(path + pos, temp->d_name.name, temp->d_name.len);
 		}
 		spin_unlock(&temp->d_lock);
-		temp = temp->d_parent;
+		temp = READ_ONCE(temp->d_parent);
 
 		/* Are we at the root? */
 		if (IS_ROOT(temp))
-- 
2.17.2

