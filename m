Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 852A835EE5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 16:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfFEOQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 10:16:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18085 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728116AbfFEOQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:16:47 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0A7A0CBCC519B925B9D5;
        Wed,  5 Jun 2019 22:16:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 5 Jun 2019 22:16:35 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        <cluster-devel@redhat.com>
Subject: [PATCH] fs: gfs2: Use IS_ERR_OR_NULL
Date:   Wed, 5 Jun 2019 22:24:24 +0800
Message-ID: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use IS_ERR_OR_NULL where appropriate.

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/gfs2/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index db9a05244a35..3925efd3fd83 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -857,7 +857,7 @@ static struct gfs2_dirent *gfs2_dirent_search(struct inode *inode,
 		return ERR_PTR(error);
 	dent = gfs2_dirent_scan(inode, bh->b_data, bh->b_size, scan, name, NULL);
 got_dent:
-	if (unlikely(dent == NULL || IS_ERR(dent))) {
+	if (IS_ERR_OR_NULL(dent)) {
 		brelse(bh);
 		bh = NULL;
 	}
-- 
2.20.1

