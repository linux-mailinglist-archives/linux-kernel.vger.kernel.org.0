Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39C9718B160
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 11:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCSK3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 06:29:38 -0400
Received: from foss.arm.com ([217.140.110.172]:33030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgCSK3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:29:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BF7D31B;
        Thu, 19 Mar 2020 03:29:37 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 719903F305;
        Thu, 19 Mar 2020 03:29:36 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 4/9] sched/topology: Kill SD_LOAD_BALANCE
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
References: <20200311181601.18314-1-valentin.schneider@arm.com>
 <20200311181601.18314-5-valentin.schneider@arm.com>
Message-ID: <a4a87ce6-9770-dc58-c2b6-e001b8050a8e@arm.com>
Date:   Thu, 19 Mar 2020 11:29:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311181601.18314-5-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.20 19:15, Valentin Schneider wrote:
> That flag is set unconditionally in sd_init(), and no one checks for it
> anymore. Remove it.

Why not merge 3/9 and 4/9 ?

[...]

> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index f341163fedc9..8de2f9744569 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -11,21 +11,20 @@
>   */
>  #ifdef CONFIG_SMP
>  
> -#define SD_LOAD_BALANCE		0x0001	/* Do load balancing on this domain. */
> -#define SD_BALANCE_NEWIDLE	0x0002	/* Balance when about to become idle */

[...]

> -#define SD_OVERLAP		0x2000	/* sched_domains of this level overlap */
> -#define SD_NUMA			0x4000	/* cross-node balancing */
> +#define SD_BALANCE_NEWIDLE	0x0001	/* Balance when about to become idle */

IMHO, changing the values of the remaining SD flags will break lots of
userspace scripts.

[...]
