Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A9410AAA5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 07:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfK0GWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 01:22:08 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbfK0GWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 01:22:08 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E07D67B1CFB1DC994B8D;
        Wed, 27 Nov 2019 14:22:04 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Wed, 27 Nov 2019 14:21:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Vignesh Raghavendra" <vigneshr@ti.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] mtd: ubi: wl: remove set but not used variable 'prev_e'
Date:   Wed, 27 Nov 2019 06:20:02 +0000
Message-ID: <20191127062002.23746-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/mtd/ubi/wl.c: In function 'find_wl_entry':
drivers/mtd/ubi/wl.c:322:27: warning:
 variable 'prev_e' set but not used [-Wunused-but-set-variable]

It's not used any more now, so remove it.

Fixes: f9c34bb52997 ("ubi: Fix producing anchor PEBs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
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



