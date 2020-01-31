Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3222314EB03
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 11:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgAaKkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 05:40:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:57084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgAaKjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:39:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 567E9AFF4;
        Fri, 31 Jan 2020 10:39:07 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH v2 04/21] staging: vc04_services: get rid of blocked_blocker completion in struct vchiq_arm_state
Date:   Fri, 31 Jan 2020 11:38:20 +0100
Message-Id: <20200131103836.14312-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200131103836.14312-1-nsaenzjulienne@suse.de>
References: <20200131103836.14312-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody is waiting on it, so delete it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c    | 5 -----
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.h    | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 311df3d85494..9264bb5d0bbe 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2386,11 +2386,6 @@ vchiq_arm_init_state(struct vchiq_state *state,
 		 * completion while videocore is suspended. */
 		set_resume_state(arm_state, VC_RESUME_RESUMED);
 
-		init_completion(&arm_state->blocked_blocker);
-		/* Initialise to 'done' state.  We only want to block on this
-		 * completion while things are waiting on the resume blocker */
-		complete_all(&arm_state->blocked_blocker);
-
 		arm_state->suspend_timer_timeout = SUSPEND_TIMER_TIMEOUT_MS;
 		arm_state->suspend_timer_running = 0;
 		arm_state->state = state;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index 7d1316875343..6bab241313b8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -70,7 +70,6 @@ struct vchiq_arm_state {
 	*/
 	int peer_use_count;
 
-	struct completion blocked_blocker;
 	int blocked_count;
 
 	/* Flag to indicate that the first vchiq connect has made it through.
-- 
2.25.0

