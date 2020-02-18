Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE421162CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 18:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgBRR2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 12:28:32 -0500
Received: from foss.arm.com ([217.140.110.172]:56826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgBRR2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:28:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2720C31B;
        Tue, 18 Feb 2020 09:28:32 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD0303F703;
        Tue, 18 Feb 2020 09:28:30 -0800 (PST)
Date:   Tue, 18 Feb 2020 17:28:28 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/rt: cpupri_find: implement fallback mechanism
 for !fit case
Message-ID: <20200218172827.pocmzwsrrkr5bdn5@e107158-lin.cambridge.arm.com>
References: <20200214163949.27850-1-qais.yousef@arm.com>
 <20200214163949.27850-2-qais.yousef@arm.com>
 <c0772fca-0a4b-c88d-fdf2-5715fcf8447b@arm.com>
 <20200217234549.rpv3ns7bd7l6twqu@e107158-lin>
 <50eee4ae-a733-d8e4-9f57-ab05678545fc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50eee4ae-a733-d8e4-9f57-ab05678545fc@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/20 10:53, Dietmar Eggemann wrote:
> On 18/02/2020 00:45, Qais Yousef wrote:
> > +       /*
> > +        * Help cpupri_find avoid the cost of looking for a fitting CPU when
> > +        * not really needed.
> > +        */
> 
> In case the commend is really needed, for me it would work better
> logically inverse.

Sure.

Thanks

--
Qais Yousef
