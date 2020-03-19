Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2E218BDAB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 18:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgCSRMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 13:12:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:43652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbgCSRMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:12:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 62622AD77;
        Thu, 19 Mar 2020 17:12:11 +0000 (UTC)
Date:   Thu, 19 Mar 2020 17:12:07 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Tao Zhou <ouwen210@hotmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        hdanton@sina.com, t1zhou@163.com
Subject: Re: [PATCH] sched/fair: fix condition of avg_load calculation
Message-ID: <20200319171207.GJ3772@suse.de>
References: <BL0PR14MB3779226ECE6B526471FA91FD9AF40@BL0PR14MB3779.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <BL0PR14MB3779226ECE6B526471FA91FD9AF40@BL0PR14MB3779.namprd14.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 11:39:20AM +0800, Tao Zhou wrote:
> In update_sg_wakeup_stats(), the comment says:
> 
> Computing avg_load makes sense only when group is fully
> busy or overloaded.
> 
> But, the code below this comment does not check like this.
> 
> From reading the code about avg_load in other functions, I
> confirm that avg_load should be calculated in fully busy or
> overloaded case. The comment is correct and the checking
> condition is wrong. So, change that condition.
> 
> Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
> Signed-off-by: Tao Zhou <ouwen210@hotmail.com>


Actual impact is variable, some machines for stressed overload benefit
but it's not universal. That is somewhat expected given that the heavily
overloaded case is tricky at the best of times. For tbench ramping up
load, it's also not universally beneficial but some machines heavily
benefit. Despite the range of results that are machine-dependant, the
patch looks correct so;

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
