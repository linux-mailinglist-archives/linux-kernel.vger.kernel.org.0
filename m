Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA5A318CB3A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 11:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgCTKJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 06:09:00 -0400
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:57604 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726527AbgCTKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:09:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 69C4E18224D60;
        Fri, 20 Mar 2020 10:08:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2904:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:4250:4321:5007:6119:7903:9036:10004:10400:10848:11026:11232:11473:11658:11914:12297:12679:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21324:21627:21990:30045:30054:30055:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: tent22_886f8e4967e2d
X-Filterd-Recvd-Size: 2172
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Mar 2020 10:08:57 +0000 (UTC)
Message-ID: <b771dfc7409a99b35575c14cd4dd55d24f81ca98.camel@perches.com>
Subject: Re: [PATCH v2 2/2] x86/delay: Introduce TPAUSE delay
From:   Joe Perches <joe@perches.com>
To:     Kyung Min Park <kyung.min.park@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        gregkh@linuxfoundation.org, ak@linux.intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com
Date:   Fri, 20 Mar 2020 03:07:10 -0700
In-Reply-To: <1584677604-32707-3-git-send-email-kyung.min.park@intel.com>
References: <1584677604-32707-1-git-send-email-kyung.min.park@intel.com>
         <1584677604-32707-3-git-send-email-kyung.min.park@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-19 at 21:13 -0700, Kyung Min Park wrote:
> TPAUSE instructs the processor to enter an implementation-dependent
> optimized state. The instruction execution wakes up when the time-stamp
> counter reaches or exceeds the implicit EDX:EAX 64-bit input value.
> The instruction execution also wakes up due to the expiration of
> the operating system time-limit or by an external interrupt
> or exceptions such as a debug exception or a machine check exception.
[]
> diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
[]
> @@ -97,6 +97,27 @@ static void delay_tsc(u64 cycles)
>  }
>  
>  /*
> + * On Intel the TPAUSE instruction waits until any of:
> + * 1) the TSC counter exceeds the value provided in EAX:EDX
> + * 2) global timeout in IA32_UMWAIT_CONTROL is exceeded
> + * 3) an external interrupt occurs
> + */
> +static void delay_halt_tpause(u64 start, u64 cycles)
> +{
> +	u64 until = start + cycles;
> +	unsigned int eax, edx;
> +
> +	eax = (unsigned int)(until & 0xffffffff);
> +	edx = (unsigned int)(until >> 32);

trivia:

perhaps lower_32_bits and upper_32_bits


