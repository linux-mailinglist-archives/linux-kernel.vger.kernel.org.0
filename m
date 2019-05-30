Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02B1D2E9A9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 02:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfE3AQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 20:16:13 -0400
Received: from mail.skrimstad.net ([139.162.145.221]:48494 "EHLO
        mail.skrimstad.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfE3AQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 20:16:13 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 20:16:12 EDT
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by mail.skrimstad.net (Postfix) with ESMTPA id 29812DE701;
        Thu, 30 May 2019 00:08:23 +0000 (UTC)
Date:   Thu, 30 May 2019 02:08:21 +0200
From:   Yrjan Skrimstad <yrjan@skrimstad.net>
To:     dri-devel@lists.freedesktop.org
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yrjan Skrimstad <yrjan@skrimstad.net>
Subject: [PATCH] drm/amd/powerplay/smu7_hwmgr: replace blocking delay with
 non-blocking
Message-ID: <20190530000819.GA25416@obi-wan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Authentication-Results: mail.skrimstad.net;
        auth=pass smtp.auth=yrjan@skrimstad.net smtp.mailfrom=yrjan@skrimstad.net
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver currently contains a repeated 500ms blocking delay call
which causes frequent major buffer underruns in PulseAudio. This patch
fixes this issue by replacing the blocking delay with a non-blocking
sleep call.

Signed-off-by: Yrjan Skrimstad <yrjan@skrimstad.net>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 048757e8f494..340afdbddc72 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -3494,7 +3494,7 @@ static int smu7_get_gpu_power(struct pp_hwmgr *hwmgr, u32 *query)
 							ixSMU_PM_STATUS_95, 0);
 
 	for (i = 0; i < 10; i++) {
-		mdelay(500);
+		msleep(500);
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_PmStatusLogSample);
 		tmp = cgs_read_ind_register(hwmgr->device,
 						CGS_IND_REG__SMC,
-- 
2.20.1

