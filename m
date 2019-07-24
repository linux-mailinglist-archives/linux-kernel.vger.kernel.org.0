Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7335F74176
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 00:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfGXWd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 18:33:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33772 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbfGXWdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:33:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6OMTQQU080677;
        Wed, 24 Jul 2019 22:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=T4TIk7/YwKOm4x1XPhKWgCwUqxVWnEshEleFDCiEZIE=;
 b=wSZPFjjwCyIbVQXy9Y3eYmi8aobjcX0/jm+9W8UAzFRsuiaHXudiTEqFO1tbu4s13Plw
 sIDh3O/iEZlDUjjx22xQsvRlJ8mca5GNNFlvEu0bF3XT1fAgxGan4JBfmDCJ92oTfOvd
 O9J+bZ8dKRY5jOZP7SxrVRpk9DfhmV4pGbPKf8B5Rvc1uEUocbJ+xUeMats6IL25Ozb7
 zkVIzJDpTEv+KOGHks0GRxP+gbcY7v8l72NSz6BG8zIZZvE4AMsKo3hlazk4tnHbeqgT
 LwCm4QZ1y2XSk//9E68gnBUUjJIK/cIrgpXKiF7Xj/h2bdFdRvf29FWsne2goYNnhVv9 0Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tx61c05g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 22:33:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6OMWUbY037175;
        Wed, 24 Jul 2019 22:33:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2tx60xys71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 22:33:17 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6OMXF5w009716;
        Wed, 24 Jul 2019 22:33:15 GMT
