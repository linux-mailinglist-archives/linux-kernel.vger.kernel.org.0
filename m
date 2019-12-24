Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B64129ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 09:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfLXIN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 03:13:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8169 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbfLXIN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 03:13:56 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EFF3C8C535982F2436B8;
        Tue, 24 Dec 2019 16:13:54 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 24 Dec 2019 16:13:49 +0800
From:   Ma Feng <mafeng.ma@huawei.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] drm/i915/dp: use true,false for bool variable in intel_dp.c
Date:   Tue, 24 Dec 2019 16:14:41 +0800
Message-ID: <1577175281-93306-1-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/gpu/drm/i915/display/intel_dp.c:4950:1-33: WARNING: Assignment of 0/1 to bool variable
drivers/gpu/drm/i915/display/intel_dp.c:4906:1-33: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 2f31d22..4fd0fcd 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4903,7 +4903,7 @@ static u8 intel_dp_autotest_video_pattern(struct intel_dp *intel_dp)
 	intel_dp->compliance.test_data.hdisplay = be16_to_cpu(h_width);
 	intel_dp->compliance.test_data.vdisplay = be16_to_cpu(v_height);
 	/* Set test active flag here so userspace doesn't interrupt things */
-	intel_dp->compliance.test_active = 1;
+	intel_dp->compliance.test_active = true;

 	return DP_TEST_ACK;
 }
@@ -4947,7 +4947,7 @@ static u8 intel_dp_autotest_edid(struct intel_dp *intel_dp)
 	}

 	/* Set test active flag here so userspace doesn't interrupt things */
-	intel_dp->compliance.test_active = 1;
+	intel_dp->compliance.test_active = true;

 	return test_result;
 }
--
2.6.2

