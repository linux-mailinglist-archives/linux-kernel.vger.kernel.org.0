Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFF31288D9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Dec 2019 12:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfLULZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Dec 2019 06:25:09 -0500
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:45289 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbfLULZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 06:25:09 -0500
Received: from mail.blacknight.com (unknown [81.17.254.11])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id DF7B4FD6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 11:25:05 +0000 (GMT)
Received: (qmail 25230 invoked from network); 21 Dec 2019 11:25:05 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Dec 2019 11:25:05 -0000
Date:   Sat, 21 Dec 2019 11:25:03 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
Message-ID: <20191221112503.GN3178@techsingularity.net>
References: <20191220084252.GL3178@techsingularity.net>
 <d44ae0ff-3bd7-fab1-66d0-71769c078918@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <d44ae0ff-3bd7-fab1-66d0-71769c078918@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 12:40:02PM +0000, Valentin Schneider wrote:
> > +			 * it is not exactly half as imbalance_adj must be
> > +			 * accounted for or the two domains do not converge
> > +			 * as equally balanced if the number of busy tasks is
> > +			 * roughly the size of one NUMA domain.
> > +			 */
> > +			imbalance_max = (busiest->group_weight >> 1) + imbalance_adj;
> > +			if (env->imbalance <= imbalance_adj &&
> 
> I'm confused now, have we set env->imbalance to anything at this point? AIUI
> Vincent's suggestion was to hinge this purely on the weight vs idle_cpus /
> nr_running, IOW not use imbalance:
> 
> if (sd->flags & SD_NUMA) {                                                                         
> 	imbalance_adj = max(2U, (busiest->group_weight *                                           
> 				 (env->sd->imbalance_pct - 100) / 100) >> 1);                      
> 	imbalance_max = (busiest->group_weight >> 1) + imbalance_adj;                              
>                                                                                                      
> 	if (busiest->idle_cpus >= imbalance_max) {                                                 
> 		env->imbalance = 0;                                                                
> 		return;                                                                            
> 	}                                                                                          
> }                                                                                                  
>        

Ok, I tried this just in case and it does not work out when the number
of CPUs per NUMA node gets very large. It allows very large imbalances
between the number of CPUs calculated based on imbalance_pct and based on
group_weight >> 1 and caused some very large regressions on a modern AMD
machine. The version I had that calculated an imbalance first and decided
whether to ignore it still has been consistently the best approach across
multiple machines and workloads.

-- 
Mel Gorman
SUSE Labs