Received: from [10.132.93.219] (/10.132.93.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jul 2019 15:33:15 -0700
Subject: Re: [PATCH] mm/memory-failure: Poison read receives SIGKILL instead
 of SIGBUS if mmaped more than once
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
References: <1563925110-19359-1-git-send-email-jane.chu@oracle.com>
 <CAPcyv4hyvHFnSE4AUbXooxX_Ug-raxAJgzC7jzkHp_mSg_sCmg@mail.gmail.com>
 <20190724064846.GA17567@hori.linux.bs1.fc.nec.co.jp>
From:   jane.chu@oracle.com
Organization: Oracle Corporation
Message-ID: <2cff94e6-27ea-46c7-bee4-55d789fdc6af@oracle.com>
Date:   Wed, 24 Jul 2019 15:33:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190724064846.GA17567@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240241
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all for your comments!
I've incorporated them, tested, and have a v2 ready for review.

Thanks!
-jane

On 7/23/19 11:48 PM, Naoya Horiguchi wrote:
> Hi Jane, Dan,
> 
> On Tue, Jul 23, 2019 at 06:34:35PM -0700, Dan Williams wrote:
>> On Tue, Jul 23, 2019 at 4:49 PM Jane Chu <jane.chu@oracle.com> wrote:
>>>
>>> Mmap /dev/dax more than once, then read the poison location using address
>>> from one of the mappings. The other mappings due to not having the page
>>> mapped in will cause SIGKILLs delivered to the process. SIGKILL succeeds
>>> over SIGBUS, so user process looses the opportunity to handle the UE.
>>>
>>> Although one may add MAP_POPULATE to mmap(2) to work around the issue,
>>> MAP_POPULATE makes mapping 128GB of pmem several magnitudes slower, so
>>> isn't always an option.
>>>
>>> Details -
>>>
>>> ndctl inject-error --block=10 --count=1 namespace6.0
>>>
>>> ./read_poison -x dax6.0 -o 5120 -m 2
>>> mmaped address 0x7f5bb6600000
>>> mmaped address 0x7f3cf3600000
>>> doing local read at address 0x7f3cf3601400
>>> Killed
>>>
>>> Console messages in instrumented kernel -
>>>
>>> mce: Uncorrected hardware memory error in user-access at edbe201400
>>> Memory failure: tk->addr = 7f5bb6601000
>>> Memory failure: address edbe201: call dev_pagemap_mapping_shift
>>> dev_pagemap_mapping_shift: page edbe201: no PUD
>>> Memory failure: tk->size_shift == 0
>>> Memory failure: Unable to find user space address edbe201 in read_poison
>>> Memory failure: tk->addr = 7f3cf3601000
>>> Memory failure: address edbe201: call dev_pagemap_mapping_shift
>>> Memory failure: tk->size_shift = 21
>>> Memory failure: 0xedbe201: forcibly killing read_poison:22434 because of failure to unmap corrupted page
>>>    => to deliver SIGKILL
>>> Memory failure: 0xedbe201: Killing read_poison:22434 due to hardware memory corruption
>>>    => to deliver SIGBUS
>>>
>>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>>> ---
>>>   mm/memory-failure.c | 16 ++++++++++------
>>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index d9cc660..7038abd 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -315,7 +315,6 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>>>
>>>          if (*tkc) {
>>>                  tk = *tkc;
>>> -               *tkc = NULL;
>>>          } else {
>>>                  tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
>>>                  if (!tk) {
>>> @@ -331,16 +330,21 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>>>                  tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
>>>
>>>          /*
>>> -        * In theory we don't have to kill when the page was
>>> -        * munmaped. But it could be also a mremap. Since that's
>>> -        * likely very rare kill anyways just out of paranoia, but use
>>> -        * a SIGKILL because the error is not contained anymore.
>>> +        * Indeed a page could be mmapped N times within a process. And it's possible
>>> +        * that not all of those N VMAs contain valid mapping for the page. In which
>>> +        * case we don't want to send SIGKILL to the process on behalf of the VMAs
>>> +        * that don't have the valid mapping, because doing so will eclipse the SIGBUS
>>> +        * delivered on behalf of the active VMA.
>>>           */
>>>          if (tk->addr == -EFAULT || tk->size_shift == 0) {
>>>                  pr_info("Memory failure: Unable to find user space address %lx in %s\n",
>>>                          page_to_pfn(p), tsk->comm);
>>> -               tk->addr_valid = 0;
>>> +               if (tk != *tkc)
>>> +                       kfree(tk);
>>> +               return;
> 
> The immediate return bypasses list_add_tail() below, so we might lose
> the chance of sending SIGBUS to the process.
> 
> tk->size_shift is always non-zero for !is_zone_device_page(), so
> "tk->size_shift == 0" effectively checks "no mapping on ZONE_DEVICE" now.
> As you mention above, "no mapping" doesn't means "invalid address"
> so we can drop "tk->size_shift == 0" check from this if-statement.
> Going forward in this direction, "tk->addr_valid == 0" is equivalent to
> "tk->addr == -EFAULT", so we seems to be able to remove ->addr_valid.
> This observation leads me to the following change, does it work for you?
> 
>    --- a/mm/memory-failure.c
>    +++ b/mm/memory-failure.c
>    @@ -199,7 +199,6 @@ struct to_kill {
>     	struct task_struct *tsk;
>     	unsigned long addr;
>     	short size_shift;
>    -	char addr_valid;
>     };
>     
>     /*
>    @@ -324,7 +323,6 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>     		}
>     	}
>     	tk->addr = page_address_in_vma(p, vma);
>    -	tk->addr_valid = 1;
>     	if (is_zone_device_page(p))
>     		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
>     	else
>    @@ -336,11 +334,9 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>     	 * likely very rare kill anyways just out of paranoia, but use
>     	 * a SIGKILL because the error is not contained anymore.
>     	 */
>    -	if (tk->addr == -EFAULT || tk->size_shift == 0) {
>    +	if (tk->addr == -EFAULT)
>     		pr_info("Memory failure: Unable to find user space address %lx in %s\n",
>     			page_to_pfn(p), tsk->comm);
>    -		tk->addr_valid = 0;
>    -	}
>     	get_task_struct(tsk);
>     	tk->tsk = tsk;
>     	list_add_tail(&tk->nd, to_kill);
>    @@ -366,7 +362,7 @@ static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
>     			 * make sure the process doesn't catch the
>     			 * signal and then access the memory. Just kill it.
>     			 */
>    -			if (fail || tk->addr_valid == 0) {
>    +			if (fail || tk->addr == -EFAULT) {
>     				pr_err("Memory failure: %#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
>     				       pfn, tk->tsk->comm, tk->tsk->pid);
>     				do_send_sig_info(SIGKILL, SEND_SIG_PRIV,
> 
>>>          }
>>> +       if (tk == *tkc)
>>> +               *tkc = NULL;
>>>          get_task_struct(tsk);
>>>          tk->tsk = tsk;
>>>          list_add_tail(&tk->nd, to_kill);
>>
>>
>> Concept and policy looks good to me, and I never did understand what
>> the mremap() case was trying to protect against.
>>
>> The patch is a bit difficult to read (not your fault) because of the
>> odd way that add_to_kill() expects the first 'tk' to be pre-allocated.
>> May I ask for a lead-in cleanup that moves all the allocation internal
>> to add_to_kill() and drops the **tk argument?
> 
> I totally agree with this cleanup. Thanks for the comment.
> 
> Thanks,
> Naoya Horiguchi
> 
