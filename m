Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34FC8BD0C0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 19:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407749AbfIXRfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 13:35:11 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:28692 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730690AbfIXRfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:35:10 -0400
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8OHMPVc027933;
        Tue, 24 Sep 2019 18:35:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=dpJwzAPXmBpI/Z8VFke+ya2k2FRPMeUTDY5Spj0JTE8=;
 b=l3C7UHNV648cGAH6rwG87Mvh7tBQ5DUe6cSnEp2vqguKfrwseVo4QnOKQqZJq5VADX+t
 FMnwQ0hxHT7NWqPTMnqomGhAoFcAOxDhfUrQl1gcL6vFQp86GbYd4AWkKtIgVmMb9ZCD
 F8fHrBZlqxiFzBrQnkupLXeQftZEKaZ0LlcwpaQqbiha3tiAmcX3hO9FNFTfikCF8hyQ
 woOMpapuZFtfOOFgLhrdTDcbjJWKwnS9O6EzzJ52AqErnMBUb6jNTH1w2nPQDfAthel3
 6JgZsA3Gth/RCK0hlA3XAyf+gp0+uDf3Ug7YJBzhcXCBzdvhebV2xW3OLrMBA4yWs36x ig== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 2v73qb4raq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 18:35:04 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x8OHWqBw032396;
        Tue, 24 Sep 2019 13:35:03 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint2.akamai.com with ESMTP id 2v73vpcdnm-1;
        Tue, 24 Sep 2019 13:35:03 -0400
Received: from [172.29.170.83] (bos-lpjec.kendall.corp.akamai.com [172.29.170.83])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 4147E1FC72;
        Tue, 24 Sep 2019 17:35:03 +0000 (GMT)
Subject: Re: [PATCH] epoll: simplify ep_poll_safewake() for
 CONFIG_DEBUG_LOCK_ALLOC
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Wong <normalperson@yhbt.net>
References: <1567628549-11501-1-git-send-email-jbaron@akamai.com>
 <a07adc0e-590e-623c-3c80-e28af39bd19c@akamai.com>
 <1b26e25fcc0e6c54cbdb9e66dade17db@suse.de>
From:   Jason Baron <jbaron@akamai.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jbaron@akamai.com; prefer-encrypt=mutual; keydata=
 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
 JeQ7iQ==
Message-ID: <04b08b78-6348-d592-ca2e-f718955bcc68@akamai.com>
Date:   Tue, 24 Sep 2019 13:34:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1b26e25fcc0e6c54cbdb9e66dade17db@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909240151
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-24_07:2019-09-23,2019-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909240151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/19 3:23 PM, Roman Penyaev wrote:
> On 2019-09-23 17:43, Jason Baron wrote:
>> On 9/4/19 4:22 PM, Jason Baron wrote:
>>> Currently, ep_poll_safewake() in the CONFIG_DEBUG_LOCK_ALLOC case uses
>>> ep_call_nested() in order to pass the correct subclass argument to
>>> spin_lock_irqsave_nested(). However, ep_call_nested() adds unnecessary
>>> checks for epoll depth and loops that are already verified when doing
>>> EPOLL_CTL_ADD. This mirrors a conversion that was done for
>>> !CONFIG_DEBUG_LOCK_ALLOC in: commit 37b5e5212a44 ("epoll: remove
>>> ep_call_nested() from ep_eventpoll_poll()")
>>>
>>> Signed-off-by: Jason Baron <jbaron@akamai.com>
>>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>>> Cc: Roman Penyaev <rpenyaev@suse.de>
>>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>>> Cc: Eric Wong <normalperson@yhbt.net>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> ---
>>>  fs/eventpoll.c | 36 +++++++++++++-----------------------
>>>  1 file changed, 13 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
>>> index d7f1f50..a9b2737 100644
>>> --- a/fs/eventpoll.c
>>> +++ b/fs/eventpoll.c
>>> @@ -551,28 +551,23 @@ static int ep_call_nested(struct nested_calls
>>> *ncalls,
>>>   */
>>>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>>
>>> -static struct nested_calls poll_safewake_ncalls;
>>> -
>>> -static int ep_poll_wakeup_proc(void *priv, void *cookie, int
>>> call_nests)
>>> -{
>>> -    unsigned long flags;
>>> -    wait_queue_head_t *wqueue = (wait_queue_head_t *)cookie;
>>> -
>>> -    spin_lock_irqsave_nested(&wqueue->lock, flags, call_nests + 1);
>>> -    wake_up_locked_poll(wqueue, EPOLLIN);
>>> -    spin_unlock_irqrestore(&wqueue->lock, flags);
>>> -
>>> -    return 0;
>>> -}
>>> +static DEFINE_PER_CPU(int, wakeup_nest);
>>>
>>>  static void ep_poll_safewake(wait_queue_head_t *wq)
>>>  {
>>> -    int this_cpu = get_cpu();
>>> -
>>> -    ep_call_nested(&poll_safewake_ncalls,
>>> -               ep_poll_wakeup_proc, NULL, wq, (void *) (long)
>>> this_cpu);
>>> +    unsigned long flags;
>>> +    int subclass;
>>>
>>> -    put_cpu();
>>> +    local_irq_save(flags);
>>> +    preempt_disable();
>>> +    subclass = __this_cpu_read(wakeup_nest);
>>> +    spin_lock_nested(&wq->lock, subclass + 1);
>>> +    __this_cpu_inc(wakeup_nest);
>>> +    wake_up_locked_poll(wq, POLLIN);
>>> +    __this_cpu_dec(wakeup_nest);
>>> +    spin_unlock(&wq->lock);
>>> +    local_irq_restore(flags);
>>> +    preempt_enable();
>>>  }
> 
> What if reduce number of lines with something as the following:
> 
>    int this_cpu = get_cpu();
>    subclass = __this_cpu_inc_return(wakeup_nest);
>    spin_lock_irqsave_nested(&wq->lock, flags, subclass);
>    wake_up_locked_poll(wq, POLLIN);
>    spin_unlock_irqrestore(&wq->lock, flags);
>    __this_cpu_dec(wakeup_nest);
>    put_cpu();
> 
> Other than that looks good to me.
> 
> Reviewed-by: Roman Penyaev <rpenyaev@suse.de>
> 
> -- 
> Roman


Hi,

I put the local_irq_save(flags), call there first so that there wouldn't
be any nesting. For example, in your sequence, there could be an irq
after the  __this_cpu_inc_return(), that could end up back here.

I still can use __this_cpu_inc_return() to simplify things a bit.

Thanks,

-Jason

