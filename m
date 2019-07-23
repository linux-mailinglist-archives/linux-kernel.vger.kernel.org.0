Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFD0A715DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 12:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbfGWKQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 06:16:46 -0400
Received: from foss.arm.com ([217.140.110.172]:52220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731030AbfGWKQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:16:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B04A9337;
        Tue, 23 Jul 2019 03:16:44 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4057E3F71A;
        Tue, 23 Jul 2019 03:16:42 -0700 (PDT)
Date:   Tue, 23 Jul 2019 11:16:40 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 00/21] Generic page walk and ptdump
Message-ID: <20190723101639.GD8085@lakrids.cambridge.arm.com>
References: <20190722154210.42799-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722154210.42799-1-steven.price@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 04:41:49PM +0100, Steven Price wrote:
> This is a slight reworking and extension of my previous patch set
> (Convert x86 & arm64 to use generic page walk), but I've continued the
> version numbering as most of the changes are the same. In particular
> this series ends with a generic PTDUMP implemention for arm64 and x86.
> 
> Many architectures current have a debugfs file for dumping the kernel
> page tables. Currently each architecture has to implement custom
> functions for this because the details of walking the page tables used
> by the kernel are different between architectures.
> 
> This series extends the capabilities of walk_page_range() so that it can
> deal with the page tables of the kernel (which have no VMAs and can
> contain larger huge pages than exist for user space). A generic PTDUMP
> implementation is the implemented making use of the new functionality of
> walk_page_range() and finally arm64 and x86 are switch to using it,
> removing the custom table walkers.
> 
> To enable a generic page table walker to walk the unusual mappings of
> the kernel we need to implement a set of functions which let us know
> when the walker has reached the leaf entry. After a suggestion from Will
> Deacon I've chosen the name p?d_leaf() as this (hopefully) describes
> the purpose (and is a new name so has no historic baggage). Some
> architectures have p?d_large macros but this is easily confused with
> "large pages".
> 
> Mostly this is a clean up and there should be very little functional
> change. The exceptions are:
> 
> * x86 PTDUMP debugfs output no longer display pages which aren't
>   present (patch 14).
> 
> * arm64 has the ability to efficiently process KASAN pages (which
>   previously only x86 implemented). This means that the combination of
>   KASAN and DEBUG_WX is now useable.

Are there any visible changes to the arm64 output?

Could you dump a before/after example somewhere?

Thanks,
Mark.
