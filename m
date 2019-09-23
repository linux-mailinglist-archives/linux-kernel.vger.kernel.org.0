Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5E3BB6EB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 16:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439913AbfIWOgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 10:36:46 -0400
Received: from foss.arm.com ([217.140.110.172]:43420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438045AbfIWOgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:36:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52BEC1597;
        Mon, 23 Sep 2019 07:36:42 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C0F23F59C;
        Mon, 23 Sep 2019 07:36:41 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Subject: [PATCH v2 2/9] c6x: entry: Remove unneeded need_resched() loop
Date:   Mon, 23 Sep 2019 15:36:13 +0100
Message-Id: <20190923143620.29334-3-valentin.schneider@arm.com>
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

Acked-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: linux-c6x-dev@linux-c6x.org
---
 arch/c6x/kernel/entry.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/c6x/kernel/entry.S b/arch/c6x/kernel/entry.S
index 4332a10aec6c..3cb71b31c4cd 100644
--- a/arch/c6x/kernel/entry.S
+++ b/arch/c6x/kernel/entry.S
@@ -564,7 +564,6 @@ resume_kernel:
 	NOP	4
  [A1]	BNOP	.S2	restore_all,5
 
-preempt_schedule:
 	GET_THREAD_INFO A2
 	LDW	.D1T1	*+A2(THREAD_INFO_FLAGS),A1
 #ifdef CONFIG_C6X_BIG_KERNEL
@@ -581,7 +580,7 @@ preempt_schedule:
 #else
 	B	.S2	preempt_schedule_irq
 #endif
-	ADDKPC	.S2	preempt_schedule,B3,4
+	ADDKPC	.S2	restore_all,B3,4
 #endif /* CONFIG_PREEMPT */
 
 ENTRY(enable_exception)
-- 
2.22.0

