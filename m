Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8CA81995C8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 13:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbgCaLvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 07:51:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45530 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730619AbgCaLvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 07:51:43 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3180AD57F30DCA01549B;
        Tue, 31 Mar 2020 19:51:27 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 31 Mar 2020
 19:51:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <aneesh.kumar@linux.ibm.com>, <jmoyer@redhat.com>
CC:     <linux-nvdimm@lists.01.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] libnvdimm/region: Fix build error
Date:   Tue, 31 Mar 2020 19:50:24 +0800
Message-ID: <20200331115024.31628-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20200330141943.31696-1-yuehaibing@huawei.com>
References: <20200330141943.31696-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On CONFIG_PPC32=y build fails:

drivers/nvdimm/region_devs.c:1034:14: note: in expansion of macro ‘do_div’
  remainder = do_div(per_mapping, mappings);
              ^~~~~~
In file included from ./arch/powerpc/include/generated/asm/div64.h:1:0,
                 from ./include/linux/kernel.h:18,
                 from ./include/asm-generic/bug.h:19,
                 from ./arch/powerpc/include/asm/bug.h:109,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/scatterlist.h:7,
                 from drivers/nvdimm/region_devs.c:5:
./include/asm-generic/div64.h:243:22: error: passing argument 1 of ‘__div64_32’ from incompatible pointer type [-Werror=incompatible-pointer-types]
   __rem = __div64_32(&(n), __base); \

Use div_u64 instead of do_div to fix this.

Fixes: 2522afb86a8c ("libnvdimm/region: Introduce an 'align' attribute")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: use div_u64_rem and code cleanup
---
 drivers/nvdimm/region_devs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index bf239e783940..ccbb5b43b8b2 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -563,8 +563,7 @@ static ssize_t align_store(struct device *dev,
 	 * contribute to the tail capacity in system-physical-address
 	 * space for the namespace.
 	 */
-	dpa = val;
-	remainder = do_div(dpa, nd_region->ndr_mappings);
+	dpa = div_u64_rem(val, nd_region->ndr_mappings, &remainder);
 	if (!is_power_of_2(dpa) || dpa < PAGE_SIZE
 			|| val > region_size(nd_region) || remainder)
 		return -EINVAL;
@@ -1010,7 +1009,7 @@ EXPORT_SYMBOL(nd_region_release_lane);
 
 static unsigned long default_align(struct nd_region *nd_region)
 {
-	unsigned long align, per_mapping;
+	unsigned long align;
 	int i, mappings;
 	u32 remainder;
 
@@ -1030,8 +1029,7 @@ static unsigned long default_align(struct nd_region *nd_region)
 	}
 
 	mappings = max_t(u16, 1, nd_region->ndr_mappings);
-	per_mapping = align;
-	remainder = do_div(per_mapping, mappings);
+	div_u64_rem(align, mappings, &remainder);
 	if (remainder)
 		align *= mappings;
 
-- 
2.17.1


