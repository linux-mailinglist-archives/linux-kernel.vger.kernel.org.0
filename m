Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E02D231A03
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 09:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfFAHOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jun 2019 03:14:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35468 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbfFAHOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 03:14:02 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 92328B4C434BBCF60B04;
        Sat,  1 Jun 2019 15:13:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Sat, 1 Jun 2019 15:13:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <hanghong.ma@amd.com>, <Jun.Lei@amd.com>, <Wenjing.Liu@amd.com>,
        <Krunoslav.Kovac@amd.com>, <nicholas.kazlauskas@amd.com>,
        <David.Francis@amd.com>, <Bhawanpreet.Lakha@amd.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/amd/display: Use kmemdup in dc_copy_stream()
Date:   Sat, 1 Jun 2019 07:22:08 +0000
Message-ID: <20190601072208.193673-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kmemdup rather than duplicating its implementation.

Detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index a002e690814f..b166c732b532 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -167,12 +167,11 @@ struct dc_stream_state *dc_copy_stream(const struct dc_stream_state *stream)
 {
 	struct dc_stream_state *new_stream;
 
-	new_stream = kzalloc(sizeof(struct dc_stream_state), GFP_KERNEL);
+	new_stream = kmemdup(stream, sizeof(struct dc_stream_state),
+			     GFP_KERNEL);
 	if (!new_stream)
 		return NULL;
 
-	memcpy(new_stream, stream, sizeof(struct dc_stream_state));
-
 	if (new_stream->sink)
 		dc_sink_retain(new_stream->sink);



