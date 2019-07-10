Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 267D063CB9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 22:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfGIUah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 16:30:37 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:18182 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729179AbfGIUag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:30:36 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x69KPsj6018245;
        Tue, 9 Jul 2019 20:29:13 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 2tn06s8q1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jul 2019 20:29:13 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 77E2F9A;
        Tue,  9 Jul 2019 20:29:12 +0000 (UTC)
Received: from [16.116.129.61] (unknown [16.116.129.61])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 5101D48;
        Tue,  9 Jul 2019 20:29:10 +0000 (UTC)
Subject: Re: [PATCH v2 8/9] x86/mm/tlb: Remove UV special case
To:     Russ Anderson <rja@hpe.com>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>
References: <20190702235151.4377-1-namit@vmware.com>
 <20190702235151.4377-9-namit@vmware.com>
 <alpine.DEB.2.21.1907092146570.1758@nanos.tec.linutronix.de>
 <20190709200914.fjvi3cy3qfc6fmis@hpe.com>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <373adfb0-0047-eae2-46a5-041caddfca97@hpe.com>
Date:   Tue, 9 Jul 2019 13:29:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190709200914.fjvi3cy3qfc6fmis@hpe.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-09_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/2019 1:09 PM, Russ Anderson wrote:
> On Tue, Jul 09, 2019 at 09:50:27PM +0200, Thomas Gleixner wrote:
>> On Tue, 2 Jul 2019, Nadav Amit wrote:
>>
>>> SGI UV support is outdated and not maintained, and it is not clear how
>>> it performs relatively to non-UV. Remove the code to simplify the code.
>>
>> You should at least Cc the SGI/HP folks on that. They are still
>> around. Done so.
> 
> Thanks Thomas.  The SGI UV is now HPE Superdome Flex and is
> very much still supported.
> 
> Thanks.
> 
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Dave Hansen <dave.hansen@intel.com>
>>> Suggested-by: Andy Lutomirski <luto@kernel.org>
>>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>> ---
>>>   arch/x86/mm/tlb.c | 25 -------------------------
>>>   1 file changed, 25 deletions(-)
>>>
>>> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
>>> index b47a71820f35..64afe1215495 100644
>>> --- a/arch/x86/mm/tlb.c
>>> +++ b/arch/x86/mm/tlb.c
>>> @@ -689,31 +689,6 @@ void native_flush_tlb_multi(const struct cpumask *cpumask,
>>>   		trace_tlb_flush(TLB_REMOTE_SEND_IPI,
>>>   				(info->end - info->start) >> PAGE_SHIFT);
>>>   
>>> -	if (is_uv_system()) {
>>> -		/*
>>> -		 * This whole special case is confused.  UV has a "Broadcast
>>> -		 * Assist Unit", which seems to be a fancy way to send IPIs.
>>> -		 * Back when x86 used an explicit TLB flush IPI, UV was
>>> -		 * optimized to use its own mechanism.  These days, x86 uses
>>> -		 * smp_call_function_many(), but UV still uses a manual IPI,
>>> -		 * and that IPI's action is out of date -- it does a manual
>>> -		 * flush instead of calling flush_tlb_func_remote().  This
>>> -		 * means that the percpu tlb_gen variables won't be updated
>>> -		 * and we'll do pointless flushes on future context switches.
>>> -		 *
>>> -		 * Rather than hooking native_flush_tlb_multi() here, I think
>>> -		 * that UV should be updated so that smp_call_function_many(),
>>> -		 * etc, are optimal on UV.
>>> -		 */

I thought this change was already proposed a bit ago and we acked it 
awhile back.  Also the replacement functionality is being worked on but 
it is more complex.  The smp call many has to support all the reasons 
why it's called and not just the tlb shoot downs as is the current BAU case.

>>> -		flush_tlb_func_local(info);
>>> -
>>> -		cpumask = uv_flush_tlb_others(cpumask, info);
>>> -		if (cpumask)
>>> -			smp_call_function_many(cpumask, flush_tlb_func_remote,
>>> -					       (void *)info, 1);
>>> -		return;
>>> -	}
>>> -
>>>   	/*
>>>   	 * If no page tables were freed, we can skip sending IPIs to
>>>   	 * CPUs in lazy TLB mode. They will flush the CPU themselves
>>> -- 
>>> 2.17.1
>>>
>>>
> 
