Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE10D10C892
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 13:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfK1MTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 07:19:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40841 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbfK1MTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 07:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574943572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=LeQTYn9Qt3o5rA+WQNAxKHbZ5MgiJd0v7EjtKEdo+zI=;
        b=dffgdn8ZcdyULdD7MzMI09Ih5Kp8gqlt8bPZdy+b0yFPL4PbYBSavmUwXiXB4qXRw6/QFI
        vnlLStULIfssOH6yfs/q9eH2b9O0Yh39mCDojjjlLmGGDfst4HL8VCB+pSrXIJvsEDAJnN
        lF4WHOc/rBZvU6n3mIY2Gf/RnleBHys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-blxf5S4uOSaEd2bEQRehxQ-1; Thu, 28 Nov 2019 07:19:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8182C800D4C;
        Thu, 28 Nov 2019 12:19:29 +0000 (UTC)
Received: from [10.36.116.124] (ovpn-116-124.ams2.redhat.com [10.36.116.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC0205D6C8;
        Thu, 28 Nov 2019 12:19:27 +0000 (UTC)
Subject: Re: [PATCH v1] drivers/base/node.c: get rid of get_nid_for_pfn()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191128102051.GI26807@dhcp22.suse.cz>
 <5E2F5866-0605-4DD2-9AEA-4B1C44E57D9F@redhat.com>
 <c8d2225f-9a90-65fa-5553-f4af8ca39b44@redhat.com>
 <20191128115021.GJ26807@dhcp22.suse.cz>
 <c7a3c823-d07d-54f7-19f1-bb75fb8f82df@redhat.com>
 <20191128120121.GL26807@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <17785662-d004-21ad-16a6-296c82779c8f@redhat.com>
Date:   Thu, 28 Nov 2019 13:19:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191128120121.GL26807@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: blxf5S4uOSaEd2bEQRehxQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.11.19 13:01, Michal Hocko wrote:
> On Thu 28-11-19 12:52:16, David Hildenbrand wrote:
>> On 28.11.19 12:50, Michal Hocko wrote:
>>> On Thu 28-11-19 12:23:08, David Hildenbrand wrote:
>>> [...]
>>>> >From fc13fd540a1702592e389e821f6266098e41e2bd Mon Sep 17 00:00:00 2001
>>>> From: David Hildenbrand <david@redhat.com>
>>>> Date: Wed, 27 Nov 2019 16:18:42 +0100
>>>> Subject: [PATCH] drivers/base/node.c: optimize get_nid_for_pfn()
>>>>
>>>> Since commit d84f2f5a7552 ("drivers/base/node.c: simplify
>>>> unregister_memory_block_under_nodes()") we only have a single user of
>>>> get_nid_for_pfn(). The remaining user calls this function when booting -
>>>> where all added memory is online.
>>>>
>>>> Make it clearer that this function should only be used during boot (
>>>> e.g., calling it on offline memory would be bad) by renaming the
>>>> function to something meaningful, optimize out the ifdef and the additional
>>>> system_state check, and add a comment why CONFIG_DEFERRED_STRUCT_PAGE_INIT
>>>> handling is in place at all.
>>>>
>>>> Also, optimize the call site. There is no need to check against
>>>> page_nid < 0 - it will never match the nid (nid >= 0).
>>>>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>>> Cc: Michal Hocko <mhocko@kernel.org>
>>>> Cc: Oscar Salvador <osalvador@suse.de>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>
>>> Yes this looks much better! I am not sure this will pass all weird
>>> config combinations because IS_ENABLED will not hide early_pfn_to_nid
>>> from the early compiler stages so it might complain. But if this passes
>>> 0day compile scrutiny then this is much much better. If not then we just
>>> have to use ifdef which is a minor thing.
>>
>> The compiler should optimize out
>>
>> if (0)
>> 	code
>>
>> and therefore never link to early_pfn_to_nid.
> 
> You are right, but there is a catch. The optimization phase is much
> later than the syntactic check so if the code doesn't make sense
> for the syntactic point of view then it will complain. This is a notable
> difference to #ifdef which just removes the whole block in the
> preprocessor phase.
> 

We should always have a declaration of early_pfn_to_nid(). The
interesting part AFAIKS is include/linux/mmzone.h:

#if !defined(CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID) && \
	!defined(CONFIG_HAVE_MEMBLOCK_NODE_MAP)
static inline unsigned long early_pfn_to_nid(unsigned long pfn)
{
	BUILD_BUG_ON(IS_ENABLED(CONFIG_NUMA));
	return 0;
}
#endif

so we would have

if (IS_ENABLED(...))
	BUILD_BUG_ON(IS_ENABLED(CONFIG_NUMA));

Let's see how that will turn out :) Will do some test builds
(CONFIG_NUMA, !CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID and
!CONFIG_HAVE_MEMBLOCK_NODE_MAP) ... if possible

-- 
Thanks,

David / dhildenb

