Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1997D551
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 08:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfHAGNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 02:13:15 -0400
Received: from foss.arm.com ([217.140.110.172]:58710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfHAGNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:13:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10555337;
        Wed, 31 Jul 2019 23:13:14 -0700 (PDT)
Received: from [10.163.1.81] (unknown [10.163.1.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7AE53F694;
        Wed, 31 Jul 2019 23:15:06 -0700 (PDT)
Subject: Re: [PATCH v9 10/21] mm: Add generic p?d_leaf() macros
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
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
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190722154210.42799-1-steven.price@arm.com>
 <20190722154210.42799-11-steven.price@arm.com>
 <20190723094113.GA8085@lakrids.cambridge.arm.com>
 <ce4e21f2-020f-6677-d79c-5432e3061d6e@arm.com>
 <20190729125013.GA33794@lakrids.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d427ccad-e64f-82f4-588b-816376e3cadb@arm.com>
Date:   Thu, 1 Aug 2019 11:43:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190729125013.GA33794@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/29/2019 06:20 PM, Mark Rutland wrote:
> On Sun, Jul 28, 2019 at 05:14:31PM +0530, Anshuman Khandual wrote:
>> On 07/23/2019 03:11 PM, Mark Rutland wrote:
>>> It might also be worth pointing out the reasons for this naming, e.g.
>>> p?d_large() aren't currently generic, and this name minimizes potential
>>> confusion between p?d_{large,huge}().
>>
>> Agreed. But these fallback also need to first check non-availability of large
>> pages. 
> 
> We're deliberately not making the p?d_large() helpers generic, so this
> shouldn't fall back on those.

I meant non-availability of large page support in the MMU HW not just the
presence of p?d_large() helpers.
