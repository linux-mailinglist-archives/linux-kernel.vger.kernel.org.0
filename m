Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE3B6171B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 15:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbgB0OBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 09:01:06 -0500
Received: from outbound-smtp14.blacknight.com ([46.22.139.231]:53101 "EHLO
        outbound-smtp14.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732636AbgB0OBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:01:03 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 264941C3594
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 14:01:00 +0000 (GMT)
Received: (qmail 13599 invoked from network); 27 Feb 2020 14:00:59 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Feb 2020 14:00:59 -0000
Date:   Thu, 27 Feb 2020 14:00:57 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] sched/fair: Fix kernel build warning in
 test_idle_cores() for !SMT NUMA
Message-ID: <20200227140057.GG3818@techsingularity.net>
References: <20200227110053.2514-1-lukasz.luba@arm.com>
 <d2e0fe2d-5891-a2bf-a4c5-2a1f14754c1d@arm.com>
 <74d75844-e710-6df8-30a9-acd440394c2e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <74d75844-e710-6df8-30a9-acd440394c2e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 12:08:46PM +0000, Lukasz Luba wrote:
> Hi Valentin,
> 
> On 2/27/20 11:04 AM, Valentin Schneider wrote:
> > Hi Lukasz,
> > 
> > On 2/27/20 11:00 AM, Lukasz Luba wrote:
> > > Fix kernel build warning in kernel/sched/fair.c when CONFIG_SCHED_SMT is
> > > not set and CONFIG_NUMA_BALANCING is set.
> > > 
> > > kernel/sched/fair.c:1524:20: warning: ???test_idle_cores??? declared ???static??? but never defined [-Wunused-function]
> > > 
> > 
> > I've sent a similar fix yesterday at:
> > 
> > https://lore.kernel.org/lkml/20200226121244.7524-1-valentin.schneider@arm.com/
> > 
> 
> I've missed it. You are referring in the commit message to wrong change
> (probably HEAD of that branch), while when you try to bisect, it
> will point you to
> ff7db0bf24db sched/numa: Prefer using an idle CPU as a migration target
> instead of comparing tasks
> 
> I think Mel can simply resend the patches with correct build if Ingo
> is OK.
> 
> If Mel would decide to go with extended approach of ifdefs, then maybe
> it's also good to put in there  numa_idle_core(), which actually uses
> these test_idle_cores() and is_core_idle()
> 

I preferred the first fix. I'll send just it on with an editted changelog
to identify the exact patch that caused the problem. Ingo will hopefully
let me know if he prefers to pick up the fix on top or a resend of the
series with the fix folded in.

-- 
Mel Gorman
SUSE Labs
