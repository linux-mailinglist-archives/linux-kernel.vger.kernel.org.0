Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D030D337A5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 20:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfFCSPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 14:15:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58502 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfFCSPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:15:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7078780D;
        Mon,  3 Jun 2019 11:15:13 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A531A3F5AF;
        Mon,  3 Jun 2019 11:15:12 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: clean up asym packing
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
References: <1559571064-28087-1-git-send-email-vincent.guitto@linaro.org>
 <1559571436-29091-1-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <7280a3b0-0727-f365-4453-8b4b01a64559@arm.com>
Date:   Mon, 3 Jun 2019 19:15:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559571436-29091-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/06/2019 15:17, Vincent Guittot wrote:
> Clean up asym packing to follow the default load balance behavior:
> - classify the group by creating a group_asym_capacity field.

Being nitpicky here, this doesn't classify the group in the usual way
- it doesn't get a specific group_type value (group_classify()). So maybe
"classify" isn't the best term here.

Also, why tag this group in update_sd_pick_busiest()? It would make more
sense to do so in update_sg_lb_stats() like with the other sg_lb_stats fields:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 93c24473c8a0..537710026c3a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8298,6 +8298,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
                }
        }
 
+       if (sgs->sum_nr_running &&
+           sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu))
+               sgs->group_asym_capacity = 1;
+
        /* Adjust by relative CPU capacity of the group */
        sgs->group_capacity = group->sgc->capacity;
        sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
@@ -8391,9 +8395,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
         * perform better since they share less core resources.  Hence when we
         * have idle threads, we want them to be the higher ones.
         */
-       if (sgs->sum_nr_running &&
-           sched_asym_prefer(env->dst_cpu, sg->asym_prefer_cpu)) {
-               sgs->group_asym_capacity = 1;
+       if (sgs->group_asym_capacity) {
                if (!sds->busiest)
                        return true;
 
