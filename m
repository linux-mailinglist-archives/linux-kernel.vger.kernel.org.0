Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 747752A05A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 23:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404259AbfEXV0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 17:26:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58802 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404163AbfEXV0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:26:38 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hUHhr-0007g4-Jm; Fri, 24 May 2019 21:26:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915/gtt: set err to -ENOMEM on memory allocation failure
Date:   Fri, 24 May 2019 22:26:27 +0100
Message-Id: <20190524212627.24256-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when the allocation of ppgtt->work fails the error return
path via err_free returns an uninitialized value in err. Fix this
by setting err to the appropriate error return of -ENOMEM.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: d3622099c76f ("drm/i915/gtt: Always acquire struct_mutex for gen6_ppgtt_cleanup")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/i915/i915_gem_gtt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_gem_gtt.c b/drivers/gpu/drm/i915/i915_gem_gtt.c
index 8d8a4b0ad4d9..8a9b506387d4 100644
--- a/drivers/gpu/drm/i915/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/i915_gem_gtt.c
@@ -2035,8 +2035,10 @@ static struct i915_hw_ppgtt *gen6_ppgtt_create(struct drm_i915_private *i915)
 	ppgtt->base.vm.pte_encode = ggtt->vm.pte_encode;
 
 	ppgtt->work = kmalloc(sizeof(*ppgtt->work), GFP_KERNEL);
-	if (!ppgtt->work)
+	if (!ppgtt->work) {
+		err = -ENOMEM;
 		goto err_free;
+	}
 
 	err = gen6_ppgtt_init_scratch(ppgtt);
 	if (err)
-- 
2.20.1

