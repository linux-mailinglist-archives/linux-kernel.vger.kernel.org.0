Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E77F12F820
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 13:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgACMVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 07:21:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727436AbgACMVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 07:21:04 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B2366F019B76878AC67F;
        Fri,  3 Jan 2020 20:21:01 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 3 Jan 2020
 20:20:52 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <zhengbin13@huawei.com>
Subject: [PATCH] ubi: wl: remove set but not used variable 'prev_e'
Date:   Fri, 3 Jan 2020 20:20:15 +0800
Message-ID: <20200103122015.6385-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/mtd/ubi/wl.c: In function ‘find_wl_entry’:
drivers/mtd/ubi/wl.c:322:27: warning: variable ‘prev_e’ set but not
used [-Wunused-but-set-variable]

It is never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/mtd/ubi/wl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 5d77a38dba54..837d690a8c60 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -319,7 +319,7 @@ static struct ubi_wl_entry *find_wl_entry(struct ubi_device *ubi,
 					  struct rb_root *root, int diff)
 {
 	struct rb_node *p;
-	struct ubi_wl_entry *e, *prev_e = NULL;
+	struct ubi_wl_entry *e;
 	int max;
 
 	e = rb_entry(rb_first(root), struct ubi_wl_entry, u.rb);
@@ -334,7 +334,6 @@ static struct ubi_wl_entry *find_wl_entry(struct ubi_device *ubi,
 			p = p->rb_left;
 		else {
 			p = p->rb_right;
-			prev_e = e;
 			e = e1;
 		}
 	}
-- 
2.17.2

