Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6505E72B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 14:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389570AbfJ1Ngk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 09:36:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5211 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729742AbfJ1Ngk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:36:40 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 329F9FADBF5561FE308D;
        Mon, 28 Oct 2019 21:36:38 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 28 Oct 2019
 21:36:30 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rex.zhu@amd.com>, <evan.quan@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 3/3] drm/amd/powerplay: Make two functions static
Date:   Mon, 28 Oct 2019 21:36:21 +0800
Message-ID: <20191028133621.21400-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c:2050:5:
 warning: symbol 'arcturus_i2c_eeprom_control_init' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c:2068:6:
 warning: symbol 'arcturus_i2c_eeprom_control_fini' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index d48a49d..3099ac2 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2047,7 +2047,7 @@ static const struct i2c_algorithm arcturus_i2c_eeprom_i2c_algo = {
 	.functionality = arcturus_i2c_eeprom_i2c_func,
 };
 
-int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
+static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	int res;
@@ -2065,7 +2065,7 @@ int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
 	return res;
 }
 
-void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
+static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
 {
 	i2c_del_adapter(control);
 }
-- 
2.7.4


