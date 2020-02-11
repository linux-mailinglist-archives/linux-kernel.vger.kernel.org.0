Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEEC159149
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 15:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgBKOAc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Feb 2020 09:00:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729437AbgBKOAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:00:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ED9B2086A;
        Tue, 11 Feb 2020 14:00:30 +0000 (UTC)
Date:   Tue, 11 Feb 2020 09:00:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] why can't dynamic isolation just like the static way
Message-ID: <20200211090028.4e12d02e@gandalf.local.home>
In-Reply-To: <20200211114350.GJ14914@hirez.programming.kicks-ass.net>
References: <fed10a26-7423-23b5-316c-c74d354870dd@linux.alibaba.com>
        <20200211114350.GJ14914@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020 12:43:50 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Feb 11, 2020 at 04:17:34PM +0800, 王贇 wrote:
> > Hi, folks
> > 
> > We are dealing with isolcpus these days and try to do the isolation
> > dynamically.
> > 
> > The kernel doc lead us into the cpuset.sched_load_balance, it's fine
> > to achieve the dynamic isolation with it, however we got problem with
> > the systemd stuff.  
> 
> Then don't use systemd :-) Also, if systemd is the problem, why are you
> bugging us?

[ Background. Peter is someone that doesn't even use systemd. ;-) ]

-- Steve
