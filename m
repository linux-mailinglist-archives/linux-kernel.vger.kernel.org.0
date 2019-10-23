Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B34BE143E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 10:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390277AbfJWIb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 04:31:29 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:4505 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387829AbfJWIb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:31:29 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id B1BFDE93D3079EB8002D;
        Wed, 23 Oct 2019 16:31:26 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x9N8U30j081278;
        Wed, 23 Oct 2019 16:30:03 +0800 (GMT-8)
        (envelope-from zhong.shiqi@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019102316302352-91717 ;
          Wed, 23 Oct 2019 16:30:23 +0800 
From:   zhongshiqi <zhong.shiqi@zte.com.cn>
To:     harry.wentland@amd.com
Cc:     sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com, Jun.Lei@amd.com,
        David.Francis@amd.com, Dmytro.Laktyushkin@amd.com,
        anthony.koo@amd.com, Wenjing.Liu@amd.com,
        nicholas.kazlauskas@amd.com, Aidan.Wood@amd.com,
        Chris.Park@amd.com, Eric.Yang2@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn,
        zhongshiqi <zhong.shiqi@zte.com.cn>
Subject: [PATCH] dc.c:use kzalloc without test
Date:   Wed, 23 Oct 2019 16:32:23 +0800
Message-Id: <1571819543-15676-1-git-send-email-zhong.shiqi@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-10-23 16:30:23,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-10-23 16:30:06,
        Serialize complete at 2019-10-23 16:30:06
X-MAIL: mse-fl1.zte.com.cn x9N8U30j081278
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dc.c:583:null check is needed after using kzalloc function

Signed-off-by: zhongshiqi <zhong.shiqi@zte.com.cn>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5d1aded..4b8819c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -580,6 +580,10 @@ static bool construct(struct dc *dc,
 #ifdef CONFIG_DRM_AMD_DC_DCN2_0
 	// Allocate memory for the vm_helper
 	dc->vm_helper = kzalloc(sizeof(struct vm_helper), GFP_KERNEL);
+	if (!dc->vm_helper) {
+		dm_error("%s: failed to create dc->vm_helper\n", __func__);
+		goto fail;
+	}
 
 #endif
 	memcpy(&dc->bb_overrides, &init_params->bb_overrides, sizeof(dc->bb_overrides));
-- 
2.9.5

