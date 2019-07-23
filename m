Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B6A711FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 08:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387997AbfGWGiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 02:38:54 -0400
Received: from foss.arm.com ([217.140.110.172]:49360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732836AbfGWGiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:38:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CDAE344;
        Mon, 22 Jul 2019 23:38:53 -0700 (PDT)
Received: from [10.162.40.183] (p8cg001049571a15.blr.arm.com [10.162.40.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 502D83F71F;
        Mon, 22 Jul 2019 23:40:51 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v9 00/21] Generic page walk and ptdump
To:     Steven Price <steven.price@arm.com>, linux-mm@kvack.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190722154210.42799-1-steven.price@arm.com>
Message-ID: <835a0f2e-328d-7f7f-e52a-b754137789f9@arm.com>
Date:   Tue, 23 Jul 2019 12:09:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190722154210.42799-1-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steven,

On 07/22/2019 09:11 PM, Steven Price wrote:
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

Could other architectures just enable this new generic PTDUMP feature if
required without much problem ?

> 
> To enable a generic page table walker to walk the unusual mappings of
> the kernel we need to implement a set of functions which let us know
> when the walker has reached the leaf entry. After a suggestion from Will
> Deacon I've chosen the name p?d_leaf() as this (hopefully) describes
> the purpose (and is a new name so has no historic baggage). Some
> architectures have p?d_large macros but this is easily confused with
> "large pages".

I have not been following the previous version of the series closely, hence
might be missing something here. But p?d_large() which identifies large
mappings on a given level can only signify a leaf entry. Large pages on the
table exist only as leaf entries. So what is the problem for it being used
directly instead. Is there any possibility in the kernel mapping when these
large pages are not leaf entries ?

> 
> Mostly this is a clean up and there should be very little functional
> change. The exceptions are:
> 
> * x86 PTDUMP debugfs output no longer display pages which aren't
>   present (patch 14).

Hmm, kernel mappings pages which are not present! which ones are those ?
Just curious.

> 
> * arm64 has the ability to efficiently process KASAN pages (which
>   previously only x86 implemented). This means that the combination of
>   KASAN and DEBUG_WX is now useable.
> 
> Also available as a git tree:
> git://linux-arm.org/linux-sp.git walk_page_range/v9
> 
> Changes since v8:
> https://lore.kernel.org/lkml/20190403141627.11664-1-steven.price@arm.com/
>  * Rename from p?d_large() to p?d_leaf()

As mentioned before wondering if this is actually required or it is even a
good idea to introduce something like this which expands page table helper
semantics scope further in generic MM.

>  * Dropped patches migrating arm64/x86 custom walkers to
>    walk_page_range() in favour of adding a generic PTDUMP implementation
>    and migrating arm64/x86 to that instead.
>  * Rebased to v5.3-rc1

Creating a generic PTDUMP implementation is definitely a better idea.
