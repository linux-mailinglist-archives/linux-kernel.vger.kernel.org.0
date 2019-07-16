Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 003E46B247
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 01:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbfGPXRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 19:17:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52504 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388722AbfGPXRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 19:17:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so20243850wms.2;
        Tue, 16 Jul 2019 16:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZPNAIZrsK4+U6rgjCy68jx9tWt2okrGTctCQKZZqaVk=;
        b=idazxkNsN2pNk0/MVT0kHmohrDF1HMpqDRRKgYwmg88qj0VgDuD+rQ0RIKR4Vo07Rd
         Wzd3TtHvItbbVxDOsk1fOFjtmKKC/MuNEzCCYbiMxskr5bPokUbgUB9n4xgHqgurVNiZ
         UH/4jWQReV9IW/sykDZNGbGc4dW43yMrfAWNre/nNlSQVM/1n28iIxneFc2pZm9Ba4eA
         ryZ/TNWrfEORaEUFD0WbYpvw1bO9JkK09tbVu2VyQJsGuE1XmiR0CwTl81cOvQadmF7x
         LQphW2lRzEDwsac//4T2rPzqTD3QOdM2ecsko4WzqPtS1qCRrrLYAavi96thjA0+08Qf
         uKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZPNAIZrsK4+U6rgjCy68jx9tWt2okrGTctCQKZZqaVk=;
        b=Dum+jBVqS95QcYifxQG92o4QUIEYa5afhQ3tCU6bXNxBo+0etnr0PO/9E+MweRajWk
         urwN/9TZMsLqdY8yDrxP5BPH9LDS3yUysncxltOOlE9hIVAPZi2ow3YaLdMbAHn/MZ+Y
         TepQt6TJzfV57u9xoCwflcWs385XsWXGoFoDQ/0aqpVw2XMaYEnTfIusJOjNkkj6cg5v
         35EFF9jHLNk9K9inND0/r1+QX9Jjr3gU4XMgPa+TCkB4ZsFWdxQoY8tEummNIEFOFHNc
         yAcA5Z1OnMSP2HviRwDoG0DIQ9mvMx5mTFC4enFz7PFNZtZUZHpREwMP6t7urockPBRk
         432Q==
X-Gm-Message-State: APjAAAVxmBFCTQb0EVvYwVkvQvevmmjHcf2jj1c5lmnJwH2MLw+9VpNx
        ttAyP2/VGdFb5qAuxytl2Yc=
X-Google-Smtp-Source: APXvYqzqO878df2sfizq9sKrdPckpjOpWVZVnmqooBnAei9He3ZqFiDGMK61M5BKpXu4JTk4xk/o8A==
X-Received: by 2002:a1c:f918:: with SMTP id x24mr31191982wmh.132.1563319041405;
        Tue, 16 Jul 2019 16:17:21 -0700 (PDT)
Received: from [10.67.49.31] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i66sm37574242wmi.11.2019.07.16.16.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 16:17:20 -0700 (PDT)
Subject: Re: [PATCH] of/fdt: Make sure no-map does not remove already reserved
 regions
To:     Rob Herring <robh+dt@kernel.org>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ian Campbell <ian.campbell@citrix.com>,
        Grant Likely <grant.likely@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <20190703050827.173284-1-drinkcat@chromium.org>
 <815a8414-bfbe-c693-3208-1580779815ec@gmail.com>
 <CAL_JsqLETdazfnz5EU0Qw4TVVBhWmzk12Z5zYMo5Hm2ACPXh1w@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <421844aa-cf68-d4d2-f02d-aefaf8954fdf@gmail.com>
Date:   Tue, 16 Jul 2019 16:17:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLETdazfnz5EU0Qw4TVVBhWmzk12Z5zYMo5Hm2ACPXh1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/19 4:12 PM, Rob Herring wrote:
> On Tue, Jul 16, 2019 at 4:46 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> On 7/2/19 10:08 PM, Nicolas Boichat wrote:
>>> If the device tree is incorrectly configured, and attempts to
>>> define a "no-map" reserved memory that overlaps with the kernel
>>> data/code, the kernel would crash quickly after boot, with no
>>> obvious clue about the nature of the issue.
>>>
>>> For example, this would happen if we have the kernel mapped at
>>> these addresses (from /proc/iomem):
>>> 40000000-41ffffff : System RAM
>>>   40080000-40dfffff : Kernel code
>>>   40e00000-411fffff : reserved
>>>   41200000-413e0fff : Kernel data
>>>
>>> And we declare a no-map shared-dma-pool region at a fixed address
>>> within that range:
>>> mem_reserved: mem_region {
>>>       compatible = "shared-dma-pool";
>>>       reg = <0 0x40000000 0 0x01A00000>;
>>>       no-map;
>>> };
>>>
>>> To fix this, when removing memory regions at early boot (which is
>>> what "no-map" regions do), we need to make sure that the memory
>>> is not already reserved. If we do, __reserved_mem_reserve_reg
>>> will throw an error:
>>> [    0.000000] OF: fdt: Reserved memory: failed to reserve memory
>>>    for node 'mem_region': base 0x0000000040000000, size 26 MiB
>>> and the code that will try to use the region should also fail,
>>> later on.
>>>
>>> We do not do anything for non-"no-map" regions, as memblock
>>> explicitly allows reserved regions to overlap, and the commit
>>> that this fixes removed the check for that precise reason.
>>>
>>> Fixes: 094cb98179f19b7 ("of/fdt: memblock_reserve /memreserve/ regions in the case of partial overlap")
>>> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>>> ---
>>>  drivers/of/fdt.c | 10 +++++++++-
>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>> index cd17dc62a71980a..a1ded43fc332d0c 100644
>>> --- a/drivers/of/fdt.c
>>> +++ b/drivers/of/fdt.c
>>> @@ -1138,8 +1138,16 @@ int __init __weak early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size)
>>>  int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
>>>                                       phys_addr_t size, bool nomap)
>>>  {
>>> -     if (nomap)
>>> +     if (nomap) {
>>> +             /*
>>> +              * If the memory is already reserved (by another region), we
>>> +              * should not allow it to be removed altogether.
>>> +              */
>>> +             if (memblock_is_region_reserved(base, size))
>>> +                     return -EBUSY;
>>> +
>>>               return memblock_remove(base, size);
>>
>> While you are it, the nomap argument (introduced with
>> e8d9d1f5485b52ec3c4d7af839e6914438f6c285) predates the introduction of
>> memblock_is_nomap() (bf3d3cc580f9960883ebf9ea05868f336d9491c2), so
>> should just remove memblock_remove() and use memblock_mark_nomap()
>> instead here.
> 
> Perhaps like this patch[1]? Though the reasoning is different and the
> commit message here is more thorough, so can I get a combined patch.

From a quick reading it does look like memblock_isolate_range(), as
called by memblock_setclr_flag() should be able to detect this region
was already reserved, though I have not tried it.

> However, I don't under how handling a misconfigured DT and aligned
> with EFI are the same patch. What's considered valid for EFI is not
> for DT regions?

That I don't know how to answer.
-- 
Florian
