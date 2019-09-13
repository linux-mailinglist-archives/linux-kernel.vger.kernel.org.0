Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D57C8B2339
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 17:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403896AbfIMPVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 11:21:19 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:53548 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2388354AbfIMPVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:21:18 -0400
Received: (qmail 3216 invoked by uid 2102); 13 Sep 2019 11:21:17 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Sep 2019 11:21:17 -0400
Date:   Fri, 13 Sep 2019 11:21:17 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Documentation for plain accesses and data races
In-Reply-To: <20190912220126.GA14560@paulmck-ThinkPad-P72>
Message-ID: <Pine.LNX.4.44L0.1909131032510.1466-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2019, Paul E. McKenney wrote:

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
> Good stuff, thank you for putting this together!
> 
> Please see below for some questions, comments, and confusion interspersed.

Thanks for looking over this.  Replies given inline below...

> > Alan
> > 
> > ------------------------------------------------------------------------
> > 
> > 
> > PLAIN ACCESSES AND DATA RACES
> > -----------------------------
> > 
> > In the LKMM, memory accesses such as READ_ONCE(x), atomic_inc(&y),
> > smp_load_acquire(&z), and so on are collectively referred to as
> > "marked" accesses, because they are all annotated with special
> > operations of one kind or another.  Ordinary C-language memory
> > accesses such as x or y = 0 are simply called "plain" accesses.
> > 
> > Early versions of the LKMM had nothing to say about plain accesses.
> > The C standard allows compilers to assume that the variables affected
> > by plain accesses are not concurrently read or written by any other
> > threads or CPUs.  This leaves compilers free to implement all manner
> > of transformations or optimizations of code containing plain accesses,
> > making such code very difficult for a memory model to handle.
> > 
> > Here is just one example of a possible pitfall:
> > 
> > 	int a = 6;
> > 	int *x = &a;
> > 
> > 	P0()
> > 	{
> > 		int *r1;
> > 		int r2 = 0;
> > 
> > 		r1 = x;
> > 		if (r1 != NULL)
> > 			r2 = READ_ONCE(*r1);
> > 	}
> > 
> > 	P1()
> > 	{
> > 		WRITE_ONCE(x, NULL);
> > 	}
> 
> I tried making a litmus test out of this:
> 
> ------------------------------------------------------------------------
> C plain-1
> 
> {
> 	int a = 6;
> 	int *x = &a;
> }
> 
> P0(int **x)
> {
> 	int *r1;
> 	int r2 = 0;
> 
> 	r1 = *x;
> 	if (r1 != 0)
> 		r2 = READ_ONCE(*r1);
> }
> 
> P1(int **x)
> {
> 	WRITE_ONCE(*x, 0);
> }
> 
> locations [a; x; r1]
> exists ~r2=6 /\ ~r2=0
> ------------------------------------------------------------------------
> 
> However, r1 steadfastly refuses to have any value other than zero.
> 
> ------------------------------------------------------------------------
> $ herd7 -conf linux-kernel.cfg /tmp/argh
> Test plain-1 Allowed
> States 1
> a=6; r1=0; r2=0; x=0;
> No
> Witnesses
> Positive: 0 Negative: 2
> Flag data-race
> Condition exists (not (r2=6) /\ not (r2=0))
> Observation plain-1 Never 0 2
> Time plain-1 0.00
> Hash=b0fdbd0f627fd65e0cd413bf87f6f4a4
> ------------------------------------------------------------------------
> 
> What am I doing wrong here?  Outdated herd7 version?

In this and all the other litmus tests below, your "exists" clauses
are wrong.  For example, here it should say:

exists ~0:r2=6 /\ ~0:r2=0

You forgot about the "0:" in front of the CPU-local variables.  
Similarly for the "locations" clause.

