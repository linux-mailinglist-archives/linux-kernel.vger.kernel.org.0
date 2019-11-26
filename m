Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1497109E06
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 13:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfKZMgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 07:36:06 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:14535 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbfKZMgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:36:06 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47Mk0L6SN5z9v0G4;
        Tue, 26 Nov 2019 13:36:02 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=oKWo+zQq; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sy2nbQBvnlm6; Tue, 26 Nov 2019 13:36:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47Mk0L5P7Qz9v0G3;
        Tue, 26 Nov 2019 13:36:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574771762; bh=S4Id3wMLy6jAh6nEC8BsTFEBlkSuV/BaTuK6CGZslfI=;
        h=From:Subject:To:Cc:Date:From;
        b=oKWo+zQqtTYKNzC9HiycrgCE+P3gx6lVj/5nkQ3YrHHU7IiBy2byYert4pPRg52fP
         GtBub76ElXO1FxSGOcOV1JC7BDSYvUb45OUNJqGauhmo549kZSKFpf6WXUxD7BPXfG
         zJzaoaCeiXNdwPCldt/3SAPT+bERz32ebtGrMI2o=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FD1B8B7FC;
        Tue, 26 Nov 2019 13:36:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kfd4sNZgw0Et; Tue, 26 Nov 2019 13:36:03 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BC4D18B771;
        Tue, 26 Nov 2019 13:36:03 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 535F56B76A; Tue, 26 Nov 2019 12:36:03 +0000 (UTC)
Message-Id: <cover.1574771539.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 00/16] Enable CONFIG_VMAP_STACK on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Tue, 26 Nov 2019 12:36:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this serie is to enable CONFIG_VMAP_STACK on PPC32.

rfc v1: initial support on 8xx

rfc v2: added stack overflow detection.

v3:
- Stack overflow detection works, tested with LKDTM STACK_EXHAUST test
- Support for book3s32 added

v4:
- Fixed build failure with CONFIG_KVM (patch 14)
- Fixed boot failure with pmac32_defconfig+VMAP_STACK+KVM (new patch 15)
- Fixed crash with altivec and fpu (patch 16)

Christophe Leroy (16):
  powerpc/32: replace MTMSRD() by mtmsr
  powerpc/32: Add EXCEPTION_PROLOG_0 in head_32.h
  powerpc/32: save DEAR/DAR before calling handle_page_fault
  powerpc/32: move MSR_PR test into EXCEPTION_PROLOG_0
  powerpc/32: add a macro to get and/or save DAR and DSISR on stack.
  powerpc/32: prepare for CONFIG_VMAP_STACK
  powerpc: align stack to 2 * THREAD_SIZE with VMAP_STACK
  powerpc/32: Add early stack overflow detection with VMAP stack.
  powerpc/8xx: Use alternative scratch registers in DTLB miss handler
  powerpc/8xx: drop exception entries for non-existing exceptions
  powerpc/8xx: move DataStoreTLBMiss perf handler
  powerpc/8xx: split breakpoint exception
  powerpc/8xx: Enable CONFIG_VMAP_STACK
  powerpc/32s: reorganise DSI handler.
  powerpc/32s: avoid crossing page boundary while changing SRR0/1.
  powerpc/32s: Activate CONFIG_VMAP_STACK

 arch/powerpc/include/asm/irq.h         |   1 +
 arch/powerpc/include/asm/processor.h   |   6 ++
 arch/powerpc/include/asm/thread_info.h |  18 ++++
 arch/powerpc/kernel/asm-offsets.c      |   6 ++
 arch/powerpc/kernel/entry_32.S         |  55 ++++++++--
 arch/powerpc/kernel/fpu.S              |   3 +
 arch/powerpc/kernel/head_32.S          |  65 ++++++++----
 arch/powerpc/kernel/head_32.h          | 129 ++++++++++++++++++++---
 arch/powerpc/kernel/head_40x.S         |   2 +
 arch/powerpc/kernel/head_8xx.S         | 186 +++++++++++++++------------------
 arch/powerpc/kernel/head_booke.h       |   2 +
 arch/powerpc/kernel/head_fsl_booke.S   |   1 +
 arch/powerpc/kernel/irq.c              |   1 +
 arch/powerpc/kernel/setup_32.c         |   3 +-
 arch/powerpc/kernel/setup_64.c         |   2 +-
 arch/powerpc/kernel/traps.c            |  15 ++-
 arch/powerpc/kernel/vector.S           |   3 +
 arch/powerpc/kernel/vmlinux.lds.S      |   2 +-
 arch/powerpc/mm/book3s32/hash_low.S    |  46 +++++---
 arch/powerpc/mm/book3s32/mmu.c         |   9 +-
 arch/powerpc/perf/8xx-pmu.c            |  12 ++-
 arch/powerpc/platforms/Kconfig.cputype |   3 +
 22 files changed, 393 insertions(+), 177 deletions(-)

-- 
2.13.3

