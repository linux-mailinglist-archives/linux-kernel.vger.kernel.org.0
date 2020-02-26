Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB5A1701ED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 16:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgBZPH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 10:07:27 -0500
Received: from outbound-smtp61.blacknight.com ([46.22.136.249]:52239 "EHLO
        outbound-smtp61.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbgBZPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:07:27 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp61.blacknight.com (Postfix) with ESMTPS id 28343FA7C4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 15:07:25 +0000 (GMT)
Received: (qmail 21281 invoked from network); 26 Feb 2020 15:07:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Feb 2020 15:07:25 -0000
Date:   Wed, 26 Feb 2020 15:07:23 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] sched/fair: Fix unused prototype warning
Message-ID: <20200226150723.GD3818@techsingularity.net>
References: <20200226121244.7524-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200226121244.7524-1-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 12:12:44PM +0000, Valentin Schneider wrote:
> Building against the latest tip/sched/core
> 
>   a0f03b617c3b ("sched/numa: Stop an exhastive search if a reasonable swap candidate or idle CPU is found")
> 
> with the arm64 defconfig (which doesn't have CONFIG_SCHED_SMT set) leads
> to:
> 
>   kernel/sched/fair.c:1525:20: warning: ???test_idle_cores??? declared ???static??? but never defined [-Wunused-function]
>    static inline bool test_idle_cores(int cpu, bool def);
> 		      ^~~~~~~~~~~~~~~
> 
> Rather than define it in its own CONFIG_SCHED_SMT #define island, bunch it
> up with test_idle_cores().
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

Ingo, what is your preferred method for dealing with this situation
in tip? A resubmission of "sched/numa: Stop an exhastive search if a
reasonable swap candidate or idle CPU is found" with these folded together
or Valentin's patch on top?

-- 
Mel Gorman
SUSE Labs
