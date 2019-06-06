Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4879F36FDF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 11:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfFFJcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 05:32:08 -0400
Received: from foss.arm.com ([217.140.101.70]:43590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbfFFJcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:32:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEBE180D;
        Thu,  6 Jun 2019 02:32:06 -0700 (PDT)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB04C3F690;
        Thu,  6 Jun 2019 02:32:04 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        marc.zyngier@arm.com, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com, james.morse@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        liwei391@huawei.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v3 1/8] arm64: Do not enable IRQs for ct_user_exit
Date:   Thu,  6 Jun 2019 10:31:50 +0100
Message-Id: <1559813517-41540-2-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559813517-41540-1-git-send-email-julien.thierry@arm.com>
References: <1559813517-41540-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For el0_dbg and el0_error, DAIF bits get explicitly cleared before
calling ct_user_exit.

When context tracking is disabled, DAIF gets set (almost) immediately
after. When context tracking is enabled, among the first things done
is disabling IRQs.

What is actually needed is:
- PSR.D = 0 so the system can be debugged (should be already the case)
- PSR.A = 0 so async error can be handled during context tracking

Do not clear PSR.I in those two locations.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc:Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index cd0c7af..89ab6bd 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -870,7 +870,7 @@ el0_dbg:
 	mov	x1, x25
 	mov	x2, sp
 	bl	do_debug_exception
-	enable_daif
+	enable_da_f
 	ct_user_exit
 	b	ret_to_user
 el0_inv:
@@ -922,7 +922,7 @@ el0_error_naked:
 	enable_dbg
 	mov	x0, sp
 	bl	do_serror
-	enable_daif
+	enable_da_f
 	ct_user_exit
 	b	ret_to_user
 ENDPROC(el0_error)
--
1.9.1
