Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02038109229
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 17:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfKYQul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 11:50:41 -0500
Received: from foss.arm.com ([217.140.110.172]:52764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbfKYQuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:50:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2343831B;
        Mon, 25 Nov 2019 08:50:40 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C546C3F68E;
        Mon, 25 Nov 2019 08:50:38 -0800 (PST)
Subject: Re: [GIT PULL] scheduler changes for v5.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20191125125944.GA22218@gmail.com>
 <9af8a5eb-5104-ad0b-bf46-dedb65d66a07@arm.com>
 <CAHk-=wjV6CGaVXYoWvQER4_xmFdX2eTBSYf+6WhcgAx+K9M+Og@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <ea914edf-4674-368a-f32c-d4eeeabea703@arm.com>
Date:   Mon, 25 Nov 2019 16:50:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjV6CGaVXYoWvQER4_xmFdX2eTBSYf+6WhcgAx+K9M+Og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2019 16:48, Linus Torvalds wrote:
> On Mon, Nov 25, 2019 at 5:49 AM Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>> On 25/11/2019 12:59, Ingo Molnar wrote:
>>
>> So I really don't want to be labeled as "that annoying scheduler PR guy",
>> but some patches in Vincent's rework should be squashed to avoid being
>> performance bisection honeypots.
>>
>>> Vincent Guittot (14):
>>>       sched/fair: Remove meaningless imbalance calculation
>>>       sched/fair: Rework load_balance()
>>
>> These two ^ (were split for ease of reviewing, [1])
>>
>>>       sched/fair: Rework find_idlest_group()
>>>       sched/fair: Fix rework of find_idlest_group()
>>
>> And these two ^ (Mel voiced similar concerns at [2])
> 
> If they were split for ease of reviewing, then they should be split in
> the history too.
> 
> I worry a lot less about some possible (temporary!) performance dip
> than about a hard bug, and if the code is easier to review in two
> steps then it's going to be easier to find the bug in two steps too.
> 

Fair enough, lesson learned, sorry for the noise.
