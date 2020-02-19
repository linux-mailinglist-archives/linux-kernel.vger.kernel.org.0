Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6BEC164652
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 15:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgBSOGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 09:06:24 -0500
Received: from outbound-smtp48.blacknight.com ([46.22.136.219]:59635 "EHLO
        outbound-smtp48.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbgBSOGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:06:23 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id CBC31FB26D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:06:21 +0000 (GMT)
Received: (qmail 17049 invoked from network); 19 Feb 2020 14:06:21 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Feb 2020 14:06:21 -0000
Date:   Wed, 19 Feb 2020 14:06:19 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v4
Message-ID: <20200219140619.GQ3466@techsingularity.net>
References: <20200219135442.18107-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200219135442.18107-1-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:54:29PM +0000, Mel Gorman wrote:
> This is V4 which includes the latest versions of Vincent's patch
> addressing review feedback. Patches 4-8 are Vincent's work plus one
> important performance fix. They can be merged in isolation even if the
> remaining patches are rejected for whatever reason.
> 

And I managed to send the wrong version, this is wrong.

-- 
Mel Gorman
SUSE Labs
