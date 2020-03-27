Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5C19568E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 12:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgC0LsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 07:48:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:52594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgC0LsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 07:48:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A1E52AB7F;
        Fri, 27 Mar 2020 11:48:05 +0000 (UTC)
Date:   Fri, 27 Mar 2020 11:48:01 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com,
        vpillai@digitalocean.com, joel@joelfernandes.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH] sched/fair: Fix negative imbalance in imbalance
 calculation
Message-ID: <20200327114801.GL3772@suse.de>
References: <1585201349-70192-1-git-send-email-aubrey.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1585201349-70192-1-git-send-email-aubrey.li@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 01:42:29PM +0800, Aubrey Li wrote:
> A negative imbalance value was observed after imbalance calculation,
> this happens when the local sched group type is group_fully_busy,
> and the average load of local group is greater than the selected
> busiest group. Fix this problem by comparing the average load of the
> local and busiest group before imbalance calculation formula.
> 
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Phil Auld <pauld@redhat.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
