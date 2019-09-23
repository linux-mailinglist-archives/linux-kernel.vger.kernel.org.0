Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFB9BB6E4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 16:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439999AbfIWOgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 10:36:51 -0400
Received: from foss.arm.com ([217.140.110.172]:43448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439802AbfIWOgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:36:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5CD315BF;
        Mon, 23 Sep 2019 07:36:45 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B8F73F59C;
        Mon, 23 Sep 2019 07:36:45 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 6/9] RISC-V: entry: Remove unneeded need_resched() loop
Date:   Mon, 23 Sep 2019 15:36:17 +0100
Message-Id: <20190923143620.29334-7-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190923143620.29334-1-valentin.schneider@arm.com>
References: <20190923143620.29334-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the enabling and disabling of IRQs within preempt_schedule_irq()
is contained in a need_resched() loop, we don't need the outer arch
code loop.

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/kernel/entry.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 74ccfd464071..d0523167d261 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -250,12 +250,11 @@ restore_all:
 resume_kernel:
 	REG_L s0, TASK_TI_PREEMPT_COUNT(tp)
 	bnez s0, restore_all
-need_resched:
 	REG_L s0, TASK_TI_FLAGS(tp)
 	andi s0, s0, _TIF_NEED_RESCHED
 	beqz s0, restore_all
 	call preempt_schedule_irq
-	j need_resched
+	j restore_all
 #endif
 
 work_pending:
-- 
2.22.0

