Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E2766969
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfGLIzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 04:55:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60688 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfGLIzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x8WbIHFyv0ABBFcrHAzlMJIMfoT3LVqQH9+jbFhqNOk=; b=pAshXTbk8185R9diOLyIbCIL9
        JbNJ9pCeEAgagt55CojO1I8wE+7O9I6TanWMhj4EFNHc2jKM4eDy1W8LUxF4Dmiz4ddGYycbQPTPL
        RK4c5ge932bvIH+gvxt3NKbodqAv12cCai89jnXSZunX5oilhHFcESRKq+U79IvM1ELtchT6jLiFj
        mH3EAONPGzd4ePD5Fl378KNIdbb9aFAhofWHhaYk1f6BBt6CF/vKd5Uo1Em+JLCsWIe5g8xga3Som
        qBkDPQacDtIhtiG11UrHgxrM/RLtrgUNMjcjUJ6VCEZnK+W3VX8UCRtwSNdNcepB/z8ISQm3tejnp
        GDv6AIdqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlrL9-0003mf-9v; Fri, 12 Jul 2019 08:55:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CBD920120CB1; Fri, 12 Jul 2019 10:55:36 +0200 (CEST)
Date:   Fri, 12 Jul 2019 10:55:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
Message-ID: <20190712085536.GP3402@hirez.programming.kicks-ass.net>
References: <20190710172123.GC801@sol.localdomain>
 <f498d8cc-ba82-d3dc-7557-142a1b35976a@acm.org>
 <20190710180242.GA193819@gmail.com>
 <a19779d0-0192-8dc0-d51b-e6938a455f31@acm.org>
 <47a9287d-1f02-95d5-a5cf-55f0c0d38378@gmail.com>
 <cdfeb3f8-8dc5-aa60-2782-7b3c5110edf5@acm.org>
 <ee3bac8d-d061-7d07-5990-59871e7e2a4b@gmail.com>
 <9219c421-0868-f97f-2d84-df48aed9f8a8@acm.org>
 <20190710220943.GM3419@hirez.programming.kicks-ass.net>
 <e10e95c7-b832-5560-e3ca-3ce584bc0ca3@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e10e95c7-b832-5560-e3ca-3ce584bc0ca3@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 11:53:12AM -0700, Bart Van Assche wrote:
> On 7/10/19 3:09 PM, Peter Zijlstra wrote:
> > One thing I mentioned when Thomas did the unwinder API changes was
> > trying to move lockdep over to something like stackdepot.
> > 
> > We can't directly use stackdepot as is, because it uses locks and memory
> > allocation, but we could maybe add a lower level API to it and use that
> > under the graph_lock() on static storage or something.
> > 
> > Otherwise we'll have to (re)implement something like it.
> > 
> > I've not looked at it in detail.
> 
> Hi Peter,
> 
> Is something like the untested patch below perhaps what you had in mind?

Most excellent, yes! Now I suppose the $64000 question is if it actually
reduces the amount of storage we use for stack traces..

Seems to boot just fine.. :-)
