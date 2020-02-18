Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60B3016263F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 13:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgBRMiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 07:38:23 -0500
Received: from foss.arm.com ([217.140.110.172]:51344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbgBRMiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:38:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE056328;
        Tue, 18 Feb 2020 04:38:22 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08B1B3F6CF;
        Tue, 18 Feb 2020 04:38:20 -0800 (PST)
Subject: Re: [PATCH v2 1/5] sched/fair: Reorder enqueue/dequeue_task_fair path
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-2-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <ee38d205-b356-9474-785e-e514d81b7d7f@arm.com>
Date:   Tue, 18 Feb 2020 13:37:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214152729.6059-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2020 16:27, Vincent Guittot wrote:
> The walk through the cgroup hierarchy during the enqueue/dequeue of a task
> is split in 2 distinct parts for throttled cfs_rq without any added value
> but making code less readable.
> 
> Change the code ordering such that everything related to a cfs_rq
> (throttled or not) will be done in the same loop.
> 
> In addition, the same steps ordering is used when updating a cfs_rq:
> - update_load_avg
> - update_cfs_group
> - update *h_nr_running

Is this code change really necessary? You pay with two extra goto's. We
still have the two for_each_sched_entity(se)'s because of 'if
(se->on_rq); break;'.

[...]
