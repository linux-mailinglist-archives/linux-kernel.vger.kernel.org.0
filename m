Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D875F13161D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 17:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgAFQdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 11:33:08 -0500
Received: from outbound-smtp35.blacknight.com ([46.22.139.218]:57440 "EHLO
        outbound-smtp35.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbgAFQdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:33:08 -0500
Received: from mail.blacknight.com (unknown [81.17.254.16])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 5150B18FA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jan 2020 16:33:06 +0000 (GMT)
Received: (qmail 12915 invoked from network); 6 Jan 2020 16:33:06 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Jan 2020 16:33:06 -0000
Date:   Mon, 6 Jan 2020 16:33:03 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Rik van Riel <riel@surriel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        valentin.schneider@arm.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com, parth@linux.ibm.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v3
Message-ID: <20200106163303.GC3466@techsingularity.net>
References: <20200106144250.GA3466@techsingularity.net>
 <04033a63f11a9c59ebd2b099355915e4e889b772.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <04033a63f11a9c59ebd2b099355915e4e889b772.camel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 10:47:18AM -0500, Rik van Riel wrote:
> > +			imbalance_adj = (100 / (env->sd->imbalance_pct
> > - 100)) - 1;
> > +
> > +			/*
> > +			 * Allow small imbalances when the busiest
> > group has
> > +			 * low utilisation.
> > +			 */
> > +			imbalance_max = imbalance_adj << 1;
> > +			if (busiest->sum_nr_running < imbalance_max)
> > +				env->imbalance -= min(env->imbalance,
> > imbalance_adj);
> > +		}
> > +
> 
> Wait, so imbalance_max is a function only of
> env->sd->imbalance_pct, and it gets compared
> against busiest->sum_nr_running, which is related
> to the number of CPUs in the node?
> 

It's not directly related to the number of CPUs in the node. Are you
thinking of busiest->group_weight?

-- 
Mel Gorman
SUSE Labs
