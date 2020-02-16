Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3968516061B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 20:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgBPT5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 14:57:08 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40967 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgBPT5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 14:57:07 -0500
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.12] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id CA948C0002;
        Sun, 16 Feb 2020 19:57:05 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] riscv: End kernel region search in setup_bootmem
 earlier
To:     Jan Kiszka <jan.kiszka@web.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <cover.1581767384.git.jan.kiszka@web.de>
 <b11898805c2f9f01b10867a05701aa0fafeaa886.1581767384.git.jan.kiszka@web.de>
 <8f0ddf1f-1ea9-8bde-76a0-ba60788c2a2d@ghiti.fr>
 <f64451c2-48b4-c998-c89f-29b11b371e55@web.de>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <45d6b6a1-c0a9-df9e-e4a6-05b1dde27877@ghiti.fr>
Date:   Sun, 16 Feb 2020 14:57:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <f64451c2-48b4-c998-c89f-29b11b371e55@web.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/16/20 11:06 AM, Jan Kiszka wrote:
> On 16.02.20 15:42, Alex Ghiti wrote:
>> Hi Jan,
>>
>> On 2/15/20 6:49 AM, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> No need to look further when that single region is found.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> =2D--
>>> � arch/riscv/mm/init.c | 2 ++
>>> � 1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>> index aec39a56d6cf..a774547e9021 100644
>>> =2D-- a/arch/riscv/mm/init.c
>>> +++ b/arch/riscv/mm/init.c
>>> @@ -160,6 +160,8 @@ void __init setup_bootmem(void)
>>> ������������� if (reg->base + mem_size < end)
>>> ����������������� memblock_remove(reg->base + mem_size,
>>> ������������������������� end - reg->base - mem_size);
>>> +
>>> +����������� break;
>>> ��������� }
>>> ����� }
>>> ����� BUG_ON(mem_size =3D=3D 0);
>>> =2D-
>>> 2.16.4
>>>
>>>
>>
>> I was looking at the test above that determines if the current memblock
>> contains the kernel:
>>
>> if (reg->base <= vmlinux_end && vmlinux_end <= end)
>>
>> Shouldn't it be:
>>
>> if (reg->base <= vmlinux_start && vmlinux_end <= end)
>>
>> ?
> 
> Yes, I think you are right. Would you like to send a patch that fixes this?

Thanks for confirming, I'll send a patch tomorrow and cc stable too.

Alex

> 
>>
>> Otherwise, we can indeed stop as soon as we found the region containing
>> the kernel, so feel free to add:
>>
>> Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
>>
> 
> Thanks,
> Jan
> 
