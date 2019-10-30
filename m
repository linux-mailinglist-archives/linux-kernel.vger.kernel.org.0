Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 118D0E9DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 15:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfJ3OxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 10:53:18 -0400
Received: from outbound-smtp39.blacknight.com ([46.22.139.222]:55350 "EHLO
        outbound-smtp39.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbfJ3OxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:53:18 -0400
Received: from mail.blacknight.com (unknown [81.17.254.10])
        by outbound-smtp39.blacknight.com (Postfix) with ESMTPS id D8B79ECD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 14:53:15 +0000 (GMT)
Received: (qmail 27271 invoked from network); 30 Oct 2019 14:53:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Oct 2019 14:53:15 -0000
Date:   Wed, 30 Oct 2019 14:53:13 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com
Subject: Re: [PATCH v4 02/11] sched/fair: rename sum_nr_running to
 sum_h_nr_running
Message-ID: <20191030145313.GI3016@techsingularity.net>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-3-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1571405198-27570-3-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 03:26:29PM +0200, Vincent Guittot wrote:
> Rename sum_nr_running to sum_h_nr_running because it effectively tracks
> cfs->h_nr_running so we can use sum_nr_running to track rq->nr_running
> when needed.
> 
> There is no functional changes.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Acked-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
