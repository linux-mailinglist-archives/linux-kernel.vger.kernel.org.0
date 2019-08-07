Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E70E84A76
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 13:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfHGLQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 07:16:51 -0400
Received: from foss.arm.com ([217.140.110.172]:46804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfHGLQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:16:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A08581570;
        Wed,  7 Aug 2019 04:16:50 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80FD03F575;
        Wed,  7 Aug 2019 04:16:49 -0700 (PDT)
Subject: Re: [PATCH v2 4/8] sched/fair: rework load_balance
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
 <1564670424-26023-5-git-send-email-vincent.guittot@linaro.org>
 <74bb33d7-3ba4-aabe-c7a2-3865d5759281@arm.com>
Message-ID: <a5388765-2392-fcfe-7a29-88f143e1025f@arm.com>
Date:   Wed, 7 Aug 2019 12:16:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <74bb33d7-3ba4-aabe-c7a2-3865d5759281@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2019 18:17, Valentin Schneider wrote:
>> @@ -8765,7 +8942,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>  	env.src_rq = busiest;
>>  
>>  	ld_moved = 0;
>> -	if (busiest->cfs.h_nr_running > 1) {
>> +	if (busiest->nr_running > 1) {
> 
> Shouldn't that stay h_nr_running ? We can't do much if those aren't CFS
> tasks.
> 

Wait, so that seems to be a correction of an over-zealous rename in patch
2/8, but I think we actually *do* want it to be a cfs.h_nr_running check
here.

And actually this made me have a think about our active balance checks,
I'm cooking something up in that regards.
