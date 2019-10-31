Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D40EB1FE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 15:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfJaOAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 10:00:44 -0400
Received: from foss.arm.com ([217.140.110.172]:49044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbfJaOAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:00:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E0B146A;
        Thu, 31 Oct 2019 07:00:43 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3FF43F71E;
        Thu, 31 Oct 2019 07:00:40 -0700 (PDT)
Date:   Thu, 31 Oct 2019 14:00:38 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v14 21/22] arm64: mm: Convert mm/dump.c to use
 walk_page_range()
Message-ID: <20191031140038.GC39590@arrakis.emea.arm.com>
References: <20191028135910.33253-1-steven.price@arm.com>
 <20191028135910.33253-22-steven.price@arm.com>
 <20191030164535.GC13309@arrakis.emea.arm.com>
 <40956d62-241c-6685-72f1-bfc01183141e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40956d62-241c-6685-72f1-bfc01183141e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 01:32:34PM +0000, Steven Price wrote:
> On 30/10/2019 16:45, Catalin Marinas wrote:
> > On Mon, Oct 28, 2019 at 01:59:09PM +0000, Steven Price wrote:
> >> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> >> index 93f9f77582ae..9d9b740a86d2 100644
> >> --- a/arch/arm64/mm/dump.c
> >> +++ b/arch/arm64/mm/dump.c
> >> @@ -15,6 +15,7 @@
> >>  #include <linux/io.h>
> >>  #include <linux/init.h>
> >>  #include <linux/mm.h>
> >> +#include <linux/ptdump.h>
> >>  #include <linux/sched.h>
> >>  #include <linux/seq_file.h>
> >>  
> >> @@ -75,10 +76,11 @@ static struct addr_marker address_markers[] = {
> >>   * dumps out a description of the range.
> >>   */
> >>  struct pg_state {
> >> +	struct ptdump_state ptdump;
> >>  	struct seq_file *seq;
> >>  	const struct addr_marker *marker;
> >>  	unsigned long start_address;
> >> -	unsigned level;
> >> +	int level;
> >>  	u64 current_prot;
> >>  	bool check_wx;
> >>  	unsigned long wx_pages;
> >> @@ -178,6 +180,10 @@ static struct pg_level pg_level[] = {
> >>  		.name	= "PGD",
> >>  		.bits	= pte_bits,
> >>  		.num	= ARRAY_SIZE(pte_bits),
> >> +	}, { /* p4d */
> >> +		.name	= "P4D",
> >> +		.bits	= pte_bits,
> >> +		.num	= ARRAY_SIZE(pte_bits),
> >>  	}, { /* pud */
> >>  		.name	= (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
> >>  		.bits	= pte_bits,
> > 
> > We could use "PGD" for the p4d entry since we don't have five levels.
> > This patches the "PGD" name used for pud/pmd when these levels are
> > folded.
> 
> Good point, although I'd actually be more tempted to do the opposite -
> remove the special casing for PUD/PMD as the generic code should now
> never provide those levels if they are folded. What do you think?

I agree, it makes sense.

-- 
Catalin
