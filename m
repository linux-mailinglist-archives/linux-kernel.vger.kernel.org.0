Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2108E1007A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 15:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfKROvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 09:51:38 -0500
Received: from outbound-smtp24.blacknight.com ([81.17.249.192]:53900 "EHLO
        outbound-smtp24.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726703AbfKROvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:51:38 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id D383AB880B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 14:51:36 +0000 (GMT)
Received: (qmail 3377 invoked from network); 18 Nov 2019 14:51:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Nov 2019 14:51:36 -0000
Date:   Mon, 18 Nov 2019 14:51:34 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com
Subject: Re: [PATCH v4 04/11] sched/fair: rework load_balance
Message-ID: <20191118145134.GA3016@techsingularity.net>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-5-git-send-email-vincent.guittot@linaro.org>
 <20191030154534.GJ3016@techsingularity.net>
 <20191118135017.GA123637@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20191118135017.GA123637@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 02:50:17PM +0100, Ingo Molnar wrote:
> 
> * Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > s/groupe_type/group_type/
> > 
> > >  enum group_type {
> > > -	group_other = 0,
> > > +	group_has_spare = 0,
> > > +	group_fully_busy,
> > >  	group_misfit_task,
> > > +	group_asym_packing,
> > >  	group_imbalanced,
> > > -	group_overloaded,
> > > +	group_overloaded
> > > +};
> > > +
> > 
> > While not your fault, it would be nice to comment on the meaning of each
> > group type. From a glance, it's not obvious to me why a misfit task should
> > be a high priority to move a task than a fully_busy (but not overloaded)
> > group given that moving the misfit task might make a group overloaded.
> 
> This part of your feedback should now be addressed in the scheduler tree 
> via:
> 
>   a9723389cc75: sched/fair: Add comments for group_type and balancing at SD_NUMA level
> 

While I can't see that commit ID yet, the discussed version of the patch
was fine by me.

-- 
Mel Gorman
SUSE Labs
