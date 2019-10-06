Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF27CCE2B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 06:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfJFEX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 00:23:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbfJFEX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 00:23:26 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CFB20F71EDA02A3BA95B;
        Sun,  6 Oct 2019 12:23:23 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Sun, 6 Oct 2019
 12:23:20 +0800
Subject: Re: [RFC PATCH] scripts: Fix coccicheck failed
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Julia Lawall <julia.lawall@lip6.fr>
References: <20190928094245.45696-1-yuehaibing@huawei.com>
 <alpine.DEB.2.21.1909280542490.2168@hadrien>
 <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com>
 <alpine.DEB.2.21.1909291810300.3346@hadrien>
 <ac79cb42-1713-8801-37e4-edde540f101c@huawei.com>
 <alpine.DEB.2.21.1910011500470.13162@hadrien>
 <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com>
 <alpine.DEB.2.21.1910031422240.2406@hadrien>
 <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
CC:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        "Matthias Maennich" <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <490422f5-e33f-3aab-ba2d-747b9fecca91@huawei.com>
Date:   Sun, 6 Oct 2019 12:23:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/4 10:32, Masahiro Yamada wrote:
> On Thu, Oct 3, 2019 at 9:23 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>>
>>
>>
>> On Thu, 3 Oct 2019, Masahiro Yamada wrote:
>>
>>> On Tue, Oct 1, 2019 at 10:01 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>>>>> diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
>>>>> index c832bb6445a8..99e93a6c2e24 100644
>>>>> --- a/scripts/coccinelle/misc/add_namespace.cocci
>>>>> +++ b/scripts/coccinelle/misc/add_namespace.cocci
>>>>> @@ -6,6 +6,8 @@
>>>>>  /// add a missing namespace tag to a module source file.
>>>>>  ///
>>>>>
>>>>> +virtual report
>>>>> +
>>>>>  @has_ns_import@
>>>>>  declarer name MODULE_IMPORT_NS;
>>>>>  identifier virtual.ns;
>>>>>
>>>>>
>>>>>
>>>>> Adding virtual report make the coccicheck go ahead smoothly.
>>>>
>>>> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>>>>
>>>
>>>
>>> Was this patch posted somewhere?
>>
>> It was probably waiting for moderation in the cocci mailing list.  Do you
>> have it now (or in a few minutes)?
> 
> No. I do not see it yet.
> 
> I want to pick the patch from LKML Patchwork
> https://lore.kernel.org/patchwork/project/lkml/list/
> 
> You gave Acked-by to the one-liner fix "virtual report",
> and I am happy to apply it to my tree.
> 
> YueHaibing, could you submit it as a patch?

Sorry for late, will send it.

> 
> 

