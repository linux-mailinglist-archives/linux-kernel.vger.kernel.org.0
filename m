Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E3B1350F7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 02:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgAIB12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 20:27:28 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35328 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726654AbgAIB12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 20:27:28 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 298DDC0C771FA417D7AD;
        Thu,  9 Jan 2020 09:27:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 9 Jan 2020 09:27:16 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <airlied@linux.ie>, <jani.nikula@linux.intel.com>,
        <chris@chris-wilson.co.uk>
CC:     <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH next v2] drm/i915/gtt: add missing include file asm/smp.h
Date:   Thu, 9 Jan 2020 09:23:03 +0800
Message-ID: <20200109012303.153001-1-chenzhou10@huawei.com>
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

Fix build error:
drivers/gpu/drm/i915/gt/intel_ggtt.c: In function ggtt_restore_mappings:
drivers/gpu/drm/i915/gt/intel_ggtt.c:1239:3: error:
	implicit declaration of function wbinvd_on_all_cpus; did you mean wrmsr_on_cpus? [-Werror=implicit-function-declaration]
   wbinvd_on_all_cpus();
      ^~~~~~~~~~~~~~~~~~
         wrmsr_on_cpus

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---

changes in v2:
- correct build error messages.

---
 drivers/gpu/drm/i915/gt/intel_ggtt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
index 1a2b5dc..9ef8ed8 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
@@ -6,6 +6,7 @@
 #include <linux/stop_machine.h>
 
 #include <asm/set_memory.h>
+#include <asm/smp.h>
 
 #include "intel_gt.h"
 #include "i915_drv.h"
-- 
2.7.4

