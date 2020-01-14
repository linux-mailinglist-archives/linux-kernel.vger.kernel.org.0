Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8875C13A157
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 08:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgANHK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 02:10:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43034 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728746AbgANHK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:10:28 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F2952AAD54E551A6FA5C;
        Tue, 14 Jan 2020 15:10:25 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 Jan 2020
 15:10:19 +0800
Subject: Re: [PATCH] KVM: arm/arm64: vgic-its: Check hopefully the last
 DISCARD command error
To:     Auger Eric <eric.auger@redhat.com>, <maz@kernel.org>
CC:     <andre.przywara@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>
References: <20191225133014.1825-1-yuzenghui@huawei.com>
 <f9997198-c990-d638-24d0-41d6280a9d8a@redhat.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <41c88abb-433a-f87c-c858-7f2eb4c40926@huawei.com>
Date:   Tue, 14 Jan 2020 15:10:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <f9997198-c990-d638-24d0-41d6280a9d8a@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 2020/1/10 16:37, Auger Eric wrote:
> Hi Zenghui,
> 
> On 12/25/19 2:30 PM, Zenghui Yu wrote:
>> DISCARD command error occurs if any of the following apply:
>>
>>   - [ ... (those which we have already handled) ]
> nit: I would remove the above and simply say the discard is supposed to
> fail if the collection is not mapped to any target redistributor. If an
> ITE exists then the ite->collection is non NULL.

I think this is not always true. Let's talk about the following scenario
(a bit insane, though):

1. First map a LPI to an unmapped Collection, then ite->collection is
    non NULL and its target_addr is COLLECTION_NOT_MAPPED.

2. Then issue MAPC and unMAPC(V=0) commands on this Collection, the
    ite->collection will be NULL, see vgic_its_free_collection().

Discard the LPI mapping after "1" or "2", we will both encounter the
unmapped collection command error.

> What needs to be checked is its_is_collection_mapped().
> 
> By the way update_affinity_collection() also tests ite->collection. I
> think this is useless or do I miss something?

Yeah, I agree. We managed to invoke update_affinity_collection(,, coll),
ensure that the 'coll' can _not_ be NULL.
So '!ite->collection' is already a subcase of 'coll != ite->collection'.
We can safely get rid of it.

> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 

Thanks for that. I'll change the commit message with your suggestion and
add your R-b in v2.


Thanks,
Zenghui

