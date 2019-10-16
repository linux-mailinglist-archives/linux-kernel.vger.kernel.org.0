Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93F7D861D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 04:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390744AbfJPC5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 22:57:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388896AbfJPC51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:57:27 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA11721D71;
        Wed, 16 Oct 2019 02:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571194647;
        bh=t6jIUJsBeTYu2KA0dJ2OvkGQN6ViePg9iPPoYtSusZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2a+loF5gybKCBef8w1Z/FRK+YloggKRUrFEnc657lwNfJTv2EDtzAJLhRGzdKaiCI
         dBoJK/0pxqnuKotAEMPUbsdWNSMabOtmJH0pcES4//P0ycCWJPbavjcQ1vDbPyN2A6
         h8JyOs5v56/XPaD+nS1HmpwmHub7Av6Xh2SE1WS0=
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
Subject: [PATCH 07/14] context_tracking: Introduce context_tracking_enabled_cpu()
Date:   Wed, 16 Oct 2019 04:56:53 +0200
Message-Id: <20191016025700.31277-8-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016025700.31277-1-frederic@kernel.org>
References: <20191016025700.31277-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to check if a remote CPU runs context tracking
(ie: is nohz_full). We'll need that to reliably support "nice"
accounting on kcpustat.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/context_tracking_state.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 08f125f6b31b..587717705727 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -31,6 +31,11 @@ static inline bool context_tracking_enabled(void)
 	return static_branch_unlikely(&context_tracking_key);
 }
 
+static inline bool context_tracking_enabled_cpu(int cpu)
+{
+	return per_cpu(context_tracking.active, cpu);
+}
+
 static inline bool context_tracking_enabled_this_cpu(void)
 {
 	return __this_cpu_read(context_tracking.active);
@@ -43,6 +48,7 @@ static inline bool context_tracking_in_user(void)
 #else
 static inline bool context_tracking_in_user(void) { return false; }
 static inline bool context_tracking_enabled(void) { return false; }
+static inline bool context_tracking_enabled_cpu(int cpu) { return false; }
 static inline bool context_tracking_enabled_this_cpu(void) { return false; }
 #endif /* CONFIG_CONTEXT_TRACKING */
 
-- 
2.23.0

