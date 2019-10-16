Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FECDD861A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 04:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390714AbfJPC5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 22:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390685AbfJPC5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:57:18 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BABCC217D6;
        Wed, 16 Oct 2019 02:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571194638;
        bh=QcvjcZhhDwySKoPuQHzX8i9cXnr4fp5bwaMkIAToTLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqHsLIOfqpg3R9B8q86h01AFDwPtp+plxWoQU7a5h2/EtZBFL6vS7LOEs5ETRDg7n
         Wu/jaxtd3sTiCk9mkVH6WQYtK59EtG2ynAJbSVevNOroxXL7xP/dsxyuUcwLreTOno
         CW2XTHn6D236HK5uDptpg6EWV82LnreGo94tV0VY=
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
Subject: [PATCH 04/14] context_tracking: Remove context_tracking_active()
Date:   Wed, 16 Oct 2019 04:56:50 +0200
Message-Id: <20191016025700.31277-5-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016025700.31277-1-frederic@kernel.org>
References: <20191016025700.31277-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is a leftover from old removal or rename. We can drop it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/context_tracking_state.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index f128dc3be0df..f4633c2c29a5 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -42,7 +42,6 @@ static inline bool context_tracking_in_user(void)
 }
 #else
 static inline bool context_tracking_in_user(void) { return false; }
-static inline bool context_tracking_active(void) { return false; }
 static inline bool context_tracking_is_enabled(void) { return false; }
 static inline bool context_tracking_cpu_is_enabled(void) { return false; }
 #endif /* CONFIG_CONTEXT_TRACKING */
-- 
2.23.0

