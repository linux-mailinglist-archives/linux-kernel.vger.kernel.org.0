Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 283DE9A8BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 09:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbfHWH0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 03:26:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730918AbfHWH0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:26:53 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F3E65474774D532B667D;
        Fri, 23 Aug 2019 15:26:50 +0800 (CST)
Received: from [127.0.0.1] (10.133.211.147) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 23 Aug 2019
 15:26:46 +0800
Subject: Re: [PATCH V2] cpustat: print watchdog time and statistics of soft
 and hard interrupts in soft lockup scenes
To:     Peter Zijlstra <peterz@infradead.org>
References: <60319e82-3c2b-ff24-4ba7-4d58048130ff@huawei.com>
 <20190820110430.GL2332@hirez.programming.kicks-ass.net>
 <4eb6b499-b6b0-602a-ae89-0c1dceaa5088@huawei.com>
 <20190821104643.GA2349@hirez.programming.kicks-ass.net>
 <40d9fb6d-ac9f-5af2-1726-f824c4d56fa2@huawei.com>
 <20190822161412.GV2369@hirez.programming.kicks-ass.net>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
From:   c00423981 <caomeng5@huawei.com>
Message-ID: <c169f207-2f88-c457-2f08-f5da546db113@huawei.com>
Date:   Fri, 23 Aug 2019 15:26:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20190822161412.GV2369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.211.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/23 0:14, Peter Zijlstra wrote:
> On Thu, Aug 22, 2019 at 07:58:37PM +0800, c00423981 wrote:
> 
>> V1->V2
>> - fix the broken interfaces: get_idle_time and get_iowait_time
> 
>> +	else if (index == CPUTIME_IOWAIT)
>> +		time = get_iowait_time(kcs, cpu);
> 
> I'm confused; isn't that still reporting per-cpu iowait, which is still
> complete garbage?
> 
> 

Yes, I understand that these two interfaces(nr_iowait_cpu and nr_iowait) will
use nonsensical data. Thanks for your answer very much.

By the way, are there an alternative about these two interfaces?
Looking forward to your reply.

