Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F02151438B0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 09:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAUIsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 03:48:55 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:32947 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgAUIsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:48:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0ToHXESk_1579596532;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHXESk_1579596532)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:48:52 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ata/acard_ahci: remove unused variable n_elem
Date:   Tue, 21 Jan 2020 16:48:49 +0800
Message-Id: <1579596529-257563-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one care the varible acard_ahci in func acard_ahci_qc_prep.
better to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk> 
Cc: linux-ide@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 drivers/ata/acard-ahci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 46dc54d18f0b..2a04e8abd397 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -218,7 +218,6 @@ static enum ata_completion_errors acard_ahci_qc_prep(struct ata_queued_cmd *qc)
 	void *cmd_tbl;
 	u32 opts;
 	const u32 cmd_fis_len = 5; /* five dwords */
-	unsigned int n_elem;
 
 	/*
 	 * Fill in command table information.  First, the header,
@@ -232,9 +231,8 @@ static enum ata_completion_errors acard_ahci_qc_prep(struct ata_queued_cmd *qc)
 		memcpy(cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, qc->dev->cdb_len);
 	}
 
-	n_elem = 0;
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
-		n_elem = acard_ahci_fill_sg(qc, cmd_tbl);
+		acard_ahci_fill_sg(qc, cmd_tbl);
 
 	/*
 	 * Fill in command slot information.
-- 
1.8.3.1

