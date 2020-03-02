Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE49917639B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 20:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgCBTNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 14:13:47 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:50568 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbgCBTNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:13:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 70F14FB05;
        Mon,  2 Mar 2020 20:13:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 993ETPkw1lj8; Mon,  2 Mar 2020 20:13:44 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 9E2B84048C; Mon,  2 Mar 2020 20:13:36 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] drm/etnaviv: Ignore MC when checking runtime suspend idleness
Date:   Mon,  2 Mar 2020 20:13:35 +0100
Message-Id: <54839dc5a523a63344c9b53cc4314ee96ef9d5b8.1583176306.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1583176306.git.agx@sigxcpu.org>
References: <cover.1583176306.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without that runtime suspend is often blocked due to
etnaviv_gpu_rpm_suspend() returning -EBUSY since the FE seems to trigger
the MC in its idle loop.

Ignoring the MC bit makes the GPU suspend as expected. This was tested
on GC7000.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 187de610b325..da24e433f82a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1820,8 +1820,9 @@ static int etnaviv_gpu_rpm_suspend(struct device *dev)
 	if (atomic_read(&gpu->sched.hw_rq_count))
 		return -EBUSY;
 
-	/* Check whether the hardware (except FE) is idle */
-	mask = gpu->idle_mask & ~VIVS_HI_IDLE_STATE_FE;
+	/* Check whether the hardware (except FE and MC) is idle */
+	mask = gpu->idle_mask & ~(VIVS_HI_IDLE_STATE_FE |
+				  VIVS_HI_IDLE_STATE_MC);
 	idle = gpu_read(gpu, VIVS_HI_IDLE_STATE) & mask;
 	if (idle != mask)
 		return -EBUSY;
-- 
2.23.0

