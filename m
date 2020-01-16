Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA0BC13D965
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 12:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgAPL5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 06:57:00 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbgAPL46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:56:58 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8B6998A51B80C1E0246C;
        Thu, 16 Jan 2020 19:56:55 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 16 Jan 2020
 19:56:48 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <hare@suse.com>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 1/3] scsi: aic7xxx: remove set but not used variable 'tinfo'
Date:   Thu, 16 Jan 2020 19:56:01 +0800
Message-ID: <20200116115603.25386-2-yukuai3@huawei.com>
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
‘ahc_linux_target_alloc’:
drivers/scsi/aic7xxx/aic7xxx_osm.c:567:30: warning:
variable ‘tinfo’ set but not used [-Wunused-but-set-variable]

It is never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/scsi/aic7xxx/aic7xxx_osm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index d5c4a0d23706..e99aa154f77a 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -564,7 +564,6 @@ ahc_linux_target_alloc(struct scsi_target *starget)
 	struct scsi_target **ahc_targp = ahc_linux_target_in_softc(starget);
 	unsigned short scsirate;
 	struct ahc_devinfo devinfo;
-	struct ahc_initiator_tinfo *tinfo;
 	struct ahc_tmode_tstate *tstate;
 	char channel = starget->channel + 'A';
 	unsigned int our_id = ahc->our_id;
@@ -612,9 +611,6 @@ ahc_linux_target_alloc(struct scsi_target *starget)
 			spi_max_offset(starget) = 0;
 		spi_min_period(starget) = 
 			ahc_find_period(ahc, scsirate, maxsync);
-
-		tinfo = ahc_fetch_transinfo(ahc, channel, ahc->our_id,
-					    starget->id, &tstate);
 	}
 	ahc_compile_devinfo(&devinfo, our_id, starget->id,
 			    CAM_LUN_WILDCARD, channel,
-- 
2.17.2

