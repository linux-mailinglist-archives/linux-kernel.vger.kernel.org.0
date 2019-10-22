Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D25D7E0C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 21:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbfJVTM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 15:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732903AbfJVTMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:12:25 -0400
Received: from localhost.localdomain (rrcs-50-75-166-42.nys.biz.rr.com [50.75.166.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD91521929;
        Tue, 22 Oct 2019 19:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571771544;
        bh=inhfkOQ9xIrGDaCXR3ixnBd1vmXaWhpuxLRSRAKlsWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ey3dmNkSSy9+VhZatSefvVHUlOQmRmf4ayTRDRoEl0yBjeL/KIK7JUHddhoroBK62
         ss5alIYeXVCEvv042Mn3H42RH3aZI8KvX3I2u9bcn8Y3VMiNkOpU/HxNz7lLE0keP3
         YgBhVpFNXO8jbnlFi7Ai0xppgCT17WZXccEuJZ5A=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH tip/core/rcu 03/10] drivers/gpu: Replace rcu_swap_protected() with rcu_replace()
Date:   Tue, 22 Oct 2019 12:12:08 -0700
Message-Id: <20191022191215.25781-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191022191136.GA25627@paulmck-ThinkPad-P72>
References: <20191022191136.GA25627@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit replaces the use of rcu_swap_protected() with the more
intuitively appealing rcu_replace() as a step towards removing
rcu_swap_protected().

Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
[ paulmck: From rcu_replace() to rcu_replace_pointer() per Ingo Molnar. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: <intel-gfx@lists.freedesktop.org>
Cc: <dri-devel@lists.freedesktop.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index 1cdfe05..3f3e803 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -1629,7 +1629,7 @@ set_engines(struct i915_gem_context *ctx,
 		i915_gem_context_set_user_engines(ctx);
 	else
 		i915_gem_context_clear_user_engines(ctx);
-	rcu_swap_protected(ctx->engines, set.engines, 1);
+	set.engines = rcu_replace_pointer(ctx->engines, set.engines, 1);
 	mutex_unlock(&ctx->engines_mutex);
 
 	call_rcu(&set.engines->rcu, free_engines_rcu);
-- 
2.9.5

