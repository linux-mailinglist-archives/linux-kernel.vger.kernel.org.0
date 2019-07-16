Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E566B013
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 21:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbfGPTuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 15:50:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728340AbfGPTuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:50:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD81B6378;
        Tue, 16 Jul 2019 19:50:49 +0000 (UTC)
Received: from torg (ovpn-122-28.rdu2.redhat.com [10.10.122.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C11916092D;
        Tue, 16 Jul 2019 19:50:48 +0000 (UTC)
Date:   Tue, 16 Jul 2019 14:50:43 -0500
From:   Clark Williams <williams@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PREEMPT_RT] bogus lockdep assert from i915 on v5.2-rt1
Message-ID: <20190716145043.1929f50e@torg>
Organization: Red Hat, Inc
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/zVz/sAlOaLVbJoBeHrfS=UK"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 16 Jul 2019 19:50:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/zVz/sAlOaLVbJoBeHrfS=UK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thomas,

When looking at a problem on v5.2-rt1, I turned on lockdep and started getting warnings
from lockdep_assert_irqs_disabled() in the i915 driver. They're making these calls inside
a spin_lock_irqsave/spin_lock_irqrestore block, which of course doesn't fiddle with IRQs
when PREEMPT_RT is configured. The attached patch places the three calls inside
if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL)) blocks, so should avoid the bogus warning on RT.

Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790

--MP_/zVz/sAlOaLVbJoBeHrfS=UK
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-i915-avoid-calling-lockdep_assert_irqs_disabled-on-P.patch

From 8ed59c9195ce6fd338916b39155b738c557d0cab Mon Sep 17 00:00:00 2001
From: Clark Williams <williams@redhat.com>
Date: Sun, 14 Jul 2019 16:42:21 -0500
Subject: [PATCH 1/2] i915: avoid calling lockdep_assert_irqs_disabled on
 PREEMPT_RT_FULL

The PREEMPT_RT_FULL patchset keeps irqs enabled when operating on
spin_locks. Avoid this lockdep call on RT since in most cases it
will fail and WARN unnessesarily.

Signed-off-by: Clark Williams <williams@redhat.com>
---
 drivers/gpu/drm/i915/intel_breadcrumbs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_breadcrumbs.c b/drivers/gpu/drm/i915/intel_breadcrumbs.c
index 832cb6b1e9bd..3eef6010ebf6 100644
--- a/drivers/gpu/drm/i915/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/intel_breadcrumbs.c
@@ -101,7 +101,8 @@ __dma_fence_signal__notify(struct dma_fence *fence)
 	struct dma_fence_cb *cur, *tmp;
 
 	lockdep_assert_held(fence->lock);
-	lockdep_assert_irqs_disabled();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		lockdep_assert_irqs_disabled();
 
 	list_for_each_entry_safe(cur, tmp, &fence->cb_list, node) {
 		INIT_LIST_HEAD(&cur->node);
@@ -276,7 +277,8 @@ void intel_engine_fini_breadcrumbs(struct intel_engine_cs *engine)
 bool i915_request_enable_breadcrumb(struct i915_request *rq)
 {
 	lockdep_assert_held(&rq->lock);
-	lockdep_assert_irqs_disabled();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		lockdep_assert_irqs_disabled();
 
 	if (test_bit(I915_FENCE_FLAG_ACTIVE, &rq->fence.flags)) {
 		struct intel_breadcrumbs *b = &rq->engine->breadcrumbs;
@@ -325,7 +327,8 @@ void i915_request_cancel_breadcrumb(struct i915_request *rq)
 	struct intel_breadcrumbs *b = &rq->engine->breadcrumbs;
 
 	lockdep_assert_held(&rq->lock);
-	lockdep_assert_irqs_disabled();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		lockdep_assert_irqs_disabled();
 
 	/*
 	 * We must wait for b->irq_lock so that we know the interrupt handler
-- 
2.21.0


--MP_/zVz/sAlOaLVbJoBeHrfS=UK--
