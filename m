Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC49127313
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 02:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfLTBzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 20:55:37 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726964AbfLTBzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:55:36 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0C1F689C28CBC3381A9E;
        Fri, 20 Dec 2019 09:55:35 +0800 (CST)
Received: from huawei.com (10.175.127.16) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Dec 2019
 09:55:25 +0800
From:   chenmaodong <chenmaodong@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <zhangpan26@huawei.com>,
        <wuxu.wu@huawei.com>, <hushiyuan@huawei.com>,
        <chenmaodong@huawei.com>
Subject: [PATCH ] drm/radeon: Fix potential buffer overflow in ci_set_mc_special_registers()
Date:   Fri, 20 Dec 2019 09:55:05 +0800
Message-ID: <1576806905-4590-1-git-send-email-chenmaodong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.127.16]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The length of table->mc_reg_address is SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE.

In ci_set_mc_special_registers(), the boundary checking

here("if (j > SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)") allows 'j' equal to

SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE which can easily cause the 

table->mc_reg_address to read out of bounds. 

To solve this problem, we change ">" to ">=" and check this boundary 

of table->mc_reg_address after "pi->mem_gddr5" is false.

Signed-off-by: chenmaodong <chenmaodong@huawei.com>
---
 drivers/gpu/drm/radeon/ci_dpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index a97294a..42ef745a 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -4364,10 +4364,10 @@ static int ci_set_mc_special_registers(struct radeon_device *rdev,
 					table->mc_reg_table_entry[k].mc_data[j] |= 0x100;
 			}
 			j++;
-			if (j > SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
-				return -EINVAL;
 
 			if (!pi->mem_gddr5) {
+				if (j >= SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
+					return -EINVAL;
 				table->mc_reg_address[j].s1 = MC_PMG_AUTO_CMD >> 2;
 				table->mc_reg_address[j].s0 = MC_PMG_AUTO_CMD >> 2;
 				for (k = 0; k < table->num_entries; k++) {
-- 
2.7.4

