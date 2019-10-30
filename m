Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65F49EA0AB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 16:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfJ3P6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 11:58:35 -0400
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:51993 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728578AbfJ3P6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:58:32 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id ABD2F9871D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 15:58:30 +0000 (GMT)
Received: (qmail 2809 invoked from network); 30 Oct 2019 15:58:30 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Oct 2019 15:58:30 -0000
Date:   Wed, 30 Oct 2019 15:58:29 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com
Subject: Re: [PATCH v4 06/11] sched/fair: use load instead of runnable load
 in load_balance
Message-ID: <20191030155829.GL3016@techsingularity.net>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-7-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1571405198-27570-7-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 03:26:33PM +0200, Vincent Guittot wrote:
> runnable load has been introduced to take into account the case
> where blocked load biases the load balance decision which was selecting
> underutilized group with huge blocked load whereas other groups were
> overloaded.
> 
> The load is now only used when groups are overloaded. In this case,
> it's worth being conservative and taking into account the sleeping
> tasks that might wakeup on the cpu.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Hmm.... ok. Superficially I get what you're doing but worry slightly
about groups that have lots of tasks that are frequently idling on short
periods of IO.

Unfortuntely when I queued this series for testing I did not queue a load
that idles rapidly for short durations that would highlight problems in
that area.

I cannot convince myself it's ok enough for an ack but I have no reason
to complain either.

-- 
Mel Gorman
SUSE Labs
