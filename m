Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 560F513AC09
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 15:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgANOQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 09:16:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:33398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgANOQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:16:11 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 479FE2467A;
        Tue, 14 Jan 2020 14:16:10 +0000 (UTC)
Date:   Tue, 14 Jan 2020 09:16:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hewenliang <hewenliang4@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] idle: fix spelling mistake "iterrupts" -> "interrupts"
Message-ID: <20200114091608.6719edab@gandalf.local.home>
In-Reply-To: <20200114100224.GC2844@hirez.programming.kicks-ass.net>
References: <20200110025604.34373-1-hewenliang4@huawei.com>
        <20200113160413.5afcfbd7@gandalf.local.home>
        <20200114100224.GC2844@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 11:02:24 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jan 13, 2020 at 04:04:13PM -0500, Steven Rostedt wrote:
> > 
> > Peter,
> > 
> > I guess you could just pull this into one of your queues.  
> 
> Only because you replied, otherwise I tend to ignore such patches.

I figured you do, that's why I replied ;-)

We don't want misspellings to distract code reviewers from the code do
we? :-)

-- Steve
