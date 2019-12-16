Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE2B1218B7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 19:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfLPSpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 13:45:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49103 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728015AbfLPSpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576521901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TRtADKzTFs1Qp6frXK2BKRNuHXrenGJCtn+oRTbET5s=;
        b=RT6fMZIfAyU0ajEDL3GPn5tjwkaJqJB6b/FFZAJfZV9+J43I5eQpv60cZQSsL1pXpFmt0J
        HVw0HENZLF6tXmcCocKSs7vsVrPDeeEKniIttJ7Bj99InPoruMRofFM2zf21z91Y97PRUS
        SDo2khm8++EGVHCV4eNVXyv5dWrHDuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-spawUSm_O2mMRRbRhFQ_Cw-1; Mon, 16 Dec 2019 13:44:59 -0500
X-MC-Unique: spawUSm_O2mMRRbRhFQ_Cw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60EB8800D41;
        Mon, 16 Dec 2019 18:44:58 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 873A619427;
        Mon, 16 Dec 2019 18:44:54 +0000 (UTC)
Subject: Re: [PATCH v2] mm/hugetlb: defer free_huge_page() to a workqueue
From:   Waiman Long <longman@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.ibm.com, Jarod Wilson <jarod@redhat.com>
References: <20191211194615.18502-1-longman@redhat.com>
 <4fbc39a9-2c9c-4c2c-2b13-a548afe6083c@oracle.com>
 <32d2d4f2-83b9-2e40-05e2-71cd07e01b80@redhat.com>
 <0fcce71f-bc20-0ea3-b075-46592c8d533d@oracle.com>
 <20191212060650.ftqq27ftutxpc5hq@linux-p48b>
 <20191212063050.ufrpij6s6jkv7g7j@linux-p48b>
 <20191212190427.ouyohviijf5inhur@linux-p48b>
 <d6b9743c-776c-d740-73af-a600f15b910a@oracle.com>
 <79d3a7e1-384b-b759-cd84-56253fb9ed40@redhat.com>
 <20191216132658.GG30281@dhcp22.suse.cz>
 <98ac628d-f8be-270d-80bc-bf2373299caf@redhat.com>
Organization: Red Hat
Message-ID: <21a92649-bb9f-b024-e52b-4ce9355f973b@redhat.com>
Date:   Mon, 16 Dec 2019 13:44:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <98ac628d-f8be-270d-80bc-bf2373299caf@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/19 10:38 AM, Waiman Long wrote:
> On 12/16/19 8:26 AM, Michal Hocko wrote:
>> On Thu 12-12-19 15:52:20, Waiman Long wrote:
>>> On 12/12/19 2:22 PM, Mike Kravetz wrote:
>>>> On 12/12/19 11:04 AM, Davidlohr Bueso wrote:
>>>>> There have been deadlock reports[1, 2] where put_page is called
>>>>> from softirq context and this causes trouble with the hugetlb_lock,
>>>>> as well as potentially the subpool lock.
>>>>>
>>>>> For such an unlikely scenario, lets not add irq dancing overhead
>>>>> to the lock+unlock operations, which could incur in expensive
>>>>> instruction dependencies, particularly when considering hard-irq
>>>>> safety. For example PUSHF+POPF on x86.
>>>>>
>>>>> Instead, just use a workqueue and do the free_huge_page() in regular
>>>>> task context.
>>>>>
>>>>> [1] https://lore.kernel.org/lkml/20191211194615.18502-1-longman@redhat.com/
>>>>> [2] https://lore.kernel.org/lkml/20180905112341.21355-1-aneesh.kumar@linux.ibm.com/
>>>>>
>>>>> Reported-by: Waiman Long <longman@redhat.com>
>>>>> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>>>> Thank you Davidlohr.
>>>>
>>>> The patch does seem fairly simple and straight forward.  I need to brush up
>>>> on my workqueue knowledge to provide a full review.
>>>>
>>>> Longman,
>>>> Do you have a test to reproduce the issue?  If so, can you try running with
>>>> this patch.
>>> Yes, I do have a test that can reproduce the issue. I will run it with
>>> the patch and report the status tomorrow.
>> Can you extract guts of the testcase and integrate them into hugetlb
>> test suite?

BTW, what hugetlb test suite are you talking about?

Cheers,
Longman

