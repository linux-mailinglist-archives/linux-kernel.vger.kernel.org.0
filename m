Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00809D8620
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 04:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390778AbfJPC5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 22:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390762AbfJPC5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:57:36 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8811121928;
        Wed, 16 Oct 2019 02:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571194656;
        bh=g0pcVD0fBE9giR4HcvE1h3o3TTkfn7+xyzWMWt0BsjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ic08XjclTpZV94ujvWq5UPCkhaO+jFIDS6aYEUIFu9ONCT/L7nB8T26xlrcHG1D/7
         NNvHVkwaRN3hylD4DHzPZ7DLSaDf0XyF+l6ueVw9m16wvMZyBgrzZZcOFxrAj60T++
         nVaiYH/GcFVloNAnirqsgSm+Z/V2rNWCmLYbleXc=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 10/14] context_tracking: Check static key on context_tracking_enabled_*cpu()
Date:   Wed, 16 Oct 2019 04:56:56 +0200
Message-Id: <20191016025700.31277-11-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016025700.31277-1-frederic@kernel.org>
References: <20191016025700.31277-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

guest_enter() doesn't call context_tracking_enabled() before calling
context_tracking_enabled_this_cpu(). Therefore the guest code doesn't
benefit from the static key on the fast path.

Just make sure that context_tracking_enabled_*cpu() functions check
the static key by themselves to propagate the optimization.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/context_tracking_state.h | 4 ++--
 include/linux/vtime.h                  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 587717705727..e7fe6678b7ad 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -33,12 +33,12 @@ static inline bool context_tracking_enabled(void)
 
 static inline bool context_tracking_enabled_cpu(int cpu)
 {
-	return per_cpu(context_tracking.active, cpu);
+	return context_tracking_enabled() && per_cpu(context_tracking.active, cpu);
 }
 
 static inline bool context_tracking_enabled_this_cpu(void)
 {
-	return __this_cpu_read(context_tracking.active);
+	return context_tracking_enabled() && __this_cpu_read(context_tracking.active);
 }
 
 static inline bool context_tracking_in_user(void)
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index e2733bf33541..2cdeca062db3 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -33,12 +33,12 @@ static inline bool vtime_accounting_enabled(void)
 
 static inline bool vtime_accounting_enabled_cpu(int cpu)
 {
-	return (vtime_accounting_enabled() && context_tracking_enabled_cpu(cpu));
+	return context_tracking_enabled_cpu(cpu);
 }
 
 static inline bool vtime_accounting_enabled_this_cpu(void)
 {
-	return (vtime_accounting_enabled() && context_tracking_enabled_this_cpu());
+	return context_tracking_enabled_this_cpu();
 }
 
 extern void vtime_task_switch_generic(struct task_struct *prev);
-- 
2.23.0

