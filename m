Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E18918F640
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 14:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgCWNvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 09:51:42 -0400
Received: from foss.arm.com ([217.140.110.172]:49580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728647AbgCWNvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:51:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 948101063;
        Mon, 23 Mar 2020 06:51:39 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 108DC3F52E;
        Mon, 23 Mar 2020 06:51:37 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Enrico Weigelt <info@metux.net>, Ram Pai <linuxram@us.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 10/17] powerpc: Replace cpu_up/down with add/remove_cpu
Date:   Mon, 23 Mar 2020 13:51:03 +0000
Message-Id: <20200323135110.30522-11-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323135110.30522-1-qais.yousef@arm.com>
References: <20200323135110.30522-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core device API performs extra housekeeping bits that are missing
from directly calling cpu_up/down.

See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
serialization during LPM") for an example description of what might go
wrong.

This also prepares to make cpu_up/down a private interface for anything
but the cpu subsystem.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Enrico Weigelt <info@metux.net>
CC: Ram Pai <linuxram@us.ibm.com>
CC: Nicholas Piggin <npiggin@gmail.com>
CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
CC: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-kernel@vger.kernel.org
---
 arch/powerpc/kexec/core_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 04a7cba58eff..b4184092172a 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -212,7 +212,7 @@ static void wake_offline_cpus(void)
 		if (!cpu_online(cpu)) {
 			printk(KERN_INFO "kexec: Waking offline cpu %d.\n",
 			       cpu);
-			WARN_ON(cpu_up(cpu));
+			WARN_ON(add_cpu(cpu));
 		}
 	}
 }
-- 
2.17.1

