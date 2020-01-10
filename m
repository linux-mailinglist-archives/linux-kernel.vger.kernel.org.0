Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 738F713683C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 08:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgAJHUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 02:20:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbgAJHUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:20:42 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6AD5B737C754AE18F20D;
        Fri, 10 Jan 2020 15:20:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Fri, 10 Jan 2020 15:20:32 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <alexander.deucher@amd.com>, <sunpeng.li@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH] drm/amd/display: remove unnecessary conversion to bool
Date:   Fri, 10 Jan 2020 15:16:16 +0800
Message-ID: <20200110071616.84891-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion to bool is not needed, remove it.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 504055f..a004e8e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2792,7 +2792,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 			dpcd_data[DP_TRAINING_AUX_RD_INTERVAL];
 
 		link->dpcd_caps.ext_receiver_cap_field_present =
-				aux_rd_interval.bits.EXT_RECEIVER_CAP_FIELD_PRESENT == 1 ? true:false;
+				aux_rd_interval.bits.EXT_RECEIVER_CAP_FIELD_PRESENT == 1;
 
 		if (aux_rd_interval.bits.EXT_RECEIVER_CAP_FIELD_PRESENT == 1) {
 			uint8_t ext_cap_data[16];
-- 
2.7.4

