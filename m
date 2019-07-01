Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD4D333169
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 15:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfFCNsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 09:48:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51430 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727645AbfFCNsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:48:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6583E15A2;
        Mon,  3 Jun 2019 06:48:04 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45F5B3F246;
        Mon,  3 Jun 2019 06:48:03 -0700 (PDT)
Subject: Re: [PATCH] iommu: replace single-char identifiers in macros
To:     Qian Cai <cai@lca.pw>, jroedel@suse.de
Cc:     akpm@linux-foundation.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1559566783-13627-1-git-send-email-cai@lca.pw>
 <fe5e8da4-38d2-c663-c2e2-70e6d4f7640f@arm.com>
 <1559568571.6132.42.camel@lca.pw>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <deedf85a-35bc-e8be-dd94-6acb775af019@arm.com>
Date:   Mon, 3 Jun 2019 14:48:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559568571.6132.42.camel@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2019 14:29, Qian Cai wrote:
> On Mon, 2019-06-03 at 14:07 +0100, Robin Murphy wrote:
>> On 03/06/2019 13:59, Qian Cai wrote:
>>> There are a few macros in IOMMU have single-char identifiers make the
>>> code hard to read and debug. Replace them with meaningful names.
>>>
>>> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
>>> Signed-off-by: Qian Cai <cai@lca.pw>
>>> ---
>>>    include/linux/dmar.h | 14 ++++++++------
>>>    1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
>>> index f8af1d770520..eb634912f475 100644
>>> --- a/include/linux/dmar.h
>>> +++ b/include/linux/dmar.h
>>> @@ -104,12 +104,14 @@ static inline bool dmar_rcu_check(void)
>>>    
>>>    #define	dmar_rcu_dereference(p)	rcu_dereference_check((p),
>>> dmar_rcu_check())
>>>    
>>> -#define	for_each_dev_scope(a, c, p, d)	\
>>> -	for ((p) = 0; ((d) = (p) < (c) ? dmar_rcu_dereference((a)[(p)].dev)
>>> : \
>>> -			NULL, (p) < (c)); (p)++)
>>> -
>>> -#define	for_each_active_dev_scope(a, c, p, d)	\
>>> -	for_each_dev_scope((a), (c), (p), (d))	if (!(d)) { continue;
>>> } else
>>> +#define for_each_dev_scope(devs, cnt, i, tmp)				
>>> \
>>> +	for ((i) = 0; ((tmp) = (i) < (cnt) ?				
>>> \
>>
>> Given that "tmp" actually appears to be some sort of device cursor, I'm
>> not sure that that naming really achieves the stated goal of clarity :/
> 
> "tmp" is used in the callers everywhere though, although I suppose something
> like "tmp_dev" can be used if you prefer.

I don't have any preference, I'm just questioning the assertion in the 
commit message - as a reader not intimately familiar with this code, 
"tmp" is honestly no more meaningful than "d" was.

Robin.