> $ herd7 -version
> 7.52+7(dev), Rev: c81f1ff06f30d5c28c34d893a29f5f8505334179
> 
> Hmmm...  I might well be in an inconsistent herd7/ocaml state.  If no
> one sees anything obvious, I will try reinstalling from scratch, but
> that will not likely happen in the next few days.
> 
> > On the face of it, one would expect that when this code runs, the only
> > possible final values for r2 are 6 and 0, depending on whether or not
> > P1's store to x propagates to P0 before P0's load from x executes.
> > But since P0's load from x is a plain access, the compiler may decide
> > to carry out the load twice (for the comparison against NULL, then again
> > for the READ_ONCE()) and eliminate the temporary variable r1.  The
> > object code generated for P0 could therefore end up looking rather
> > like this:
> > 
> > 	P0()
> > 	{
> > 		int r2 = 0;
> > 
> > 		if (x != NULL)
> > 			r2 = READ_ONCE(*x);
> > 	}
> > 
> > And now it is obvious that this code runs the risk of dereferencing a
> > NULL pointer, because P1's store to x might propagate to P0 after the
> > test against NULL has been made but before the READ_ONCE() executes.
> > If the original code had said "r1 = READ_ONCE(x)" instead of "r1 = x",
> > the compiler would not have performed this optimization and there
> > would be no possibility of a NULL-pointer dereference.
> > 
> > Given the possibility of transformations like this one, the LKMM
> > doesn't try to predict all possible outcomes of code containing plain
> > accesses.  It is content to determine whether the code violates the
> 
> I suggest starting this sentence with something like "It is instead
> content to determine", adding "instead", to help the reader transition.

Okay.

> > compiler's assumptions, which would render the ultimate outcome
> > undefined.
> > 
> > In technical terms, the compiler is allowed to assume that when the
> > program executes, there will not be any data races.  A "data race"
> > occurs when two conflicting memory accesses execute concurrently;
> > two memory accesses "conflict" if:
> > 
> > 	they access the same location,
> > 
> > 	they occur on different CPUs (or in different threads on the
> > 	same CPU),
> > 
> > 	at least one of them is a plain access,
> > 
> > 	and at least one of them is a store.
> > 
> > The LKMM tries to determine whether a program contains two conflicting
> > accesses which may execute concurrently; if it does then the LKMM says
> > there is a potential data race and makes no predictions about the
> > program's outcome.
> > 
> > Determining whether two accesses conflict is easy; you can see that
> > all the concepts involved in the definition above are already part of
> > the memory model.  The hard part is telling whether they may execute
> > concurrently.  The LKMM takes a conservative attitude, assuming that
> > accesses may be concurrent unless it can prove they cannot.
> > 
> > If two memory accesses aren't concurrent then one must execute before
> 
> Should this say "If two memory accesses to the same location aren't
> concurrent..."?

It could, but that doesn't seem to be necessary.  The sentence is just 
as true when talking about accesses to different locations.

Besides, if I have to add that qualifier _every_ time the document
talks about concurrent accesses, things will quickly get out of hand.

> > the other.  Therefore the LKMM decides two accesses aren't concurrent
> > if they can be connected by a sequence of hb, pb, and rb links
> > (together referred to as xb, for "executes before").  However, there
> > are two complicating factors.
> > 
> > If X is a load and X executes before a store Y, then indeed there is
> > no danger of X and Y being concurrent.  After all, Y can't have any
> > effect on the value obtained by X until the memory subsystem has
> > propagated Y from its own CPU to X's CPU, which won't happen until
> > some time after Y executes and thus after X executes.  But if X is a
> > store, then even if X executes before Y it is still possible that X
> > will propagate to Y's CPU just as Y is executing.  In such a case X
> > could very well interfere somehow with Y, and we would have to
> > consider X and Y to be concurrent.
> > 
> > Therefore when X is a store, for X and Y to be non-concurrent the LKMM
> > requires not only that X must execute before Y but also that X must
> > propagate to Y's CPU before Y executes.  (Or vice versa, of course, if
> > Y executes before X -- then Y must propagate to X's CPU before X
> > executes if Y is a store.)  This is expressed by the visibility
> > relation (vis), where X ->vis Y is defined to hold if there is an
> > intermediate event Z such that:
> 
> "if there is a marked intermediate event Z such that"?

Not really needed.  I explicitly mention elsewhere that many of the
relations defined by the LKMM, including vis, apply only to marked
accesses.

