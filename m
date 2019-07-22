Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0932470ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 22:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfGVUwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 16:52:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37932 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfGVUwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZOg1aeuxZJaFRJcDsRuUUKvxXn015efnK/SXIIPlQmI=; b=TPiJKdZWiDSAbJ1qm7pO/uUbz
        Gk+c2eqwI8tim/gYGiS0A9ux1cdl3GrmKTq8wiQ6kx39xW6HUZYkq91kJlX+rWNZuGPiD1qVdiQdZ
        XYbXzvW3o8HnOJU5qnYzEsiY4B17OxvYzRkuKHOkUUCSfFBr9mAO/3LtL4hBuPbW7dVmpKxNXHpxS
        V971ARy2t00/8WYUJZdtrovBoPgCbtq4kPln9u/dhb2KMGfYowuPG4WhVzZP/BzzkGrHQNXyekO8E
        grBDZ/28XABr1nQ6ZXBLzA/axg2wnzFQPX3CszXtgAwZyKSHdTVQel9/VQg0wIArUbLBI0U521ck2
        Tf78XiH4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpfIR-0006yU-OJ; Mon, 22 Jul 2019 20:52:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 47888980D1F; Mon, 22 Jul 2019 22:52:27 +0200 (CEST)
Date:   Mon, 22 Jul 2019 22:52:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC 3/7] x86/percpu: Use C for percpu accesses when possible
Message-ID: <20190722205227.GK6698@worktop.programming.kicks-ass.net>
References: <20190718174110.4635-1-namit@vmware.com>
 <20190718174110.4635-4-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718174110.4635-4-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 10:41:06AM -0700, Nadav Amit wrote:

> diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
> index 99a7fa9ab0a3..60f97b288004 100644
> --- a/arch/x86/include/asm/preempt.h
> +++ b/arch/x86/include/asm/preempt.h
> @@ -91,7 +91,8 @@ static __always_inline void __preempt_count_sub(int val)
>   */
>  static __always_inline bool __preempt_count_dec_and_test(void)
>  {
> -	return GEN_UNARY_RMWcc("decl", __preempt_count, e, __percpu_arg([var]));
> +	return GEN_UNARY_RMWcc("decl", __my_cpu_var(__preempt_count), e,
> +			       __percpu_arg([var]));
>  }

Should this be in the previous patch?
