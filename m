Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC45D32186
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 03:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfFBB32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jun 2019 21:29:28 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34666 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfFBB3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 21:29:10 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 39E0827F23; Sat,  1 Jun 2019 21:29:07 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Michael Schmitz" <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <6249ead35826f734592db83d7073c6247d6af793.1559438652.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1559438652.git.fthain@telegraphics.com.au>
References: <cover.1559438652.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 7/7] scsi: mac_scsi: Treat Last Byte Sent time-out as failure
Date:   Sun, 02 Jun 2019 11:24:12 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A system bus error during a PDMA send operation can result in bytes being
lost. Theoretically that could cause the target to remain in DATA OUT
phase and the initiator (expecting a phase change) would time-out waiting
for the Last Byte Sent flag. Should that happen, fail the transfer so the
core driver will stop using PDMA with this target.

Cc: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/mac_scsi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mac_scsi.c b/drivers/scsi/mac_scsi.c
index 2e503f06ac99..68d4665112b5 100644
--- a/drivers/scsi/mac_scsi.c
+++ b/drivers/scsi/mac_scsi.c
@@ -188,9 +188,12 @@ static inline int macscsi_pwrite(struct NCR5380_hostdata *hostdata,
 		if (hostdata->pdma_residual == 0) {
 			if (NCR5380_poll_politely(hostdata, TARGET_COMMAND_REG,
 			                          TCR_LAST_BYTE_SENT,
-			                          TCR_LAST_BYTE_SENT, HZ / 64) < 0)
+			                          TCR_LAST_BYTE_SENT,
+			                          HZ / 64) < 0) {
 				scmd_printk(KERN_ERR, hostdata->connected,
 				            "%s: Last Byte Sent timeout\n", __func__);
+				result = -1;
+			}
 			goto out;
 		}
 
-- 
2.21.0