> > 	X is connected to Z by a possibly empty sequence of
> > 	cumul-fence links followed by an optional rfe link (if none of
> > 	these links are present, X and Z are the same event),
> > 
> > and either:
> > 
> > 	Z is connected to Y by a strong-fence link followed by a
> > 	possibly empty sequence of xb links,
> 
> "possibly empty sequence of xb links from a marked access"?

Ditto.

> > or:
> > 
> > 	Z is on the same CPU as Y and is connected to Y by a possibly
> > 	empty sequence of xb links (again, if the sequence is empty it
> > 	means Z and Y are the same event).
> > 
> > The motivations behind this definition are straightforward:
> > 
> > 	cumul-fence memory barriers force stores that are po-before
> > 	the barrier to propagate to other CPUs before stores that are
> > 	po-after the barrier.
> > 
> > 	An rfe link from an event W to an event R says that R reads
> > 	from W, which certainly means that W must have propagated to
> > 	R's CPU before R executed.
> > 
> > 	strong-fence memory barriers force stores that are po-before
> > 	the barrier, or that propagate to the barrier's CPU before the
> > 	barrier executes, to propagate to all CPUs before any events
> > 	po-after the barrier can execute.
> > 
> > To see how this works out in practice, consider our old friend, the MP
> > pattern (with fences and statement labels, but without the conditional
> > test):
> > 
> > 	int buf = 0, flag = 0;
> > 
> > 	P0()
> > 	{
> > 		X: WRITE_ONCE(buf, 1);
> > 		   smp_wmb();
> > 		W: WRITE_ONCE(flag, 1);
> > 	}
> > 
> > 	P1()
> > 	{
> > 		int r1;
> > 		int r2 = 0;
> > 
> > 		Z: r1 = READ_ONCE(flag);
> > 		   smp_rmb();
> > 		Y: r2 = READ_ONCE(buf);
> > 	}
> 
> I have to ask.  Why X then W then Z then Y?  ;-)

In order to agree with the text above.  The Z statement here 
corresponds to the Z event in the explanation of vis (and likewise for 
X and Y).  W was just an extra letter because I needed to refer to that 
statement, and X, Y, and Z were already in use.

> (This is MP+fencewmbonceonce+fencermbonceonce.litmus in the current set
> in tools/memory-model/litmus-tests.)
> 
> > The smp_wmb() memory barrier gives a cumul-fence link from X to W, and
> > assuming r1 = 1 at the end, there is an rfe link from W to Z.  This
> > means that the store to buf must propagate from P0 to P1 before Z
> > executes.  Next, Z and Y are on the same CPU and the smp_rmb() fence
> > provides an xb link from Z to Y (i.e., it forces Z to execute before
> > Y).  Therefore we have X ->vis Y: X must propagate to Y's CPU before Y
> > executes.
> > 
> > The second complicating factor mentioned above arises from the fact
> > that when we are considering data races, some of the memory accesses
> > are plain.  Now, although we have not said so explicitly, up to this
> > point most of the relations defined by the LKMM (ppo, hb, prop,
> > cumul-fence, pb, and so on -- including vis) apply only to marked
> > accesses.
> > 
> > There are good reasons for this restriction.  The compiler is not
> > allowed to apply fancy transformations to marked accesses, and
> > consequently each such access in the source code corresponds more or
> > less directly to a single machine instruction in the object code.  But
> > plain accesses are a different story; the compiler may combine them,
> > split them up, duplicate them, eliminate them, invent new ones, and
> > who knows what else.  Seeing a plain access in the source code tells
> > you almost nothing about what machine instructions will end up in the
> > object code.
> > 
> > Fortunately, the compiler isn't completely free; it is subject to some
> > limitations.  For one, it is not allowed to introduce a data race into
> > the object code if the source code does not already contain a data
> > race (if it could, memory models would be useless and no multithreaded
> > code would be safe!).  For another, it cannot move a plain access past
> > a compiler barrier.
> > 
> > A compiler barrier is a kind of fence, but as the name implies, it
> > only affects the compiler; it does not necessarily have any effect on
> > how instructions are executed by the CPU.  In Linux kernel source
> > code, the barrier() function is a compiler barrier.  It doesn't give
> > rise directly to any machine instructions in the object code; rather,
> > it affects how the compiler generates the rest of the object code.
> > Given source code like this:
> > 
> > 	... some memory accesses ...
> > 	barrier();
> > 	... some other memory accesses ...
> > 
> > the barrier() function ensures that the machine instructions
> > corresponding to the first group of accesses will all end po-before
> > any machine instructions corresponding to the second group of accesses
> > -- even if some of the accesses are plain.  (Of course, the CPU may
> > then execute some of those accesses out of program order, but we
> > already know how to deal with such issues.)  Without the barrier()
> > there would be no such guarantee; the two groups of accesses could be
> > intermingled or even reversed in the object code.
> > 
> > The LKMM doesn't say much about the barrier() function, but it does
> > require that all fences are also compiler barriers.  In addition, it
> > requires that the ordering properties of memory barriers such as
> > smp_rmb() or smp_store_release() apply to plain accesses as well as to
> > marked accesses.
> > 
> > This is the key to analyzing data races.  Consider the MP pattern
> > again, now using plain accesses for buf:
> > 
> > 	int buf = 0, flag = 0;
> > 
> > 	P0()
> > 	{
> > 		U: buf = 1;
> > 		   smp_wmb();
> > 		X: WRITE_ONCE(flag, 1);
> > 	}
> > 
> > 	P1()
> > 	{
> > 		int r1;
> > 		int r2 = 0;
> > 
> > 		Y: r1 = READ_ONCE(flag);
> > 		   if (r1) {
> > 			   smp_rmb();
> > 			V: r2 = buf;
> > 		   }
> > 	}
> 
> And same nit, why not just X, Y, and Z?

