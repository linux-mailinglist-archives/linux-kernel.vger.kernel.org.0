Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34DE4154FB8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 01:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgBGA1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 19:27:39 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3017 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBGA1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 19:27:39 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3caee10000>; Thu, 06 Feb 2020 16:27:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Feb 2020 16:27:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Feb 2020 16:27:38 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Feb
 2020 00:27:35 +0000
Subject: Re: [PATCH] mm: fix a data race in put_page()
To:     Qian Cai <cai@lca.pw>
CC:     Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>,
        <akpm@linux-foundation.org>, <ira.weiny@intel.com>,
        <dan.j.williams@intel.com>, <elver@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20200206145501.GD26114@quack2.suse.cz>
 <D022CBB0-C8EC-4F5A-A0B0-893AA7A014AA@lca.pw>
 <079c4429-8a11-154d-cf5c-473d2698d18d@nvidia.com>
 <235ACF21-35BE-4EDA-BA64-9553DA53BF12@lca.pw>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <90ab0b09-0f70-fe6d-259e-f529f4ef9174@nvidia.com>
Date:   Thu, 6 Feb 2020 16:27:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <235ACF21-35BE-4EDA-BA64-9553DA53BF12@lca.pw>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581035233; bh=pB+e0J8CDnr1RA7mN63T5ahx5bEiD5ff9DW/6lG1XnU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=S2cuqs7jxI+Yz2WpcZsM50KxZjg3hS9AyvT0oVMZ2cnpQANtBqBm0zXp50hPdyFne
         ACRVBJR2K16wvgfAJhlHAs23BYy6bcJUgosLeSf8YsH1uJgoR1MCnd40x7xQt5GvXi
         7L7OE5RrS29BrdAEloemxLdPjkE5zuLYwAARPWFLlLhcLHq+tIa8ffcOdVCVgGNRqx
         v166Z9J+14Y9nrqOm2uI+V9CUEXlqzDjfONv2qklVvXQcFQe8II8Dls41h8AaxNE8m
         hUMYvggOel0fyy3lBlJWoarQ0w6UrRT/cvR3jo5yZmSILDj66SAxvwSJMJpa5A+7eZ
         i4Ybo85P6ShXQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/20 4:18 PM, Qian Cai wrote:
>> On Feb 6, 2020, at 6:34 PM, John Hubbard <jhubbard@nvidia.com> wrote:
>> On 2/6/20 7:23 AM, Qian Cai wrote:
>>>> On Feb 6, 2020, at 9:55 AM, Jan Kara <jack@suse.cz> wrote:
>>>> I don't think the problem is real. The question is how to make KCSAN happy
>>>> in a way that doesn't silence other possibly useful things it can find and
>>>> also which makes it most obvious to the reader what's going on... IMHO
>>>> using READ_ONCE() fulfills these targets nicely - it is free
>>>> performance-wise in this case, it silences the checker without impacting
>>>> other races on page->flags, its kind of obvious we don't want the load torn
>>>> in this case so it makes sense to the reader (although a comment may be
>>>> nice).
>>>
>>> Actually, use the data_race() macro there fulfilling the same purpose too, i.e, silence the splat here but still keep searching for other races.
>>>
>>
>> Yes, but both READ_ONCE() and data_race() would be saying untrue things about this code,
>> and that somewhat offends my sense of perfection... :)
>>
>> * READ_ONCE(): this field need not be restricted to being read only once, so the
>>  name is immediately wrong. We're using side effects of READ_ONCE().
>>
>> * data_race(): there is no race on the N bits worth of page zone number data. There
>>  is only a perceived race, due to tools that look at word-level granularity.
>>
>> I'd propose one or both of the following:
>>
>> a) Hope that Marco (I've fixed the typo in his name. --jh) has an idea to enhance KCSAN so as to support this model of
>>   access, and/or
> 
> A similar thing was brought up before, i.e., anything compared to zero is immune to load-tearing
> issues, but it is rather difficult to implement it in the compiler, so it was settled to use data_race(),
> 
> https://lore.kernel.org/lkml/CANpmjNN8J1oWtLPHTgCwbbtTuU_Js-8HD=cozW5cYkm8h-GTBg@mail.gmail.com/#r
> 


Thanks for that link to the previous discussion, good context.


>>
>> b) Add a new, better-named macro to indicate what's going on. Initial bikeshed-able
>>   candidates:
>>
>> 	READ_RO_BITS()
>> 	READ_IMMUTABLE_BITS()
>> 	...etc...
>>
> 
> Actually, Linus might hate those kinds of complication rather than a simple data_race() macro,
> 
> https://lore.kernel.org/linux-fsdevel/CAHk-=wg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7HL5AB2g@mail.gmail.com/
> 

Another good link. However, my macros above haven't been proposed yet, and I'm perfectly 
comfortable proposing something that Linus *might* (or might not!) hate. No point in 
guessing about it, IMHO.

If you want, I'll be happy to put on my flame suit and post a patchset proposing 
READ_IMMUTABLE_BITS() (or a better-named thing, if someone has another name idea).  :)



thanks,
-- 
John Hubbard
NVIDIA
