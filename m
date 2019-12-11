Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01CCE11B939
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 17:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfLKQxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 11:53:24 -0500
Received: from foss.arm.com ([217.140.110.172]:39086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730058AbfLKQxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:53:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06AEC30E;
        Wed, 11 Dec 2019 08:53:24 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 579783F52E;
        Wed, 11 Dec 2019 08:53:23 -0800 (PST)
Subject: Re: [RFC PATCH 4/7] sched/fair: Dissociate wakeup decisions from SD
 flag value
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
References: <20191211164401.5013-1-valentin.schneider@arm.com>
 <20191211164401.5013-5-valentin.schneider@arm.com>
Message-ID: <26381004-06f5-a006-1e30-49e5e3d4f8d8@arm.com>
Date:   Wed, 11 Dec 2019 16:53:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191211164401.5013-5-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2019 16:43, Valentin Schneider wrote:
> @@ -6396,9 +6396,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  	if (unlikely(sd)) {
>  		/* Slow path */
>  		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
> -	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
> +	} else if (wake_flags & WF_TTWU) { /* XXX always ? */

While I'm at it, Dietmar pointed out to me that this is only really
relevant to forkees and execees when a NULL domain is attached to the CPU
(since sd_init() unconditionally sets SD_BALANCE_{FORK, EXEC}). So this
only makes a difference when the SD hierarchy hasn't been built / is being
rebuilt, or when cpusets are involved.

So perhaps we could make that an unconditional else, or make forkees/execees
bail out earlier.

>  		/* Fast path */
> -
>  		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
>  
>  		if (want_affine)
> 