Well, for one thing, you can't make four distinct statement labels out 
of X, Y, and Z!  :-)

In this case I wanted X ->vis Y, to agree with the earlier usage, and I
needed two other labels for the plain accesses.  U and V seemed
appropriate.

> Similar issues with the litmus test:
> 
> ------------------------------------------------------------------------
> C plain-4
> 
> {
> 	int buf = 0;
> 	int flag = 0;
> }
> 
> 
> P0(int *buf, int *flag)
> {
> 	*buf = 1;
> 	smp_wmb();
> 	WRITE_ONCE(*flag, 1);
> }
> 
> P1(int *buf, int *flag)
> {
> 	int r1;
> 	int r2 = 0;
> 
> 	r1 = READ_ONCE(*flag);
> 	if (r1) {
> 		smp_rmb();
> 		r2 = *buf;
> 	}
> }
> 
> exists r1=1 /\ r2=0
> ------------------------------------------------------------------------
> 
> > This program does not contain a data race.  Although the U and V
> > accesses conflict, the LKMM can prove they are not concurrent as
> > follows:
> > 
> > 	The smp_wmb() fence in P0 is both a compiler barrier and a
> > 	cumul-fence.  It guarantees that no matter what hash of
> > 	machine instructions the compiler generates for the plain
> > 	access U, all those instructions will be po-before the fence.
> > 	Consequently U's store to buf, no matter how it is carried out
> > 	at the machine level, must propagate to P1 before X's store to
> > 	flag does.
> > 
> > 	X and Y are both marked accesses.  Hence an rfe link from X to
> > 	Y is a valid indicator that X propagated to P1 before Y
> > 	executed, i.e., X ->vis Y.  (And if there is no rfe link then
> > 	r1 will be 0, so V will not be executed and ipso facto won't
> > 	race with U.)
> > 
> > 	The smp_rmb() fence in P1 is a compiler barrier as well as a
> > 	fence.  It guarantees that all the machine-level instructions
> > 	corresponding to the access V will be po-after the fence, and
> > 	therefore any loads among those instructions will execute
> > 	after the fence does and hence after Y does.
> > 
> > Thus U's store to buf is forced to propagate to P1 before V's load
> > executes (assuming V does execute), ruling out the possibility of a
> > data race between them.
> > 
> > This analysis illustrates how the LKMM deals with plain accesses in
> > general.  Suppose R is a plain load and we want to show that R
> > executes before some marked access E.  We can do this by finding a
> > marked access X such that R and X are ordered by a suitable fence and
> > X ->xb* E.  If E was also a plain access, we would also look for a
> > marked access Y such that X ->xb* Y, and Y and E are ordered by a
> > fence.  We describe this arrangement by saying that R is
> > "post-bounded" by X and E is "pre-bounded" by Y.
> > 
> > In fact, we go one step further: Since R is a read, we say that R is
> > "r-post-bounded" by X.  Similarly, E would be "r-pre-bounded" or
> > "w-pre-bounded" by Y, depending on whether E was a store or a load.
> > This distinction is needed because some fences affect only loads
> > (i.e., smp_rmb()) and some affect only stores (smp_wmb()); otherwise
> > the two types of bounds are the same.  And as a degenerate case, we
> > say that a marked access pre-bounds and post-bounds itself (e.g., if R
> > above were a marked load then X could simply be taken to be R itself.)
> > 
> > The need to distinguish between r- and w-bounding raises yet another
> > issue.  When the source code contains a plain store, the compiler is
> > allowed to put plain loads of the same location into the object code.
> > For example, given the source code:
> > 
> > 	x = 1;
> > 
> > the compiler is theoretically allowed to generate object code that
> > looks like:
> > 
> > 	if (x != 1)
> > 		x = 1;
> > 
> > thereby adding a load (and possibly replacing the store entirely).
> > For this reason, whenever the LKMM requires a plain store to be
> > w-pre-bounded or w-post-bounded by a marked access, it also requires
> > the store to be r-pre-bounded or r-post-bounded, so as to handle cases
> > where the compiler adds a load.
> > 
> > (This may be overly cautious.  We don't know of any examples where a
> > compiler has augmented a store with a load in this fashion, and the
> > Linux kernel developers would probably fight pretty hard to change a
> > compiler if it ever did this.  Still, better safe than sorry.)
> > 
> > Incidentally, the other tranformation -- augmenting a plain load by
> > adding in a store to the same location -- is not allowed.  This is
> > because the compiler cannot know whether any other CPUs might perform
> > a concurrent load from that location.  Two concurrent loads don't
> > constitute a race (they can't interfere with each other), but a store
> > does race with a concurrent load.  Thus adding a store might create a
> > data race where one was not already present in the source code,
> > something the compiler is forbidden to do.  Augmenting a store with a
> > load, on the other hand, is acceptable because doing so won't create a
> > data race unless one already existed.
> > 
> > The LKMM includes a second way to pre-bound plain accesses, in
> > addition to fences: an address dependency from a marked load.  That
> > is, in the sequence:
> > 
> > 	p = READ_ONCE(ptr);
> > 	r = *p;
> > 
> > the LKMM says that the marked load of ptr pre-bounds the plain load of
> > *p; the marked load must execute before any of the machine
> > instructions corresponding to the plain load.  This is a reasonable
> > stipulation, since after all, the CPU can't perform the load of *p
> > until it knows what value p will hold.  Furthermore, without some
> > assumption like this one, some usages typical of RCU would count as
> > data races.  For example:
> > 
> > 	int a = 1, b;
> 
> herd7 doesn't much like this.

The document mentions (near the top) that its code examples are not in 
the proper form for actual litmus tests.

> > 	int *ptr = &a;
> > 
> > 	P0()
> > 	{
> > 		b = 2;
> > 		rcu_assign_ptr(ptr, &b);
> 
> rcu_assign_pointer(), globally.

Thank you; I will fix it.

> > 	}
> > 
> > 	P1()
> > 	{
> > 		int *p;
> > 		int r;
> > 
> > 		rcu_read_lock();
> > 		p = rcu_dereference(ptr);
> > 		r = *p;
> > 		rcu_read_unlock();
> > 	}
> 
> ------------------------------------------------------------------------
> C plain-5
> 
> {
> 	int a = 1;
> 	int b;
> 	int *ptr = &a;
> }
> 
> P0(int *b, int **ptr)
> {
> 	*b = 2;
> 	rcu_assign_pointer(*ptr, b);
> }
> 
> P1(int *ptr)
> {
> 	int *r1;
> 	int r2;
> 
> 	rcu_read_lock();
> 	r1 = rcu_dereference(*ptr);
> 	r2 = *r1;
> 	rcu_read_unlock();
> }
> 
> exists r1=b /\ r2=1
> ------------------------------------------------------------------------
> 
> Also strange output:
> 
> ------------------------------------------------------------------------
> $ herd7 -conf linux-kernel.cfg /tmp/argh
> Test plain-3 Allowed
> States 1
> r1=0; r2=0;
> No
> Witnesses
> Positive: 0 Negative: 2
> Condition exists (r1=b /\ r2=1)
> Observation plain-3 Never 0 2
> Time plain-3 0.00
> Hash=44e039597a92bdc7efc9217813478126
> ------------------------------------------------------------------------
> 
> > (In this example the rcu_read_lock() and rcu_read_unlock() calls don't
> > really do anything, because there aren't any grace periods.  They are
> > included merely for the sake of good form; typically P0 would call
> > synchronize_rcu() somewhere after the rcu_assign_ptr().)
> > 
> > rcu_assign_ptr() performs a store-release, so the plain store to b is
> > definitely w-post-bounded before the store to ptr, and the two stores
> > will propagate to P1 in that order.  However, rcu_dereference() is
> > only equivalent to READ_ONCE().  While it is a marked access, it is
> > not a fence or compiler barrier.  Hence the only guarantee we have
> > that the load of ptr in P1 is r-pre-bounded before the load of *p
> > (thus avoiding a race) is the assumption about address dependencies.
> > 
> > This is a situation where the compiler can undermine the memory model,
> > and a certain amount of care is required when programming constructs
> > like this one.  In particular, comparisons between the pointer and
> > other known addresses can cause trouble.  If you have something like:
> > 
> > 	p = rcu_dereference(ptr);
> > 	if (p == &x)
> > 		r = *p;
> > 
> > then the compiler just might generate object code resembling:
> > 
> > 	p = rcu_dereference(ptr);
> > 	if (p == &x)
> > 		r = x;
> > 
> > or even:
> > 
> > 	rtemp = x;
> > 	p = rcu_dereference(ptr);
> > 	if (p == &x)
> > 		r = rtemp;
> > 
> > which would invalidate the memory model's assumption, since the CPU
> > could now perform the load of x before the load of ptr (there might be
> > a control dependency but no address dependency at the machine level).
> > 
> > Finally, it turns out there is a situation in which a plain write does
> > not need to be w-post-bounded: when it is separated from the
> > conflicting access by a fence.  At first glance this may seem
> > impossible.  After all, to be conflicting the second access has to be
> > on a different CPU from the first, and fences don't link events on
> > different CPUs.  Well, normal fences don't -- but rcu-fence can!
> > Here's an example:
> > 
> > 	int x, y;
> > 
> > 	P0()
> > 	{
> > 		WRITE_ONCE(x, 1);
> > 		synchronize_rcu();
> > 		y = 3;
> > 	}
> > 
> > 	P1()
> > 	{
> > 		rcu_read_lock();
> > 		if (READ_ONCE(x) == 0)
> > 			y = 2;
> > 		rcu_read_unlock();
> > 	}
> 
> I introduced an r1 to create an "exists" clause:
> 
> ------------------------------------------------------------------------
> C plain-6
> 
> {
> 	int x;
> 	int y;
> }
> 
> 
> P0(int *x, int *y)
> {
> 	WRITE_ONCE(*x, 1);
> 	synchronize_rcu();
> 	*y = 3;
> }
> 
> P1(int *x, int *y)
> {
> 	int r1;
> 
> 	rcu_read_lock();
> 	r1 = READ_ONCE(*x);
> 	if (r1 == 0)
> 		*y = 2;
> 	rcu_read_unlock();
> }
> 
> exists r1=0 /\ y=2
> ------------------------------------------------------------------------

By the way, my example is essentially the same as 
manual/plain/C-S-rcunoderef-2.litmus in your archive.  Variable names 
changed and the local variable eliminated, but otherwise equivalent.

> > Do the plain stores to y race?  Clearly not if P1 reads a non-zero
> > value for x, so let's assume the READ_ONCE(x) does obtain 0.  This
> > means that the read-side critical section in P1 must finish executing
> > before the grace period in P0 does, because RCU's Grace-Period
> > Guarantee says that otherwise P0's store to x would have propagated to
> > P1 before the critical section started and so would have been visible
> > to the READ_ONCE().  (Another way of putting it is that the fre link
> > from the READ_ONCE() to the WRITE_ONCE() gives rise to an rcu-link
> > between those two events.)
> > 
> > This means there is an rcu-fence link from P1's "y = 2" store to P0's
> > "y = 3" store, and consequently the first must propagate from P1 to P0
> > before the second can execute.  Therefore the two stores cannot be
> > concurrent and there is no race, even though P1's plain store to y
> > isn't w-post-bounded by any marked accesses.
> > 
> > Putting all this material together yields the following picture.  For
> > two conflicting stores W and W', where W ->co W', the LKMM says the
> > stores don't race if W can be linked to W' by a
> > 
> > 	w-post-bounded ; vis ; w-pre-bounded
> > 
> > sequence.  If W is plain then they also have to be linked by an
> > 
> > 	r-post-bounded ; xb* ; w-pre-bounded
> > 
> > sequence, and if W' is plain then they also have to be linked by a
> > 
> > 	w-post-bounded ; vis ; r-pre-bounded
> > 
> > sequence.  For a conflicting load R and store W, the LKMM says the two
> > accesses don't race if R can be linked to W by an
> > 
> > 	r-post-bounded ; xb* ; w-pre-bounded
> > 
> > sequence or if W can be linked to R by a
> > 
> > 	w-post-bounded ; vis ; r-pre-bounded
> > 
> > sequence.  For the cases involving a vis link, the LKMM also accepts
> > sequences in which W is linked to W' or R by a
> > 
> > 	strong-fence ; xb* ; {w and/or r}-pre-bounded
> > 
> > sequence with no post-bounding, and in every case the LKMM also allows
> > the link simply to be a fence with no bounding at all.  If no sequence
> > of the appropriate sort exists, the LKMM says that the accesses race.
> > 
> > There is one more part of the LKMM related to plain accesses (although
> > not to data races) we should discuss.  Recall that many relations such
> > as hb are limited to marked accesses only.  As a result, the
> > happens-before, propagates-before, and rcu axioms (which state that
> > various relation must not contain a cycle) doesn't apply to plain
> > accesses.  Nevertheless, we do want to rule out such cycles, because
> > they don't make sense even for plain accesses.
> > 
> > To this end, the LKMM imposes three extra restrictions, together
> > called the "plain-coherence" axiom because of their resemblance to the
> > coherency rules:
> > 
> > 	If R and W conflict and it is possible to link R to W by one
> > 	of the xb* sequences listed above, then W ->rfe R is not
> > 	allowed (i.e., a load cannot read from a store that it
> > 	executes before, even if one or both is plain).
> > 
> > 	If W and R conflict and it is possible to link W to R by one
> > 	of the vis sequences listed above, then R ->fre W is not
> > 	allowed (i.e., if a store is visible to a load then the load
> > 	must read from that store or one coherence-after it).
> > 
> > 	If W and W' conflict and it is possible to link W to W' by one
> > 	of the vis sequences listed above, then W' ->co W is not
> > 	allowed (i.e., if one store is visible to another then it must
> > 	come after in the coherence order).
> > 
> > This is the extent to which the LKMM deals with plain accesses.
> > Perhaps it could say more (for example, plain accesses might
> > contribute to the ppo relation), but at the moment it seems that this
> > minimal, conservative approach is good enough.
> 
> I will need to read this last section again.  Perhaps more than once.  ;-)
> 
> Anyway, good stuff!!!

Thanks.  I'll submit it after more reviews are in.

Alan

