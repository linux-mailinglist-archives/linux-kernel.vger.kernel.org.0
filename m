Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11B7711E2C9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 12:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLML2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 06:28:50 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:33168 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbfLML2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 06:28:49 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ifj7k-0004JA-4j; Fri, 13 Dec 2019 12:28:44 +0100
To:     Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH] KVM: arm/arm64: vgic-its: Fix restoration of unmapped  collections
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Dec 2019 11:28:43 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>
In-Reply-To: <d36b75e7-bd83-e501-3bd4-76bf0489c5ce@huawei.com>
References: <20191213094237.19627-1-eric.auger@redhat.com>
 <d36b75e7-bd83-e501-3bd4-76bf0489c5ce@huawei.com>
Message-ID: <9e9e3ed65ddf40ab72528187089e0997@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, eric.auger@redhat.com, eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 2019-12-13 10:53, Zenghui Yu wrote:
> Hi Eric,
>
> On 2019/12/13 17:42, Eric Auger wrote:
>> Saving/restoring an unmapped collection is a valid scenario. For
>> example this happens if a MAPTI command was sent, featuring an
>> unmapped collection. At the moment the CTE fails to be restored.
>> Only compare against the number of online vcpus if the rdist
>> base is set.
>
> Have you actually seen a problem and this patch fixed it? To be 
> honest,
> I'm surprised to find that we can map a LPI to an unmapped collection 
> ;)
> (and prevent it to be delivered to vcpu with an 
> INT_UNMAPPED_INTERRUPT
> error, until someone had actually mapped the collection).
> After a quick glance of spec (MAPTI), just as you said, this is 
> valid.

Yes, this is one of the (many) odd bits in the architecture. And there 
is
a bizarre wording in the MAPC description when V=0:

"Behavior is unpredictable if there are interrupts that are mapped to 
the
specified collection, with the restriction that further translation 
requests
from that device are ignored."

It is really odd that:

- it is unpredictable to unmap the collection with mapped interrupts,
   but mapping interrupts to an unmapped collection is fine

- the notion of "interrupts from that device" doesn't match any of the
   MAPC parameters

Do you hate the GIC already? ;-)

> If Marc has no objection to this fix, please add
>
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

Thanks for that, I've applied it to the patch and will push out
the update as soon as ra.kernel.org is reachable again.

         M.
-- 
Jazz is not dead. It just smells funny...
