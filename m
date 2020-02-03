Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5F4150503
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 12:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgBCLRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 06:17:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbgBCLRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 06:17:07 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3952B20721;
        Mon,  3 Feb 2020 11:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580728626;
        bh=hOfgDkQXNA9GPbFW4AZJE9W6aP9xIhI/B2/YSYBkl0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iCEeBT7tK0216U7jKUQhiCKEkZ/IUTyBiEsCbQSQZ1tgW9bWAZ+kpEtC0mi1Sp/lv
         Idx3bLRD3yAeaW++w2wMMw6GXg5mcR0OijMaCLhglkkZHMJQw1h+xsJY0vNH3aLdNN
         Uw73hzJATKDocN5XJP0ZqaL27BCUg7rNnCUFEelk=
Date:   Mon, 3 Feb 2020 11:17:01 +0000
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     peterz@infradead.org, longman@redhat.com, mingo@redhat.com,
        catalin.marinas@arm.com, clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] arm64/spinlock: fix a -Wunused-function warning
Message-ID: <20200203111701.GA4124@willie-the-truck>
References: <20200123202051.8106-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123202051.8106-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 03:20:51PM -0500, Qian Cai wrote:
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
> Fix it by converting vcpu_is_preempted() to a static inline function.
> 
> Fixes: f5bfdc8e3947 ("locking/osq: Use optimized spinning loop for arm64")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: convert vcpu_is_preempted() to a static inline function.
> 
>  arch/arm64/include/asm/spinlock.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
> index 102404dc1e13..9083d6992603 100644
> --- a/arch/arm64/include/asm/spinlock.h
> +++ b/arch/arm64/include/asm/spinlock.h
> @@ -18,6 +18,10 @@
>   * See:
>   * https://lore.kernel.org/lkml/20200110100612.GC2827@hirez.programming.kicks-ass.net
>   */
> -#define vcpu_is_preempted(cpu)	false
> +#define vcpu_is_preempted vcpu_is_preempted
> +static inline bool vcpu_is_preempted(int cpu)
> +{
> +	return false;
> +}

Cheers, I'll queue this at -rc1.

Will
