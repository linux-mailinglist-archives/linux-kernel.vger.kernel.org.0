Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC53D134093
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 12:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgAHLeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 06:34:15 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59386 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbgAHLeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:34:15 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D11C6C1D8E4646345969;
        Wed,  8 Jan 2020 19:34:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Wed, 8 Jan 2020 19:34:04 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <hare@suse.com>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH] scsi: aic7xxx: use kmemdup
Date:   Wed, 8 Jan 2020 19:29:53 +0800
Message-ID: <20200108112953.41808-1-chenzhou10@huawei.com>
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

Fix memdup.cocci warnings:
./drivers/scsi/aic7xxx/aic79xx_core.c:9445:27-34: WARNING opportunity for kmemdup

Use kmemdup rather than duplicating its implementation.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/scsi/aic7xxx/aic79xx_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index 7e5044b..f4bc88c 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -9442,10 +9442,9 @@ ahd_loadseq(struct ahd_softc *ahd)
 	if (cs_count != 0) {
 
 		cs_count *= sizeof(struct cs);
-		ahd->critical_sections = kmalloc(cs_count, GFP_ATOMIC);
+		ahd->critical_sections = kmemdup(cs_table, cs_count, GFP_ATOMIC);
 		if (ahd->critical_sections == NULL)
 			panic("ahd_loadseq: Could not malloc");
-		memcpy(ahd->critical_sections, cs_table, cs_count);
 	}
 	ahd_outb(ahd, SEQCTL0, PERRORDIS|FAILDIS|FASTMODE);
 
-- 
2.7.4

