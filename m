Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E71A34EA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 12:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfH3KYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 06:24:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:59036 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727417AbfH3KYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 06:24:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2AAFAFF1;
        Fri, 30 Aug 2019 10:24:38 +0000 (UTC)
Date:   Fri, 30 Aug 2019 12:24:36 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Song Liu <songliubraving@fb.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [patch V3 1/2] x86/mm/pti: Handle unaligned address gracefully
 in pti_clone_pagetable()
Message-ID: <20190830102436.GG17192@suse.de>
References: <20190828142445.454151604@linutronix.de>
 <20190828143123.971884723@linutronix.de>
 <alpine.DEB.2.21.1908282252170.1938@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1908282352470.1938@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908282352470.1938@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:54:55PM +0200, Thomas Gleixner wrote:
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -330,13 +330,15 @@ pti_clone_pgtable(unsigned long start, u
>  
>  		pud = pud_offset(p4d, addr);
>  		if (pud_none(*pud)) {
> -			addr += PUD_SIZE;
> +			WARN_ON_ONCE(addr & ~PUD_MASK);
> +			addr = round_up(addr + 1, PUD_SIZE);
>  			continue;
>  		}
>  
>  		pmd = pmd_offset(pud, addr);
>  		if (pmd_none(*pmd)) {
> -			addr += PMD_SIZE;
> +			WARN_ON_ONCE(addr & ~PMD_MASK);
> +			addr = round_up(addr + 1, PMD_SIZE);
>  			continue;
>  		}
>

Reviewed-by: Joerg Roedel <jroedel@suse.de>
