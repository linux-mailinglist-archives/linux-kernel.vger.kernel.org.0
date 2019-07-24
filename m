Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5051B7274B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 07:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfGXFZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 01:25:22 -0400
Received: from ispman.iskranet.ru ([62.213.33.10]:38342 "EHLO
        ispman.iskranet.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGXFZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 01:25:22 -0400
Received: by ispman.iskranet.ru (Postfix, from userid 8)
        id 9252E8217E2; Wed, 24 Jul 2019 12:25:19 +0700 (KRAT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on ispman.iskranet.ru
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=4.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        shortcircuit=ham autolearn=disabled version=3.3.2
Received: from KB016249 (unknown [62.213.40.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ispman.iskranet.ru (Postfix) with ESMTPS id E31798217E2;
        Wed, 24 Jul 2019 12:25:18 +0700 (KRAT)
From:   Arseny Solokha <asolokha@kb.kras.ru>
To:     christian@brauner.io
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au
Subject: Re: [PATCH] powerpc: Wire up clone3 syscall
In-Reply-To: <20190722133701.g3w5g4crogqb7oi5@brauner.io>
References: <20190722133701.g3w5g4crogqb7oi5@brauner.io>
Date:   Wed, 24 Jul 2019 12:25:14 +0700
Message-ID: <87ftmwknr9.fsf@kb.kras.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

may I also ask to provide ppc_clone3 symbol also for 32-bit powerpc? Otherwise
Michael's patch breaks build for me:

  powerpc-e500v2-linux-gnuspe-ld: arch/powerpc/kernel/systbl.o: in function `sys_call_table':
  (.rodata+0x6cc): undefined reference to `ppc_clone3'
  make: *** [Makefile:1060: vmlinux] Error 1

The patch was tested using Christian's program on a real e500 machine.

--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -597,6 +597,14 @@ ppc_clone:
 	stw	r0,_TRAP(r1)		/* register set saved */
 	b	sys_clone

+	.globl	ppc_clone3
+ppc_clone3:
+	SAVE_NVGPRS(r1)
+	lwz	r0,_TRAP(r1)
+	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	stw	r0,_TRAP(r1)		/* register set saved */
+	b	sys_clone3
+
 	.globl	ppc_swapcontext
 ppc_swapcontext:
 	SAVE_NVGPRS(r1)

I don't think this trivial hunk deserves a separate patch submission.

Thanks,
Arseny
