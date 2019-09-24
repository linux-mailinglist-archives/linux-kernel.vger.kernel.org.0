Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68032BC398
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 10:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438776AbfIXIAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 04:00:09 -0400
Received: from foss.arm.com ([217.140.110.172]:55296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406320AbfIXIAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 04:00:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8E09142F;
        Tue, 24 Sep 2019 01:00:08 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.40.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 02D393F59C;
        Tue, 24 Sep 2019 01:00:05 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memremap: Drop unused SECTION_SIZE and SECTION_MASK
Date:   Tue, 24 Sep 2019 13:30:10 +0530
Message-Id: <1569312010-31313-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SECTION_SIZE and SECTION_MASK macros are not getting used anymore. But they
do conflict with existing definitions on arm64 platform causing following
warning during build. Lets drop these unused macros.

mm/memremap.c:16: warning: "SECTION_MASK" redefined
 #define SECTION_MASK ~((1UL << PA_SECTION_SHIFT) - 1)

In file included from ./arch/arm64/include/asm/processor.h:34,
                 from ./include/linux/mutex.h:19,
                 from ./include/linux/kernfs.h:12,
                 from ./include/linux/sysfs.h:16,
                 from ./include/linux/kobject.h:20,
                 from ./include/linux/device.h:16,
                 from mm/memremap.c:3:
./arch/arm64/include/asm/pgtable-hwdef.h:79: note: this is the location of
the previous definition
 #define SECTION_MASK  (~(SECTION_SIZE-1))

mm/memremap.c:17: warning: "SECTION_SIZE" redefined
 #define SECTION_SIZE (1UL << PA_SECTION_SHIFT)

In file included from ./arch/arm64/include/asm/processor.h:34,
                 from ./include/linux/mutex.h:19,
                 from ./include/linux/kernfs.h:12,
                 from ./include/linux/sysfs.h:16,
                 from ./include/linux/kobject.h:20,
                 from ./include/linux/device.h:16,
                 from mm/memremap.c:3:
./arch/arm64/include/asm/pgtable-hwdef.h:78: note: this is the location of
the previous definition
 #define SECTION_SIZE  (_AC(1, UL) << SECTION_SHIFT)

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: linux-kernel@vger.kernel.org
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Build and boot tested on arm64 platform with ZONE_DEVICE enabled. But
only boot tested on arm64 and some other platforms with allmodconfig.

 mm/memremap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index f6c17339cd0d..bf2882bfbf48 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -13,8 +13,6 @@
 #include <linux/xarray.h>
 
 static DEFINE_XARRAY(pgmap_array);
-#define SECTION_MASK ~((1UL << PA_SECTION_SHIFT) - 1)
-#define SECTION_SIZE (1UL << PA_SECTION_SHIFT)
 
 #ifdef CONFIG_DEV_PAGEMAP_OPS
 DEFINE_STATIC_KEY_FALSE(devmap_managed_key);
-- 
2.20.1

