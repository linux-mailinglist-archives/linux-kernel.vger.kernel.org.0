Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D48775A2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 03:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfG0BgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 21:36:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3179 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfG0BgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 21:36:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E62FA483789FF0263845;
        Sat, 27 Jul 2019 09:36:07 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 27 Jul 2019
 09:36:00 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <eric@anholt.net>, <wahrenst@gmx.net>,
        <gregkh@linuxfoundation.org>, <inf.braun@fau.de>,
        <nishkadg.linux@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v3 -next] staging: vc04_services: fix unused-but-set-variable warning
Date:   Sat, 27 Jul 2019 09:35:24 +0800
Message-ID: <20190727013524.33168-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190725142716.49276-1-yuehaibing@huawei.com>
References: <20190725142716.49276-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc used-but-set-variable warning:

drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: In function vchiq_release_internal:
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2827:16: warning:
 variable local_entity_uc set but not used [-Wunused-but-set-variable]
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2827:6: warning:
 variable local_uc set but not used [-Wunused-but-set-variable]

Remove the unused variables 'local_entity_uc' and 'local_uc'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Stefan Wahren <wahrenst@gmx.net>
---
v3: fix patch title
v2: remove the unused variable
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index cc4383d..b1595b1 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2824,7 +2824,6 @@ vchiq_release_internal(struct vchiq_state *state, struct vchiq_service *service)
 	VCHIQ_STATUS_T ret = VCHIQ_SUCCESS;
 	char entity[16];
 	int *entity_uc;
-	int local_uc, local_entity_uc;
 
 	if (!arm_state)
 		goto out;
@@ -2849,8 +2848,8 @@ vchiq_release_internal(struct vchiq_state *state, struct vchiq_service *service)
 		ret = VCHIQ_ERROR;
 		goto unlock;
 	}
-	local_uc = --arm_state->videocore_use_count;
-	local_entity_uc = --(*entity_uc);
+	--arm_state->videocore_use_count;
+	--(*entity_uc);
 
 	if (!vchiq_videocore_wanted(state)) {
 		if (vchiq_platform_use_suspend_timer() &&
-- 
2.7.4


