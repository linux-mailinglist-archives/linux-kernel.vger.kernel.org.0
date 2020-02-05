Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7861531D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 14:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgBEN3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 08:29:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbgBEN3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:29:20 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FB7F2072B;
        Wed,  5 Feb 2020 13:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580909360;
        bh=q3GH23a1FDWaFVRhUTNliOpuwo1wF6ZsFejI9M8tSQ0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ofwCmh1sIX/qbPu2BPDWAM8+n1bBJRtfpk57yQ5E3gpnTb1ouvryIAWv1mX68b7+V
         asnILCtTNG4d18fkKGdPX0/wEEH9JMoUTOeLLVzuWrJ4NExqkhMf2bNqoCf0SNipV1
         0qXXPXGEiLt76+qPSL7164BVlu3fifDR8dPG4HNc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D16FD35227F3; Wed,  5 Feb 2020 05:29:19 -0800 (PST)
Date:   Wed, 5 Feb 2020 05:29:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Amol Grover <frextrite@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: Re: [PATCH] tracing: Annotate ftrace_graph_hash pointer with __rcu
Message-ID: <20200205132919.GU2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200201072703.17330-1-frextrite@gmail.com>
 <20200203163301.GB85781@google.com>
 <20200204200116.479f0c60@oasis.local.home>
 <20200205131110.GT2935@paulmck-ThinkPad-P72>
 <20200205081409.4550aa67@oasis.local.home>
 <20200205081921.34b19d9a@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205081921.34b19d9a@oasis.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 08:19:21AM -0500, Steven Rostedt wrote:
> On Wed, 5 Feb 2020 08:14:09 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 5 Feb 2020 05:11:10 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > I strongly recommend a comment stating why disabling preemption prevents
> > > ftrace_graph_hash from going away.  I see the synchronize_rcu() after
> > > the rcu_assign_pointer() in ftrace_graph_release(), but I don't see
> > > anything that waits on CPUs that RCU is not watching.
> > > 
> > > Of course, event tracing -makes- RCU watch when needed, but if that
> > > was set up, then lockdep would not have complained.
> > > 
> > > So what am I missing?  
> > 
> > Keep looking in your INBOX and look at the patch I asked you to ack or
> > complain about ;-) 

Not yet seeing it, but...

> Actually, looking at the code myself, it appears to be missing the
> ftrace_sync. Thus, this is a bug, and requires the ftrace sync, as
> synchronize_rcu() is not strong enough here.
> 
> Patch in process!

Thank you for chasing it down!

							Thanx, Paul
