Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF1FCE9B59
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 13:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfJ3MOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 08:14:18 -0400
Received: from ozlabs.org ([203.11.71.1]:43971 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfJ3MOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:14:17 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4736nf5bR0z9sPq; Wed, 30 Oct 2019 23:14:14 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3b9176e9a874a848afa7eb2f6943639eb18b7a17
In-Reply-To: <1563215552-8166-1-git-send-email-cai@lca.pw>
To:     Qian Cai <cai@lca.pw>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, paulus@samba.org,
        tyreld@linux.vnet.ibm.com, joe@perches.com, Qian Cai <cai@lca.pw>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4] powerpc/setup_64: fix -Wempty-body warnings
Message-Id: <4736nf5bR0z9sPq@ozlabs.org>
Date:   Wed, 30 Oct 2019 23:14:14 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-15 at 18:32:32 UTC, Qian Cai wrote:
> At the beginning of setup_64.c, it has,
> 
>   #ifdef DEBUG
>   #define DBG(fmt...) udbg_printf(fmt)
>   #else
>   #define DBG(fmt...)
>   #endif
> 
> where DBG() could be compiled away, and generate warnings,
> 
> arch/powerpc/kernel/setup_64.c: In function 'initialize_cache_info':
> arch/powerpc/kernel/setup_64.c:579:49: warning: suggest braces around
> empty body in an 'if' statement [-Wempty-body]
>     DBG("Argh, can't find dcache properties !\n");
>                                                  ^
> arch/powerpc/kernel/setup_64.c:582:49: warning: suggest braces around
> empty body in an 'if' statement [-Wempty-body]
>     DBG("Argh, can't find icache properties !\n");
> 
> Fix it by using the suggestions from Michael:
> 
> "Neither of those sites should use DBG(), that's not really early boot
> code, they should just use pr_warn().
> 
> And the other uses of DBG() in initialize_cache_info() should just be
> removed.
> 
> In smp_release_cpus() the entry/exit DBG's should just be removed, and
> the spinning_secondaries line should just be pr_debug().
> 
> That would just leave the two calls in early_setup(). If we taught
> udbg_printf() to return early when udbg_putc is NULL, then we could just
> call udbg_printf() unconditionally and get rid of the DBG macro
> entirely."
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Qian Cai <cai@lca.pw>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3b9176e9a874a848afa7eb2f6943639eb18b7a17

cheers
