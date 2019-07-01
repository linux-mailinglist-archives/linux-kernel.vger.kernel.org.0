Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66E792B5AB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 14:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfE0MpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 08:45:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34949 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0MpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:45:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so16825194wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 05:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q2cYYgwiWVJJBJqLCSUSB4vY9rqs6lWWDF70rTeYp2I=;
        b=Paf9iVeoszHBnRKPHCz0DTUTPc6h34kPjVSNdzANESDsGV3GPKduruIq2bg+q11s9V
         FUZaiu9Z+FQFh1mKjx3dbJdyvMWhmPCgo0S5VkdlLQ+KpoNciX4ls7h1ZYuyu9seGx2I
         QCcK9hM/2+UGS/rjSUxzOIipqH3d/k2Iv28JR1K/aiwk43HLeIKvpoIlIOdbXDcMUY5n
         R3EDs0Rdtxx9o8gx/5aH2dq/7ipG+Xy7nJtGf83D1OqA8KF4Bds6phXfFPBdu5XpDup7
         lDrKLHe/NpW3sJL5vbzIcDjoNXPjomVwjkUgJEIUOoq9fyV+RiGyKQTWMZtWcjldHsUu
         LlSw==
X-Gm-Message-State: APjAAAVP0zliLxVQUdmHlZtFQDHIeqf6qhPOVklI42t8mJWmP+j+rmKR
        +lilkHsd+OG3weDaB4vwIgL+FA==
X-Google-Smtp-Source: APXvYqygU7qP4o2dkcY70xoK+YyGPQ+ieDW7hA+ZGXuE8LRMvLdpuQeC+BnMGifi0won+RJCrdExpA==
X-Received: by 2002:adf:bc94:: with SMTP id g20mr21574548wrh.206.1558961119322;
        Mon, 27 May 2019 05:45:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c92d:f9e8:f150:3553? ([2001:b07:6468:f312:c92d:f9e8:f150:3553])
        by smtp.gmail.com with ESMTPSA id o20sm13139362wro.2.2019.05.27.05.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 05:45:18 -0700 (PDT)
Subject: Re: [RFC PATCH 5/6] x86/mm/tlb: Flush remote and local TLBs
 concurrently
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juergen Gross <jgross@suse.com>, Nadav Amit <namit@vmware.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20190525082203.6531-1-namit@vmware.com>
 <20190525082203.6531-6-namit@vmware.com>
 <08b21fb5-2226-7924-30e3-31e4adcfc0a3@suse.com>
 <20190527094710.GU2623@hirez.programming.kicks-ass.net>
 <e9c0dc1f-799a-b6e3-8d41-58f0a6b693cd@redhat.com>
 <20190527123206.GC2623@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81a67fa3-309d-79cc-5009-5c4908b18ba3@redhat.com>
Date:   Mon, 27 May 2019 14:45:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527123206.GC2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/19 14:32, Peter Zijlstra wrote:
> On Mon, May 27, 2019 at 12:21:59PM +0200, Paolo Bonzini wrote:
>> On 27/05/19 11:47, Peter Zijlstra wrote:
> 
>>> --- a/arch/x86/kernel/kvm.c
>>> +++ b/arch/x86/kernel/kvm.c
>>> @@ -580,7 +580,7 @@ static void __init kvm_apf_trap_init(voi
>>>  
>>>  static DEFINE_PER_CPU(cpumask_var_t, __pv_tlb_mask);
>>>  
>>> -static void kvm_flush_tlb_others(const struct cpumask *cpumask,
>>> +static void kvm_flush_tlb_multi(const struct cpumask *cpumask,
>>>  			const struct flush_tlb_info *info)
>>>  {
>>>  	u8 state;
>>> @@ -594,6 +594,9 @@ static void kvm_flush_tlb_others(const s
>>>  	 * queue flush_on_enter for pre-empted vCPUs
>>>  	 */
>>>  	for_each_cpu(cpu, flushmask) {
>>> +		if (cpu == smp_processor_id())
>>> +			continue;
>>> +
>>
>> Even this would be just an optimization; the vCPU you're running on
>> cannot be preempted.  You can just change others to multi.
> 
> Yeah, I know, but it felt weird so I added the explicit skip. No strong
> feelings though.

Neither here, and it would indeed deserve a comment if you left the if out.

Paolo

