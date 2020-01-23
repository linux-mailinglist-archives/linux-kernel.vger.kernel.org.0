Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037B9146EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 17:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgAWQ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 11:56:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbgAWQ4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:56:20 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2BB021569;
        Thu, 23 Jan 2020 16:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579798580;
        bh=MSOvB9Ez+GU+Pkc0XJ8/972rCHvs2v7owDXEQdOJ5OQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q+TtOV4tbUrPSn3Gk4mwwbwCxHA8ZjpNbBNWtTs3aXqLLcoSrO/LjJAzTiG4nQxCd
         mL63iyR5GiKt9QQuNj+uC/+aRwbbnxz/27bWPGf8znZzWIktJXWAhcu/hV+7oMKR4+
         se+rQLlgCsD3delxx1vWAqt6fqgUIK1zUygX3/kQ=
Date:   Thu, 23 Jan 2020 16:56:15 +0000
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     peterz@infradead.org, longman@redhat.com, mingo@redhat.com,
        catalin.marinas@arm.com, clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] arm64/spinlock: fix a -Wunused-function warning
Message-ID: <20200123165614.GA20126@willie-the-truck>
References: <20200123162945.7705-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123162945.7705-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 11:29:45AM -0500, Qian Cai wrote:
> The commit f5bfdc8e3947 ("locking/osq: Use optimized spinning loop for
> arm64") introduced a warning from Clang because vcpu_is_preempted() is
> compiled away,
> 
> kernel/locking/osq_lock.c:25:19: warning: unused function 'node_cpu'
> [-Wunused-function]
> static inline int node_cpu(struct optimistic_spin_node *node)
>                   ^
> 1 warning generated.
> 
> Since vcpu_is_preempted() had already been defined in
> include/linux/sched.h as false, just comment out the redundant macro, so
> it can still be served for the documentation purpose.
> 
> Fixes: f5bfdc8e3947 ("locking/osq: Use optimized spinning loop for arm64")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/arm64/include/asm/spinlock.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
> index 102404dc1e13..b05f82e8ba19 100644
> --- a/arch/arm64/include/asm/spinlock.h
> +++ b/arch/arm64/include/asm/spinlock.h
> @@ -17,7 +17,8 @@
>   *
>   * See:
>   * https://lore.kernel.org/lkml/20200110100612.GC2827@hirez.programming.kicks-ass.net
> + *
> + * #define vcpu_is_preempted(cpu)	false
>   */
> -#define vcpu_is_preempted(cpu)	false

Damn, the whole point of this was to warn in the case that
vcpu_is_preempted() does get defined for arm64. Can we force it to evaluate
the macro argument instead (e.g. ({ (cpu), false; }) or something)?

Will
