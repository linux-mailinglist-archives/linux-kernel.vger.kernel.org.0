Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2170FE72AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 14:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389495AbfJ1NfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 09:35:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbfJ1Ne7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:34:59 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9A01375B8B23BB5841DE;
        Mon, 28 Oct 2019 21:34:53 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 28 Oct 2019
 21:34:45 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Bhawanpreet.Lakha@amd.com>, <Dmytro.Laktyushkin@amd.com>,
        <charlene.liu@amd.com>, <eric.bernstein@amd.com>,
        <Jun.Lei@amd.com>, <Anthony.Koo@amd.com>, <Reza.Amini@amd.com>,
        <Harmanprit.Tatla@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/display: Make calculate_integer_scaling static
Date:   Mon, 28 Oct 2019 21:34:36 +0800
Message-ID: <20191028133436.30608-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:963:6:
 warning: symbol 'calculate_integer_scaling' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 70e601a..3769830 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -960,7 +960,7 @@ static bool are_rects_integer_multiples(struct rect src, struct rect dest)
 	return false;
 }
 
-void calculate_integer_scaling(struct pipe_ctx *pipe_ctx)
+static void calculate_integer_scaling(struct pipe_ctx *pipe_ctx)
 {
 	if (!pipe_ctx->plane_state->scaling_quality.integer_scaling)
 		return;
-- 
2.7.4


