Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 786959155E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 09:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfHRH2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 03:28:54 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42218 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfHRH2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 03:28:54 -0400
Received: by mail-yb1-f195.google.com with SMTP id h8so3330259ybq.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 00:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o9Rkq3dkBHyl5deQARpSgyWUVR/JbkupDTFCJi/n5xw=;
        b=m0M0wTe2vd4i264b75gFhQeonve+s/aH/LsA6GoJi4t0KTiKXy9o3xos/eZV9h3G3Z
         imOHWmtir4bOCYxDQ5L//jnrHanHeqW4sbZOHpVzlH3n4tjseQdhQLw8V8JnULqVamLr
         3kw9nDdaskKSYv3oDKXYIDjHT42iOxZKgtQXtWdUr/Mp1maZHbr4MOGjV+mB6l2okh1U
         oPL0P2zVrdlckf3TMkwviUMBinYCIvMArR6KRk8qGAnhKaXf8Q5H7Z8KKLz3dvRf2xRT
         akbOmbYLgJz3NspWtg4UZv11qyK06dF2VzwDdaFEIOrAVZKr2Pteqp7zqSKkybHvZAIN
         TYhQ==
X-Gm-Message-State: APjAAAVp3Tl14t6RR3ghppFHSUD8gfCaQmv121l6tMCrQPY4mh4de5S9
        1psrr36VKPmmpVfQqLaFpBQ=
X-Google-Smtp-Source: APXvYqyXh0ACf3uPloT7K9ye/+ewlFZvUxgDm53vVvtLuiCjKWpyMuWjKUJjNkgdC5CAlgnzSdjXBw==
X-Received: by 2002:a25:d143:: with SMTP id i64mr12704171ybg.111.1566113333214;
        Sun, 18 Aug 2019 00:28:53 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id j130sm2396856ywg.31.2019.08.18.00.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 00:28:52 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mtd: rawnand: Fix a memory leak bug
Date:   Sun, 18 Aug 2019 02:28:40 -0500
Message-Id: <1566113321-4464-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nand_scan_bbt(), a temporary buffer 'buf' is allocated through
vmalloc(). However, if check_create() fails, 'buf' is not deallocated,
leading to a memory leak bug. To fix this issue, free 'buf' before
returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/mtd/nand/raw/nand_bbt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index 2ef15ef..864a00a 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -1245,7 +1245,7 @@ static int nand_scan_bbt(struct nand_chip *this, struct nand_bbt_descr *bd)
 	buf = vmalloc(len);
 	if (!buf) {
 		res = -ENOMEM;
-		goto err;
+		goto err_free_bbt;
 	}
 
 	/* Is the bbt at a given page? */
@@ -1258,7 +1258,7 @@ static int nand_scan_bbt(struct nand_chip *this, struct nand_bbt_descr *bd)
 
 	res = check_create(this, buf, bd);
 	if (res)
-		goto err;
+		goto err_free_buf;
 
 	/* Prevent the bbt regions from erasing / writing */
 	mark_bbt_region(this, td);
@@ -1268,7 +1268,9 @@ static int nand_scan_bbt(struct nand_chip *this, struct nand_bbt_descr *bd)
 	vfree(buf);
 	return 0;
 
-err:
+err_free_buf:
+	vfree(buf);
+err_free_bbt:
 	kfree(this->bbt);
 	this->bbt = NULL;
 	return res;
-- 
2.7.4

