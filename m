Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1474B358B8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 10:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfFEIhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 04:37:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:52566 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726885AbfFEIhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:37:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B76D4AB87;
        Wed,  5 Jun 2019 08:37:37 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] xen/swiotlb: remember having called
 xen_create_contiguous_region()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <20190529090407.1225-1-jgross@suse.com>
 <20190529090407.1225-4-jgross@suse.com>
 <20190530090409.GB30428@infradead.org>
 <eebb0275-9418-717f-97d7-5e55917f46fd@oracle.com>
 <2fbfc6a7-572c-1ce2-3323-802f9a77500e@suse.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <0fcd8b61-7714-2278-e552-f0b72d9c5d1a@suse.com>
Date:   Wed, 5 Jun 2019 10:37:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2fbfc6a7-572c-1ce2-3323-802f9a77500e@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.19 13:38, Juergen Gross wrote:
> On 30/05/2019 14:46, Boris Ostrovsky wrote:
>> On 5/30/19 5:04 AM, Christoph Hellwig wrote:
>>> Please don't add your private flag to page-flags.h.  The whole point of
>>> the private flag is that you can use it in any way you want withou
>>> touching the common code.
>>
>>
>> There is already a bunch of aliases for various sub-components
>> (including Xen) in page-flags.h for private flags, which is why I
>> suggested we do the same for the new use case. Adding this new alias
>> will keep flag usage consistent.
> 
> What about me adding another patch moving those Xen private aliases
> into arch/x86/include/asm/xen/page.h ?

This is becoming difficult.

I'd need to remove the "#undef PF_NO_COMPOUND" from page-flags.h or to
#include a (new) xen/page-flags.h from page-flags.h after all the
defines are ready. Is that really worth the effort given that other
components (e.g. file systems) are doing the same?


Juergen
