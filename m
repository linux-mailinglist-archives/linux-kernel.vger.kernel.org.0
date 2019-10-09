Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD631D0B79
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 11:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfJIJjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 05:39:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56240 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfJIJjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:39:40 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iI8RT-0006l2-At; Wed, 09 Oct 2019 09:39:35 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915: remove redundant variable err
Date:   Wed,  9 Oct 2019 10:39:35 +0100
Message-Id: <20191009093935.17895-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

An earlier commit removed any error assignments to err and we
are now left with a zero assignment to err and a check that is
always false. Clean this up by removing the redundant variable
err and the error check.

Addresses-Coverity: ("'Constant' variable guard")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/i915/i915_active.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
index aa37c07004b9..67305165c12a 100644
--- a/drivers/gpu/drm/i915/i915_active.c
+++ b/drivers/gpu/drm/i915/i915_active.c
@@ -438,7 +438,6 @@ static void enable_signaling(struct i915_active_fence *active)
 int i915_active_wait(struct i915_active *ref)
 {
 	struct active_node *it, *n;
-	int err = 0;
 
 	might_sleep();
 
@@ -456,8 +455,6 @@ int i915_active_wait(struct i915_active *ref)
 	/* Any fence added after the wait begins will not be auto-signaled */
 
 	i915_active_release(ref);
-	if (err)
-		return err;
 
 	if (wait_var_event_interruptible(ref, i915_active_is_idle(ref)))
 		return -EINTR;
-- 
2.20.1

