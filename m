Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0D117E809
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 20:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgCITFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 15:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbgCITEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:04:25 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90F122465D;
        Mon,  9 Mar 2020 19:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780665;
        bh=8ct4k9EQ96WU1gDhy3rwlqxEXCUMYNo28oo7Rj2xjfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eDlsutZ1MyvM+30ZO1sh1XVqlj/AF2XbJ5vJCGpAGAPtbTiMkY5ttRDxybbveHvvx
         KSk27Wp5HLz1z9g9RDsIugZv8aC0WF0b11dhZpQNydtwDILafp8oJkwP+RpifOt6VB
         MZqskKjZiny1y/7Uod7j+Sqv4Jz4evRXjJAzBauI=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 14/32] kcsan: Cleanup of main KCSAN Kconfig option
Date:   Mon,  9 Mar 2020 12:04:02 -0700
Message-Id: <20200309190420.6100-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200309190359.GA5822@paulmck-ThinkPad-P72>
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

This patch cleans up the rules of the 'KCSAN' Kconfig option by:
  1. implicitly selecting 'STACKTRACE' instead of depending on it;
  2. depending on DEBUG_KERNEL, to avoid accidentally turning KCSAN on if
     the kernel is not meant to be a debug kernel;
  3. updating the short and long summaries.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/Kconfig.kcsan | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 020ac63..9785bbf 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -4,12 +4,15 @@ config HAVE_ARCH_KCSAN
 	bool
 
 menuconfig KCSAN
-	bool "KCSAN: watchpoint-based dynamic data race detector"
-	depends on HAVE_ARCH_KCSAN && !KASAN && STACKTRACE
+	bool "KCSAN: dynamic data race detector"
+	depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN
+	select STACKTRACE
 	help
-	  Kernel Concurrency Sanitizer is a dynamic data race detector, which
-	  uses a watchpoint-based sampling approach to detect races. See
-	  <file:Documentation/dev-tools/kcsan.rst> for more details.
+	  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic data race
+	  detector, which relies on compile-time instrumentation, and uses a
+	  watchpoint-based sampling approach to detect data races.
+
+	  See <file:Documentation/dev-tools/kcsan.rst> for more details.
 
 if KCSAN
 
-- 
2.9.5

