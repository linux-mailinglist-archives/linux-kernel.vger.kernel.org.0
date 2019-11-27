Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0EAE10ADE0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 11:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfK0Kj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 05:39:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:56122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727169AbfK0Kjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:39:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88612B40D;
        Wed, 27 Nov 2019 10:39:50 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Breno Leitao <leitao@debian.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        Daniel Axtens <dja@axtens.net>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Romero <gromero@linux.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 rebase 21/34] powerpc/64s/exception: soft nmi interrupt should not use ret_from_except
Date:   Wed, 27 Nov 2019 11:38:57 +0100
Message-Id: <35ff4ea58b58f949072efc24c9920648ffdafb05.1574803685.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574803684.git.msuchanek@suse.de>
References: <cover.1574803684.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

The soft nmi handler does not reconcile interrupt state, so it should
not return via the normal ret_from_except path. Return like other NMIs,
using the EXCEPTION_RESTORE_REGS macro.

This becomes important when the scv interrupt is implemented, which
must handle soft-masked interrupts that have r13 set to something other
than the PACA -- returning to kernel in this case must restore r13.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 38bc66b95516..af1264cd005f 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -2740,7 +2740,11 @@ EXC_COMMON_BEGIN(soft_nmi_common)
 	bl	save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	soft_nmi_interrupt
-	b	ret_from_except
+	/* Clear MSR_RI before setting SRR0 and SRR1. */
+	li	r9,0
+	mtmsrd	r9,1
+	EXCEPTION_RESTORE_REGS hsrr=0
+	RFI_TO_KERNEL
 
 #endif /* CONFIG_PPC_WATCHDOG */
 
-- 
2.23.0

