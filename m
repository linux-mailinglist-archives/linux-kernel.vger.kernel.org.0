Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11CDA14EB00
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 11:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgAaKkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 05:40:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:57102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728447AbgAaKjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:39:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0E5ABAFFC;
        Fri, 31 Jan 2020 10:39:08 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH v2 05/21] staging: vc04_services: Delete blocked_count in struct vchiq_arm_state
Date:   Fri, 31 Jan 2020 11:38:21 +0100
Message-Id: <20200131103836.14312-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200131103836.14312-1-nsaenzjulienne@suse.de>
References: <20200131103836.14312-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable is always 0. So delete it an all the code conditional to
it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 --
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 9264bb5d0bbe..4545df573c90 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2266,8 +2266,6 @@ vchiq_videocore_wanted(struct vchiq_state *state)
 	if (!arm_state)
 		/* autosuspend not supported - always return wanted */
 		return 1;
-	else if (arm_state->blocked_count)
-		return 1;
 	else if (!arm_state->videocore_use_count)
 		/* usage count zero - check for override unless we're forcing */
 		return vchiq_platform_videocore_wanted(state);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index 6bab241313b8..35889a65b17f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -70,8 +70,6 @@ struct vchiq_arm_state {
 	*/
 	int peer_use_count;
 
-	int blocked_count;
-
 	/* Flag to indicate that the first vchiq connect has made it through.
 	** This means that both sides should be fully ready, and we should
 	** be able to suspend after this point.
-- 
2.25.0

