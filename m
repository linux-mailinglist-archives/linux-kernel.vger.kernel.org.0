Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD753A2BC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 03:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfFIB1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 21:27:00 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59996 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfFIB0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 21:26:45 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 0D0C527ACE; Sat,  8 Jun 2019 21:26:43 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Michael Schmitz" <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <825f9cc5f8887f0d32274442ea7b21449b48f27c.1560043151.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1560043151.git.fthain@telegraphics.com.au>
References: <cover.1560043151.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 7/7] scsi: mac_scsi: Treat Last Byte Sent time-out as
 failure
Date:   Sun, 09 Jun 2019 11:19:11 +1000
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
index 8fbec1768bbf..658a719cfcba 100644
--- a/drivers/scsi/mac_scsi.c
+++ b/drivers/scsi/mac_scsi.c
@@ -360,9 +360,12 @@ static inline int macscsi_pwrite(struct NCR5380_hostdata *hostdata,
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

