Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD4713D82D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 11:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgAPKsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 05:48:55 -0500
Received: from foss.arm.com ([217.140.110.172]:47798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgAPKsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:48:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0EAF31B;
        Thu, 16 Jan 2020 02:48:54 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9E173F534;
        Thu, 16 Jan 2020 02:48:53 -0800 (PST)
Subject: Re: [PATCH] sched/topology: Assert non-NUMA topology masks don't
 (partially) overlap
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        prime.zeng@hisilicon.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, mingo@kernel.org
References: <20200115160915.22575-1-valentin.schneider@arm.com>
 <20200116104428.GP2827@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <51417b97-c5c9-c0b7-d7c8-5e850acbf984@arm.com>
Date:   Thu, 16 Jan 2020 10:48:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200116104428.GP2827@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/01/2020 10:44, Peter Zijlstra wrote:
> On Wed, Jan 15, 2020 at 04:09:15PM +0000, Valentin Schneider wrote:
>> A "less intrusive" alternative is to assert the sd->groups list doesn't get
>> re-written, which is a symptom of such bogus topologies. I've briefly
>> tested this, you can have a look at it here:
>>
>>   http://www.linux-arm.org/git?p=linux-vs.git;a=commit;h=e0ead72137332cbd3d69c9055ab29e6ffae5b37b
> 
> Something like that might still make sense. Can't never be too careful,
> right ;-)
> 

True. I'll ponder about it and see if I can't make it a bit neater

