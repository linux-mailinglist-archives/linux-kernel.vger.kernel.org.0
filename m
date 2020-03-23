Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE51B18F63E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 14:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgCWNvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 09:51:38 -0400
Received: from foss.arm.com ([217.140.110.172]:49526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbgCWNve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:51:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A50A1396;
        Mon, 23 Mar 2020 06:51:34 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 564233F52E;
        Mon, 23 Mar 2020 06:51:33 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 07/17] arm64: Use reboot_cpu instead of hardconding it to 0
Date:   Mon, 23 Mar 2020 13:51:00 +0000
Message-Id: <20200323135110.30522-8-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323135110.30522-1-qais.yousef@arm.com>
References: <20200323135110.30522-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use `reboot_cpu` variable instead of hardcoding 0 as the reboot cpu in
machine_shutdown().

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will@kernel.org>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 arch/arm64/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 1b9f7b749d75..3e5a6ad66cbe 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -145,7 +145,7 @@ void arch_cpu_idle_dead(void)
  */
 void machine_shutdown(void)
 {
-	smp_shutdown_nonboot_cpus(0);
+	smp_shutdown_nonboot_cpus(reboot_cpu);
 }
 
 /*
-- 
2.17.1

