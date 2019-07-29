Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB4B178DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 16:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfG2O2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 10:28:48 -0400
Received: from foss.arm.com ([217.140.110.172]:45084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfG2O2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:28:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0306A28;
        Mon, 29 Jul 2019 07:28:48 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB0C13F71F;
        Mon, 29 Jul 2019 07:28:46 -0700 (PDT)
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Phil Auld <pauld@redhat.com>
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
 <d55f906e-6e91-9f49-5c2c-7ec2e6bd68b0@arm.com>
 <CAKfTPtD2hDxnHSaa5C_Jrtabb_ogJSgkLE=5UPyystKZqUmzWA@mail.gmail.com>
 <4d3a67f5-c9c4-6397-7405-6f0efbd49d5c@arm.com>
 <CAKfTPtBE5fzycHk33rf7Bky-tYSeCXaKd9oGR5cgaghzbL2TvA@mail.gmail.com>
 <aff49e6a-b4d3-baae-9124-3d5bb5abdbfe@arm.com>
 <CAKfTPtBTH10k56s-sU3TX+vL6Xas-QArLW-CBz7ZeqU0BNzMQA@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <58f79135-4b6c-2507-3f5d-e3c7704bf8b3@arm.com>
Date:   Mon, 29 Jul 2019 15:28:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBTH10k56s-sU3TX+vL6Xas-QArLW-CBz7ZeqU0BNzMQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2019 15:47, Vincent Guittot wrote:
[...]
>> If CPU0 runs the load balancer, balancing utilization would mean pulling
>> 2 tasks from CPU1 to reach the domain-average of 40%. The good side of this
>> is that we could save ourselves from running some newidle balances, but
>> I'll admit that's all quite "finger in the air".
> 
> Don't forget that scheduler also selects a cpu when task wakeup and
> should cope with such situation
> 

Right, although I'm not sure even the slow wakeup path is any good at
balancing utilization.

>>
>>>> happen, but it'd be a shame to repeatedly do this when we could
>>>> preemptively balance utilization.
>>>>
