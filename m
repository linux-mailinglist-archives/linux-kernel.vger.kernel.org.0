Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5F4103BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbfKTNiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:38:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbfKTNiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:38:11 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9B1A224D2;
        Wed, 20 Nov 2019 13:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257090;
        bh=RBuBWXYf0/lyp7anjxfePMKjgagftH/zMcvO62N8Awg=;
        h=From:To:Cc:Subject:Date:From;
        b=yQih8+6gflE9Z0OLVtEs36odQqhrnkNGN7eNMSqRQqYgdeFBV3Eklarxqm+Lc1UKI
         CcTOo1vCnC2fBUrjtsenRt+UH0XcgvP4yjKYVhsSzH2rwiQr/Z5r2uM+RErIrzb1cx
         sR7RRJgct5o75MJw6weZmtq2sCHBhaVfeXI02k0k=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] trace: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:38:07 +0800
Message-Id: <20191120133807.12741-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 kernel/trace/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index b872716bb2a0..f67620499faa 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -79,7 +79,7 @@ config FTRACE_NMI_ENTER
 
 config EVENT_TRACING
 	select CONTEXT_SWITCH_TRACER
-        select GLOB
+	select GLOB
 	bool
 
 config CONTEXT_SWITCH_TRACER
@@ -311,7 +311,7 @@ config TRACER_SNAPSHOT
 	      cat snapshot
 
 config TRACER_SNAPSHOT_PER_CPU_SWAP
-        bool "Allow snapshot to swap per CPU"
+	bool "Allow snapshot to swap per CPU"
 	depends on TRACER_SNAPSHOT
 	select RING_BUFFER_ALLOW_SWAP
 	help
@@ -683,7 +683,7 @@ config MMIOTRACE_TEST
 	  Say N, unless you absolutely know what you are doing.
 
 config TRACEPOINT_BENCHMARK
-        bool "Add tracepoint that benchmarks tracepoints"
+	bool "Add tracepoint that benchmarks tracepoints"
 	help
 	 This option creates the tracepoint "benchmark:benchmark_event".
 	 When the tracepoint is enabled, it kicks off a kernel thread that
@@ -732,7 +732,7 @@ config RING_BUFFER_STARTUP_TEST
        bool "Ring buffer startup self test"
        depends on RING_BUFFER
        help
-         Run a simple self test on the ring buffer on boot up. Late in the
+	 Run a simple self test on the ring buffer on boot up. Late in the
 	 kernel boot sequence, the test will start that kicks off
 	 a thread per cpu. Each thread will write various size events
 	 into the ring buffer. Another thread is created to send IPIs
-- 
2.17.1

