Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E41879DE70
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 09:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfH0HJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 03:09:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbfH0HJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:09:47 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1E48B97A03B8D482BE85;
        Tue, 27 Aug 2019 15:09:45 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 27 Aug 2019
 15:09:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Bhawanpreet.Lakha@amd.com>, <Anthony.Koo@amd.com>,
        <ahmad.othman@amd.com>, <eric.bernstein@amd.com>,
        <yuehaibing@huawei.com>, <aric.cyr@amd.com>, <alvin.lee3@amd.com>,
        <Harmanprit.Tatla@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] drm/amd/display: remove unused function setFieldWithMask
Date:   Tue, 27 Aug 2019 15:09:25 +0800
Message-ID: <20190827070925.16080-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit a9f54ce3c603 ("drm/amd/display: Refactoring VTEM"),
there is no caller in tree.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 .../drm/amd/display/modules/info_packet/info_packet.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 5f4b98d..d885d64 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -114,25 +114,6 @@ enum ColorimetryYCCDP {
 	ColorimetryYCC_DP_ITU2020YCbCr  = 7,
 };
 
-void setFieldWithMask(unsigned char *dest, unsigned int mask, unsigned int value)
-{
-	unsigned int shift = 0;
-
-	if (!mask || !dest)
-		return;
-
-	while (!((mask >> shift) & 1))
-		shift++;
-
-	//reset
-	*dest = *dest & ~mask;
-	//set
-	//dont let value span past mask
-	value = value & (mask >> shift);
-	//insert value
-	*dest = *dest | (value << shift);
-}
-
 void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet)
 {
-- 
2.7.4


