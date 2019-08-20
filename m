Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08496965B5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 17:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfHTP6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 11:58:10 -0400
Received: from foss.arm.com ([217.140.110.172]:44058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfHTP6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:58:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8885128;
        Tue, 20 Aug 2019 08:58:09 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 281AA3F246;
        Tue, 20 Aug 2019 08:58:08 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, acme@kernel.org, mark.rutland@arm.com,
        raph.gault+kdev@gmail.com, Raphael Gault <raphael.gault@arm.com>
Subject: [PATCH] arm64: perf_event: Add missing header needed for smp_processor_id()
Date:   Tue, 20 Aug 2019 16:57:45 +0100
Message-Id: <20190820155745.20593-1-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 arch/arm64/kernel/perf_event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 96e90e270042..24575c0a0065 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
+#include <linux/smp.h>
 
 /* ARMv8 Cortex-A53 specific event types. */
 #define ARMV8_A53_PERFCTR_PREF_LINEFILL				0xC2
-- 
2.17.1

