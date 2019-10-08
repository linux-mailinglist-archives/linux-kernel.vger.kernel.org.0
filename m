Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A434CFC80
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 16:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfJHOeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 10:34:07 -0400
Received: from foss.arm.com ([217.140.110.172]:38216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfJHOeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:34:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B5AE1570;
        Tue,  8 Oct 2019 07:34:06 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50A223F703;
        Tue,  8 Oct 2019 07:34:05 -0700 (PDT)
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
 <c752dd1a-731e-aae3-6a2c-aecf88901ac0@arm.com>
 <CAKfTPtBQNJfNmBqpuaefsLzsTrGxJ=2bTs+tRdbOAa9J3eKuVw@mail.gmail.com>
 <31cac0c1-98e4-c70e-e156-51a70813beff@arm.com>
 <20191008141642.GQ2294@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <b4e29e48-a97c-67e5-a284-6ddc13222c5b@arm.com>
Date:   Tue, 8 Oct 2019 15:34:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008141642.GQ2294@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2019 15:16, Peter Zijlstra wrote:
> On Wed, Oct 02, 2019 at 11:47:59AM +0100, Valentin Schneider wrote:
> 
>> Yeah, right shift on signed negative values are implementation defined.
> 
> Seriously? Even under -fno-strict-overflow? There is a perfectly
> sensible operation for signed shift right, this stuff should not be
> undefined.
> 

Mmm good point. I didn't see anything relevant in the description of that
flag. All my copy of the C99 standard (draft) says at 6.5.7.5 is:

"""
The result of E1 >> E2 [...] If E1 has a signed type and a negative value,
the resulting value is implementation-defined.
"""

Arithmetic shift would make sense, but I think this stems from twos'
complement not being imposed: 6.2.6.2.2 says sign can be done with
sign + magnitude, twos complement or ones' complement...

I suppose when you really just want a division you should ask for division
semantics - i.e. use '/'. I'd expect compilers to be smart enough to turn
that into a shift if a power of 2 is involved, and to do something else
if negative values can be involved.
