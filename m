Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B6CC0732
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 16:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfI0OWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 10:22:06 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:32982 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726926AbfI0OWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:22:05 -0400
Received: (qmail 2591 invoked by uid 2102); 27 Sep 2019 10:22:04 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Sep 2019 10:22:04 -0400
Date:   Fri, 27 Sep 2019 10:22:04 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrea Parri <parri.andrea@gmail.com>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Documentation for plain accesses and data races
In-Reply-To: <20190927085905.GA11454@andrea>
Message-ID: <Pine.LNX.4.44L0.1909271021130.1698-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2019, Andrea Parri wrote:

> On Fri, Sep 06, 2019 at 02:11:29PM -0400, Alan Stern wrote:
> > Folks:
> > 
> > I have spent some time writing up a section for 
> > tools/memory-model/Documentation/explanation.txt on plain accesses and 
> > data races.  The initial version is below.
> > 
> > I'm afraid it's rather long and perhaps gets too bogged down in 
> > complexities.  On the other hand, this is a complicated topic so to 
> > some extent this is unavoidable.
> > 
> > In any case, I'd like to hear your comments and reviews.
> 
> Thank you for writing this up, Alan, and sorry for the delayed reply.
> 
> The section looks great to me, and I have no further suggestions besides
> the minor fixes which have been already pointed out in the thread.
> 
> Looking forward to your v2 (an actual patch),

Thanks for the review.  I'll post the patch (together with a couple of 
other changes) in a week or so.

Alan

