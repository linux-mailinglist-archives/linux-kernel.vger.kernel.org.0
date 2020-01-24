Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 360DC148A43
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 15:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388504AbgAXOqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 09:46:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:43418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387996AbgAXOqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:46:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 90665AFCB;
        Fri, 24 Jan 2020 14:46:31 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH 03/22] staging: vc04_services: Get rid of resume_blocker completion in struct vchiq_arm_state
Date:   Fri, 24 Jan 2020 15:45:57 +0100
Message-Id: <20200124144617.2213-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124144617.2213-1-nsaenzjulienne@suse.de>
References: <20200124144617.2213-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody is waiting on it, so delete all relevant code.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c     | 11 -----------
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h     |  4 ----
 2 files changed, 15 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index af4dc23f5510..311df3d85494 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2386,11 +2386,6 @@ vchiq_arm_init_state(struct vchiq_state *state,
 		 * completion while videocore is suspended. */
 		set_resume_state(arm_state, VC_RESUME_RESUMED);
 
-		init_completion(&arm_state->resume_blocker);
-		/* Initialise to 'done' state.  We only want to block on this
-		 * completion while resume is blocked */
-		complete_all(&arm_state->resume_blocker);
-
 		init_completion(&arm_state->blocked_blocker);
 		/* Initialise to 'done' state.  We only want to block on this
 		 * completion while things are waiting on the resume blocker */
@@ -2560,12 +2555,6 @@ need_resume(struct vchiq_state *state)
 			vchiq_videocore_wanted(state);
 }
 
-static inline void
-unblock_resume(struct vchiq_arm_state *arm_state)
-{
-	complete_all(&arm_state->resume_blocker);
-}
-
 /* Initiate suspend via slot handler. Should be called with the write lock
  * held */
 enum vchiq_status
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index c904f7be9084..7d1316875343 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -70,10 +70,6 @@ struct vchiq_arm_state {
 	*/
 	int peer_use_count;
 
-	/* Flag to indicate whether resume is blocked.  This happens when the
-	** ARM is suspending
-	*/
-	struct completion resume_blocker;
 	struct completion blocked_blocker;
 	int blocked_count;
 
-- 
2.25.0

