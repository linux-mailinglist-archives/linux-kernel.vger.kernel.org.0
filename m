Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF6ED132814
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 14:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgAGNus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 08:50:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9119 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727658AbgAGNus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:50:48 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 627125F4EBFE2DB72D19;
        Tue,  7 Jan 2020 21:50:45 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 7 Jan 2020
 21:50:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <ville.syrjala@linux.intel.com>, <chris@chris-wilson.co.uk>,
        <tvrtko.ursulin@intel.com>, <yuehaibing@huawei.com>,
        <matthew.auld@intel.com>
CC:     <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/i915: Add missing include file <linux/math64.h>
Date:   Tue, 7 Jan 2020 21:50:14 +0800
Message-ID: <20200107135014.36472-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error:
./drivers/gpu/drm/i915/selftests/i915_random.h: In function i915_prandom_u32_max_state:
./drivers/gpu/drm/i915/selftests/i915_random.h:48:23: error:
 implicit declaration of function mul_u32_u32; did you mean mul_u64_u32_div? [-Werror=implicit-function-declaration]
  return upper_32_bits(mul_u32_u32(prandom_u32_state(state), ep_ro));

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 7ce5b6850b47 ("drm/i915/selftests: Use mul_u32_u32() for 32b x 32b -> 64b result")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/i915/selftests/i915_random.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/selftests/i915_random.h b/drivers/gpu/drm/i915/selftests/i915_random.h
index 35cc69a..f650cfb 100644
--- a/drivers/gpu/drm/i915/selftests/i915_random.h
+++ b/drivers/gpu/drm/i915/selftests/i915_random.h
@@ -26,6 +26,7 @@
 #define __I915_SELFTESTS_RANDOM_H__
 
 #include <linux/random.h>
+#include <linux/math64.h>
 
 #include "../i915_selftest.h"
 
-- 
2.7.4


