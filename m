Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3879EE8E7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 20:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfKDTpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 14:45:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbfKDTpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:45:33 -0500
Received: from paulmck-ThinkPad-P72.home (28.234-255-62.static.virginmediabusiness.co.uk [62.255.234.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC90F206BA;
        Mon,  4 Nov 2019 19:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572896731;
        bh=zShf6R9bX9F6o40dOZzi8/vpAucOB2J9IcRU7OUWPhY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lKuUkqRwSn7RPYMEuJbp4Xd1bFnsY3NbliJtHq+BNCUTYhoh8GFLg5Bqcbr1I7xbQ
         lwaqAr8VLqRQ8wGHmXqm2icU1CYw73ENQv29ewS0dFCDaqTXtB/luAoluvBJxurX+Y
         9N4uj6OezOaxfszRlyYCtL3OwwjiyeoB2/OQ7up4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 389793520B56; Mon,  4 Nov 2019 11:45:28 -0800 (PST)
Date:   Mon, 4 Nov 2019 11:45:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] Documentation: RCU: whatisRCU: Fix formatting for
 section 2
Message-ID: <20191104194528.GJ20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191104133315.GA14499@workstation-kernel-dev>
 <20191104150328.GZ20975@paulmck-ThinkPad-P72>
 <20191104171641.GA15217@workstation-kernel-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104171641.GA15217@workstation-kernel-dev>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 10:46:41PM +0530, Amol Grover wrote:
> On Mon, Nov 04, 2019 at 07:03:28AM -0800, Paul E. McKenney wrote:
> > On Mon, Nov 04, 2019 at 07:03:15PM +0530, Amol Grover wrote:
> > > Convert RCU API method text to sub-headings and
> > > add hyperlink and superscript to 2 literary notes
> > > under rcu_dereference() section
> > > 
> > > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > 
> > Good stuff, but Phong Tran beat you to it.  If you are suggesting
> > changes to that patch, please send a reply to her email, which
> > may be found here:
> > 
> > https://lore.kernel.org/lkml/20191030233128.14997-1-tranmanphong@gmail.com/
> > 
> > There are several options for replying to this email listed at the
> > bottom of that web page.
> 
> Thank you Paul! And that is correct, I was suggesting changes to
> that patch. However, since that patch was already integrated into
> the `dev` branch, I mistakenly believed this patch could be sent
> independently. Sorry for the trouble, I'll re-send the patch the
> correct way.

It is of course only polite to include the author of the previous patch
on CC, both using the "Cc: Phong Tran <tranmanphong@gmail.com>" tag
following your "Signed-off" by.

							Thanx, Paul

> Thank you
> Amol
> 
> > 
> > > ---
> > >  Documentation/RCU/whatisRCU.rst | 34 +++++++++++++++++++++++++++------
> > >  1 file changed, 28 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> > > index ae40c8bcc56c..3cf6e17d0065 100644
> > > --- a/Documentation/RCU/whatisRCU.rst
> > > +++ b/Documentation/RCU/whatisRCU.rst
> > > @@ -150,6 +150,7 @@ later.  See the kernel docbook documentation for more info, or look directly
> > >  at the function header comments.
> > >  
> > >  rcu_read_lock()
> > > +^^^^^^^^^^^^^^^
> > >  
> > >  	void rcu_read_lock(void);
> > >  
> > > @@ -164,6 +165,7 @@ rcu_read_lock()
> > >  	longer-term references to data structures.
> > >  
> > >  rcu_read_unlock()
> > > +^^^^^^^^^^^^^^^^^
> > >  
> > >  	void rcu_read_unlock(void);
> > >  
> > > @@ -172,6 +174,7 @@ rcu_read_unlock()
> > >  	read-side critical sections may be nested and/or overlapping.
> > >  
> > >  synchronize_rcu()
> > > +^^^^^^^^^^^^^^^^^
> > >  
> > >  	void synchronize_rcu(void);
> > >  
> > > @@ -225,6 +228,7 @@ synchronize_rcu()
> > >  	checklist.txt for some approaches to limiting the update rate.
> > >  
> > >  rcu_assign_pointer()
> > > +^^^^^^^^^^^^^^^^^^^^
> > >  
> > >  	void rcu_assign_pointer(p, typeof(p) v);
> > >  
> > > @@ -245,6 +249,7 @@ rcu_assign_pointer()
> > >  	the _rcu list-manipulation primitives such as list_add_rcu().
> > >  
> > >  rcu_dereference()
> > > +^^^^^^^^^^^^^^^^^
> > >  
> > >  	typeof(p) rcu_dereference(p);
> > >  
> > > @@ -279,8 +284,10 @@ rcu_dereference()
> > >  	if an update happened while in the critical section, and incur
> > >  	unnecessary overhead on Alpha CPUs.
> > >  
> > > +.. _back_to_1:
> > > +
> > >  	Note that the value returned by rcu_dereference() is valid
> > > -	only within the enclosing RCU read-side critical section [1].
> > > +	only within the enclosing RCU read-side critical section |cs_1|.
> > >  	For example, the following is -not- legal::
> > >  
> > >  		rcu_read_lock();
> > > @@ -298,15 +305,27 @@ rcu_dereference()
> > >  	it was acquired is just as illegal as doing so with normal
> > >  	locking.
> > >  
> > > +.. _back_to_2:
> > > +
> > >  	As with rcu_assign_pointer(), an important function of
> > >  	rcu_dereference() is to document which pointers are protected by
> > >  	RCU, in particular, flagging a pointer that is subject to changing
> > >  	at any time, including immediately after the rcu_dereference().
> > >  	And, again like rcu_assign_pointer(), rcu_dereference() is
> > >  	typically used indirectly, via the _rcu list-manipulation
> > > -	primitives, such as list_for_each_entry_rcu() [2].
> > > +	primitives, such as list_for_each_entry_rcu() |entry_2|.
> > > +
> > > +.. |cs_1| raw:: html
> > > +
> > > +	<a href="#cs"><sup>[1]</sup></a>
> > > +
> > > +.. |entry_2| raw:: html
> > >  
> > > -	[1] The variant rcu_dereference_protected() can be used outside
> > > +	<a href="#entry"><sup>[2]</sup></a>
> > > +
> > > +.. _cs:
> > > +
> > > +	\ :sup:`[1]`\  The variant rcu_dereference_protected() can be used outside
> > >  	of an RCU read-side critical section as long as the usage is
> > >  	protected by locks acquired by the update-side code.  This variant
> > >  	avoids the lockdep warning that would happen when using (for
> > > @@ -317,15 +336,18 @@ rcu_dereference()
> > >  	a lockdep expression to indicate which locks must be acquired
> > >  	by the caller. If the indicated protection is not provided,
> > >  	a lockdep splat is emitted.  See Documentation/RCU/Design/Requirements/Requirements.rst
> > > -	and the API's code comments for more details and example usage.
> > > +	and the API's code comments for more details and example usage. :ref:`back <back_to_1>`
> > > +
> > > +
> > > +.. _entry:
> > >  
> > > -	[2] If the list_for_each_entry_rcu() instance might be used by
> > > +	\ :sup:`[2]`\  If the list_for_each_entry_rcu() instance might be used by
> > >  	update-side code as well as by RCU readers, then an additional
> > >  	lockdep expression can be added to its list of arguments.
> > >  	For example, given an additional "lock_is_held(&mylock)" argument,
> > >  	the RCU lockdep code would complain only if this instance was
> > >  	invoked outside of an RCU read-side critical section and without
> > > -	the protection of mylock.
> > > +	the protection of mylock. :ref:`back <back_to_2>`
> > >  
> > >  The following diagram shows how each API communicates among the
> > >  reader, updater, and reclaimer.
> > > -- 
> > > 2.20.1
> > > 
