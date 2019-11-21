Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED5F91051D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 12:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKULwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 06:52:47 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:34689 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfKULwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:52:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id D24673F59D;
        Thu, 21 Nov 2019 12:52:43 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=U5WWZU7y;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NZRwLHAXHBD9; Thu, 21 Nov 2019 12:52:42 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 744D83F59F;
        Thu, 21 Nov 2019 12:52:41 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id C2466360051;
        Thu, 21 Nov 2019 12:52:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1574337160; bh=rADTjlZLWos97SHytV5j8Qmd2jVz1bQ6E4e0jEU56Fo=;
        h=From:To:Cc:Subject:Date:From;
        b=U5WWZU7yZFP/JrCuk/AtbxMN6B9ivocYHZ/udxnZhFc7X1XSmxuGehtLeC2/cvi3X
         0c9AgQQeUD4Tltxt/Uk1RLjgIsjtHdjRFB9KrF+rs74iru9ftV3Yfs49QmQiGs8VPp
         9K6ehIXqq70mcvEKDgwOkc69Hj93V8qtStmebvhA=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        pv-drivers@vmware.com
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Vishal Bhakta <vbhakta@vmware.com>, Jim Gill <jgill@vmware.com>
Subject: [PATCH 1/2] scsi: vmw_pvscsi: Fix swiotlb operation
Date:   Thu, 21 Nov 2019 12:52:03 +0100
Message-Id: <20191121115204.53060-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

With swiotlb, the first byte of the sense buffer may in some cases be
uninitialized since we use DMA_FROM_DEVICE, and the device incorrectly
doesn't clear it. In those cases, clear it after DMA unmapping.

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Suggested-by: Vishal Bhakta <vbhakta@vmware.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Acked-by: Jim Gill <jgill@vmware.com>

 Please enter the commit message for your changes. Lines starting
---
 drivers/scsi/vmw_pvscsi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index 70008816c91f..8a09d184a320 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -402,6 +402,17 @@ static int pvscsi_map_buffers(struct pvscsi_adapter *adapter,
 	return 0;
 }
 
+/*
+ * The device incorrectly doesn't clear the first byte of the sense
+ * buffer in some cases. We have to do it ourselves.
+ * Otherwise we run into trouble when SWIOTLB is forced.
+ */
+static void pvscsi_patch_sense(struct scsi_cmnd *cmd)
+{
+	if (cmd->sense_buffer)
+		cmd->sense_buffer[0] = 0;
+}
+
 static void pvscsi_unmap_buffers(const struct pvscsi_adapter *adapter,
 				 struct pvscsi_ctx *ctx)
 {
@@ -544,6 +555,8 @@ static void pvscsi_complete_request(struct pvscsi_adapter *adapter,
 	cmd = ctx->cmd;
 	abort_cmp = ctx->abort_cmp;
 	pvscsi_unmap_buffers(adapter, ctx);
+	if (sdstat != SAM_STAT_CHECK_CONDITION)
+		pvscsi_patch_sense(cmd);
 	pvscsi_release_context(adapter, ctx);
 	if (abort_cmp) {
 		/*
@@ -873,6 +886,7 @@ static void pvscsi_reset_all(struct pvscsi_adapter *adapter)
 			scmd_printk(KERN_ERR, cmd,
 				    "Forced reset on cmd %p\n", cmd);
 			pvscsi_unmap_buffers(adapter, ctx);
+			pvscsi_patch_sense(cmd);
 			pvscsi_release_context(adapter, ctx);
 			cmd->result = (DID_RESET << 16);
 			cmd->scsi_done(cmd);
-- 
2.21.0

