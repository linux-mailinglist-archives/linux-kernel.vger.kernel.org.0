Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3908647475
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2019 14:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfFPMXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 08:23:54 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52889 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfFPMXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 08:23:54 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45RYRW6mT5z9sNC; Sun, 16 Jun 2019 22:23:51 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 82f6e266f8123d7938713c0e10c03aa655b3e68a
X-Patchwork-Hint: ignore
In-Reply-To: <97664671a229a4240bfb22f69ec4743e837c2b83.1558600628.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: fix build failure on book3e with KVM
Message-Id: <45RYRW6mT5z9sNC@ozlabs.org>
Date:   Sun, 16 Jun 2019 22:23:51 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-23 at 08:39:27 UTC, Christophe Leroy wrote:
> Build failure was introduced by the commit identified below,
> due to missed macro expension leading to wrong called function's name.
> 
> arch/powerpc/kernel/head_fsl_booke.o: In function `SystemCall':
> arch/powerpc/kernel/head_fsl_booke.S:416: undefined reference to `kvmppc_handler_BOOKE_INTERRUPT_SYSCALL_SPRN_SRR1'
> Makefile:1052: recipe for target 'vmlinux' failed
> 
> The called function should be kvmppc_handler_8_0x01B(). This patch fixes it.
> 
> Reported-by: Paul Mackerras <paulus@ozlabs.org>
> Fixes: 1a4b739bbb4f ("powerpc/32: implement fast entry for syscalls on BOOKE")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/82f6e266f8123d7938713c0e10c03aa655b3e68a

cheers
