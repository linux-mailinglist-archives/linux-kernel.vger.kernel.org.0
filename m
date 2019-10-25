Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92294E5516
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 22:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfJYUZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 16:25:41 -0400
Received: from ale.deltatee.com ([207.54.116.67]:35308 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbfJYUZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 16:25:40 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iO69R-00078d-Ir; Fri, 25 Oct 2019 14:25:39 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iO69Q-00038z-Ok; Fri, 25 Oct 2019 14:25:36 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 25 Oct 2019 14:25:34 -0600
Message-Id: <20191025202535.12036-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025202535.12036-1-logang@deltatee.com>
References: <20191025202535.12036-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [RFC PATCH 2/3] nvme: Create helper function to obtain command effects
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the code to obtain command effects from the code
to start a passthru request and open code nvme_known_admin_effects()
in the new helper.

The new helper function will be necessary for nvmet passthru
code to determine if we need to change out of interrupt context
to handle the effects.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c | 41 +++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2bde988d1aa..2b4f0ea55f8d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -886,22 +886,8 @@ static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 	return ERR_PTR(ret);
 }
 
-static u32 nvme_known_admin_effects(u8 opcode)
-{
-	switch (opcode) {
-	case nvme_admin_format_nvm:
-		return NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
-					NVME_CMD_EFFECTS_CSE_MASK;
-	case nvme_admin_sanitize_nvm:
-		return NVME_CMD_EFFECTS_CSE_MASK;
-	default:
-		break;
-	}
-	return 0;
-}
-
-static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			       u8 opcode)
+static u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+				u8 opcode)
 {
 	u32 effects = 0;
 
@@ -917,7 +903,24 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	if (ctrl->effects)
 		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
-	effects |= nvme_known_admin_effects(opcode);
+
+	switch (opcode) {
+	case nvme_admin_format_nvm:
+		effects |= NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
+					NVME_CMD_EFFECTS_CSE_MASK;
+		break;
+	case nvme_admin_sanitize_nvm:
+		effects |= NVME_CMD_EFFECTS_CSE_MASK;
+		break;
+	default:
+		break;
+	}
+
+	return effects;
+}
+
+static void nvme_passthru_start(struct nvme_ctrl *ctrl, u32 effects)
+{
 
 	/*
 	 * For simplicity, IO to all namespaces is quiesced even if the command
@@ -931,7 +934,6 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		nvme_start_freeze(ctrl);
 		nvme_wait_freeze(ctrl);
 	}
-	return effects;
 }
 
 static void nvme_update_formats(struct nvme_ctrl *ctrl)
@@ -975,7 +977,8 @@ static void nvme_execute_passthru_rq(struct request *rq)
 	struct gendisk *disk = ns ? ns->disk : NULL;
 	u32 effects;
 
-	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
+	effects = nvme_command_effects(ctrl, ns, cmd->common.opcode);
+	nvme_passthru_start(ctrl, effects);
 	blk_execute_rq(rq->q, disk, rq, 0);
 	nvme_passthru_end(ctrl, effects);
 }
-- 
2.20.1

