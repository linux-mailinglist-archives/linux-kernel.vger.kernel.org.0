Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD5D51328B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 18:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfECQwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 12:52:41 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:58706 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728417AbfECQwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:52:40 -0400
Received: (qmail 5909 invoked by uid 2102); 3 May 2019 12:52:39 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 May 2019 12:52:39 -0400
Date:   Fri, 3 May 2019 12:52:39 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Peter Zijlstra <peterz@infradead.org>
cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>
Subject: Re: f68f031d ("Documentation: atomic_t.txt: Explain ordering provided
 by smp_mb__{before,after}_atomic()")
In-Reply-To: <20190503163411.GH2606@hirez.programming.kicks-ass.net>
Message-ID: <Pine.LNX.4.44L0.1905031252060.1437-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2019, Peter Zijlstra wrote:

> On Fri, May 03, 2019 at 12:19:21PM -0400, Alan Stern wrote:
> > On Fri, 3 May 2019, Peter Zijlstra wrote:
> > 
> > > On Fri, May 03, 2019 at 07:53:26AM -0700, Paul E. McKenney wrote:
> > > > Hello, Alan,
> > > > 
> > > > Just following up on the -rcu commit below.  I believe that it needs
> > > > some adjustment given Peter Zijlstra's addition of "memory" to the x86
> > > > non-value-returning atomics, but thought I should double-check.
> > > 
> > > Right; I should get back to that thread...
> > 
> > The real question, still outstanding, is whether smp_mb__before_atomic 
> > orders anything following the RMW instruction (and similarly, whether 
> > smp_mb__after_atomic orders anything preceding the RMW instruction).
> 
> Yes -- that was very much the intent, and only (some) x86 ops and (some)
> MIPS config have issues with that.

Okay, then I better update the patch.

Alan

