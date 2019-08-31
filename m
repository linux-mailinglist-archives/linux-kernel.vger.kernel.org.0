Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC98A43ED
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 12:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfHaKS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 06:18:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:21120 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfHaKS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 06:18:27 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46LC3h1mPdz9v4gN;
        Sat, 31 Aug 2019 12:18:24 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=XcPoqKSs; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id yCN6EBBjj26Z; Sat, 31 Aug 2019 12:18:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46LC3h0Ttpz9v4gL;
        Sat, 31 Aug 2019 12:18:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567246704; bh=qFMzlyfxCodFSC4zHAOz2kDQ77ypyGQHTBxTejDX1bI=;
        h=From:Subject:To:Cc:Date:From;
        b=XcPoqKSsWPUOi2/+SwSxnbm73qCTTiXgUobkrwGvL7FHKduXJ5zNKAYV4Iq5g1pfI
         w/kTNtJGAOmRI3kLJ+tHVsu2DOAOldn+6zYmMbAT40yHcGwTPYCSY9afpvXAvq6nYq
         U3+BNQOwhYJ6mIMUb0To3O8ANNxbvwbwQUVl3ZGA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6828E8B7B9;
        Sat, 31 Aug 2019 12:18:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JaMaC9-f54tk; Sat, 31 Aug 2019 12:18:25 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 33C698B789;
        Sat, 31 Aug 2019 12:18:25 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 551F06985C; Sat, 31 Aug 2019 10:18:23 +0000 (UTC)
Message-Id: <cover.1567245404.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 00/10] Enable CONFIG_VMAP_STACK on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 31 Aug 2019 10:18:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this serie is to enable CONFIG_VMAP_STACK on PPC32.

For the time being we have something working on 8xx.

Further work I'm working on:
- Fix stack overflow detection (doesn't work all the time yet, with the LKDTM STACK_EXHAUST test it hang).
- Add support to powerpc 603
- Add support to all book3s32

v2: added stack overflow detection.

Christophe Leroy (10):
  powerpc/32: replace MTMSRD() by mtmsr
  powerpc/32: Add EXCEPTION_PROLOG_0 in head_32.h
  powerpc/32: prepare for CONFIG_VMAP_STACK
  powerpc/8xx: Use alternative scratch registers in DTLB miss handler
  powerpc/8xx: drop exception entries for non-existing exceptions
  powerpc/8xx: move DataStoreTLBMiss perf handler
  powerpc/8xx: split breakpoint exception
  powerpc/8xx: Enable CONFIG_VMAP_STACK
  powerpc: align stack to 2 * THREAD_SIZE with VMAP_STACK
  powerpc/32: Add stack overflow detection with VMAP stack.

 arch/powerpc/Kconfig                   |   1 +
 arch/powerpc/include/asm/processor.h   |   5 ++
 arch/powerpc/include/asm/thread_info.h |  18 ++++
 arch/powerpc/kernel/asm-offsets.c      |   5 ++
 arch/powerpc/kernel/entry_32.S         |  37 +++++++--
 arch/powerpc/kernel/head_32.S          |   4 +-
 arch/powerpc/kernel/head_32.h          |  98 ++++++++++++++++++++--
 arch/powerpc/kernel/head_8xx.S         | 145 ++++++++++++++++++---------------
 arch/powerpc/kernel/setup_32.c         |   2 +-
 arch/powerpc/kernel/setup_64.c         |   2 +-
 arch/powerpc/kernel/vmlinux.lds.S      |   2 +-
 arch/powerpc/perf/8xx-pmu.c            |  12 ++-
 12 files changed, 240 insertions(+), 91 deletions(-)

-- 
2.13.3

