Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E12E8341F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 16:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733083AbfHFOlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 10:41:31 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:39190 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731807AbfHFOlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:41:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0TYpaznJ_1565102485;
Received: from 10.15.232.115(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TYpaznJ_1565102485)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 06 Aug 2019 22:41:26 +0800
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Phil Auld <pauld@redhat.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad> <20190805200914.GD20173@pauld.bos.csb>
 <20190806135401.GB46757@aaronlu> <20190806141750.GA20858@pauld.bos.csb>
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
Message-ID: <83904232-dc75-34fa-2cf6-e11739ae7e5c@linux.alibaba.com>
Date:   Tue, 6 Aug 2019 22:41:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806141750.GA20858@pauld.bos.csb>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/6 22:17, Phil Auld wrote:
> On Tue, Aug 06, 2019 at 09:54:01PM +0800 Aaron Lu wrote:
>> On Mon, Aug 05, 2019 at 04:09:15PM -0400, Phil Auld wrote:
>>> Hi,
>>>
>>> On Fri, Aug 02, 2019 at 11:37:15AM -0400 Julien Desfossez wrote:
>>>> We tested both Aaron's and Tim's patches and here are our results.
>>>>
>>>> Test setup:
>>>> - 2 1-thread sysbench, one running the cpu benchmark, the other one the
>>>>   mem benchmark
>>>> - both started at the same time
>>>> - both are pinned on the same core (2 hardware threads)
>>>> - 10 30-seconds runs
>>>> - test script: https://paste.debian.net/plainh/834cf45c
>>>> - only showing the CPU events/sec (higher is better)
>>>> - tested 4 tag configurations:
>>>>   - no tag
>>>>   - sysbench mem untagged, sysbench cpu tagged
>>>>   - sysbench mem tagged, sysbench cpu untagged
>>>>   - both tagged with a different tag
>>>> - "Alone" is the sysbench CPU running alone on the core, no tag
>>>> - "nosmt" is both sysbench pinned on the same hardware thread, no tag
>>>> - "Tim's full patchset + sched" is an experiment with Tim's patchset
>>>>   combined with Aaron's "hack patch" to get rid of the remaining deep
>>>>   idle cases
>>>> - In all test cases, both tasks can run simultaneously (which was not
>>>>   the case without those patches), but the standard deviation is a
>>>>   pretty good indicator of the fairness/consistency.
>>>>
>>>> No tag
>>>> ------
>>>> Test                            Average     Stdev
>>>> Alone                           1306.90     0.94
>>>> nosmt                           649.95      1.44
>>>> Aaron's full patchset:          828.15      32.45
>>>> Aaron's first 2 patches:        832.12      36.53
>>>> Aaron's 3rd patch alone:        864.21      3.68
>>>> Tim's full patchset:            852.50      4.11
>>>> Tim's full patchset + sched:    852.59      8.25
>>>>
>>>> Sysbench mem untagged, sysbench cpu tagged
>>>> ------------------------------------------
>>>> Test                            Average     Stdev
>>>> Alone                           1306.90     0.94
>>>> nosmt                           649.95      1.44
>>>> Aaron's full patchset:          586.06      1.77
>>>> Aaron's first 2 patches:        630.08      47.30
>>>> Aaron's 3rd patch alone:        1086.65     246.54
>>>> Tim's full patchset:            852.50      4.11
>>>> Tim's full patchset + sched:    390.49      15.76
>>>>
>>>> Sysbench mem tagged, sysbench cpu untagged
>>>> ------------------------------------------
>>>> Test                            Average     Stdev
>>>> Alone                           1306.90     0.94
>>>> nosmt                           649.95      1.44
>>>> Aaron's full patchset:          583.77      3.52
>>>> Aaron's first 2 patches:        513.63      63.09
>>>> Aaron's 3rd patch alone:        1171.23     3.35
>>>> Tim's full patchset:            564.04      58.05
>>>> Tim's full patchset + sched:    1026.16     49.43
>>>>
>>>> Both sysbench tagged
>>>> --------------------
>>>> Test                            Average     Stdev
>>>> Alone                           1306.90     0.94
>>>> nosmt                           649.95      1.44
>>>> Aaron's full patchset:          582.15      3.75
>>>> Aaron's first 2 patches:        561.07      91.61
>>>> Aaron's 3rd patch alone:        638.49      231.06
>>>> Tim's full patchset:            679.43      70.07
>>>> Tim's full patchset + sched:    664.34      210.14
>>>>
>>>
>>> Sorry if I'm missing something obvious here but with only 2 processes 
>>> of interest shouldn't one tagged and one untagged be about the same
>>> as both tagged?  
>>
>> It should.
>>
>>> In both cases the 2 sysbenches should not be running on the core at 
>>> the same time. 
>>
>> Agree.
>>
>>> There will be times when oher non-related threads could share the core
>>> with the untagged one. Is that enough to account for this difference?
>>
>> What difference do you mean?
> 
> 
> I was looking at the above posted numbers. For example:
> 
>>>> Sysbench mem untagged, sysbench cpu tagged
>>>> Aaron's 3rd patch alone:        1086.65     246.54
> 
>>>> Sysbench mem tagged, sysbench cpu untagged
>>>> Aaron's 3rd patch alone:        1171.23     3.35
> 
>>>> Both sysbench tagged
>>>> Aaron's 3rd patch alone:        638.49      231.06
> 
> 
> Admittedly, there's some high variance on some of those numbers. 

The high variance suggests the code having some fairness issues :-)

For the test here, I didn't expect the 3rd patch being used alone
since the fairness is solved by patch2 and patch3 together.
