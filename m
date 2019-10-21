Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4113DF33D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 18:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbfJUQfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 12:35:22 -0400
Received: from [217.140.110.172] ([217.140.110.172]:57654 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbfJUQfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:35:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F36B21692;
        Mon, 21 Oct 2019 09:34:53 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B29693F71F;
        Mon, 21 Oct 2019 09:34:51 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     amit.kachhap@arm.com, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        james.morse@arm.com, jeyu@kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, mark.rutland@arm.com, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
Subject: [PATCH 6/8] arm64: asm-offsets: add S_FP
Date:   Mon, 21 Oct 2019 17:34:24 +0100
Message-Id: <20191021163426.9408-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191021163426.9408-1-mark.rutland@arm.com>
References: <20191021163426.9408-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that assembly code can more easily manipulate the FP (x29) within a
pt_regs, add an S_FP asm-offsets definition.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/asm-offsets.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 214685760e1c..a5bdce8af65b 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -56,6 +56,7 @@ int main(void)
   DEFINE(S_X24,			offsetof(struct pt_regs, regs[24]));
   DEFINE(S_X26,			offsetof(struct pt_regs, regs[26]));
   DEFINE(S_X28,			offsetof(struct pt_regs, regs[28]));
+  DEFINE(S_FP,			offsetof(struct pt_regs, regs[29]));
   DEFINE(S_LR,			offsetof(struct pt_regs, regs[30]));
   DEFINE(S_SP,			offsetof(struct pt_regs, sp));
   DEFINE(S_PSTATE,		offsetof(struct pt_regs, pstate));
-- 
2.11.0

