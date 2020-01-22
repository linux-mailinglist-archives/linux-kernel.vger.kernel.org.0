Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A021144C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 08:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAVHVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 02:21:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51382 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbgAVHVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 02:21:47 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 958936BF22A3041C68A4;
        Wed, 22 Jan 2020 15:21:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Wed, 22 Jan 2020 15:21:38 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <jens.wiklander@linaro.org>, <Rijo-john.Thomas@amd.com>
CC:     <yaohongbo@huawei.com>, <chenzhou10@huawei.com>,
        <tee-dev@lists.linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] tee: amdtee: amdtee depends on CRYPTO_DEV_CCP_DD
Date:   Wed, 22 Jan 2020 15:16:43 +0800
Message-ID: <20200122071643.8122-1-yaohongbo@huawei.com>
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

If CRYPTO_DEV_CCP_DD=m and AMDTEE=y, the following error is seen
while building call.c or core.c

drivers/tee/amdtee/call.o: In function `handle_unload_ta':
call.c:(.text+0x35f): undefined reference to `psp_tee_process_cmd'
drivers/tee/amdtee/core.o: In function `amdtee_driver_init':
core.c:(.init.text+0xf): undefined reference to `psp_check_tee_status

Fix the config dependency for AMDTEE here.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 757cc3e9ff ("tee: add AMD-TEE driver")
Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 drivers/tee/amdtee/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/amdtee/Kconfig b/drivers/tee/amdtee/Kconfig
index 4e32b6413b41..191f9715fa9a 100644
--- a/drivers/tee/amdtee/Kconfig
+++ b/drivers/tee/amdtee/Kconfig
@@ -3,6 +3,6 @@
 config AMDTEE
 	tristate "AMD-TEE"
 	default m
-	depends on CRYPTO_DEV_SP_PSP
+	depends on CRYPTO_DEV_SP_PSP && CRYPTO_DEV_CCP_DD
 	help
 	  This implements AMD's Trusted Execution Environment (TEE) driver.
-- 
2.20.1

