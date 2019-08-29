Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEA49A0F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 03:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfH2B5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 21:57:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5687 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbfH2B5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 21:57:32 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4F550E427B9ACF4E9F9F;
        Thu, 29 Aug 2019 09:57:31 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 29 Aug 2019
 09:57:22 +0800
Subject: Re: [PATCH v6 00/12] implement KASLR for powerpc/fsl_booke/32
To:     Scott Wood <oss@buserror.net>, <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <diana.craciun@nxp.com>,
        <christophe.leroy@c-s.fr>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <wangkefeng.wang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>, <zhaohongjiang@huawei.com>,
        <thunder.leizhen@huawei.com>, <fanchengyang@huawei.com>,
        <yebin10@huawei.com>
References: <20190809100800.5426-1-yanaijie@huawei.com>
 <a39b81562bcdeda7ffe0c2c29a60ff08c77047a6.camel@buserror.net>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <923983fc-364d-440d-5c3a-3d3d6de60d14@huawei.com>
Date:   Thu, 29 Aug 2019 09:57:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <a39b81562bcdeda7ffe0c2c29a60ff08c77047a6.camel@buserror.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/28 12:05, Scott Wood wrote:
> On Fri, 2019-08-09 at 18:07 +0800, Jason Yan wrote:
>> This series implements KASLR for powerpc/fsl_booke/32, as a security
>> feature that deters exploit attempts relying on knowledge of the location
>> of kernel internals.
>>
>> Since CONFIG_RELOCATABLE has already supported, what we need to do is
>> map or copy kernel to a proper place and relocate.
> 
> Have you tested this with a kernel that was loaded at a non-zero address?  I
> tried loading a kernel at 0x04000000 (by changing the address in the uImage,
> and setting bootm_low to 04000000 in U-Boot), and it works without
> CONFIG_RANDOMIZE and fails with.
> 

Not yet. I will test this kind of cases in the next days. Thank you so
much. If there are any other corner cases that have to be tested, please
let me know.

>>   Freescale Book-E
>> parts expect lowmem to be mapped by fixed TLB entries(TLB1). The TLB1
>> entries are not suitable to map the kernel directly in a randomized
>> region, so we chose to copy the kernel to a proper place and restart to
>> relocate.
>>
>> Entropy is derived from the banner and timer base, which will change every
>> build and boot. This not so much safe so additionally the bootloader may
>> pass entropy via the /chosen/kaslr-seed node in device tree.
> 
> How complicated would it be to directly access the HW RNG (if present) that
> early in the boot?  It'd be nice if a U-Boot update weren't required (and
> particularly concerning that KASLR would appear to work without a U-Boot
> update, but without decent entropy).
> 
> -Scott
> 
> 
> 
> .
> 

