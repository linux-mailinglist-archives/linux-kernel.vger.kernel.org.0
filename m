Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A615F13D967
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 12:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgAPL5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 06:57:04 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbgAPL47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:56:59 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 94F55EC39D4C2347171C;
        Thu, 16 Jan 2020 19:56:55 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 16 Jan 2020
 19:56:49 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <hare@suse.com>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 2/3] scsi: aic7xxx: remove set but not used variable 'ahc'
Date:   Thu, 16 Jan 2020 19:56:02 +0800
Message-ID: <20200116115603.25386-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200116115603.25386-1-yukuai3@huawei.com>
References: <20200116115603.25386-1-yukuai3@huawei.com>
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

drivers/scsi/aic7xxx/aic7xxx_osm.c: In function
‘ahc_linux_slave_configure’:
drivers/scsi/aic7xxx/aic7xxx_osm.c:674:20: warning:
variable ‘ahc’ set but not used [-Wunused-but-set-variable]

It is never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/scsi/aic7xxx/aic7xxx_osm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index e99aa154f77a..2cda0736c989 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -667,10 +667,6 @@ ahc_linux_slave_alloc(struct scsi_device *sdev)
 static int
 ahc_linux_slave_configure(struct scsi_device *sdev)
 {
-	struct	ahc_softc *ahc;
-
-	ahc = *((struct ahc_softc **)sdev->host->hostdata);
-
 	if (bootverbose)
 		sdev_printk(KERN_INFO, sdev, "Slave Configure\n");
 
-- 
2.17.2

