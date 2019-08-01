Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94EA37DB55
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 14:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbfHAMWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 08:22:40 -0400
Received: from foss.arm.com ([217.140.110.172]:35084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731239AbfHAMWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:22:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 879161570;
        Thu,  1 Aug 2019 05:22:34 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF0683F575;
        Thu,  1 Aug 2019 05:22:31 -0700 (PDT)
Subject: Re: [PATCH v9 10/21] mm: Add generic p?d_leaf() macros
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20190722154210.42799-1-steven.price@arm.com>
 <20190722154210.42799-11-steven.price@arm.com>
 <20190723094113.GA8085@lakrids.cambridge.arm.com>
 <ce4e21f2-020f-6677-d79c-5432e3061d6e@arm.com>
 <674bd809-f853-adb0-b1ab-aa4404093083@arm.com>
 <0979d4b4-7a97-2dc3-67cf-3aa6569bfdcd@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <ae073f1f-7c39-7e6d-0e6b-54978f0d3fdf@arm.com>
Date:   Thu, 1 Aug 2019 13:22:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0979d4b4-7a97-2dc3-67cf-3aa6569bfdcd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2019 07:09, Anshuman Khandual wrote:
> 
> 
> On 07/29/2019 05:08 PM, Steven Price wrote:
>> On 28/07/2019 12:44, Anshuman Khandual wrote:
>>>
>>>
>>> On 07/23/2019 03:11 PM, Mark Rutland wrote:
>>>> On Mon, Jul 22, 2019 at 04:41:59PM +0100, Steven Price wrote:
>>>>> Exposing the pud/pgd levels of the page tables to walk_page_range() means
>>>>> we may come across the exotic large mappings that come with large areas
>>>>> of contiguous memory (such as the kernel's linear map).
>>>>>
>>>>> For architectures that don't provide all p?d_leaf() macros, provide
>>>>> generic do nothing default that are suitable where there cannot be leaf
>>>>> pages that that level.
>>>>>
>>>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>>>
>>>> Not a big deal, but it would probably make sense for this to be patch 1
>>>> in the series, given it defines the semantic of p?d_leaf(), and they're
>>>> not used until we provide all the architectural implemetnations anyway.
>>>
>>> Agreed.
>>>
>>>>
>>>> It might also be worth pointing out the reasons for this naming, e.g.
>>>> p?d_large() aren't currently generic, and this name minimizes potential
>>>> confusion between p?d_{large,huge}().
>>>
>>> Agreed. But these fallback also need to first check non-availability of large
>>> pages. I am not sure whether CONFIG_HUGETLB_PAGE config being clear indicates
>>> that conclusively or not. Being a page table leaf entry has a broader meaning
>>> than a large page but that is really not the case today. All leaf entries here
>>> are large page entries from MMU perspective. This dependency can definitely be
>>> removed when there are other types of leaf entries but for now IMHO it feels
>>> bit problematic not to directly associate leaf entries with large pages in
>>> config restriction while doing exactly the same.
>>
>> The intention here is that the page walkers are able to walk any type of
>> page table entry which the kernel may use. CONFIG_HUGETLB_PAGE only
>> controls whether "huge TLB pages" are used by user space processes. It's
>> quite possible that option to not be selected but the linear mapping to
>> have been mapped using "large pages" (i.e. leaf entries further up the
>> tree than normal).
> 
> I understand that kernel page table might use large pages where as user space
> never enabled HugeTLB. The point to make here was CONFIG_HUGETLB approximately
> indicates the presence of large pages though the absence of same does not
> conclusively indicate that large pages are really absent on the MMU. Perhaps it
> will requires something new like MMU_[LARGE|HUGE]_PAGES.

CONFIG_HUGETLB doesn't necessarily mean leaf entries can appear anywhere
other than PTE. Some architectures always have a full tree of page
tables, but can program their TLBs with larger entries - I think all the
architectures I've come across have software page table walking, but in
theory the arm64 contiguous hint bit could be considered similar.

Steve
