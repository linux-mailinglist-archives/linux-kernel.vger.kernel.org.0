Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90F4157776
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 14:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbgBJNAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 08:00:30 -0500
Received: from foss.arm.com ([217.140.110.172]:60752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730161AbgBJNA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:00:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34AC831B;
        Mon, 10 Feb 2020 05:00:26 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B1063F68E;
        Mon, 10 Feb 2020 05:00:25 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        richard.henderson@linaro.org, tytso@mit.edu, will@kernel.org
Subject: [PATCH 3/4] arm64: add credited/trusted RNG support
Date:   Mon, 10 Feb 2020 13:00:14 +0000
Message-Id: <20200210130015.17664-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200210130015.17664-1-mark.rutland@arm.com>
References: <20200210130015.17664-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently arm64 doesn't initialize the primary CRNG in a (potentially)
trusted manner as we only detect the presence of the RNG once secondary
CPUs are up.

Now that the core RNG code distinguishes the early initialization of the
primary CRNG, we can implement arch_get_random_seed_long_early() to
support this.

This patch does so.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/archrandom.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/asm/archrandom.h
index 3fe02da70004..fc1594a0710e 100644
--- a/arch/arm64/include/asm/archrandom.h
+++ b/arch/arm64/include/asm/archrandom.h
@@ -4,6 +4,8 @@
 
 #ifdef CONFIG_ARCH_RANDOM
 
+#include <linux/bug.h>
+#include <linux/kernel.h>
 #include <linux/random.h>
 #include <asm/cpufeature.h>
 
@@ -66,6 +68,18 @@ static inline bool __init __early_cpu_has_rndr(void)
 	return (ftr >> ID_AA64ISAR0_RNDR_SHIFT) & 0xf;
 }
 
+static inline bool __init __must_check
+arch_get_random_seed_long_early(unsigned long *v)
+{
+	WARN_ON(system_state != SYSTEM_BOOTING);
+
+	if (!__early_cpu_has_rndr())
+		return false;
+
+	return __arm64_rndr(v);
+}
+#define arch_get_random_seed_long_early arch_get_random_seed_long_early
+
 #else
 
 static inline bool __arm64_rndr(unsigned long *v) { return false; }
-- 
2.11.0

