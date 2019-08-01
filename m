Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955807E4E2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 23:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389295AbfHAVkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 17:40:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37355 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389232AbfHAVjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:39:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so34801983pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 14:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U+5faUJkG1y0fnvyt8TF9suJQqycP97v5gdw2EVsedc=;
        b=QKIBpRzIXckCtBpzcQnwZC35NN/220VeJvywpOMo4Xb7TLR+vx048D0ZANACyK4Xyz
         laGUhZtQySz2EyfQ8InhM9/oS/ScLorAko1R6Go712pn865IduWkODusH+RHomIJM5KS
         I5xV2jVXyCNwljIUupXuzbfXFlNE8Ev+oAAP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U+5faUJkG1y0fnvyt8TF9suJQqycP97v5gdw2EVsedc=;
        b=QHDOzNBaKlX8QuyBb49A5FqjisXZm1pcq6Ozm/DUewnfP77OYEcImoLutBb0pwUYP6
         S9HsJPg55heHHVpK3ci/ZjCi/rX0zb78JHhOJFP9GxGsa8FJN4v+EE6kJur4L700CxuW
         iaVxrW7zpo+dabGlLY6omkSR6HtU9S4oeZrx78lQDQITG8U2281/fVfbUdLACGKJCdm4
         Ouvuu8jwTVIPArmtacQaqQvegDXUMq1ZXhMpcqvnneEs3fuNv/ptdiRrJcJC5RE41tyo
         HIWTKaNTZeP0aQt5NItuDmc6tZk3I+SjWVk4vTvf+iOtQ3PfrDc2oviRijLEjg6tExod
         V9Mg==
X-Gm-Message-State: APjAAAWViqg96UhQUriloIr44jmt6C2ZreNiJiHCX5T6sapcjXolW0Y6
        LKfBCKyKRWP0sAv3zo5fOLCVyhJP
X-Google-Smtp-Source: APXvYqx6GVoEmzrQ3CvwPOqZ9FDOkf4WzGPZks31Vb58o3zpc9HZ9rGPeg2EpgZAkgSQoZDL0FIEpg==
X-Received: by 2002:aa7:8b55:: with SMTP id i21mr56031014pfd.155.1564695580458;
        Thu, 01 Aug 2019 14:39:40 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r61sm5940423pjb.7.2019.08.01.14.39.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 14:39:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org
Subject: ['PATCH v2' 3/7] docs: rcu: convert some articles from html to ReST
Date:   Thu,  1 Aug 2019 17:39:18 -0400
Message-Id: <20190801213922.158860-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801213922.158860-1-joel@joelfernandes.org>
References: <20190801213922.158860-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

There are 4 RCU articles that are written on html format.

The way they are, they can't be part of the Linux Kernel
documentation body nor share the styles and pdf output.

So, convert them to ReST format.

This way, make htmldocs and make pdfdocs will produce a
documentation output that will be like the original ones, but
will be part of the Linux Kernel documentation body.

Part of the conversion was done with the help of pandoc, but
the result had some broken things that had to be manually
fixed.

Following are manual changes Mauro made when doing the automatic conversion:
Quoting from: https://lore.kernel.org/rcu/20190726154550.5eeae294@coco.lan/

> > At least the pandoc's version I used here has a bug: its conversion
> > from html to ReST on those files only start after a <body> tag - or
> > when the first quiz table starts. I only discovered that adding a
> > <body> at the beginning of the file solve this book at the last
> > conversions.
> >
> > So, for most html->ReST conversions, I manually converted the first
> > part of the document, basically stripping html paragraph tags and
> > by replacing highlights by the ReST syntax.
> >
> > Also, all the quiz tables seem to assume some javascript macro or
> > css style that would be hiding the answer part until the mouse moves
> > to it. Such macro/css was not there at the kernel tree. So, the quiz
> > answers have the same color as the background, making them invisible.
> > Even if we had such macro/css, this is not portable for pdf/LaTeX output
> > (and I'm not sure if this would work with ePub).
> >
> > So, I ended by manually doing the table conversion.
> >
> > Finally, I double-checked if the conversions ended ok, addressing any
> > issues that might have heppened.
> >
> > So, after both automatic conversion and manual fixes, I opened both the
> > html files produced by Sphinx and the original ones and compared them
> > line per line (except for the indexes, as Sphinx produces them
> > automatically), in order to see if all information from the original
> > files will be there on a format close to what we have on other ReST
> > files, fixing any pending issues if any.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../Data-Structures/Data-Structures.html      | 1391 -------
 .../Data-Structures/Data-Structures.rst       | 1163 ++++++
 .../Expedited-Grace-Periods.html              |  668 ----
 .../Expedited-Grace-Periods.rst               |  521 +++
 .../Memory-Ordering/Tree-RCU-Diagram.html     |    9 -
 .../Tree-RCU-Memory-Ordering.html             |  704 ----
 .../Tree-RCU-Memory-Ordering.rst              |  625 ++++
 .../RCU/Design/Requirements/Requirements.html | 3330 -----------------
 .../RCU/Design/Requirements/Requirements.rst  | 2662 +++++++++++++
 Documentation/RCU/index.rst                   |    5 +
 Documentation/RCU/whatisRCU.txt               |    4 +-
 11 files changed, 4978 insertions(+), 6104 deletions(-)
 delete mode 100644 Documentation/RCU/Design/Data-Structures/Data-Structures.html
 create mode 100644 Documentation/RCU/Design/Data-Structures/Data-Structures.rst
 delete mode 100644 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
 create mode 100644 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
 delete mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Diagram.html
 delete mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
 create mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
 delete mode 100644 Documentation/RCU/Design/Requirements/Requirements.html
 create mode 100644 Documentation/RCU/Design/Requirements/Requirements.rst

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.html b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
deleted file mode 100644
index c30c1957c7e6..000000000000
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.html
+++ /dev/null
@@ -1,1391 +0,0 @@
-<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
-        "http://www.w3.org/TR/html4/loose.dtd">
-        <html>
-        <head><title>A Tour Through TREE_RCU's Data Structures [LWN.net]</title>
-        <meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
-
-           <p>December 18, 2016</p>
-           <p>This article was contributed by Paul E.&nbsp;McKenney</p>
-
-<h3>Introduction</h3>
-
-This document describes RCU's major data structures and their relationship
-to each other.
-
-<ol>
-<li>	<a href="#Data-Structure Relationships">
-	Data-Structure Relationships</a>
-<li>	<a href="#The rcu_state Structure">
-	The <tt>rcu_state</tt> Structure</a>
-<li>	<a href="#The rcu_node Structure">
-	The <tt>rcu_node</tt> Structure</a>
-<li>	<a href="#The rcu_segcblist Structure">
-	The <tt>rcu_segcblist</tt> Structure</a>
-<li>	<a href="#The rcu_data Structure">
-	The <tt>rcu_data</tt> Structure</a>
-<li>	<a href="#The rcu_head Structure">
-	The <tt>rcu_head</tt> Structure</a>
-<li>	<a href="#RCU-Specific Fields in the task_struct Structure">
-	RCU-Specific Fields in the <tt>task_struct</tt> Structure</a>
-<li>	<a href="#Accessor Functions">
-	Accessor Functions</a>
-</ol>
-
-<h3><a name="Data-Structure Relationships">Data-Structure Relationships</a></h3>
-
-<p>RCU is for all intents and purposes a large state machine, and its
-data structures maintain the state in such a way as to allow RCU readers
-to execute extremely quickly, while also processing the RCU grace periods
-requested by updaters in an efficient and extremely scalable fashion.
-The efficiency and scalability of RCU updaters is provided primarily
-by a combining tree, as shown below:
-
-</p><p><img src="BigTreeClassicRCU.svg" alt="BigTreeClassicRCU.svg" width="30%">
-
-</p><p>This diagram shows an enclosing <tt>rcu_state</tt> structure
-containing a tree of <tt>rcu_node</tt> structures.
-Each leaf node of the <tt>rcu_node</tt> tree has up to 16
-<tt>rcu_data</tt> structures associated with it, so that there
-are <tt>NR_CPUS</tt> number of <tt>rcu_data</tt> structures,
-one for each possible CPU.
-This structure is adjusted at boot time, if needed, to handle the
-common case where <tt>nr_cpu_ids</tt> is much less than
-<tt>NR_CPUs</tt>.
-For example, a number of Linux distributions set <tt>NR_CPUs=4096</tt>,
-which results in a three-level <tt>rcu_node</tt> tree.
-If the actual hardware has only 16 CPUs, RCU will adjust itself
-at boot time, resulting in an <tt>rcu_node</tt> tree with only a single node.
-
-</p><p>The purpose of this combining tree is to allow per-CPU events
-such as quiescent states, dyntick-idle transitions,
-and CPU hotplug operations to be processed efficiently
-and scalably.
-Quiescent states are recorded by the per-CPU <tt>rcu_data</tt> structures,
-and other events are recorded by the leaf-level <tt>rcu_node</tt>
-structures.
-All of these events are combined at each level of the tree until finally
-grace periods are completed at the tree's root <tt>rcu_node</tt>
-structure.
-A grace period can be completed at the root once every CPU
-(or, in the case of <tt>CONFIG_PREEMPT_RCU</tt>, task)
-has passed through a quiescent state.
-Once a grace period has completed, record of that fact is propagated
-back down the tree.
-
-</p><p>As can be seen from the diagram, on a 64-bit system
-a two-level tree with 64 leaves can accommodate 1,024 CPUs, with a fanout
-of 64 at the root and a fanout of 16 at the leaves.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Why isn't the fanout at the leaves also 64?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	Because there are more types of events that affect the leaf-level
-	<tt>rcu_node</tt> structures than further up the tree.
-	Therefore, if the leaf <tt>rcu_node</tt> structures have fanout of
-	64, the contention on these structures' <tt>-&gt;structures</tt>
-	becomes excessive.
-	Experimentation on a wide variety of systems has shown that a fanout
-	of 16 works well for the leaves of the <tt>rcu_node</tt> tree.
-	</font>
-
-	<p><font color="ffffff">Of course, further experience with
-	systems having hundreds or thousands of CPUs may demonstrate
-	that the fanout for the non-leaf <tt>rcu_node</tt> structures
-	must also be reduced.
-	Such reduction can be easily carried out when and if it proves
-	necessary.
-	In the meantime, if you are using such a system and running into
-	contention problems on the non-leaf <tt>rcu_node</tt> structures,
-	you may use the <tt>CONFIG_RCU_FANOUT</tt> kernel configuration
-	parameter to reduce the non-leaf fanout as needed.
-	</font>
-
-	<p><font color="ffffff">Kernels built for systems with
-	strong NUMA characteristics might also need to adjust
-	<tt>CONFIG_RCU_FANOUT</tt> so that the domains of the
-	<tt>rcu_node</tt> structures align with hardware boundaries.
-	However, there has thus far been no need for this.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>If your system has more than 1,024 CPUs (or more than 512 CPUs on
-a 32-bit system), then RCU will automatically add more levels to the
-tree.
-For example, if you are crazy enough to build a 64-bit system with 65,536
-CPUs, RCU would configure the <tt>rcu_node</tt> tree as follows:
-
-</p><p><img src="HugeTreeClassicRCU.svg" alt="HugeTreeClassicRCU.svg" width="50%">
-
-</p><p>RCU currently permits up to a four-level tree, which on a 64-bit system
-accommodates up to 4,194,304 CPUs, though only a mere 524,288 CPUs for
-32-bit systems.
-On the other hand, you can set both <tt>CONFIG_RCU_FANOUT</tt> and
-<tt>CONFIG_RCU_FANOUT_LEAF</tt> to be as small as 2, which would result
-in a 16-CPU test using a 4-level tree.
-This can be useful for testing large-system capabilities on small test
-machines.
-
-</p><p>This multi-level combining tree allows us to get most of the
-performance and scalability
-benefits of partitioning, even though RCU grace-period detection is
-inherently a global operation.
-The trick here is that only the last CPU to report a quiescent state
-into a given <tt>rcu_node</tt> structure need advance to the <tt>rcu_node</tt>
-structure at the next level up the tree.
-This means that at the leaf-level <tt>rcu_node</tt> structure, only
-one access out of sixteen will progress up the tree.
-For the internal <tt>rcu_node</tt> structures, the situation is even
-more extreme:  Only one access out of sixty-four will progress up
-the tree.
-Because the vast majority of the CPUs do not progress up the tree,
-the lock contention remains roughly constant up the tree.
-No matter how many CPUs there are in the system, at most 64 quiescent-state
-reports per grace period will progress all the way to the root
-<tt>rcu_node</tt> structure, thus ensuring that the lock contention
-on that root <tt>rcu_node</tt> structure remains acceptably low.
-
-</p><p>In effect, the combining tree acts like a big shock absorber,
-keeping lock contention under control at all tree levels regardless
-of the level of loading on the system.
-
-</p><p>RCU updaters wait for normal grace periods by registering
-RCU callbacks, either directly via <tt>call_rcu()</tt>
-or indirectly via <tt>synchronize_rcu()</tt> and friends.
-RCU callbacks are represented by <tt>rcu_head</tt> structures,
-which are queued on <tt>rcu_data</tt> structures while they are
-waiting for a grace period to elapse, as shown in the following figure:
-
-</p><p><img src="BigTreePreemptRCUBHdyntickCB.svg" alt="BigTreePreemptRCUBHdyntickCB.svg" width="40%">
-
-</p><p>This figure shows how <tt>TREE_RCU</tt>'s and
-<tt>PREEMPT_RCU</tt>'s major data structures are related.
-Lesser data structures will be introduced with the algorithms that
-make use of them.
-
-</p><p>Note that each of the data structures in the above figure has
-its own synchronization:
-
-<p><ol>
-<li>	Each <tt>rcu_state</tt> structures has a lock and a mutex,
-	and some fields are protected by the corresponding root
-	<tt>rcu_node</tt> structure's lock.
-<li>	Each <tt>rcu_node</tt> structure has a spinlock.
-<li>	The fields in <tt>rcu_data</tt> are private to the corresponding
-	CPU, although a few can be read and written by other CPUs.
-</ol>
-
-<p>It is important to note that different data structures can have
-very different ideas about the state of RCU at any given time.
-For but one example, awareness of the start or end of a given RCU
-grace period propagates slowly through the data structures.
-This slow propagation is absolutely necessary for RCU to have good
-read-side performance.
-If this balkanized implementation seems foreign to you, one useful
-trick is to consider each instance of these data structures to be
-a different person, each having the usual slightly different
-view of reality.
-
-</p><p>The general role of each of these data structures is as
-follows:
-
-</p><ol>
-<li>	<tt>rcu_state</tt>:
-	This structure forms the interconnection between the
-	<tt>rcu_node</tt> and <tt>rcu_data</tt> structures,
-	tracks grace periods, serves as short-term repository
-	for callbacks orphaned by CPU-hotplug events,
-	maintains <tt>rcu_barrier()</tt> state,
-	tracks expedited grace-period state,
-	and maintains state used to force quiescent states when
-	grace periods extend too long,
-<li>	<tt>rcu_node</tt>: This structure forms the combining
-	tree that propagates quiescent-state
-	information from the leaves to the root, and also propagates
-	grace-period information from the root to the leaves.
-	It provides local copies of the grace-period state in order
-	to allow this information to be accessed in a synchronized
-	manner without suffering the scalability limitations that
-	would otherwise be imposed by global locking.
-	In <tt>CONFIG_PREEMPT_RCU</tt> kernels, it manages the lists
-	of tasks that have blocked while in their current
-	RCU read-side critical section.
-	In <tt>CONFIG_PREEMPT_RCU</tt> with
-	<tt>CONFIG_RCU_BOOST</tt>, it manages the
-	per-<tt>rcu_node</tt> priority-boosting
-	kernel threads (kthreads) and state.
-	Finally, it records CPU-hotplug state in order to determine
-	which CPUs should be ignored during a given grace period.
-<li>	<tt>rcu_data</tt>: This per-CPU structure is the
-	focus of quiescent-state detection and RCU callback queuing.
-	It also tracks its relationship to the corresponding leaf
-	<tt>rcu_node</tt> structure to allow more-efficient
-	propagation of quiescent states up the <tt>rcu_node</tt>
-	combining tree.
-	Like the <tt>rcu_node</tt> structure, it provides a local
-	copy of the grace-period information to allow for-free
-	synchronized
-	access to this information from the corresponding CPU.
-	Finally, this structure records past dyntick-idle state
-	for the corresponding CPU and also tracks statistics.
-<li>	<tt>rcu_head</tt>:
-	This structure represents RCU callbacks, and is the
-	only structure allocated and managed by RCU users.
-	The <tt>rcu_head</tt> structure is normally embedded
-	within the RCU-protected data structure.
-</ol>
-
-<p>If all you wanted from this article was a general notion of how
-RCU's data structures are related, you are done.
-Otherwise, each of the following sections give more details on
-the <tt>rcu_state</tt>, <tt>rcu_node</tt> and <tt>rcu_data</tt> data
-structures.
-
-<h3><a name="The rcu_state Structure">
-The <tt>rcu_state</tt> Structure</a></h3>
-
-<p>The <tt>rcu_state</tt> structure is the base structure that
-represents the state of RCU in the system.
-This structure forms the interconnection between the
-<tt>rcu_node</tt> and <tt>rcu_data</tt> structures,
-tracks grace periods, contains the lock used to
-synchronize with CPU-hotplug events,
-and maintains state used to force quiescent states when
-grace periods extend too long,
-
-</p><p>A few of the <tt>rcu_state</tt> structure's fields are discussed,
-singly and in groups, in the following sections.
-The more specialized fields are covered in the discussion of their
-use.
-
-<h5>Relationship to rcu_node and rcu_data Structures</h5>
-
-This portion of the <tt>rcu_state</tt> structure is declared
-as follows:
-
-<pre>
-  1   struct rcu_node node[NUM_RCU_NODES];
-  2   struct rcu_node *level[NUM_RCU_LVLS + 1];
-  3   struct rcu_data __percpu *rda;
-</pre>
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Wait a minute!
-	You said that the <tt>rcu_node</tt> structures formed a tree,
-	but they are declared as a flat array!
-	What gives?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	The tree is laid out in the array.
-	The first node In the array is the head, the next set of nodes in the
-	array are children of the head node, and so on until the last set of
-	nodes in the array are the leaves.
-	</font>
-
-	<p><font color="ffffff">See the following diagrams to see how
-	this works.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>The <tt>rcu_node</tt> tree is embedded into the
-<tt>-&gt;node[]</tt> array as shown in the following figure:
-
-</p><p><img src="TreeMapping.svg" alt="TreeMapping.svg" width="40%">
-
-</p><p>One interesting consequence of this mapping is that a
-breadth-first traversal of the tree is implemented as a simple
-linear scan of the array, which is in fact what the
-<tt>rcu_for_each_node_breadth_first()</tt> macro does.
-This macro is used at the beginning and ends of grace periods.
-
-</p><p>Each entry of the <tt>-&gt;level</tt> array references
-the first <tt>rcu_node</tt> structure on the corresponding level
-of the tree, for example, as shown below:
-
-</p><p><img src="TreeMappingLevel.svg" alt="TreeMappingLevel.svg" width="40%">
-
-</p><p>The zero<sup>th</sup> element of the array references the root
-<tt>rcu_node</tt> structure, the first element references the
-first child of the root <tt>rcu_node</tt>, and finally the second
-element references the first leaf <tt>rcu_node</tt> structure.
-
-</p><p>For whatever it is worth, if you draw the tree to be tree-shaped
-rather than array-shaped, it is easy to draw a planar representation:
-
-</p><p><img src="TreeLevel.svg" alt="TreeLevel.svg" width="60%">
-
-</p><p>Finally, the <tt>-&gt;rda</tt> field references a per-CPU
-pointer to the corresponding CPU's <tt>rcu_data</tt> structure.
-
-</p><p>All of these fields are constant once initialization is complete,
-and therefore need no protection.
-
-<h5>Grace-Period Tracking</h5>
-
-<p>This portion of the <tt>rcu_state</tt> structure is declared
-as follows:
-
-<pre>
-  1   unsigned long gp_seq;
-</pre>
-
-<p>RCU grace periods are numbered, and
-the <tt>-&gt;gp_seq</tt> field contains the current grace-period
-sequence number.
-The bottom two bits are the state of the current grace period,
-which can be zero for not yet started or one for in progress.
-In other words, if the bottom two bits of <tt>-&gt;gp_seq</tt> are
-zero, then RCU is idle.
-Any other value in the bottom two bits indicates that something is broken.
-This field is protected by the root <tt>rcu_node</tt> structure's
-<tt>-&gt;lock</tt> field.
-
-</p><p>There are <tt>-&gt;gp_seq</tt> fields
-in the <tt>rcu_node</tt> and <tt>rcu_data</tt> structures
-as well.
-The fields in the <tt>rcu_state</tt> structure represent the
-most current value, and those of the other structures are compared
-in order to detect the beginnings and ends of grace periods in a distributed
-fashion.
-The values flow from <tt>rcu_state</tt> to <tt>rcu_node</tt>
-(down the tree from the root to the leaves) to <tt>rcu_data</tt>.
-
-<h5>Miscellaneous</h5>
-
-<p>This portion of the <tt>rcu_state</tt> structure is declared
-as follows:
-
-<pre>
-  1   unsigned long gp_max;
-  2   char abbr;
-  3   char *name;
-</pre>
-
-<p>The <tt>-&gt;gp_max</tt> field tracks the duration of the longest
-grace period in jiffies.
-It is protected by the root <tt>rcu_node</tt>'s <tt>-&gt;lock</tt>.
-
-<p>The <tt>-&gt;name</tt> and <tt>-&gt;abbr</tt> fields distinguish
-between preemptible RCU (&ldquo;rcu_preempt&rdquo; and &ldquo;p&rdquo;)
-and non-preemptible RCU (&ldquo;rcu_sched&rdquo; and &ldquo;s&rdquo;).
-These fields are used for diagnostic and tracing purposes.
-
-<h3><a name="The rcu_node Structure">
-The <tt>rcu_node</tt> Structure</a></h3>
-
-<p>The <tt>rcu_node</tt> structures form the combining
-tree that propagates quiescent-state
-information from the leaves to the root and also that propagates
-grace-period information from the root down to the leaves.
-They provides local copies of the grace-period state in order
-to allow this information to be accessed in a synchronized
-manner without suffering the scalability limitations that
-would otherwise be imposed by global locking.
-In <tt>CONFIG_PREEMPT_RCU</tt> kernels, they manage the lists
-of tasks that have blocked while in their current
-RCU read-side critical section.
-In <tt>CONFIG_PREEMPT_RCU</tt> with
-<tt>CONFIG_RCU_BOOST</tt>, they manage the
-per-<tt>rcu_node</tt> priority-boosting
-kernel threads (kthreads) and state.
-Finally, they record CPU-hotplug state in order to determine
-which CPUs should be ignored during a given grace period.
-
-</p><p>The <tt>rcu_node</tt> structure's fields are discussed,
-singly and in groups, in the following sections.
-
-<h5>Connection to Combining Tree</h5>
-
-<p>This portion of the <tt>rcu_node</tt> structure is declared
-as follows:
-
-<pre>
-  1   struct rcu_node *parent;
-  2   u8 level;
-  3   u8 grpnum;
-  4   unsigned long grpmask;
-  5   int grplo;
-  6   int grphi;
-</pre>
-
-<p>The <tt>-&gt;parent</tt> pointer references the <tt>rcu_node</tt>
-one level up in the tree, and is <tt>NULL</tt> for the root
-<tt>rcu_node</tt>.
-The RCU implementation makes heavy use of this field to push quiescent
-states up the tree.
-The <tt>-&gt;level</tt> field gives the level in the tree, with
-the root being at level zero, its children at level one, and so on.
-The <tt>-&gt;grpnum</tt> field gives this node's position within
-the children of its parent, so this number can range between 0 and 31
-on 32-bit systems and between 0 and 63 on 64-bit systems.
-The <tt>-&gt;level</tt> and <tt>-&gt;grpnum</tt> fields are
-used only during initialization and for tracing.
-The <tt>-&gt;grpmask</tt> field is the bitmask counterpart of
-<tt>-&gt;grpnum</tt>, and therefore always has exactly one bit set.
-This mask is used to clear the bit corresponding to this <tt>rcu_node</tt>
-structure in its parent's bitmasks, which are described later.
-Finally, the <tt>-&gt;grplo</tt> and <tt>-&gt;grphi</tt> fields
-contain the lowest and highest numbered CPU served by this
-<tt>rcu_node</tt> structure, respectively.
-
-</p><p>All of these fields are constant, and thus do not require any
-synchronization.
-
-<h5>Synchronization</h5>
-
-<p>This field of the <tt>rcu_node</tt> structure is declared
-as follows:
-
-<pre>
-  1   raw_spinlock_t lock;
-</pre>
-
-<p>This field is used to protect the remaining fields in this structure,
-unless otherwise stated.
-That said, all of the fields in this structure can be accessed without
-locking for tracing purposes.
-Yes, this can result in confusing traces, but better some tracing confusion
-than to be heisenbugged out of existence.
-
-<h5>Grace-Period Tracking</h5>
-
-<p>This portion of the <tt>rcu_node</tt> structure is declared
-as follows:
-
-<pre>
-  1   unsigned long gp_seq;
-  2   unsigned long gp_seq_needed;
-</pre>
-
-<p>The <tt>rcu_node</tt> structures' <tt>-&gt;gp_seq</tt> fields are
-the counterparts of the field of the same name in the <tt>rcu_state</tt>
-structure.
-They each may lag up to one step behind their <tt>rcu_state</tt>
-counterpart.
-If the bottom two bits of a given <tt>rcu_node</tt> structure's
-<tt>-&gt;gp_seq</tt> field is zero, then this <tt>rcu_node</tt>
-structure believes that RCU is idle.
-</p><p>The <tt>&gt;gp_seq</tt> field of each <tt>rcu_node</tt>
-structure is updated at the beginning and the end
-of each grace period.
-
-<p>The <tt>-&gt;gp_seq_needed</tt> fields record the
-furthest-in-the-future grace period request seen by the corresponding
-<tt>rcu_node</tt> structure.  The request is considered fulfilled when
-the value of the <tt>-&gt;gp_seq</tt> field equals or exceeds that of
-the <tt>-&gt;gp_seq_needed</tt> field.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Suppose that this <tt>rcu_node</tt> structure doesn't see
-	a request for a very long time.
-	Won't wrapping of the <tt>-&gt;gp_seq</tt> field cause
-	problems?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	No, because if the <tt>-&gt;gp_seq_needed</tt> field lags behind the
-	<tt>-&gt;gp_seq</tt> field, the <tt>-&gt;gp_seq_needed</tt> field
-	will be updated at the end of the grace period.
-	Modulo-arithmetic comparisons therefore will always get the
-	correct answer, even with wrapping.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<h5>Quiescent-State Tracking</h5>
-
-<p>These fields manage the propagation of quiescent states up the
-combining tree.
-
-</p><p>This portion of the <tt>rcu_node</tt> structure has fields
-as follows:
-
-<pre>
-  1   unsigned long qsmask;
-  2   unsigned long expmask;
-  3   unsigned long qsmaskinit;
-  4   unsigned long expmaskinit;
-</pre>
-
-<p>The <tt>-&gt;qsmask</tt> field tracks which of this
-<tt>rcu_node</tt> structure's children still need to report
-quiescent states for the current normal grace period.
-Such children will have a value of 1 in their corresponding bit.
-Note that the leaf <tt>rcu_node</tt> structures should be
-thought of as having <tt>rcu_data</tt> structures as their
-children.
-Similarly, the <tt>-&gt;expmask</tt> field tracks which
-of this <tt>rcu_node</tt> structure's children still need to report
-quiescent states for the current expedited grace period.
-An expedited grace period has
-the same conceptual properties as a normal grace period, but the
-expedited implementation accepts extreme CPU overhead to obtain
-much lower grace-period latency, for example, consuming a few
-tens of microseconds worth of CPU time to reduce grace-period
-duration from milliseconds to tens of microseconds.
-The <tt>-&gt;qsmaskinit</tt> field tracks which of this
-<tt>rcu_node</tt> structure's children cover for at least
-one online CPU.
-This mask is used to initialize <tt>-&gt;qsmask</tt>,
-and <tt>-&gt;expmaskinit</tt> is used to initialize
-<tt>-&gt;expmask</tt> and the beginning of the
-normal and expedited grace periods, respectively.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Why are these bitmasks protected by locking?
-	Come on, haven't you heard of atomic instructions???
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	Lockless grace-period computation!  Such a tantalizing possibility!
-	</font>
-
-	<p><font color="ffffff">But consider the following sequence of events:
-	</font>
-
-	<ol>
-	<li>	<font color="ffffff">CPU&nbsp;0 has been in dyntick-idle
-		mode for quite some time.
-		When it wakes up, it notices that the current RCU
-		grace period needs it to report in, so it sets a
-		flag where the scheduling clock interrupt will find it.
-		</font><p>
-	<li>	<font color="ffffff">Meanwhile, CPU&nbsp;1 is running
-		<tt>force_quiescent_state()</tt>,
-		and notices that CPU&nbsp;0 has been in dyntick idle mode,
-		which qualifies as an extended quiescent state.
-		</font><p>
-	<li>	<font color="ffffff">CPU&nbsp;0's scheduling clock
-		interrupt fires in the
-		middle of an RCU read-side critical section, and notices
-		that the RCU core needs something, so commences RCU softirq
-		processing.
-		</font>
-		<p>
-	<li>	<font color="ffffff">CPU&nbsp;0's softirq handler
-		executes and is just about ready
-		to report its quiescent state up the <tt>rcu_node</tt>
-		tree.
-		</font><p>
-	<li>	<font color="ffffff">But CPU&nbsp;1 beats it to the punch,
-		completing the current
-		grace period and starting a new one.
-		</font><p>
-	<li>	<font color="ffffff">CPU&nbsp;0 now reports its quiescent
-		state for the wrong
-		grace period.
-		That grace period might now end before the RCU read-side
-		critical section.
-		If that happens, disaster will ensue.
-		</font>
-	</ol>
-
-	<p><font color="ffffff">So the locking is absolutely required in
-	order to coordinate clearing of the bits with updating of the
-	grace-period sequence number in <tt>-&gt;gp_seq</tt>.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<h5>Blocked-Task Management</h5>
-
-<p><tt>PREEMPT_RCU</tt> allows tasks to be preempted in the
-midst of their RCU read-side critical sections, and these tasks
-must be tracked explicitly.
-The details of exactly why and how they are tracked will be covered
-in a separate article on RCU read-side processing.
-For now, it is enough to know that the <tt>rcu_node</tt>
-structure tracks them.
-
-<pre>
-  1   struct list_head blkd_tasks;
-  2   struct list_head *gp_tasks;
-  3   struct list_head *exp_tasks;
-  4   bool wait_blkd_tasks;
-</pre>
-
-<p>The <tt>-&gt;blkd_tasks</tt> field is a list header for
-the list of blocked and preempted tasks.
-As tasks undergo context switches within RCU read-side critical
-sections, their <tt>task_struct</tt> structures are enqueued
-(via the <tt>task_struct</tt>'s <tt>-&gt;rcu_node_entry</tt>
-field) onto the head of the <tt>-&gt;blkd_tasks</tt> list for the
-leaf <tt>rcu_node</tt> structure corresponding to the CPU
-on which the outgoing context switch executed.
-As these tasks later exit their RCU read-side critical sections,
-they remove themselves from the list.
-This list is therefore in reverse time order, so that if one of the tasks
-is blocking the current grace period, all subsequent tasks must
-also be blocking that same grace period.
-Therefore, a single pointer into this list suffices to track
-all tasks blocking a given grace period.
-That pointer is stored in <tt>-&gt;gp_tasks</tt> for normal
-grace periods and in <tt>-&gt;exp_tasks</tt> for expedited
-grace periods.
-These last two fields are <tt>NULL</tt> if either there is
-no grace period in flight or if there are no blocked tasks
-preventing that grace period from completing.
-If either of these two pointers is referencing a task that
-removes itself from the <tt>-&gt;blkd_tasks</tt> list,
-then that task must advance the pointer to the next task on
-the list, or set the pointer to <tt>NULL</tt> if there
-are no subsequent tasks on the list.
-
-</p><p>For example, suppose that tasks&nbsp;T1, T2, and&nbsp;T3 are
-all hard-affinitied to the largest-numbered CPU in the system.
-Then if task&nbsp;T1 blocked in an RCU read-side
-critical section, then an expedited grace period started,
-then task&nbsp;T2 blocked in an RCU read-side critical section,
-then a normal grace period started, and finally task&nbsp;3 blocked
-in an RCU read-side critical section, then the state of the
-last leaf <tt>rcu_node</tt> structure's blocked-task list
-would be as shown below:
-
-</p><p><img src="blkd_task.svg" alt="blkd_task.svg" width="60%">
-
-</p><p>Task&nbsp;T1 is blocking both grace periods, task&nbsp;T2 is
-blocking only the normal grace period, and task&nbsp;T3 is blocking
-neither grace period.
-Note that these tasks will not remove themselves from this list
-immediately upon resuming execution.
-They will instead remain on the list until they execute the outermost
-<tt>rcu_read_unlock()</tt> that ends their RCU read-side critical
-section.
-
-<p>
-The <tt>-&gt;wait_blkd_tasks</tt> field indicates whether or not
-the current grace period is waiting on a blocked task.
-
-<h5>Sizing the <tt>rcu_node</tt> Array</h5>
-
-<p>The <tt>rcu_node</tt> array is sized via a series of
-C-preprocessor expressions as follows:
-
-<pre>
- 1 #ifdef CONFIG_RCU_FANOUT
- 2 #define RCU_FANOUT CONFIG_RCU_FANOUT
- 3 #else
- 4 # ifdef CONFIG_64BIT
- 5 # define RCU_FANOUT 64
- 6 # else
- 7 # define RCU_FANOUT 32
- 8 # endif
- 9 #endif
-10
-11 #ifdef CONFIG_RCU_FANOUT_LEAF
-12 #define RCU_FANOUT_LEAF CONFIG_RCU_FANOUT_LEAF
-13 #else
-14 # ifdef CONFIG_64BIT
-15 # define RCU_FANOUT_LEAF 64
-16 # else
-17 # define RCU_FANOUT_LEAF 32
-18 # endif
-19 #endif
-20
-21 #define RCU_FANOUT_1        (RCU_FANOUT_LEAF)
-22 #define RCU_FANOUT_2        (RCU_FANOUT_1 * RCU_FANOUT)
-23 #define RCU_FANOUT_3        (RCU_FANOUT_2 * RCU_FANOUT)
-24 #define RCU_FANOUT_4        (RCU_FANOUT_3 * RCU_FANOUT)
-25
-26 #if NR_CPUS &lt;= RCU_FANOUT_1
-27 #  define RCU_NUM_LVLS        1
-28 #  define NUM_RCU_LVL_0        1
-29 #  define NUM_RCU_NODES        NUM_RCU_LVL_0
-30 #  define NUM_RCU_LVL_INIT    { NUM_RCU_LVL_0 }
-31 #  define RCU_NODE_NAME_INIT  { "rcu_node_0" }
-32 #  define RCU_FQS_NAME_INIT   { "rcu_node_fqs_0" }
-33 #  define RCU_EXP_NAME_INIT   { "rcu_node_exp_0" }
-34 #elif NR_CPUS &lt;= RCU_FANOUT_2
-35 #  define RCU_NUM_LVLS        2
-36 #  define NUM_RCU_LVL_0        1
-37 #  define NUM_RCU_LVL_1        DIV_ROUND_UP(NR_CPUS, RCU_FANOUT_1)
-38 #  define NUM_RCU_NODES        (NUM_RCU_LVL_0 + NUM_RCU_LVL_1)
-39 #  define NUM_RCU_LVL_INIT    { NUM_RCU_LVL_0, NUM_RCU_LVL_1 }
-40 #  define RCU_NODE_NAME_INIT  { "rcu_node_0", "rcu_node_1" }
-41 #  define RCU_FQS_NAME_INIT   { "rcu_node_fqs_0", "rcu_node_fqs_1" }
-42 #  define RCU_EXP_NAME_INIT   { "rcu_node_exp_0", "rcu_node_exp_1" }
-43 #elif NR_CPUS &lt;= RCU_FANOUT_3
-44 #  define RCU_NUM_LVLS        3
-45 #  define NUM_RCU_LVL_0        1
-46 #  define NUM_RCU_LVL_1        DIV_ROUND_UP(NR_CPUS, RCU_FANOUT_2)
-47 #  define NUM_RCU_LVL_2        DIV_ROUND_UP(NR_CPUS, RCU_FANOUT_1)
-48 #  define NUM_RCU_NODES        (NUM_RCU_LVL_0 + NUM_RCU_LVL_1 + NUM_RCU_LVL_2)
-49 #  define NUM_RCU_LVL_INIT    { NUM_RCU_LVL_0, NUM_RCU_LVL_1, NUM_RCU_LVL_2 }
-50 #  define RCU_NODE_NAME_INIT  { "rcu_node_0", "rcu_node_1", "rcu_node_2" }
-51 #  define RCU_FQS_NAME_INIT   { "rcu_node_fqs_0", "rcu_node_fqs_1", "rcu_node_fqs_2" }
-52 #  define RCU_EXP_NAME_INIT   { "rcu_node_exp_0", "rcu_node_exp_1", "rcu_node_exp_2" }
-53 #elif NR_CPUS &lt;= RCU_FANOUT_4
-54 #  define RCU_NUM_LVLS        4
-55 #  define NUM_RCU_LVL_0        1
-56 #  define NUM_RCU_LVL_1        DIV_ROUND_UP(NR_CPUS, RCU_FANOUT_3)
-57 #  define NUM_RCU_LVL_2        DIV_ROUND_UP(NR_CPUS, RCU_FANOUT_2)
-58 #  define NUM_RCU_LVL_3        DIV_ROUND_UP(NR_CPUS, RCU_FANOUT_1)
-59 #  define NUM_RCU_NODES        (NUM_RCU_LVL_0 + NUM_RCU_LVL_1 + NUM_RCU_LVL_2 + NUM_RCU_LVL_3)
-60 #  define NUM_RCU_LVL_INIT    { NUM_RCU_LVL_0, NUM_RCU_LVL_1, NUM_RCU_LVL_2, NUM_RCU_LVL_3 }
-61 #  define RCU_NODE_NAME_INIT  { "rcu_node_0", "rcu_node_1", "rcu_node_2", "rcu_node_3" }
-62 #  define RCU_FQS_NAME_INIT   { "rcu_node_fqs_0", "rcu_node_fqs_1", "rcu_node_fqs_2", "rcu_node_fqs_3" }
-63 #  define RCU_EXP_NAME_INIT   { "rcu_node_exp_0", "rcu_node_exp_1", "rcu_node_exp_2", "rcu_node_exp_3" }
-64 #else
-65 # error "CONFIG_RCU_FANOUT insufficient for NR_CPUS"
-66 #endif
-</pre>
-
-<p>The maximum number of levels in the <tt>rcu_node</tt> structure
-is currently limited to four, as specified by lines&nbsp;21-24
-and the structure of the subsequent &ldquo;if&rdquo; statement.
-For 32-bit systems, this allows 16*32*32*32=524,288 CPUs, which
-should be sufficient for the next few years at least.
-For 64-bit systems, 16*64*64*64=4,194,304 CPUs is allowed, which
-should see us through the next decade or so.
-This four-level tree also allows kernels built with
-<tt>CONFIG_RCU_FANOUT=8</tt> to support up to 4096 CPUs,
-which might be useful in very large systems having eight CPUs per
-socket (but please note that no one has yet shown any measurable
-performance degradation due to misaligned socket and <tt>rcu_node</tt>
-boundaries).
-In addition, building kernels with a full four levels of <tt>rcu_node</tt>
-tree permits better testing of RCU's combining-tree code.
-
-</p><p>The <tt>RCU_FANOUT</tt> symbol controls how many children
-are permitted at each non-leaf level of the <tt>rcu_node</tt> tree.
-If the <tt>CONFIG_RCU_FANOUT</tt> Kconfig option is not specified,
-it is set based on the word size of the system, which is also
-the Kconfig default.
-
-</p><p>The <tt>RCU_FANOUT_LEAF</tt> symbol controls how many CPUs are
-handled by each leaf <tt>rcu_node</tt> structure.
-Experience has shown that allowing a given leaf <tt>rcu_node</tt>
-structure to handle 64 CPUs, as permitted by the number of bits in
-the <tt>-&gt;qsmask</tt> field on a 64-bit system, results in
-excessive contention for the leaf <tt>rcu_node</tt> structures'
-<tt>-&gt;lock</tt> fields.
-The number of CPUs per leaf <tt>rcu_node</tt> structure is therefore
-limited to 16 given the default value of <tt>CONFIG_RCU_FANOUT_LEAF</tt>.
-If <tt>CONFIG_RCU_FANOUT_LEAF</tt> is unspecified, the value
-selected is based on the word size of the system, just as for
-<tt>CONFIG_RCU_FANOUT</tt>.
-Lines&nbsp;11-19 perform this computation.
-
-</p><p>Lines&nbsp;21-24 compute the maximum number of CPUs supported by
-a single-level (which contains a single <tt>rcu_node</tt> structure),
-two-level, three-level, and four-level <tt>rcu_node</tt> tree,
-respectively, given the fanout specified by <tt>RCU_FANOUT</tt>
-and <tt>RCU_FANOUT_LEAF</tt>.
-These numbers of CPUs are retained in the
-<tt>RCU_FANOUT_1</tt>,
-<tt>RCU_FANOUT_2</tt>,
-<tt>RCU_FANOUT_3</tt>, and
-<tt>RCU_FANOUT_4</tt>
-C-preprocessor variables, respectively.
-
-</p><p>These variables are used to control the C-preprocessor <tt>#if</tt>
-statement spanning lines&nbsp;26-66 that computes the number of
-<tt>rcu_node</tt> structures required for each level of the tree,
-as well as the number of levels required.
-The number of levels is placed in the <tt>NUM_RCU_LVLS</tt>
-C-preprocessor variable by lines&nbsp;27, 35, 44, and&nbsp;54.
-The number of <tt>rcu_node</tt> structures for the topmost level
-of the tree is always exactly one, and this value is unconditionally
-placed into <tt>NUM_RCU_LVL_0</tt> by lines&nbsp;28, 36, 45, and&nbsp;55.
-The rest of the levels (if any) of the <tt>rcu_node</tt> tree
-are computed by dividing the maximum number of CPUs by the
-fanout supported by the number of levels from the current level down,
-rounding up.  This computation is performed by lines&nbsp;37,
-46-47, and&nbsp;56-58.
-Lines&nbsp;31-33, 40-42, 50-52, and&nbsp;62-63 create initializers
-for lockdep lock-class names.
-Finally, lines&nbsp;64-66 produce an error if the maximum number of
-CPUs is too large for the specified fanout.
-
-<h3><a name="The rcu_segcblist Structure">
-The <tt>rcu_segcblist</tt> Structure</a></h3>
-
-The <tt>rcu_segcblist</tt> structure maintains a segmented list of
-callbacks as follows:
-
-<pre>
- 1 #define RCU_DONE_TAIL        0
- 2 #define RCU_WAIT_TAIL        1
- 3 #define RCU_NEXT_READY_TAIL  2
- 4 #define RCU_NEXT_TAIL        3
- 5 #define RCU_CBLIST_NSEGS     4
- 6
- 7 struct rcu_segcblist {
- 8   struct rcu_head *head;
- 9   struct rcu_head **tails[RCU_CBLIST_NSEGS];
-10   unsigned long gp_seq[RCU_CBLIST_NSEGS];
-11   long len;
-12   long len_lazy;
-13 };
-</pre>
-
-<p>
-The segments are as follows:
-
-<ol>
-<li>	<tt>RCU_DONE_TAIL</tt>: Callbacks whose grace periods have elapsed.
-	These callbacks are ready to be invoked.
-<li>	<tt>RCU_WAIT_TAIL</tt>: Callbacks that are waiting for the
-	current grace period.
-	Note that different CPUs can have different ideas about which
-	grace period is current, hence the <tt>-&gt;gp_seq</tt> field.
-<li>	<tt>RCU_NEXT_READY_TAIL</tt>: Callbacks waiting for the next
-	grace period to start.
-<li>	<tt>RCU_NEXT_TAIL</tt>: Callbacks that have not yet been
-	associated with a grace period.
-</ol>
-
-<p>
-The <tt>-&gt;head</tt> pointer references the first callback or
-is <tt>NULL</tt> if the list contains no callbacks (which is
-<i>not</i> the same as being empty).
-Each element of the <tt>-&gt;tails[]</tt> array references the
-<tt>-&gt;next</tt> pointer of the last callback in the corresponding
-segment of the list, or the list's <tt>-&gt;head</tt> pointer if
-that segment and all previous segments are empty.
-If the corresponding segment is empty but some previous segment is
-not empty, then the array element is identical to its predecessor.
-Older callbacks are closer to the head of the list, and new callbacks
-are added at the tail.
-This relationship between the <tt>-&gt;head</tt> pointer, the
-<tt>-&gt;tails[]</tt> array, and the callbacks is shown in this
-diagram:
-
-</p><p><img src="nxtlist.svg" alt="nxtlist.svg" width="40%">
-
-</p><p>In this figure, the <tt>-&gt;head</tt> pointer references the
-first
-RCU callback in the list.
-The <tt>-&gt;tails[RCU_DONE_TAIL]</tt> array element references
-the <tt>-&gt;head</tt> pointer itself, indicating that none
-of the callbacks is ready to invoke.
-The <tt>-&gt;tails[RCU_WAIT_TAIL]</tt> array element references callback
-CB&nbsp;2's <tt>-&gt;next</tt> pointer, which indicates that
-CB&nbsp;1 and CB&nbsp;2 are both waiting on the current grace period,
-give or take possible disagreements about exactly which grace period
-is the current one.
-The <tt>-&gt;tails[RCU_NEXT_READY_TAIL]</tt> array element
-references the same RCU callback that <tt>-&gt;tails[RCU_WAIT_TAIL]</tt>
-does, which indicates that there are no callbacks waiting on the next
-RCU grace period.
-The <tt>-&gt;tails[RCU_NEXT_TAIL]</tt> array element references
-CB&nbsp;4's <tt>-&gt;next</tt> pointer, indicating that all the
-remaining RCU callbacks have not yet been assigned to an RCU grace
-period.
-Note that the <tt>-&gt;tails[RCU_NEXT_TAIL]</tt> array element
-always references the last RCU callback's <tt>-&gt;next</tt> pointer
-unless the callback list is empty, in which case it references
-the <tt>-&gt;head</tt> pointer.
-
-<p>
-There is one additional important special case for the
-<tt>-&gt;tails[RCU_NEXT_TAIL]</tt> array element: It can be <tt>NULL</tt>
-when this list is <i>disabled</i>.
-Lists are disabled when the corresponding CPU is offline or when
-the corresponding CPU's callbacks are offloaded to a kthread,
-both of which are described elsewhere.
-
-</p><p>CPUs advance their callbacks from the
-<tt>RCU_NEXT_TAIL</tt> to the <tt>RCU_NEXT_READY_TAIL</tt> to the
-<tt>RCU_WAIT_TAIL</tt> to the <tt>RCU_DONE_TAIL</tt> list segments
-as grace periods advance.
-
-</p><p>The <tt>-&gt;gp_seq[]</tt> array records grace-period
-numbers corresponding to the list segments.
-This is what allows different CPUs to have different ideas as to
-which is the current grace period while still avoiding premature
-invocation of their callbacks.
-In particular, this allows CPUs that go idle for extended periods
-to determine which of their callbacks are ready to be invoked after
-reawakening.
-
-</p><p>The <tt>-&gt;len</tt> counter contains the number of
-callbacks in <tt>-&gt;head</tt>, and the
-<tt>-&gt;len_lazy</tt> contains the number of those callbacks that
-are known to only free memory, and whose invocation can therefore
-be safely deferred.
-
-<p><b>Important note</b>: It is the <tt>-&gt;len</tt> field that
-determines whether or not there are callbacks associated with
-this <tt>rcu_segcblist</tt> structure, <i>not</i> the <tt>-&gt;head</tt>
-pointer.
-The reason for this is that all the ready-to-invoke callbacks
-(that is, those in the <tt>RCU_DONE_TAIL</tt> segment) are extracted
-all at once at callback-invocation time (<tt>rcu_do_batch</tt>), due
-to which <tt>-&gt;head</tt> may be set to NULL if there are no not-done
-callbacks remaining in the <tt>rcu_segcblist</tt>.
-If callback invocation must be postponed, for example, because a
-high-priority process just woke up on this CPU, then the remaining
-callbacks are placed back on the <tt>RCU_DONE_TAIL</tt> segment and
-<tt>-&gt;head</tt> once again points to the start of the segment.
-In short, the head field can briefly be <tt>NULL</tt> even though the
-CPU has callbacks present the entire time.
-Therefore, it is not appropriate to test the <tt>-&gt;head</tt> pointer
-for <tt>NULL</tt>.
-
-<p>In contrast, the <tt>-&gt;len</tt> and <tt>-&gt;len_lazy</tt> counts
-are adjusted only after the corresponding callbacks have been invoked.
-This means that the <tt>-&gt;len</tt> count is zero only if
-the <tt>rcu_segcblist</tt> structure really is devoid of callbacks.
-Of course, off-CPU sampling of the <tt>-&gt;len</tt> count requires
-careful use of appropriate synchronization, for example, memory barriers.
-This synchronization can be a bit subtle, particularly in the case
-of <tt>rcu_barrier()</tt>.
-
-<h3><a name="The rcu_data Structure">
-The <tt>rcu_data</tt> Structure</a></h3>
-
-<p>The <tt>rcu_data</tt> maintains the per-CPU state for the RCU subsystem.
-The fields in this structure may be accessed only from the corresponding
-CPU (and from tracing) unless otherwise stated.
-This structure is the
-focus of quiescent-state detection and RCU callback queuing.
-It also tracks its relationship to the corresponding leaf
-<tt>rcu_node</tt> structure to allow more-efficient
-propagation of quiescent states up the <tt>rcu_node</tt>
-combining tree.
-Like the <tt>rcu_node</tt> structure, it provides a local
-copy of the grace-period information to allow for-free
-synchronized
-access to this information from the corresponding CPU.
-Finally, this structure records past dyntick-idle state
-for the corresponding CPU and also tracks statistics.
-
-</p><p>The <tt>rcu_data</tt> structure's fields are discussed,
-singly and in groups, in the following sections.
-
-<h5>Connection to Other Data Structures</h5>
-
-<p>This portion of the <tt>rcu_data</tt> structure is declared
-as follows:
-
-<pre>
-  1   int cpu;
-  2   struct rcu_node *mynode;
-  3   unsigned long grpmask;
-  4   bool beenonline;
-</pre>
-
-<p>The <tt>-&gt;cpu</tt> field contains the number of the
-corresponding CPU and the <tt>-&gt;mynode</tt> field references the
-corresponding <tt>rcu_node</tt> structure.
-The <tt>-&gt;mynode</tt> is used to propagate quiescent states
-up the combining tree.
-These two fields are constant and therefore do not require synchronization.
-
-<p>The <tt>-&gt;grpmask</tt> field indicates the bit in
-the <tt>-&gt;mynode-&gt;qsmask</tt> corresponding to this
-<tt>rcu_data</tt> structure, and is also used when propagating
-quiescent states.
-The <tt>-&gt;beenonline</tt> flag is set whenever the corresponding
-CPU comes online, which means that the debugfs tracing need not dump
-out any <tt>rcu_data</tt> structure for which this flag is not set.
-
-<h5>Quiescent-State and Grace-Period Tracking</h5>
-
-<p>This portion of the <tt>rcu_data</tt> structure is declared
-as follows:
-
-<pre>
-  1   unsigned long gp_seq;
-  2   unsigned long gp_seq_needed;
-  3   bool cpu_no_qs;
-  4   bool core_needs_qs;
-  5   bool gpwrap;
-</pre>
-
-<p>The <tt>-&gt;gp_seq</tt> field is the counterpart of the field of the same
-name in the <tt>rcu_state</tt> and <tt>rcu_node</tt> structures.  The
-<tt>-&gt;gp_seq_needed</tt> field is the counterpart of the field of the same
-name in the rcu_node</tt> structure.
-They may each lag up to one behind their <tt>rcu_node</tt>
-counterparts, but in <tt>CONFIG_NO_HZ_IDLE</tt> and
-<tt>CONFIG_NO_HZ_FULL</tt> kernels can lag
-arbitrarily far behind for CPUs in dyntick-idle mode (but these counters
-will catch up upon exit from dyntick-idle mode).
-If the lower two bits of a given <tt>rcu_data</tt> structure's
-<tt>-&gt;gp_seq</tt> are zero, then this <tt>rcu_data</tt>
-structure believes that RCU is idle.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	All this replication of the grace period numbers can only cause
-	massive confusion.
-	Why not just keep a global sequence number and be done with it???
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	Because if there was only a single global sequence
-	numbers, there would need to be a single global lock to allow
-	safely accessing and updating it.
-	And if we are not going to have a single global lock, we need
-	to carefully manage the numbers on a per-node basis.
-	Recall from the answer to a previous Quick Quiz that the consequences
-	of applying a previously sampled quiescent state to the wrong
-	grace period are quite severe.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>The <tt>-&gt;cpu_no_qs</tt> flag indicates that the
-CPU has not yet passed through a quiescent state,
-while the <tt>-&gt;core_needs_qs</tt> flag indicates that the
-RCU core needs a quiescent state from the corresponding CPU.
-The <tt>-&gt;gpwrap</tt> field indicates that the corresponding
-CPU has remained idle for so long that the
-<tt>gp_seq</tt> counter is in danger of overflow, which
-will cause the CPU to disregard the values of its counters on
-its next exit from idle.
-
-<h5>RCU Callback Handling</h5>
-
-<p>In the absence of CPU-hotplug events, RCU callbacks are invoked by
-the same CPU that registered them.
-This is strictly a cache-locality optimization: callbacks can and
-do get invoked on CPUs other than the one that registered them.
-After all, if the CPU that registered a given callback has gone
-offline before the callback can be invoked, there really is no other
-choice.
-
-</p><p>This portion of the <tt>rcu_data</tt> structure is declared
-as follows:
-
-<pre>
- 1 struct rcu_segcblist cblist;
- 2 long qlen_last_fqs_check;
- 3 unsigned long n_cbs_invoked;
- 4 unsigned long n_nocbs_invoked;
- 5 unsigned long n_cbs_orphaned;
- 6 unsigned long n_cbs_adopted;
- 7 unsigned long n_force_qs_snap;
- 8 long blimit;
-</pre>
-
-<p>The <tt>-&gt;cblist</tt> structure is the segmented callback list
-described earlier.
-The CPU advances the callbacks in its <tt>rcu_data</tt> structure
-whenever it notices that another RCU grace period has completed.
-The CPU detects the completion of an RCU grace period by noticing
-that the value of its <tt>rcu_data</tt> structure's
-<tt>-&gt;gp_seq</tt> field differs from that of its leaf
-<tt>rcu_node</tt> structure.
-Recall that each <tt>rcu_node</tt> structure's
-<tt>-&gt;gp_seq</tt> field is updated at the beginnings and ends of each
-grace period.
-
-<p>
-The <tt>-&gt;qlen_last_fqs_check</tt> and
-<tt>-&gt;n_force_qs_snap</tt> coordinate the forcing of quiescent
-states from <tt>call_rcu()</tt> and friends when callback
-lists grow excessively long.
-
-</p><p>The <tt>-&gt;n_cbs_invoked</tt>,
-<tt>-&gt;n_cbs_orphaned</tt>, and <tt>-&gt;n_cbs_adopted</tt>
-fields count the number of callbacks invoked,
-sent to other CPUs when this CPU goes offline,
-and received from other CPUs when those other CPUs go offline.
-The <tt>-&gt;n_nocbs_invoked</tt> is used when the CPU's callbacks
-are offloaded to a kthread.
-
-<p>
-Finally, the <tt>-&gt;blimit</tt> counter is the maximum number of
-RCU callbacks that may be invoked at a given time.
-
-<h5>Dyntick-Idle Handling</h5>
-
-<p>This portion of the <tt>rcu_data</tt> structure is declared
-as follows:
-
-<pre>
-  1   int dynticks_snap;
-  2   unsigned long dynticks_fqs;
-</pre>
-
-The <tt>-&gt;dynticks_snap</tt> field is used to take a snapshot
-of the corresponding CPU's dyntick-idle state when forcing
-quiescent states, and is therefore accessed from other CPUs.
-Finally, the <tt>-&gt;dynticks_fqs</tt> field is used to
-count the number of times this CPU is determined to be in
-dyntick-idle state, and is used for tracing and debugging purposes.
-
-<p>
-This portion of the rcu_data structure is declared as follows:
-
-<pre>
-  1   long dynticks_nesting;
-  2   long dynticks_nmi_nesting;
-  3   atomic_t dynticks;
-  4   bool rcu_need_heavy_qs;
-  5   bool rcu_urgent_qs;
-</pre>
-
-<p>These fields in the rcu_data structure maintain the per-CPU dyntick-idle
-state for the corresponding CPU.
-The fields may be accessed only from the corresponding CPU (and from tracing)
-unless otherwise stated.
-
-<p>The <tt>-&gt;dynticks_nesting</tt> field counts the
-nesting depth of process execution, so that in normal circumstances
-this counter has value zero or one.
-NMIs, irqs, and tracers are counted by the <tt>-&gt;dynticks_nmi_nesting</tt>
-field.
-Because NMIs cannot be masked, changes to this variable have to be
-undertaken carefully using an algorithm provided by Andy Lutomirski.
-The initial transition from idle adds one, and nested transitions
-add two, so that a nesting level of five is represented by a
-<tt>-&gt;dynticks_nmi_nesting</tt> value of nine.
-This counter can therefore be thought of as counting the number
-of reasons why this CPU cannot be permitted to enter dyntick-idle
-mode, aside from process-level transitions.
-
-<p>However, it turns out that when running in non-idle kernel context,
-the Linux kernel is fully capable of entering interrupt handlers that
-never exit and perhaps also vice versa.
-Therefore, whenever the <tt>-&gt;dynticks_nesting</tt> field is
-incremented up from zero, the <tt>-&gt;dynticks_nmi_nesting</tt> field
-is set to a large positive number, and whenever the
-<tt>-&gt;dynticks_nesting</tt> field is decremented down to zero,
-the the <tt>-&gt;dynticks_nmi_nesting</tt> field is set to zero.
-Assuming that the number of misnested interrupts is not sufficient
-to overflow the counter, this approach corrects the
-<tt>-&gt;dynticks_nmi_nesting</tt> field every time the corresponding
-CPU enters the idle loop from process context.
-
-</p><p>The <tt>-&gt;dynticks</tt> field counts the corresponding
-CPU's transitions to and from either dyntick-idle or user mode, so
-that this counter has an even value when the CPU is in dyntick-idle
-mode or user mode and an odd value otherwise. The transitions to/from
-user mode need to be counted for user mode adaptive-ticks support
-(see timers/NO_HZ.txt).
-
-</p><p>The <tt>-&gt;rcu_need_heavy_qs</tt> field is used
-to record the fact that the RCU core code would really like to
-see a quiescent state from the corresponding CPU, so much so that
-it is willing to call for heavy-weight dyntick-counter operations.
-This flag is checked by RCU's context-switch and <tt>cond_resched()</tt>
-code, which provide a momentary idle sojourn in response.
-
-</p><p>Finally, the <tt>-&gt;rcu_urgent_qs</tt> field is used to record
-the fact that the RCU core code would really like to see a quiescent state from
-the corresponding CPU, with the various other fields indicating just how badly
-RCU wants this quiescent state.
-This flag is checked by RCU's context-switch path
-(<tt>rcu_note_context_switch</tt>) and the cond_resched code.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Why not simply combine the <tt>-&gt;dynticks_nesting</tt>
-	and <tt>-&gt;dynticks_nmi_nesting</tt> counters into a
-	single counter that just counts the number of reasons that
-	the corresponding CPU is non-idle?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	Because this would fail in the presence of interrupts whose
-	handlers never return and of handlers that manage to return
-	from a made-up interrupt.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>Additional fields are present for some special-purpose
-builds, and are discussed separately.
-
-<h3><a name="The rcu_head Structure">
-The <tt>rcu_head</tt> Structure</a></h3>
-
-<p>Each <tt>rcu_head</tt> structure represents an RCU callback.
-These structures are normally embedded within RCU-protected data
-structures whose algorithms use asynchronous grace periods.
-In contrast, when using algorithms that block waiting for RCU grace periods,
-RCU users need not provide <tt>rcu_head</tt> structures.
-
-</p><p>The <tt>rcu_head</tt> structure has fields as follows:
-
-<pre>
-  1   struct rcu_head *next;
-  2   void (*func)(struct rcu_head *head);
-</pre>
-
-<p>The <tt>-&gt;next</tt> field is used
-to link the <tt>rcu_head</tt> structures together in the
-lists within the <tt>rcu_data</tt> structures.
-The <tt>-&gt;func</tt> field is a pointer to the function
-to be called when the callback is ready to be invoked, and
-this function is passed a pointer to the <tt>rcu_head</tt>
-structure.
-However, <tt>kfree_rcu()</tt> uses the <tt>-&gt;func</tt>
-field to record the offset of the <tt>rcu_head</tt>
-structure within the enclosing RCU-protected data structure.
-
-</p><p>Both of these fields are used internally by RCU.
-From the viewpoint of RCU users, this structure is an
-opaque &ldquo;cookie&rdquo;.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Given that the callback function <tt>-&gt;func</tt>
-	is passed a pointer to the <tt>rcu_head</tt> structure,
-	how is that function supposed to find the beginning of the
-	enclosing RCU-protected data structure?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	In actual practice, there is a separate callback function per
-	type of RCU-protected data structure.
-	The callback function can therefore use the <tt>container_of()</tt>
-	macro in the Linux kernel (or other pointer-manipulation facilities
-	in other software environments) to find the beginning of the
-	enclosing structure.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<h3><a name="RCU-Specific Fields in the task_struct Structure">
-RCU-Specific Fields in the <tt>task_struct</tt> Structure</a></h3>
-
-<p>The <tt>CONFIG_PREEMPT_RCU</tt> implementation uses some
-additional fields in the <tt>task_struct</tt> structure:
-
-<pre>
- 1 #ifdef CONFIG_PREEMPT_RCU
- 2   int rcu_read_lock_nesting;
- 3   union rcu_special rcu_read_unlock_special;
- 4   struct list_head rcu_node_entry;
- 5   struct rcu_node *rcu_blocked_node;
- 6 #endif /* #ifdef CONFIG_PREEMPT_RCU */
- 7 #ifdef CONFIG_TASKS_RCU
- 8   unsigned long rcu_tasks_nvcsw;
- 9   bool rcu_tasks_holdout;
-10   struct list_head rcu_tasks_holdout_list;
-11   int rcu_tasks_idle_cpu;
-12 #endif /* #ifdef CONFIG_TASKS_RCU */
-</pre>
-
-<p>The <tt>-&gt;rcu_read_lock_nesting</tt> field records the
-nesting level for RCU read-side critical sections, and
-the <tt>-&gt;rcu_read_unlock_special</tt> field is a bitmask
-that records special conditions that require <tt>rcu_read_unlock()</tt>
-to do additional work.
-The <tt>-&gt;rcu_node_entry</tt> field is used to form lists of
-tasks that have blocked within preemptible-RCU read-side critical
-sections and the <tt>-&gt;rcu_blocked_node</tt> field references
-the <tt>rcu_node</tt> structure whose list this task is a member of,
-or <tt>NULL</tt> if it is not blocked within a preemptible-RCU
-read-side critical section.
-
-<p>The <tt>-&gt;rcu_tasks_nvcsw</tt> field tracks the number of
-voluntary context switches that this task had undergone at the
-beginning of the current tasks-RCU grace period,
-<tt>-&gt;rcu_tasks_holdout</tt> is set if the current tasks-RCU
-grace period is waiting on this task, <tt>-&gt;rcu_tasks_holdout_list</tt>
-is a list element enqueuing this task on the holdout list,
-and <tt>-&gt;rcu_tasks_idle_cpu</tt> tracks which CPU this
-idle task is running, but only if the task is currently running,
-that is, if the CPU is currently idle.
-
-<h3><a name="Accessor Functions">
-Accessor Functions</a></h3>
-
-<p>The following listing shows the
-<tt>rcu_get_root()</tt>, <tt>rcu_for_each_node_breadth_first</tt> and
-<tt>rcu_for_each_leaf_node()</tt> function and macros:
-
-<pre>
-  1 static struct rcu_node *rcu_get_root(struct rcu_state *rsp)
-  2 {
-  3   return &amp;rsp-&gt;node[0];
-  4 }
-  5
-  6 #define rcu_for_each_node_breadth_first(rsp, rnp) \
-  7   for ((rnp) = &amp;(rsp)-&gt;node[0]; \
-  8        (rnp) &lt; &amp;(rsp)-&gt;node[NUM_RCU_NODES]; (rnp)++)
-  9
- 10 #define rcu_for_each_leaf_node(rsp, rnp) \
- 11   for ((rnp) = (rsp)-&gt;level[NUM_RCU_LVLS - 1]; \
- 12        (rnp) &lt; &amp;(rsp)-&gt;node[NUM_RCU_NODES]; (rnp)++)
-</pre>
-
-<p>The <tt>rcu_get_root()</tt> simply returns a pointer to the
-first element of the specified <tt>rcu_state</tt> structure's
-<tt>-&gt;node[]</tt> array, which is the root <tt>rcu_node</tt>
-structure.
-
-</p><p>As noted earlier, the <tt>rcu_for_each_node_breadth_first()</tt>
-macro takes advantage of the layout of the <tt>rcu_node</tt>
-structures in the <tt>rcu_state</tt> structure's
-<tt>-&gt;node[]</tt> array, performing a breadth-first traversal by
-simply traversing the array in order.
-Similarly, the <tt>rcu_for_each_leaf_node()</tt> macro traverses only
-the last part of the array, thus traversing only the leaf
-<tt>rcu_node</tt> structures.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	What does
-	<tt>rcu_for_each_leaf_node()</tt> do if the <tt>rcu_node</tt> tree
-	contains only a single node?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	In the single-node case,
-	<tt>rcu_for_each_leaf_node()</tt> traverses the single node.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<h3><a name="Summary">
-Summary</a></h3>
-
-So the state of RCU is represented by an <tt>rcu_state</tt> structure,
-which contains a combining tree of <tt>rcu_node</tt> and
-<tt>rcu_data</tt> structures.
-Finally, in <tt>CONFIG_NO_HZ_IDLE</tt> kernels, each CPU's dyntick-idle
-state is tracked by dynticks-related fields in the <tt>rcu_data</tt> structure.
-
-If you made it this far, you are well prepared to read the code
-walkthroughs in the other articles in this series.
-
-<h3><a name="Acknowledgments">
-Acknowledgments</a></h3>
-
-I owe thanks to Cyrill Gorcunov, Mathieu Desnoyers, Dhaval Giani, Paul
-Turner, Abhishek Srivastava, Matt Kowalczyk, and Serge Hallyn
-for helping me get this document into a more human-readable state.
-
-<h3><a name="Legal Statement">
-Legal Statement</a></h3>
-
-<p>This work represents the view of the author and does not necessarily
-represent the view of IBM.
-
-</p><p>Linux is a registered trademark of Linus Torvalds.
-
-</p><p>Other company, product, and service names may be trademarks or
-service marks of others.
-
-</body></html>
diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
new file mode 100644
index 000000000000..4a48e20a46f2
--- /dev/null
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
@@ -0,0 +1,1163 @@
+===================================================
+A Tour Through TREE_RCU's Data Structures [LWN.net]
+===================================================
+
+December 18, 2016
+
+This article was contributed by Paul E. McKenney
+
+Introduction
+============
+
+This document describes RCU's major data structures and their relationship
+to each other.
+
+Data-Structure Relationships
+============================
+
+RCU is for all intents and purposes a large state machine, and its
+data structures maintain the state in such a way as to allow RCU readers
+to execute extremely quickly, while also processing the RCU grace periods
+requested by updaters in an efficient and extremely scalable fashion.
+The efficiency and scalability of RCU updaters is provided primarily
+by a combining tree, as shown below:
+
+.. kernel-figure:: BigTreeClassicRCU.svg
+
+This diagram shows an enclosing ``rcu_state`` structure containing a tree
+of ``rcu_node`` structures. Each leaf node of the ``rcu_node`` tree has up
+to 16 ``rcu_data`` structures associated with it, so that there are
+``NR_CPUS`` number of ``rcu_data`` structures, one for each possible CPU.
+This structure is adjusted at boot time, if needed, to handle the common
+case where ``nr_cpu_ids`` is much less than ``NR_CPUs``.
+For example, a number of Linux distributions set ``NR_CPUs=4096``,
+which results in a three-level ``rcu_node`` tree.
+If the actual hardware has only 16 CPUs, RCU will adjust itself
+at boot time, resulting in an ``rcu_node`` tree with only a single node.
+
+The purpose of this combining tree is to allow per-CPU events
+such as quiescent states, dyntick-idle transitions,
+and CPU hotplug operations to be processed efficiently
+and scalably.
+Quiescent states are recorded by the per-CPU ``rcu_data`` structures,
+and other events are recorded by the leaf-level ``rcu_node``
+structures.
+All of these events are combined at each level of the tree until finally
+grace periods are completed at the tree's root ``rcu_node``
+structure.
+A grace period can be completed at the root once every CPU
+(or, in the case of ``CONFIG_PREEMPT_RCU``, task)
+has passed through a quiescent state.
+Once a grace period has completed, record of that fact is propagated
+back down the tree.
+
+As can be seen from the diagram, on a 64-bit system
+a two-level tree with 64 leaves can accommodate 1,024 CPUs, with a fanout
+of 64 at the root and a fanout of 16 at the leaves.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Why isn't the fanout at the leaves also 64?                           |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Because there are more types of events that affect the leaf-level     |
+| ``rcu_node`` structures than further up the tree. Therefore, if the   |
+| leaf ``rcu_node`` structures have fanout of 64, the contention on     |
+| these structures' ``->structures`` becomes excessive. Experimentation |
+| on a wide variety of systems has shown that a fanout of 16 works well |
+| for the leaves of the ``rcu_node`` tree.                              |
+|                                                                       |
+| Of course, further experience with systems having hundreds or         |
+| thousands of CPUs may demonstrate that the fanout for the non-leaf    |
+| ``rcu_node`` structures must also be reduced. Such reduction can be   |
+| easily carried out when and if it proves necessary. In the meantime,  |
+| if you are using such a system and running into contention problems   |
+| on the non-leaf ``rcu_node`` structures, you may use the              |
+| ``CONFIG_RCU_FANOUT`` kernel configuration parameter to reduce the    |
+| non-leaf fanout as needed.                                            |
+|                                                                       |
+| Kernels built for systems with strong NUMA characteristics might      |
+| also need to adjust ``CONFIG_RCU_FANOUT`` so that the domains of      |
+| the ``rcu_node`` structures align with hardware boundaries.           |
+| However, there has thus far been no need for this.                    |
++-----------------------------------------------------------------------+
+
+If your system has more than 1,024 CPUs (or more than 512 CPUs on a
+32-bit system), then RCU will automatically add more levels to the tree.
+For example, if you are crazy enough to build a 64-bit system with
+65,536 CPUs, RCU would configure the ``rcu_node`` tree as follows:
+
+.. kernel-figure:: HugeTreeClassicRCU.svg
+
+RCU currently permits up to a four-level tree, which on a 64-bit system
+accommodates up to 4,194,304 CPUs, though only a mere 524,288 CPUs for
+32-bit systems. On the other hand, you can set both
+``CONFIG_RCU_FANOUT`` and ``CONFIG_RCU_FANOUT_LEAF`` to be as small as
+2, which would result in a 16-CPU test using a 4-level tree. This can be
+useful for testing large-system capabilities on small test machines.
+
+This multi-level combining tree allows us to get most of the performance
+and scalability benefits of partitioning, even though RCU grace-period
+detection is inherently a global operation. The trick here is that only
+the last CPU to report a quiescent state into a given ``rcu_node``
+structure need advance to the ``rcu_node`` structure at the next level
+up the tree. This means that at the leaf-level ``rcu_node`` structure,
+only one access out of sixteen will progress up the tree. For the
+internal ``rcu_node`` structures, the situation is even more extreme:
+Only one access out of sixty-four will progress up the tree. Because the
+vast majority of the CPUs do not progress up the tree, the lock
+contention remains roughly constant up the tree. No matter how many CPUs
+there are in the system, at most 64 quiescent-state reports per grace
+period will progress all the way to the root ``rcu_node`` structure,
+thus ensuring that the lock contention on that root ``rcu_node``
+structure remains acceptably low.
+
+In effect, the combining tree acts like a big shock absorber, keeping
+lock contention under control at all tree levels regardless of the level
+of loading on the system.
+
+RCU updaters wait for normal grace periods by registering RCU callbacks,
+either directly via ``call_rcu()`` or indirectly via
+``synchronize_rcu()`` and friends. RCU callbacks are represented by
+``rcu_head`` structures, which are queued on ``rcu_data`` structures
+while they are waiting for a grace period to elapse, as shown in the
+following figure:
+
+.. kernel-figure:: BigTreePreemptRCUBHdyntickCB.svg
+
+This figure shows how ``TREE_RCU``'s and ``PREEMPT_RCU``'s major data
+structures are related. Lesser data structures will be introduced with
+the algorithms that make use of them.
+
+Note that each of the data structures in the above figure has its own
+synchronization:
+
+#. Each ``rcu_state`` structures has a lock and a mutex, and some fields
+   are protected by the corresponding root ``rcu_node`` structure's lock.
+#. Each ``rcu_node`` structure has a spinlock.
+#. The fields in ``rcu_data`` are private to the corresponding CPU,
+   although a few can be read and written by other CPUs.
+
+It is important to note that different data structures can have very
+different ideas about the state of RCU at any given time. For but one
+example, awareness of the start or end of a given RCU grace period
+propagates slowly through the data structures. This slow propagation is
+absolutely necessary for RCU to have good read-side performance. If this
+balkanized implementation seems foreign to you, one useful trick is to
+consider each instance of these data structures to be a different
+person, each having the usual slightly different view of reality.
+
+The general role of each of these data structures is as follows:
+
+#. ``rcu_state``: This structure forms the interconnection between the
+   ``rcu_node`` and ``rcu_data`` structures, tracks grace periods,
+   serves as short-term repository for callbacks orphaned by CPU-hotplug
+   events, maintains ``rcu_barrier()`` state, tracks expedited
+   grace-period state, and maintains state used to force quiescent
+   states when grace periods extend too long,
+#. ``rcu_node``: This structure forms the combining tree that propagates
+   quiescent-state information from the leaves to the root, and also
+   propagates grace-period information from the root to the leaves. It
+   provides local copies of the grace-period state in order to allow
+   this information to be accessed in a synchronized manner without
+   suffering the scalability limitations that would otherwise be imposed
+   by global locking. In ``CONFIG_PREEMPT_RCU`` kernels, it manages the
+   lists of tasks that have blocked while in their current RCU read-side
+   critical section. In ``CONFIG_PREEMPT_RCU`` with
+   ``CONFIG_RCU_BOOST``, it manages the per-\ ``rcu_node``
+   priority-boosting kernel threads (kthreads) and state. Finally, it
+   records CPU-hotplug state in order to determine which CPUs should be
+   ignored during a given grace period.
+#. ``rcu_data``: This per-CPU structure is the focus of quiescent-state
+   detection and RCU callback queuing. It also tracks its relationship
+   to the corresponding leaf ``rcu_node`` structure to allow
+   more-efficient propagation of quiescent states up the ``rcu_node``
+   combining tree. Like the ``rcu_node`` structure, it provides a local
+   copy of the grace-period information to allow for-free synchronized
+   access to this information from the corresponding CPU. Finally, this
+   structure records past dyntick-idle state for the corresponding CPU
+   and also tracks statistics.
+#. ``rcu_head``: This structure represents RCU callbacks, and is the
+   only structure allocated and managed by RCU users. The ``rcu_head``
+   structure is normally embedded within the RCU-protected data
+   structure.
+
+If all you wanted from this article was a general notion of how RCU's
+data structures are related, you are done. Otherwise, each of the
+following sections give more details on the ``rcu_state``, ``rcu_node``
+and ``rcu_data`` data structures.
+
+The ``rcu_state`` Structure
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``rcu_state`` structure is the base structure that represents the
+state of RCU in the system. This structure forms the interconnection
+between the ``rcu_node`` and ``rcu_data`` structures, tracks grace
+periods, contains the lock used to synchronize with CPU-hotplug events,
+and maintains state used to force quiescent states when grace periods
+extend too long,
+
+A few of the ``rcu_state`` structure's fields are discussed, singly and
+in groups, in the following sections. The more specialized fields are
+covered in the discussion of their use.
+
+Relationship to rcu_node and rcu_data Structures
+''''''''''''''''''''''''''''''''''''''''''''''''
+
+This portion of the ``rcu_state`` structure is declared as follows:
+
+::
+
+     1   struct rcu_node node[NUM_RCU_NODES];
+     2   struct rcu_node *level[NUM_RCU_LVLS + 1];
+     3   struct rcu_data __percpu *rda;
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Wait a minute! You said that the ``rcu_node`` structures formed a     |
+| tree, but they are declared as a flat array! What gives?              |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| The tree is laid out in the array. The first node In the array is the |
+| head, the next set of nodes in the array are children of the head     |
+| node, and so on until the last set of nodes in the array are the      |
+| leaves.                                                               |
+| See the following diagrams to see how this works.                     |
++-----------------------------------------------------------------------+
+
+The ``rcu_node`` tree is embedded into the ``->node[]`` array as shown
+in the following figure:
+
+.. kernel-figure:: TreeMapping.svg
+
+One interesting consequence of this mapping is that a breadth-first
+traversal of the tree is implemented as a simple linear scan of the
+array, which is in fact what the ``rcu_for_each_node_breadth_first()``
+macro does. This macro is used at the beginning and ends of grace
+periods.
+
+Each entry of the ``->level`` array references the first ``rcu_node``
+structure on the corresponding level of the tree, for example, as shown
+below:
+
+.. kernel-figure:: TreeMappingLevel.svg
+
+The zero\ :sup:`th` element of the array references the root
+``rcu_node`` structure, the first element references the first child of
+the root ``rcu_node``, and finally the second element references the
+first leaf ``rcu_node`` structure.
+
+For whatever it is worth, if you draw the tree to be tree-shaped rather
+than array-shaped, it is easy to draw a planar representation:
+
+.. kernel-figure:: TreeLevel.svg
+
+Finally, the ``->rda`` field references a per-CPU pointer to the
+corresponding CPU's ``rcu_data`` structure.
+
+All of these fields are constant once initialization is complete, and
+therefore need no protection.
+
+Grace-Period Tracking
+'''''''''''''''''''''
+
+This portion of the ``rcu_state`` structure is declared as follows:
+
+::
+
+     1   unsigned long gp_seq;
+
+RCU grace periods are numbered, and the ``->gp_seq`` field contains the
+current grace-period sequence number. The bottom two bits are the state
+of the current grace period, which can be zero for not yet started or
+one for in progress. In other words, if the bottom two bits of
+``->gp_seq`` are zero, then RCU is idle. Any other value in the bottom
+two bits indicates that something is broken. This field is protected by
+the root ``rcu_node`` structure's ``->lock`` field.
+
+There are ``->gp_seq`` fields in the ``rcu_node`` and ``rcu_data``
+structures as well. The fields in the ``rcu_state`` structure represent
+the most current value, and those of the other structures are compared
+in order to detect the beginnings and ends of grace periods in a
+distributed fashion. The values flow from ``rcu_state`` to ``rcu_node``
+(down the tree from the root to the leaves) to ``rcu_data``.
+
+Miscellaneous
+'''''''''''''
+
+This portion of the ``rcu_state`` structure is declared as follows:
+
+::
+
+     1   unsigned long gp_max;
+     2   char abbr;
+     3   char *name;
+
+The ``->gp_max`` field tracks the duration of the longest grace period
+in jiffies. It is protected by the root ``rcu_node``'s ``->lock``.
+
+The ``->name`` and ``->abbr`` fields distinguish between preemptible RCU
+(“rcu_preempt” and “p”) and non-preemptible RCU (“rcu_sched” and “s”).
+These fields are used for diagnostic and tracing purposes.
+
+The ``rcu_node`` Structure
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``rcu_node`` structures form the combining tree that propagates
+quiescent-state information from the leaves to the root and also that
+propagates grace-period information from the root down to the leaves.
+They provides local copies of the grace-period state in order to allow
+this information to be accessed in a synchronized manner without
+suffering the scalability limitations that would otherwise be imposed by
+global locking. In ``CONFIG_PREEMPT_RCU`` kernels, they manage the lists
+of tasks that have blocked while in their current RCU read-side critical
+section. In ``CONFIG_PREEMPT_RCU`` with ``CONFIG_RCU_BOOST``, they
+manage the per-\ ``rcu_node`` priority-boosting kernel threads
+(kthreads) and state. Finally, they record CPU-hotplug state in order to
+determine which CPUs should be ignored during a given grace period.
+
+The ``rcu_node`` structure's fields are discussed, singly and in groups,
+in the following sections.
+
+Connection to Combining Tree
+''''''''''''''''''''''''''''
+
+This portion of the ``rcu_node`` structure is declared as follows:
+
+::
+
+     1   struct rcu_node *parent;
+     2   u8 level;
+     3   u8 grpnum;
+     4   unsigned long grpmask;
+     5   int grplo;
+     6   int grphi;
+
+The ``->parent`` pointer references the ``rcu_node`` one level up in the
+tree, and is ``NULL`` for the root ``rcu_node``. The RCU implementation
+makes heavy use of this field to push quiescent states up the tree. The
+``->level`` field gives the level in the tree, with the root being at
+level zero, its children at level one, and so on. The ``->grpnum`` field
+gives this node's position within the children of its parent, so this
+number can range between 0 and 31 on 32-bit systems and between 0 and 63
+on 64-bit systems. The ``->level`` and ``->grpnum`` fields are used only
+during initialization and for tracing. The ``->grpmask`` field is the
+bitmask counterpart of ``->grpnum``, and therefore always has exactly
+one bit set. This mask is used to clear the bit corresponding to this
+``rcu_node`` structure in its parent's bitmasks, which are described
+later. Finally, the ``->grplo`` and ``->grphi`` fields contain the
+lowest and highest numbered CPU served by this ``rcu_node`` structure,
+respectively.
+
+All of these fields are constant, and thus do not require any
+synchronization.
+
+Synchronization
+'''''''''''''''
+
+This field of the ``rcu_node`` structure is declared as follows:
+
+::
+
+     1   raw_spinlock_t lock;
+
+This field is used to protect the remaining fields in this structure,
+unless otherwise stated. That said, all of the fields in this structure
+can be accessed without locking for tracing purposes. Yes, this can
+result in confusing traces, but better some tracing confusion than to be
+heisenbugged out of existence.
+
+.. _grace-period-tracking-1:
+
+Grace-Period Tracking
+'''''''''''''''''''''
+
+This portion of the ``rcu_node`` structure is declared as follows:
+
+::
+
+     1   unsigned long gp_seq;
+     2   unsigned long gp_seq_needed;
+
+The ``rcu_node`` structures' ``->gp_seq`` fields are the counterparts of
+the field of the same name in the ``rcu_state`` structure. They each may
+lag up to one step behind their ``rcu_state`` counterpart. If the bottom
+two bits of a given ``rcu_node`` structure's ``->gp_seq`` field is zero,
+then this ``rcu_node`` structure believes that RCU is idle.
+
+The ``>gp_seq`` field of each ``rcu_node`` structure is updated at the
+beginning and the end of each grace period.
+
+The ``->gp_seq_needed`` fields record the furthest-in-the-future grace
+period request seen by the corresponding ``rcu_node`` structure. The
+request is considered fulfilled when the value of the ``->gp_seq`` field
+equals or exceeds that of the ``->gp_seq_needed`` field.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Suppose that this ``rcu_node`` structure doesn't see a request for a  |
+| very long time. Won't wrapping of the ``->gp_seq`` field cause        |
+| problems?                                                             |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| No, because if the ``->gp_seq_needed`` field lags behind the          |
+| ``->gp_seq`` field, the ``->gp_seq_needed`` field will be updated at  |
+| the end of the grace period. Modulo-arithmetic comparisons therefore  |
+| will always get the correct answer, even with wrapping.               |
++-----------------------------------------------------------------------+
+
+Quiescent-State Tracking
+''''''''''''''''''''''''
+
+These fields manage the propagation of quiescent states up the combining
+tree.
+
+This portion of the ``rcu_node`` structure has fields as follows:
+
+::
+
+     1   unsigned long qsmask;
+     2   unsigned long expmask;
+     3   unsigned long qsmaskinit;
+     4   unsigned long expmaskinit;
+
+The ``->qsmask`` field tracks which of this ``rcu_node`` structure's
+children still need to report quiescent states for the current normal
+grace period. Such children will have a value of 1 in their
+corresponding bit. Note that the leaf ``rcu_node`` structures should be
+thought of as having ``rcu_data`` structures as their children.
+Similarly, the ``->expmask`` field tracks which of this ``rcu_node``
+structure's children still need to report quiescent states for the
+current expedited grace period. An expedited grace period has the same
+conceptual properties as a normal grace period, but the expedited
+implementation accepts extreme CPU overhead to obtain much lower
+grace-period latency, for example, consuming a few tens of microseconds
+worth of CPU time to reduce grace-period duration from milliseconds to
+tens of microseconds. The ``->qsmaskinit`` field tracks which of this
+``rcu_node`` structure's children cover for at least one online CPU.
+This mask is used to initialize ``->qsmask``, and ``->expmaskinit`` is
+used to initialize ``->expmask`` and the beginning of the normal and
+expedited grace periods, respectively.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Why are these bitmasks protected by locking? Come on, haven't you     |
+| heard of atomic instructions???                                       |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Lockless grace-period computation! Such a tantalizing possibility!    |
+| But consider the following sequence of events:                        |
+|                                                                       |
+| #. CPU 0 has been in dyntick-idle mode for quite some time. When it   |
+|    wakes up, it notices that the current RCU grace period needs it to |
+|    report in, so it sets a flag where the scheduling clock interrupt  |
+|    will find it.                                                      |
+| #. Meanwhile, CPU 1 is running ``force_quiescent_state()``, and       |
+|    notices that CPU 0 has been in dyntick idle mode, which qualifies  |
+|    as an extended quiescent state.                                    |
+| #. CPU 0's scheduling clock interrupt fires in the middle of an RCU   |
+|    read-side critical section, and notices that the RCU core needs    |
+|    something, so commences RCU softirq processing.                    |
+| #. CPU 0's softirq handler executes and is just about ready to report |
+|    its quiescent state up the ``rcu_node`` tree.                      |
+| #. But CPU 1 beats it to the punch, completing the current grace      |
+|    period and starting a new one.                                     |
+| #. CPU 0 now reports its quiescent state for the wrong grace period.  |
+|    That grace period might now end before the RCU read-side critical  |
+|    section. If that happens, disaster will ensue.                     |
+|                                                                       |
+| So the locking is absolutely required in order to coordinate clearing |
+| of the bits with updating of the grace-period sequence number in      |
+| ``->gp_seq``.                                                         |
++-----------------------------------------------------------------------+
+
+Blocked-Task Management
+'''''''''''''''''''''''
+
+``PREEMPT_RCU`` allows tasks to be preempted in the midst of their RCU
+read-side critical sections, and these tasks must be tracked explicitly.
+The details of exactly why and how they are tracked will be covered in a
+separate article on RCU read-side processing. For now, it is enough to
+know that the ``rcu_node`` structure tracks them.
+
+::
+
+     1   struct list_head blkd_tasks;
+     2   struct list_head *gp_tasks;
+     3   struct list_head *exp_tasks;
+     4   bool wait_blkd_tasks;
+
+The ``->blkd_tasks`` field is a list header for the list of blocked and
+preempted tasks. As tasks undergo context switches within RCU read-side
+critical sections, their ``task_struct`` structures are enqueued (via
+the ``task_struct``'s ``->rcu_node_entry`` field) onto the head of the
+``->blkd_tasks`` list for the leaf ``rcu_node`` structure corresponding
+to the CPU on which the outgoing context switch executed. As these tasks
+later exit their RCU read-side critical sections, they remove themselves
+from the list. This list is therefore in reverse time order, so that if
+one of the tasks is blocking the current grace period, all subsequent
+tasks must also be blocking that same grace period. Therefore, a single
+pointer into this list suffices to track all tasks blocking a given
+grace period. That pointer is stored in ``->gp_tasks`` for normal grace
+periods and in ``->exp_tasks`` for expedited grace periods. These last
+two fields are ``NULL`` if either there is no grace period in flight or
+if there are no blocked tasks preventing that grace period from
+completing. If either of these two pointers is referencing a task that
+removes itself from the ``->blkd_tasks`` list, then that task must
+advance the pointer to the next task on the list, or set the pointer to
+``NULL`` if there are no subsequent tasks on the list.
+
+For example, suppose that tasks T1, T2, and T3 are all hard-affinitied
+to the largest-numbered CPU in the system. Then if task T1 blocked in an
+RCU read-side critical section, then an expedited grace period started,
+then task T2 blocked in an RCU read-side critical section, then a normal
+grace period started, and finally task 3 blocked in an RCU read-side
+critical section, then the state of the last leaf ``rcu_node``
+structure's blocked-task list would be as shown below:
+
+.. kernel-figure:: blkd_task.svg
+
+Task T1 is blocking both grace periods, task T2 is blocking only the
+normal grace period, and task T3 is blocking neither grace period. Note
+that these tasks will not remove themselves from this list immediately
+upon resuming execution. They will instead remain on the list until they
+execute the outermost ``rcu_read_unlock()`` that ends their RCU
+read-side critical section.
+
+The ``->wait_blkd_tasks`` field indicates whether or not the current
+grace period is waiting on a blocked task.
+
+Sizing the ``rcu_node`` Array
+'''''''''''''''''''''''''''''
+
+The ``rcu_node`` array is sized via a series of C-preprocessor
+expressions as follows:
+
+::
+
+    1 #ifdef CONFIG_RCU_FANOUT
+    2 #define RCU_FANOUT CONFIG_RCU_FANOUT
+    3 #else
+    4 # ifdef CONFIG_64BIT
+    5 # define RCU_FANOUT 64
+    6 # else
+    7 # define RCU_FANOUT 32
+    8 # endif
+    9 #endif
+   10
+   11 #ifdef CONFIG_RCU_FANOUT_LEAF
+   12 #define RCU_FANOUT_LEAF CONFIG_RCU_FANOUT_LEAF
+   13 #else
+   14 # ifdef CONFIG_64BIT
+   15 # define RCU_FANOUT_LEAF 64
+   16 # else
+   17 # define RCU_FANOUT_LEAF 32
+   18 # endif
+   19 #endif
+   20
+   21 #define RCU_FANOUT_1        (RCU_FANOUT_LEAF)
+   22 #define RCU_FANOUT_2        (RCU_FANOUT_1 * RCU_FANOUT)
+   23 #define RCU_FANOUT_3        (RCU_FANOUT_2 * RCU_FANOUT)
+   24 #define RCU_FANOUT_4        (RCU_FANOUT_3 * RCU_FANOUT)
+   25
+   26 #if NR_CPUS <= RCU_FANOUT_1
+   27 #  define RCU_NUM_LVLS        1
+   28 #  define NUM_RCU_LVL_0        1
+   29 #  define NUM_RCU_NODES        NUM_RCU_LVL_0
+   30 #  define NUM_RCU_LVL_INIT    { NUM_RCU_LVL_0 }
+   31 #  define RCU_NODE_NAME_INIT  { "rcu_node_0" }
+   32 #  define RCU_FQS_NAME_INIT   { "rcu_node_fqs_0" }
+   33 #  define RCU_EXP_NAME_INIT   { "rcu_node_exp_0" }
+   34 #elif NR_CPUS <= RCU_FANOUT_2
+   35 #  define RCU_NUM_LVLS        2
+   36 #  define NUM_RCU_LVL_0        1
+   37 #  define NUM_RCU_LVL_1        DIV_ROUND_UP(NR_CPUS, RCU_FANOUT_1)
+   38 #  define NUM_RCU_NODES        (NUM_RCU_LVL_0 + NUM_RCU_LVL_1)
+   39 #  define NUM_RCU_LVL_INIT    { NUM_RCU_LVL_0, NUM_RCU_LVL_1 }
+   40 #  define RCU_NODE_NAME_INIT  { "rcu_node_0", "rcu_node_1" }
+   41 #  define RCU_FQS_NAME_INIT   { "rcu_node_fqs_0", "rcu_node_fqs_1" }
+   42 #  define RCU_EXP_NAME_INIT   { "rcu_node_exp_0", "rcu_node_exp_1" }
+   43 #elif NR_CPUS <= RCU_FANOUT_3
+   44 #  define RCU_NUM_LVLS        3
+   45 #  define NUM_RCU_LVL_0        1
+   46 #  define NUM_RCU_LVL_1        DIV_ROUND_UP(NR_CPUS, RCU_FANOUT_2)
+   47 #  define NUM_RCU_LVL_2        DIV_ROUND_UP(NR_CPUS, RCU_FANOUT_1)
+   48 #  define NUM_RCU_NODES        (NUM_RCU_LVL_0 + NUM_RCU_LVL_1 + NUM_RCU_LVL_2)
+   49 #  define NUM_RCU_LVL_INIT    { NUM_RCU_LVL_0, NUM_RCU_LVL_1, NUM_RCU_LVL_2 }
+   50 #  define RCU_NODE_NAME_INIT  { "rcu_node_0", "rcu_node_1", "rcu_node_2" }
+   51 #  define RCU_FQS_NAME_INIT   { "rcu_node_fqs_0", "rcu_node_fqs_1", "rcu_node_fqs_2" }
+   52 #  define RCU_EXP_NAME_INIT   { "rcu_node_exp_0", "rcu_node_exp_1", "rcu_node_exp_2" }
+   53 #elif NR_CPUS <= RCU_FANOUT_4
+   54 #  define RCU_NUM_LVLS        4
+   55 #  define NUM_RCU_LVL_0        1
+   56 #  define NUM_RCU_LVL_1        DIV_ROUND_UP(NR_CPUS, RCU_FANOUT_3)
+   57 #  define NUM_RCU_LVL_2        DIV_ROUND_UP(NR_CPUS, RCU_FANOUT_2)
+   58 #  define NUM_RCU_LVL_3        DIV_ROUND_UP(NR_CPUS, RCU_FANOUT_1)
+   59 #  define NUM_RCU_NODES        (NUM_RCU_LVL_0 + NUM_RCU_LVL_1 + NUM_RCU_LVL_2 + NUM_RCU_LVL_3)
+   60 #  define NUM_RCU_LVL_INIT    { NUM_RCU_LVL_0, NUM_RCU_LVL_1, NUM_RCU_LVL_2, NUM_RCU_LVL_3 }
+   61 #  define RCU_NODE_NAME_INIT  { "rcu_node_0", "rcu_node_1", "rcu_node_2", "rcu_node_3" }
+   62 #  define RCU_FQS_NAME_INIT   { "rcu_node_fqs_0", "rcu_node_fqs_1", "rcu_node_fqs_2", "rcu_node_fqs_3" }
+   63 #  define RCU_EXP_NAME_INIT   { "rcu_node_exp_0", "rcu_node_exp_1", "rcu_node_exp_2", "rcu_node_exp_3" }
+   64 #else
+   65 # error "CONFIG_RCU_FANOUT insufficient for NR_CPUS"
+   66 #endif
+
+The maximum number of levels in the ``rcu_node`` structure is currently
+limited to four, as specified by lines 21-24 and the structure of the
+subsequent “if” statement. For 32-bit systems, this allows
+16*32*32*32=524,288 CPUs, which should be sufficient for the next few
+years at least. For 64-bit systems, 16*64*64*64=4,194,304 CPUs is
+allowed, which should see us through the next decade or so. This
+four-level tree also allows kernels built with ``CONFIG_RCU_FANOUT=8``
+to support up to 4096 CPUs, which might be useful in very large systems
+having eight CPUs per socket (but please note that no one has yet shown
+any measurable performance degradation due to misaligned socket and
+``rcu_node`` boundaries). In addition, building kernels with a full four
+levels of ``rcu_node`` tree permits better testing of RCU's
+combining-tree code.
+
+The ``RCU_FANOUT`` symbol controls how many children are permitted at
+each non-leaf level of the ``rcu_node`` tree. If the
+``CONFIG_RCU_FANOUT`` Kconfig option is not specified, it is set based
+on the word size of the system, which is also the Kconfig default.
+
+The ``RCU_FANOUT_LEAF`` symbol controls how many CPUs are handled by
+each leaf ``rcu_node`` structure. Experience has shown that allowing a
+given leaf ``rcu_node`` structure to handle 64 CPUs, as permitted by the
+number of bits in the ``->qsmask`` field on a 64-bit system, results in
+excessive contention for the leaf ``rcu_node`` structures' ``->lock``
+fields. The number of CPUs per leaf ``rcu_node`` structure is therefore
+limited to 16 given the default value of ``CONFIG_RCU_FANOUT_LEAF``. If
+``CONFIG_RCU_FANOUT_LEAF`` is unspecified, the value selected is based
+on the word size of the system, just as for ``CONFIG_RCU_FANOUT``.
+Lines 11-19 perform this computation.
+
+Lines 21-24 compute the maximum number of CPUs supported by a
+single-level (which contains a single ``rcu_node`` structure),
+two-level, three-level, and four-level ``rcu_node`` tree, respectively,
+given the fanout specified by ``RCU_FANOUT`` and ``RCU_FANOUT_LEAF``.
+These numbers of CPUs are retained in the ``RCU_FANOUT_1``,
+``RCU_FANOUT_2``, ``RCU_FANOUT_3``, and ``RCU_FANOUT_4`` C-preprocessor
+variables, respectively.
+
+These variables are used to control the C-preprocessor ``#if`` statement
+spanning lines 26-66 that computes the number of ``rcu_node`` structures
+required for each level of the tree, as well as the number of levels
+required. The number of levels is placed in the ``NUM_RCU_LVLS``
+C-preprocessor variable by lines 27, 35, 44, and 54. The number of
+``rcu_node`` structures for the topmost level of the tree is always
+exactly one, and this value is unconditionally placed into
+``NUM_RCU_LVL_0`` by lines 28, 36, 45, and 55. The rest of the levels
+(if any) of the ``rcu_node`` tree are computed by dividing the maximum
+number of CPUs by the fanout supported by the number of levels from the
+current level down, rounding up. This computation is performed by
+lines 37, 46-47, and 56-58. Lines 31-33, 40-42, 50-52, and 62-63 create
+initializers for lockdep lock-class names. Finally, lines 64-66 produce
+an error if the maximum number of CPUs is too large for the specified
+fanout.
+
+The ``rcu_segcblist`` Structure
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``rcu_segcblist`` structure maintains a segmented list of callbacks
+as follows:
+
+::
+
+    1 #define RCU_DONE_TAIL        0
+    2 #define RCU_WAIT_TAIL        1
+    3 #define RCU_NEXT_READY_TAIL  2
+    4 #define RCU_NEXT_TAIL        3
+    5 #define RCU_CBLIST_NSEGS     4
+    6
+    7 struct rcu_segcblist {
+    8   struct rcu_head *head;
+    9   struct rcu_head **tails[RCU_CBLIST_NSEGS];
+   10   unsigned long gp_seq[RCU_CBLIST_NSEGS];
+   11   long len;
+   12   long len_lazy;
+   13 };
+
+The segments are as follows:
+
+#. ``RCU_DONE_TAIL``: Callbacks whose grace periods have elapsed. These
+   callbacks are ready to be invoked.
+#. ``RCU_WAIT_TAIL``: Callbacks that are waiting for the current grace
+   period. Note that different CPUs can have different ideas about which
+   grace period is current, hence the ``->gp_seq`` field.
+#. ``RCU_NEXT_READY_TAIL``: Callbacks waiting for the next grace period
+   to start.
+#. ``RCU_NEXT_TAIL``: Callbacks that have not yet been associated with a
+   grace period.
+
+The ``->head`` pointer references the first callback or is ``NULL`` if
+the list contains no callbacks (which is *not* the same as being empty).
+Each element of the ``->tails[]`` array references the ``->next``
+pointer of the last callback in the corresponding segment of the list,
+or the list's ``->head`` pointer if that segment and all previous
+segments are empty. If the corresponding segment is empty but some
+previous segment is not empty, then the array element is identical to
+its predecessor. Older callbacks are closer to the head of the list, and
+new callbacks are added at the tail. This relationship between the
+``->head`` pointer, the ``->tails[]`` array, and the callbacks is shown
+in this diagram:
+
+.. kernel-figure:: nxtlist.svg
+
+In this figure, the ``->head`` pointer references the first RCU callback
+in the list. The ``->tails[RCU_DONE_TAIL]`` array element references the
+``->head`` pointer itself, indicating that none of the callbacks is
+ready to invoke. The ``->tails[RCU_WAIT_TAIL]`` array element references
+callback CB 2's ``->next`` pointer, which indicates that CB 1 and CB 2
+are both waiting on the current grace period, give or take possible
+disagreements about exactly which grace period is the current one. The
+``->tails[RCU_NEXT_READY_TAIL]`` array element references the same RCU
+callback that ``->tails[RCU_WAIT_TAIL]`` does, which indicates that
+there are no callbacks waiting on the next RCU grace period. The
+``->tails[RCU_NEXT_TAIL]`` array element references CB 4's ``->next``
+pointer, indicating that all the remaining RCU callbacks have not yet
+been assigned to an RCU grace period. Note that the
+``->tails[RCU_NEXT_TAIL]`` array element always references the last RCU
+callback's ``->next`` pointer unless the callback list is empty, in
+which case it references the ``->head`` pointer.
+
+There is one additional important special case for the
+``->tails[RCU_NEXT_TAIL]`` array element: It can be ``NULL`` when this
+list is *disabled*. Lists are disabled when the corresponding CPU is
+offline or when the corresponding CPU's callbacks are offloaded to a
+kthread, both of which are described elsewhere.
+
+CPUs advance their callbacks from the ``RCU_NEXT_TAIL`` to the
+``RCU_NEXT_READY_TAIL`` to the ``RCU_WAIT_TAIL`` to the
+``RCU_DONE_TAIL`` list segments as grace periods advance.
+
+The ``->gp_seq[]`` array records grace-period numbers corresponding to
+the list segments. This is what allows different CPUs to have different
+ideas as to which is the current grace period while still avoiding
+premature invocation of their callbacks. In particular, this allows CPUs
+that go idle for extended periods to determine which of their callbacks
+are ready to be invoked after reawakening.
+
+The ``->len`` counter contains the number of callbacks in ``->head``,
+and the ``->len_lazy`` contains the number of those callbacks that are
+known to only free memory, and whose invocation can therefore be safely
+deferred.
+
+.. important::
+
+   It is the ``->len`` field that determines whether or
+   not there are callbacks associated with this ``rcu_segcblist``
+   structure, *not* the ``->head`` pointer. The reason for this is that all
+   the ready-to-invoke callbacks (that is, those in the ``RCU_DONE_TAIL``
+   segment) are extracted all at once at callback-invocation time
+   (``rcu_do_batch``), due to which ``->head`` may be set to NULL if there
+   are no not-done callbacks remaining in the ``rcu_segcblist``. If
+   callback invocation must be postponed, for example, because a
+   high-priority process just woke up on this CPU, then the remaining
+   callbacks are placed back on the ``RCU_DONE_TAIL`` segment and
+   ``->head`` once again points to the start of the segment. In short, the
+   head field can briefly be ``NULL`` even though the CPU has callbacks
+   present the entire time. Therefore, it is not appropriate to test the
+   ``->head`` pointer for ``NULL``.
+
+In contrast, the ``->len`` and ``->len_lazy`` counts are adjusted only
+after the corresponding callbacks have been invoked. This means that the
+``->len`` count is zero only if the ``rcu_segcblist`` structure really
+is devoid of callbacks. Of course, off-CPU sampling of the ``->len``
+count requires careful use of appropriate synchronization, for example,
+memory barriers. This synchronization can be a bit subtle, particularly
+in the case of ``rcu_barrier()``.
+
+The ``rcu_data`` Structure
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``rcu_data`` maintains the per-CPU state for the RCU subsystem. The
+fields in this structure may be accessed only from the corresponding CPU
+(and from tracing) unless otherwise stated. This structure is the focus
+of quiescent-state detection and RCU callback queuing. It also tracks
+its relationship to the corresponding leaf ``rcu_node`` structure to
+allow more-efficient propagation of quiescent states up the ``rcu_node``
+combining tree. Like the ``rcu_node`` structure, it provides a local
+copy of the grace-period information to allow for-free synchronized
+access to this information from the corresponding CPU. Finally, this
+structure records past dyntick-idle state for the corresponding CPU and
+also tracks statistics.
+
+The ``rcu_data`` structure's fields are discussed, singly and in groups,
+in the following sections.
+
+Connection to Other Data Structures
+'''''''''''''''''''''''''''''''''''
+
+This portion of the ``rcu_data`` structure is declared as follows:
+
+::
+
+     1   int cpu;
+     2   struct rcu_node *mynode;
+     3   unsigned long grpmask;
+     4   bool beenonline;
+
+The ``->cpu`` field contains the number of the corresponding CPU and the
+``->mynode`` field references the corresponding ``rcu_node`` structure.
+The ``->mynode`` is used to propagate quiescent states up the combining
+tree. These two fields are constant and therefore do not require
+synchronization.
+
+The ``->grpmask`` field indicates the bit in the ``->mynode->qsmask``
+corresponding to this ``rcu_data`` structure, and is also used when
+propagating quiescent states. The ``->beenonline`` flag is set whenever
+the corresponding CPU comes online, which means that the debugfs tracing
+need not dump out any ``rcu_data`` structure for which this flag is not
+set.
+
+Quiescent-State and Grace-Period Tracking
+'''''''''''''''''''''''''''''''''''''''''
+
+This portion of the ``rcu_data`` structure is declared as follows:
+
+::
+
+     1   unsigned long gp_seq;
+     2   unsigned long gp_seq_needed;
+     3   bool cpu_no_qs;
+     4   bool core_needs_qs;
+     5   bool gpwrap;
+
+The ``->gp_seq`` field is the counterpart of the field of the same name
+in the ``rcu_state`` and ``rcu_node`` structures. The
+``->gp_seq_needed`` field is the counterpart of the field of the same
+name in the rcu_node structure. They may each lag up to one behind their
+``rcu_node`` counterparts, but in ``CONFIG_NO_HZ_IDLE`` and
+``CONFIG_NO_HZ_FULL`` kernels can lag arbitrarily far behind for CPUs in
+dyntick-idle mode (but these counters will catch up upon exit from
+dyntick-idle mode). If the lower two bits of a given ``rcu_data``
+structure's ``->gp_seq`` are zero, then this ``rcu_data`` structure
+believes that RCU is idle.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| All this replication of the grace period numbers can only cause       |
+| massive confusion. Why not just keep a global sequence number and be  |
+| done with it???                                                       |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Because if there was only a single global sequence numbers, there     |
+| would need to be a single global lock to allow safely accessing and   |
+| updating it. And if we are not going to have a single global lock, we |
+| need to carefully manage the numbers on a per-node basis. Recall from |
+| the answer to a previous Quick Quiz that the consequences of applying |
+| a previously sampled quiescent state to the wrong grace period are    |
+| quite severe.                                                         |
++-----------------------------------------------------------------------+
+
+The ``->cpu_no_qs`` flag indicates that the CPU has not yet passed
+through a quiescent state, while the ``->core_needs_qs`` flag indicates
+that the RCU core needs a quiescent state from the corresponding CPU.
+The ``->gpwrap`` field indicates that the corresponding CPU has remained
+idle for so long that the ``gp_seq`` counter is in danger of overflow,
+which will cause the CPU to disregard the values of its counters on its
+next exit from idle.
+
+RCU Callback Handling
+'''''''''''''''''''''
+
+In the absence of CPU-hotplug events, RCU callbacks are invoked by the
+same CPU that registered them. This is strictly a cache-locality
+optimization: callbacks can and do get invoked on CPUs other than the
+one that registered them. After all, if the CPU that registered a given
+callback has gone offline before the callback can be invoked, there
+really is no other choice.
+
+This portion of the ``rcu_data`` structure is declared as follows:
+
+::
+
+    1 struct rcu_segcblist cblist;
+    2 long qlen_last_fqs_check;
+    3 unsigned long n_cbs_invoked;
+    4 unsigned long n_nocbs_invoked;
+    5 unsigned long n_cbs_orphaned;
+    6 unsigned long n_cbs_adopted;
+    7 unsigned long n_force_qs_snap;
+    8 long blimit;
+
+The ``->cblist`` structure is the segmented callback list described
+earlier. The CPU advances the callbacks in its ``rcu_data`` structure
+whenever it notices that another RCU grace period has completed. The CPU
+detects the completion of an RCU grace period by noticing that the value
+of its ``rcu_data`` structure's ``->gp_seq`` field differs from that of
+its leaf ``rcu_node`` structure. Recall that each ``rcu_node``
+structure's ``->gp_seq`` field is updated at the beginnings and ends of
+each grace period.
+
+The ``->qlen_last_fqs_check`` and ``->n_force_qs_snap`` coordinate the
+forcing of quiescent states from ``call_rcu()`` and friends when
+callback lists grow excessively long.
+
+The ``->n_cbs_invoked``, ``->n_cbs_orphaned``, and ``->n_cbs_adopted``
+fields count the number of callbacks invoked, sent to other CPUs when
+this CPU goes offline, and received from other CPUs when those other
+CPUs go offline. The ``->n_nocbs_invoked`` is used when the CPU's
+callbacks are offloaded to a kthread.
+
+Finally, the ``->blimit`` counter is the maximum number of RCU callbacks
+that may be invoked at a given time.
+
+Dyntick-Idle Handling
+'''''''''''''''''''''
+
+This portion of the ``rcu_data`` structure is declared as follows:
+
+::
+
+     1   int dynticks_snap;
+     2   unsigned long dynticks_fqs;
+
+The ``->dynticks_snap`` field is used to take a snapshot of the
+corresponding CPU's dyntick-idle state when forcing quiescent states,
+and is therefore accessed from other CPUs. Finally, the
+``->dynticks_fqs`` field is used to count the number of times this CPU
+is determined to be in dyntick-idle state, and is used for tracing and
+debugging purposes.
+
+This portion of the rcu_data structure is declared as follows:
+
+::
+
+     1   long dynticks_nesting;
+     2   long dynticks_nmi_nesting;
+     3   atomic_t dynticks;
+     4   bool rcu_need_heavy_qs;
+     5   bool rcu_urgent_qs;
+
+These fields in the rcu_data structure maintain the per-CPU dyntick-idle
+state for the corresponding CPU. The fields may be accessed only from
+the corresponding CPU (and from tracing) unless otherwise stated.
+
+The ``->dynticks_nesting`` field counts the nesting depth of process
+execution, so that in normal circumstances this counter has value zero
+or one. NMIs, irqs, and tracers are counted by the
+``->dynticks_nmi_nesting`` field. Because NMIs cannot be masked, changes
+to this variable have to be undertaken carefully using an algorithm
+provided by Andy Lutomirski. The initial transition from idle adds one,
+and nested transitions add two, so that a nesting level of five is
+represented by a ``->dynticks_nmi_nesting`` value of nine. This counter
+can therefore be thought of as counting the number of reasons why this
+CPU cannot be permitted to enter dyntick-idle mode, aside from
+process-level transitions.
+
+However, it turns out that when running in non-idle kernel context, the
+Linux kernel is fully capable of entering interrupt handlers that never
+exit and perhaps also vice versa. Therefore, whenever the
+``->dynticks_nesting`` field is incremented up from zero, the
+``->dynticks_nmi_nesting`` field is set to a large positive number, and
+whenever the ``->dynticks_nesting`` field is decremented down to zero,
+the the ``->dynticks_nmi_nesting`` field is set to zero. Assuming that
+the number of misnested interrupts is not sufficient to overflow the
+counter, this approach corrects the ``->dynticks_nmi_nesting`` field
+every time the corresponding CPU enters the idle loop from process
+context.
+
+The ``->dynticks`` field counts the corresponding CPU's transitions to
+and from either dyntick-idle or user mode, so that this counter has an
+even value when the CPU is in dyntick-idle mode or user mode and an odd
+value otherwise. The transitions to/from user mode need to be counted
+for user mode adaptive-ticks support (see timers/NO_HZ.txt).
+
+The ``->rcu_need_heavy_qs`` field is used to record the fact that the
+RCU core code would really like to see a quiescent state from the
+corresponding CPU, so much so that it is willing to call for
+heavy-weight dyntick-counter operations. This flag is checked by RCU's
+context-switch and ``cond_resched()`` code, which provide a momentary
+idle sojourn in response.
+
+Finally, the ``->rcu_urgent_qs`` field is used to record the fact that
+the RCU core code would really like to see a quiescent state from the
+corresponding CPU, with the various other fields indicating just how
+badly RCU wants this quiescent state. This flag is checked by RCU's
+context-switch path (``rcu_note_context_switch``) and the cond_resched
+code.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Why not simply combine the ``->dynticks_nesting`` and                 |
+| ``->dynticks_nmi_nesting`` counters into a single counter that just   |
+| counts the number of reasons that the corresponding CPU is non-idle?  |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Because this would fail in the presence of interrupts whose handlers  |
+| never return and of handlers that manage to return from a made-up     |
+| interrupt.                                                            |
++-----------------------------------------------------------------------+
+
+Additional fields are present for some special-purpose builds, and are
+discussed separately.
+
+The ``rcu_head`` Structure
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Each ``rcu_head`` structure represents an RCU callback. These structures
+are normally embedded within RCU-protected data structures whose
+algorithms use asynchronous grace periods. In contrast, when using
+algorithms that block waiting for RCU grace periods, RCU users need not
+provide ``rcu_head`` structures.
+
+The ``rcu_head`` structure has fields as follows:
+
+::
+
+     1   struct rcu_head *next;
+     2   void (*func)(struct rcu_head *head);
+
+The ``->next`` field is used to link the ``rcu_head`` structures
+together in the lists within the ``rcu_data`` structures. The ``->func``
+field is a pointer to the function to be called when the callback is
+ready to be invoked, and this function is passed a pointer to the
+``rcu_head`` structure. However, ``kfree_rcu()`` uses the ``->func``
+field to record the offset of the ``rcu_head`` structure within the
+enclosing RCU-protected data structure.
+
+Both of these fields are used internally by RCU. From the viewpoint of
+RCU users, this structure is an opaque “cookie”.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Given that the callback function ``->func`` is passed a pointer to    |
+| the ``rcu_head`` structure, how is that function supposed to find the |
+| beginning of the enclosing RCU-protected data structure?              |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| In actual practice, there is a separate callback function per type of |
+| RCU-protected data structure. The callback function can therefore use |
+| the ``container_of()`` macro in the Linux kernel (or other            |
+| pointer-manipulation facilities in other software environments) to    |
+| find the beginning of the enclosing structure.                        |
++-----------------------------------------------------------------------+
+
+RCU-Specific Fields in the ``task_struct`` Structure
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``CONFIG_PREEMPT_RCU`` implementation uses some additional fields in
+the ``task_struct`` structure:
+
+::
+
+    1 #ifdef CONFIG_PREEMPT_RCU
+    2   int rcu_read_lock_nesting;
+    3   union rcu_special rcu_read_unlock_special;
+    4   struct list_head rcu_node_entry;
+    5   struct rcu_node *rcu_blocked_node;
+    6 #endif /* #ifdef CONFIG_PREEMPT_RCU */
+    7 #ifdef CONFIG_TASKS_RCU
+    8   unsigned long rcu_tasks_nvcsw;
+    9   bool rcu_tasks_holdout;
+   10   struct list_head rcu_tasks_holdout_list;
+   11   int rcu_tasks_idle_cpu;
+   12 #endif /* #ifdef CONFIG_TASKS_RCU */
+
+The ``->rcu_read_lock_nesting`` field records the nesting level for RCU
+read-side critical sections, and the ``->rcu_read_unlock_special`` field
+is a bitmask that records special conditions that require
+``rcu_read_unlock()`` to do additional work. The ``->rcu_node_entry``
+field is used to form lists of tasks that have blocked within
+preemptible-RCU read-side critical sections and the
+``->rcu_blocked_node`` field references the ``rcu_node`` structure whose
+list this task is a member of, or ``NULL`` if it is not blocked within a
+preemptible-RCU read-side critical section.
+
+The ``->rcu_tasks_nvcsw`` field tracks the number of voluntary context
+switches that this task had undergone at the beginning of the current
+tasks-RCU grace period, ``->rcu_tasks_holdout`` is set if the current
+tasks-RCU grace period is waiting on this task,
+``->rcu_tasks_holdout_list`` is a list element enqueuing this task on
+the holdout list, and ``->rcu_tasks_idle_cpu`` tracks which CPU this
+idle task is running, but only if the task is currently running, that
+is, if the CPU is currently idle.
+
+Accessor Functions
+~~~~~~~~~~~~~~~~~~
+
+The following listing shows the ``rcu_get_root()``,
+``rcu_for_each_node_breadth_first`` and ``rcu_for_each_leaf_node()``
+function and macros:
+
+::
+
+     1 static struct rcu_node *rcu_get_root(struct rcu_state *rsp)
+     2 {
+     3   return &rsp->node[0];
+     4 }
+     5
+     6 #define rcu_for_each_node_breadth_first(rsp, rnp) \
+     7   for ((rnp) = &(rsp)->node[0]; \
+     8        (rnp) < &(rsp)->node[NUM_RCU_NODES]; (rnp)++)
+     9
+    10 #define rcu_for_each_leaf_node(rsp, rnp) \
+    11   for ((rnp) = (rsp)->level[NUM_RCU_LVLS - 1]; \
+    12        (rnp) < &(rsp)->node[NUM_RCU_NODES]; (rnp)++)
+
+The ``rcu_get_root()`` simply returns a pointer to the first element of
+the specified ``rcu_state`` structure's ``->node[]`` array, which is the
+root ``rcu_node`` structure.
+
+As noted earlier, the ``rcu_for_each_node_breadth_first()`` macro takes
+advantage of the layout of the ``rcu_node`` structures in the
+``rcu_state`` structure's ``->node[]`` array, performing a breadth-first
+traversal by simply traversing the array in order. Similarly, the
+``rcu_for_each_leaf_node()`` macro traverses only the last part of the
+array, thus traversing only the leaf ``rcu_node`` structures.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| What does ``rcu_for_each_leaf_node()`` do if the ``rcu_node`` tree    |
+| contains only a single node?                                          |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| In the single-node case, ``rcu_for_each_leaf_node()`` traverses the   |
+| single node.                                                          |
++-----------------------------------------------------------------------+
+
+Summary
+~~~~~~~
+
+So the state of RCU is represented by an ``rcu_state`` structure, which
+contains a combining tree of ``rcu_node`` and ``rcu_data`` structures.
+Finally, in ``CONFIG_NO_HZ_IDLE`` kernels, each CPU's dyntick-idle state
+is tracked by dynticks-related fields in the ``rcu_data`` structure. If
+you made it this far, you are well prepared to read the code
+walkthroughs in the other articles in this series.
+
+Acknowledgments
+~~~~~~~~~~~~~~~
+
+I owe thanks to Cyrill Gorcunov, Mathieu Desnoyers, Dhaval Giani, Paul
+Turner, Abhishek Srivastava, Matt Kowalczyk, and Serge Hallyn for
+helping me get this document into a more human-readable state.
+
+Legal Statement
+~~~~~~~~~~~~~~~
+
+This work represents the view of the author and does not necessarily
+represent the view of IBM.
+
+Linux is a registered trademark of Linus Torvalds.
+
+Other company, product, and service names may be trademarks or service
+marks of others.
diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
deleted file mode 100644
index 57300db4b5ff..000000000000
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
+++ /dev/null
@@ -1,668 +0,0 @@
-<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
-        "http://www.w3.org/TR/html4/loose.dtd">
-        <html>
-        <head><title>A Tour Through TREE_RCU's Expedited Grace Periods</title>
-        <meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
-
-<h2>Introduction</h2>
-
-This document describes RCU's expedited grace periods.
-Unlike RCU's normal grace periods, which accept long latencies to attain
-high efficiency and minimal disturbance, expedited grace periods accept
-lower efficiency and significant disturbance to attain shorter latencies.
-
-<p>
-There are two flavors of RCU (RCU-preempt and RCU-sched), with an earlier
-third RCU-bh flavor having been implemented in terms of the other two.
-Each of the two implementations is covered in its own section.
-
-<ol>
-<li>	<a href="#Expedited Grace Period Design">
-	Expedited Grace Period Design</a>
-<li>	<a href="#RCU-preempt Expedited Grace Periods">
-	RCU-preempt Expedited Grace Periods</a>
-<li>	<a href="#RCU-sched Expedited Grace Periods">
-	RCU-sched Expedited Grace Periods</a>
-<li>	<a href="#Expedited Grace Period and CPU Hotplug">
-	Expedited Grace Period and CPU Hotplug</a>
-<li>	<a href="#Expedited Grace Period Refinements">
-	Expedited Grace Period Refinements</a>
-</ol>
-
-<h2><a name="Expedited Grace Period Design">
-Expedited Grace Period Design</a></h2>
-
-<p>
-The expedited RCU grace periods cannot be accused of being subtle,
-given that they for all intents and purposes hammer every CPU that
-has not yet provided a quiescent state for the current expedited
-grace period.
-The one saving grace is that the hammer has grown a bit smaller
-over time:  The old call to <tt>try_stop_cpus()</tt> has been
-replaced with a set of calls to <tt>smp_call_function_single()</tt>,
-each of which results in an IPI to the target CPU.
-The corresponding handler function checks the CPU's state, motivating
-a faster quiescent state where possible, and triggering a report
-of that quiescent state.
-As always for RCU, once everything has spent some time in a quiescent
-state, the expedited grace period has completed.
-
-<p>
-The details of the <tt>smp_call_function_single()</tt> handler's
-operation depend on the RCU flavor, as described in the following
-sections.
-
-<h2><a name="RCU-preempt Expedited Grace Periods">
-RCU-preempt Expedited Grace Periods</a></h2>
-
-<p>
-<tt>CONFIG_PREEMPT=y</tt> kernels implement RCU-preempt.
-The overall flow of the handling of a given CPU by an RCU-preempt
-expedited grace period is shown in the following diagram:
-
-<p><img src="ExpRCUFlow.svg" alt="ExpRCUFlow.svg" width="55%">
-
-<p>
-The solid arrows denote direct action, for example, a function call.
-The dotted arrows denote indirect action, for example, an IPI
-or a state that is reached after some time.
-
-<p>
-If a given CPU is offline or idle, <tt>synchronize_rcu_expedited()</tt>
-will ignore it because idle and offline CPUs are already residing
-in quiescent states.
-Otherwise, the expedited grace period will use
-<tt>smp_call_function_single()</tt> to send the CPU an IPI, which
-is handled by <tt>rcu_exp_handler()</tt>.
-
-<p>
-However, because this is preemptible RCU, <tt>rcu_exp_handler()</tt>
-can check to see if the CPU is currently running in an RCU read-side
-critical section.
-If not, the handler can immediately report a quiescent state.
-Otherwise, it sets flags so that the outermost <tt>rcu_read_unlock()</tt>
-invocation will provide the needed quiescent-state report.
-This flag-setting avoids the previous forced preemption of all
-CPUs that might have RCU read-side critical sections.
-In addition, this flag-setting is done so as to avoid increasing
-the overhead of the common-case fastpath through the scheduler.
-
-<p>
-Again because this is preemptible RCU, an RCU read-side critical section
-can be preempted.
-When that happens, RCU will enqueue the task, which will the continue to
-block the current expedited grace period until it resumes and finds its
-outermost <tt>rcu_read_unlock()</tt>.
-The CPU will report a quiescent state just after enqueuing the task because
-the CPU is no longer blocking the grace period.
-It is instead the preempted task doing the blocking.
-The list of blocked tasks is managed by <tt>rcu_preempt_ctxt_queue()</tt>,
-which is called from <tt>rcu_preempt_note_context_switch()</tt>, which
-in turn is called from <tt>rcu_note_context_switch()</tt>, which in
-turn is called from the scheduler.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Why not just have the expedited grace period check the
-	state of all the CPUs?
-	After all, that would avoid all those real-time-unfriendly IPIs.
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	Because we want the RCU read-side critical sections to run fast,
-	which means no memory barriers.
-	Therefore, it is not possible to safely check the state from some
-	other CPU.
-	And even if it was possible to safely check the state, it would
-	still be necessary to IPI the CPU to safely interact with the
-	upcoming <tt>rcu_read_unlock()</tt> invocation, which means that
-	the remote state testing would not help the worst-case
-	latency that real-time applications care about.
-
-	<p><font color="ffffff">One way to prevent your real-time
-	application from getting hit with these IPIs is to
-	build your kernel with <tt>CONFIG_NO_HZ_FULL=y</tt>.
-	RCU would then perceive the CPU running your application
-	as being idle, and it would be able to safely detect that
-	state without needing to IPI the CPU.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>
-Please note that this is just the overall flow:
-Additional complications can arise due to races with CPUs going idle
-or offline, among other things.
-
-<h2><a name="RCU-sched Expedited Grace Periods">
-RCU-sched Expedited Grace Periods</a></h2>
-
-<p>
-<tt>CONFIG_PREEMPT=n</tt> kernels implement RCU-sched.
-The overall flow of the handling of a given CPU by an RCU-sched
-expedited grace period is shown in the following diagram:
-
-<p><img src="ExpSchedFlow.svg" alt="ExpSchedFlow.svg" width="55%">
-
-<p>
-As with RCU-preempt, RCU-sched's
-<tt>synchronize_rcu_expedited()</tt> ignores offline and
-idle CPUs, again because they are in remotely detectable
-quiescent states.
-However, because the
-<tt>rcu_read_lock_sched()</tt> and <tt>rcu_read_unlock_sched()</tt>
-leave no trace of their invocation, in general it is not possible to tell
-whether or not the current CPU is in an RCU read-side critical section.
-The best that RCU-sched's <tt>rcu_exp_handler()</tt> can do is to check
-for idle, on the off-chance that the CPU went idle while the IPI
-was in flight.
-If the CPU is idle, then <tt>rcu_exp_handler()</tt> reports
-the quiescent state.
-
-<p> Otherwise, the handler forces a future context switch by setting the
-NEED_RESCHED flag of the current task's thread flag and the CPU preempt
-counter.
-At the time of the context switch, the CPU reports the quiescent state.
-Should the CPU go offline first, it will report the quiescent state
-at that time.
-
-<h2><a name="Expedited Grace Period and CPU Hotplug">
-Expedited Grace Period and CPU Hotplug</a></h2>
-
-<p>
-The expedited nature of expedited grace periods require a much tighter
-interaction with CPU hotplug operations than is required for normal
-grace periods.
-In addition, attempting to IPI offline CPUs will result in splats, but
-failing to IPI online CPUs can result in too-short grace periods.
-Neither option is acceptable in production kernels.
-
-<p>
-The interaction between expedited grace periods and CPU hotplug operations
-is carried out at several levels:
-
-<ol>
-<li>	The number of CPUs that have ever been online is tracked
-	by the <tt>rcu_state</tt> structure's <tt>-&gt;ncpus</tt>
-	field.
-	The <tt>rcu_state</tt> structure's <tt>-&gt;ncpus_snap</tt>
-	field tracks the number of CPUs that have ever been online
-	at the beginning of an RCU expedited grace period.
-	Note that this number never decreases, at least in the absence
-	of a time machine.
-<li>	The identities of the CPUs that have ever been online is
-	tracked by the <tt>rcu_node</tt> structure's
-	<tt>-&gt;expmaskinitnext</tt> field.
-	The <tt>rcu_node</tt> structure's <tt>-&gt;expmaskinit</tt>
-	field tracks the identities of the CPUs that were online
-	at least once at the beginning of the most recent RCU
-	expedited grace period.
-	The <tt>rcu_state</tt> structure's <tt>-&gt;ncpus</tt> and
-	<tt>-&gt;ncpus_snap</tt> fields are used to detect when
-	new CPUs have come online for the first time, that is,
-	when the <tt>rcu_node</tt> structure's <tt>-&gt;expmaskinitnext</tt>
-	field has changed since the beginning of the last RCU
-	expedited grace period, which triggers an update of each
-	<tt>rcu_node</tt> structure's <tt>-&gt;expmaskinit</tt>
-	field from its <tt>-&gt;expmaskinitnext</tt> field.
-<li>	Each <tt>rcu_node</tt> structure's <tt>-&gt;expmaskinit</tt>
-	field is used to initialize that structure's
-	<tt>-&gt;expmask</tt> at the beginning of each RCU
-	expedited grace period.
-	This means that only those CPUs that have been online at least
-	once will be considered for a given grace period.
-<li>	Any CPU that goes offline will clear its bit in its leaf
-	<tt>rcu_node</tt> structure's <tt>-&gt;qsmaskinitnext</tt>
-	field, so any CPU with that bit clear can safely be ignored.
-	However, it is possible for a CPU coming online or going offline
-	to have this bit set for some time while <tt>cpu_online</tt>
-	returns <tt>false</tt>.
-<li>	For each non-idle CPU that RCU believes is currently online, the grace
-	period invokes <tt>smp_call_function_single()</tt>.
-	If this succeeds, the CPU was fully online.
-	Failure indicates that the CPU is in the process of coming online
-	or going offline, in which case it is necessary to wait for a
-	short time period and try again.
-	The purpose of this wait (or series of waits, as the case may be)
-	is to permit a concurrent CPU-hotplug operation to complete.
-<li>	In the case of RCU-sched, one of the last acts of an outgoing CPU
-	is to invoke <tt>rcu_report_dead()</tt>, which
-	reports a quiescent state for that CPU.
-	However, this is likely paranoia-induced redundancy. <!-- @@@ -->
-</ol>
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Why all the dancing around with multiple counters and masks
-	tracking CPUs that were once online?
-	Why not just have a single set of masks tracking the currently
-	online CPUs and be done with it?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	Maintaining single set of masks tracking the online CPUs <i>sounds</i>
-	easier, at least until you try working out all the race conditions
-	between grace-period initialization and CPU-hotplug operations.
-	For example, suppose initialization is progressing down the
-	tree while a CPU-offline operation is progressing up the tree.
-	This situation can result in bits set at the top of the tree
-	that have no counterparts at the bottom of the tree.
-	Those bits will never be cleared, which will result in
-	grace-period hangs.
-	In short, that way lies madness, to say nothing of a great many
-	bugs, hangs, and deadlocks.
-
-	<p><font color="ffffff">
-	In contrast, the current multi-mask multi-counter scheme ensures
-	that grace-period initialization will always see consistent masks
-	up and down the tree, which brings significant simplifications
-	over the single-mask method.
-
-	<p><font color="ffffff">
-	This is an instance of
-	<a href="http://www.cs.columbia.edu/~library/TR-repository/reports/reports-1992/cucs-039-92.ps.gz"><font color="ffffff">
-	deferring work in order to avoid synchronization</a>.
-	Lazily recording CPU-hotplug events at the beginning of the next
-	grace period greatly simplifies maintenance of the CPU-tracking
-	bitmasks in the <tt>rcu_node</tt> tree.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<h2><a name="Expedited Grace Period Refinements">
-Expedited Grace Period Refinements</a></h2>
-
-<ol>
-<li>	<a href="#Idle-CPU Checks">Idle-CPU checks</a>.
-<li>	<a href="#Batching via Sequence Counter">
-	Batching via sequence counter</a>.
-<li>	<a href="#Funnel Locking and Wait/Wakeup">
-	Funnel locking and wait/wakeup</a>.
-<li>	<a href="#Use of Workqueues">Use of Workqueues</a>.
-<li>	<a href="#Stall Warnings">Stall warnings</a>.
-<li>	<a href="#Mid-Boot Operation">Mid-boot operation</a>.
-</ol>
-
-<h3><a name="Idle-CPU Checks">Idle-CPU Checks</a></h3>
-
-<p>
-Each expedited grace period checks for idle CPUs when initially forming
-the mask of CPUs to be IPIed and again just before IPIing a CPU
-(both checks are carried out by <tt>sync_rcu_exp_select_cpus()</tt>).
-If the CPU is idle at any time between those two times, the CPU will
-not be IPIed.
-Instead, the task pushing the grace period forward will include the
-idle CPUs in the mask passed to <tt>rcu_report_exp_cpu_mult()</tt>.
-
-<p>
-For RCU-sched, there is an additional check:
-If the IPI has interrupted the idle loop, then
-<tt>rcu_exp_handler()</tt> invokes <tt>rcu_report_exp_rdp()</tt>
-to report the corresponding quiescent state.
-
-<p>
-For RCU-preempt, there is no specific check for idle in the
-IPI handler (<tt>rcu_exp_handler()</tt>), but because
-RCU read-side critical sections are not permitted within the
-idle loop, if <tt>rcu_exp_handler()</tt> sees that the CPU is within
-RCU read-side critical section, the CPU cannot possibly be idle.
-Otherwise, <tt>rcu_exp_handler()</tt> invokes
-<tt>rcu_report_exp_rdp()</tt> to report the corresponding quiescent
-state, regardless of whether or not that quiescent state was due to
-the CPU being idle.
-
-<p>
-In summary, RCU expedited grace periods check for idle when building
-the bitmask of CPUs that must be IPIed, just before sending each IPI,
-and (either explicitly or implicitly) within the IPI handler.
-
-<h3><a name="Batching via Sequence Counter">
-Batching via Sequence Counter</a></h3>
-
-<p>
-If each grace-period request was carried out separately, expedited
-grace periods would have abysmal scalability and
-problematic high-load characteristics.
-Because each grace-period operation can serve an unlimited number of
-updates, it is important to <i>batch</i> requests, so that a single
-expedited grace-period operation will cover all requests in the
-corresponding batch.
-
-<p>
-This batching is controlled by a sequence counter named
-<tt>-&gt;expedited_sequence</tt> in the <tt>rcu_state</tt> structure.
-This counter has an odd value when there is an expedited grace period
-in progress and an even value otherwise, so that dividing the counter
-value by two gives the number of completed grace periods.
-During any given update request, the counter must transition from
-even to odd and then back to even, thus indicating that a grace
-period has elapsed.
-Therefore, if the initial value of the counter is <tt>s</tt>,
-the updater must wait until the counter reaches at least the
-value <tt>(s+3)&amp;~0x1</tt>.
-This counter is managed by the following access functions:
-
-<ol>
-<li>	<tt>rcu_exp_gp_seq_start()</tt>, which marks the start of
-	an expedited grace period.
-<li>	<tt>rcu_exp_gp_seq_end()</tt>, which marks the end of an
-	expedited grace period.
-<li>	<tt>rcu_exp_gp_seq_snap()</tt>, which obtains a snapshot of
-	the counter.
-<li>	<tt>rcu_exp_gp_seq_done()</tt>, which returns <tt>true</tt>
-	if a full expedited grace period has elapsed since the
-	corresponding call to <tt>rcu_exp_gp_seq_snap()</tt>.
-</ol>
-
-<p>
-Again, only one request in a given batch need actually carry out
-a grace-period operation, which means there must be an efficient
-way to identify which of many concurrent reqeusts will initiate
-the grace period, and that there be an efficient way for the
-remaining requests to wait for that grace period to complete.
-However, that is the topic of the next section.
-
-<h3><a name="Funnel Locking and Wait/Wakeup">
-Funnel Locking and Wait/Wakeup</a></h3>
-
-<p>
-The natural way to sort out which of a batch of updaters will initiate
-the expedited grace period is to use the <tt>rcu_node</tt> combining
-tree, as implemented by the <tt>exp_funnel_lock()</tt> function.
-The first updater corresponding to a given grace period arriving
-at a given <tt>rcu_node</tt> structure records its desired grace-period
-sequence number in the <tt>-&gt;exp_seq_rq</tt> field and moves up
-to the next level in the tree.
-Otherwise, if the <tt>-&gt;exp_seq_rq</tt> field already contains
-the sequence number for the desired grace period or some later one,
-the updater blocks on one of four wait queues in the
-<tt>-&gt;exp_wq[]</tt> array, using the second-from-bottom
-and third-from bottom bits as an index.
-An <tt>-&gt;exp_lock</tt> field in the <tt>rcu_node</tt> structure
-synchronizes access to these fields.
-
-<p>
-An empty <tt>rcu_node</tt> tree is shown in the following diagram,
-with the white cells representing the <tt>-&gt;exp_seq_rq</tt> field
-and the red cells representing the elements of the
-<tt>-&gt;exp_wq[]</tt> array.
-
-<p><img src="Funnel0.svg" alt="Funnel0.svg" width="75%">
-
-<p>
-The next diagram shows the situation after the arrival of Task&nbsp;A
-and Task&nbsp;B at the leftmost and rightmost leaf <tt>rcu_node</tt>
-structures, respectively.
-The current value of the <tt>rcu_state</tt> structure's
-<tt>-&gt;expedited_sequence</tt> field is zero, so adding three and
-clearing the bottom bit results in the value two, which both tasks
-record in the <tt>-&gt;exp_seq_rq</tt> field of their respective
-<tt>rcu_node</tt> structures:
-
-<p><img src="Funnel1.svg" alt="Funnel1.svg" width="75%">
-
-<p>
-Each of Tasks&nbsp;A and&nbsp;B will move up to the root
-<tt>rcu_node</tt> structure.
-Suppose that Task&nbsp;A wins, recording its desired grace-period sequence
-number and resulting in the state shown below:
-
-<p><img src="Funnel2.svg" alt="Funnel2.svg" width="75%">
-
-<p>
-Task&nbsp;A now advances to initiate a new grace period, while Task&nbsp;B
-moves up to the root <tt>rcu_node</tt> structure, and, seeing that
-its desired sequence number is already recorded, blocks on
-<tt>-&gt;exp_wq[1]</tt>.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Why <tt>-&gt;exp_wq[1]</tt>?
-	Given that the value of these tasks' desired sequence number is
-	two, so shouldn't they instead block on <tt>-&gt;exp_wq[2]</tt>?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	No.
-
-	<p><font color="ffffff">
-	Recall that the bottom bit of the desired sequence number indicates
-	whether or not a grace period is currently in progress.
-	It is therefore necessary to shift the sequence number right one
-	bit position to obtain the number of the grace period.
-	This results in <tt>-&gt;exp_wq[1]</tt>.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>
-If Tasks&nbsp;C and&nbsp;D also arrive at this point, they will compute the
-same desired grace-period sequence number, and see that both leaf
-<tt>rcu_node</tt> structures already have that value recorded.
-They will therefore block on their respective <tt>rcu_node</tt>
-structures' <tt>-&gt;exp_wq[1]</tt> fields, as shown below:
-
-<p><img src="Funnel3.svg" alt="Funnel3.svg" width="75%">
-
-<p>
-Task&nbsp;A now acquires the <tt>rcu_state</tt> structure's
-<tt>-&gt;exp_mutex</tt> and initiates the grace period, which
-increments <tt>-&gt;expedited_sequence</tt>.
-Therefore, if Tasks&nbsp;E and&nbsp;F arrive, they will compute
-a desired sequence number of 4 and will record this value as
-shown below:
-
-<p><img src="Funnel4.svg" alt="Funnel4.svg" width="75%">
-
-<p>
-Tasks&nbsp;E and&nbsp;F will propagate up the <tt>rcu_node</tt>
-combining tree, with Task&nbsp;F blocking on the root <tt>rcu_node</tt>
-structure and Task&nbsp;E wait for Task&nbsp;A to finish so that
-it can start the next grace period.
-The resulting state is as shown below:
-
-<p><img src="Funnel5.svg" alt="Funnel5.svg" width="75%">
-
-<p>
-Once the grace period completes, Task&nbsp;A
-starts waking up the tasks waiting for this grace period to complete,
-increments the <tt>-&gt;expedited_sequence</tt>,
-acquires the <tt>-&gt;exp_wake_mutex</tt> and then releases the
-<tt>-&gt;exp_mutex</tt>.
-This results in the following state:
-
-<p><img src="Funnel6.svg" alt="Funnel6.svg" width="75%">
-
-<p>
-Task&nbsp;E can then acquire <tt>-&gt;exp_mutex</tt> and increment
-<tt>-&gt;expedited_sequence</tt> to the value three.
-If new tasks&nbsp;G and&nbsp;H arrive and moves up the combining tree at the
-same time, the state will be as follows:
-
-<p><img src="Funnel7.svg" alt="Funnel7.svg" width="75%">
-
-<p>
-Note that three of the root <tt>rcu_node</tt> structure's
-waitqueues are now occupied.
-However, at some point, Task&nbsp;A will wake up the
-tasks blocked on the <tt>-&gt;exp_wq</tt> waitqueues, resulting
-in the following state:
-
-<p><img src="Funnel8.svg" alt="Funnel8.svg" width="75%">
-
-<p>
-Execution will continue with Tasks&nbsp;E and&nbsp;H completing
-their grace periods and carrying out their wakeups.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	What happens if Task&nbsp;A takes so long to do its wakeups
-	that Task&nbsp;E's grace period completes?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	Then Task&nbsp;E will block on the <tt>-&gt;exp_wake_mutex</tt>,
-	which will also prevent it from releasing <tt>-&gt;exp_mutex</tt>,
-	which in turn will prevent the next grace period from starting.
-	This last is important in preventing overflow of the
-	<tt>-&gt;exp_wq[]</tt> array.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<h3><a name="Use of Workqueues">Use of Workqueues</a></h3>
-
-<p>
-In earlier implementations, the task requesting the expedited
-grace period also drove it to completion.
-This straightforward approach had the disadvantage of needing to
-account for POSIX signals sent to user tasks,
-so more recent implemementations use the Linux kernel's
-<a href="https://www.kernel.org/doc/Documentation/core-api/workqueue.rst">workqueues</a>.
-
-<p>
-The requesting task still does counter snapshotting and funnel-lock
-processing, but the task reaching the top of the funnel lock
-does a <tt>schedule_work()</tt> (from <tt>_synchronize_rcu_expedited()</tt>
-so that a workqueue kthread does the actual grace-period processing.
-Because workqueue kthreads do not accept POSIX signals, grace-period-wait
-processing need not allow for POSIX signals.
-
-In addition, this approach allows wakeups for the previous expedited
-grace period to be overlapped with processing for the next expedited
-grace period.
-Because there are only four sets of waitqueues, it is necessary to
-ensure that the previous grace period's wakeups complete before the
-next grace period's wakeups start.
-This is handled by having the <tt>-&gt;exp_mutex</tt>
-guard expedited grace-period processing and the
-<tt>-&gt;exp_wake_mutex</tt> guard wakeups.
-The key point is that the <tt>-&gt;exp_mutex</tt> is not released
-until the first wakeup is complete, which means that the
-<tt>-&gt;exp_wake_mutex</tt> has already been acquired at that point.
-This approach ensures that the previous grace period's wakeups can
-be carried out while the current grace period is in process, but
-that these wakeups will complete before the next grace period starts.
-This means that only three waitqueues are required, guaranteeing that
-the four that are provided are sufficient.
-
-<h3><a name="Stall Warnings">Stall Warnings</a></h3>
-
-<p>
-Expediting grace periods does nothing to speed things up when RCU
-readers take too long, and therefore expedited grace periods check
-for stalls just as normal grace periods do.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	But why not just let the normal grace-period machinery
-	detect the stalls, given that a given reader must block
-	both normal and expedited grace periods?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	Because it is quite possible that at a given time there
-	is no normal grace period in progress, in which case the
-	normal grace period cannot emit a stall warning.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-The <tt>synchronize_sched_expedited_wait()</tt> function loops waiting
-for the expedited grace period to end, but with a timeout set to the
-current RCU CPU stall-warning time.
-If this time is exceeded, any CPUs or <tt>rcu_node</tt> structures
-blocking the current grace period are printed.
-Each stall warning results in another pass through the loop, but the
-second and subsequent passes use longer stall times.
-
-<h3><a name="Mid-Boot Operation">Mid-boot operation</a></h3>
-
-<p>
-The use of workqueues has the advantage that the expedited
-grace-period code need not worry about POSIX signals.
-Unfortunately, it has the
-corresponding disadvantage that workqueues cannot be used until
-they are initialized, which does not happen until some time after
-the scheduler spawns the first task.
-Given that there are parts of the kernel that really do want to
-execute grace periods during this mid-boot &ldquo;dead zone&rdquo;,
-expedited grace periods must do something else during thie time.
-
-<p>
-What they do is to fall back to the old practice of requiring that the
-requesting task drive the expedited grace period, as was the case
-before the use of workqueues.
-However, the requesting task is only required to drive the grace period
-during the mid-boot dead zone.
-Before mid-boot, a synchronous grace period is a no-op.
-Some time after mid-boot, workqueues are used.
-
-<p>
-Non-expedited non-SRCU synchronous grace periods must also operate
-normally during mid-boot.
-This is handled by causing non-expedited grace periods to take the
-expedited code path during mid-boot.
-
-<p>
-The current code assumes that there are no POSIX signals during
-the mid-boot dead zone.
-However, if an overwhelming need for POSIX signals somehow arises,
-appropriate adjustments can be made to the expedited stall-warning code.
-One such adjustment would reinstate the pre-workqueue stall-warning
-checks, but only during the mid-boot dead zone.
-
-<p>
-With this refinement, synchronous grace periods can now be used from
-task context pretty much any time during the life of the kernel.
-That is, aside from some points in the suspend, hibernate, or shutdown
-code path.
-
-<h3><a name="Summary">
-Summary</a></h3>
-
-<p>
-Expedited grace periods use a sequence-number approach to promote
-batching, so that a single grace-period operation can serve numerous
-requests.
-A funnel lock is used to efficiently identify the one task out of
-a concurrent group that will request the grace period.
-All members of the group will block on waitqueues provided in
-the <tt>rcu_node</tt> structure.
-The actual grace-period processing is carried out by a workqueue.
-
-<p>
-CPU-hotplug operations are noted lazily in order to prevent the need
-for tight synchronization between expedited grace periods and
-CPU-hotplug operations.
-The dyntick-idle counters are used to avoid sending IPIs to idle CPUs,
-at least in the common case.
-RCU-preempt and RCU-sched use different IPI handlers and different
-code to respond to the state changes carried out by those handlers,
-but otherwise use common code.
-
-<p>
-Quiescent states are tracked using the <tt>rcu_node</tt> tree,
-and once all necessary quiescent states have been reported,
-all tasks waiting on this expedited grace period are awakened.
-A pair of mutexes are used to allow one grace period's wakeups
-to proceed concurrently with the next grace period's processing.
-
-<p>
-This combination of mechanisms allows expedited grace periods to
-run reasonably efficiently.
-However, for non-time-critical tasks, normal grace periods should be
-used instead because their longer duration permits much higher
-degrees of batching, and thus much lower per-request overheads.
-
-</body></html>
diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
new file mode 100644
index 000000000000..72f0f6fbd53c
--- /dev/null
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
@@ -0,0 +1,521 @@
+=================================================
+A Tour Through TREE_RCU's Expedited Grace Periods
+=================================================
+
+Introduction
+============
+
+This document describes RCU's expedited grace periods.
+Unlike RCU's normal grace periods, which accept long latencies to attain
+high efficiency and minimal disturbance, expedited grace periods accept
+lower efficiency and significant disturbance to attain shorter latencies.
+
+There are two flavors of RCU (RCU-preempt and RCU-sched), with an earlier
+third RCU-bh flavor having been implemented in terms of the other two.
+Each of the two implementations is covered in its own section.
+
+Expedited Grace Period Design
+=============================
+
+The expedited RCU grace periods cannot be accused of being subtle,
+given that they for all intents and purposes hammer every CPU that
+has not yet provided a quiescent state for the current expedited
+grace period.
+The one saving grace is that the hammer has grown a bit smaller
+over time:  The old call to ``try_stop_cpus()`` has been
+replaced with a set of calls to ``smp_call_function_single()``,
+each of which results in an IPI to the target CPU.
+The corresponding handler function checks the CPU's state, motivating
+a faster quiescent state where possible, and triggering a report
+of that quiescent state.
+As always for RCU, once everything has spent some time in a quiescent
+state, the expedited grace period has completed.
+
+The details of the ``smp_call_function_single()`` handler's
+operation depend on the RCU flavor, as described in the following
+sections.
+
+RCU-preempt Expedited Grace Periods
+===================================
+
+``CONFIG_PREEMPT=y`` kernels implement RCU-preempt.
+The overall flow of the handling of a given CPU by an RCU-preempt
+expedited grace period is shown in the following diagram:
+
+.. kernel-figure:: ExpRCUFlow.svg
+
+The solid arrows denote direct action, for example, a function call.
+The dotted arrows denote indirect action, for example, an IPI
+or a state that is reached after some time.
+
+If a given CPU is offline or idle, ``synchronize_rcu_expedited()``
+will ignore it because idle and offline CPUs are already residing
+in quiescent states.
+Otherwise, the expedited grace period will use
+``smp_call_function_single()`` to send the CPU an IPI, which
+is handled by ``rcu_exp_handler()``.
+
+However, because this is preemptible RCU, ``rcu_exp_handler()``
+can check to see if the CPU is currently running in an RCU read-side
+critical section.
+If not, the handler can immediately report a quiescent state.
+Otherwise, it sets flags so that the outermost ``rcu_read_unlock()``
+invocation will provide the needed quiescent-state report.
+This flag-setting avoids the previous forced preemption of all
+CPUs that might have RCU read-side critical sections.
+In addition, this flag-setting is done so as to avoid increasing
+the overhead of the common-case fastpath through the scheduler.
+
+Again because this is preemptible RCU, an RCU read-side critical section
+can be preempted.
+When that happens, RCU will enqueue the task, which will the continue to
+block the current expedited grace period until it resumes and finds its
+outermost ``rcu_read_unlock()``.
+The CPU will report a quiescent state just after enqueuing the task because
+the CPU is no longer blocking the grace period.
+It is instead the preempted task doing the blocking.
+The list of blocked tasks is managed by ``rcu_preempt_ctxt_queue()``,
+which is called from ``rcu_preempt_note_context_switch()``, which
+in turn is called from ``rcu_note_context_switch()``, which in
+turn is called from the scheduler.
+
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Why not just have the expedited grace period check the state of all   |
+| the CPUs? After all, that would avoid all those real-time-unfriendly  |
+| IPIs.                                                                 |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Because we want the RCU read-side critical sections to run fast,      |
+| which means no memory barriers. Therefore, it is not possible to      |
+| safely check the state from some other CPU. And even if it was        |
+| possible to safely check the state, it would still be necessary to    |
+| IPI the CPU to safely interact with the upcoming                      |
+| ``rcu_read_unlock()`` invocation, which means that the remote state   |
+| testing would not help the worst-case latency that real-time          |
+| applications care about.                                              |
+|                                                                       |
+| One way to prevent your real-time application from getting hit with   |
+| these IPIs is to build your kernel with ``CONFIG_NO_HZ_FULL=y``. RCU  |
+| would then perceive the CPU running your application as being idle,   |
+| and it would be able to safely detect that state without needing to   |
+| IPI the CPU.                                                          |
++-----------------------------------------------------------------------+
+
+Please note that this is just the overall flow: Additional complications
+can arise due to races with CPUs going idle or offline, among other
+things.
+
+RCU-sched Expedited Grace Periods
+---------------------------------
+
+``CONFIG_PREEMPT=n`` kernels implement RCU-sched. The overall flow of
+the handling of a given CPU by an RCU-sched expedited grace period is
+shown in the following diagram:
+
+.. kernel-figure:: ExpSchedFlow.svg
+
+As with RCU-preempt, RCU-sched's ``synchronize_rcu_expedited()`` ignores
+offline and idle CPUs, again because they are in remotely detectable
+quiescent states. However, because the ``rcu_read_lock_sched()`` and
+``rcu_read_unlock_sched()`` leave no trace of their invocation, in
+general it is not possible to tell whether or not the current CPU is in
+an RCU read-side critical section. The best that RCU-sched's
+``rcu_exp_handler()`` can do is to check for idle, on the off-chance
+that the CPU went idle while the IPI was in flight. If the CPU is idle,
+then ``rcu_exp_handler()`` reports the quiescent state.
+
+Otherwise, the handler forces a future context switch by setting the
+NEED_RESCHED flag of the current task's thread flag and the CPU preempt
+counter. At the time of the context switch, the CPU reports the
+quiescent state. Should the CPU go offline first, it will report the
+quiescent state at that time.
+
+Expedited Grace Period and CPU Hotplug
+--------------------------------------
+
+The expedited nature of expedited grace periods require a much tighter
+interaction with CPU hotplug operations than is required for normal
+grace periods. In addition, attempting to IPI offline CPUs will result
+in splats, but failing to IPI online CPUs can result in too-short grace
+periods. Neither option is acceptable in production kernels.
+
+The interaction between expedited grace periods and CPU hotplug
+operations is carried out at several levels:
+
+#. The number of CPUs that have ever been online is tracked by the
+   ``rcu_state`` structure's ``->ncpus`` field. The ``rcu_state``
+   structure's ``->ncpus_snap`` field tracks the number of CPUs that
+   have ever been online at the beginning of an RCU expedited grace
+   period. Note that this number never decreases, at least in the
+   absence of a time machine.
+#. The identities of the CPUs that have ever been online is tracked by
+   the ``rcu_node`` structure's ``->expmaskinitnext`` field. The
+   ``rcu_node`` structure's ``->expmaskinit`` field tracks the
+   identities of the CPUs that were online at least once at the
+   beginning of the most recent RCU expedited grace period. The
+   ``rcu_state`` structure's ``->ncpus`` and ``->ncpus_snap`` fields are
+   used to detect when new CPUs have come online for the first time,
+   that is, when the ``rcu_node`` structure's ``->expmaskinitnext``
+   field has changed since the beginning of the last RCU expedited grace
+   period, which triggers an update of each ``rcu_node`` structure's
+   ``->expmaskinit`` field from its ``->expmaskinitnext`` field.
+#. Each ``rcu_node`` structure's ``->expmaskinit`` field is used to
+   initialize that structure's ``->expmask`` at the beginning of each
+   RCU expedited grace period. This means that only those CPUs that have
+   been online at least once will be considered for a given grace
+   period.
+#. Any CPU that goes offline will clear its bit in its leaf ``rcu_node``
+   structure's ``->qsmaskinitnext`` field, so any CPU with that bit
+   clear can safely be ignored. However, it is possible for a CPU coming
+   online or going offline to have this bit set for some time while
+   ``cpu_online`` returns ``false``.
+#. For each non-idle CPU that RCU believes is currently online, the
+   grace period invokes ``smp_call_function_single()``. If this
+   succeeds, the CPU was fully online. Failure indicates that the CPU is
+   in the process of coming online or going offline, in which case it is
+   necessary to wait for a short time period and try again. The purpose
+   of this wait (or series of waits, as the case may be) is to permit a
+   concurrent CPU-hotplug operation to complete.
+#. In the case of RCU-sched, one of the last acts of an outgoing CPU is
+   to invoke ``rcu_report_dead()``, which reports a quiescent state for
+   that CPU. However, this is likely paranoia-induced redundancy.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Why all the dancing around with multiple counters and masks tracking  |
+| CPUs that were once online? Why not just have a single set of masks   |
+| tracking the currently online CPUs and be done with it?               |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Maintaining single set of masks tracking the online CPUs *sounds*     |
+| easier, at least until you try working out all the race conditions    |
+| between grace-period initialization and CPU-hotplug operations. For   |
+| example, suppose initialization is progressing down the tree while a  |
+| CPU-offline operation is progressing up the tree. This situation can  |
+| result in bits set at the top of the tree that have no counterparts   |
+| at the bottom of the tree. Those bits will never be cleared, which    |
+| will result in grace-period hangs. In short, that way lies madness,   |
+| to say nothing of a great many bugs, hangs, and deadlocks.            |
+| In contrast, the current multi-mask multi-counter scheme ensures that |
+| grace-period initialization will always see consistent masks up and   |
+| down the tree, which brings significant simplifications over the      |
+| single-mask method.                                                   |
+|                                                                       |
+| This is an instance of `deferring work in order to avoid              |
+| synchronization <http://www.cs.columbia.edu/~library/TR-repository/re |
+| ports/reports-1992/cucs-039-92.ps.gz>`__.                             |
+| Lazily recording CPU-hotplug events at the beginning of the next      |
+| grace period greatly simplifies maintenance of the CPU-tracking       |
+| bitmasks in the ``rcu_node`` tree.                                    |
++-----------------------------------------------------------------------+
+
+Expedited Grace Period Refinements
+----------------------------------
+
+Idle-CPU Checks
+~~~~~~~~~~~~~~~
+
+Each expedited grace period checks for idle CPUs when initially forming
+the mask of CPUs to be IPIed and again just before IPIing a CPU (both
+checks are carried out by ``sync_rcu_exp_select_cpus()``). If the CPU is
+idle at any time between those two times, the CPU will not be IPIed.
+Instead, the task pushing the grace period forward will include the idle
+CPUs in the mask passed to ``rcu_report_exp_cpu_mult()``.
+
+For RCU-sched, there is an additional check: If the IPI has interrupted
+the idle loop, then ``rcu_exp_handler()`` invokes
+``rcu_report_exp_rdp()`` to report the corresponding quiescent state.
+
+For RCU-preempt, there is no specific check for idle in the IPI handler
+(``rcu_exp_handler()``), but because RCU read-side critical sections are
+not permitted within the idle loop, if ``rcu_exp_handler()`` sees that
+the CPU is within RCU read-side critical section, the CPU cannot
+possibly be idle. Otherwise, ``rcu_exp_handler()`` invokes
+``rcu_report_exp_rdp()`` to report the corresponding quiescent state,
+regardless of whether or not that quiescent state was due to the CPU
+being idle.
+
+In summary, RCU expedited grace periods check for idle when building the
+bitmask of CPUs that must be IPIed, just before sending each IPI, and
+(either explicitly or implicitly) within the IPI handler.
+
+Batching via Sequence Counter
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If each grace-period request was carried out separately, expedited grace
+periods would have abysmal scalability and problematic high-load
+characteristics. Because each grace-period operation can serve an
+unlimited number of updates, it is important to *batch* requests, so
+that a single expedited grace-period operation will cover all requests
+in the corresponding batch.
+
+This batching is controlled by a sequence counter named
+``->expedited_sequence`` in the ``rcu_state`` structure. This counter
+has an odd value when there is an expedited grace period in progress and
+an even value otherwise, so that dividing the counter value by two gives
+the number of completed grace periods. During any given update request,
+the counter must transition from even to odd and then back to even, thus
+indicating that a grace period has elapsed. Therefore, if the initial
+value of the counter is ``s``, the updater must wait until the counter
+reaches at least the value ``(s+3)&~0x1``. This counter is managed by
+the following access functions:
+
+#. ``rcu_exp_gp_seq_start()``, which marks the start of an expedited
+   grace period.
+#. ``rcu_exp_gp_seq_end()``, which marks the end of an expedited grace
+   period.
+#. ``rcu_exp_gp_seq_snap()``, which obtains a snapshot of the counter.
+#. ``rcu_exp_gp_seq_done()``, which returns ``true`` if a full expedited
+   grace period has elapsed since the corresponding call to
+   ``rcu_exp_gp_seq_snap()``.
+
+Again, only one request in a given batch need actually carry out a
+grace-period operation, which means there must be an efficient way to
+identify which of many concurrent reqeusts will initiate the grace
+period, and that there be an efficient way for the remaining requests to
+wait for that grace period to complete. However, that is the topic of
+the next section.
+
+Funnel Locking and Wait/Wakeup
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The natural way to sort out which of a batch of updaters will initiate
+the expedited grace period is to use the ``rcu_node`` combining tree, as
+implemented by the ``exp_funnel_lock()`` function. The first updater
+corresponding to a given grace period arriving at a given ``rcu_node``
+structure records its desired grace-period sequence number in the
+``->exp_seq_rq`` field and moves up to the next level in the tree.
+Otherwise, if the ``->exp_seq_rq`` field already contains the sequence
+number for the desired grace period or some later one, the updater
+blocks on one of four wait queues in the ``->exp_wq[]`` array, using the
+second-from-bottom and third-from bottom bits as an index. An
+``->exp_lock`` field in the ``rcu_node`` structure synchronizes access
+to these fields.
+
+An empty ``rcu_node`` tree is shown in the following diagram, with the
+white cells representing the ``->exp_seq_rq`` field and the red cells
+representing the elements of the ``->exp_wq[]`` array.
+
+.. kernel-figure:: Funnel0.svg
+
+The next diagram shows the situation after the arrival of Task A and
+Task B at the leftmost and rightmost leaf ``rcu_node`` structures,
+respectively. The current value of the ``rcu_state`` structure's
+``->expedited_sequence`` field is zero, so adding three and clearing the
+bottom bit results in the value two, which both tasks record in the
+``->exp_seq_rq`` field of their respective ``rcu_node`` structures:
+
+.. kernel-figure:: Funnel1.svg
+
+Each of Tasks A and B will move up to the root ``rcu_node`` structure.
+Suppose that Task A wins, recording its desired grace-period sequence
+number and resulting in the state shown below:
+
+.. kernel-figure:: Funnel2.svg
+
+Task A now advances to initiate a new grace period, while Task B moves
+up to the root ``rcu_node`` structure, and, seeing that its desired
+sequence number is already recorded, blocks on ``->exp_wq[1]``.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Why ``->exp_wq[1]``? Given that the value of these tasks' desired     |
+| sequence number is two, so shouldn't they instead block on            |
+| ``->exp_wq[2]``?                                                      |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| No.                                                                   |
+| Recall that the bottom bit of the desired sequence number indicates   |
+| whether or not a grace period is currently in progress. It is         |
+| therefore necessary to shift the sequence number right one bit        |
+| position to obtain the number of the grace period. This results in    |
+| ``->exp_wq[1]``.                                                      |
++-----------------------------------------------------------------------+
+
+If Tasks C and D also arrive at this point, they will compute the same
+desired grace-period sequence number, and see that both leaf
+``rcu_node`` structures already have that value recorded. They will
+therefore block on their respective ``rcu_node`` structures'
+``->exp_wq[1]`` fields, as shown below:
+
+.. kernel-figure:: Funnel3.svg
+
+Task A now acquires the ``rcu_state`` structure's ``->exp_mutex`` and
+initiates the grace period, which increments ``->expedited_sequence``.
+Therefore, if Tasks E and F arrive, they will compute a desired sequence
+number of 4 and will record this value as shown below:
+
+.. kernel-figure:: Funnel4.svg
+
+Tasks E and F will propagate up the ``rcu_node`` combining tree, with
+Task F blocking on the root ``rcu_node`` structure and Task E wait for
+Task A to finish so that it can start the next grace period. The
+resulting state is as shown below:
+
+.. kernel-figure:: Funnel5.svg
+
+Once the grace period completes, Task A starts waking up the tasks
+waiting for this grace period to complete, increments the
+``->expedited_sequence``, acquires the ``->exp_wake_mutex`` and then
+releases the ``->exp_mutex``. This results in the following state:
+
+.. kernel-figure:: Funnel6.svg
+
+Task E can then acquire ``->exp_mutex`` and increment
+``->expedited_sequence`` to the value three. If new tasks G and H arrive
+and moves up the combining tree at the same time, the state will be as
+follows:
+
+.. kernel-figure:: Funnel7.svg
+
+Note that three of the root ``rcu_node`` structure's waitqueues are now
+occupied. However, at some point, Task A will wake up the tasks blocked
+on the ``->exp_wq`` waitqueues, resulting in the following state:
+
+.. kernel-figure:: Funnel8.svg
+
+Execution will continue with Tasks E and H completing their grace
+periods and carrying out their wakeups.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| What happens if Task A takes so long to do its wakeups that Task E's  |
+| grace period completes?                                               |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Then Task E will block on the ``->exp_wake_mutex``, which will also   |
+| prevent it from releasing ``->exp_mutex``, which in turn will prevent |
+| the next grace period from starting. This last is important in        |
+| preventing overflow of the ``->exp_wq[]`` array.                      |
++-----------------------------------------------------------------------+
+
+Use of Workqueues
+~~~~~~~~~~~~~~~~~
+
+In earlier implementations, the task requesting the expedited grace
+period also drove it to completion. This straightforward approach had
+the disadvantage of needing to account for POSIX signals sent to user
+tasks, so more recent implemementations use the Linux kernel's
+`workqueues <https://www.kernel.org/doc/Documentation/core-api/workqueue.rst>`__.
+
+The requesting task still does counter snapshotting and funnel-lock
+processing, but the task reaching the top of the funnel lock does a
+``schedule_work()`` (from ``_synchronize_rcu_expedited()`` so that a
+workqueue kthread does the actual grace-period processing. Because
+workqueue kthreads do not accept POSIX signals, grace-period-wait
+processing need not allow for POSIX signals. In addition, this approach
+allows wakeups for the previous expedited grace period to be overlapped
+with processing for the next expedited grace period. Because there are
+only four sets of waitqueues, it is necessary to ensure that the
+previous grace period's wakeups complete before the next grace period's
+wakeups start. This is handled by having the ``->exp_mutex`` guard
+expedited grace-period processing and the ``->exp_wake_mutex`` guard
+wakeups. The key point is that the ``->exp_mutex`` is not released until
+the first wakeup is complete, which means that the ``->exp_wake_mutex``
+has already been acquired at that point. This approach ensures that the
+previous grace period's wakeups can be carried out while the current
+grace period is in process, but that these wakeups will complete before
+the next grace period starts. This means that only three waitqueues are
+required, guaranteeing that the four that are provided are sufficient.
+
+Stall Warnings
+~~~~~~~~~~~~~~
+
+Expediting grace periods does nothing to speed things up when RCU
+readers take too long, and therefore expedited grace periods check for
+stalls just as normal grace periods do.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| But why not just let the normal grace-period machinery detect the     |
+| stalls, given that a given reader must block both normal and          |
+| expedited grace periods?                                              |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Because it is quite possible that at a given time there is no normal  |
+| grace period in progress, in which case the normal grace period       |
+| cannot emit a stall warning.                                          |
++-----------------------------------------------------------------------+
+
+The ``synchronize_sched_expedited_wait()`` function loops waiting for
+the expedited grace period to end, but with a timeout set to the current
+RCU CPU stall-warning time. If this time is exceeded, any CPUs or
+``rcu_node`` structures blocking the current grace period are printed.
+Each stall warning results in another pass through the loop, but the
+second and subsequent passes use longer stall times.
+
+Mid-boot operation
+~~~~~~~~~~~~~~~~~~
+
+The use of workqueues has the advantage that the expedited grace-period
+code need not worry about POSIX signals. Unfortunately, it has the
+corresponding disadvantage that workqueues cannot be used until they are
+initialized, which does not happen until some time after the scheduler
+spawns the first task. Given that there are parts of the kernel that
+really do want to execute grace periods during this mid-boot “dead
+zone”, expedited grace periods must do something else during thie time.
+
+What they do is to fall back to the old practice of requiring that the
+requesting task drive the expedited grace period, as was the case before
+the use of workqueues. However, the requesting task is only required to
+drive the grace period during the mid-boot dead zone. Before mid-boot, a
+synchronous grace period is a no-op. Some time after mid-boot,
+workqueues are used.
+
+Non-expedited non-SRCU synchronous grace periods must also operate
+normally during mid-boot. This is handled by causing non-expedited grace
+periods to take the expedited code path during mid-boot.
+
+The current code assumes that there are no POSIX signals during the
+mid-boot dead zone. However, if an overwhelming need for POSIX signals
+somehow arises, appropriate adjustments can be made to the expedited
+stall-warning code. One such adjustment would reinstate the
+pre-workqueue stall-warning checks, but only during the mid-boot dead
+zone.
+
+With this refinement, synchronous grace periods can now be used from
+task context pretty much any time during the life of the kernel. That
+is, aside from some points in the suspend, hibernate, or shutdown code
+path.
+
+Summary
+~~~~~~~
+
+Expedited grace periods use a sequence-number approach to promote
+batching, so that a single grace-period operation can serve numerous
+requests. A funnel lock is used to efficiently identify the one task out
+of a concurrent group that will request the grace period. All members of
+the group will block on waitqueues provided in the ``rcu_node``
+structure. The actual grace-period processing is carried out by a
+workqueue.
+
+CPU-hotplug operations are noted lazily in order to prevent the need for
+tight synchronization between expedited grace periods and CPU-hotplug
+operations. The dyntick-idle counters are used to avoid sending IPIs to
+idle CPUs, at least in the common case. RCU-preempt and RCU-sched use
+different IPI handlers and different code to respond to the state
+changes carried out by those handlers, but otherwise use common code.
+
+Quiescent states are tracked using the ``rcu_node`` tree, and once all
+necessary quiescent states have been reported, all tasks waiting on this
+expedited grace period are awakened. A pair of mutexes are used to allow
+one grace period's wakeups to proceed concurrently with the next grace
+period's processing.
+
+This combination of mechanisms allows expedited grace periods to run
+reasonably efficiently. However, for non-time-critical tasks, normal
+grace periods should be used instead because their longer duration
+permits much higher degrees of batching, and thus much lower per-request
+overheads.
diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Diagram.html b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Diagram.html
deleted file mode 100644
index e5b42a798ff3..000000000000
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Diagram.html
+++ /dev/null
@@ -1,9 +0,0 @@
-<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
-        "http://www.w3.org/TR/html4/loose.dtd">
-        <html>
-        <head><title>A Diagram of TREE_RCU's Grace-Period Memory Ordering</title>
-        <meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
-
-<p><img src="TreeRCU-gp.svg" alt="TreeRCU-gp.svg">
-
-</body></html>
diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
deleted file mode 100644
index c64f8d26609f..000000000000
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
+++ /dev/null
@@ -1,704 +0,0 @@
-<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
-        "http://www.w3.org/TR/html4/loose.dtd">
-        <html>
-        <head><title>A Tour Through TREE_RCU's Grace-Period Memory Ordering</title>
-        <meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
-
-           <p>August 8, 2017</p>
-           <p>This article was contributed by Paul E.&nbsp;McKenney</p>
-
-<h3>Introduction</h3>
-
-<p>This document gives a rough visual overview of how Tree RCU's
-grace-period memory ordering guarantee is provided.
-
-<ol>
-<li>	<a href="#What Is Tree RCU's Grace Period Memory Ordering Guarantee?">
-	What Is Tree RCU's Grace Period Memory Ordering Guarantee?</a>
-<li>	<a href="#Tree RCU Grace Period Memory Ordering Building Blocks">
-	Tree RCU Grace Period Memory Ordering Building Blocks</a>
-<li>	<a href="#Tree RCU Grace Period Memory Ordering Components">
-	Tree RCU Grace Period Memory Ordering Components</a>
-<li>	<a href="#Putting It All Together">Putting It All Together</a>
-</ol>
-
-<h3><a name="What Is Tree RCU's Grace Period Memory Ordering Guarantee?">
-What Is Tree RCU's Grace Period Memory Ordering Guarantee?</a></h3>
-
-<p>RCU grace periods provide extremely strong memory-ordering guarantees
-for non-idle non-offline code.
-Any code that happens after the end of a given RCU grace period is guaranteed
-to see the effects of all accesses prior to the beginning of that grace
-period that are within RCU read-side critical sections.
-Similarly, any code that happens before the beginning of a given RCU grace
-period is guaranteed to see the effects of all accesses following the end
-of that grace period that are within RCU read-side critical sections.
-
-<p>Note well that RCU-sched read-side critical sections include any region
-of code for which preemption is disabled.
-Given that each individual machine instruction can be thought of as
-an extremely small region of preemption-disabled code, one can think of
-<tt>synchronize_rcu()</tt> as <tt>smp_mb()</tt> on steroids.
-
-<p>RCU updaters use this guarantee by splitting their updates into
-two phases, one of which is executed before the grace period and
-the other of which is executed after the grace period.
-In the most common use case, phase one removes an element from
-a linked RCU-protected data structure, and phase two frees that element.
-For this to work, any readers that have witnessed state prior to the
-phase-one update (in the common case, removal) must not witness state
-following the phase-two update (in the common case, freeing).
-
-<p>The RCU implementation provides this guarantee using a network
-of lock-based critical sections, memory barriers, and per-CPU
-processing, as is described in the following sections.
-
-<h3><a name="Tree RCU Grace Period Memory Ordering Building Blocks">
-Tree RCU Grace Period Memory Ordering Building Blocks</a></h3>
-
-<p>The workhorse for RCU's grace-period memory ordering is the
-critical section for the <tt>rcu_node</tt> structure's
-<tt>-&gt;lock</tt>.
-These critical sections use helper functions for lock acquisition, including
-<tt>raw_spin_lock_rcu_node()</tt>,
-<tt>raw_spin_lock_irq_rcu_node()</tt>, and
-<tt>raw_spin_lock_irqsave_rcu_node()</tt>.
-Their lock-release counterparts are
-<tt>raw_spin_unlock_rcu_node()</tt>,
-<tt>raw_spin_unlock_irq_rcu_node()</tt>, and
-<tt>raw_spin_unlock_irqrestore_rcu_node()</tt>,
-respectively.
-For completeness, a
-<tt>raw_spin_trylock_rcu_node()</tt>
-is also provided.
-The key point is that the lock-acquisition functions, including
-<tt>raw_spin_trylock_rcu_node()</tt>, all invoke
-<tt>smp_mb__after_unlock_lock()</tt> immediately after successful
-acquisition of the lock.
-
-<p>Therefore, for any given <tt>rcu_node</tt> structure, any access
-happening before one of the above lock-release functions will be seen
-by all CPUs as happening before any access happening after a later
-one of the above lock-acquisition functions.
-Furthermore, any access happening before one of the
-above lock-release function on any given CPU will be seen by all
-CPUs as happening before any access happening after a later one
-of the above lock-acquisition functions executing on that same CPU,
-even if the lock-release and lock-acquisition functions are operating
-on different <tt>rcu_node</tt> structures.
-Tree RCU uses these two ordering guarantees to form an ordering
-network among all CPUs that were in any way involved in the grace
-period, including any CPUs that came online or went offline during
-the grace period in question.
-
-<p>The following litmus test exhibits the ordering effects of these
-lock-acquisition and lock-release functions:
-
-<pre>
- 1 int x, y, z;
- 2
- 3 void task0(void)
- 4 {
- 5   raw_spin_lock_rcu_node(rnp);
- 6   WRITE_ONCE(x, 1);
- 7   r1 = READ_ONCE(y);
- 8   raw_spin_unlock_rcu_node(rnp);
- 9 }
-10
-11 void task1(void)
-12 {
-13   raw_spin_lock_rcu_node(rnp);
-14   WRITE_ONCE(y, 1);
-15   r2 = READ_ONCE(z);
-16   raw_spin_unlock_rcu_node(rnp);
-17 }
-18
-19 void task2(void)
-20 {
-21   WRITE_ONCE(z, 1);
-22   smp_mb();
-23   r3 = READ_ONCE(x);
-24 }
-25
-26 WARN_ON(r1 == 0 &amp;&amp; r2 == 0 &amp;&amp; r3 == 0);
-</pre>
-
-<p>The <tt>WARN_ON()</tt> is evaluated at &ldquo;the end of time&rdquo;,
-after all changes have propagated throughout the system.
-Without the <tt>smp_mb__after_unlock_lock()</tt> provided by the
-acquisition functions, this <tt>WARN_ON()</tt> could trigger, for example
-on PowerPC.
-The <tt>smp_mb__after_unlock_lock()</tt> invocations prevent this
-<tt>WARN_ON()</tt> from triggering.
-
-<p>This approach must be extended to include idle CPUs, which need
-RCU's grace-period memory ordering guarantee to extend to any
-RCU read-side critical sections preceding and following the current
-idle sojourn.
-This case is handled by calls to the strongly ordered
-<tt>atomic_add_return()</tt> read-modify-write atomic operation that
-is invoked within <tt>rcu_dynticks_eqs_enter()</tt> at idle-entry
-time and within <tt>rcu_dynticks_eqs_exit()</tt> at idle-exit time.
-The grace-period kthread invokes <tt>rcu_dynticks_snap()</tt> and
-<tt>rcu_dynticks_in_eqs_since()</tt> (both of which invoke
-an <tt>atomic_add_return()</tt> of zero) to detect idle CPUs.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	But what about CPUs that remain offline for the entire
-	grace period?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	Such CPUs will be offline at the beginning of the grace period,
-	so the grace period won't expect quiescent states from them.
-	Races between grace-period start and CPU-hotplug operations
-	are mediated by the CPU's leaf <tt>rcu_node</tt> structure's
-	<tt>-&gt;lock</tt> as described above.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>The approach must be extended to handle one final case, that
-of waking a task blocked in <tt>synchronize_rcu()</tt>.
-This task might be affinitied to a CPU that is not yet aware that
-the grace period has ended, and thus might not yet be subject to
-the grace period's memory ordering.
-Therefore, there is an <tt>smp_mb()</tt> after the return from
-<tt>wait_for_completion()</tt> in the <tt>synchronize_rcu()</tt>
-code path.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	What?  Where???
-	I don't see any <tt>smp_mb()</tt> after the return from
-	<tt>wait_for_completion()</tt>!!!
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	That would be because I spotted the need for that
-	<tt>smp_mb()</tt> during the creation of this documentation,
-	and it is therefore unlikely to hit mainline before v4.14.
-	Kudos to Lance Roy, Will Deacon, Peter Zijlstra, and
-	Jonathan Cameron for asking questions that sensitized me
-	to the rather elaborate sequence of events that demonstrate
-	the need for this memory barrier.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>Tree RCU's grace--period memory-ordering guarantees rely most
-heavily on the <tt>rcu_node</tt> structure's <tt>-&gt;lock</tt>
-field, so much so that it is necessary to abbreviate this pattern
-in the diagrams in the next section.
-For example, consider the <tt>rcu_prepare_for_idle()</tt> function
-shown below, which is one of several functions that enforce ordering
-of newly arrived RCU callbacks against future grace periods:
-
-<pre>
- 1 static void rcu_prepare_for_idle(void)
- 2 {
- 3   bool needwake;
- 4   struct rcu_data *rdp;
- 5   struct rcu_dynticks *rdtp = this_cpu_ptr(&amp;rcu_dynticks);
- 6   struct rcu_node *rnp;
- 7   struct rcu_state *rsp;
- 8   int tne;
- 9
-10   if (IS_ENABLED(CONFIG_RCU_NOCB_CPU_ALL) ||
-11       rcu_is_nocb_cpu(smp_processor_id()))
-12     return;
-13   tne = READ_ONCE(tick_nohz_active);
-14   if (tne != rdtp-&gt;tick_nohz_enabled_snap) {
-15     if (rcu_cpu_has_callbacks(NULL))
-16       invoke_rcu_core();
-17     rdtp-&gt;tick_nohz_enabled_snap = tne;
-18     return;
-19   }
-20   if (!tne)
-21     return;
-22   if (rdtp-&gt;all_lazy &amp;&amp;
-23       rdtp-&gt;nonlazy_posted != rdtp-&gt;nonlazy_posted_snap) {
-24     rdtp-&gt;all_lazy = false;
-25     rdtp-&gt;nonlazy_posted_snap = rdtp-&gt;nonlazy_posted;
-26     invoke_rcu_core();
-27     return;
-28   }
-29   if (rdtp-&gt;last_accelerate == jiffies)
-30     return;
-31   rdtp-&gt;last_accelerate = jiffies;
-32   for_each_rcu_flavor(rsp) {
-33     rdp = this_cpu_ptr(rsp-&gt;rda);
-34     if (rcu_segcblist_pend_cbs(&amp;rdp-&gt;cblist))
-35       continue;
-36     rnp = rdp-&gt;mynode;
-37     raw_spin_lock_rcu_node(rnp);
-38     needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
-39     raw_spin_unlock_rcu_node(rnp);
-40     if (needwake)
-41       rcu_gp_kthread_wake(rsp);
-42   }
-43 }
-</pre>
-
-<p>But the only part of <tt>rcu_prepare_for_idle()</tt> that really
-matters for this discussion are lines&nbsp;37&ndash;39.
-We will therefore abbreviate this function as follows:
-
-</p><p><img src="rcu_node-lock.svg" alt="rcu_node-lock.svg">
-
-<p>The box represents the <tt>rcu_node</tt> structure's <tt>-&gt;lock</tt>
-critical section, with the double line on top representing the additional
-<tt>smp_mb__after_unlock_lock()</tt>.
-
-<h3><a name="Tree RCU Grace Period Memory Ordering Components">
-Tree RCU Grace Period Memory Ordering Components</a></h3>
-
-<p>Tree RCU's grace-period memory-ordering guarantee is provided by
-a number of RCU components:
-
-<ol>
-<li>	<a href="#Callback Registry">Callback Registry</a>
-<li>	<a href="#Grace-Period Initialization">Grace-Period Initialization</a>
-<li>	<a href="#Self-Reported Quiescent States">
-	Self-Reported Quiescent States</a>
-<li>	<a href="#Dynamic Tick Interface">Dynamic Tick Interface</a>
-<li>	<a href="#CPU-Hotplug Interface">CPU-Hotplug Interface</a>
-<li>	<a href="Forcing Quiescent States">Forcing Quiescent States</a>
-<li>	<a href="Grace-Period Cleanup">Grace-Period Cleanup</a>
-<li>	<a href="Callback Invocation">Callback Invocation</a>
-</ol>
-
-<p>Each of the following section looks at the corresponding component
-in detail.
-
-<h4><a name="Callback Registry">Callback Registry</a></h4>
-
-<p>If RCU's grace-period guarantee is to mean anything at all, any
-access that happens before a given invocation of <tt>call_rcu()</tt>
-must also happen before the corresponding grace period.
-The implementation of this portion of RCU's grace period guarantee
-is shown in the following figure:
-
-</p><p><img src="TreeRCU-callback-registry.svg" alt="TreeRCU-callback-registry.svg">
-
-<p>Because <tt>call_rcu()</tt> normally acts only on CPU-local state,
-it provides no ordering guarantees, either for itself or for
-phase one of the update (which again will usually be removal of
-an element from an RCU-protected data structure).
-It simply enqueues the <tt>rcu_head</tt> structure on a per-CPU list,
-which cannot become associated with a grace period until a later
-call to <tt>rcu_accelerate_cbs()</tt>, as shown in the diagram above.
-
-<p>One set of code paths shown on the left invokes
-<tt>rcu_accelerate_cbs()</tt> via
-<tt>note_gp_changes()</tt>, either directly from <tt>call_rcu()</tt> (if
-the current CPU is inundated with queued <tt>rcu_head</tt> structures)
-or more likely from an <tt>RCU_SOFTIRQ</tt> handler.
-Another code path in the middle is taken only in kernels built with
-<tt>CONFIG_RCU_FAST_NO_HZ=y</tt>, which invokes
-<tt>rcu_accelerate_cbs()</tt> via <tt>rcu_prepare_for_idle()</tt>.
-The final code path on the right is taken only in kernels built with
-<tt>CONFIG_HOTPLUG_CPU=y</tt>, which invokes
-<tt>rcu_accelerate_cbs()</tt> via
-<tt>rcu_advance_cbs()</tt>, <tt>rcu_migrate_callbacks</tt>,
-<tt>rcutree_migrate_callbacks()</tt>, and <tt>takedown_cpu()</tt>,
-which in turn is invoked on a surviving CPU after the outgoing
-CPU has been completely offlined.
-
-<p>There are a few other code paths within grace-period processing
-that opportunistically invoke <tt>rcu_accelerate_cbs()</tt>.
-However, either way, all of the CPU's recently queued <tt>rcu_head</tt>
-structures are associated with a future grace-period number under
-the protection of the CPU's lead <tt>rcu_node</tt> structure's
-<tt>-&gt;lock</tt>.
-In all cases, there is full ordering against any prior critical section
-for that same <tt>rcu_node</tt> structure's <tt>-&gt;lock</tt>, and
-also full ordering against any of the current task's or CPU's prior critical
-sections for any <tt>rcu_node</tt> structure's <tt>-&gt;lock</tt>.
-
-<p>The next section will show how this ordering ensures that any
-accesses prior to the <tt>call_rcu()</tt> (particularly including phase
-one of the update)
-happen before the start of the corresponding grace period.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	But what about <tt>synchronize_rcu()</tt>?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	The <tt>synchronize_rcu()</tt> passes <tt>call_rcu()</tt>
-	to <tt>wait_rcu_gp()</tt>, which invokes it.
-	So either way, it eventually comes down to <tt>call_rcu()</tt>.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<h4><a name="Grace-Period Initialization">Grace-Period Initialization</a></h4>
-
-<p>Grace-period initialization is carried out by
-the grace-period kernel thread, which makes several passes over the
-<tt>rcu_node</tt> tree within the <tt>rcu_gp_init()</tt> function.
-This means that showing the full flow of ordering through the
-grace-period computation will require duplicating this tree.
-If you find this confusing, please note that the state of the
-<tt>rcu_node</tt> changes over time, just like Heraclitus's river.
-However, to keep the <tt>rcu_node</tt> river tractable, the
-grace-period kernel thread's traversals are presented in multiple
-parts, starting in this section with the various phases of
-grace-period initialization.
-
-<p>The first ordering-related grace-period initialization action is to
-advance the <tt>rcu_state</tt> structure's <tt>-&gt;gp_seq</tt>
-grace-period-number counter, as shown below:
-
-</p><p><img src="TreeRCU-gp-init-1.svg" alt="TreeRCU-gp-init-1.svg" width="75%">
-
-<p>The actual increment is carried out using <tt>smp_store_release()</tt>,
-which helps reject false-positive RCU CPU stall detection.
-Note that only the root <tt>rcu_node</tt> structure is touched.
-
-<p>The first pass through the <tt>rcu_node</tt> tree updates bitmasks
-based on CPUs having come online or gone offline since the start of
-the previous grace period.
-In the common case where the number of online CPUs for this <tt>rcu_node</tt>
-structure has not transitioned to or from zero,
-this pass will scan only the leaf <tt>rcu_node</tt> structures.
-However, if the number of online CPUs for a given leaf <tt>rcu_node</tt>
-structure has transitioned from zero,
-<tt>rcu_init_new_rnp()</tt> will be invoked for the first incoming CPU.
-Similarly, if the number of online CPUs for a given leaf <tt>rcu_node</tt>
-structure has transitioned to zero,
-<tt>rcu_cleanup_dead_rnp()</tt> will be invoked for the last outgoing CPU.
-The diagram below shows the path of ordering if the leftmost
-<tt>rcu_node</tt> structure onlines its first CPU and if the next
-<tt>rcu_node</tt> structure has no online CPUs
-(or, alternatively if the leftmost <tt>rcu_node</tt> structure offlines
-its last CPU and if the next <tt>rcu_node</tt> structure has no online CPUs).
-
-</p><p><img src="TreeRCU-gp-init-2.svg" alt="TreeRCU-gp-init-1.svg" width="75%">
-
-<p>The final <tt>rcu_gp_init()</tt> pass through the <tt>rcu_node</tt>
-tree traverses breadth-first, setting each <tt>rcu_node</tt> structure's
-<tt>-&gt;gp_seq</tt> field to the newly advanced value from the
-<tt>rcu_state</tt> structure, as shown in the following diagram.
-
-</p><p><img src="TreeRCU-gp-init-3.svg" alt="TreeRCU-gp-init-1.svg" width="75%">
-
-<p>This change will also cause each CPU's next call to
-<tt>__note_gp_changes()</tt>
-to notice that a new grace period has started, as described in the next
-section.
-But because the grace-period kthread started the grace period at the
-root (with the advancing of the <tt>rcu_state</tt> structure's
-<tt>-&gt;gp_seq</tt> field) before setting each leaf <tt>rcu_node</tt>
-structure's <tt>-&gt;gp_seq</tt> field, each CPU's observation of
-the start of the grace period will happen after the actual start
-of the grace period.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	But what about the CPU that started the grace period?
-	Why wouldn't it see the start of the grace period right when
-	it started that grace period?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	In some deep philosophical and overly anthromorphized
-	sense, yes, the CPU starting the grace period is immediately
-	aware of having done so.
-	However, if we instead assume that RCU is not self-aware,
-	then even the CPU starting the grace period does not really
-	become aware of the start of this grace period until its
-	first call to <tt>__note_gp_changes()</tt>.
-	On the other hand, this CPU potentially gets early notification
-	because it invokes <tt>__note_gp_changes()</tt> during its
-	last <tt>rcu_gp_init()</tt> pass through its leaf
-	<tt>rcu_node</tt> structure.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<h4><a name="Self-Reported Quiescent States">
-Self-Reported Quiescent States</a></h4>
-
-<p>When all entities that might block the grace period have reported
-quiescent states (or as described in a later section, had quiescent
-states reported on their behalf), the grace period can end.
-Online non-idle CPUs report their own quiescent states, as shown
-in the following diagram:
-
-</p><p><img src="TreeRCU-qs.svg" alt="TreeRCU-qs.svg" width="75%">
-
-<p>This is for the last CPU to report a quiescent state, which signals
-the end of the grace period.
-Earlier quiescent states would push up the <tt>rcu_node</tt> tree
-only until they encountered an <tt>rcu_node</tt> structure that
-is waiting for additional quiescent states.
-However, ordering is nevertheless preserved because some later quiescent
-state will acquire that <tt>rcu_node</tt> structure's <tt>-&gt;lock</tt>.
-
-<p>Any number of events can lead up to a CPU invoking
-<tt>note_gp_changes</tt> (or alternatively, directly invoking
-<tt>__note_gp_changes()</tt>), at which point that CPU will notice
-the start of a new grace period while holding its leaf
-<tt>rcu_node</tt> lock.
-Therefore, all execution shown in this diagram happens after the
-start of the grace period.
-In addition, this CPU will consider any RCU read-side critical
-section that started before the invocation of <tt>__note_gp_changes()</tt>
-to have started before the grace period, and thus a critical
-section that the grace period must wait on.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	But a RCU read-side critical section might have started
-	after the beginning of the grace period
-	(the advancing of <tt>-&gt;gp_seq</tt> from earlier), so why should
-	the grace period wait on such a critical section?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	It is indeed not necessary for the grace period to wait on such
-	a critical section.
-	However, it is permissible to wait on it.
-	And it is furthermore important to wait on it, as this
-	lazy approach is far more scalable than a &ldquo;big bang&rdquo;
-	all-at-once grace-period start could possibly be.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>If the CPU does a context switch, a quiescent state will be
-noted by <tt>rcu_node_context_switch()</tt> on the left.
-On the other hand, if the CPU takes a scheduler-clock interrupt
-while executing in usermode, a quiescent state will be noted by
-<tt>rcu_sched_clock_irq()</tt> on the right.
-Either way, the passage through a quiescent state will be noted
-in a per-CPU variable.
-
-<p>The next time an <tt>RCU_SOFTIRQ</tt> handler executes on
-this CPU (for example, after the next scheduler-clock
-interrupt), <tt>rcu_core()</tt> will invoke
-<tt>rcu_check_quiescent_state()</tt>, which will notice the
-recorded quiescent state, and invoke
-<tt>rcu_report_qs_rdp()</tt>.
-If <tt>rcu_report_qs_rdp()</tt> verifies that the quiescent state
-really does apply to the current grace period, it invokes
-<tt>rcu_report_rnp()</tt> which traverses up the <tt>rcu_node</tt>
-tree as shown at the bottom of the diagram, clearing bits from
-each <tt>rcu_node</tt> structure's <tt>-&gt;qsmask</tt> field,
-and propagating up the tree when the result is zero.
-
-<p>Note that traversal passes upwards out of a given <tt>rcu_node</tt>
-structure only if the current CPU is reporting the last quiescent
-state for the subtree headed by that <tt>rcu_node</tt> structure.
-A key point is that if a CPU's traversal stops at a given <tt>rcu_node</tt>
-structure, then there will be a later traversal by another CPU
-(or perhaps the same one) that proceeds upwards
-from that point, and the <tt>rcu_node</tt> <tt>-&gt;lock</tt>
-guarantees that the first CPU's quiescent state happens before the
-remainder of the second CPU's traversal.
-Applying this line of thought repeatedly shows that all CPUs'
-quiescent states happen before the last CPU traverses through
-the root <tt>rcu_node</tt> structure, the &ldquo;last CPU&rdquo;
-being the one that clears the last bit in the root <tt>rcu_node</tt>
-structure's <tt>-&gt;qsmask</tt> field.
-
-<h4><a name="Dynamic Tick Interface">Dynamic Tick Interface</a></h4>
-
-<p>Due to energy-efficiency considerations, RCU is forbidden from
-disturbing idle CPUs.
-CPUs are therefore required to notify RCU when entering or leaving idle
-state, which they do via fully ordered value-returning atomic operations
-on a per-CPU variable.
-The ordering effects are as shown below:
-
-</p><p><img src="TreeRCU-dyntick.svg" alt="TreeRCU-dyntick.svg" width="50%">
-
-<p>The RCU grace-period kernel thread samples the per-CPU idleness
-variable while holding the corresponding CPU's leaf <tt>rcu_node</tt>
-structure's <tt>-&gt;lock</tt>.
-This means that any RCU read-side critical sections that precede the
-idle period (the oval near the top of the diagram above) will happen
-before the end of the current grace period.
-Similarly, the beginning of the current grace period will happen before
-any RCU read-side critical sections that follow the
-idle period (the oval near the bottom of the diagram above).
-
-<p>Plumbing this into the full grace-period execution is described
-<a href="#Forcing Quiescent States">below</a>.
-
-<h4><a name="CPU-Hotplug Interface">CPU-Hotplug Interface</a></h4>
-
-<p>RCU is also forbidden from disturbing offline CPUs, which might well
-be powered off and removed from the system completely.
-CPUs are therefore required to notify RCU of their comings and goings
-as part of the corresponding CPU hotplug operations.
-The ordering effects are shown below:
-
-</p><p><img src="TreeRCU-hotplug.svg" alt="TreeRCU-hotplug.svg" width="50%">
-
-<p>Because CPU hotplug operations are much less frequent than idle transitions,
-they are heavier weight, and thus acquire the CPU's leaf <tt>rcu_node</tt>
-structure's <tt>-&gt;lock</tt> and update this structure's
-<tt>-&gt;qsmaskinitnext</tt>.
-The RCU grace-period kernel thread samples this mask to detect CPUs
-having gone offline since the beginning of this grace period.
-
-<p>Plumbing this into the full grace-period execution is described
-<a href="#Forcing Quiescent States">below</a>.
-
-<h4><a name="Forcing Quiescent States">Forcing Quiescent States</a></h4>
-
-<p>As noted above, idle and offline CPUs cannot report their own
-quiescent states, and therefore the grace-period kernel thread
-must do the reporting on their behalf.
-This process is called &ldquo;forcing quiescent states&rdquo;, it is
-repeated every few jiffies, and its ordering effects are shown below:
-
-</p><p><img src="TreeRCU-gp-fqs.svg" alt="TreeRCU-gp-fqs.svg" width="100%">
-
-<p>Each pass of quiescent state forcing is guaranteed to traverse the
-leaf <tt>rcu_node</tt> structures, and if there are no new quiescent
-states due to recently idled and/or offlined CPUs, then only the
-leaves are traversed.
-However, if there is a newly offlined CPU as illustrated on the left
-or a newly idled CPU as illustrated on the right, the corresponding
-quiescent state will be driven up towards the root.
-As with self-reported quiescent states, the upwards driving stops
-once it reaches an <tt>rcu_node</tt> structure that has quiescent
-states outstanding from other CPUs.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	The leftmost drive to root stopped before it reached
-	the root <tt>rcu_node</tt> structure, which means that
-	there are still CPUs subordinate to that structure on
-	which the current grace period is waiting.
-	Given that, how is it possible that the rightmost drive
-	to root ended the grace period?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	Good analysis!
-	It is in fact impossible in the absence of bugs in RCU.
-	But this diagram is complex enough as it is, so simplicity
-	overrode accuracy.
-	You can think of it as poetic license, or you can think of
-	it as misdirection that is resolved in the
-	<a href="#Putting It All Together">stitched-together diagram</a>.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<h4><a name="Grace-Period Cleanup">Grace-Period Cleanup</a></h4>
-
-<p>Grace-period cleanup first scans the <tt>rcu_node</tt> tree
-breadth-first advancing all the <tt>-&gt;gp_seq</tt> fields, then it
-advances the <tt>rcu_state</tt> structure's <tt>-&gt;gp_seq</tt> field.
-The ordering effects are shown below:
-
-</p><p><img src="TreeRCU-gp-cleanup.svg" alt="TreeRCU-gp-cleanup.svg" width="75%">
-
-<p>As indicated by the oval at the bottom of the diagram, once
-grace-period cleanup is complete, the next grace period can begin.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	But when precisely does the grace period end?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	There is no useful single point at which the grace period
-	can be said to end.
-	The earliest reasonable candidate is as soon as the last
-	CPU has reported its quiescent state, but it may be some
-	milliseconds before RCU becomes aware of this.
-	The latest reasonable candidate is once the <tt>rcu_state</tt>
-	structure's <tt>-&gt;gp_seq</tt> field has been updated,
-	but it is quite possible that some CPUs have already completed
-	phase two of their updates by that time.
-	In short, if you are going to work with RCU, you need to
-	learn to embrace uncertainty.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-
-<h4><a name="Callback Invocation">Callback Invocation</a></h4>
-
-<p>Once a given CPU's leaf <tt>rcu_node</tt> structure's
-<tt>-&gt;gp_seq</tt> field has been updated, that CPU can begin
-invoking its RCU callbacks that were waiting for this grace period
-to end.
-These callbacks are identified by <tt>rcu_advance_cbs()</tt>,
-which is usually invoked by <tt>__note_gp_changes()</tt>.
-As shown in the diagram below, this invocation can be triggered by
-the scheduling-clock interrupt (<tt>rcu_sched_clock_irq()</tt> on
-the left) or by idle entry (<tt>rcu_cleanup_after_idle()</tt> on
-the right, but only for kernels build with
-<tt>CONFIG_RCU_FAST_NO_HZ=y</tt>).
-Either way, <tt>RCU_SOFTIRQ</tt> is raised, which results in
-<tt>rcu_do_batch()</tt> invoking the callbacks, which in turn
-allows those callbacks to carry out (either directly or indirectly
-via wakeup) the needed phase-two processing for each update.
-
-</p><p><img src="TreeRCU-callback-invocation.svg" alt="TreeRCU-callback-invocation.svg" width="60%">
-
-<p>Please note that callback invocation can also be prompted by any
-number of corner-case code paths, for example, when a CPU notes that
-it has excessive numbers of callbacks queued.
-In all cases, the CPU acquires its leaf <tt>rcu_node</tt> structure's
-<tt>-&gt;lock</tt> before invoking callbacks, which preserves the
-required ordering against the newly completed grace period.
-
-<p>However, if the callback function communicates to other CPUs,
-for example, doing a wakeup, then it is that function's responsibility
-to maintain ordering.
-For example, if the callback function wakes up a task that runs on
-some other CPU, proper ordering must in place in both the callback
-function and the task being awakened.
-To see why this is important, consider the top half of the
-<a href="#Grace-Period Cleanup">grace-period cleanup</a> diagram.
-The callback might be running on a CPU corresponding to the leftmost
-leaf <tt>rcu_node</tt> structure, and awaken a task that is to run on
-a CPU corresponding to the rightmost leaf <tt>rcu_node</tt> structure,
-and the grace-period kernel thread might not yet have reached the
-rightmost leaf.
-In this case, the grace period's memory ordering might not yet have
-reached that CPU, so again the callback function and the awakened
-task must supply proper ordering.
-
-<h3><a name="Putting It All Together">Putting It All Together</a></h3>
-
-<p>A stitched-together diagram is
-<a href="Tree-RCU-Diagram.html">here</a>.
-
-<h3><a name="Legal Statement">
-Legal Statement</a></h3>
-
-<p>This work represents the view of the author and does not necessarily
-represent the view of IBM.
-
-</p><p>Linux is a registered trademark of Linus Torvalds.
-
-</p><p>Other company, product, and service names may be trademarks or
-service marks of others.
-
-</body></html>
diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
new file mode 100644
index 000000000000..1011b5db1b3d
--- /dev/null
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -0,0 +1,625 @@
+======================================================
+A Tour Through TREE_RCU's Grace-Period Memory Ordering
+======================================================
+
+August 8, 2017
+
+This article was contributed by Paul E.&nbsp;McKenney
+
+Introduction
+============
+
+This document gives a rough visual overview of how Tree RCU's
+grace-period memory ordering guarantee is provided.
+
+What Is Tree RCU's Grace Period Memory Ordering Guarantee?
+==========================================================
+
+RCU grace periods provide extremely strong memory-ordering guarantees
+for non-idle non-offline code.
+Any code that happens after the end of a given RCU grace period is guaranteed
+to see the effects of all accesses prior to the beginning of that grace
+period that are within RCU read-side critical sections.
+Similarly, any code that happens before the beginning of a given RCU grace
+period is guaranteed to see the effects of all accesses following the end
+of that grace period that are within RCU read-side critical sections.
+
+Note well that RCU-sched read-side critical sections include any region
+of code for which preemption is disabled.
+Given that each individual machine instruction can be thought of as
+an extremely small region of preemption-disabled code, one can think of
+``synchronize_rcu()`` as ``smp_mb()`` on steroids.
+
+RCU updaters use this guarantee by splitting their updates into
+two phases, one of which is executed before the grace period and
+the other of which is executed after the grace period.
+In the most common use case, phase one removes an element from
+a linked RCU-protected data structure, and phase two frees that element.
+For this to work, any readers that have witnessed state prior to the
+phase-one update (in the common case, removal) must not witness state
+following the phase-two update (in the common case, freeing).
+
+The RCU implementation provides this guarantee using a network
+of lock-based critical sections, memory barriers, and per-CPU
+processing, as is described in the following sections.
+
+Tree RCU Grace Period Memory Ordering Building Blocks
+=====================================================
+
+The workhorse for RCU's grace-period memory ordering is the
+critical section for the ``rcu_node`` structure's
+``-&gt;lock``. These critical sections use helper functions for lock
+acquisition, including ``raw_spin_lock_rcu_node()``,
+``raw_spin_lock_irq_rcu_node()``, and ``raw_spin_lock_irqsave_rcu_node()``.
+Their lock-release counterparts are ``raw_spin_unlock_rcu_node()``,
+``raw_spin_unlock_irq_rcu_node()``, and
+``raw_spin_unlock_irqrestore_rcu_node()``, respectively.
+For completeness, a ``raw_spin_trylock_rcu_node()`` is also provided.
+The key point is that the lock-acquisition functions, including
+``raw_spin_trylock_rcu_node()``, all invoke ``smp_mb__after_unlock_lock()``
+immediately after successful acquisition of the lock.
+
+Therefore, for any given ``rcu_node`` structure, any access
+happening before one of the above lock-release functions will be seen
+by all CPUs as happening before any access happening after a later
+one of the above lock-acquisition functions.
+Furthermore, any access happening before one of the
+above lock-release function on any given CPU will be seen by all
+CPUs as happening before any access happening after a later one
+of the above lock-acquisition functions executing on that same CPU,
+even if the lock-release and lock-acquisition functions are operating
+on different ``rcu_node`` structures.
+Tree RCU uses these two ordering guarantees to form an ordering
+network among all CPUs that were in any way involved in the grace
+period, including any CPUs that came online or went offline during
+the grace period in question.
+
+The following litmus test exhibits the ordering effects of these
+lock-acquisition and lock-release functions::
+
+    1 int x, y, z;
+    2
+    3 void task0(void)
+    4 {
+    5   raw_spin_lock_rcu_node(rnp);
+    6   WRITE_ONCE(x, 1);
+    7   r1 = READ_ONCE(y);
+    8   raw_spin_unlock_rcu_node(rnp);
+    9 }
+   10
+   11 void task1(void)
+   12 {
+   13   raw_spin_lock_rcu_node(rnp);
+   14   WRITE_ONCE(y, 1);
+   15   r2 = READ_ONCE(z);
+   16   raw_spin_unlock_rcu_node(rnp);
+   17 }
+   18
+   19 void task2(void)
+   20 {
+   21   WRITE_ONCE(z, 1);
+   22   smp_mb();
+   23   r3 = READ_ONCE(x);
+   24 }
+   25
+   26 WARN_ON(r1 == 0 &amp;&amp; r2 == 0 &amp;&amp; r3 == 0);
+
+The ``WARN_ON()`` is evaluated at &ldquo;the end of time&rdquo;,
+after all changes have propagated throughout the system.
+Without the ``smp_mb__after_unlock_lock()`` provided by the
+acquisition functions, this ``WARN_ON()`` could trigger, for example
+on PowerPC.
+The ``smp_mb__after_unlock_lock()`` invocations prevent this
+``WARN_ON()`` from triggering.
+
+This approach must be extended to include idle CPUs, which need
+RCU's grace-period memory ordering guarantee to extend to any
+RCU read-side critical sections preceding and following the current
+idle sojourn.
+This case is handled by calls to the strongly ordered
+``atomic_add_return()`` read-modify-write atomic operation that
+is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
+time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
+The grace-period kthread invokes ``rcu_dynticks_snap()`` and
+``rcu_dynticks_in_eqs_since()`` (both of which invoke
+an ``atomic_add_return()`` of zero) to detect idle CPUs.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| But what about CPUs that remain offline for the entire grace period?  |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Such CPUs will be offline at the beginning of the grace period, so    |
+| the grace period won't expect quiescent states from them. Races       |
+| between grace-period start and CPU-hotplug operations are mediated    |
+| by the CPU's leaf ``rcu_node`` structure's ``->lock`` as described    |
+| above.                                                                |
++-----------------------------------------------------------------------+
+
+The approach must be extended to handle one final case, that of waking a
+task blocked in ``synchronize_rcu()``. This task might be affinitied to
+a CPU that is not yet aware that the grace period has ended, and thus
+might not yet be subject to the grace period's memory ordering.
+Therefore, there is an ``smp_mb()`` after the return from
+``wait_for_completion()`` in the ``synchronize_rcu()`` code path.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| What? Where??? I don't see any ``smp_mb()`` after the return from     |
+| ``wait_for_completion()``!!!                                          |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| That would be because I spotted the need for that ``smp_mb()`` during |
+| the creation of this documentation, and it is therefore unlikely to   |
+| hit mainline before v4.14. Kudos to Lance Roy, Will Deacon, Peter     |
+| Zijlstra, and Jonathan Cameron for asking questions that sensitized   |
+| me to the rather elaborate sequence of events that demonstrate the    |
+| need for this memory barrier.                                         |
++-----------------------------------------------------------------------+
+
+Tree RCU's grace--period memory-ordering guarantees rely most heavily on
+the ``rcu_node`` structure's ``->lock`` field, so much so that it is
+necessary to abbreviate this pattern in the diagrams in the next
+section. For example, consider the ``rcu_prepare_for_idle()`` function
+shown below, which is one of several functions that enforce ordering of
+newly arrived RCU callbacks against future grace periods:
+
+::
+
+    1 static void rcu_prepare_for_idle(void)
+    2 {
+    3   bool needwake;
+    4   struct rcu_data *rdp;
+    5   struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
+    6   struct rcu_node *rnp;
+    7   struct rcu_state *rsp;
+    8   int tne;
+    9
+   10   if (IS_ENABLED(CONFIG_RCU_NOCB_CPU_ALL) ||
+   11       rcu_is_nocb_cpu(smp_processor_id()))
+   12     return;
+   13   tne = READ_ONCE(tick_nohz_active);
+   14   if (tne != rdtp->tick_nohz_enabled_snap) {
+   15     if (rcu_cpu_has_callbacks(NULL))
+   16       invoke_rcu_core();
+   17     rdtp->tick_nohz_enabled_snap = tne;
+   18     return;
+   19   }
+   20   if (!tne)
+   21     return;
+   22   if (rdtp->all_lazy &&
+   23       rdtp->nonlazy_posted != rdtp->nonlazy_posted_snap) {
+   24     rdtp->all_lazy = false;
+   25     rdtp->nonlazy_posted_snap = rdtp->nonlazy_posted;
+   26     invoke_rcu_core();
+   27     return;
+   28   }
+   29   if (rdtp->last_accelerate == jiffies)
+   30     return;
+   31   rdtp->last_accelerate = jiffies;
+   32   for_each_rcu_flavor(rsp) {
+   33     rdp = this_cpu_ptr(rsp->rda);
+   34     if (rcu_segcblist_pend_cbs(&rdp->cblist))
+   35       continue;
+   36     rnp = rdp->mynode;
+   37     raw_spin_lock_rcu_node(rnp);
+   38     needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
+   39     raw_spin_unlock_rcu_node(rnp);
+   40     if (needwake)
+   41       rcu_gp_kthread_wake(rsp);
+   42   }
+   43 }
+
+But the only part of ``rcu_prepare_for_idle()`` that really matters for
+this discussion are lines 37–39. We will therefore abbreviate this
+function as follows:
+
+.. kernel-figure:: rcu_node-lock.svg
+
+The box represents the ``rcu_node`` structure's ``->lock`` critical
+section, with the double line on top representing the additional
+``smp_mb__after_unlock_lock()``.
+
+Tree RCU Grace Period Memory Ordering Components
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Tree RCU's grace-period memory-ordering guarantee is provided by a
+number of RCU components:
+
+#. `Callback Registry <#Callback%20Registry>`__
+#. `Grace-Period Initialization <#Grace-Period%20Initialization>`__
+#. `Self-Reported Quiescent
+   States <#Self-Reported%20Quiescent%20States>`__
+#. `Dynamic Tick Interface <#Dynamic%20Tick%20Interface>`__
+#. `CPU-Hotplug Interface <#CPU-Hotplug%20Interface>`__
+#. `Forcing Quiescent States <Forcing%20Quiescent%20States>`__
+#. `Grace-Period Cleanup <Grace-Period%20Cleanup>`__
+#. `Callback Invocation <Callback%20Invocation>`__
+
+Each of the following section looks at the corresponding component in
+detail.
+
+Callback Registry
+^^^^^^^^^^^^^^^^^
+
+If RCU's grace-period guarantee is to mean anything at all, any access
+that happens before a given invocation of ``call_rcu()`` must also
+happen before the corresponding grace period. The implementation of this
+portion of RCU's grace period guarantee is shown in the following
+figure:
+
+.. kernel-figure:: TreeRCU-callback-registry.svg
+
+Because ``call_rcu()`` normally acts only on CPU-local state, it
+provides no ordering guarantees, either for itself or for phase one of
+the update (which again will usually be removal of an element from an
+RCU-protected data structure). It simply enqueues the ``rcu_head``
+structure on a per-CPU list, which cannot become associated with a grace
+period until a later call to ``rcu_accelerate_cbs()``, as shown in the
+diagram above.
+
+One set of code paths shown on the left invokes ``rcu_accelerate_cbs()``
+via ``note_gp_changes()``, either directly from ``call_rcu()`` (if the
+current CPU is inundated with queued ``rcu_head`` structures) or more
+likely from an ``RCU_SOFTIRQ`` handler. Another code path in the middle
+is taken only in kernels built with ``CONFIG_RCU_FAST_NO_HZ=y``, which
+invokes ``rcu_accelerate_cbs()`` via ``rcu_prepare_for_idle()``. The
+final code path on the right is taken only in kernels built with
+``CONFIG_HOTPLUG_CPU=y``, which invokes ``rcu_accelerate_cbs()`` via
+``rcu_advance_cbs()``, ``rcu_migrate_callbacks``,
+``rcutree_migrate_callbacks()``, and ``takedown_cpu()``, which in turn
+is invoked on a surviving CPU after the outgoing CPU has been completely
+offlined.
+
+There are a few other code paths within grace-period processing that
+opportunistically invoke ``rcu_accelerate_cbs()``. However, either way,
+all of the CPU's recently queued ``rcu_head`` structures are associated
+with a future grace-period number under the protection of the CPU's lead
+``rcu_node`` structure's ``->lock``. In all cases, there is full
+ordering against any prior critical section for that same ``rcu_node``
+structure's ``->lock``, and also full ordering against any of the
+current task's or CPU's prior critical sections for any ``rcu_node``
+structure's ``->lock``.
+
+The next section will show how this ordering ensures that any accesses
+prior to the ``call_rcu()`` (particularly including phase one of the
+update) happen before the start of the corresponding grace period.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| But what about ``synchronize_rcu()``?                                 |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| The ``synchronize_rcu()`` passes ``call_rcu()`` to ``wait_rcu_gp()``, |
+| which invokes it. So either way, it eventually comes down to          |
+| ``call_rcu()``.                                                       |
++-----------------------------------------------------------------------+
+
+Grace-Period Initialization
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Grace-period initialization is carried out by the grace-period kernel
+thread, which makes several passes over the ``rcu_node`` tree within the
+``rcu_gp_init()`` function. This means that showing the full flow of
+ordering through the grace-period computation will require duplicating
+this tree. If you find this confusing, please note that the state of the
+``rcu_node`` changes over time, just like Heraclitus's river. However,
+to keep the ``rcu_node`` river tractable, the grace-period kernel
+thread's traversals are presented in multiple parts, starting in this
+section with the various phases of grace-period initialization.
+
+The first ordering-related grace-period initialization action is to
+advance the ``rcu_state`` structure's ``->gp_seq`` grace-period-number
+counter, as shown below:
+
+.. kernel-figure:: TreeRCU-gp-init-1.svg
+
+The actual increment is carried out using ``smp_store_release()``, which
+helps reject false-positive RCU CPU stall detection. Note that only the
+root ``rcu_node`` structure is touched.
+
+The first pass through the ``rcu_node`` tree updates bitmasks based on
+CPUs having come online or gone offline since the start of the previous
+grace period. In the common case where the number of online CPUs for
+this ``rcu_node`` structure has not transitioned to or from zero, this
+pass will scan only the leaf ``rcu_node`` structures. However, if the
+number of online CPUs for a given leaf ``rcu_node`` structure has
+transitioned from zero, ``rcu_init_new_rnp()`` will be invoked for the
+first incoming CPU. Similarly, if the number of online CPUs for a given
+leaf ``rcu_node`` structure has transitioned to zero,
+``rcu_cleanup_dead_rnp()`` will be invoked for the last outgoing CPU.
+The diagram below shows the path of ordering if the leftmost
+``rcu_node`` structure onlines its first CPU and if the next
+``rcu_node`` structure has no online CPUs (or, alternatively if the
+leftmost ``rcu_node`` structure offlines its last CPU and if the next
+``rcu_node`` structure has no online CPUs).
+
+.. kernel-figure:: TreeRCU-gp-init-1.svg
+
+The final ``rcu_gp_init()`` pass through the ``rcu_node`` tree traverses
+breadth-first, setting each ``rcu_node`` structure's ``->gp_seq`` field
+to the newly advanced value from the ``rcu_state`` structure, as shown
+in the following diagram.
+
+.. kernel-figure:: TreeRCU-gp-init-1.svg
+
+This change will also cause each CPU's next call to
+``__note_gp_changes()`` to notice that a new grace period has started,
+as described in the next section. But because the grace-period kthread
+started the grace period at the root (with the advancing of the
+``rcu_state`` structure's ``->gp_seq`` field) before setting each leaf
+``rcu_node`` structure's ``->gp_seq`` field, each CPU's observation of
+the start of the grace period will happen after the actual start of the
+grace period.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| But what about the CPU that started the grace period? Why wouldn't it |
+| see the start of the grace period right when it started that grace    |
+| period?                                                               |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| In some deep philosophical and overly anthromorphized sense, yes, the |
+| CPU starting the grace period is immediately aware of having done so. |
+| However, if we instead assume that RCU is not self-aware, then even   |
+| the CPU starting the grace period does not really become aware of the |
+| start of this grace period until its first call to                    |
+| ``__note_gp_changes()``. On the other hand, this CPU potentially gets |
+| early notification because it invokes ``__note_gp_changes()`` during  |
+| its last ``rcu_gp_init()`` pass through its leaf ``rcu_node``         |
+| structure.                                                            |
++-----------------------------------------------------------------------+
+
+Self-Reported Quiescent States
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+When all entities that might block the grace period have reported
+quiescent states (or as described in a later section, had quiescent
+states reported on their behalf), the grace period can end. Online
+non-idle CPUs report their own quiescent states, as shown in the
+following diagram:
+
+.. kernel-figure:: TreeRCU-qs.svg
+
+This is for the last CPU to report a quiescent state, which signals the
+end of the grace period. Earlier quiescent states would push up the
+``rcu_node`` tree only until they encountered an ``rcu_node`` structure
+that is waiting for additional quiescent states. However, ordering is
+nevertheless preserved because some later quiescent state will acquire
+that ``rcu_node`` structure's ``->lock``.
+
+Any number of events can lead up to a CPU invoking ``note_gp_changes``
+(or alternatively, directly invoking ``__note_gp_changes()``), at which
+point that CPU will notice the start of a new grace period while holding
+its leaf ``rcu_node`` lock. Therefore, all execution shown in this
+diagram happens after the start of the grace period. In addition, this
+CPU will consider any RCU read-side critical section that started before
+the invocation of ``__note_gp_changes()`` to have started before the
+grace period, and thus a critical section that the grace period must
+wait on.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| But a RCU read-side critical section might have started after the     |
+| beginning of the grace period (the advancing of ``->gp_seq`` from     |
+| earlier), so why should the grace period wait on such a critical      |
+| section?                                                              |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| It is indeed not necessary for the grace period to wait on such a     |
+| critical section. However, it is permissible to wait on it. And it is |
+| furthermore important to wait on it, as this lazy approach is far     |
+| more scalable than a “big bang” all-at-once grace-period start could  |
+| possibly be.                                                          |
++-----------------------------------------------------------------------+
+
+If the CPU does a context switch, a quiescent state will be noted by
+``rcu_node_context_switch()`` on the left. On the other hand, if the CPU
+takes a scheduler-clock interrupt while executing in usermode, a
+quiescent state will be noted by ``rcu_sched_clock_irq()`` on the right.
+Either way, the passage through a quiescent state will be noted in a
+per-CPU variable.
+
+The next time an ``RCU_SOFTIRQ`` handler executes on this CPU (for
+example, after the next scheduler-clock interrupt), ``rcu_core()`` will
+invoke ``rcu_check_quiescent_state()``, which will notice the recorded
+quiescent state, and invoke ``rcu_report_qs_rdp()``. If
+``rcu_report_qs_rdp()`` verifies that the quiescent state really does
+apply to the current grace period, it invokes ``rcu_report_rnp()`` which
+traverses up the ``rcu_node`` tree as shown at the bottom of the
+diagram, clearing bits from each ``rcu_node`` structure's ``->qsmask``
+field, and propagating up the tree when the result is zero.
+
+Note that traversal passes upwards out of a given ``rcu_node`` structure
+only if the current CPU is reporting the last quiescent state for the
+subtree headed by that ``rcu_node`` structure. A key point is that if a
+CPU's traversal stops at a given ``rcu_node`` structure, then there will
+be a later traversal by another CPU (or perhaps the same one) that
+proceeds upwards from that point, and the ``rcu_node`` ``->lock``
+guarantees that the first CPU's quiescent state happens before the
+remainder of the second CPU's traversal. Applying this line of thought
+repeatedly shows that all CPUs' quiescent states happen before the last
+CPU traverses through the root ``rcu_node`` structure, the “last CPU”
+being the one that clears the last bit in the root ``rcu_node``
+structure's ``->qsmask`` field.
+
+Dynamic Tick Interface
+^^^^^^^^^^^^^^^^^^^^^^
+
+Due to energy-efficiency considerations, RCU is forbidden from
+disturbing idle CPUs. CPUs are therefore required to notify RCU when
+entering or leaving idle state, which they do via fully ordered
+value-returning atomic operations on a per-CPU variable. The ordering
+effects are as shown below:
+
+.. kernel-figure:: TreeRCU-dyntick.svg
+
+The RCU grace-period kernel thread samples the per-CPU idleness variable
+while holding the corresponding CPU's leaf ``rcu_node`` structure's
+``->lock``. This means that any RCU read-side critical sections that
+precede the idle period (the oval near the top of the diagram above)
+will happen before the end of the current grace period. Similarly, the
+beginning of the current grace period will happen before any RCU
+read-side critical sections that follow the idle period (the oval near
+the bottom of the diagram above).
+
+Plumbing this into the full grace-period execution is described
+`below <#Forcing%20Quiescent%20States>`__.
+
+CPU-Hotplug Interface
+^^^^^^^^^^^^^^^^^^^^^
+
+RCU is also forbidden from disturbing offline CPUs, which might well be
+powered off and removed from the system completely. CPUs are therefore
+required to notify RCU of their comings and goings as part of the
+corresponding CPU hotplug operations. The ordering effects are shown
+below:
+
+.. kernel-figure:: TreeRCU-hotplug.svg
+
+Because CPU hotplug operations are much less frequent than idle
+transitions, they are heavier weight, and thus acquire the CPU's leaf
+``rcu_node`` structure's ``->lock`` and update this structure's
+``->qsmaskinitnext``. The RCU grace-period kernel thread samples this
+mask to detect CPUs having gone offline since the beginning of this
+grace period.
+
+Plumbing this into the full grace-period execution is described
+`below <#Forcing%20Quiescent%20States>`__.
+
+Forcing Quiescent States
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+As noted above, idle and offline CPUs cannot report their own quiescent
+states, and therefore the grace-period kernel thread must do the
+reporting on their behalf. This process is called “forcing quiescent
+states”, it is repeated every few jiffies, and its ordering effects are
+shown below:
+
+.. kernel-figure:: TreeRCU-gp-fqs.svg
+
+Each pass of quiescent state forcing is guaranteed to traverse the leaf
+``rcu_node`` structures, and if there are no new quiescent states due to
+recently idled and/or offlined CPUs, then only the leaves are traversed.
+However, if there is a newly offlined CPU as illustrated on the left or
+a newly idled CPU as illustrated on the right, the corresponding
+quiescent state will be driven up towards the root. As with
+self-reported quiescent states, the upwards driving stops once it
+reaches an ``rcu_node`` structure that has quiescent states outstanding
+from other CPUs.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| The leftmost drive to root stopped before it reached the root         |
+| ``rcu_node`` structure, which means that there are still CPUs         |
+| subordinate to that structure on which the current grace period is    |
+| waiting. Given that, how is it possible that the rightmost drive to   |
+| root ended the grace period?                                          |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Good analysis! It is in fact impossible in the absence of bugs in     |
+| RCU. But this diagram is complex enough as it is, so simplicity       |
+| overrode accuracy. You can think of it as poetic license, or you can  |
+| think of it as misdirection that is resolved in the                   |
+| `stitched-together diagram <#Putting%20It%20All%20Together>`__.       |
++-----------------------------------------------------------------------+
+
+Grace-Period Cleanup
+^^^^^^^^^^^^^^^^^^^^
+
+Grace-period cleanup first scans the ``rcu_node`` tree breadth-first
+advancing all the ``->gp_seq`` fields, then it advances the
+``rcu_state`` structure's ``->gp_seq`` field. The ordering effects are
+shown below:
+
+.. kernel-figure:: TreeRCU-gp-cleanup.svg
+
+As indicated by the oval at the bottom of the diagram, once grace-period
+cleanup is complete, the next grace period can begin.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| But when precisely does the grace period end?                         |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| There is no useful single point at which the grace period can be said |
+| to end. The earliest reasonable candidate is as soon as the last CPU  |
+| has reported its quiescent state, but it may be some milliseconds     |
+| before RCU becomes aware of this. The latest reasonable candidate is  |
+| once the ``rcu_state`` structure's ``->gp_seq`` field has been        |
+| updated, but it is quite possible that some CPUs have already         |
+| completed phase two of their updates by that time. In short, if you   |
+| are going to work with RCU, you need to learn to embrace uncertainty. |
++-----------------------------------------------------------------------+
+
+Callback Invocation
+^^^^^^^^^^^^^^^^^^^
+
+Once a given CPU's leaf ``rcu_node`` structure's ``->gp_seq`` field has
+been updated, that CPU can begin invoking its RCU callbacks that were
+waiting for this grace period to end. These callbacks are identified by
+``rcu_advance_cbs()``, which is usually invoked by
+``__note_gp_changes()``. As shown in the diagram below, this invocation
+can be triggered by the scheduling-clock interrupt
+(``rcu_sched_clock_irq()`` on the left) or by idle entry
+(``rcu_cleanup_after_idle()`` on the right, but only for kernels build
+with ``CONFIG_RCU_FAST_NO_HZ=y``). Either way, ``RCU_SOFTIRQ`` is
+raised, which results in ``rcu_do_batch()`` invoking the callbacks,
+which in turn allows those callbacks to carry out (either directly or
+indirectly via wakeup) the needed phase-two processing for each update.
+
+.. kernel-figure:: TreeRCU-callback-invocation.svg
+
+Please note that callback invocation can also be prompted by any number
+of corner-case code paths, for example, when a CPU notes that it has
+excessive numbers of callbacks queued. In all cases, the CPU acquires
+its leaf ``rcu_node`` structure's ``->lock`` before invoking callbacks,
+which preserves the required ordering against the newly completed grace
+period.
+
+However, if the callback function communicates to other CPUs, for
+example, doing a wakeup, then it is that function's responsibility to
+maintain ordering. For example, if the callback function wakes up a task
+that runs on some other CPU, proper ordering must in place in both the
+callback function and the task being awakened. To see why this is
+important, consider the top half of the `grace-period
+cleanup <#Grace-Period%20Cleanup>`__ diagram. The callback might be
+running on a CPU corresponding to the leftmost leaf ``rcu_node``
+structure, and awaken a task that is to run on a CPU corresponding to
+the rightmost leaf ``rcu_node`` structure, and the grace-period kernel
+thread might not yet have reached the rightmost leaf. In this case, the
+grace period's memory ordering might not yet have reached that CPU, so
+again the callback function and the awakened task must supply proper
+ordering.
+
+Putting It All Together
+~~~~~~~~~~~~~~~~~~~~~~~
+
+A stitched-together diagram is here:
+
+.. kernel-figure:: TreeRCU-gp.svg
+
+Legal Statement
+~~~~~~~~~~~~~~~
+
+This work represents the view of the author and does not necessarily
+represent the view of IBM.
+
+Linux is a registered trademark of Linus Torvalds.
+
+Other company, product, and service names may be trademarks or service
+marks of others.
diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
deleted file mode 100644
index 5a9238a2883c..000000000000
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ /dev/null
@@ -1,3330 +0,0 @@
-<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
-        "http://www.w3.org/TR/html4/loose.dtd">
-        <html>
-        <head><title>A Tour Through RCU's Requirements [LWN.net]</title>
-        <meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
-
-<h1>A Tour Through RCU's Requirements</h1>
-
-<p>Copyright IBM Corporation, 2015</p>
-<p>Author: Paul E.&nbsp;McKenney</p>
-<p><i>The initial version of this document appeared in the
-<a href="https://lwn.net/">LWN</a> articles
-<a href="https://lwn.net/Articles/652156/">here</a>,
-<a href="https://lwn.net/Articles/652677/">here</a>, and
-<a href="https://lwn.net/Articles/653326/">here</a>.</i></p>
-
-<h2>Introduction</h2>
-
-<p>
-Read-copy update (RCU) is a synchronization mechanism that is often
-used as a replacement for reader-writer locking.
-RCU is unusual in that updaters do not block readers,
-which means that RCU's read-side primitives can be exceedingly fast
-and scalable.
-In addition, updaters can make useful forward progress concurrently
-with readers.
-However, all this concurrency between RCU readers and updaters does raise
-the question of exactly what RCU readers are doing, which in turn
-raises the question of exactly what RCU's requirements are.
-
-<p>
-This document therefore summarizes RCU's requirements, and can be thought
-of as an informal, high-level specification for RCU.
-It is important to understand that RCU's specification is primarily
-empirical in nature;
-in fact, I learned about many of these requirements the hard way.
-This situation might cause some consternation, however, not only
-has this learning process been a lot of fun, but it has also been
-a great privilege to work with so many people willing to apply
-technologies in interesting new ways.
-
-<p>
-All that aside, here are the categories of currently known RCU requirements:
-</p>
-
-<ol>
-<li>	<a href="#Fundamental Requirements">
-	Fundamental Requirements</a>
-<li>	<a href="#Fundamental Non-Requirements">Fundamental Non-Requirements</a>
-<li>	<a href="#Parallelism Facts of Life">
-	Parallelism Facts of Life</a>
-<li>	<a href="#Quality-of-Implementation Requirements">
-	Quality-of-Implementation Requirements</a>
-<li>	<a href="#Linux Kernel Complications">
-	Linux Kernel Complications</a>
-<li>	<a href="#Software-Engineering Requirements">
-	Software-Engineering Requirements</a>
-<li>	<a href="#Other RCU Flavors">
-	Other RCU Flavors</a>
-<li>	<a href="#Possible Future Changes">
-	Possible Future Changes</a>
-</ol>
-
-<p>
-This is followed by a <a href="#Summary">summary</a>,
-however, the answers to each quick quiz immediately follows the quiz.
-Select the big white space with your mouse to see the answer.
-
-<h2><a name="Fundamental Requirements">Fundamental Requirements</a></h2>
-
-<p>
-RCU's fundamental requirements are the closest thing RCU has to hard
-mathematical requirements.
-These are:
-
-<ol>
-<li>	<a href="#Grace-Period Guarantee">
-	Grace-Period Guarantee</a>
-<li>	<a href="#Publish-Subscribe Guarantee">
-	Publish-Subscribe Guarantee</a>
-<li>	<a href="#Memory-Barrier Guarantees">
-	Memory-Barrier Guarantees</a>
-<li>	<a href="#RCU Primitives Guaranteed to Execute Unconditionally">
-	RCU Primitives Guaranteed to Execute Unconditionally</a>
-<li>	<a href="#Guaranteed Read-to-Write Upgrade">
-	Guaranteed Read-to-Write Upgrade</a>
-</ol>
-
-<h3><a name="Grace-Period Guarantee">Grace-Period Guarantee</a></h3>
-
-<p>
-RCU's grace-period guarantee is unusual in being premeditated:
-Jack Slingwine and I had this guarantee firmly in mind when we started
-work on RCU (then called &ldquo;rclock&rdquo;) in the early 1990s.
-That said, the past two decades of experience with RCU have produced
-a much more detailed understanding of this guarantee.
-
-<p>
-RCU's grace-period guarantee allows updaters to wait for the completion
-of all pre-existing RCU read-side critical sections.
-An RCU read-side critical section
-begins with the marker <tt>rcu_read_lock()</tt> and ends with
-the marker <tt>rcu_read_unlock()</tt>.
-These markers may be nested, and RCU treats a nested set as one
-big RCU read-side critical section.
-Production-quality implementations of <tt>rcu_read_lock()</tt> and
-<tt>rcu_read_unlock()</tt> are extremely lightweight, and in
-fact have exactly zero overhead in Linux kernels built for production
-use with <tt>CONFIG_PREEMPT=n</tt>.
-
-<p>
-This guarantee allows ordering to be enforced with extremely low
-overhead to readers, for example:
-
-<blockquote>
-<pre>
- 1 int x, y;
- 2
- 3 void thread0(void)
- 4 {
- 5   rcu_read_lock();
- 6   r1 = READ_ONCE(x);
- 7   r2 = READ_ONCE(y);
- 8   rcu_read_unlock();
- 9 }
-10
-11 void thread1(void)
-12 {
-13   WRITE_ONCE(x, 1);
-14   synchronize_rcu();
-15   WRITE_ONCE(y, 1);
-16 }
-</pre>
-</blockquote>
-
-<p>
-Because the <tt>synchronize_rcu()</tt> on line&nbsp;14 waits for
-all pre-existing readers, any instance of <tt>thread0()</tt> that
-loads a value of zero from <tt>x</tt> must complete before
-<tt>thread1()</tt> stores to <tt>y</tt>, so that instance must
-also load a value of zero from <tt>y</tt>.
-Similarly, any instance of <tt>thread0()</tt> that loads a value of
-one from <tt>y</tt> must have started after the
-<tt>synchronize_rcu()</tt> started, and must therefore also load
-a value of one from <tt>x</tt>.
-Therefore, the outcome:
-<blockquote>
-<pre>
-(r1 == 0 &amp;&amp; r2 == 1)
-</pre>
-</blockquote>
-cannot happen.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Wait a minute!
-	You said that updaters can make useful forward progress concurrently
-	with readers, but pre-existing readers will block
-	<tt>synchronize_rcu()</tt>!!!
-	Just who are you trying to fool???
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	First, if updaters do not wish to be blocked by readers, they can use
-	<tt>call_rcu()</tt> or <tt>kfree_rcu()</tt>, which will
-	be discussed later.
-	Second, even when using <tt>synchronize_rcu()</tt>, the other
-	update-side code does run concurrently with readers, whether
-	pre-existing or not.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>
-This scenario resembles one of the first uses of RCU in
-<a href="https://en.wikipedia.org/wiki/DYNIX">DYNIX/ptx</a>,
-which managed a distributed lock manager's transition into
-a state suitable for handling recovery from node failure,
-more or less as follows:
-
-<blockquote>
-<pre>
- 1 #define STATE_NORMAL        0
- 2 #define STATE_WANT_RECOVERY 1
- 3 #define STATE_RECOVERING    2
- 4 #define STATE_WANT_NORMAL   3
- 5
- 6 int state = STATE_NORMAL;
- 7
- 8 void do_something_dlm(void)
- 9 {
-10   int state_snap;
-11
-12   rcu_read_lock();
-13   state_snap = READ_ONCE(state);
-14   if (state_snap == STATE_NORMAL)
-15     do_something();
-16   else
-17     do_something_carefully();
-18   rcu_read_unlock();
-19 }
-20
-21 void start_recovery(void)
-22 {
-23   WRITE_ONCE(state, STATE_WANT_RECOVERY);
-24   synchronize_rcu();
-25   WRITE_ONCE(state, STATE_RECOVERING);
-26   recovery();
-27   WRITE_ONCE(state, STATE_WANT_NORMAL);
-28   synchronize_rcu();
-29   WRITE_ONCE(state, STATE_NORMAL);
-30 }
-</pre>
-</blockquote>
-
-<p>
-The RCU read-side critical section in <tt>do_something_dlm()</tt>
-works with the <tt>synchronize_rcu()</tt> in <tt>start_recovery()</tt>
-to guarantee that <tt>do_something()</tt> never runs concurrently
-with <tt>recovery()</tt>, but with little or no synchronization
-overhead in <tt>do_something_dlm()</tt>.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Why is the <tt>synchronize_rcu()</tt> on line&nbsp;28 needed?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	Without that extra grace period, memory reordering could result in
-	<tt>do_something_dlm()</tt> executing <tt>do_something()</tt>
-	concurrently with the last bits of <tt>recovery()</tt>.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>
-In order to avoid fatal problems such as deadlocks,
-an RCU read-side critical section must not contain calls to
-<tt>synchronize_rcu()</tt>.
-Similarly, an RCU read-side critical section must not
-contain anything that waits, directly or indirectly, on completion of
-an invocation of <tt>synchronize_rcu()</tt>.
-
-<p>
-Although RCU's grace-period guarantee is useful in and of itself, with
-<a href="https://lwn.net/Articles/573497/">quite a few use cases</a>,
-it would be good to be able to use RCU to coordinate read-side
-access to linked data structures.
-For this, the grace-period guarantee is not sufficient, as can
-be seen in function <tt>add_gp_buggy()</tt> below.
-We will look at the reader's code later, but in the meantime, just think of
-the reader as locklessly picking up the <tt>gp</tt> pointer,
-and, if the value loaded is non-<tt>NULL</tt>, locklessly accessing the
-<tt>-&gt;a</tt> and <tt>-&gt;b</tt> fields.
-
-<blockquote>
-<pre>
- 1 bool add_gp_buggy(int a, int b)
- 2 {
- 3   p = kmalloc(sizeof(*p), GFP_KERNEL);
- 4   if (!p)
- 5     return -ENOMEM;
- 6   spin_lock(&amp;gp_lock);
- 7   if (rcu_access_pointer(gp)) {
- 8     spin_unlock(&amp;gp_lock);
- 9     return false;
-10   }
-11   p-&gt;a = a;
-12   p-&gt;b = a;
-13   gp = p; /* ORDERING BUG */
-14   spin_unlock(&amp;gp_lock);
-15   return true;
-16 }
-</pre>
-</blockquote>
-
-<p>
-The problem is that both the compiler and weakly ordered CPUs are within
-their rights to reorder this code as follows:
-
-<blockquote>
-<pre>
- 1 bool add_gp_buggy_optimized(int a, int b)
- 2 {
- 3   p = kmalloc(sizeof(*p), GFP_KERNEL);
- 4   if (!p)
- 5     return -ENOMEM;
- 6   spin_lock(&amp;gp_lock);
- 7   if (rcu_access_pointer(gp)) {
- 8     spin_unlock(&amp;gp_lock);
- 9     return false;
-10   }
-<b>11   gp = p; /* ORDERING BUG */
-12   p-&gt;a = a;
-13   p-&gt;b = a;</b>
-14   spin_unlock(&amp;gp_lock);
-15   return true;
-16 }
-</pre>
-</blockquote>
-
-<p>
-If an RCU reader fetches <tt>gp</tt> just after
-<tt>add_gp_buggy_optimized</tt> executes line&nbsp;11,
-it will see garbage in the <tt>-&gt;a</tt> and <tt>-&gt;b</tt>
-fields.
-And this is but one of many ways in which compiler and hardware optimizations
-could cause trouble.
-Therefore, we clearly need some way to prevent the compiler and the CPU from
-reordering in this manner, which brings us to the publish-subscribe
-guarantee discussed in the next section.
-
-<h3><a name="Publish-Subscribe Guarantee">Publish/Subscribe Guarantee</a></h3>
-
-<p>
-RCU's publish-subscribe guarantee allows data to be inserted
-into a linked data structure without disrupting RCU readers.
-The updater uses <tt>rcu_assign_pointer()</tt> to insert the
-new data, and readers use <tt>rcu_dereference()</tt> to
-access data, whether new or old.
-The following shows an example of insertion:
-
-<blockquote>
-<pre>
- 1 bool add_gp(int a, int b)
- 2 {
- 3   p = kmalloc(sizeof(*p), GFP_KERNEL);
- 4   if (!p)
- 5     return -ENOMEM;
- 6   spin_lock(&amp;gp_lock);
- 7   if (rcu_access_pointer(gp)) {
- 8     spin_unlock(&amp;gp_lock);
- 9     return false;
-10   }
-11   p-&gt;a = a;
-12   p-&gt;b = a;
-13   rcu_assign_pointer(gp, p);
-14   spin_unlock(&amp;gp_lock);
-15   return true;
-16 }
-</pre>
-</blockquote>
-
-<p>
-The <tt>rcu_assign_pointer()</tt> on line&nbsp;13 is conceptually
-equivalent to a simple assignment statement, but also guarantees
-that its assignment will
-happen after the two assignments in lines&nbsp;11 and&nbsp;12,
-similar to the C11 <tt>memory_order_release</tt> store operation.
-It also prevents any number of &ldquo;interesting&rdquo; compiler
-optimizations, for example, the use of <tt>gp</tt> as a scratch
-location immediately preceding the assignment.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	But <tt>rcu_assign_pointer()</tt> does nothing to prevent the
-	two assignments to <tt>p-&gt;a</tt> and <tt>p-&gt;b</tt>
-	from being reordered.
-	Can't that also cause problems?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	No, it cannot.
-	The readers cannot see either of these two fields until
-	the assignment to <tt>gp</tt>, by which time both fields are
-	fully initialized.
-	So reordering the assignments
-	to <tt>p-&gt;a</tt> and <tt>p-&gt;b</tt> cannot possibly
-	cause any problems.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>
-It is tempting to assume that the reader need not do anything special
-to control its accesses to the RCU-protected data,
-as shown in <tt>do_something_gp_buggy()</tt> below:
-
-<blockquote>
-<pre>
- 1 bool do_something_gp_buggy(void)
- 2 {
- 3   rcu_read_lock();
- 4   p = gp;  /* OPTIMIZATIONS GALORE!!! */
- 5   if (p) {
- 6     do_something(p-&gt;a, p-&gt;b);
- 7     rcu_read_unlock();
- 8     return true;
- 9   }
-10   rcu_read_unlock();
-11   return false;
-12 }
-</pre>
-</blockquote>
-
-<p>
-However, this temptation must be resisted because there are a
-surprisingly large number of ways that the compiler
-(to say nothing of
-<a href="https://h71000.www7.hp.com/wizard/wiz_2637.html">DEC Alpha CPUs</a>)
-can trip this code up.
-For but one example, if the compiler were short of registers, it
-might choose to refetch from <tt>gp</tt> rather than keeping
-a separate copy in <tt>p</tt> as follows:
-
-<blockquote>
-<pre>
- 1 bool do_something_gp_buggy_optimized(void)
- 2 {
- 3   rcu_read_lock();
- 4   if (gp) { /* OPTIMIZATIONS GALORE!!! */
-<b> 5     do_something(gp-&gt;a, gp-&gt;b);</b>
- 6     rcu_read_unlock();
- 7     return true;
- 8   }
- 9   rcu_read_unlock();
-10   return false;
-11 }
-</pre>
-</blockquote>
-
-<p>
-If this function ran concurrently with a series of updates that
-replaced the current structure with a new one,
-the fetches of <tt>gp-&gt;a</tt>
-and <tt>gp-&gt;b</tt> might well come from two different structures,
-which could cause serious confusion.
-To prevent this (and much else besides), <tt>do_something_gp()</tt> uses
-<tt>rcu_dereference()</tt> to fetch from <tt>gp</tt>:
-
-<blockquote>
-<pre>
- 1 bool do_something_gp(void)
- 2 {
- 3   rcu_read_lock();
- 4   p = rcu_dereference(gp);
- 5   if (p) {
- 6     do_something(p-&gt;a, p-&gt;b);
- 7     rcu_read_unlock();
- 8     return true;
- 9   }
-10   rcu_read_unlock();
-11   return false;
-12 }
-</pre>
-</blockquote>
-
-<p>
-The <tt>rcu_dereference()</tt> uses volatile casts and (for DEC Alpha)
-memory barriers in the Linux kernel.
-Should a
-<a href="http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf">high-quality implementation of C11 <tt>memory_order_consume</tt> [PDF]</a>
-ever appear, then <tt>rcu_dereference()</tt> could be implemented
-as a <tt>memory_order_consume</tt> load.
-Regardless of the exact implementation, a pointer fetched by
-<tt>rcu_dereference()</tt> may not be used outside of the
-outermost RCU read-side critical section containing that
-<tt>rcu_dereference()</tt>, unless protection of
-the corresponding data element has been passed from RCU to some
-other synchronization mechanism, most commonly locking or
-<a href="https://www.kernel.org/doc/Documentation/RCU/rcuref.txt">reference counting</a>.
-
-<p>
-In short, updaters use <tt>rcu_assign_pointer()</tt> and readers
-use <tt>rcu_dereference()</tt>, and these two RCU API elements
-work together to ensure that readers have a consistent view of
-newly added data elements.
-
-<p>
-Of course, it is also necessary to remove elements from RCU-protected
-data structures, for example, using the following process:
-
-<ol>
-<li>	Remove the data element from the enclosing structure.
-<li>	Wait for all pre-existing RCU read-side critical sections
-	to complete (because only pre-existing readers can possibly have
-	a reference to the newly removed data element).
-<li>	At this point, only the updater has a reference to the
-	newly removed data element, so it can safely reclaim
-	the data element, for example, by passing it to <tt>kfree()</tt>.
-</ol>
-
-This process is implemented by <tt>remove_gp_synchronous()</tt>:
-
-<blockquote>
-<pre>
- 1 bool remove_gp_synchronous(void)
- 2 {
- 3   struct foo *p;
- 4
- 5   spin_lock(&amp;gp_lock);
- 6   p = rcu_access_pointer(gp);
- 7   if (!p) {
- 8     spin_unlock(&amp;gp_lock);
- 9     return false;
-10   }
-11   rcu_assign_pointer(gp, NULL);
-12   spin_unlock(&amp;gp_lock);
-13   synchronize_rcu();
-14   kfree(p);
-15   return true;
-16 }
-</pre>
-</blockquote>
-
-<p>
-This function is straightforward, with line&nbsp;13 waiting for a grace
-period before line&nbsp;14 frees the old data element.
-This waiting ensures that readers will reach line&nbsp;7 of
-<tt>do_something_gp()</tt> before the data element referenced by
-<tt>p</tt> is freed.
-The <tt>rcu_access_pointer()</tt> on line&nbsp;6 is similar to
-<tt>rcu_dereference()</tt>, except that:
-
-<ol>
-<li>	The value returned by <tt>rcu_access_pointer()</tt>
-	cannot be dereferenced.
-	If you want to access the value pointed to as well as
-	the pointer itself, use <tt>rcu_dereference()</tt>
-	instead of <tt>rcu_access_pointer()</tt>.
-<li>	The call to <tt>rcu_access_pointer()</tt> need not be
-	protected.
-	In contrast, <tt>rcu_dereference()</tt> must either be
-	within an RCU read-side critical section or in a code
-	segment where the pointer cannot change, for example, in
-	code protected by the corresponding update-side lock.
-</ol>
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Without the <tt>rcu_dereference()</tt> or the
-	<tt>rcu_access_pointer()</tt>, what destructive optimizations
-	might the compiler make use of?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	Let's start with what happens to <tt>do_something_gp()</tt>
-	if it fails to use <tt>rcu_dereference()</tt>.
-	It could reuse a value formerly fetched from this same pointer.
-	It could also fetch the pointer from <tt>gp</tt> in a byte-at-a-time
-	manner, resulting in <i>load tearing</i>, in turn resulting a bytewise
-	mash-up of two distinct pointer values.
-	It might even use value-speculation optimizations, where it makes
-	a wrong guess, but by the time it gets around to checking the
-	value, an update has changed the pointer to match the wrong guess.
-	Too bad about any dereferences that returned pre-initialization garbage
-	in the meantime!
-	</font>
-
-	<p><font color="ffffff">
-	For <tt>remove_gp_synchronous()</tt>, as long as all modifications
-	to <tt>gp</tt> are carried out while holding <tt>gp_lock</tt>,
-	the above optimizations are harmless.
-	However, <tt>sparse</tt> will complain if you
-	define <tt>gp</tt> with <tt>__rcu</tt> and then
-	access it without using
-	either <tt>rcu_access_pointer()</tt> or <tt>rcu_dereference()</tt>.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>
-In short, RCU's publish-subscribe guarantee is provided by the combination
-of <tt>rcu_assign_pointer()</tt> and <tt>rcu_dereference()</tt>.
-This guarantee allows data elements to be safely added to RCU-protected
-linked data structures without disrupting RCU readers.
-This guarantee can be used in combination with the grace-period
-guarantee to also allow data elements to be removed from RCU-protected
-linked data structures, again without disrupting RCU readers.
-
-<p>
-This guarantee was only partially premeditated.
-DYNIX/ptx used an explicit memory barrier for publication, but had nothing
-resembling <tt>rcu_dereference()</tt> for subscription, nor did it
-have anything resembling the <tt>smp_read_barrier_depends()</tt>
-that was later subsumed into <tt>rcu_dereference()</tt> and later
-still into <tt>READ_ONCE()</tt>.
-The need for these operations made itself known quite suddenly at a
-late-1990s meeting with the DEC Alpha architects, back in the days when
-DEC was still a free-standing company.
-It took the Alpha architects a good hour to convince me that any sort
-of barrier would ever be needed, and it then took me a good <i>two</i> hours
-to convince them that their documentation did not make this point clear.
-More recent work with the C and C++ standards committees have provided
-much education on tricks and traps from the compiler.
-In short, compilers were much less tricky in the early 1990s, but in
-2015, don't even think about omitting <tt>rcu_dereference()</tt>!
-
-<h3><a name="Memory-Barrier Guarantees">Memory-Barrier Guarantees</a></h3>
-
-<p>
-The previous section's simple linked-data-structure scenario clearly
-demonstrates the need for RCU's stringent memory-ordering guarantees on
-systems with more than one CPU:
-
-<ol>
-<li>	Each CPU that has an RCU read-side critical section that
-	begins before <tt>synchronize_rcu()</tt> starts is
-	guaranteed to execute a full memory barrier between the time
-	that the RCU read-side critical section ends and the time that
-	<tt>synchronize_rcu()</tt> returns.
-	Without this guarantee, a pre-existing RCU read-side critical section
-	might hold a reference to the newly removed <tt>struct foo</tt>
-	after the <tt>kfree()</tt> on line&nbsp;14 of
-	<tt>remove_gp_synchronous()</tt>.
-<li>	Each CPU that has an RCU read-side critical section that ends
-	after <tt>synchronize_rcu()</tt> returns is guaranteed
-	to execute a full memory barrier between the time that
-	<tt>synchronize_rcu()</tt> begins and the time that the RCU
-	read-side critical section begins.
-	Without this guarantee, a later RCU read-side critical section
-	running after the <tt>kfree()</tt> on line&nbsp;14 of
-	<tt>remove_gp_synchronous()</tt> might
-	later run <tt>do_something_gp()</tt> and find the
-	newly deleted <tt>struct foo</tt>.
-<li>	If the task invoking <tt>synchronize_rcu()</tt> remains
-	on a given CPU, then that CPU is guaranteed to execute a full
-	memory barrier sometime during the execution of
-	<tt>synchronize_rcu()</tt>.
-	This guarantee ensures that the <tt>kfree()</tt> on
-	line&nbsp;14 of <tt>remove_gp_synchronous()</tt> really does
-	execute after the removal on line&nbsp;11.
-<li>	If the task invoking <tt>synchronize_rcu()</tt> migrates
-	among a group of CPUs during that invocation, then each of the
-	CPUs in that group is guaranteed to execute a full memory barrier
-	sometime during the execution of <tt>synchronize_rcu()</tt>.
-	This guarantee also ensures that the <tt>kfree()</tt> on
-	line&nbsp;14 of <tt>remove_gp_synchronous()</tt> really does
-	execute after the removal on
-	line&nbsp;11, but also in the case where the thread executing the
-	<tt>synchronize_rcu()</tt> migrates in the meantime.
-</ol>
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Given that multiple CPUs can start RCU read-side critical sections
-	at any time without any ordering whatsoever, how can RCU possibly
-	tell whether or not a given RCU read-side critical section starts
-	before a given instance of <tt>synchronize_rcu()</tt>?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	If RCU cannot tell whether or not a given
-	RCU read-side critical section starts before a
-	given instance of <tt>synchronize_rcu()</tt>,
-	then it must assume that the RCU read-side critical section
-	started first.
-	In other words, a given instance of <tt>synchronize_rcu()</tt>
-	can avoid waiting on a given RCU read-side critical section only
-	if it can prove that <tt>synchronize_rcu()</tt> started first.
-	</font>
-
-	<p><font color="ffffff">
-	A related question is &ldquo;When <tt>rcu_read_lock()</tt>
-	doesn't generate any code, why does it matter how it relates
-	to a grace period?&rdquo;
-	The answer is that it is not the relationship of
-	<tt>rcu_read_lock()</tt> itself that is important, but rather
-	the relationship of the code within the enclosed RCU read-side
-	critical section to the code preceding and following the
-	grace period.
-	If we take this viewpoint, then a given RCU read-side critical
-	section begins before a given grace period when some access
-	preceding the grace period observes the effect of some access
-	within the critical section, in which case none of the accesses
-	within the critical section may observe the effects of any
-	access following the grace period.
-	</font>
-
-	<p><font color="ffffff">
-	As of late 2016, mathematical models of RCU take this
-	viewpoint, for example, see slides&nbsp;62 and&nbsp;63
-	of the
-	<a href="http://www2.rdrop.com/users/paulmck/scalability/paper/LinuxMM.2016.10.04c.LCE.pdf">2016 LinuxCon EU</a>
-	presentation.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	The first and second guarantees require unbelievably strict ordering!
-	Are all these memory barriers <i> really</i> required?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	Yes, they really are required.
-	To see why the first guarantee is required, consider the following
-	sequence of events:
-	</font>
-
-	<ol>
-	<li>	<font color="ffffff">
-		CPU 1: <tt>rcu_read_lock()</tt>
-		</font>
-	<li>	<font color="ffffff">
-		CPU 1: <tt>q = rcu_dereference(gp);
-		/* Very likely to return p. */</tt>
-		</font>
-	<li>	<font color="ffffff">
-		CPU 0: <tt>list_del_rcu(p);</tt>
-		</font>
-	<li>	<font color="ffffff">
-		CPU 0: <tt>synchronize_rcu()</tt> starts.
-		</font>
-	<li>	<font color="ffffff">
-		CPU 1: <tt>do_something_with(q-&gt;a);
-		/* No smp_mb(), so might happen after kfree(). */</tt>
-		</font>
-	<li>	<font color="ffffff">
-		CPU 1: <tt>rcu_read_unlock()</tt>
-		</font>
-	<li>	<font color="ffffff">
-		CPU 0: <tt>synchronize_rcu()</tt> returns.
-		</font>
-	<li>	<font color="ffffff">
-		CPU 0: <tt>kfree(p);</tt>
-		</font>
-	</ol>
-
-	<p><font color="ffffff">
-	Therefore, there absolutely must be a full memory barrier between the
-	end of the RCU read-side critical section and the end of the
-	grace period.
-	</font>
-
-	<p><font color="ffffff">
-	The sequence of events demonstrating the necessity of the second rule
-	is roughly similar:
-	</font>
-
-	<ol>
-	<li>	<font color="ffffff">CPU 0: <tt>list_del_rcu(p);</tt>
-		</font>
-	<li>	<font color="ffffff">CPU 0: <tt>synchronize_rcu()</tt> starts.
-		</font>
-	<li>	<font color="ffffff">CPU 1: <tt>rcu_read_lock()</tt>
-		</font>
-	<li>	<font color="ffffff">CPU 1: <tt>q = rcu_dereference(gp);
-		/* Might return p if no memory barrier. */</tt>
-		</font>
-	<li>	<font color="ffffff">CPU 0: <tt>synchronize_rcu()</tt> returns.
-		</font>
-	<li>	<font color="ffffff">CPU 0: <tt>kfree(p);</tt>
-		</font>
-	<li>	<font color="ffffff">
-		CPU 1: <tt>do_something_with(q-&gt;a); /* Boom!!! */</tt>
-		</font>
-	<li>	<font color="ffffff">CPU 1: <tt>rcu_read_unlock()</tt>
-		</font>
-	</ol>
-
-	<p><font color="ffffff">
-	And similarly, without a memory barrier between the beginning of the
-	grace period and the beginning of the RCU read-side critical section,
-	CPU&nbsp;1 might end up accessing the freelist.
-	</font>
-
-	<p><font color="ffffff">
-	The &ldquo;as if&rdquo; rule of course applies, so that any
-	implementation that acts as if the appropriate memory barriers
-	were in place is a correct implementation.
-	That said, it is much easier to fool yourself into believing
-	that you have adhered to the as-if rule than it is to actually
-	adhere to it!
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	You claim that <tt>rcu_read_lock()</tt> and <tt>rcu_read_unlock()</tt>
-	generate absolutely no code in some kernel builds.
-	This means that the compiler might arbitrarily rearrange consecutive
-	RCU read-side critical sections.
-	Given such rearrangement, if a given RCU read-side critical section
-	is done, how can you be sure that all prior RCU read-side critical
-	sections are done?
-	Won't the compiler rearrangements make that impossible to determine?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	In cases where <tt>rcu_read_lock()</tt> and <tt>rcu_read_unlock()</tt>
-	generate absolutely no code, RCU infers quiescent states only at
-	special locations, for example, within the scheduler.
-	Because calls to <tt>schedule()</tt> had better prevent calling-code
-	accesses to shared variables from being rearranged across the call to
-	<tt>schedule()</tt>, if RCU detects the end of a given RCU read-side
-	critical section, it will necessarily detect the end of all prior
-	RCU read-side critical sections, no matter how aggressively the
-	compiler scrambles the code.
-	</font>
-
-	<p><font color="ffffff">
-	Again, this all assumes that the compiler cannot scramble code across
-	calls to the scheduler, out of interrupt handlers, into the idle loop,
-	into user-mode code, and so on.
-	But if your kernel build allows that sort of scrambling, you have broken
-	far more than just RCU!
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>
-Note that these memory-barrier requirements do not replace the fundamental
-RCU requirement that a grace period wait for all pre-existing readers.
-On the contrary, the memory barriers called out in this section must operate in
-such a way as to <i>enforce</i> this fundamental requirement.
-Of course, different implementations enforce this requirement in different
-ways, but enforce it they must.
-
-<h3><a name="RCU Primitives Guaranteed to Execute Unconditionally">RCU Primitives Guaranteed to Execute Unconditionally</a></h3>
-
-<p>
-The common-case RCU primitives are unconditional.
-They are invoked, they do their job, and they return, with no possibility
-of error, and no need to retry.
-This is a key RCU design philosophy.
-
-<p>
-However, this philosophy is pragmatic rather than pigheaded.
-If someone comes up with a good justification for a particular conditional
-RCU primitive, it might well be implemented and added.
-After all, this guarantee was reverse-engineered, not premeditated.
-The unconditional nature of the RCU primitives was initially an
-accident of implementation, and later experience with synchronization
-primitives with conditional primitives caused me to elevate this
-accident to a guarantee.
-Therefore, the justification for adding a conditional primitive to
-RCU would need to be based on detailed and compelling use cases.
-
-<h3><a name="Guaranteed Read-to-Write Upgrade">Guaranteed Read-to-Write Upgrade</a></h3>
-
-<p>
-As far as RCU is concerned, it is always possible to carry out an
-update within an RCU read-side critical section.
-For example, that RCU read-side critical section might search for
-a given data element, and then might acquire the update-side
-spinlock in order to update that element, all while remaining
-in that RCU read-side critical section.
-Of course, it is necessary to exit the RCU read-side critical section
-before invoking <tt>synchronize_rcu()</tt>, however, this
-inconvenience can be avoided through use of the
-<tt>call_rcu()</tt> and <tt>kfree_rcu()</tt> API members
-described later in this document.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	But how does the upgrade-to-write operation exclude other readers?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	It doesn't, just like normal RCU updates, which also do not exclude
-	RCU readers.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>
-This guarantee allows lookup code to be shared between read-side
-and update-side code, and was premeditated, appearing in the earliest
-DYNIX/ptx RCU documentation.
-
-<h2><a name="Fundamental Non-Requirements">Fundamental Non-Requirements</a></h2>
-
-<p>
-RCU provides extremely lightweight readers, and its read-side guarantees,
-though quite useful, are correspondingly lightweight.
-It is therefore all too easy to assume that RCU is guaranteeing more
-than it really is.
-Of course, the list of things that RCU does not guarantee is infinitely
-long, however, the following sections list a few non-guarantees that
-have caused confusion.
-Except where otherwise noted, these non-guarantees were premeditated.
-
-<ol>
-<li>	<a href="#Readers Impose Minimal Ordering">
-	Readers Impose Minimal Ordering</a>
-<li>	<a href="#Readers Do Not Exclude Updaters">
-	Readers Do Not Exclude Updaters</a>
-<li>	<a href="#Updaters Only Wait For Old Readers">
-	Updaters Only Wait For Old Readers</a>
-<li>	<a href="#Grace Periods Don't Partition Read-Side Critical Sections">
-	Grace Periods Don't Partition Read-Side Critical Sections</a>
-<li>	<a href="#Read-Side Critical Sections Don't Partition Grace Periods">
-	Read-Side Critical Sections Don't Partition Grace Periods</a>
-</ol>
-
-<h3><a name="Readers Impose Minimal Ordering">Readers Impose Minimal Ordering</a></h3>
-
-<p>
-Reader-side markers such as <tt>rcu_read_lock()</tt> and
-<tt>rcu_read_unlock()</tt> provide absolutely no ordering guarantees
-except through their interaction with the grace-period APIs such as
-<tt>synchronize_rcu()</tt>.
-To see this, consider the following pair of threads:
-
-<blockquote>
-<pre>
- 1 void thread0(void)
- 2 {
- 3   rcu_read_lock();
- 4   WRITE_ONCE(x, 1);
- 5   rcu_read_unlock();
- 6   rcu_read_lock();
- 7   WRITE_ONCE(y, 1);
- 8   rcu_read_unlock();
- 9 }
-10
-11 void thread1(void)
-12 {
-13   rcu_read_lock();
-14   r1 = READ_ONCE(y);
-15   rcu_read_unlock();
-16   rcu_read_lock();
-17   r2 = READ_ONCE(x);
-18   rcu_read_unlock();
-19 }
-</pre>
-</blockquote>
-
-<p>
-After <tt>thread0()</tt> and <tt>thread1()</tt> execute
-concurrently, it is quite possible to have
-
-<blockquote>
-<pre>
-(r1 == 1 &amp;&amp; r2 == 0)
-</pre>
-</blockquote>
-
-(that is, <tt>y</tt> appears to have been assigned before <tt>x</tt>),
-which would not be possible if <tt>rcu_read_lock()</tt> and
-<tt>rcu_read_unlock()</tt> had much in the way of ordering
-properties.
-But they do not, so the CPU is within its rights
-to do significant reordering.
-This is by design:  Any significant ordering constraints would slow down
-these fast-path APIs.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Can't the compiler also reorder this code?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	No, the volatile casts in <tt>READ_ONCE()</tt> and
-	<tt>WRITE_ONCE()</tt> prevent the compiler from reordering in
-	this particular case.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<h3><a name="Readers Do Not Exclude Updaters">Readers Do Not Exclude Updaters</a></h3>
-
-<p>
-Neither <tt>rcu_read_lock()</tt> nor <tt>rcu_read_unlock()</tt>
-exclude updates.
-All they do is to prevent grace periods from ending.
-The following example illustrates this:
-
-<blockquote>
-<pre>
- 1 void thread0(void)
- 2 {
- 3   rcu_read_lock();
- 4   r1 = READ_ONCE(y);
- 5   if (r1) {
- 6     do_something_with_nonzero_x();
- 7     r2 = READ_ONCE(x);
- 8     WARN_ON(!r2); /* BUG!!! */
- 9   }
-10   rcu_read_unlock();
-11 }
-12
-13 void thread1(void)
-14 {
-15   spin_lock(&amp;my_lock);
-16   WRITE_ONCE(x, 1);
-17   WRITE_ONCE(y, 1);
-18   spin_unlock(&amp;my_lock);
-19 }
-</pre>
-</blockquote>
-
-<p>
-If the <tt>thread0()</tt> function's <tt>rcu_read_lock()</tt>
-excluded the <tt>thread1()</tt> function's update,
-the <tt>WARN_ON()</tt> could never fire.
-But the fact is that <tt>rcu_read_lock()</tt> does not exclude
-much of anything aside from subsequent grace periods, of which
-<tt>thread1()</tt> has none, so the
-<tt>WARN_ON()</tt> can and does fire.
-
-<h3><a name="Updaters Only Wait For Old Readers">Updaters Only Wait For Old Readers</a></h3>
-
-<p>
-It might be tempting to assume that after <tt>synchronize_rcu()</tt>
-completes, there are no readers executing.
-This temptation must be avoided because
-new readers can start immediately after <tt>synchronize_rcu()</tt>
-starts, and <tt>synchronize_rcu()</tt> is under no
-obligation to wait for these new readers.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Suppose that synchronize_rcu() did wait until <i>all</i>
-	readers had completed instead of waiting only on
-	pre-existing readers.
-	For how long would the updater be able to rely on there
-	being no readers?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	For no time at all.
-	Even if <tt>synchronize_rcu()</tt> were to wait until
-	all readers had completed, a new reader might start immediately after
-	<tt>synchronize_rcu()</tt> completed.
-	Therefore, the code following
-	<tt>synchronize_rcu()</tt> can <i>never</i> rely on there being
-	no readers.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<h3><a name="Grace Periods Don't Partition Read-Side Critical Sections">
-Grace Periods Don't Partition Read-Side Critical Sections</a></h3>
-
-<p>
-It is tempting to assume that if any part of one RCU read-side critical
-section precedes a given grace period, and if any part of another RCU
-read-side critical section follows that same grace period, then all of
-the first RCU read-side critical section must precede all of the second.
-However, this just isn't the case: A single grace period does not
-partition the set of RCU read-side critical sections.
-An example of this situation can be illustrated as follows, where
-<tt>x</tt>, <tt>y</tt>, and <tt>z</tt> are initially all zero:
-
-<blockquote>
-<pre>
- 1 void thread0(void)
- 2 {
- 3   rcu_read_lock();
- 4   WRITE_ONCE(a, 1);
- 5   WRITE_ONCE(b, 1);
- 6   rcu_read_unlock();
- 7 }
- 8
- 9 void thread1(void)
-10 {
-11   r1 = READ_ONCE(a);
-12   synchronize_rcu();
-13   WRITE_ONCE(c, 1);
-14 }
-15
-16 void thread2(void)
-17 {
-18   rcu_read_lock();
-19   r2 = READ_ONCE(b);
-20   r3 = READ_ONCE(c);
-21   rcu_read_unlock();
-22 }
-</pre>
-</blockquote>
-
-<p>
-It turns out that the outcome:
-
-<blockquote>
-<pre>
-(r1 == 1 &amp;&amp; r2 == 0 &amp;&amp; r3 == 1)
-</pre>
-</blockquote>
-
-is entirely possible.
-The following figure show how this can happen, with each circled
-<tt>QS</tt> indicating the point at which RCU recorded a
-<i>quiescent state</i> for each thread, that is, a state in which
-RCU knows that the thread cannot be in the midst of an RCU read-side
-critical section that started before the current grace period:
-
-<p><img src="GPpartitionReaders1.svg" alt="GPpartitionReaders1.svg" width="60%"></p>
-
-<p>
-If it is necessary to partition RCU read-side critical sections in this
-manner, it is necessary to use two grace periods, where the first
-grace period is known to end before the second grace period starts:
-
-<blockquote>
-<pre>
- 1 void thread0(void)
- 2 {
- 3   rcu_read_lock();
- 4   WRITE_ONCE(a, 1);
- 5   WRITE_ONCE(b, 1);
- 6   rcu_read_unlock();
- 7 }
- 8
- 9 void thread1(void)
-10 {
-11   r1 = READ_ONCE(a);
-12   synchronize_rcu();
-13   WRITE_ONCE(c, 1);
-14 }
-15
-16 void thread2(void)
-17 {
-18   r2 = READ_ONCE(c);
-19   synchronize_rcu();
-20   WRITE_ONCE(d, 1);
-21 }
-22
-23 void thread3(void)
-24 {
-25   rcu_read_lock();
-26   r3 = READ_ONCE(b);
-27   r4 = READ_ONCE(d);
-28   rcu_read_unlock();
-29 }
-</pre>
-</blockquote>
-
-<p>
-Here, if <tt>(r1 == 1)</tt>, then
-<tt>thread0()</tt>'s write to <tt>b</tt> must happen
-before the end of <tt>thread1()</tt>'s grace period.
-If in addition <tt>(r4 == 1)</tt>, then
-<tt>thread3()</tt>'s read from <tt>b</tt> must happen
-after the beginning of <tt>thread2()</tt>'s grace period.
-If it is also the case that <tt>(r2 == 1)</tt>, then the
-end of <tt>thread1()</tt>'s grace period must precede the
-beginning of <tt>thread2()</tt>'s grace period.
-This mean that the two RCU read-side critical sections cannot overlap,
-guaranteeing that <tt>(r3 == 1)</tt>.
-As a result, the outcome:
-
-<blockquote>
-<pre>
-(r1 == 1 &amp;&amp; r2 == 1 &amp;&amp; r3 == 0 &amp;&amp; r4 == 1)
-</pre>
-</blockquote>
-
-cannot happen.
-
-<p>
-This non-requirement was also non-premeditated, but became apparent
-when studying RCU's interaction with memory ordering.
-
-<h3><a name="Read-Side Critical Sections Don't Partition Grace Periods">
-Read-Side Critical Sections Don't Partition Grace Periods</a></h3>
-
-<p>
-It is also tempting to assume that if an RCU read-side critical section
-happens between a pair of grace periods, then those grace periods cannot
-overlap.
-However, this temptation leads nowhere good, as can be illustrated by
-the following, with all variables initially zero:
-
-<blockquote>
-<pre>
- 1 void thread0(void)
- 2 {
- 3   rcu_read_lock();
- 4   WRITE_ONCE(a, 1);
- 5   WRITE_ONCE(b, 1);
- 6   rcu_read_unlock();
- 7 }
- 8
- 9 void thread1(void)
-10 {
-11   r1 = READ_ONCE(a);
-12   synchronize_rcu();
-13   WRITE_ONCE(c, 1);
-14 }
-15
-16 void thread2(void)
-17 {
-18   rcu_read_lock();
-19   WRITE_ONCE(d, 1);
-20   r2 = READ_ONCE(c);
-21   rcu_read_unlock();
-22 }
-23
-24 void thread3(void)
-25 {
-26   r3 = READ_ONCE(d);
-27   synchronize_rcu();
-28   WRITE_ONCE(e, 1);
-29 }
-30
-31 void thread4(void)
-32 {
-33   rcu_read_lock();
-34   r4 = READ_ONCE(b);
-35   r5 = READ_ONCE(e);
-36   rcu_read_unlock();
-37 }
-</pre>
-</blockquote>
-
-<p>
-In this case, the outcome:
-
-<blockquote>
-<pre>
-(r1 == 1 &amp;&amp; r2 == 1 &amp;&amp; r3 == 1 &amp;&amp; r4 == 0 &amp&amp; r5 == 1)
-</pre>
-</blockquote>
-
-is entirely possible, as illustrated below:
-
-<p><img src="ReadersPartitionGP1.svg" alt="ReadersPartitionGP1.svg" width="100%"></p>
-
-<p>
-Again, an RCU read-side critical section can overlap almost all of a
-given grace period, just so long as it does not overlap the entire
-grace period.
-As a result, an RCU read-side critical section cannot partition a pair
-of RCU grace periods.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	How long a sequence of grace periods, each separated by an RCU
-	read-side critical section, would be required to partition the RCU
-	read-side critical sections at the beginning and end of the chain?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	In theory, an infinite number.
-	In practice, an unknown number that is sensitive to both implementation
-	details and timing considerations.
-	Therefore, even in practice, RCU users must abide by the
-	theoretical rather than the practical answer.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<h2><a name="Parallelism Facts of Life">Parallelism Facts of Life</a></h2>
-
-<p>
-These parallelism facts of life are by no means specific to RCU, but
-the RCU implementation must abide by them.
-They therefore bear repeating:
-
-<ol>
-<li>	Any CPU or task may be delayed at any time,
-	and any attempts to avoid these delays by disabling
-	preemption, interrupts, or whatever are completely futile.
-	This is most obvious in preemptible user-level
-	environments and in virtualized environments (where
-	a given guest OS's VCPUs can be preempted at any time by
-	the underlying hypervisor), but can also happen in bare-metal
-	environments due to ECC errors, NMIs, and other hardware
-	events.
-	Although a delay of more than about 20 seconds can result
-	in splats, the RCU implementation is obligated to use
-	algorithms that can tolerate extremely long delays, but where
-	&ldquo;extremely long&rdquo; is not long enough to allow
-	wrap-around when incrementing a 64-bit counter.
-<li>	Both the compiler and the CPU can reorder memory accesses.
-	Where it matters, RCU must use compiler directives and
-	memory-barrier instructions to preserve ordering.
-<li>	Conflicting writes to memory locations in any given cache line
-	will result in expensive cache misses.
-	Greater numbers of concurrent writes and more-frequent
-	concurrent writes will result in more dramatic slowdowns.
-	RCU is therefore obligated to use algorithms that have
-	sufficient locality to avoid significant performance and
-	scalability problems.
-<li>	As a rough rule of thumb, only one CPU's worth of processing
-	may be carried out under the protection of any given exclusive
-	lock.
-	RCU must therefore use scalable locking designs.
-<li>	Counters are finite, especially on 32-bit systems.
-	RCU's use of counters must therefore tolerate counter wrap,
-	or be designed such that counter wrap would take way more
-	time than a single system is likely to run.
-	An uptime of ten years is quite possible, a runtime
-	of a century much less so.
-	As an example of the latter, RCU's dyntick-idle nesting counter
-	allows 54 bits for interrupt nesting level (this counter
-	is 64 bits even on a 32-bit system).
-	Overflowing this counter requires 2<sup>54</sup>
-	half-interrupts on a given CPU without that CPU ever going idle.
-	If a half-interrupt happened every microsecond, it would take
-	570 years of runtime to overflow this counter, which is currently
-	believed to be an acceptably long time.
-<li>	Linux systems can have thousands of CPUs running a single
-	Linux kernel in a single shared-memory environment.
-	RCU must therefore pay close attention to high-end scalability.
-</ol>
-
-<p>
-This last parallelism fact of life means that RCU must pay special
-attention to the preceding facts of life.
-The idea that Linux might scale to systems with thousands of CPUs would
-have been met with some skepticism in the 1990s, but these requirements
-would have otherwise have been unsurprising, even in the early 1990s.
-
-<h2><a name="Quality-of-Implementation Requirements">Quality-of-Implementation Requirements</a></h2>
-
-<p>
-These sections list quality-of-implementation requirements.
-Although an RCU implementation that ignores these requirements could
-still be used, it would likely be subject to limitations that would
-make it inappropriate for industrial-strength production use.
-Classes of quality-of-implementation requirements are as follows:
-
-<ol>
-<li>	<a href="#Specialization">Specialization</a>
-<li>	<a href="#Performance and Scalability">Performance and Scalability</a>
-<li>	<a href="#Forward Progress">Forward Progress</a>
-<li>	<a href="#Composability">Composability</a>
-<li>	<a href="#Corner Cases">Corner Cases</a>
-</ol>
-
-<p>
-These classes is covered in the following sections.
-
-<h3><a name="Specialization">Specialization</a></h3>
-
-<p>
-RCU is and always has been intended primarily for read-mostly situations,
-which means that RCU's read-side primitives are optimized, often at the
-expense of its update-side primitives.
-Experience thus far is captured by the following list of situations:
-
-<ol>
-<li>	Read-mostly data, where stale and inconsistent data is not
-	a problem:   RCU works great!
-<li>	Read-mostly data, where data must be consistent:
-	RCU works well.
-<li>	Read-write data, where data must be consistent:
-	RCU <i>might</i> work OK.
-	Or not.
-<li>	Write-mostly data, where data must be consistent:
-	RCU is very unlikely to be the right tool for the job,
-	with the following exceptions, where RCU can provide:
-	<ol type=a>
-	<li>	Existence guarantees for update-friendly mechanisms.
-	<li>	Wait-free read-side primitives for real-time use.
-	</ol>
-</ol>
-
-<p>
-This focus on read-mostly situations means that RCU must interoperate
-with other synchronization primitives.
-For example, the <tt>add_gp()</tt> and <tt>remove_gp_synchronous()</tt>
-examples discussed earlier use RCU to protect readers and locking to
-coordinate updaters.
-However, the need extends much farther, requiring that a variety of
-synchronization primitives be legal within RCU read-side critical sections,
-including spinlocks, sequence locks, atomic operations, reference
-counters, and memory barriers.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	What about sleeping locks?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	These are forbidden within Linux-kernel RCU read-side critical
-	sections because it is not legal to place a quiescent state
-	(in this case, voluntary context switch) within an RCU read-side
-	critical section.
-	However, sleeping locks may be used within userspace RCU read-side
-	critical sections, and also within Linux-kernel sleepable RCU
-	<a href="#Sleepable RCU"><font color="ffffff">(SRCU)</font></a>
-	read-side critical sections.
-	In addition, the -rt patchset turns spinlocks into a
-	sleeping locks so that the corresponding critical sections
-	can be preempted, which also means that these sleeplockified
-	spinlocks (but not other sleeping locks!)  may be acquire within
-	-rt-Linux-kernel RCU read-side critical sections.
-	</font>
-
-	<p><font color="ffffff">
-	Note that it <i>is</i> legal for a normal RCU read-side
-	critical section to conditionally acquire a sleeping locks
-	(as in <tt>mutex_trylock()</tt>), but only as long as it does
-	not loop indefinitely attempting to conditionally acquire that
-	sleeping locks.
-	The key point is that things like <tt>mutex_trylock()</tt>
-	either return with the mutex held, or return an error indication if
-	the mutex was not immediately available.
-	Either way, <tt>mutex_trylock()</tt> returns immediately without
-	sleeping.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>
-It often comes as a surprise that many algorithms do not require a
-consistent view of data, but many can function in that mode,
-with network routing being the poster child.
-Internet routing algorithms take significant time to propagate
-updates, so that by the time an update arrives at a given system,
-that system has been sending network traffic the wrong way for
-a considerable length of time.
-Having a few threads continue to send traffic the wrong way for a
-few more milliseconds is clearly not a problem:  In the worst case,
-TCP retransmissions will eventually get the data where it needs to go.
-In general, when tracking the state of the universe outside of the
-computer, some level of inconsistency must be tolerated due to
-speed-of-light delays if nothing else.
-
-<p>
-Furthermore, uncertainty about external state is inherent in many cases.
-For example, a pair of veterinarians might use heartbeat to determine
-whether or not a given cat was alive.
-But how long should they wait after the last heartbeat to decide that
-the cat is in fact dead?
-Waiting less than 400 milliseconds makes no sense because this would
-mean that a relaxed cat would be considered to cycle between death
-and life more than 100 times per minute.
-Moreover, just as with human beings, a cat's heart might stop for
-some period of time, so the exact wait period is a judgment call.
-One of our pair of veterinarians might wait 30 seconds before pronouncing
-the cat dead, while the other might insist on waiting a full minute.
-The two veterinarians would then disagree on the state of the cat during
-the final 30 seconds of the minute following the last heartbeat.
-
-<p>
-Interestingly enough, this same situation applies to hardware.
-When push comes to shove, how do we tell whether or not some
-external server has failed?
-We send messages to it periodically, and declare it failed if we
-don't receive a response within a given period of time.
-Policy decisions can usually tolerate short
-periods of inconsistency.
-The policy was decided some time ago, and is only now being put into
-effect, so a few milliseconds of delay is normally inconsequential.
-
-<p>
-However, there are algorithms that absolutely must see consistent data.
-For example, the translation between a user-level SystemV semaphore
-ID to the corresponding in-kernel data structure is protected by RCU,
-but it is absolutely forbidden to update a semaphore that has just been
-removed.
-In the Linux kernel, this need for consistency is accommodated by acquiring
-spinlocks located in the in-kernel data structure from within
-the RCU read-side critical section, and this is indicated by the
-green box in the figure above.
-Many other techniques may be used, and are in fact used within the
-Linux kernel.
-
-<p>
-In short, RCU is not required to maintain consistency, and other
-mechanisms may be used in concert with RCU when consistency is required.
-RCU's specialization allows it to do its job extremely well, and its
-ability to interoperate with other synchronization mechanisms allows
-the right mix of synchronization tools to be used for a given job.
-
-<h3><a name="Performance and Scalability">Performance and Scalability</a></h3>
-
-<p>
-Energy efficiency is a critical component of performance today,
-and Linux-kernel RCU implementations must therefore avoid unnecessarily
-awakening idle CPUs.
-I cannot claim that this requirement was premeditated.
-In fact, I learned of it during a telephone conversation in which I
-was given &ldquo;frank and open&rdquo; feedback on the importance
-of energy efficiency in battery-powered systems and on specific
-energy-efficiency shortcomings of the Linux-kernel RCU implementation.
-In my experience, the battery-powered embedded community will consider
-any unnecessary wakeups to be extremely unfriendly acts.
-So much so that mere Linux-kernel-mailing-list posts are
-insufficient to vent their ire.
-
-<p>
-Memory consumption is not particularly important for in most
-situations, and has become decreasingly
-so as memory sizes have expanded and memory
-costs have plummeted.
-However, as I learned from Matt Mackall's
-<a href="http://elinux.org/Linux_Tiny-FAQ">bloatwatch</a>
-efforts, memory footprint is critically important on single-CPU systems with
-non-preemptible (<tt>CONFIG_PREEMPT=n</tt>) kernels, and thus
-<a href="https://lkml.kernel.org/g/20090113221724.GA15307@linux.vnet.ibm.com">tiny RCU</a>
-was born.
-Josh Triplett has since taken over the small-memory banner with his
-<a href="https://tiny.wiki.kernel.org/">Linux kernel tinification</a>
-project, which resulted in
-<a href="#Sleepable RCU">SRCU</a>
-becoming optional for those kernels not needing it.
-
-<p>
-The remaining performance requirements are, for the most part,
-unsurprising.
-For example, in keeping with RCU's read-side specialization,
-<tt>rcu_dereference()</tt> should have negligible overhead (for
-example, suppression of a few minor compiler optimizations).
-Similarly, in non-preemptible environments, <tt>rcu_read_lock()</tt> and
-<tt>rcu_read_unlock()</tt> should have exactly zero overhead.
-
-<p>
-In preemptible environments, in the case where the RCU read-side
-critical section was not preempted (as will be the case for the
-highest-priority real-time process), <tt>rcu_read_lock()</tt> and
-<tt>rcu_read_unlock()</tt> should have minimal overhead.
-In particular, they should not contain atomic read-modify-write
-operations, memory-barrier instructions, preemption disabling,
-interrupt disabling, or backwards branches.
-However, in the case where the RCU read-side critical section was preempted,
-<tt>rcu_read_unlock()</tt> may acquire spinlocks and disable interrupts.
-This is why it is better to nest an RCU read-side critical section
-within a preempt-disable region than vice versa, at least in cases
-where that critical section is short enough to avoid unduly degrading
-real-time latencies.
-
-<p>
-The <tt>synchronize_rcu()</tt> grace-period-wait primitive is
-optimized for throughput.
-It may therefore incur several milliseconds of latency in addition to
-the duration of the longest RCU read-side critical section.
-On the other hand, multiple concurrent invocations of
-<tt>synchronize_rcu()</tt> are required to use batching optimizations
-so that they can be satisfied by a single underlying grace-period-wait
-operation.
-For example, in the Linux kernel, it is not unusual for a single
-grace-period-wait operation to serve more than
-<a href="https://www.usenix.org/conference/2004-usenix-annual-technical-conference/making-rcu-safe-deep-sub-millisecond-response">1,000 separate invocations</a>
-of <tt>synchronize_rcu()</tt>, thus amortizing the per-invocation
-overhead down to nearly zero.
-However, the grace-period optimization is also required to avoid
-measurable degradation of real-time scheduling and interrupt latencies.
-
-<p>
-In some cases, the multi-millisecond <tt>synchronize_rcu()</tt>
-latencies are unacceptable.
-In these cases, <tt>synchronize_rcu_expedited()</tt> may be used
-instead, reducing the grace-period latency down to a few tens of
-microseconds on small systems, at least in cases where the RCU read-side
-critical sections are short.
-There are currently no special latency requirements for
-<tt>synchronize_rcu_expedited()</tt> on large systems, but,
-consistent with the empirical nature of the RCU specification,
-that is subject to change.
-However, there most definitely are scalability requirements:
-A storm of <tt>synchronize_rcu_expedited()</tt> invocations on 4096
-CPUs should at least make reasonable forward progress.
-In return for its shorter latencies, <tt>synchronize_rcu_expedited()</tt>
-is permitted to impose modest degradation of real-time latency
-on non-idle online CPUs.
-Here, &ldquo;modest&rdquo; means roughly the same latency
-degradation as a scheduling-clock interrupt.
-
-<p>
-There are a number of situations where even
-<tt>synchronize_rcu_expedited()</tt>'s reduced grace-period
-latency is unacceptable.
-In these situations, the asynchronous <tt>call_rcu()</tt> can be
-used in place of <tt>synchronize_rcu()</tt> as follows:
-
-<blockquote>
-<pre>
- 1 struct foo {
- 2   int a;
- 3   int b;
- 4   struct rcu_head rh;
- 5 };
- 6
- 7 static void remove_gp_cb(struct rcu_head *rhp)
- 8 {
- 9   struct foo *p = container_of(rhp, struct foo, rh);
-10
-11   kfree(p);
-12 }
-13
-14 bool remove_gp_asynchronous(void)
-15 {
-16   struct foo *p;
-17
-18   spin_lock(&amp;gp_lock);
-19   p = rcu_access_pointer(gp);
-20   if (!p) {
-21     spin_unlock(&amp;gp_lock);
-22     return false;
-23   }
-24   rcu_assign_pointer(gp, NULL);
-25   call_rcu(&amp;p-&gt;rh, remove_gp_cb);
-26   spin_unlock(&amp;gp_lock);
-27   return true;
-28 }
-</pre>
-</blockquote>
-
-<p>
-A definition of <tt>struct foo</tt> is finally needed, and appears
-on lines&nbsp;1-5.
-The function <tt>remove_gp_cb()</tt> is passed to <tt>call_rcu()</tt>
-on line&nbsp;25, and will be invoked after the end of a subsequent
-grace period.
-This gets the same effect as <tt>remove_gp_synchronous()</tt>,
-but without forcing the updater to wait for a grace period to elapse.
-The <tt>call_rcu()</tt> function may be used in a number of
-situations where neither <tt>synchronize_rcu()</tt> nor
-<tt>synchronize_rcu_expedited()</tt> would be legal,
-including within preempt-disable code, <tt>local_bh_disable()</tt> code,
-interrupt-disable code, and interrupt handlers.
-However, even <tt>call_rcu()</tt> is illegal within NMI handlers
-and from idle and offline CPUs.
-The callback function (<tt>remove_gp_cb()</tt> in this case) will be
-executed within softirq (software interrupt) environment within the
-Linux kernel,
-either within a real softirq handler or under the protection
-of <tt>local_bh_disable()</tt>.
-In both the Linux kernel and in userspace, it is bad practice to
-write an RCU callback function that takes too long.
-Long-running operations should be relegated to separate threads or
-(in the Linux kernel) workqueues.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Why does line&nbsp;19 use <tt>rcu_access_pointer()</tt>?
-	After all, <tt>call_rcu()</tt> on line&nbsp;25 stores into the
-	structure, which would interact badly with concurrent insertions.
-	Doesn't this mean that <tt>rcu_dereference()</tt> is required?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	Presumably the <tt>-&gt;gp_lock</tt> acquired on line&nbsp;18 excludes
-	any changes, including any insertions that <tt>rcu_dereference()</tt>
-	would protect against.
-	Therefore, any insertions will be delayed until after
-	<tt>-&gt;gp_lock</tt>
-	is released on line&nbsp;25, which in turn means that
-	<tt>rcu_access_pointer()</tt> suffices.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>
-However, all that <tt>remove_gp_cb()</tt> is doing is
-invoking <tt>kfree()</tt> on the data element.
-This is a common idiom, and is supported by <tt>kfree_rcu()</tt>,
-which allows &ldquo;fire and forget&rdquo; operation as shown below:
-
-<blockquote>
-<pre>
- 1 struct foo {
- 2   int a;
- 3   int b;
- 4   struct rcu_head rh;
- 5 };
- 6
- 7 bool remove_gp_faf(void)
- 8 {
- 9   struct foo *p;
-10
-11   spin_lock(&amp;gp_lock);
-12   p = rcu_dereference(gp);
-13   if (!p) {
-14     spin_unlock(&amp;gp_lock);
-15     return false;
-16   }
-17   rcu_assign_pointer(gp, NULL);
-18   kfree_rcu(p, rh);
-19   spin_unlock(&amp;gp_lock);
-20   return true;
-21 }
-</pre>
-</blockquote>
-
-<p>
-Note that <tt>remove_gp_faf()</tt> simply invokes
-<tt>kfree_rcu()</tt> and proceeds, without any need to pay any
-further attention to the subsequent grace period and <tt>kfree()</tt>.
-It is permissible to invoke <tt>kfree_rcu()</tt> from the same
-environments as for <tt>call_rcu()</tt>.
-Interestingly enough, DYNIX/ptx had the equivalents of
-<tt>call_rcu()</tt> and <tt>kfree_rcu()</tt>, but not
-<tt>synchronize_rcu()</tt>.
-This was due to the fact that RCU was not heavily used within DYNIX/ptx,
-so the very few places that needed something like
-<tt>synchronize_rcu()</tt> simply open-coded it.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Earlier it was claimed that <tt>call_rcu()</tt> and
-	<tt>kfree_rcu()</tt> allowed updaters to avoid being blocked
-	by readers.
-	But how can that be correct, given that the invocation of the callback
-	and the freeing of the memory (respectively) must still wait for
-	a grace period to elapse?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	We could define things this way, but keep in mind that this sort of
-	definition would say that updates in garbage-collected languages
-	cannot complete until the next time the garbage collector runs,
-	which does not seem at all reasonable.
-	The key point is that in most cases, an updater using either
-	<tt>call_rcu()</tt> or <tt>kfree_rcu()</tt> can proceed to the
-	next update as soon as it has invoked <tt>call_rcu()</tt> or
-	<tt>kfree_rcu()</tt>, without having to wait for a subsequent
-	grace period.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>
-But what if the updater must wait for the completion of code to be
-executed after the end of the grace period, but has other tasks
-that can be carried out in the meantime?
-The polling-style <tt>get_state_synchronize_rcu()</tt> and
-<tt>cond_synchronize_rcu()</tt> functions may be used for this
-purpose, as shown below:
-
-<blockquote>
-<pre>
- 1 bool remove_gp_poll(void)
- 2 {
- 3   struct foo *p;
- 4   unsigned long s;
- 5
- 6   spin_lock(&amp;gp_lock);
- 7   p = rcu_access_pointer(gp);
- 8   if (!p) {
- 9     spin_unlock(&amp;gp_lock);
-10     return false;
-11   }
-12   rcu_assign_pointer(gp, NULL);
-13   spin_unlock(&amp;gp_lock);
-14   s = get_state_synchronize_rcu();
-15   do_something_while_waiting();
-16   cond_synchronize_rcu(s);
-17   kfree(p);
-18   return true;
-19 }
-</pre>
-</blockquote>
-
-<p>
-On line&nbsp;14, <tt>get_state_synchronize_rcu()</tt> obtains a
-&ldquo;cookie&rdquo; from RCU,
-then line&nbsp;15 carries out other tasks,
-and finally, line&nbsp;16 returns immediately if a grace period has
-elapsed in the meantime, but otherwise waits as required.
-The need for <tt>get_state_synchronize_rcu</tt> and
-<tt>cond_synchronize_rcu()</tt> has appeared quite recently,
-so it is too early to tell whether they will stand the test of time.
-
-<p>
-RCU thus provides a range of tools to allow updaters to strike the
-required tradeoff between latency, flexibility and CPU overhead.
-
-<h3><a name="Forward Progress">Forward Progress</a></h3>
-
-<p>
-In theory, delaying grace-period completion and callback invocation
-is harmless.
-In practice, not only are memory sizes finite but also callbacks sometimes
-do wakeups, and sufficiently deferred wakeups can be difficult
-to distinguish from system hangs.
-Therefore, RCU must provide a number of mechanisms to promote forward
-progress.
-
-<p>
-These mechanisms are not foolproof, nor can they be.
-For one simple example, an infinite loop in an RCU read-side critical
-section must by definition prevent later grace periods from ever completing.
-For a more involved example, consider a 64-CPU system built with
-<tt>CONFIG_RCU_NOCB_CPU=y</tt> and booted with <tt>rcu_nocbs=1-63</tt>,
-where CPUs&nbsp;1 through&nbsp;63 spin in tight loops that invoke
-<tt>call_rcu()</tt>.
-Even if these tight loops also contain calls to <tt>cond_resched()</tt>
-(thus allowing grace periods to complete), CPU&nbsp;0 simply will
-not be able to invoke callbacks as fast as the other 63 CPUs can
-register them, at least not until the system runs out of memory.
-In both of these examples, the Spiderman principle applies:  With great
-power comes great responsibility.
-However, short of this level of abuse, RCU is required to
-ensure timely completion of grace periods and timely invocation of
-callbacks.
-
-<p>
-RCU takes the following steps to encourage timely completion of
-grace periods:
-
-<ol>
-<li>	If a grace period fails to complete within 100&nbsp;milliseconds,
-	RCU causes future invocations of <tt>cond_resched()</tt> on
-	the holdout CPUs to provide an RCU quiescent state.
-	RCU also causes those CPUs' <tt>need_resched()</tt> invocations
-	to return <tt>true</tt>, but only after the corresponding CPU's
-	next scheduling-clock.
-<li>	CPUs mentioned in the <tt>nohz_full</tt> kernel boot parameter
-	can run indefinitely in the kernel without scheduling-clock
-	interrupts, which defeats the above <tt>need_resched()</tt>
-	strategem.
-	RCU will therefore invoke <tt>resched_cpu()</tt> on any
-	<tt>nohz_full</tt> CPUs still holding out after
-	109&nbsp;milliseconds.
-<li>	In kernels built with <tt>CONFIG_RCU_BOOST=y</tt>, if a given
-	task that has been preempted within an RCU read-side critical
-	section is holding out for more than 500&nbsp;milliseconds,
-	RCU will resort to priority boosting.
-<li>	If a CPU is still holding out 10&nbsp;seconds into the grace
-	period, RCU will invoke <tt>resched_cpu()</tt> on it regardless
-	of its <tt>nohz_full</tt> state.
-</ol>
-
-<p>
-The above values are defaults for systems running with <tt>HZ=1000</tt>.
-They will vary as the value of <tt>HZ</tt> varies, and can also be
-changed using the relevant Kconfig options and kernel boot parameters.
-RCU currently does not do much sanity checking of these
-parameters, so please use caution when changing them.
-Note that these forward-progress measures are provided only for RCU,
-not for
-<a href="#Sleepable RCU">SRCU</a> or
-<a href="#Tasks RCU">Tasks RCU</a>.
-
-<p>
-RCU takes the following steps in <tt>call_rcu()</tt> to encourage timely
-invocation of callbacks when any given non-<tt>rcu_nocbs</tt> CPU has
-10,000 callbacks, or has 10,000 more callbacks than it had the last time
-encouragement was provided:
-
-<ol>
-<li>	Starts a grace period, if one is not already in progress.
-<li>	Forces immediate checking for quiescent states, rather than
-	waiting for three milliseconds to have elapsed since the
-	beginning of the grace period.
-<li>	Immediately tags the CPU's callbacks with their grace period
-	completion numbers, rather than waiting for the <tt>RCU_SOFTIRQ</tt>
-	handler to get around to it.
-<li>	Lifts callback-execution batch limits, which speeds up callback
-	invocation at the expense of degrading realtime response.
-</ol>
-
-<p>
-Again, these are default values when running at <tt>HZ=1000</tt>,
-and can be overridden.
-Again, these forward-progress measures are provided only for RCU,
-not for
-<a href="#Sleepable RCU">SRCU</a> or
-<a href="#Tasks RCU">Tasks RCU</a>.
-Even for RCU, callback-invocation forward progress for <tt>rcu_nocbs</tt>
-CPUs is much less well-developed, in part because workloads benefiting
-from <tt>rcu_nocbs</tt> CPUs tend to invoke <tt>call_rcu()</tt>
-relatively infrequently.
-If workloads emerge that need both <tt>rcu_nocbs</tt> CPUs and high
-<tt>call_rcu()</tt> invocation rates, then additional forward-progress
-work will be required.
-
-<h3><a name="Composability">Composability</a></h3>
-
-<p>
-Composability has received much attention in recent years, perhaps in part
-due to the collision of multicore hardware with object-oriented techniques
-designed in single-threaded environments for single-threaded use.
-And in theory, RCU read-side critical sections may be composed, and in
-fact may be nested arbitrarily deeply.
-In practice, as with all real-world implementations of composable
-constructs, there are limitations.
-
-<p>
-Implementations of RCU for which <tt>rcu_read_lock()</tt>
-and <tt>rcu_read_unlock()</tt> generate no code, such as
-Linux-kernel RCU when <tt>CONFIG_PREEMPT=n</tt>, can be
-nested arbitrarily deeply.
-After all, there is no overhead.
-Except that if all these instances of <tt>rcu_read_lock()</tt>
-and <tt>rcu_read_unlock()</tt> are visible to the compiler,
-compilation will eventually fail due to exhausting memory,
-mass storage, or user patience, whichever comes first.
-If the nesting is not visible to the compiler, as is the case with
-mutually recursive functions each in its own translation unit,
-stack overflow will result.
-If the nesting takes the form of loops, perhaps in the guise of tail
-recursion, either the control variable
-will overflow or (in the Linux kernel) you will get an RCU CPU stall warning.
-Nevertheless, this class of RCU implementations is one
-of the most composable constructs in existence.
-
-<p>
-RCU implementations that explicitly track nesting depth
-are limited by the nesting-depth counter.
-For example, the Linux kernel's preemptible RCU limits nesting to
-<tt>INT_MAX</tt>.
-This should suffice for almost all practical purposes.
-That said, a consecutive pair of RCU read-side critical sections
-between which there is an operation that waits for a grace period
-cannot be enclosed in another RCU read-side critical section.
-This is because it is not legal to wait for a grace period within
-an RCU read-side critical section:  To do so would result either
-in deadlock or
-in RCU implicitly splitting the enclosing RCU read-side critical
-section, neither of which is conducive to a long-lived and prosperous
-kernel.
-
-<p>
-It is worth noting that RCU is not alone in limiting composability.
-For example, many transactional-memory implementations prohibit
-composing a pair of transactions separated by an irrevocable
-operation (for example, a network receive operation).
-For another example, lock-based critical sections can be composed
-surprisingly freely, but only if deadlock is avoided.
-
-<p>
-In short, although RCU read-side critical sections are highly composable,
-care is required in some situations, just as is the case for any other
-composable synchronization mechanism.
-
-<h3><a name="Corner Cases">Corner Cases</a></h3>
-
-<p>
-A given RCU workload might have an endless and intense stream of
-RCU read-side critical sections, perhaps even so intense that there
-was never a point in time during which there was not at least one
-RCU read-side critical section in flight.
-RCU cannot allow this situation to block grace periods:  As long as
-all the RCU read-side critical sections are finite, grace periods
-must also be finite.
-
-<p>
-That said, preemptible RCU implementations could potentially result
-in RCU read-side critical sections being preempted for long durations,
-which has the effect of creating a long-duration RCU read-side
-critical section.
-This situation can arise only in heavily loaded systems, but systems using
-real-time priorities are of course more vulnerable.
-Therefore, RCU priority boosting is provided to help deal with this
-case.
-That said, the exact requirements on RCU priority boosting will likely
-evolve as more experience accumulates.
-
-<p>
-Other workloads might have very high update rates.
-Although one can argue that such workloads should instead use
-something other than RCU, the fact remains that RCU must
-handle such workloads gracefully.
-This requirement is another factor driving batching of grace periods,
-but it is also the driving force behind the checks for large numbers
-of queued RCU callbacks in the <tt>call_rcu()</tt> code path.
-Finally, high update rates should not delay RCU read-side critical
-sections, although some small read-side delays can occur when using
-<tt>synchronize_rcu_expedited()</tt>, courtesy of this function's use
-of <tt>smp_call_function_single()</tt>.
-
-<p>
-Although all three of these corner cases were understood in the early
-1990s, a simple user-level test consisting of <tt>close(open(path))</tt>
-in a tight loop
-in the early 2000s suddenly provided a much deeper appreciation of the
-high-update-rate corner case.
-This test also motivated addition of some RCU code to react to high update
-rates, for example, if a given CPU finds itself with more than 10,000
-RCU callbacks queued, it will cause RCU to take evasive action by
-more aggressively starting grace periods and more aggressively forcing
-completion of grace-period processing.
-This evasive action causes the grace period to complete more quickly,
-but at the cost of restricting RCU's batching optimizations, thus
-increasing the CPU overhead incurred by that grace period.
-
-<h2><a name="Software-Engineering Requirements">
-Software-Engineering Requirements</a></h2>
-
-<p>
-Between Murphy's Law and &ldquo;To err is human&rdquo;, it is necessary to
-guard against mishaps and misuse:
-
-<ol>
-<li>	It is all too easy to forget to use <tt>rcu_read_lock()</tt>
-	everywhere that it is needed, so kernels built with
-	<tt>CONFIG_PROVE_RCU=y</tt> will splat if
-	<tt>rcu_dereference()</tt> is used outside of an
-	RCU read-side critical section.
-	Update-side code can use <tt>rcu_dereference_protected()</tt>,
-	which takes a
-	<a href="https://lwn.net/Articles/371986/">lockdep expression</a>
-	to indicate what is providing the protection.
-	If the indicated protection is not provided, a lockdep splat
-	is emitted.
-
-	<p>
-	Code shared between readers and updaters can use
-	<tt>rcu_dereference_check()</tt>, which also takes a
-	lockdep expression, and emits a lockdep splat if neither
-	<tt>rcu_read_lock()</tt> nor the indicated protection
-	is in place.
-	In addition, <tt>rcu_dereference_raw()</tt> is used in those
-	(hopefully rare) cases where the required protection cannot
-	be easily described.
-	Finally, <tt>rcu_read_lock_held()</tt> is provided to
-	allow a function to verify that it has been invoked within
-	an RCU read-side critical section.
-	I was made aware of this set of requirements shortly after Thomas
-	Gleixner audited a number of RCU uses.
-<li>	A given function might wish to check for RCU-related preconditions
-	upon entry, before using any other RCU API.
-	The <tt>rcu_lockdep_assert()</tt> does this job,
-	asserting the expression in kernels having lockdep enabled
-	and doing nothing otherwise.
-<li>	It is also easy to forget to use <tt>rcu_assign_pointer()</tt>
-	and <tt>rcu_dereference()</tt>, perhaps (incorrectly)
-	substituting a simple assignment.
-	To catch this sort of error, a given RCU-protected pointer may be
-	tagged with <tt>__rcu</tt>, after which sparse
-	will complain about simple-assignment accesses to that pointer.
-	Arnd Bergmann made me aware of this requirement, and also
-	supplied the needed
-	<a href="https://lwn.net/Articles/376011/">patch series</a>.
-<li>	Kernels built with <tt>CONFIG_DEBUG_OBJECTS_RCU_HEAD=y</tt>
-	will splat if a data element is passed to <tt>call_rcu()</tt>
-	twice in a row, without a grace period in between.
-	(This error is similar to a double free.)
-	The corresponding <tt>rcu_head</tt> structures that are
-	dynamically allocated are automatically tracked, but
-	<tt>rcu_head</tt> structures allocated on the stack
-	must be initialized with <tt>init_rcu_head_on_stack()</tt>
-	and cleaned up with <tt>destroy_rcu_head_on_stack()</tt>.
-	Similarly, statically allocated non-stack <tt>rcu_head</tt>
-	structures must be initialized with <tt>init_rcu_head()</tt>
-	and cleaned up with <tt>destroy_rcu_head()</tt>.
-	Mathieu Desnoyers made me aware of this requirement, and also
-	supplied the needed
-	<a href="https://lkml.kernel.org/g/20100319013024.GA28456@Krystal">patch</a>.
-<li>	An infinite loop in an RCU read-side critical section will
-	eventually trigger an RCU CPU stall warning splat, with
-	the duration of &ldquo;eventually&rdquo; being controlled by the
-	<tt>RCU_CPU_STALL_TIMEOUT</tt> <tt>Kconfig</tt> option, or,
-	alternatively, by the
-	<tt>rcupdate.rcu_cpu_stall_timeout</tt> boot/sysfs
-	parameter.
-	However, RCU is not obligated to produce this splat
-	unless there is a grace period waiting on that particular
-	RCU read-side critical section.
-	<p>
-	Some extreme workloads might intentionally delay
-	RCU grace periods, and systems running those workloads can
-	be booted with <tt>rcupdate.rcu_cpu_stall_suppress</tt>
-	to suppress the splats.
-	This kernel parameter may also be set via <tt>sysfs</tt>.
-	Furthermore, RCU CPU stall warnings are counter-productive
-	during sysrq dumps and during panics.
-	RCU therefore supplies the <tt>rcu_sysrq_start()</tt> and
-	<tt>rcu_sysrq_end()</tt> API members to be called before
-	and after long sysrq dumps.
-	RCU also supplies the <tt>rcu_panic()</tt> notifier that is
-	automatically invoked at the beginning of a panic to suppress
-	further RCU CPU stall warnings.
-
-	<p>
-	This requirement made itself known in the early 1990s, pretty
-	much the first time that it was necessary to debug a CPU stall.
-	That said, the initial implementation in DYNIX/ptx was quite
-	generic in comparison with that of Linux.
-<li>	Although it would be very good to detect pointers leaking out
-	of RCU read-side critical sections, there is currently no
-	good way of doing this.
-	One complication is the need to distinguish between pointers
-	leaking and pointers that have been handed off from RCU to
-	some other synchronization mechanism, for example, reference
-	counting.
-<li>	In kernels built with <tt>CONFIG_RCU_TRACE=y</tt>, RCU-related
-	information is provided via event tracing.
-<li>	Open-coded use of <tt>rcu_assign_pointer()</tt> and
-	<tt>rcu_dereference()</tt> to create typical linked
-	data structures can be surprisingly error-prone.
-	Therefore, RCU-protected
-	<a href="https://lwn.net/Articles/609973/#RCU List APIs">linked lists</a>
-	and, more recently, RCU-protected
-	<a href="https://lwn.net/Articles/612100/">hash tables</a>
-	are available.
-	Many other special-purpose RCU-protected data structures are
-	available in the Linux kernel and the userspace RCU library.
-<li>	Some linked structures are created at compile time, but still
-	require <tt>__rcu</tt> checking.
-	The <tt>RCU_POINTER_INITIALIZER()</tt> macro serves this
-	purpose.
-<li>	It is not necessary to use <tt>rcu_assign_pointer()</tt>
-	when creating linked structures that are to be published via
-	a single external pointer.
-	The <tt>RCU_INIT_POINTER()</tt> macro is provided for
-	this task and also for assigning <tt>NULL</tt> pointers
-	at runtime.
-</ol>
-
-<p>
-This not a hard-and-fast list:  RCU's diagnostic capabilities will
-continue to be guided by the number and type of usage bugs found
-in real-world RCU usage.
-
-<h2><a name="Linux Kernel Complications">Linux Kernel Complications</a></h2>
-
-<p>
-The Linux kernel provides an interesting environment for all kinds of
-software, including RCU.
-Some of the relevant points of interest are as follows:
-
-<ol>
-<li>	<a href="#Configuration">Configuration</a>.
-<li>	<a href="#Firmware Interface">Firmware Interface</a>.
-<li>	<a href="#Early Boot">Early Boot</a>.
-<li>	<a href="#Interrupts and NMIs">
-	Interrupts and non-maskable interrupts (NMIs)</a>.
-<li>	<a href="#Loadable Modules">Loadable Modules</a>.
-<li>	<a href="#Hotplug CPU">Hotplug CPU</a>.
-<li>	<a href="#Scheduler and RCU">Scheduler and RCU</a>.
-<li>	<a href="#Tracing and RCU">Tracing and RCU</a>.
-<li>	<a href="#Energy Efficiency">Energy Efficiency</a>.
-<li>	<a href="#Scheduling-Clock Interrupts and RCU">
-	Scheduling-Clock Interrupts and RCU</a>.
-<li>	<a href="#Memory Efficiency">Memory Efficiency</a>.
-<li>	<a href="#Performance, Scalability, Response Time, and Reliability">
-	Performance, Scalability, Response Time, and Reliability</a>.
-</ol>
-
-<p>
-This list is probably incomplete, but it does give a feel for the
-most notable Linux-kernel complications.
-Each of the following sections covers one of the above topics.
-
-<h3><a name="Configuration">Configuration</a></h3>
-
-<p>
-RCU's goal is automatic configuration, so that almost nobody
-needs to worry about RCU's <tt>Kconfig</tt> options.
-And for almost all users, RCU does in fact work well
-&ldquo;out of the box.&rdquo;
-
-<p>
-However, there are specialized use cases that are handled by
-kernel boot parameters and <tt>Kconfig</tt> options.
-Unfortunately, the <tt>Kconfig</tt> system will explicitly ask users
-about new <tt>Kconfig</tt> options, which requires almost all of them
-be hidden behind a <tt>CONFIG_RCU_EXPERT</tt> <tt>Kconfig</tt> option.
-
-<p>
-This all should be quite obvious, but the fact remains that
-Linus Torvalds recently had to
-<a href="https://lkml.kernel.org/g/CA+55aFy4wcCwaL4okTs8wXhGZ5h-ibecy_Meg9C4MNQrUnwMcg@mail.gmail.com">remind</a>
-me of this requirement.
-
-<h3><a name="Firmware Interface">Firmware Interface</a></h3>
-
-<p>
-In many cases, kernel obtains information about the system from the
-firmware, and sometimes things are lost in translation.
-Or the translation is accurate, but the original message is bogus.
-
-<p>
-For example, some systems' firmware overreports the number of CPUs,
-sometimes by a large factor.
-If RCU naively believed the firmware, as it used to do,
-it would create too many per-CPU kthreads.
-Although the resulting system will still run correctly, the extra
-kthreads needlessly consume memory and can cause confusion
-when they show up in <tt>ps</tt> listings.
-
-<p>
-RCU must therefore wait for a given CPU to actually come online before
-it can allow itself to believe that the CPU actually exists.
-The resulting &ldquo;ghost CPUs&rdquo; (which are never going to
-come online) cause a number of
-<a href="https://paulmck.livejournal.com/37494.html">interesting complications</a>.
-
-<h3><a name="Early Boot">Early Boot</a></h3>
-
-<p>
-The Linux kernel's boot sequence is an interesting process,
-and RCU is used early, even before <tt>rcu_init()</tt>
-is invoked.
-In fact, a number of RCU's primitives can be used as soon as the
-initial task's <tt>task_struct</tt> is available and the
-boot CPU's per-CPU variables are set up.
-The read-side primitives (<tt>rcu_read_lock()</tt>,
-<tt>rcu_read_unlock()</tt>, <tt>rcu_dereference()</tt>,
-and <tt>rcu_access_pointer()</tt>) will operate normally very early on,
-as will <tt>rcu_assign_pointer()</tt>.
-
-<p>
-Although <tt>call_rcu()</tt> may be invoked at any
-time during boot, callbacks are not guaranteed to be invoked until after
-all of RCU's kthreads have been spawned, which occurs at
-<tt>early_initcall()</tt> time.
-This delay in callback invocation is due to the fact that RCU does not
-invoke callbacks until it is fully initialized, and this full initialization
-cannot occur until after the scheduler has initialized itself to the
-point where RCU can spawn and run its kthreads.
-In theory, it would be possible to invoke callbacks earlier,
-however, this is not a panacea because there would be severe restrictions
-on what operations those callbacks could invoke.
-
-<p>
-Perhaps surprisingly, <tt>synchronize_rcu()</tt> and
-<tt>synchronize_rcu_expedited()</tt>,
-will operate normally
-during very early boot, the reason being that there is only one CPU
-and preemption is disabled.
-This means that the call <tt>synchronize_rcu()</tt> (or friends)
-itself is a quiescent
-state and thus a grace period, so the early-boot implementation can
-be a no-op.
-
-<p>
-However, once the scheduler has spawned its first kthread, this early
-boot trick fails for <tt>synchronize_rcu()</tt> (as well as for
-<tt>synchronize_rcu_expedited()</tt>) in <tt>CONFIG_PREEMPT=y</tt>
-kernels.
-The reason is that an RCU read-side critical section might be preempted,
-which means that a subsequent <tt>synchronize_rcu()</tt> really does have
-to wait for something, as opposed to simply returning immediately.
-Unfortunately, <tt>synchronize_rcu()</tt> can't do this until all of
-its kthreads are spawned, which doesn't happen until some time during
-<tt>early_initcalls()</tt> time.
-But this is no excuse:  RCU is nevertheless required to correctly handle
-synchronous grace periods during this time period.
-Once all of its kthreads are up and running, RCU starts running
-normally.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	How can RCU possibly handle grace periods before all of its
-	kthreads have been spawned???
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	Very carefully!
-	</font>
-
-	<p><font color="ffffff">
-	During the &ldquo;dead zone&rdquo; between the time that the
-	scheduler spawns the first task and the time that all of RCU's
-	kthreads have been spawned, all synchronous grace periods are
-	handled by the expedited grace-period mechanism.
-	At runtime, this expedited mechanism relies on workqueues, but
-	during the dead zone the requesting task itself drives the
-	desired expedited grace period.
-	Because dead-zone execution takes place within task context,
-	everything works.
-	Once the dead zone ends, expedited grace periods go back to
-	using workqueues, as is required to avoid problems that would
-	otherwise occur when a user task received a POSIX signal while
-	driving an expedited grace period.
-	</font>
-
-	<p><font color="ffffff">
-	And yes, this does mean that it is unhelpful to send POSIX
-	signals to random tasks between the time that the scheduler
-	spawns its first kthread and the time that RCU's kthreads
-	have all been spawned.
-	If there ever turns out to be a good reason for sending POSIX
-	signals during that time, appropriate adjustments will be made.
-	(If it turns out that POSIX signals are sent during this time for
-	no good reason, other adjustments will be made, appropriate
-	or otherwise.)
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>
-I learned of these boot-time requirements as a result of a series of
-system hangs.
-
-<h3><a name="Interrupts and NMIs">Interrupts and NMIs</a></h3>
-
-<p>
-The Linux kernel has interrupts, and RCU read-side critical sections are
-legal within interrupt handlers and within interrupt-disabled regions
-of code, as are invocations of <tt>call_rcu()</tt>.
-
-<p>
-Some Linux-kernel architectures can enter an interrupt handler from
-non-idle process context, and then just never leave it, instead stealthily
-transitioning back to process context.
-This trick is sometimes used to invoke system calls from inside the kernel.
-These &ldquo;half-interrupts&rdquo; mean that RCU has to be very careful
-about how it counts interrupt nesting levels.
-I learned of this requirement the hard way during a rewrite
-of RCU's dyntick-idle code.
-
-<p>
-The Linux kernel has non-maskable interrupts (NMIs), and
-RCU read-side critical sections are legal within NMI handlers.
-Thankfully, RCU update-side primitives, including
-<tt>call_rcu()</tt>, are prohibited within NMI handlers.
-
-<p>
-The name notwithstanding, some Linux-kernel architectures
-can have nested NMIs, which RCU must handle correctly.
-Andy Lutomirski
-<a href="https://lkml.kernel.org/r/CALCETrXLq1y7e_dKFPgou-FKHB6Pu-r8+t-6Ds+8=va7anBWDA@mail.gmail.com">surprised me</a>
-with this requirement;
-he also kindly surprised me with
-<a href="https://lkml.kernel.org/r/CALCETrXSY9JpW3uE6H8WYk81sg56qasA2aqmjMPsq5dOtzso=g@mail.gmail.com">an algorithm</a>
-that meets this requirement.
-
-<p>
-Furthermore, NMI handlers can be interrupted by what appear to RCU
-to be normal interrupts.
-One way that this can happen is for code that directly invokes
-<tt>rcu_irq_enter()</tt> and <tt>rcu_irq_exit()</tt> to be called
-from an NMI handler.
-This astonishing fact of life prompted the current code structure,
-which has <tt>rcu_irq_enter()</tt> invoking <tt>rcu_nmi_enter()</tt>
-and <tt>rcu_irq_exit()</tt> invoking <tt>rcu_nmi_exit()</tt>.
-And yes, I also learned of this requirement the hard way.
-
-<h3><a name="Loadable Modules">Loadable Modules</a></h3>
-
-<p>
-The Linux kernel has loadable modules, and these modules can
-also be unloaded.
-After a given module has been unloaded, any attempt to call
-one of its functions results in a segmentation fault.
-The module-unload functions must therefore cancel any
-delayed calls to loadable-module functions, for example,
-any outstanding <tt>mod_timer()</tt> must be dealt with
-via <tt>del_timer_sync()</tt> or similar.
-
-<p>
-Unfortunately, there is no way to cancel an RCU callback;
-once you invoke <tt>call_rcu()</tt>, the callback function is
-eventually going to be invoked, unless the system goes down first.
-Because it is normally considered socially irresponsible to crash the system
-in response to a module unload request, we need some other way
-to deal with in-flight RCU callbacks.
-
-<p>
-RCU therefore provides
-<tt><a href="https://lwn.net/Articles/217484/">rcu_barrier()</a></tt>,
-which waits until all in-flight RCU callbacks have been invoked.
-If a module uses <tt>call_rcu()</tt>, its exit function should therefore
-prevent any future invocation of <tt>call_rcu()</tt>, then invoke
-<tt>rcu_barrier()</tt>.
-In theory, the underlying module-unload code could invoke
-<tt>rcu_barrier()</tt> unconditionally, but in practice this would
-incur unacceptable latencies.
-
-<p>
-Nikita Danilov noted this requirement for an analogous filesystem-unmount
-situation, and Dipankar Sarma incorporated <tt>rcu_barrier()</tt> into RCU.
-The need for <tt>rcu_barrier()</tt> for module unloading became
-apparent later.
-
-<p>
-<b>Important note</b>: The <tt>rcu_barrier()</tt> function is not,
-repeat, <i>not</i>, obligated to wait for a grace period.
-It is instead only required to wait for RCU callbacks that have
-already been posted.
-Therefore, if there are no RCU callbacks posted anywhere in the system,
-<tt>rcu_barrier()</tt> is within its rights to return immediately.
-Even if there are callbacks posted, <tt>rcu_barrier()</tt> does not
-necessarily need to wait for a grace period.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Wait a minute!
-	Each RCU callbacks must wait for a grace period to complete,
-	and <tt>rcu_barrier()</tt> must wait for each pre-existing
-	callback to be invoked.
-	Doesn't <tt>rcu_barrier()</tt> therefore need to wait for
-	a full grace period if there is even one callback posted anywhere
-	in the system?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	Absolutely not!!!
-	</font>
-
-	<p><font color="ffffff">
-	Yes, each RCU callbacks must wait for a grace period to complete,
-	but it might well be partly (or even completely) finished waiting
-	by the time <tt>rcu_barrier()</tt> is invoked.
-	In that case, <tt>rcu_barrier()</tt> need only wait for the
-	remaining portion of the grace period to elapse.
-	So even if there are quite a few callbacks posted,
-	<tt>rcu_barrier()</tt> might well return quite quickly.
-	</font>
-
-	<p><font color="ffffff">
-	So if you need to wait for a grace period as well as for all
-	pre-existing callbacks, you will need to invoke both
-	<tt>synchronize_rcu()</tt> and <tt>rcu_barrier()</tt>.
-	If latency is a concern, you can always use workqueues
-	to invoke them concurrently.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<h3><a name="Hotplug CPU">Hotplug CPU</a></h3>
-
-<p>
-The Linux kernel supports CPU hotplug, which means that CPUs
-can come and go.
-It is of course illegal to use any RCU API member from an offline CPU,
-with the exception of <a href="#Sleepable RCU">SRCU</a> read-side
-critical sections.
-This requirement was present from day one in DYNIX/ptx, but
-on the other hand, the Linux kernel's CPU-hotplug implementation
-is &ldquo;interesting.&rdquo;
-
-<p>
-The Linux-kernel CPU-hotplug implementation has notifiers that
-are used to allow the various kernel subsystems (including RCU)
-to respond appropriately to a given CPU-hotplug operation.
-Most RCU operations may be invoked from CPU-hotplug notifiers,
-including even synchronous grace-period operations such as
-<tt>synchronize_rcu()</tt> and <tt>synchronize_rcu_expedited()</tt>.
-
-<p>
-However, all-callback-wait operations such as
-<tt>rcu_barrier()</tt> are also not supported, due to the
-fact that there are phases of CPU-hotplug operations where
-the outgoing CPU's callbacks will not be invoked until after
-the CPU-hotplug operation ends, which could also result in deadlock.
-Furthermore, <tt>rcu_barrier()</tt> blocks CPU-hotplug operations
-during its execution, which results in another type of deadlock
-when invoked from a CPU-hotplug notifier.
-
-<h3><a name="Scheduler and RCU">Scheduler and RCU</a></h3>
-
-<p>
-RCU depends on the scheduler, and the scheduler uses RCU to
-protect some of its data structures.
-The preemptible-RCU <tt>rcu_read_unlock()</tt>
-implementation must therefore be written carefully to avoid deadlocks
-involving the scheduler's runqueue and priority-inheritance locks.
-In particular, <tt>rcu_read_unlock()</tt> must tolerate an
-interrupt where the interrupt handler invokes both
-<tt>rcu_read_lock()</tt> and <tt>rcu_read_unlock()</tt>.
-This possibility requires <tt>rcu_read_unlock()</tt> to use
-negative nesting levels to avoid destructive recursion via
-interrupt handler's use of RCU.
-
-<p>
-This scheduler-RCU requirement came as a
-<a href="https://lwn.net/Articles/453002/">complete surprise</a>.
-
-<p>
-As noted above, RCU makes use of kthreads, and it is necessary to
-avoid excessive CPU-time accumulation by these kthreads.
-This requirement was no surprise, but RCU's violation of it
-when running context-switch-heavy workloads when built with
-<tt>CONFIG_NO_HZ_FULL=y</tt>
-<a href="http://www.rdrop.com/users/paulmck/scalability/paper/BareMetal.2015.01.15b.pdf">did come as a surprise [PDF]</a>.
-RCU has made good progress towards meeting this requirement, even
-for context-switch-heavy <tt>CONFIG_NO_HZ_FULL=y</tt> workloads,
-but there is room for further improvement.
-
-<p>
-It is forbidden to hold any of scheduler's runqueue or priority-inheritance
-spinlocks across an <tt>rcu_read_unlock()</tt> unless interrupts have been
-disabled across the entire RCU read-side critical section, that is,
-up to and including the matching <tt>rcu_read_lock()</tt>.
-Violating this restriction can result in deadlocks involving these
-scheduler spinlocks.
-There was hope that this restriction might be lifted when interrupt-disabled
-calls to <tt>rcu_read_unlock()</tt> started deferring the reporting of
-the resulting RCU-preempt quiescent state until the end of the corresponding
-interrupts-disabled region.
-Unfortunately, timely reporting of the corresponding quiescent state
-to expedited grace periods requires a call to <tt>raise_softirq()</tt>,
-which can acquire these scheduler spinlocks.
-In addition, real-time systems using RCU priority boosting
-need this restriction to remain in effect because deferred
-quiescent-state reporting would also defer deboosting, which in turn
-would degrade real-time latencies.
-
-<p>
-In theory, if a given RCU read-side critical section could be
-guaranteed to be less than one second in duration, holding a scheduler
-spinlock across that critical section's <tt>rcu_read_unlock()</tt>
-would require only that preemption be disabled across the entire
-RCU read-side critical section, not interrupts.
-Unfortunately, given the possibility of vCPU preemption, long-running
-interrupts, and so on, it is not possible in practice to guarantee
-that a given RCU read-side critical section will complete in less than
-one second.
-Therefore, as noted above, if scheduler spinlocks are held across
-a given call to <tt>rcu_read_unlock()</tt>, interrupts must be
-disabled across the entire RCU read-side critical section.
-
-<h3><a name="Tracing and RCU">Tracing and RCU</a></h3>
-
-<p>
-It is possible to use tracing on RCU code, but tracing itself
-uses RCU.
-For this reason, <tt>rcu_dereference_raw_notrace()</tt>
-is provided for use by tracing, which avoids the destructive
-recursion that could otherwise ensue.
-This API is also used by virtualization in some architectures,
-where RCU readers execute in environments in which tracing
-cannot be used.
-The tracing folks both located the requirement and provided the
-needed fix, so this surprise requirement was relatively painless.
-
-<h3><a name="Energy Efficiency">Energy Efficiency</a></h3>
-
-<p>
-Interrupting idle CPUs is considered socially unacceptable,
-especially by people with battery-powered embedded systems.
-RCU therefore conserves energy by detecting which CPUs are
-idle, including tracking CPUs that have been interrupted from idle.
-This is a large part of the energy-efficiency requirement,
-so I learned of this via an irate phone call.
-
-<p>
-Because RCU avoids interrupting idle CPUs, it is illegal to
-execute an RCU read-side critical section on an idle CPU.
-(Kernels built with <tt>CONFIG_PROVE_RCU=y</tt> will splat
-if you try it.)
-The <tt>RCU_NONIDLE()</tt> macro and <tt>_rcuidle</tt>
-event tracing is provided to work around this restriction.
-In addition, <tt>rcu_is_watching()</tt> may be used to
-test whether or not it is currently legal to run RCU read-side
-critical sections on this CPU.
-I learned of the need for diagnostics on the one hand
-and <tt>RCU_NONIDLE()</tt> on the other while inspecting
-idle-loop code.
-Steven Rostedt supplied <tt>_rcuidle</tt> event tracing,
-which is used quite heavily in the idle loop.
-However, there are some restrictions on the code placed within
-<tt>RCU_NONIDLE()</tt>:
-
-<ol>
-<li>	Blocking is prohibited.
-	In practice, this is not a serious restriction given that idle
-	tasks are prohibited from blocking to begin with.
-<li>	Although nesting <tt>RCU_NONIDLE()</tt> is permitted, they cannot
-	nest indefinitely deeply.
-	However, given that they can be nested on the order of a million
-	deep, even on 32-bit systems, this should not be a serious
-	restriction.
-	This nesting limit would probably be reached long after the
-	compiler OOMed or the stack overflowed.
-<li>	Any code path that enters <tt>RCU_NONIDLE()</tt> must sequence
-	out of that same <tt>RCU_NONIDLE()</tt>.
-	For example, the following is grossly illegal:
-
-	<blockquote>
-	<pre>
- 1     RCU_NONIDLE({
- 2       do_something();
- 3       goto bad_idea;  /* BUG!!! */
- 4       do_something_else();});
- 5   bad_idea:
-	</pre>
-	</blockquote>
-
-	<p>
-	It is just as illegal to transfer control into the middle of
-	<tt>RCU_NONIDLE()</tt>'s argument.
-	Yes, in theory, you could transfer in as long as you also
-	transferred out, but in practice you could also expect to get sharply
-	worded review comments.
-</ol>
-
-<p>
-It is similarly socially unacceptable to interrupt an
-<tt>nohz_full</tt> CPU running in userspace.
-RCU must therefore track <tt>nohz_full</tt> userspace
-execution.
-RCU must therefore be able to sample state at two points in
-time, and be able to determine whether or not some other CPU spent
-any time idle and/or executing in userspace.
-
-<p>
-These energy-efficiency requirements have proven quite difficult to
-understand and to meet, for example, there have been more than five
-clean-sheet rewrites of RCU's energy-efficiency code, the last of
-which was finally able to demonstrate
-<a href="http://www.rdrop.com/users/paulmck/realtime/paper/AMPenergy.2013.04.19a.pdf">real energy savings running on real hardware [PDF]</a>.
-As noted earlier,
-I learned of many of these requirements via angry phone calls:
-Flaming me on the Linux-kernel mailing list was apparently not
-sufficient to fully vent their ire at RCU's energy-efficiency bugs!
-
-<h3><a name="Scheduling-Clock Interrupts and RCU">
-Scheduling-Clock Interrupts and RCU</a></h3>
-
-<p>
-The kernel transitions between in-kernel non-idle execution, userspace
-execution, and the idle loop.
-Depending on kernel configuration, RCU handles these states differently:
-
-<table border=3>
-<tr><th><tt>HZ</tt> Kconfig</th>
-	<th>In-Kernel</th>
-		<th>Usermode</th>
-			<th>Idle</th></tr>
-<tr><th align="left"><tt>HZ_PERIODIC</tt></th>
-	<td>Can rely on scheduling-clock interrupt.</td>
-		<td>Can rely on scheduling-clock interrupt and its
-		    detection of interrupt from usermode.</td>
-			<td>Can rely on RCU's dyntick-idle detection.</td></tr>
-<tr><th align="left"><tt>NO_HZ_IDLE</tt></th>
-	<td>Can rely on scheduling-clock interrupt.</td>
-		<td>Can rely on scheduling-clock interrupt and its
-		    detection of interrupt from usermode.</td>
-			<td>Can rely on RCU's dyntick-idle detection.</td></tr>
-<tr><th align="left"><tt>NO_HZ_FULL</tt></th>
-	<td>Can only sometimes rely on scheduling-clock interrupt.
-	    In other cases, it is necessary to bound kernel execution
-	    times and/or use IPIs.</td>
-		<td>Can rely on RCU's dyntick-idle detection.</td>
-			<td>Can rely on RCU's dyntick-idle detection.</td></tr>
-</table>
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	Why can't <tt>NO_HZ_FULL</tt> in-kernel execution rely on the
-	scheduling-clock interrupt, just like <tt>HZ_PERIODIC</tt>
-	and <tt>NO_HZ_IDLE</tt> do?
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	Because, as a performance optimization, <tt>NO_HZ_FULL</tt>
-	does not necessarily re-enable the scheduling-clock interrupt
-	on entry to each and every system call.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>
-However, RCU must be reliably informed as to whether any given
-CPU is currently in the idle loop, and, for <tt>NO_HZ_FULL</tt>,
-also whether that CPU is executing in usermode, as discussed
-<a href="#Energy Efficiency">earlier</a>.
-It also requires that the scheduling-clock interrupt be enabled when
-RCU needs it to be:
-
-<ol>
-<li>	If a CPU is either idle or executing in usermode, and RCU believes
-	it is non-idle, the scheduling-clock tick had better be running.
-	Otherwise, you will get RCU CPU stall warnings.  Or at best,
-	very long (11-second) grace periods, with a pointless IPI waking
-	the CPU from time to time.
-<li>	If a CPU is in a portion of the kernel that executes RCU read-side
-	critical sections, and RCU believes this CPU to be idle, you will get
-	random memory corruption.  <b>DON'T DO THIS!!!</b>
-
-	<br>This is one reason to test with lockdep, which will complain
-	about this sort of thing.
-<li>	If a CPU is in a portion of the kernel that is absolutely
-	positively no-joking guaranteed to never execute any RCU read-side
-	critical sections, and RCU believes this CPU to to be idle,
-	no problem.  This sort of thing is used by some architectures
-	for light-weight exception handlers, which can then avoid the
-	overhead of <tt>rcu_irq_enter()</tt> and <tt>rcu_irq_exit()</tt>
-	at exception entry and exit, respectively.
-	Some go further and avoid the entireties of <tt>irq_enter()</tt>
-	and <tt>irq_exit()</tt>.
-
-	<br>Just make very sure you are running some of your tests with
-	<tt>CONFIG_PROVE_RCU=y</tt>, just in case one of your code paths
-	was in fact joking about not doing RCU read-side critical sections.
-<li>	If a CPU is executing in the kernel with the scheduling-clock
-	interrupt disabled and RCU believes this CPU to be non-idle,
-	and if the CPU goes idle (from an RCU perspective) every few
-	jiffies, no problem.  It is usually OK for there to be the
-	occasional gap between idle periods of up to a second or so.
-
-	<br>If the gap grows too long, you get RCU CPU stall warnings.
-<li>	If a CPU is either idle or executing in usermode, and RCU believes
-	it to be idle, of course no problem.
-<li>	If a CPU is executing in the kernel, the kernel code
-	path is passing through quiescent states at a reasonable
-	frequency (preferably about once per few jiffies, but the
-	occasional excursion to a second or so is usually OK) and the
-	scheduling-clock interrupt is enabled, of course no problem.
-
-	<br>If the gap between a successive pair of quiescent states grows
-	too long, you get RCU CPU stall warnings.
-</ol>
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	But what if my driver has a hardware interrupt handler
-	that can run for many seconds?
-	I cannot invoke <tt>schedule()</tt> from an hardware
-	interrupt handler, after all!
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	One approach is to do <tt>rcu_irq_exit();rcu_irq_enter();</tt>
-	every so often.
-	But given that long-running interrupt handlers can cause
-	other problems, not least for response time, shouldn't you
-	work to keep your interrupt handler's runtime within reasonable
-	bounds?
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
-<p>
-But as long as RCU is properly informed of kernel state transitions between
-in-kernel execution, usermode execution, and idle, and as long as the
-scheduling-clock interrupt is enabled when RCU needs it to be, you
-can rest assured that the bugs you encounter will be in some other
-part of RCU or some other part of the kernel!
-
-<h3><a name="Memory Efficiency">Memory Efficiency</a></h3>
-
-<p>
-Although small-memory non-realtime systems can simply use Tiny RCU,
-code size is only one aspect of memory efficiency.
-Another aspect is the size of the <tt>rcu_head</tt> structure
-used by <tt>call_rcu()</tt> and <tt>kfree_rcu()</tt>.
-Although this structure contains nothing more than a pair of pointers,
-it does appear in many RCU-protected data structures, including
-some that are size critical.
-The <tt>page</tt> structure is a case in point, as evidenced by
-the many occurrences of the <tt>union</tt> keyword within that structure.
-
-<p>
-This need for memory efficiency is one reason that RCU uses hand-crafted
-singly linked lists to track the <tt>rcu_head</tt> structures that
-are waiting for a grace period to elapse.
-It is also the reason why <tt>rcu_head</tt> structures do not contain
-debug information, such as fields tracking the file and line of the
-<tt>call_rcu()</tt> or <tt>kfree_rcu()</tt> that posted them.
-Although this information might appear in debug-only kernel builds at some
-point, in the meantime, the <tt>-&gt;func</tt> field will often provide
-the needed debug information.
-
-<p>
-However, in some cases, the need for memory efficiency leads to even
-more extreme measures.
-Returning to the <tt>page</tt> structure, the <tt>rcu_head</tt> field
-shares storage with a great many other structures that are used at
-various points in the corresponding page's lifetime.
-In order to correctly resolve certain
-<a href="https://lkml.kernel.org/g/1439976106-137226-1-git-send-email-kirill.shutemov@linux.intel.com">race conditions</a>,
-the Linux kernel's memory-management subsystem needs a particular bit
-to remain zero during all phases of grace-period processing,
-and that bit happens to map to the bottom bit of the
-<tt>rcu_head</tt> structure's <tt>-&gt;next</tt> field.
-RCU makes this guarantee as long as <tt>call_rcu()</tt>
-is used to post the callback, as opposed to <tt>kfree_rcu()</tt>
-or some future &ldquo;lazy&rdquo;
-variant of <tt>call_rcu()</tt> that might one day be created for
-energy-efficiency purposes.
-
-<p>
-That said, there are limits.
-RCU requires that the <tt>rcu_head</tt> structure be aligned to a
-two-byte boundary, and passing a misaligned <tt>rcu_head</tt>
-structure to one of the <tt>call_rcu()</tt> family of functions
-will result in a splat.
-It is therefore necessary to exercise caution when packing
-structures containing fields of type <tt>rcu_head</tt>.
-Why not a four-byte or even eight-byte alignment requirement?
-Because the m68k architecture provides only two-byte alignment,
-and thus acts as alignment's least common denominator.
-
-<p>
-The reason for reserving the bottom bit of pointers to
-<tt>rcu_head</tt> structures is to leave the door open to
-&ldquo;lazy&rdquo; callbacks whose invocations can safely be deferred.
-Deferring invocation could potentially have energy-efficiency
-benefits, but only if the rate of non-lazy callbacks decreases
-significantly for some important workload.
-In the meantime, reserving the bottom bit keeps this option open
-in case it one day becomes useful.
-
-<h3><a name="Performance, Scalability, Response Time, and Reliability">
-Performance, Scalability, Response Time, and Reliability</a></h3>
-
-<p>
-Expanding on the
-<a href="#Performance and Scalability">earlier discussion</a>,
-RCU is used heavily by hot code paths in performance-critical
-portions of the Linux kernel's networking, security, virtualization,
-and scheduling code paths.
-RCU must therefore use efficient implementations, especially in its
-read-side primitives.
-To that end, it would be good if preemptible RCU's implementation
-of <tt>rcu_read_lock()</tt> could be inlined, however, doing
-this requires resolving <tt>#include</tt> issues with the
-<tt>task_struct</tt> structure.
-
-<p>
-The Linux kernel supports hardware configurations with up to
-4096 CPUs, which means that RCU must be extremely scalable.
-Algorithms that involve frequent acquisitions of global locks or
-frequent atomic operations on global variables simply cannot be
-tolerated within the RCU implementation.
-RCU therefore makes heavy use of a combining tree based on the
-<tt>rcu_node</tt> structure.
-RCU is required to tolerate all CPUs continuously invoking any
-combination of RCU's runtime primitives with minimal per-operation
-overhead.
-In fact, in many cases, increasing load must <i>decrease</i> the
-per-operation overhead, witness the batching optimizations for
-<tt>synchronize_rcu()</tt>, <tt>call_rcu()</tt>,
-<tt>synchronize_rcu_expedited()</tt>, and <tt>rcu_barrier()</tt>.
-As a general rule, RCU must cheerfully accept whatever the
-rest of the Linux kernel decides to throw at it.
-
-<p>
-The Linux kernel is used for real-time workloads, especially
-in conjunction with the
-<a href="https://rt.wiki.kernel.org/index.php/Main_Page">-rt patchset</a>.
-The real-time-latency response requirements are such that the
-traditional approach of disabling preemption across RCU
-read-side critical sections is inappropriate.
-Kernels built with <tt>CONFIG_PREEMPT=y</tt> therefore
-use an RCU implementation that allows RCU read-side critical
-sections to be preempted.
-This requirement made its presence known after users made it
-clear that an earlier
-<a href="https://lwn.net/Articles/107930/">real-time patch</a>
-did not meet their needs, in conjunction with some
-<a href="https://lkml.kernel.org/g/20050318002026.GA2693@us.ibm.com">RCU issues</a>
-encountered by a very early version of the -rt patchset.
-
-<p>
-In addition, RCU must make do with a sub-100-microsecond real-time latency
-budget.
-In fact, on smaller systems with the -rt patchset, the Linux kernel
-provides sub-20-microsecond real-time latencies for the whole kernel,
-including RCU.
-RCU's scalability and latency must therefore be sufficient for
-these sorts of configurations.
-To my surprise, the sub-100-microsecond real-time latency budget
-<a href="http://www.rdrop.com/users/paulmck/realtime/paper/bigrt.2013.01.31a.LCA.pdf">
-applies to even the largest systems [PDF]</a>,
-up to and including systems with 4096 CPUs.
-This real-time requirement motivated the grace-period kthread, which
-also simplified handling of a number of race conditions.
-
-<p>
-RCU must avoid degrading real-time response for CPU-bound threads, whether
-executing in usermode (which is one use case for
-<tt>CONFIG_NO_HZ_FULL=y</tt>) or in the kernel.
-That said, CPU-bound loops in the kernel must execute
-<tt>cond_resched()</tt> at least once per few tens of milliseconds
-in order to avoid receiving an IPI from RCU.
-
-<p>
-Finally, RCU's status as a synchronization primitive means that
-any RCU failure can result in arbitrary memory corruption that can be
-extremely difficult to debug.
-This means that RCU must be extremely reliable, which in
-practice also means that RCU must have an aggressive stress-test
-suite.
-This stress-test suite is called <tt>rcutorture</tt>.
-
-<p>
-Although the need for <tt>rcutorture</tt> was no surprise,
-the current immense popularity of the Linux kernel is posing
-interesting&mdash;and perhaps unprecedented&mdash;validation
-challenges.
-To see this, keep in mind that there are well over one billion
-instances of the Linux kernel running today, given Android
-smartphones, Linux-powered televisions, and servers.
-This number can be expected to increase sharply with the advent of
-the celebrated Internet of Things.
-
-<p>
-Suppose that RCU contains a race condition that manifests on average
-once per million years of runtime.
-This bug will be occurring about three times per <i>day</i> across
-the installed base.
-RCU could simply hide behind hardware error rates, given that no one
-should really expect their smartphone to last for a million years.
-However, anyone taking too much comfort from this thought should
-consider the fact that in most jurisdictions, a successful multi-year
-test of a given mechanism, which might include a Linux kernel,
-suffices for a number of types of safety-critical certifications.
-In fact, rumor has it that the Linux kernel is already being used
-in production for safety-critical applications.
-I don't know about you, but I would feel quite bad if a bug in RCU
-killed someone.
-Which might explain my recent focus on validation and verification.
-
-<h2><a name="Other RCU Flavors">Other RCU Flavors</a></h2>
-
-<p>
-One of the more surprising things about RCU is that there are now
-no fewer than five <i>flavors</i>, or API families.
-In addition, the primary flavor that has been the sole focus up to
-this point has two different implementations, non-preemptible and
-preemptible.
-The other four flavors are listed below, with requirements for each
-described in a separate section.
-
-<ol>
-<li>	<a href="#Bottom-Half Flavor">Bottom-Half Flavor (Historical)</a>
-<li>	<a href="#Sched Flavor">Sched Flavor (Historical)</a>
-<li>	<a href="#Sleepable RCU">Sleepable RCU</a>
-<li>	<a href="#Tasks RCU">Tasks RCU</a>
-</ol>
-
-<h3><a name="Bottom-Half Flavor">Bottom-Half Flavor (Historical)</a></h3>
-
-<p>
-The RCU-bh flavor of RCU has since been expressed in terms of
-the other RCU flavors as part of a consolidation of the three
-flavors into a single flavor.
-The read-side API remains, and continues to disable softirq and to
-be accounted for by lockdep.
-Much of the material in this section is therefore strictly historical
-in nature.
-
-<p>
-The softirq-disable (AKA &ldquo;bottom-half&rdquo;,
-hence the &ldquo;_bh&rdquo; abbreviations)
-flavor of RCU, or <i>RCU-bh</i>, was developed by
-Dipankar Sarma to provide a flavor of RCU that could withstand the
-network-based denial-of-service attacks researched by Robert
-Olsson.
-These attacks placed so much networking load on the system
-that some of the CPUs never exited softirq execution,
-which in turn prevented those CPUs from ever executing a context switch,
-which, in the RCU implementation of that time, prevented grace periods
-from ever ending.
-The result was an out-of-memory condition and a system hang.
-
-<p>
-The solution was the creation of RCU-bh, which does
-<tt>local_bh_disable()</tt>
-across its read-side critical sections, and which uses the transition
-from one type of softirq processing to another as a quiescent state
-in addition to context switch, idle, user mode, and offline.
-This means that RCU-bh grace periods can complete even when some of
-the CPUs execute in softirq indefinitely, thus allowing algorithms
-based on RCU-bh to withstand network-based denial-of-service attacks.
-
-<p>
-Because
-<tt>rcu_read_lock_bh()</tt> and <tt>rcu_read_unlock_bh()</tt>
-disable and re-enable softirq handlers, any attempt to start a softirq
-handlers during the
-RCU-bh read-side critical section will be deferred.
-In this case, <tt>rcu_read_unlock_bh()</tt>
-will invoke softirq processing, which can take considerable time.
-One can of course argue that this softirq overhead should be associated
-with the code following the RCU-bh read-side critical section rather
-than <tt>rcu_read_unlock_bh()</tt>, but the fact
-is that most profiling tools cannot be expected to make this sort
-of fine distinction.
-For example, suppose that a three-millisecond-long RCU-bh read-side
-critical section executes during a time of heavy networking load.
-There will very likely be an attempt to invoke at least one softirq
-handler during that three milliseconds, but any such invocation will
-be delayed until the time of the <tt>rcu_read_unlock_bh()</tt>.
-This can of course make it appear at first glance as if
-<tt>rcu_read_unlock_bh()</tt> was executing very slowly.
-
-<p>
-The
-<a href="https://lwn.net/Articles/609973/#RCU Per-Flavor API Table">RCU-bh API</a>
-includes
-<tt>rcu_read_lock_bh()</tt>,
-<tt>rcu_read_unlock_bh()</tt>,
-<tt>rcu_dereference_bh()</tt>,
-<tt>rcu_dereference_bh_check()</tt>,
-<tt>synchronize_rcu_bh()</tt>,
-<tt>synchronize_rcu_bh_expedited()</tt>,
-<tt>call_rcu_bh()</tt>,
-<tt>rcu_barrier_bh()</tt>, and
-<tt>rcu_read_lock_bh_held()</tt>.
-However, the update-side APIs are now simple wrappers for other RCU
-flavors, namely RCU-sched in CONFIG_PREEMPT=n kernels and RCU-preempt
-otherwise.
-
-<h3><a name="Sched Flavor">Sched Flavor (Historical)</a></h3>
-
-<p>
-The RCU-sched flavor of RCU has since been expressed in terms of
-the other RCU flavors as part of a consolidation of the three
-flavors into a single flavor.
-The read-side API remains, and continues to disable preemption and to
-be accounted for by lockdep.
-Much of the material in this section is therefore strictly historical
-in nature.
-
-<p>
-Before preemptible RCU, waiting for an RCU grace period had the
-side effect of also waiting for all pre-existing interrupt
-and NMI handlers.
-However, there are legitimate preemptible-RCU implementations that
-do not have this property, given that any point in the code outside
-of an RCU read-side critical section can be a quiescent state.
-Therefore, <i>RCU-sched</i> was created, which follows &ldquo;classic&rdquo;
-RCU in that an RCU-sched grace period waits for for pre-existing
-interrupt and NMI handlers.
-In kernels built with <tt>CONFIG_PREEMPT=n</tt>, the RCU and RCU-sched
-APIs have identical implementations, while kernels built with
-<tt>CONFIG_PREEMPT=y</tt> provide a separate implementation for each.
-
-<p>
-Note well that in <tt>CONFIG_PREEMPT=y</tt> kernels,
-<tt>rcu_read_lock_sched()</tt> and <tt>rcu_read_unlock_sched()</tt>
-disable and re-enable preemption, respectively.
-This means that if there was a preemption attempt during the
-RCU-sched read-side critical section, <tt>rcu_read_unlock_sched()</tt>
-will enter the scheduler, with all the latency and overhead entailed.
-Just as with <tt>rcu_read_unlock_bh()</tt>, this can make it look
-as if <tt>rcu_read_unlock_sched()</tt> was executing very slowly.
-However, the highest-priority task won't be preempted, so that task
-will enjoy low-overhead <tt>rcu_read_unlock_sched()</tt> invocations.
-
-<p>
-The
-<a href="https://lwn.net/Articles/609973/#RCU Per-Flavor API Table">RCU-sched API</a>
-includes
-<tt>rcu_read_lock_sched()</tt>,
-<tt>rcu_read_unlock_sched()</tt>,
-<tt>rcu_read_lock_sched_notrace()</tt>,
-<tt>rcu_read_unlock_sched_notrace()</tt>,
-<tt>rcu_dereference_sched()</tt>,
-<tt>rcu_dereference_sched_check()</tt>,
-<tt>synchronize_sched()</tt>,
-<tt>synchronize_rcu_sched_expedited()</tt>,
-<tt>call_rcu_sched()</tt>,
-<tt>rcu_barrier_sched()</tt>, and
-<tt>rcu_read_lock_sched_held()</tt>.
-However, anything that disables preemption also marks an RCU-sched
-read-side critical section, including
-<tt>preempt_disable()</tt> and <tt>preempt_enable()</tt>,
-<tt>local_irq_save()</tt> and <tt>local_irq_restore()</tt>,
-and so on.
-
-<h3><a name="Sleepable RCU">Sleepable RCU</a></h3>
-
-<p>
-For well over a decade, someone saying &ldquo;I need to block within
-an RCU read-side critical section&rdquo; was a reliable indication
-that this someone did not understand RCU.
-After all, if you are always blocking in an RCU read-side critical
-section, you can probably afford to use a higher-overhead synchronization
-mechanism.
-However, that changed with the advent of the Linux kernel's notifiers,
-whose RCU read-side critical
-sections almost never sleep, but sometimes need to.
-This resulted in the introduction of
-<a href="https://lwn.net/Articles/202847/">sleepable RCU</a>,
-or <i>SRCU</i>.
-
-<p>
-SRCU allows different domains to be defined, with each such domain
-defined by an instance of an <tt>srcu_struct</tt> structure.
-A pointer to this structure must be passed in to each SRCU function,
-for example, <tt>synchronize_srcu(&amp;ss)</tt>, where
-<tt>ss</tt> is the <tt>srcu_struct</tt> structure.
-The key benefit of these domains is that a slow SRCU reader in one
-domain does not delay an SRCU grace period in some other domain.
-That said, one consequence of these domains is that read-side code
-must pass a &ldquo;cookie&rdquo; from <tt>srcu_read_lock()</tt>
-to <tt>srcu_read_unlock()</tt>, for example, as follows:
-
-<blockquote>
-<pre>
- 1 int idx;
- 2
- 3 idx = srcu_read_lock(&amp;ss);
- 4 do_something();
- 5 srcu_read_unlock(&amp;ss, idx);
-</pre>
-</blockquote>
-
-<p>
-As noted above, it is legal to block within SRCU read-side critical sections,
-however, with great power comes great responsibility.
-If you block forever in one of a given domain's SRCU read-side critical
-sections, then that domain's grace periods will also be blocked forever.
-Of course, one good way to block forever is to deadlock, which can
-happen if any operation in a given domain's SRCU read-side critical
-section can wait, either directly or indirectly, for that domain's
-grace period to elapse.
-For example, this results in a self-deadlock:
-
-<blockquote>
-<pre>
- 1 int idx;
- 2
- 3 idx = srcu_read_lock(&amp;ss);
- 4 do_something();
- 5 synchronize_srcu(&amp;ss);
- 6 srcu_read_unlock(&amp;ss, idx);
-</pre>
-</blockquote>
-
-<p>
-However, if line&nbsp;5 acquired a mutex that was held across
-a <tt>synchronize_srcu()</tt> for domain <tt>ss</tt>,
-deadlock would still be possible.
-Furthermore, if line&nbsp;5 acquired a mutex that was held across
-a <tt>synchronize_srcu()</tt> for some other domain <tt>ss1</tt>,
-and if an <tt>ss1</tt>-domain SRCU read-side critical section
-acquired another mutex that was held across as <tt>ss</tt>-domain
-<tt>synchronize_srcu()</tt>,
-deadlock would again be possible.
-Such a deadlock cycle could extend across an arbitrarily large number
-of different SRCU domains.
-Again, with great power comes great responsibility.
-
-<p>
-Unlike the other RCU flavors, SRCU read-side critical sections can
-run on idle and even offline CPUs.
-This ability requires that <tt>srcu_read_lock()</tt> and
-<tt>srcu_read_unlock()</tt> contain memory barriers, which means
-that SRCU readers will run a bit slower than would RCU readers.
-It also motivates the <tt>smp_mb__after_srcu_read_unlock()</tt>
-API, which, in combination with <tt>srcu_read_unlock()</tt>,
-guarantees a full memory barrier.
-
-<p>
-Also unlike other RCU flavors, <tt>synchronize_srcu()</tt> may <b>not</b>
-be invoked from CPU-hotplug notifiers, due to the fact that SRCU grace
-periods make use of timers and the possibility of timers being temporarily
-&ldquo;stranded&rdquo; on the outgoing CPU.
-This stranding of timers means that timers posted to the outgoing CPU
-will not fire until late in the CPU-hotplug process.
-The problem is that if a notifier is waiting on an SRCU grace period,
-that grace period is waiting on a timer, and that timer is stranded on the
-outgoing CPU, then the notifier will never be awakened, in other words,
-deadlock has occurred.
-This same situation of course also prohibits <tt>srcu_barrier()</tt>
-from being invoked from CPU-hotplug notifiers.
-
-<p>
-SRCU also differs from other RCU flavors in that SRCU's expedited and
-non-expedited grace periods are implemented by the same mechanism.
-This means that in the current SRCU implementation, expediting a
-future grace period has the side effect of expediting all prior
-grace periods that have not yet completed.
-(But please note that this is a property of the current implementation,
-not necessarily of future implementations.)
-In addition, if SRCU has been idle for longer than the interval
-specified by the <tt>srcutree.exp_holdoff</tt> kernel boot parameter
-(25&nbsp;microseconds by default),
-and if a <tt>synchronize_srcu()</tt> invocation ends this idle period,
-that invocation will be automatically expedited.
-
-<p>
-As of v4.12, SRCU's callbacks are maintained per-CPU, eliminating
-a locking bottleneck present in prior kernel versions.
-Although this will allow users to put much heavier stress on
-<tt>call_srcu()</tt>, it is important to note that SRCU does not
-yet take any special steps to deal with callback flooding.
-So if you are posting (say) 10,000 SRCU callbacks per second per CPU,
-you are probably totally OK, but if you intend to post (say) 1,000,000
-SRCU callbacks per second per CPU, please run some tests first.
-SRCU just might need a few adjustment to deal with that sort of load.
-Of course, your mileage may vary based on the speed of your CPUs and
-the size of your memory.
-
-<p>
-The
-<a href="https://lwn.net/Articles/609973/#RCU Per-Flavor API Table">SRCU API</a>
-includes
-<tt>srcu_read_lock()</tt>,
-<tt>srcu_read_unlock()</tt>,
-<tt>srcu_dereference()</tt>,
-<tt>srcu_dereference_check()</tt>,
-<tt>synchronize_srcu()</tt>,
-<tt>synchronize_srcu_expedited()</tt>,
-<tt>call_srcu()</tt>,
-<tt>srcu_barrier()</tt>, and
-<tt>srcu_read_lock_held()</tt>.
-It also includes
-<tt>DEFINE_SRCU()</tt>,
-<tt>DEFINE_STATIC_SRCU()</tt>, and
-<tt>init_srcu_struct()</tt>
-APIs for defining and initializing <tt>srcu_struct</tt> structures.
-
-<h3><a name="Tasks RCU">Tasks RCU</a></h3>
-
-<p>
-Some forms of tracing use &ldquo;trampolines&rdquo; to handle the
-binary rewriting required to install different types of probes.
-It would be good to be able to free old trampolines, which sounds
-like a job for some form of RCU.
-However, because it is necessary to be able to install a trace
-anywhere in the code, it is not possible to use read-side markers
-such as <tt>rcu_read_lock()</tt> and <tt>rcu_read_unlock()</tt>.
-In addition, it does not work to have these markers in the trampoline
-itself, because there would need to be instructions following
-<tt>rcu_read_unlock()</tt>.
-Although <tt>synchronize_rcu()</tt> would guarantee that execution
-reached the <tt>rcu_read_unlock()</tt>, it would not be able to
-guarantee that execution had completely left the trampoline.
-
-<p>
-The solution, in the form of
-<a href="https://lwn.net/Articles/607117/"><i>Tasks RCU</i></a>,
-is to have implicit
-read-side critical sections that are delimited by voluntary context
-switches, that is, calls to <tt>schedule()</tt>,
-<tt>cond_resched()</tt>, and
-<tt>synchronize_rcu_tasks()</tt>.
-In addition, transitions to and from userspace execution also delimit
-tasks-RCU read-side critical sections.
-
-<p>
-The tasks-RCU API is quite compact, consisting only of
-<tt>call_rcu_tasks()</tt>,
-<tt>synchronize_rcu_tasks()</tt>, and
-<tt>rcu_barrier_tasks()</tt>.
-In <tt>CONFIG_PREEMPT=n</tt> kernels, trampolines cannot be preempted,
-so these APIs map to
-<tt>call_rcu()</tt>,
-<tt>synchronize_rcu()</tt>, and
-<tt>rcu_barrier()</tt>, respectively.
-In <tt>CONFIG_PREEMPT=y</tt> kernels, trampolines can be preempted,
-and these three APIs are therefore implemented by separate functions
-that check for voluntary context switches.
-
-<h2><a name="Possible Future Changes">Possible Future Changes</a></h2>
-
-<p>
-One of the tricks that RCU uses to attain update-side scalability is
-to increase grace-period latency with increasing numbers of CPUs.
-If this becomes a serious problem, it will be necessary to rework the
-grace-period state machine so as to avoid the need for the additional
-latency.
-
-<p>
-RCU disables CPU hotplug in a few places, perhaps most notably in the
-<tt>rcu_barrier()</tt> operations.
-If there is a strong reason to use <tt>rcu_barrier()</tt> in CPU-hotplug
-notifiers, it will be necessary to avoid disabling CPU hotplug.
-This would introduce some complexity, so there had better be a <i>very</i>
-good reason.
-
-<p>
-The tradeoff between grace-period latency on the one hand and interruptions
-of other CPUs on the other hand may need to be re-examined.
-The desire is of course for zero grace-period latency as well as zero
-interprocessor interrupts undertaken during an expedited grace period
-operation.
-While this ideal is unlikely to be achievable, it is quite possible that
-further improvements can be made.
-
-<p>
-The multiprocessor implementations of RCU use a combining tree that
-groups CPUs so as to reduce lock contention and increase cache locality.
-However, this combining tree does not spread its memory across NUMA
-nodes nor does it align the CPU groups with hardware features such
-as sockets or cores.
-Such spreading and alignment is currently believed to be unnecessary
-because the hotpath read-side primitives do not access the combining
-tree, nor does <tt>call_rcu()</tt> in the common case.
-If you believe that your architecture needs such spreading and alignment,
-then your architecture should also benefit from the
-<tt>rcutree.rcu_fanout_leaf</tt> boot parameter, which can be set
-to the number of CPUs in a socket, NUMA node, or whatever.
-If the number of CPUs is too large, use a fraction of the number of
-CPUs.
-If the number of CPUs is a large prime number, well, that certainly
-is an &ldquo;interesting&rdquo; architectural choice!
-More flexible arrangements might be considered, but only if
-<tt>rcutree.rcu_fanout_leaf</tt> has proven inadequate, and only
-if the inadequacy has been demonstrated by a carefully run and
-realistic system-level workload.
-
-<p>
-Please note that arrangements that require RCU to remap CPU numbers will
-require extremely good demonstration of need and full exploration of
-alternatives.
-
-<p>
-RCU's various kthreads are reasonably recent additions.
-It is quite likely that adjustments will be required to more gracefully
-handle extreme loads.
-It might also be necessary to be able to relate CPU utilization by
-RCU's kthreads and softirq handlers to the code that instigated this
-CPU utilization.
-For example, RCU callback overhead might be charged back to the
-originating <tt>call_rcu()</tt> instance, though probably not
-in production kernels.
-
-<p>
-Additional work may be required to provide reasonable forward-progress
-guarantees under heavy load for grace periods and for callback
-invocation.
-
-<h2><a name="Summary">Summary</a></h2>
-
-<p>
-This document has presented more than two decade's worth of RCU
-requirements.
-Given that the requirements keep changing, this will not be the last
-word on this subject, but at least it serves to get an important
-subset of the requirements set forth.
-
-<h2><a name="Acknowledgments">Acknowledgments</a></h2>
-
-I am grateful to Steven Rostedt, Lai Jiangshan, Ingo Molnar,
-Oleg Nesterov, Borislav Petkov, Peter Zijlstra, Boqun Feng, and
-Andy Lutomirski for their help in rendering
-this article human readable, and to Michelle Rankin for her support
-of this effort.
-Other contributions are acknowledged in the Linux kernel's git archive.
-
-</body></html>
diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
new file mode 100644
index 000000000000..876e0038bb58
--- /dev/null
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -0,0 +1,2662 @@
+=================================
+A Tour Through RCU's Requirements
+=================================
+
+Copyright IBM Corporation, 2015
+
+Author: Paul E. McKenney
+
+The initial version of this document appeared in the
+`LWN <https://lwn.net/>`_ on those articles:
+`part 1 <https://lwn.net/Articles/652156/>`_,
+`part 2 <https://lwn.net/Articles/652677/>`_, and
+`part 3 <https://lwn.net/Articles/653326/>`_.
+
+Introduction
+------------
+
+Read-copy update (RCU) is a synchronization mechanism that is often used
+as a replacement for reader-writer locking. RCU is unusual in that
+updaters do not block readers, which means that RCU's read-side
+primitives can be exceedingly fast and scalable. In addition, updaters
+can make useful forward progress concurrently with readers. However, all
+this concurrency between RCU readers and updaters does raise the
+question of exactly what RCU readers are doing, which in turn raises the
+question of exactly what RCU's requirements are.
+
+This document therefore summarizes RCU's requirements, and can be
+thought of as an informal, high-level specification for RCU. It is
+important to understand that RCU's specification is primarily empirical
+in nature; in fact, I learned about many of these requirements the hard
+way. This situation might cause some consternation, however, not only
+has this learning process been a lot of fun, but it has also been a
+great privilege to work with so many people willing to apply
+technologies in interesting new ways.
+
+All that aside, here are the categories of currently known RCU
+requirements:
+
+#. `Fundamental Requirements <#Fundamental%20Requirements>`__
+#. `Fundamental Non-Requirements <#Fundamental%20Non-Requirements>`__
+#. `Parallelism Facts of Life <#Parallelism%20Facts%20of%20Life>`__
+#. `Quality-of-Implementation
+   Requirements <#Quality-of-Implementation%20Requirements>`__
+#. `Linux Kernel Complications <#Linux%20Kernel%20Complications>`__
+#. `Software-Engineering
+   Requirements <#Software-Engineering%20Requirements>`__
+#. `Other RCU Flavors <#Other%20RCU%20Flavors>`__
+#. `Possible Future Changes <#Possible%20Future%20Changes>`__
+
+This is followed by a `summary <#Summary>`__, however, the answers to
+each quick quiz immediately follows the quiz. Select the big white space
+with your mouse to see the answer.
+
+Fundamental Requirements
+------------------------
+
+RCU's fundamental requirements are the closest thing RCU has to hard
+mathematical requirements. These are:
+
+#. `Grace-Period Guarantee <#Grace-Period%20Guarantee>`__
+#. `Publish-Subscribe Guarantee <#Publish-Subscribe%20Guarantee>`__
+#. `Memory-Barrier Guarantees <#Memory-Barrier%20Guarantees>`__
+#. `RCU Primitives Guaranteed to Execute
+   Unconditionally <#RCU%20Primitives%20Guaranteed%20to%20Execute%20Unconditionally>`__
+#. `Guaranteed Read-to-Write
+   Upgrade <#Guaranteed%20Read-to-Write%20Upgrade>`__
+
+Grace-Period Guarantee
+~~~~~~~~~~~~~~~~~~~~~~
+
+RCU's grace-period guarantee is unusual in being premeditated: Jack
+Slingwine and I had this guarantee firmly in mind when we started work
+on RCU (then called “rclock”) in the early 1990s. That said, the past
+two decades of experience with RCU have produced a much more detailed
+understanding of this guarantee.
+
+RCU's grace-period guarantee allows updaters to wait for the completion
+of all pre-existing RCU read-side critical sections. An RCU read-side
+critical section begins with the marker ``rcu_read_lock()`` and ends
+with the marker ``rcu_read_unlock()``. These markers may be nested, and
+RCU treats a nested set as one big RCU read-side critical section.
+Production-quality implementations of ``rcu_read_lock()`` and
+``rcu_read_unlock()`` are extremely lightweight, and in fact have
+exactly zero overhead in Linux kernels built for production use with
+``CONFIG_PREEMPT=n``.
+
+This guarantee allows ordering to be enforced with extremely low
+overhead to readers, for example:
+
+   ::
+
+       1 int x, y;
+       2
+       3 void thread0(void)
+       4 {
+       5   rcu_read_lock();
+       6   r1 = READ_ONCE(x);
+       7   r2 = READ_ONCE(y);
+       8   rcu_read_unlock();
+       9 }
+      10
+      11 void thread1(void)
+      12 {
+      13   WRITE_ONCE(x, 1);
+      14   synchronize_rcu();
+      15   WRITE_ONCE(y, 1);
+      16 }
+
+Because the ``synchronize_rcu()`` on line 14 waits for all pre-existing
+readers, any instance of ``thread0()`` that loads a value of zero from
+``x`` must complete before ``thread1()`` stores to ``y``, so that
+instance must also load a value of zero from ``y``. Similarly, any
+instance of ``thread0()`` that loads a value of one from ``y`` must have
+started after the ``synchronize_rcu()`` started, and must therefore also
+load a value of one from ``x``. Therefore, the outcome:
+
+   ::
+
+      (r1 == 0 && r2 == 1)
+
+cannot happen.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Wait a minute! You said that updaters can make useful forward         |
+| progress concurrently with readers, but pre-existing readers will     |
+| block ``synchronize_rcu()``!!!                                        |
+| Just who are you trying to fool???                                    |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| First, if updaters do not wish to be blocked by readers, they can use |
+| ``call_rcu()`` or ``kfree_rcu()``, which will be discussed later.     |
+| Second, even when using ``synchronize_rcu()``, the other update-side  |
+| code does run concurrently with readers, whether pre-existing or not. |
++-----------------------------------------------------------------------+
+
+This scenario resembles one of the first uses of RCU in
+`DYNIX/ptx <https://en.wikipedia.org/wiki/DYNIX>`__, which managed a
+distributed lock manager's transition into a state suitable for handling
+recovery from node failure, more or less as follows:
+
+   ::
+
+       1 #define STATE_NORMAL        0
+       2 #define STATE_WANT_RECOVERY 1
+       3 #define STATE_RECOVERING    2
+       4 #define STATE_WANT_NORMAL   3
+       5
+       6 int state = STATE_NORMAL;
+       7
+       8 void do_something_dlm(void)
+       9 {
+      10   int state_snap;
+      11
+      12   rcu_read_lock();
+      13   state_snap = READ_ONCE(state);
+      14   if (state_snap == STATE_NORMAL)
+      15     do_something();
+      16   else
+      17     do_something_carefully();
+      18   rcu_read_unlock();
+      19 }
+      20
+      21 void start_recovery(void)
+      22 {
+      23   WRITE_ONCE(state, STATE_WANT_RECOVERY);
+      24   synchronize_rcu();
+      25   WRITE_ONCE(state, STATE_RECOVERING);
+      26   recovery();
+      27   WRITE_ONCE(state, STATE_WANT_NORMAL);
+      28   synchronize_rcu();
+      29   WRITE_ONCE(state, STATE_NORMAL);
+      30 }
+
+The RCU read-side critical section in ``do_something_dlm()`` works with
+the ``synchronize_rcu()`` in ``start_recovery()`` to guarantee that
+``do_something()`` never runs concurrently with ``recovery()``, but with
+little or no synchronization overhead in ``do_something_dlm()``.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Why is the ``synchronize_rcu()`` on line 28 needed?                   |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Without that extra grace period, memory reordering could result in    |
+| ``do_something_dlm()`` executing ``do_something()`` concurrently with |
+| the last bits of ``recovery()``.                                      |
++-----------------------------------------------------------------------+
+
+In order to avoid fatal problems such as deadlocks, an RCU read-side
+critical section must not contain calls to ``synchronize_rcu()``.
+Similarly, an RCU read-side critical section must not contain anything
+that waits, directly or indirectly, on completion of an invocation of
+``synchronize_rcu()``.
+
+Although RCU's grace-period guarantee is useful in and of itself, with
+`quite a few use cases <https://lwn.net/Articles/573497/>`__, it would
+be good to be able to use RCU to coordinate read-side access to linked
+data structures. For this, the grace-period guarantee is not sufficient,
+as can be seen in function ``add_gp_buggy()`` below. We will look at the
+reader's code later, but in the meantime, just think of the reader as
+locklessly picking up the ``gp`` pointer, and, if the value loaded is
+non-\ ``NULL``, locklessly accessing the ``->a`` and ``->b`` fields.
+
+   ::
+
+       1 bool add_gp_buggy(int a, int b)
+       2 {
+       3   p = kmalloc(sizeof(*p), GFP_KERNEL);
+       4   if (!p)
+       5     return -ENOMEM;
+       6   spin_lock(&gp_lock);
+       7   if (rcu_access_pointer(gp)) {
+       8     spin_unlock(&gp_lock);
+       9     return false;
+      10   }
+      11   p->a = a;
+      12   p->b = a;
+      13   gp = p; /* ORDERING BUG */
+      14   spin_unlock(&gp_lock);
+      15   return true;
+      16 }
+
+The problem is that both the compiler and weakly ordered CPUs are within
+their rights to reorder this code as follows:
+
+   ::
+
+       1 bool add_gp_buggy_optimized(int a, int b)
+       2 {
+       3   p = kmalloc(sizeof(*p), GFP_KERNEL);
+       4   if (!p)
+       5     return -ENOMEM;
+       6   spin_lock(&gp_lock);
+       7   if (rcu_access_pointer(gp)) {
+       8     spin_unlock(&gp_lock);
+       9     return false;
+      10   }
+      11   gp = p; /* ORDERING BUG */
+      12   p->a = a;
+      13   p->b = a;
+      14   spin_unlock(&gp_lock);
+      15   return true;
+      16 }
+
+If an RCU reader fetches ``gp`` just after ``add_gp_buggy_optimized``
+executes line 11, it will see garbage in the ``->a`` and ``->b`` fields.
+And this is but one of many ways in which compiler and hardware
+optimizations could cause trouble. Therefore, we clearly need some way
+to prevent the compiler and the CPU from reordering in this manner,
+which brings us to the publish-subscribe guarantee discussed in the next
+section.
+
+Publish/Subscribe Guarantee
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+RCU's publish-subscribe guarantee allows data to be inserted into a
+linked data structure without disrupting RCU readers. The updater uses
+``rcu_assign_pointer()`` to insert the new data, and readers use
+``rcu_dereference()`` to access data, whether new or old. The following
+shows an example of insertion:
+
+   ::
+
+       1 bool add_gp(int a, int b)
+       2 {
+       3   p = kmalloc(sizeof(*p), GFP_KERNEL);
+       4   if (!p)
+       5     return -ENOMEM;
+       6   spin_lock(&gp_lock);
+       7   if (rcu_access_pointer(gp)) {
+       8     spin_unlock(&gp_lock);
+       9     return false;
+      10   }
+      11   p->a = a;
+      12   p->b = a;
+      13   rcu_assign_pointer(gp, p);
+      14   spin_unlock(&gp_lock);
+      15   return true;
+      16 }
+
+The ``rcu_assign_pointer()`` on line 13 is conceptually equivalent to a
+simple assignment statement, but also guarantees that its assignment
+will happen after the two assignments in lines 11 and 12, similar to the
+C11 ``memory_order_release`` store operation. It also prevents any
+number of “interesting” compiler optimizations, for example, the use of
+``gp`` as a scratch location immediately preceding the assignment.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| But ``rcu_assign_pointer()`` does nothing to prevent the two          |
+| assignments to ``p->a`` and ``p->b`` from being reordered. Can't that |
+| also cause problems?                                                  |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| No, it cannot. The readers cannot see either of these two fields      |
+| until the assignment to ``gp``, by which time both fields are fully   |
+| initialized. So reordering the assignments to ``p->a`` and ``p->b``   |
+| cannot possibly cause any problems.                                   |
++-----------------------------------------------------------------------+
+
+It is tempting to assume that the reader need not do anything special to
+control its accesses to the RCU-protected data, as shown in
+``do_something_gp_buggy()`` below:
+
+   ::
+
+       1 bool do_something_gp_buggy(void)
+       2 {
+       3   rcu_read_lock();
+       4   p = gp;  /* OPTIMIZATIONS GALORE!!! */
+       5   if (p) {
+       6     do_something(p->a, p->b);
+       7     rcu_read_unlock();
+       8     return true;
+       9   }
+      10   rcu_read_unlock();
+      11   return false;
+      12 }
+
+However, this temptation must be resisted because there are a
+surprisingly large number of ways that the compiler (to say nothing of
+`DEC Alpha CPUs <https://h71000.www7.hp.com/wizard/wiz_2637.html>`__)
+can trip this code up. For but one example, if the compiler were short
+of registers, it might choose to refetch from ``gp`` rather than keeping
+a separate copy in ``p`` as follows:
+
+   ::
+
+       1 bool do_something_gp_buggy_optimized(void)
+       2 {
+       3   rcu_read_lock();
+       4   if (gp) { /* OPTIMIZATIONS GALORE!!! */
+       5     do_something(gp->a, gp->b);
+       6     rcu_read_unlock();
+       7     return true;
+       8   }
+       9   rcu_read_unlock();
+      10   return false;
+      11 }
+
+If this function ran concurrently with a series of updates that replaced
+the current structure with a new one, the fetches of ``gp->a`` and
+``gp->b`` might well come from two different structures, which could
+cause serious confusion. To prevent this (and much else besides),
+``do_something_gp()`` uses ``rcu_dereference()`` to fetch from ``gp``:
+
+   ::
+
+       1 bool do_something_gp(void)
+       2 {
+       3   rcu_read_lock();
+       4   p = rcu_dereference(gp);
+       5   if (p) {
+       6     do_something(p->a, p->b);
+       7     rcu_read_unlock();
+       8     return true;
+       9   }
+      10   rcu_read_unlock();
+      11   return false;
+      12 }
+
+The ``rcu_dereference()`` uses volatile casts and (for DEC Alpha) memory
+barriers in the Linux kernel. Should a `high-quality implementation of
+C11 ``memory_order_consume``
+[PDF] <http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf>`__
+ever appear, then ``rcu_dereference()`` could be implemented as a
+``memory_order_consume`` load. Regardless of the exact implementation, a
+pointer fetched by ``rcu_dereference()`` may not be used outside of the
+outermost RCU read-side critical section containing that
+``rcu_dereference()``, unless protection of the corresponding data
+element has been passed from RCU to some other synchronization
+mechanism, most commonly locking or `reference
+counting <https://www.kernel.org/doc/Documentation/RCU/rcuref.txt>`__.
+
+In short, updaters use ``rcu_assign_pointer()`` and readers use
+``rcu_dereference()``, and these two RCU API elements work together to
+ensure that readers have a consistent view of newly added data elements.
+
+Of course, it is also necessary to remove elements from RCU-protected
+data structures, for example, using the following process:
+
+#. Remove the data element from the enclosing structure.
+#. Wait for all pre-existing RCU read-side critical sections to complete
+   (because only pre-existing readers can possibly have a reference to
+   the newly removed data element).
+#. At this point, only the updater has a reference to the newly removed
+   data element, so it can safely reclaim the data element, for example,
+   by passing it to ``kfree()``.
+
+This process is implemented by ``remove_gp_synchronous()``:
+
+   ::
+
+       1 bool remove_gp_synchronous(void)
+       2 {
+       3   struct foo *p;
+       4
+       5   spin_lock(&gp_lock);
+       6   p = rcu_access_pointer(gp);
+       7   if (!p) {
+       8     spin_unlock(&gp_lock);
+       9     return false;
+      10   }
+      11   rcu_assign_pointer(gp, NULL);
+      12   spin_unlock(&gp_lock);
+      13   synchronize_rcu();
+      14   kfree(p);
+      15   return true;
+      16 }
+
+This function is straightforward, with line 13 waiting for a grace
+period before line 14 frees the old data element. This waiting ensures
+that readers will reach line 7 of ``do_something_gp()`` before the data
+element referenced by ``p`` is freed. The ``rcu_access_pointer()`` on
+line 6 is similar to ``rcu_dereference()``, except that:
+
+#. The value returned by ``rcu_access_pointer()`` cannot be
+   dereferenced. If you want to access the value pointed to as well as
+   the pointer itself, use ``rcu_dereference()`` instead of
+   ``rcu_access_pointer()``.
+#. The call to ``rcu_access_pointer()`` need not be protected. In
+   contrast, ``rcu_dereference()`` must either be within an RCU
+   read-side critical section or in a code segment where the pointer
+   cannot change, for example, in code protected by the corresponding
+   update-side lock.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Without the ``rcu_dereference()`` or the ``rcu_access_pointer()``,    |
+| what destructive optimizations might the compiler make use of?        |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Let's start with what happens to ``do_something_gp()`` if it fails to |
+| use ``rcu_dereference()``. It could reuse a value formerly fetched    |
+| from this same pointer. It could also fetch the pointer from ``gp``   |
+| in a byte-at-a-time manner, resulting in *load tearing*, in turn      |
+| resulting a bytewise mash-up of two distinct pointer values. It might |
+| even use value-speculation optimizations, where it makes a wrong      |
+| guess, but by the time it gets around to checking the value, an       |
+| update has changed the pointer to match the wrong guess. Too bad      |
+| about any dereferences that returned pre-initialization garbage in    |
+| the meantime!                                                         |
+| For ``remove_gp_synchronous()``, as long as all modifications to      |
+| ``gp`` are carried out while holding ``gp_lock``, the above           |
+| optimizations are harmless. However, ``sparse`` will complain if you  |
+| define ``gp`` with ``__rcu`` and then access it without using either  |
+| ``rcu_access_pointer()`` or ``rcu_dereference()``.                    |
++-----------------------------------------------------------------------+
+
+In short, RCU's publish-subscribe guarantee is provided by the
+combination of ``rcu_assign_pointer()`` and ``rcu_dereference()``. This
+guarantee allows data elements to be safely added to RCU-protected
+linked data structures without disrupting RCU readers. This guarantee
+can be used in combination with the grace-period guarantee to also allow
+data elements to be removed from RCU-protected linked data structures,
+again without disrupting RCU readers.
+
+This guarantee was only partially premeditated. DYNIX/ptx used an
+explicit memory barrier for publication, but had nothing resembling
+``rcu_dereference()`` for subscription, nor did it have anything
+resembling the ``smp_read_barrier_depends()`` that was later subsumed
+into ``rcu_dereference()`` and later still into ``READ_ONCE()``. The
+need for these operations made itself known quite suddenly at a
+late-1990s meeting with the DEC Alpha architects, back in the days when
+DEC was still a free-standing company. It took the Alpha architects a
+good hour to convince me that any sort of barrier would ever be needed,
+and it then took me a good *two* hours to convince them that their
+documentation did not make this point clear. More recent work with the C
+and C++ standards committees have provided much education on tricks and
+traps from the compiler. In short, compilers were much less tricky in
+the early 1990s, but in 2015, don't even think about omitting
+``rcu_dereference()``!
+
+Memory-Barrier Guarantees
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The previous section's simple linked-data-structure scenario clearly
+demonstrates the need for RCU's stringent memory-ordering guarantees on
+systems with more than one CPU:
+
+#. Each CPU that has an RCU read-side critical section that begins
+   before ``synchronize_rcu()`` starts is guaranteed to execute a full
+   memory barrier between the time that the RCU read-side critical
+   section ends and the time that ``synchronize_rcu()`` returns. Without
+   this guarantee, a pre-existing RCU read-side critical section might
+   hold a reference to the newly removed ``struct foo`` after the
+   ``kfree()`` on line 14 of ``remove_gp_synchronous()``.
+#. Each CPU that has an RCU read-side critical section that ends after
+   ``synchronize_rcu()`` returns is guaranteed to execute a full memory
+   barrier between the time that ``synchronize_rcu()`` begins and the
+   time that the RCU read-side critical section begins. Without this
+   guarantee, a later RCU read-side critical section running after the
+   ``kfree()`` on line 14 of ``remove_gp_synchronous()`` might later run
+   ``do_something_gp()`` and find the newly deleted ``struct foo``.
+#. If the task invoking ``synchronize_rcu()`` remains on a given CPU,
+   then that CPU is guaranteed to execute a full memory barrier sometime
+   during the execution of ``synchronize_rcu()``. This guarantee ensures
+   that the ``kfree()`` on line 14 of ``remove_gp_synchronous()`` really
+   does execute after the removal on line 11.
+#. If the task invoking ``synchronize_rcu()`` migrates among a group of
+   CPUs during that invocation, then each of the CPUs in that group is
+   guaranteed to execute a full memory barrier sometime during the
+   execution of ``synchronize_rcu()``. This guarantee also ensures that
+   the ``kfree()`` on line 14 of ``remove_gp_synchronous()`` really does
+   execute after the removal on line 11, but also in the case where the
+   thread executing the ``synchronize_rcu()`` migrates in the meantime.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Given that multiple CPUs can start RCU read-side critical sections at |
+| any time without any ordering whatsoever, how can RCU possibly tell   |
+| whether or not a given RCU read-side critical section starts before a |
+| given instance of ``synchronize_rcu()``?                              |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| If RCU cannot tell whether or not a given RCU read-side critical      |
+| section starts before a given instance of ``synchronize_rcu()``, then |
+| it must assume that the RCU read-side critical section started first. |
+| In other words, a given instance of ``synchronize_rcu()`` can avoid   |
+| waiting on a given RCU read-side critical section only if it can      |
+| prove that ``synchronize_rcu()`` started first.                       |
+| A related question is “When ``rcu_read_lock()`` doesn't generate any  |
+| code, why does it matter how it relates to a grace period?” The       |
+| answer is that it is not the relationship of ``rcu_read_lock()``      |
+| itself that is important, but rather the relationship of the code     |
+| within the enclosed RCU read-side critical section to the code        |
+| preceding and following the grace period. If we take this viewpoint,  |
+| then a given RCU read-side critical section begins before a given     |
+| grace period when some access preceding the grace period observes the |
+| effect of some access within the critical section, in which case none |
+| of the accesses within the critical section may observe the effects   |
+| of any access following the grace period.                             |
+|                                                                       |
+| As of late 2016, mathematical models of RCU take this viewpoint, for  |
+| example, see slides 62 and 63 of the `2016 LinuxCon                   |
+| EU <http://www2.rdrop.com/users/paulmck/scalability/paper/LinuxMM.201 |
+| 6.10.04c.LCE.pdf>`__                                                  |
+| presentation.                                                         |
++-----------------------------------------------------------------------+
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| The first and second guarantees require unbelievably strict ordering! |
+| Are all these memory barriers *really* required?                      |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Yes, they really are required. To see why the first guarantee is      |
+| required, consider the following sequence of events:                  |
+|                                                                       |
+| #. CPU 1: ``rcu_read_lock()``                                         |
+| #. CPU 1: ``q = rcu_dereference(gp); /* Very likely to return p. */`` |
+| #. CPU 0: ``list_del_rcu(p);``                                        |
+| #. CPU 0: ``synchronize_rcu()`` starts.                               |
+| #. CPU 1: ``do_something_with(q->a);``                                |
+|    ``/* No smp_mb(), so might happen after kfree(). */``              |
+| #. CPU 1: ``rcu_read_unlock()``                                       |
+| #. CPU 0: ``synchronize_rcu()`` returns.                              |
+| #. CPU 0: ``kfree(p);``                                               |
+|                                                                       |
+| Therefore, there absolutely must be a full memory barrier between the |
+| end of the RCU read-side critical section and the end of the grace    |
+| period.                                                               |
+|                                                                       |
+| The sequence of events demonstrating the necessity of the second rule |
+| is roughly similar:                                                   |
+|                                                                       |
+| #. CPU 0: ``list_del_rcu(p);``                                        |
+| #. CPU 0: ``synchronize_rcu()`` starts.                               |
+| #. CPU 1: ``rcu_read_lock()``                                         |
+| #. CPU 1: ``q = rcu_dereference(gp);``                                |
+|    ``/* Might return p if no memory barrier. */``                     |
+| #. CPU 0: ``synchronize_rcu()`` returns.                              |
+| #. CPU 0: ``kfree(p);``                                               |
+| #. CPU 1: ``do_something_with(q->a); /* Boom!!! */``                  |
+| #. CPU 1: ``rcu_read_unlock()``                                       |
+|                                                                       |
+| And similarly, without a memory barrier between the beginning of the  |
+| grace period and the beginning of the RCU read-side critical section, |
+| CPU 1 might end up accessing the freelist.                            |
+|                                                                       |
+| The “as if” rule of course applies, so that any implementation that   |
+| acts as if the appropriate memory barriers were in place is a correct |
+| implementation. That said, it is much easier to fool yourself into    |
+| believing that you have adhered to the as-if rule than it is to       |
+| actually adhere to it!                                                |
++-----------------------------------------------------------------------+
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| You claim that ``rcu_read_lock()`` and ``rcu_read_unlock()`` generate |
+| absolutely no code in some kernel builds. This means that the         |
+| compiler might arbitrarily rearrange consecutive RCU read-side        |
+| critical sections. Given such rearrangement, if a given RCU read-side |
+| critical section is done, how can you be sure that all prior RCU      |
+| read-side critical sections are done? Won't the compiler              |
+| rearrangements make that impossible to determine?                     |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| In cases where ``rcu_read_lock()`` and ``rcu_read_unlock()`` generate |
+| absolutely no code, RCU infers quiescent states only at special       |
+| locations, for example, within the scheduler. Because calls to        |
+| ``schedule()`` had better prevent calling-code accesses to shared     |
+| variables from being rearranged across the call to ``schedule()``, if |
+| RCU detects the end of a given RCU read-side critical section, it     |
+| will necessarily detect the end of all prior RCU read-side critical   |
+| sections, no matter how aggressively the compiler scrambles the code. |
+| Again, this all assumes that the compiler cannot scramble code across |
+| calls to the scheduler, out of interrupt handlers, into the idle      |
+| loop, into user-mode code, and so on. But if your kernel build allows |
+| that sort of scrambling, you have broken far more than just RCU!      |
++-----------------------------------------------------------------------+
+
+Note that these memory-barrier requirements do not replace the
+fundamental RCU requirement that a grace period wait for all
+pre-existing readers. On the contrary, the memory barriers called out in
+this section must operate in such a way as to *enforce* this fundamental
+requirement. Of course, different implementations enforce this
+requirement in different ways, but enforce it they must.
+
+RCU Primitives Guaranteed to Execute Unconditionally
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The common-case RCU primitives are unconditional. They are invoked, they
+do their job, and they return, with no possibility of error, and no need
+to retry. This is a key RCU design philosophy.
+
+However, this philosophy is pragmatic rather than pigheaded. If someone
+comes up with a good justification for a particular conditional RCU
+primitive, it might well be implemented and added. After all, this
+guarantee was reverse-engineered, not premeditated. The unconditional
+nature of the RCU primitives was initially an accident of
+implementation, and later experience with synchronization primitives
+with conditional primitives caused me to elevate this accident to a
+guarantee. Therefore, the justification for adding a conditional
+primitive to RCU would need to be based on detailed and compelling use
+cases.
+
+Guaranteed Read-to-Write Upgrade
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+As far as RCU is concerned, it is always possible to carry out an update
+within an RCU read-side critical section. For example, that RCU
+read-side critical section might search for a given data element, and
+then might acquire the update-side spinlock in order to update that
+element, all while remaining in that RCU read-side critical section. Of
+course, it is necessary to exit the RCU read-side critical section
+before invoking ``synchronize_rcu()``, however, this inconvenience can
+be avoided through use of the ``call_rcu()`` and ``kfree_rcu()`` API
+members described later in this document.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| But how does the upgrade-to-write operation exclude other readers?    |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| It doesn't, just like normal RCU updates, which also do not exclude   |
+| RCU readers.                                                          |
++-----------------------------------------------------------------------+
+
+This guarantee allows lookup code to be shared between read-side and
+update-side code, and was premeditated, appearing in the earliest
+DYNIX/ptx RCU documentation.
+
+Fundamental Non-Requirements
+----------------------------
+
+RCU provides extremely lightweight readers, and its read-side
+guarantees, though quite useful, are correspondingly lightweight. It is
+therefore all too easy to assume that RCU is guaranteeing more than it
+really is. Of course, the list of things that RCU does not guarantee is
+infinitely long, however, the following sections list a few
+non-guarantees that have caused confusion. Except where otherwise noted,
+these non-guarantees were premeditated.
+
+#. `Readers Impose Minimal
+   Ordering <#Readers%20Impose%20Minimal%20Ordering>`__
+#. `Readers Do Not Exclude
+   Updaters <#Readers%20Do%20Not%20Exclude%20Updaters>`__
+#. `Updaters Only Wait For Old
+   Readers <#Updaters%20Only%20Wait%20For%20Old%20Readers>`__
+#. `Grace Periods Don't Partition Read-Side Critical
+   Sections <#Grace%20Periods%20Don't%20Partition%20Read-Side%20Critical%20Sections>`__
+#. `Read-Side Critical Sections Don't Partition Grace
+   Periods <#Read-Side%20Critical%20Sections%20Don't%20Partition%20Grace%20Periods>`__
+
+Readers Impose Minimal Ordering
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Reader-side markers such as ``rcu_read_lock()`` and
+``rcu_read_unlock()`` provide absolutely no ordering guarantees except
+through their interaction with the grace-period APIs such as
+``synchronize_rcu()``. To see this, consider the following pair of
+threads:
+
+   ::
+
+       1 void thread0(void)
+       2 {
+       3   rcu_read_lock();
+       4   WRITE_ONCE(x, 1);
+       5   rcu_read_unlock();
+       6   rcu_read_lock();
+       7   WRITE_ONCE(y, 1);
+       8   rcu_read_unlock();
+       9 }
+      10
+      11 void thread1(void)
+      12 {
+      13   rcu_read_lock();
+      14   r1 = READ_ONCE(y);
+      15   rcu_read_unlock();
+      16   rcu_read_lock();
+      17   r2 = READ_ONCE(x);
+      18   rcu_read_unlock();
+      19 }
+
+After ``thread0()`` and ``thread1()`` execute concurrently, it is quite
+possible to have
+
+   ::
+
+      (r1 == 1 && r2 == 0)
+
+(that is, ``y`` appears to have been assigned before ``x``), which would
+not be possible if ``rcu_read_lock()`` and ``rcu_read_unlock()`` had
+much in the way of ordering properties. But they do not, so the CPU is
+within its rights to do significant reordering. This is by design: Any
+significant ordering constraints would slow down these fast-path APIs.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Can't the compiler also reorder this code?                            |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| No, the volatile casts in ``READ_ONCE()`` and ``WRITE_ONCE()``        |
+| prevent the compiler from reordering in this particular case.         |
++-----------------------------------------------------------------------+
+
+Readers Do Not Exclude Updaters
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Neither ``rcu_read_lock()`` nor ``rcu_read_unlock()`` exclude updates.
+All they do is to prevent grace periods from ending. The following
+example illustrates this:
+
+   ::
+
+       1 void thread0(void)
+       2 {
+       3   rcu_read_lock();
+       4   r1 = READ_ONCE(y);
+       5   if (r1) {
+       6     do_something_with_nonzero_x();
+       7     r2 = READ_ONCE(x);
+       8     WARN_ON(!r2); /* BUG!!! */
+       9   }
+      10   rcu_read_unlock();
+      11 }
+      12
+      13 void thread1(void)
+      14 {
+      15   spin_lock(&my_lock);
+      16   WRITE_ONCE(x, 1);
+      17   WRITE_ONCE(y, 1);
+      18   spin_unlock(&my_lock);
+      19 }
+
+If the ``thread0()`` function's ``rcu_read_lock()`` excluded the
+``thread1()`` function's update, the ``WARN_ON()`` could never fire. But
+the fact is that ``rcu_read_lock()`` does not exclude much of anything
+aside from subsequent grace periods, of which ``thread1()`` has none, so
+the ``WARN_ON()`` can and does fire.
+
+Updaters Only Wait For Old Readers
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+It might be tempting to assume that after ``synchronize_rcu()``
+completes, there are no readers executing. This temptation must be
+avoided because new readers can start immediately after
+``synchronize_rcu()`` starts, and ``synchronize_rcu()`` is under no
+obligation to wait for these new readers.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Suppose that synchronize_rcu() did wait until *all* readers had       |
+| completed instead of waiting only on pre-existing readers. For how    |
+| long would the updater be able to rely on there being no readers?     |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| For no time at all. Even if ``synchronize_rcu()`` were to wait until  |
+| all readers had completed, a new reader might start immediately after |
+| ``synchronize_rcu()`` completed. Therefore, the code following        |
+| ``synchronize_rcu()`` can *never* rely on there being no readers.     |
++-----------------------------------------------------------------------+
+
+Grace Periods Don't Partition Read-Side Critical Sections
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+It is tempting to assume that if any part of one RCU read-side critical
+section precedes a given grace period, and if any part of another RCU
+read-side critical section follows that same grace period, then all of
+the first RCU read-side critical section must precede all of the second.
+However, this just isn't the case: A single grace period does not
+partition the set of RCU read-side critical sections. An example of this
+situation can be illustrated as follows, where ``x``, ``y``, and ``z``
+are initially all zero:
+
+   ::
+
+       1 void thread0(void)
+       2 {
+       3   rcu_read_lock();
+       4   WRITE_ONCE(a, 1);
+       5   WRITE_ONCE(b, 1);
+       6   rcu_read_unlock();
+       7 }
+       8
+       9 void thread1(void)
+      10 {
+      11   r1 = READ_ONCE(a);
+      12   synchronize_rcu();
+      13   WRITE_ONCE(c, 1);
+      14 }
+      15
+      16 void thread2(void)
+      17 {
+      18   rcu_read_lock();
+      19   r2 = READ_ONCE(b);
+      20   r3 = READ_ONCE(c);
+      21   rcu_read_unlock();
+      22 }
+
+It turns out that the outcome:
+
+   ::
+
+      (r1 == 1 && r2 == 0 && r3 == 1)
+
+is entirely possible. The following figure show how this can happen,
+with each circled ``QS`` indicating the point at which RCU recorded a
+*quiescent state* for each thread, that is, a state in which RCU knows
+that the thread cannot be in the midst of an RCU read-side critical
+section that started before the current grace period:
+
+.. kernel-figure:: GPpartitionReaders1.svg
+
+If it is necessary to partition RCU read-side critical sections in this
+manner, it is necessary to use two grace periods, where the first grace
+period is known to end before the second grace period starts:
+
+   ::
+
+       1 void thread0(void)
+       2 {
+       3   rcu_read_lock();
+       4   WRITE_ONCE(a, 1);
+       5   WRITE_ONCE(b, 1);
+       6   rcu_read_unlock();
+       7 }
+       8
+       9 void thread1(void)
+      10 {
+      11   r1 = READ_ONCE(a);
+      12   synchronize_rcu();
+      13   WRITE_ONCE(c, 1);
+      14 }
+      15
+      16 void thread2(void)
+      17 {
+      18   r2 = READ_ONCE(c);
+      19   synchronize_rcu();
+      20   WRITE_ONCE(d, 1);
+      21 }
+      22
+      23 void thread3(void)
+      24 {
+      25   rcu_read_lock();
+      26   r3 = READ_ONCE(b);
+      27   r4 = READ_ONCE(d);
+      28   rcu_read_unlock();
+      29 }
+
+Here, if ``(r1 == 1)``, then ``thread0()``'s write to ``b`` must happen
+before the end of ``thread1()``'s grace period. If in addition
+``(r4 == 1)``, then ``thread3()``'s read from ``b`` must happen after
+the beginning of ``thread2()``'s grace period. If it is also the case
+that ``(r2 == 1)``, then the end of ``thread1()``'s grace period must
+precede the beginning of ``thread2()``'s grace period. This mean that
+the two RCU read-side critical sections cannot overlap, guaranteeing
+that ``(r3 == 1)``. As a result, the outcome:
+
+   ::
+
+      (r1 == 1 && r2 == 1 && r3 == 0 && r4 == 1)
+
+cannot happen.
+
+This non-requirement was also non-premeditated, but became apparent when
+studying RCU's interaction with memory ordering.
+
+Read-Side Critical Sections Don't Partition Grace Periods
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+It is also tempting to assume that if an RCU read-side critical section
+happens between a pair of grace periods, then those grace periods cannot
+overlap. However, this temptation leads nowhere good, as can be
+illustrated by the following, with all variables initially zero:
+
+   ::
+
+       1 void thread0(void)
+       2 {
+       3   rcu_read_lock();
+       4   WRITE_ONCE(a, 1);
+       5   WRITE_ONCE(b, 1);
+       6   rcu_read_unlock();
+       7 }
+       8
+       9 void thread1(void)
+      10 {
+      11   r1 = READ_ONCE(a);
+      12   synchronize_rcu();
+      13   WRITE_ONCE(c, 1);
+      14 }
+      15
+      16 void thread2(void)
+      17 {
+      18   rcu_read_lock();
+      19   WRITE_ONCE(d, 1);
+      20   r2 = READ_ONCE(c);
+      21   rcu_read_unlock();
+      22 }
+      23
+      24 void thread3(void)
+      25 {
+      26   r3 = READ_ONCE(d);
+      27   synchronize_rcu();
+      28   WRITE_ONCE(e, 1);
+      29 }
+      30
+      31 void thread4(void)
+      32 {
+      33   rcu_read_lock();
+      34   r4 = READ_ONCE(b);
+      35   r5 = READ_ONCE(e);
+      36   rcu_read_unlock();
+      37 }
+
+In this case, the outcome:
+
+   ::
+
+      (r1 == 1 && r2 == 1 && r3 == 1 && r4 == 0 && r5 == 1)
+
+is entirely possible, as illustrated below:
+
+.. kernel-figure:: ReadersPartitionGP1.svg
+
+Again, an RCU read-side critical section can overlap almost all of a
+given grace period, just so long as it does not overlap the entire grace
+period. As a result, an RCU read-side critical section cannot partition
+a pair of RCU grace periods.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| How long a sequence of grace periods, each separated by an RCU        |
+| read-side critical section, would be required to partition the RCU    |
+| read-side critical sections at the beginning and end of the chain?    |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| In theory, an infinite number. In practice, an unknown number that is |
+| sensitive to both implementation details and timing considerations.   |
+| Therefore, even in practice, RCU users must abide by the theoretical  |
+| rather than the practical answer.                                     |
++-----------------------------------------------------------------------+
+
+Parallelism Facts of Life
+-------------------------
+
+These parallelism facts of life are by no means specific to RCU, but the
+RCU implementation must abide by them. They therefore bear repeating:
+
+#. Any CPU or task may be delayed at any time, and any attempts to avoid
+   these delays by disabling preemption, interrupts, or whatever are
+   completely futile. This is most obvious in preemptible user-level
+   environments and in virtualized environments (where a given guest
+   OS's VCPUs can be preempted at any time by the underlying
+   hypervisor), but can also happen in bare-metal environments due to
+   ECC errors, NMIs, and other hardware events. Although a delay of more
+   than about 20 seconds can result in splats, the RCU implementation is
+   obligated to use algorithms that can tolerate extremely long delays,
+   but where “extremely long” is not long enough to allow wrap-around
+   when incrementing a 64-bit counter.
+#. Both the compiler and the CPU can reorder memory accesses. Where it
+   matters, RCU must use compiler directives and memory-barrier
+   instructions to preserve ordering.
+#. Conflicting writes to memory locations in any given cache line will
+   result in expensive cache misses. Greater numbers of concurrent
+   writes and more-frequent concurrent writes will result in more
+   dramatic slowdowns. RCU is therefore obligated to use algorithms that
+   have sufficient locality to avoid significant performance and
+   scalability problems.
+#. As a rough rule of thumb, only one CPU's worth of processing may be
+   carried out under the protection of any given exclusive lock. RCU
+   must therefore use scalable locking designs.
+#. Counters are finite, especially on 32-bit systems. RCU's use of
+   counters must therefore tolerate counter wrap, or be designed such
+   that counter wrap would take way more time than a single system is
+   likely to run. An uptime of ten years is quite possible, a runtime of
+   a century much less so. As an example of the latter, RCU's
+   dyntick-idle nesting counter allows 54 bits for interrupt nesting
+   level (this counter is 64 bits even on a 32-bit system). Overflowing
+   this counter requires 2\ :sup:`54` half-interrupts on a given CPU
+   without that CPU ever going idle. If a half-interrupt happened every
+   microsecond, it would take 570 years of runtime to overflow this
+   counter, which is currently believed to be an acceptably long time.
+#. Linux systems can have thousands of CPUs running a single Linux
+   kernel in a single shared-memory environment. RCU must therefore pay
+   close attention to high-end scalability.
+
+This last parallelism fact of life means that RCU must pay special
+attention to the preceding facts of life. The idea that Linux might
+scale to systems with thousands of CPUs would have been met with some
+skepticism in the 1990s, but these requirements would have otherwise
+have been unsurprising, even in the early 1990s.
+
+Quality-of-Implementation Requirements
+--------------------------------------
+
+These sections list quality-of-implementation requirements. Although an
+RCU implementation that ignores these requirements could still be used,
+it would likely be subject to limitations that would make it
+inappropriate for industrial-strength production use. Classes of
+quality-of-implementation requirements are as follows:
+
+#. `Specialization <#Specialization>`__
+#. `Performance and Scalability <#Performance%20and%20Scalability>`__
+#. `Forward Progress <#Forward%20Progress>`__
+#. `Composability <#Composability>`__
+#. `Corner Cases <#Corner%20Cases>`__
+
+These classes is covered in the following sections.
+
+Specialization
+~~~~~~~~~~~~~~
+
+RCU is and always has been intended primarily for read-mostly
+situations, which means that RCU's read-side primitives are optimized,
+often at the expense of its update-side primitives. Experience thus far
+is captured by the following list of situations:
+
+#. Read-mostly data, where stale and inconsistent data is not a problem:
+   RCU works great!
+#. Read-mostly data, where data must be consistent: RCU works well.
+#. Read-write data, where data must be consistent: RCU *might* work OK.
+   Or not.
+#. Write-mostly data, where data must be consistent: RCU is very
+   unlikely to be the right tool for the job, with the following
+   exceptions, where RCU can provide:
+
+   a. Existence guarantees for update-friendly mechanisms.
+   b. Wait-free read-side primitives for real-time use.
+
+This focus on read-mostly situations means that RCU must interoperate
+with other synchronization primitives. For example, the ``add_gp()`` and
+``remove_gp_synchronous()`` examples discussed earlier use RCU to
+protect readers and locking to coordinate updaters. However, the need
+extends much farther, requiring that a variety of synchronization
+primitives be legal within RCU read-side critical sections, including
+spinlocks, sequence locks, atomic operations, reference counters, and
+memory barriers.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| What about sleeping locks?                                            |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| These are forbidden within Linux-kernel RCU read-side critical        |
+| sections because it is not legal to place a quiescent state (in this  |
+| case, voluntary context switch) within an RCU read-side critical      |
+| section. However, sleeping locks may be used within userspace RCU     |
+| read-side critical sections, and also within Linux-kernel sleepable   |
+| RCU `(SRCU) <#Sleepable%20RCU>`__ read-side critical sections. In     |
+| addition, the -rt patchset turns spinlocks into a sleeping locks so   |
+| that the corresponding critical sections can be preempted, which also |
+| means that these sleeplockified spinlocks (but not other sleeping     |
+| locks!) may be acquire within -rt-Linux-kernel RCU read-side critical |
+| sections.                                                             |
+| Note that it *is* legal for a normal RCU read-side critical section   |
+| to conditionally acquire a sleeping locks (as in                      |
+| ``mutex_trylock()``), but only as long as it does not loop            |
+| indefinitely attempting to conditionally acquire that sleeping locks. |
+| The key point is that things like ``mutex_trylock()`` either return   |
+| with the mutex held, or return an error indication if the mutex was   |
+| not immediately available. Either way, ``mutex_trylock()`` returns    |
+| immediately without sleeping.                                         |
++-----------------------------------------------------------------------+
+
+It often comes as a surprise that many algorithms do not require a
+consistent view of data, but many can function in that mode, with
+network routing being the poster child. Internet routing algorithms take
+significant time to propagate updates, so that by the time an update
+arrives at a given system, that system has been sending network traffic
+the wrong way for a considerable length of time. Having a few threads
+continue to send traffic the wrong way for a few more milliseconds is
+clearly not a problem: In the worst case, TCP retransmissions will
+eventually get the data where it needs to go. In general, when tracking
+the state of the universe outside of the computer, some level of
+inconsistency must be tolerated due to speed-of-light delays if nothing
+else.
+
+Furthermore, uncertainty about external state is inherent in many cases.
+For example, a pair of veterinarians might use heartbeat to determine
+whether or not a given cat was alive. But how long should they wait
+after the last heartbeat to decide that the cat is in fact dead? Waiting
+less than 400 milliseconds makes no sense because this would mean that a
+relaxed cat would be considered to cycle between death and life more
+than 100 times per minute. Moreover, just as with human beings, a cat's
+heart might stop for some period of time, so the exact wait period is a
+judgment call. One of our pair of veterinarians might wait 30 seconds
+before pronouncing the cat dead, while the other might insist on waiting
+a full minute. The two veterinarians would then disagree on the state of
+the cat during the final 30 seconds of the minute following the last
+heartbeat.
+
+Interestingly enough, this same situation applies to hardware. When push
+comes to shove, how do we tell whether or not some external server has
+failed? We send messages to it periodically, and declare it failed if we
+don't receive a response within a given period of time. Policy decisions
+can usually tolerate short periods of inconsistency. The policy was
+decided some time ago, and is only now being put into effect, so a few
+milliseconds of delay is normally inconsequential.
+
+However, there are algorithms that absolutely must see consistent data.
+For example, the translation between a user-level SystemV semaphore ID
+to the corresponding in-kernel data structure is protected by RCU, but
+it is absolutely forbidden to update a semaphore that has just been
+removed. In the Linux kernel, this need for consistency is accommodated
+by acquiring spinlocks located in the in-kernel data structure from
+within the RCU read-side critical section, and this is indicated by the
+green box in the figure above. Many other techniques may be used, and
+are in fact used within the Linux kernel.
+
+In short, RCU is not required to maintain consistency, and other
+mechanisms may be used in concert with RCU when consistency is required.
+RCU's specialization allows it to do its job extremely well, and its
+ability to interoperate with other synchronization mechanisms allows the
+right mix of synchronization tools to be used for a given job.
+
+Performance and Scalability
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Energy efficiency is a critical component of performance today, and
+Linux-kernel RCU implementations must therefore avoid unnecessarily
+awakening idle CPUs. I cannot claim that this requirement was
+premeditated. In fact, I learned of it during a telephone conversation
+in which I was given “frank and open” feedback on the importance of
+energy efficiency in battery-powered systems and on specific
+energy-efficiency shortcomings of the Linux-kernel RCU implementation.
+In my experience, the battery-powered embedded community will consider
+any unnecessary wakeups to be extremely unfriendly acts. So much so that
+mere Linux-kernel-mailing-list posts are insufficient to vent their ire.
+
+Memory consumption is not particularly important for in most situations,
+and has become decreasingly so as memory sizes have expanded and memory
+costs have plummeted. However, as I learned from Matt Mackall's
+`bloatwatch <http://elinux.org/Linux_Tiny-FAQ>`__ efforts, memory
+footprint is critically important on single-CPU systems with
+non-preemptible (``CONFIG_PREEMPT=n``) kernels, and thus `tiny
+RCU <https://lkml.kernel.org/g/20090113221724.GA15307@linux.vnet.ibm.com>`__
+was born. Josh Triplett has since taken over the small-memory banner
+with his `Linux kernel tinification <https://tiny.wiki.kernel.org/>`__
+project, which resulted in `SRCU <#Sleepable%20RCU>`__ becoming optional
+for those kernels not needing it.
+
+The remaining performance requirements are, for the most part,
+unsurprising. For example, in keeping with RCU's read-side
+specialization, ``rcu_dereference()`` should have negligible overhead
+(for example, suppression of a few minor compiler optimizations).
+Similarly, in non-preemptible environments, ``rcu_read_lock()`` and
+``rcu_read_unlock()`` should have exactly zero overhead.
+
+In preemptible environments, in the case where the RCU read-side
+critical section was not preempted (as will be the case for the
+highest-priority real-time process), ``rcu_read_lock()`` and
+``rcu_read_unlock()`` should have minimal overhead. In particular, they
+should not contain atomic read-modify-write operations, memory-barrier
+instructions, preemption disabling, interrupt disabling, or backwards
+branches. However, in the case where the RCU read-side critical section
+was preempted, ``rcu_read_unlock()`` may acquire spinlocks and disable
+interrupts. This is why it is better to nest an RCU read-side critical
+section within a preempt-disable region than vice versa, at least in
+cases where that critical section is short enough to avoid unduly
+degrading real-time latencies.
+
+The ``synchronize_rcu()`` grace-period-wait primitive is optimized for
+throughput. It may therefore incur several milliseconds of latency in
+addition to the duration of the longest RCU read-side critical section.
+On the other hand, multiple concurrent invocations of
+``synchronize_rcu()`` are required to use batching optimizations so that
+they can be satisfied by a single underlying grace-period-wait
+operation. For example, in the Linux kernel, it is not unusual for a
+single grace-period-wait operation to serve more than `1,000 separate
+invocations <https://www.usenix.org/conference/2004-usenix-annual-technical-conference/making-rcu-safe-deep-sub-millisecond-response>`__
+of ``synchronize_rcu()``, thus amortizing the per-invocation overhead
+down to nearly zero. However, the grace-period optimization is also
+required to avoid measurable degradation of real-time scheduling and
+interrupt latencies.
+
+In some cases, the multi-millisecond ``synchronize_rcu()`` latencies are
+unacceptable. In these cases, ``synchronize_rcu_expedited()`` may be
+used instead, reducing the grace-period latency down to a few tens of
+microseconds on small systems, at least in cases where the RCU read-side
+critical sections are short. There are currently no special latency
+requirements for ``synchronize_rcu_expedited()`` on large systems, but,
+consistent with the empirical nature of the RCU specification, that is
+subject to change. However, there most definitely are scalability
+requirements: A storm of ``synchronize_rcu_expedited()`` invocations on
+4096 CPUs should at least make reasonable forward progress. In return
+for its shorter latencies, ``synchronize_rcu_expedited()`` is permitted
+to impose modest degradation of real-time latency on non-idle online
+CPUs. Here, “modest” means roughly the same latency degradation as a
+scheduling-clock interrupt.
+
+There are a number of situations where even
+``synchronize_rcu_expedited()``'s reduced grace-period latency is
+unacceptable. In these situations, the asynchronous ``call_rcu()`` can
+be used in place of ``synchronize_rcu()`` as follows:
+
+   ::
+
+       1 struct foo {
+       2   int a;
+       3   int b;
+       4   struct rcu_head rh;
+       5 };
+       6
+       7 static void remove_gp_cb(struct rcu_head *rhp)
+       8 {
+       9   struct foo *p = container_of(rhp, struct foo, rh);
+      10
+      11   kfree(p);
+      12 }
+      13
+      14 bool remove_gp_asynchronous(void)
+      15 {
+      16   struct foo *p;
+      17
+      18   spin_lock(&gp_lock);
+      19   p = rcu_access_pointer(gp);
+      20   if (!p) {
+      21     spin_unlock(&gp_lock);
+      22     return false;
+      23   }
+      24   rcu_assign_pointer(gp, NULL);
+      25   call_rcu(&p->rh, remove_gp_cb);
+      26   spin_unlock(&gp_lock);
+      27   return true;
+      28 }
+
+A definition of ``struct foo`` is finally needed, and appears on
+lines 1-5. The function ``remove_gp_cb()`` is passed to ``call_rcu()``
+on line 25, and will be invoked after the end of a subsequent grace
+period. This gets the same effect as ``remove_gp_synchronous()``, but
+without forcing the updater to wait for a grace period to elapse. The
+``call_rcu()`` function may be used in a number of situations where
+neither ``synchronize_rcu()`` nor ``synchronize_rcu_expedited()`` would
+be legal, including within preempt-disable code, ``local_bh_disable()``
+code, interrupt-disable code, and interrupt handlers. However, even
+``call_rcu()`` is illegal within NMI handlers and from idle and offline
+CPUs. The callback function (``remove_gp_cb()`` in this case) will be
+executed within softirq (software interrupt) environment within the
+Linux kernel, either within a real softirq handler or under the
+protection of ``local_bh_disable()``. In both the Linux kernel and in
+userspace, it is bad practice to write an RCU callback function that
+takes too long. Long-running operations should be relegated to separate
+threads or (in the Linux kernel) workqueues.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Why does line 19 use ``rcu_access_pointer()``? After all,             |
+| ``call_rcu()`` on line 25 stores into the structure, which would      |
+| interact badly with concurrent insertions. Doesn't this mean that     |
+| ``rcu_dereference()`` is required?                                    |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Presumably the ``->gp_lock`` acquired on line 18 excludes any         |
+| changes, including any insertions that ``rcu_dereference()`` would    |
+| protect against. Therefore, any insertions will be delayed until      |
+| after ``->gp_lock`` is released on line 25, which in turn means that  |
+| ``rcu_access_pointer()`` suffices.                                    |
++-----------------------------------------------------------------------+
+
+However, all that ``remove_gp_cb()`` is doing is invoking ``kfree()`` on
+the data element. This is a common idiom, and is supported by
+``kfree_rcu()``, which allows “fire and forget” operation as shown
+below:
+
+   ::
+
+       1 struct foo {
+       2   int a;
+       3   int b;
+       4   struct rcu_head rh;
+       5 };
+       6
+       7 bool remove_gp_faf(void)
+       8 {
+       9   struct foo *p;
+      10
+      11   spin_lock(&gp_lock);
+      12   p = rcu_dereference(gp);
+      13   if (!p) {
+      14     spin_unlock(&gp_lock);
+      15     return false;
+      16   }
+      17   rcu_assign_pointer(gp, NULL);
+      18   kfree_rcu(p, rh);
+      19   spin_unlock(&gp_lock);
+      20   return true;
+      21 }
+
+Note that ``remove_gp_faf()`` simply invokes ``kfree_rcu()`` and
+proceeds, without any need to pay any further attention to the
+subsequent grace period and ``kfree()``. It is permissible to invoke
+``kfree_rcu()`` from the same environments as for ``call_rcu()``.
+Interestingly enough, DYNIX/ptx had the equivalents of ``call_rcu()``
+and ``kfree_rcu()``, but not ``synchronize_rcu()``. This was due to the
+fact that RCU was not heavily used within DYNIX/ptx, so the very few
+places that needed something like ``synchronize_rcu()`` simply
+open-coded it.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Earlier it was claimed that ``call_rcu()`` and ``kfree_rcu()``        |
+| allowed updaters to avoid being blocked by readers. But how can that  |
+| be correct, given that the invocation of the callback and the freeing |
+| of the memory (respectively) must still wait for a grace period to    |
+| elapse?                                                               |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| We could define things this way, but keep in mind that this sort of   |
+| definition would say that updates in garbage-collected languages      |
+| cannot complete until the next time the garbage collector runs, which |
+| does not seem at all reasonable. The key point is that in most cases, |
+| an updater using either ``call_rcu()`` or ``kfree_rcu()`` can proceed |
+| to the next update as soon as it has invoked ``call_rcu()`` or        |
+| ``kfree_rcu()``, without having to wait for a subsequent grace        |
+| period.                                                               |
++-----------------------------------------------------------------------+
+
+But what if the updater must wait for the completion of code to be
+executed after the end of the grace period, but has other tasks that can
+be carried out in the meantime? The polling-style
+``get_state_synchronize_rcu()`` and ``cond_synchronize_rcu()`` functions
+may be used for this purpose, as shown below:
+
+   ::
+
+       1 bool remove_gp_poll(void)
+       2 {
+       3   struct foo *p;
+       4   unsigned long s;
+       5
+       6   spin_lock(&gp_lock);
+       7   p = rcu_access_pointer(gp);
+       8   if (!p) {
+       9     spin_unlock(&gp_lock);
+      10     return false;
+      11   }
+      12   rcu_assign_pointer(gp, NULL);
+      13   spin_unlock(&gp_lock);
+      14   s = get_state_synchronize_rcu();
+      15   do_something_while_waiting();
+      16   cond_synchronize_rcu(s);
+      17   kfree(p);
+      18   return true;
+      19 }
+
+On line 14, ``get_state_synchronize_rcu()`` obtains a “cookie” from RCU,
+then line 15 carries out other tasks, and finally, line 16 returns
+immediately if a grace period has elapsed in the meantime, but otherwise
+waits as required. The need for ``get_state_synchronize_rcu`` and
+``cond_synchronize_rcu()`` has appeared quite recently, so it is too
+early to tell whether they will stand the test of time.
+
+RCU thus provides a range of tools to allow updaters to strike the
+required tradeoff between latency, flexibility and CPU overhead.
+
+Forward Progress
+~~~~~~~~~~~~~~~~
+
+In theory, delaying grace-period completion and callback invocation is
+harmless. In practice, not only are memory sizes finite but also
+callbacks sometimes do wakeups, and sufficiently deferred wakeups can be
+difficult to distinguish from system hangs. Therefore, RCU must provide
+a number of mechanisms to promote forward progress.
+
+These mechanisms are not foolproof, nor can they be. For one simple
+example, an infinite loop in an RCU read-side critical section must by
+definition prevent later grace periods from ever completing. For a more
+involved example, consider a 64-CPU system built with
+``CONFIG_RCU_NOCB_CPU=y`` and booted with ``rcu_nocbs=1-63``, where
+CPUs 1 through 63 spin in tight loops that invoke ``call_rcu()``. Even
+if these tight loops also contain calls to ``cond_resched()`` (thus
+allowing grace periods to complete), CPU 0 simply will not be able to
+invoke callbacks as fast as the other 63 CPUs can register them, at
+least not until the system runs out of memory. In both of these
+examples, the Spiderman principle applies: With great power comes great
+responsibility. However, short of this level of abuse, RCU is required
+to ensure timely completion of grace periods and timely invocation of
+callbacks.
+
+RCU takes the following steps to encourage timely completion of grace
+periods:
+
+#. If a grace period fails to complete within 100 milliseconds, RCU
+   causes future invocations of ``cond_resched()`` on the holdout CPUs
+   to provide an RCU quiescent state. RCU also causes those CPUs'
+   ``need_resched()`` invocations to return ``true``, but only after the
+   corresponding CPU's next scheduling-clock.
+#. CPUs mentioned in the ``nohz_full`` kernel boot parameter can run
+   indefinitely in the kernel without scheduling-clock interrupts, which
+   defeats the above ``need_resched()`` strategem. RCU will therefore
+   invoke ``resched_cpu()`` on any ``nohz_full`` CPUs still holding out
+   after 109 milliseconds.
+#. In kernels built with ``CONFIG_RCU_BOOST=y``, if a given task that
+   has been preempted within an RCU read-side critical section is
+   holding out for more than 500 milliseconds, RCU will resort to
+   priority boosting.
+#. If a CPU is still holding out 10 seconds into the grace period, RCU
+   will invoke ``resched_cpu()`` on it regardless of its ``nohz_full``
+   state.
+
+The above values are defaults for systems running with ``HZ=1000``. They
+will vary as the value of ``HZ`` varies, and can also be changed using
+the relevant Kconfig options and kernel boot parameters. RCU currently
+does not do much sanity checking of these parameters, so please use
+caution when changing them. Note that these forward-progress measures
+are provided only for RCU, not for `SRCU <#Sleepable%20RCU>`__ or `Tasks
+RCU <#Tasks%20RCU>`__.
+
+RCU takes the following steps in ``call_rcu()`` to encourage timely
+invocation of callbacks when any given non-\ ``rcu_nocbs`` CPU has
+10,000 callbacks, or has 10,000 more callbacks than it had the last time
+encouragement was provided:
+
+#. Starts a grace period, if one is not already in progress.
+#. Forces immediate checking for quiescent states, rather than waiting
+   for three milliseconds to have elapsed since the beginning of the
+   grace period.
+#. Immediately tags the CPU's callbacks with their grace period
+   completion numbers, rather than waiting for the ``RCU_SOFTIRQ``
+   handler to get around to it.
+#. Lifts callback-execution batch limits, which speeds up callback
+   invocation at the expense of degrading realtime response.
+
+Again, these are default values when running at ``HZ=1000``, and can be
+overridden. Again, these forward-progress measures are provided only for
+RCU, not for `SRCU <#Sleepable%20RCU>`__ or `Tasks
+RCU <#Tasks%20RCU>`__. Even for RCU, callback-invocation forward
+progress for ``rcu_nocbs`` CPUs is much less well-developed, in part
+because workloads benefiting from ``rcu_nocbs`` CPUs tend to invoke
+``call_rcu()`` relatively infrequently. If workloads emerge that need
+both ``rcu_nocbs`` CPUs and high ``call_rcu()`` invocation rates, then
+additional forward-progress work will be required.
+
+Composability
+~~~~~~~~~~~~~
+
+Composability has received much attention in recent years, perhaps in
+part due to the collision of multicore hardware with object-oriented
+techniques designed in single-threaded environments for single-threaded
+use. And in theory, RCU read-side critical sections may be composed, and
+in fact may be nested arbitrarily deeply. In practice, as with all
+real-world implementations of composable constructs, there are
+limitations.
+
+Implementations of RCU for which ``rcu_read_lock()`` and
+``rcu_read_unlock()`` generate no code, such as Linux-kernel RCU when
+``CONFIG_PREEMPT=n``, can be nested arbitrarily deeply. After all, there
+is no overhead. Except that if all these instances of
+``rcu_read_lock()`` and ``rcu_read_unlock()`` are visible to the
+compiler, compilation will eventually fail due to exhausting memory,
+mass storage, or user patience, whichever comes first. If the nesting is
+not visible to the compiler, as is the case with mutually recursive
+functions each in its own translation unit, stack overflow will result.
+If the nesting takes the form of loops, perhaps in the guise of tail
+recursion, either the control variable will overflow or (in the Linux
+kernel) you will get an RCU CPU stall warning. Nevertheless, this class
+of RCU implementations is one of the most composable constructs in
+existence.
+
+RCU implementations that explicitly track nesting depth are limited by
+the nesting-depth counter. For example, the Linux kernel's preemptible
+RCU limits nesting to ``INT_MAX``. This should suffice for almost all
+practical purposes. That said, a consecutive pair of RCU read-side
+critical sections between which there is an operation that waits for a
+grace period cannot be enclosed in another RCU read-side critical
+section. This is because it is not legal to wait for a grace period
+within an RCU read-side critical section: To do so would result either
+in deadlock or in RCU implicitly splitting the enclosing RCU read-side
+critical section, neither of which is conducive to a long-lived and
+prosperous kernel.
+
+It is worth noting that RCU is not alone in limiting composability. For
+example, many transactional-memory implementations prohibit composing a
+pair of transactions separated by an irrevocable operation (for example,
+a network receive operation). For another example, lock-based critical
+sections can be composed surprisingly freely, but only if deadlock is
+avoided.
+
+In short, although RCU read-side critical sections are highly
+composable, care is required in some situations, just as is the case for
+any other composable synchronization mechanism.
+
+Corner Cases
+~~~~~~~~~~~~
+
+A given RCU workload might have an endless and intense stream of RCU
+read-side critical sections, perhaps even so intense that there was
+never a point in time during which there was not at least one RCU
+read-side critical section in flight. RCU cannot allow this situation to
+block grace periods: As long as all the RCU read-side critical sections
+are finite, grace periods must also be finite.
+
+That said, preemptible RCU implementations could potentially result in
+RCU read-side critical sections being preempted for long durations,
+which has the effect of creating a long-duration RCU read-side critical
+section. This situation can arise only in heavily loaded systems, but
+systems using real-time priorities are of course more vulnerable.
+Therefore, RCU priority boosting is provided to help deal with this
+case. That said, the exact requirements on RCU priority boosting will
+likely evolve as more experience accumulates.
+
+Other workloads might have very high update rates. Although one can
+argue that such workloads should instead use something other than RCU,
+the fact remains that RCU must handle such workloads gracefully. This
+requirement is another factor driving batching of grace periods, but it
+is also the driving force behind the checks for large numbers of queued
+RCU callbacks in the ``call_rcu()`` code path. Finally, high update
+rates should not delay RCU read-side critical sections, although some
+small read-side delays can occur when using
+``synchronize_rcu_expedited()``, courtesy of this function's use of
+``smp_call_function_single()``.
+
+Although all three of these corner cases were understood in the early
+1990s, a simple user-level test consisting of ``close(open(path))`` in a
+tight loop in the early 2000s suddenly provided a much deeper
+appreciation of the high-update-rate corner case. This test also
+motivated addition of some RCU code to react to high update rates, for
+example, if a given CPU finds itself with more than 10,000 RCU callbacks
+queued, it will cause RCU to take evasive action by more aggressively
+starting grace periods and more aggressively forcing completion of
+grace-period processing. This evasive action causes the grace period to
+complete more quickly, but at the cost of restricting RCU's batching
+optimizations, thus increasing the CPU overhead incurred by that grace
+period.
+
+Software-Engineering Requirements
+---------------------------------
+
+Between Murphy's Law and “To err is human”, it is necessary to guard
+against mishaps and misuse:
+
+#. It is all too easy to forget to use ``rcu_read_lock()`` everywhere
+   that it is needed, so kernels built with ``CONFIG_PROVE_RCU=y`` will
+   splat if ``rcu_dereference()`` is used outside of an RCU read-side
+   critical section. Update-side code can use
+   ``rcu_dereference_protected()``, which takes a `lockdep
+   expression <https://lwn.net/Articles/371986/>`__ to indicate what is
+   providing the protection. If the indicated protection is not
+   provided, a lockdep splat is emitted.
+   Code shared between readers and updaters can use
+   ``rcu_dereference_check()``, which also takes a lockdep expression,
+   and emits a lockdep splat if neither ``rcu_read_lock()`` nor the
+   indicated protection is in place. In addition,
+   ``rcu_dereference_raw()`` is used in those (hopefully rare) cases
+   where the required protection cannot be easily described. Finally,
+   ``rcu_read_lock_held()`` is provided to allow a function to verify
+   that it has been invoked within an RCU read-side critical section. I
+   was made aware of this set of requirements shortly after Thomas
+   Gleixner audited a number of RCU uses.
+#. A given function might wish to check for RCU-related preconditions
+   upon entry, before using any other RCU API. The
+   ``rcu_lockdep_assert()`` does this job, asserting the expression in
+   kernels having lockdep enabled and doing nothing otherwise.
+#. It is also easy to forget to use ``rcu_assign_pointer()`` and
+   ``rcu_dereference()``, perhaps (incorrectly) substituting a simple
+   assignment. To catch this sort of error, a given RCU-protected
+   pointer may be tagged with ``__rcu``, after which sparse will
+   complain about simple-assignment accesses to that pointer. Arnd
+   Bergmann made me aware of this requirement, and also supplied the
+   needed `patch series <https://lwn.net/Articles/376011/>`__.
+#. Kernels built with ``CONFIG_DEBUG_OBJECTS_RCU_HEAD=y`` will splat if
+   a data element is passed to ``call_rcu()`` twice in a row, without a
+   grace period in between. (This error is similar to a double free.)
+   The corresponding ``rcu_head`` structures that are dynamically
+   allocated are automatically tracked, but ``rcu_head`` structures
+   allocated on the stack must be initialized with
+   ``init_rcu_head_on_stack()`` and cleaned up with
+   ``destroy_rcu_head_on_stack()``. Similarly, statically allocated
+   non-stack ``rcu_head`` structures must be initialized with
+   ``init_rcu_head()`` and cleaned up with ``destroy_rcu_head()``.
+   Mathieu Desnoyers made me aware of this requirement, and also
+   supplied the needed
+   `patch <https://lkml.kernel.org/g/20100319013024.GA28456@Krystal>`__.
+#. An infinite loop in an RCU read-side critical section will eventually
+   trigger an RCU CPU stall warning splat, with the duration of
+   “eventually” being controlled by the ``RCU_CPU_STALL_TIMEOUT``
+   ``Kconfig`` option, or, alternatively, by the
+   ``rcupdate.rcu_cpu_stall_timeout`` boot/sysfs parameter. However, RCU
+   is not obligated to produce this splat unless there is a grace period
+   waiting on that particular RCU read-side critical section.
+
+   Some extreme workloads might intentionally delay RCU grace periods,
+   and systems running those workloads can be booted with
+   ``rcupdate.rcu_cpu_stall_suppress`` to suppress the splats. This
+   kernel parameter may also be set via ``sysfs``. Furthermore, RCU CPU
+   stall warnings are counter-productive during sysrq dumps and during
+   panics. RCU therefore supplies the ``rcu_sysrq_start()`` and
+   ``rcu_sysrq_end()`` API members to be called before and after long
+   sysrq dumps. RCU also supplies the ``rcu_panic()`` notifier that is
+   automatically invoked at the beginning of a panic to suppress further
+   RCU CPU stall warnings.
+
+   This requirement made itself known in the early 1990s, pretty much
+   the first time that it was necessary to debug a CPU stall. That said,
+   the initial implementation in DYNIX/ptx was quite generic in
+   comparison with that of Linux.
+
+#. Although it would be very good to detect pointers leaking out of RCU
+   read-side critical sections, there is currently no good way of doing
+   this. One complication is the need to distinguish between pointers
+   leaking and pointers that have been handed off from RCU to some other
+   synchronization mechanism, for example, reference counting.
+#. In kernels built with ``CONFIG_RCU_TRACE=y``, RCU-related information
+   is provided via event tracing.
+#. Open-coded use of ``rcu_assign_pointer()`` and ``rcu_dereference()``
+   to create typical linked data structures can be surprisingly
+   error-prone. Therefore, RCU-protected `linked
+   lists <https://lwn.net/Articles/609973/#RCU%20List%20APIs>`__ and,
+   more recently, RCU-protected `hash
+   tables <https://lwn.net/Articles/612100/>`__ are available. Many
+   other special-purpose RCU-protected data structures are available in
+   the Linux kernel and the userspace RCU library.
+#. Some linked structures are created at compile time, but still require
+   ``__rcu`` checking. The ``RCU_POINTER_INITIALIZER()`` macro serves
+   this purpose.
+#. It is not necessary to use ``rcu_assign_pointer()`` when creating
+   linked structures that are to be published via a single external
+   pointer. The ``RCU_INIT_POINTER()`` macro is provided for this task
+   and also for assigning ``NULL`` pointers at runtime.
+
+This not a hard-and-fast list: RCU's diagnostic capabilities will
+continue to be guided by the number and type of usage bugs found in
+real-world RCU usage.
+
+Linux Kernel Complications
+--------------------------
+
+The Linux kernel provides an interesting environment for all kinds of
+software, including RCU. Some of the relevant points of interest are as
+follows:
+
+#. `Configuration <#Configuration>`__.
+#. `Firmware Interface <#Firmware%20Interface>`__.
+#. `Early Boot <#Early%20Boot>`__.
+#. `Interrupts and non-maskable interrupts
+   (NMIs) <#Interrupts%20and%20NMIs>`__.
+#. `Loadable Modules <#Loadable%20Modules>`__.
+#. `Hotplug CPU <#Hotplug%20CPU>`__.
+#. `Scheduler and RCU <#Scheduler%20and%20RCU>`__.
+#. `Tracing and RCU <#Tracing%20and%20RCU>`__.
+#. `Energy Efficiency <#Energy%20Efficiency>`__.
+#. `Scheduling-Clock Interrupts and
+   RCU <#Scheduling-Clock%20Interrupts%20and%20RCU>`__.
+#. `Memory Efficiency <#Memory%20Efficiency>`__.
+#. `Performance, Scalability, Response Time, and
+   Reliability <#Performance,%20Scalability,%20Response%20Time,%20and%20Reliability>`__.
+
+This list is probably incomplete, but it does give a feel for the most
+notable Linux-kernel complications. Each of the following sections
+covers one of the above topics.
+
+Configuration
+~~~~~~~~~~~~~
+
+RCU's goal is automatic configuration, so that almost nobody needs to
+worry about RCU's ``Kconfig`` options. And for almost all users, RCU
+does in fact work well “out of the box.”
+
+However, there are specialized use cases that are handled by kernel boot
+parameters and ``Kconfig`` options. Unfortunately, the ``Kconfig``
+system will explicitly ask users about new ``Kconfig`` options, which
+requires almost all of them be hidden behind a ``CONFIG_RCU_EXPERT``
+``Kconfig`` option.
+
+This all should be quite obvious, but the fact remains that Linus
+Torvalds recently had to
+`remind <https://lkml.kernel.org/g/CA+55aFy4wcCwaL4okTs8wXhGZ5h-ibecy_Meg9C4MNQrUnwMcg@mail.gmail.com>`__
+me of this requirement.
+
+Firmware Interface
+~~~~~~~~~~~~~~~~~~
+
+In many cases, kernel obtains information about the system from the
+firmware, and sometimes things are lost in translation. Or the
+translation is accurate, but the original message is bogus.
+
+For example, some systems' firmware overreports the number of CPUs,
+sometimes by a large factor. If RCU naively believed the firmware, as it
+used to do, it would create too many per-CPU kthreads. Although the
+resulting system will still run correctly, the extra kthreads needlessly
+consume memory and can cause confusion when they show up in ``ps``
+listings.
+
+RCU must therefore wait for a given CPU to actually come online before
+it can allow itself to believe that the CPU actually exists. The
+resulting “ghost CPUs” (which are never going to come online) cause a
+number of `interesting
+complications <https://paulmck.livejournal.com/37494.html>`__.
+
+Early Boot
+~~~~~~~~~~
+
+The Linux kernel's boot sequence is an interesting process, and RCU is
+used early, even before ``rcu_init()`` is invoked. In fact, a number of
+RCU's primitives can be used as soon as the initial task's
+``task_struct`` is available and the boot CPU's per-CPU variables are
+set up. The read-side primitives (``rcu_read_lock()``,
+``rcu_read_unlock()``, ``rcu_dereference()``, and
+``rcu_access_pointer()``) will operate normally very early on, as will
+``rcu_assign_pointer()``.
+
+Although ``call_rcu()`` may be invoked at any time during boot,
+callbacks are not guaranteed to be invoked until after all of RCU's
+kthreads have been spawned, which occurs at ``early_initcall()`` time.
+This delay in callback invocation is due to the fact that RCU does not
+invoke callbacks until it is fully initialized, and this full
+initialization cannot occur until after the scheduler has initialized
+itself to the point where RCU can spawn and run its kthreads. In theory,
+it would be possible to invoke callbacks earlier, however, this is not a
+panacea because there would be severe restrictions on what operations
+those callbacks could invoke.
+
+Perhaps surprisingly, ``synchronize_rcu()`` and
+``synchronize_rcu_expedited()``, will operate normally during very early
+boot, the reason being that there is only one CPU and preemption is
+disabled. This means that the call ``synchronize_rcu()`` (or friends)
+itself is a quiescent state and thus a grace period, so the early-boot
+implementation can be a no-op.
+
+However, once the scheduler has spawned its first kthread, this early
+boot trick fails for ``synchronize_rcu()`` (as well as for
+``synchronize_rcu_expedited()``) in ``CONFIG_PREEMPT=y`` kernels. The
+reason is that an RCU read-side critical section might be preempted,
+which means that a subsequent ``synchronize_rcu()`` really does have to
+wait for something, as opposed to simply returning immediately.
+Unfortunately, ``synchronize_rcu()`` can't do this until all of its
+kthreads are spawned, which doesn't happen until some time during
+``early_initcalls()`` time. But this is no excuse: RCU is nevertheless
+required to correctly handle synchronous grace periods during this time
+period. Once all of its kthreads are up and running, RCU starts running
+normally.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| How can RCU possibly handle grace periods before all of its kthreads  |
+| have been spawned???                                                  |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Very carefully!                                                       |
+| During the “dead zone” between the time that the scheduler spawns the |
+| first task and the time that all of RCU's kthreads have been spawned, |
+| all synchronous grace periods are handled by the expedited            |
+| grace-period mechanism. At runtime, this expedited mechanism relies   |
+| on workqueues, but during the dead zone the requesting task itself    |
+| drives the desired expedited grace period. Because dead-zone          |
+| execution takes place within task context, everything works. Once the |
+| dead zone ends, expedited grace periods go back to using workqueues,  |
+| as is required to avoid problems that would otherwise occur when a    |
+| user task received a POSIX signal while driving an expedited grace    |
+| period.                                                               |
+|                                                                       |
+| And yes, this does mean that it is unhelpful to send POSIX signals to |
+| random tasks between the time that the scheduler spawns its first     |
+| kthread and the time that RCU's kthreads have all been spawned. If    |
+| there ever turns out to be a good reason for sending POSIX signals    |
+| during that time, appropriate adjustments will be made. (If it turns  |
+| out that POSIX signals are sent during this time for no good reason,  |
+| other adjustments will be made, appropriate or otherwise.)            |
++-----------------------------------------------------------------------+
+
+I learned of these boot-time requirements as a result of a series of
+system hangs.
+
+Interrupts and NMIs
+~~~~~~~~~~~~~~~~~~~
+
+The Linux kernel has interrupts, and RCU read-side critical sections are
+legal within interrupt handlers and within interrupt-disabled regions of
+code, as are invocations of ``call_rcu()``.
+
+Some Linux-kernel architectures can enter an interrupt handler from
+non-idle process context, and then just never leave it, instead
+stealthily transitioning back to process context. This trick is
+sometimes used to invoke system calls from inside the kernel. These
+“half-interrupts” mean that RCU has to be very careful about how it
+counts interrupt nesting levels. I learned of this requirement the hard
+way during a rewrite of RCU's dyntick-idle code.
+
+The Linux kernel has non-maskable interrupts (NMIs), and RCU read-side
+critical sections are legal within NMI handlers. Thankfully, RCU
+update-side primitives, including ``call_rcu()``, are prohibited within
+NMI handlers.
+
+The name notwithstanding, some Linux-kernel architectures can have
+nested NMIs, which RCU must handle correctly. Andy Lutomirski `surprised
+me <https://lkml.kernel.org/r/CALCETrXLq1y7e_dKFPgou-FKHB6Pu-r8+t-6Ds+8=va7anBWDA@mail.gmail.com>`__
+with this requirement; he also kindly surprised me with `an
+algorithm <https://lkml.kernel.org/r/CALCETrXSY9JpW3uE6H8WYk81sg56qasA2aqmjMPsq5dOtzso=g@mail.gmail.com>`__
+that meets this requirement.
+
+Furthermore, NMI handlers can be interrupted by what appear to RCU to be
+normal interrupts. One way that this can happen is for code that
+directly invokes ``rcu_irq_enter()`` and ``rcu_irq_exit()`` to be called
+from an NMI handler. This astonishing fact of life prompted the current
+code structure, which has ``rcu_irq_enter()`` invoking
+``rcu_nmi_enter()`` and ``rcu_irq_exit()`` invoking ``rcu_nmi_exit()``.
+And yes, I also learned of this requirement the hard way.
+
+Loadable Modules
+~~~~~~~~~~~~~~~~
+
+The Linux kernel has loadable modules, and these modules can also be
+unloaded. After a given module has been unloaded, any attempt to call
+one of its functions results in a segmentation fault. The module-unload
+functions must therefore cancel any delayed calls to loadable-module
+functions, for example, any outstanding ``mod_timer()`` must be dealt
+with via ``del_timer_sync()`` or similar.
+
+Unfortunately, there is no way to cancel an RCU callback; once you
+invoke ``call_rcu()``, the callback function is eventually going to be
+invoked, unless the system goes down first. Because it is normally
+considered socially irresponsible to crash the system in response to a
+module unload request, we need some other way to deal with in-flight RCU
+callbacks.
+
+RCU therefore provides ``rcu_barrier()``, which waits until all
+in-flight RCU callbacks have been invoked. If a module uses
+``call_rcu()``, its exit function should therefore prevent any future
+invocation of ``call_rcu()``, then invoke ``rcu_barrier()``. In theory,
+the underlying module-unload code could invoke ``rcu_barrier()``
+unconditionally, but in practice this would incur unacceptable
+latencies.
+
+Nikita Danilov noted this requirement for an analogous
+filesystem-unmount situation, and Dipankar Sarma incorporated
+``rcu_barrier()`` into RCU. The need for ``rcu_barrier()`` for module
+unloading became apparent later.
+
+.. important::
+
+   The ``rcu_barrier()`` function is not, repeat,
+   *not*, obligated to wait for a grace period. It is instead only required
+   to wait for RCU callbacks that have already been posted. Therefore, if
+   there are no RCU callbacks posted anywhere in the system,
+   ``rcu_barrier()`` is within its rights to return immediately. Even if
+   there are callbacks posted, ``rcu_barrier()`` does not necessarily need
+   to wait for a grace period.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Wait a minute! Each RCU callbacks must wait for a grace period to     |
+| complete, and ``rcu_barrier()`` must wait for each pre-existing       |
+| callback to be invoked. Doesn't ``rcu_barrier()`` therefore need to   |
+| wait for a full grace period if there is even one callback posted     |
+| anywhere in the system?                                               |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Absolutely not!!!                                                     |
+| Yes, each RCU callbacks must wait for a grace period to complete, but |
+| it might well be partly (or even completely) finished waiting by the  |
+| time ``rcu_barrier()`` is invoked. In that case, ``rcu_barrier()``    |
+| need only wait for the remaining portion of the grace period to       |
+| elapse. So even if there are quite a few callbacks posted,            |
+| ``rcu_barrier()`` might well return quite quickly.                    |
+|                                                                       |
+| So if you need to wait for a grace period as well as for all          |
+| pre-existing callbacks, you will need to invoke both                  |
+| ``synchronize_rcu()`` and ``rcu_barrier()``. If latency is a concern, |
+| you can always use workqueues to invoke them concurrently.            |
++-----------------------------------------------------------------------+
+
+Hotplug CPU
+~~~~~~~~~~~
+
+The Linux kernel supports CPU hotplug, which means that CPUs can come
+and go. It is of course illegal to use any RCU API member from an
+offline CPU, with the exception of `SRCU <#Sleepable%20RCU>`__ read-side
+critical sections. This requirement was present from day one in
+DYNIX/ptx, but on the other hand, the Linux kernel's CPU-hotplug
+implementation is “interesting.”
+
+The Linux-kernel CPU-hotplug implementation has notifiers that are used
+to allow the various kernel subsystems (including RCU) to respond
+appropriately to a given CPU-hotplug operation. Most RCU operations may
+be invoked from CPU-hotplug notifiers, including even synchronous
+grace-period operations such as ``synchronize_rcu()`` and
+``synchronize_rcu_expedited()``.
+
+However, all-callback-wait operations such as ``rcu_barrier()`` are also
+not supported, due to the fact that there are phases of CPU-hotplug
+operations where the outgoing CPU's callbacks will not be invoked until
+after the CPU-hotplug operation ends, which could also result in
+deadlock. Furthermore, ``rcu_barrier()`` blocks CPU-hotplug operations
+during its execution, which results in another type of deadlock when
+invoked from a CPU-hotplug notifier.
+
+Scheduler and RCU
+~~~~~~~~~~~~~~~~~
+
+RCU depends on the scheduler, and the scheduler uses RCU to protect some
+of its data structures. The preemptible-RCU ``rcu_read_unlock()``
+implementation must therefore be written carefully to avoid deadlocks
+involving the scheduler's runqueue and priority-inheritance locks. In
+particular, ``rcu_read_unlock()`` must tolerate an interrupt where the
+interrupt handler invokes both ``rcu_read_lock()`` and
+``rcu_read_unlock()``. This possibility requires ``rcu_read_unlock()``
+to use negative nesting levels to avoid destructive recursion via
+interrupt handler's use of RCU.
+
+This scheduler-RCU requirement came as a `complete
+surprise <https://lwn.net/Articles/453002/>`__.
+
+As noted above, RCU makes use of kthreads, and it is necessary to avoid
+excessive CPU-time accumulation by these kthreads. This requirement was
+no surprise, but RCU's violation of it when running context-switch-heavy
+workloads when built with ``CONFIG_NO_HZ_FULL=y`` `did come as a
+surprise
+[PDF] <http://www.rdrop.com/users/paulmck/scalability/paper/BareMetal.2015.01.15b.pdf>`__.
+RCU has made good progress towards meeting this requirement, even for
+context-switch-heavy ``CONFIG_NO_HZ_FULL=y`` workloads, but there is
+room for further improvement.
+
+It is forbidden to hold any of scheduler's runqueue or
+priority-inheritance spinlocks across an ``rcu_read_unlock()`` unless
+interrupts have been disabled across the entire RCU read-side critical
+section, that is, up to and including the matching ``rcu_read_lock()``.
+Violating this restriction can result in deadlocks involving these
+scheduler spinlocks. There was hope that this restriction might be
+lifted when interrupt-disabled calls to ``rcu_read_unlock()`` started
+deferring the reporting of the resulting RCU-preempt quiescent state
+until the end of the corresponding interrupts-disabled region.
+Unfortunately, timely reporting of the corresponding quiescent state to
+expedited grace periods requires a call to ``raise_softirq()``, which
+can acquire these scheduler spinlocks. In addition, real-time systems
+using RCU priority boosting need this restriction to remain in effect
+because deferred quiescent-state reporting would also defer deboosting,
+which in turn would degrade real-time latencies.
+
+In theory, if a given RCU read-side critical section could be guaranteed
+to be less than one second in duration, holding a scheduler spinlock
+across that critical section's ``rcu_read_unlock()`` would require only
+that preemption be disabled across the entire RCU read-side critical
+section, not interrupts. Unfortunately, given the possibility of vCPU
+preemption, long-running interrupts, and so on, it is not possible in
+practice to guarantee that a given RCU read-side critical section will
+complete in less than one second. Therefore, as noted above, if
+scheduler spinlocks are held across a given call to
+``rcu_read_unlock()``, interrupts must be disabled across the entire RCU
+read-side critical section.
+
+Tracing and RCU
+~~~~~~~~~~~~~~~
+
+It is possible to use tracing on RCU code, but tracing itself uses RCU.
+For this reason, ``rcu_dereference_raw_notrace()`` is provided for use
+by tracing, which avoids the destructive recursion that could otherwise
+ensue. This API is also used by virtualization in some architectures,
+where RCU readers execute in environments in which tracing cannot be
+used. The tracing folks both located the requirement and provided the
+needed fix, so this surprise requirement was relatively painless.
+
+Energy Efficiency
+~~~~~~~~~~~~~~~~~
+
+Interrupting idle CPUs is considered socially unacceptable, especially
+by people with battery-powered embedded systems. RCU therefore conserves
+energy by detecting which CPUs are idle, including tracking CPUs that
+have been interrupted from idle. This is a large part of the
+energy-efficiency requirement, so I learned of this via an irate phone
+call.
+
+Because RCU avoids interrupting idle CPUs, it is illegal to execute an
+RCU read-side critical section on an idle CPU. (Kernels built with
+``CONFIG_PROVE_RCU=y`` will splat if you try it.) The ``RCU_NONIDLE()``
+macro and ``_rcuidle`` event tracing is provided to work around this
+restriction. In addition, ``rcu_is_watching()`` may be used to test
+whether or not it is currently legal to run RCU read-side critical
+sections on this CPU. I learned of the need for diagnostics on the one
+hand and ``RCU_NONIDLE()`` on the other while inspecting idle-loop code.
+Steven Rostedt supplied ``_rcuidle`` event tracing, which is used quite
+heavily in the idle loop. However, there are some restrictions on the
+code placed within ``RCU_NONIDLE()``:
+
+#. Blocking is prohibited. In practice, this is not a serious
+   restriction given that idle tasks are prohibited from blocking to
+   begin with.
+#. Although nesting ``RCU_NONIDLE()`` is permitted, they cannot nest
+   indefinitely deeply. However, given that they can be nested on the
+   order of a million deep, even on 32-bit systems, this should not be a
+   serious restriction. This nesting limit would probably be reached
+   long after the compiler OOMed or the stack overflowed.
+#. Any code path that enters ``RCU_NONIDLE()`` must sequence out of that
+   same ``RCU_NONIDLE()``. For example, the following is grossly
+   illegal:
+
+      ::
+
+	  1     RCU_NONIDLE({
+	  2       do_something();
+	  3       goto bad_idea;  /* BUG!!! */
+	  4       do_something_else();});
+	  5   bad_idea:
+
+
+   It is just as illegal to transfer control into the middle of
+   ``RCU_NONIDLE()``'s argument. Yes, in theory, you could transfer in
+   as long as you also transferred out, but in practice you could also
+   expect to get sharply worded review comments.
+
+It is similarly socially unacceptable to interrupt an ``nohz_full`` CPU
+running in userspace. RCU must therefore track ``nohz_full`` userspace
+execution. RCU must therefore be able to sample state at two points in
+time, and be able to determine whether or not some other CPU spent any
+time idle and/or executing in userspace.
+
+These energy-efficiency requirements have proven quite difficult to
+understand and to meet, for example, there have been more than five
+clean-sheet rewrites of RCU's energy-efficiency code, the last of which
+was finally able to demonstrate `real energy savings running on real
+hardware
+[PDF] <http://www.rdrop.com/users/paulmck/realtime/paper/AMPenergy.2013.04.19a.pdf>`__.
+As noted earlier, I learned of many of these requirements via angry
+phone calls: Flaming me on the Linux-kernel mailing list was apparently
+not sufficient to fully vent their ire at RCU's energy-efficiency bugs!
+
+Scheduling-Clock Interrupts and RCU
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The kernel transitions between in-kernel non-idle execution, userspace
+execution, and the idle loop. Depending on kernel configuration, RCU
+handles these states differently:
+
++-----------------+------------------+------------------+-----------------+
+| ``HZ`` Kconfig  | In-Kernel        | Usermode         | Idle            |
++=================+==================+==================+=================+
+| ``HZ_PERIODIC`` | Can rely on      | Can rely on      | Can rely on     |
+|                 | scheduling-clock | scheduling-clock | RCU's           |
+|                 | interrupt.       | interrupt and    | dyntick-idle    |
+|                 |                  | its detection    | detection.      |
+|                 |                  | of interrupt     |                 |
+|                 |                  | from usermode.   |                 |
++-----------------+------------------+------------------+-----------------+
+| ``NO_HZ_IDLE``  | Can rely on      | Can rely on      | Can rely on     |
+|                 | scheduling-clock | scheduling-clock | RCU's           |
+|                 | interrupt.       | interrupt and    | dyntick-idle    |
+|                 |                  | its detection    | detection.      |
+|                 |                  | of interrupt     |                 |
+|                 |                  | from usermode.   |                 |
++-----------------+------------------+------------------+-----------------+
+| ``NO_HZ_FULL``  | Can only         | Can rely on      | Can rely on     |
+|                 | sometimes rely   | RCU's            | RCU's           |
+|                 | on               | dyntick-idle     | dyntick-idle    |
+|                 | scheduling-clock | detection.       | detection.      |
+|                 | interrupt. In    |                  |                 |
+|                 | other cases, it  |                  |                 |
+|                 | is necessary to  |                  |                 |
+|                 | bound kernel     |                  |                 |
+|                 | execution times  |                  |                 |
+|                 | and/or use       |                  |                 |
+|                 | IPIs.            |                  |                 |
++-----------------+------------------+------------------+-----------------+
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| Why can't ``NO_HZ_FULL`` in-kernel execution rely on the              |
+| scheduling-clock interrupt, just like ``HZ_PERIODIC`` and             |
+| ``NO_HZ_IDLE`` do?                                                    |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Because, as a performance optimization, ``NO_HZ_FULL`` does not       |
+| necessarily re-enable the scheduling-clock interrupt on entry to each |
+| and every system call.                                                |
++-----------------------------------------------------------------------+
+
+However, RCU must be reliably informed as to whether any given CPU is
+currently in the idle loop, and, for ``NO_HZ_FULL``, also whether that
+CPU is executing in usermode, as discussed
+`earlier <#Energy%20Efficiency>`__. It also requires that the
+scheduling-clock interrupt be enabled when RCU needs it to be:
+
+#. If a CPU is either idle or executing in usermode, and RCU believes it
+   is non-idle, the scheduling-clock tick had better be running.
+   Otherwise, you will get RCU CPU stall warnings. Or at best, very long
+   (11-second) grace periods, with a pointless IPI waking the CPU from
+   time to time.
+#. If a CPU is in a portion of the kernel that executes RCU read-side
+   critical sections, and RCU believes this CPU to be idle, you will get
+   random memory corruption. **DON'T DO THIS!!!**
+   This is one reason to test with lockdep, which will complain about
+   this sort of thing.
+#. If a CPU is in a portion of the kernel that is absolutely positively
+   no-joking guaranteed to never execute any RCU read-side critical
+   sections, and RCU believes this CPU to to be idle, no problem. This
+   sort of thing is used by some architectures for light-weight
+   exception handlers, which can then avoid the overhead of
+   ``rcu_irq_enter()`` and ``rcu_irq_exit()`` at exception entry and
+   exit, respectively. Some go further and avoid the entireties of
+   ``irq_enter()`` and ``irq_exit()``.
+   Just make very sure you are running some of your tests with
+   ``CONFIG_PROVE_RCU=y``, just in case one of your code paths was in
+   fact joking about not doing RCU read-side critical sections.
+#. If a CPU is executing in the kernel with the scheduling-clock
+   interrupt disabled and RCU believes this CPU to be non-idle, and if
+   the CPU goes idle (from an RCU perspective) every few jiffies, no
+   problem. It is usually OK for there to be the occasional gap between
+   idle periods of up to a second or so.
+   If the gap grows too long, you get RCU CPU stall warnings.
+#. If a CPU is either idle or executing in usermode, and RCU believes it
+   to be idle, of course no problem.
+#. If a CPU is executing in the kernel, the kernel code path is passing
+   through quiescent states at a reasonable frequency (preferably about
+   once per few jiffies, but the occasional excursion to a second or so
+   is usually OK) and the scheduling-clock interrupt is enabled, of
+   course no problem.
+   If the gap between a successive pair of quiescent states grows too
+   long, you get RCU CPU stall warnings.
+
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| But what if my driver has a hardware interrupt handler that can run   |
+| for many seconds? I cannot invoke ``schedule()`` from an hardware     |
+| interrupt handler, after all!                                         |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| One approach is to do ``rcu_irq_exit();rcu_irq_enter();`` every so    |
+| often. But given that long-running interrupt handlers can cause other |
+| problems, not least for response time, shouldn't you work to keep     |
+| your interrupt handler's runtime within reasonable bounds?            |
++-----------------------------------------------------------------------+
+
+But as long as RCU is properly informed of kernel state transitions
+between in-kernel execution, usermode execution, and idle, and as long
+as the scheduling-clock interrupt is enabled when RCU needs it to be,
+you can rest assured that the bugs you encounter will be in some other
+part of RCU or some other part of the kernel!
+
+Memory Efficiency
+~~~~~~~~~~~~~~~~~
+
+Although small-memory non-realtime systems can simply use Tiny RCU, code
+size is only one aspect of memory efficiency. Another aspect is the size
+of the ``rcu_head`` structure used by ``call_rcu()`` and
+``kfree_rcu()``. Although this structure contains nothing more than a
+pair of pointers, it does appear in many RCU-protected data structures,
+including some that are size critical. The ``page`` structure is a case
+in point, as evidenced by the many occurrences of the ``union`` keyword
+within that structure.
+
+This need for memory efficiency is one reason that RCU uses hand-crafted
+singly linked lists to track the ``rcu_head`` structures that are
+waiting for a grace period to elapse. It is also the reason why
+``rcu_head`` structures do not contain debug information, such as fields
+tracking the file and line of the ``call_rcu()`` or ``kfree_rcu()`` that
+posted them. Although this information might appear in debug-only kernel
+builds at some point, in the meantime, the ``->func`` field will often
+provide the needed debug information.
+
+However, in some cases, the need for memory efficiency leads to even
+more extreme measures. Returning to the ``page`` structure, the
+``rcu_head`` field shares storage with a great many other structures
+that are used at various points in the corresponding page's lifetime. In
+order to correctly resolve certain `race
+conditions <https://lkml.kernel.org/g/1439976106-137226-1-git-send-email-kirill.shutemov@linux.intel.com>`__,
+the Linux kernel's memory-management subsystem needs a particular bit to
+remain zero during all phases of grace-period processing, and that bit
+happens to map to the bottom bit of the ``rcu_head`` structure's
+``->next`` field. RCU makes this guarantee as long as ``call_rcu()`` is
+used to post the callback, as opposed to ``kfree_rcu()`` or some future
+“lazy” variant of ``call_rcu()`` that might one day be created for
+energy-efficiency purposes.
+
+That said, there are limits. RCU requires that the ``rcu_head``
+structure be aligned to a two-byte boundary, and passing a misaligned
+``rcu_head`` structure to one of the ``call_rcu()`` family of functions
+will result in a splat. It is therefore necessary to exercise caution
+when packing structures containing fields of type ``rcu_head``. Why not
+a four-byte or even eight-byte alignment requirement? Because the m68k
+architecture provides only two-byte alignment, and thus acts as
+alignment's least common denominator.
+
+The reason for reserving the bottom bit of pointers to ``rcu_head``
+structures is to leave the door open to “lazy” callbacks whose
+invocations can safely be deferred. Deferring invocation could
+potentially have energy-efficiency benefits, but only if the rate of
+non-lazy callbacks decreases significantly for some important workload.
+In the meantime, reserving the bottom bit keeps this option open in case
+it one day becomes useful.
+
+Performance, Scalability, Response Time, and Reliability
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Expanding on the `earlier
+discussion <#Performance%20and%20Scalability>`__, RCU is used heavily by
+hot code paths in performance-critical portions of the Linux kernel's
+networking, security, virtualization, and scheduling code paths. RCU
+must therefore use efficient implementations, especially in its
+read-side primitives. To that end, it would be good if preemptible RCU's
+implementation of ``rcu_read_lock()`` could be inlined, however, doing
+this requires resolving ``#include`` issues with the ``task_struct``
+structure.
+
+The Linux kernel supports hardware configurations with up to 4096 CPUs,
+which means that RCU must be extremely scalable. Algorithms that involve
+frequent acquisitions of global locks or frequent atomic operations on
+global variables simply cannot be tolerated within the RCU
+implementation. RCU therefore makes heavy use of a combining tree based
+on the ``rcu_node`` structure. RCU is required to tolerate all CPUs
+continuously invoking any combination of RCU's runtime primitives with
+minimal per-operation overhead. In fact, in many cases, increasing load
+must *decrease* the per-operation overhead, witness the batching
+optimizations for ``synchronize_rcu()``, ``call_rcu()``,
+``synchronize_rcu_expedited()``, and ``rcu_barrier()``. As a general
+rule, RCU must cheerfully accept whatever the rest of the Linux kernel
+decides to throw at it.
+
+The Linux kernel is used for real-time workloads, especially in
+conjunction with the `-rt
+patchset <https://rt.wiki.kernel.org/index.php/Main_Page>`__. The
+real-time-latency response requirements are such that the traditional
+approach of disabling preemption across RCU read-side critical sections
+is inappropriate. Kernels built with ``CONFIG_PREEMPT=y`` therefore use
+an RCU implementation that allows RCU read-side critical sections to be
+preempted. This requirement made its presence known after users made it
+clear that an earlier `real-time
+patch <https://lwn.net/Articles/107930/>`__ did not meet their needs, in
+conjunction with some `RCU
+issues <https://lkml.kernel.org/g/20050318002026.GA2693@us.ibm.com>`__
+encountered by a very early version of the -rt patchset.
+
+In addition, RCU must make do with a sub-100-microsecond real-time
+latency budget. In fact, on smaller systems with the -rt patchset, the
+Linux kernel provides sub-20-microsecond real-time latencies for the
+whole kernel, including RCU. RCU's scalability and latency must
+therefore be sufficient for these sorts of configurations. To my
+surprise, the sub-100-microsecond real-time latency budget `applies to
+even the largest systems
+[PDF] <http://www.rdrop.com/users/paulmck/realtime/paper/bigrt.2013.01.31a.LCA.pdf>`__,
+up to and including systems with 4096 CPUs. This real-time requirement
+motivated the grace-period kthread, which also simplified handling of a
+number of race conditions.
+
+RCU must avoid degrading real-time response for CPU-bound threads,
+whether executing in usermode (which is one use case for
+``CONFIG_NO_HZ_FULL=y``) or in the kernel. That said, CPU-bound loops in
+the kernel must execute ``cond_resched()`` at least once per few tens of
+milliseconds in order to avoid receiving an IPI from RCU.
+
+Finally, RCU's status as a synchronization primitive means that any RCU
+failure can result in arbitrary memory corruption that can be extremely
+difficult to debug. This means that RCU must be extremely reliable,
+which in practice also means that RCU must have an aggressive
+stress-test suite. This stress-test suite is called ``rcutorture``.
+
+Although the need for ``rcutorture`` was no surprise, the current
+immense popularity of the Linux kernel is posing interesting—and perhaps
+unprecedented—validation challenges. To see this, keep in mind that
+there are well over one billion instances of the Linux kernel running
+today, given Android smartphones, Linux-powered televisions, and
+servers. This number can be expected to increase sharply with the advent
+of the celebrated Internet of Things.
+
+Suppose that RCU contains a race condition that manifests on average
+once per million years of runtime. This bug will be occurring about
+three times per *day* across the installed base. RCU could simply hide
+behind hardware error rates, given that no one should really expect
+their smartphone to last for a million years. However, anyone taking too
+much comfort from this thought should consider the fact that in most
+jurisdictions, a successful multi-year test of a given mechanism, which
+might include a Linux kernel, suffices for a number of types of
+safety-critical certifications. In fact, rumor has it that the Linux
+kernel is already being used in production for safety-critical
+applications. I don't know about you, but I would feel quite bad if a
+bug in RCU killed someone. Which might explain my recent focus on
+validation and verification.
+
+Other RCU Flavors
+-----------------
+
+One of the more surprising things about RCU is that there are now no
+fewer than five *flavors*, or API families. In addition, the primary
+flavor that has been the sole focus up to this point has two different
+implementations, non-preemptible and preemptible. The other four flavors
+are listed below, with requirements for each described in a separate
+section.
+
+#. `Bottom-Half Flavor (Historical) <#Bottom-Half%20Flavor>`__
+#. `Sched Flavor (Historical) <#Sched%20Flavor>`__
+#. `Sleepable RCU <#Sleepable%20RCU>`__
+#. `Tasks RCU <#Tasks%20RCU>`__
+
+Bottom-Half Flavor (Historical)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The RCU-bh flavor of RCU has since been expressed in terms of the other
+RCU flavors as part of a consolidation of the three flavors into a
+single flavor. The read-side API remains, and continues to disable
+softirq and to be accounted for by lockdep. Much of the material in this
+section is therefore strictly historical in nature.
+
+The softirq-disable (AKA “bottom-half”, hence the “_bh” abbreviations)
+flavor of RCU, or *RCU-bh*, was developed by Dipankar Sarma to provide a
+flavor of RCU that could withstand the network-based denial-of-service
+attacks researched by Robert Olsson. These attacks placed so much
+networking load on the system that some of the CPUs never exited softirq
+execution, which in turn prevented those CPUs from ever executing a
+context switch, which, in the RCU implementation of that time, prevented
+grace periods from ever ending. The result was an out-of-memory
+condition and a system hang.
+
+The solution was the creation of RCU-bh, which does
+``local_bh_disable()`` across its read-side critical sections, and which
+uses the transition from one type of softirq processing to another as a
+quiescent state in addition to context switch, idle, user mode, and
+offline. This means that RCU-bh grace periods can complete even when
+some of the CPUs execute in softirq indefinitely, thus allowing
+algorithms based on RCU-bh to withstand network-based denial-of-service
+attacks.
+
+Because ``rcu_read_lock_bh()`` and ``rcu_read_unlock_bh()`` disable and
+re-enable softirq handlers, any attempt to start a softirq handlers
+during the RCU-bh read-side critical section will be deferred. In this
+case, ``rcu_read_unlock_bh()`` will invoke softirq processing, which can
+take considerable time. One can of course argue that this softirq
+overhead should be associated with the code following the RCU-bh
+read-side critical section rather than ``rcu_read_unlock_bh()``, but the
+fact is that most profiling tools cannot be expected to make this sort
+of fine distinction. For example, suppose that a three-millisecond-long
+RCU-bh read-side critical section executes during a time of heavy
+networking load. There will very likely be an attempt to invoke at least
+one softirq handler during that three milliseconds, but any such
+invocation will be delayed until the time of the
+``rcu_read_unlock_bh()``. This can of course make it appear at first
+glance as if ``rcu_read_unlock_bh()`` was executing very slowly.
+
+The `RCU-bh
+API <https://lwn.net/Articles/609973/#RCU%20Per-Flavor%20API%20Table>`__
+includes ``rcu_read_lock_bh()``, ``rcu_read_unlock_bh()``,
+``rcu_dereference_bh()``, ``rcu_dereference_bh_check()``,
+``synchronize_rcu_bh()``, ``synchronize_rcu_bh_expedited()``,
+``call_rcu_bh()``, ``rcu_barrier_bh()``, and
+``rcu_read_lock_bh_held()``. However, the update-side APIs are now
+simple wrappers for other RCU flavors, namely RCU-sched in
+CONFIG_PREEMPT=n kernels and RCU-preempt otherwise.
+
+Sched Flavor (Historical)
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The RCU-sched flavor of RCU has since been expressed in terms of the
+other RCU flavors as part of a consolidation of the three flavors into a
+single flavor. The read-side API remains, and continues to disable
+preemption and to be accounted for by lockdep. Much of the material in
+this section is therefore strictly historical in nature.
+
+Before preemptible RCU, waiting for an RCU grace period had the side
+effect of also waiting for all pre-existing interrupt and NMI handlers.
+However, there are legitimate preemptible-RCU implementations that do
+not have this property, given that any point in the code outside of an
+RCU read-side critical section can be a quiescent state. Therefore,
+*RCU-sched* was created, which follows “classic” RCU in that an
+RCU-sched grace period waits for for pre-existing interrupt and NMI
+handlers. In kernels built with ``CONFIG_PREEMPT=n``, the RCU and
+RCU-sched APIs have identical implementations, while kernels built with
+``CONFIG_PREEMPT=y`` provide a separate implementation for each.
+
+Note well that in ``CONFIG_PREEMPT=y`` kernels,
+``rcu_read_lock_sched()`` and ``rcu_read_unlock_sched()`` disable and
+re-enable preemption, respectively. This means that if there was a
+preemption attempt during the RCU-sched read-side critical section,
+``rcu_read_unlock_sched()`` will enter the scheduler, with all the
+latency and overhead entailed. Just as with ``rcu_read_unlock_bh()``,
+this can make it look as if ``rcu_read_unlock_sched()`` was executing
+very slowly. However, the highest-priority task won't be preempted, so
+that task will enjoy low-overhead ``rcu_read_unlock_sched()``
+invocations.
+
+The `RCU-sched
+API <https://lwn.net/Articles/609973/#RCU%20Per-Flavor%20API%20Table>`__
+includes ``rcu_read_lock_sched()``, ``rcu_read_unlock_sched()``,
+``rcu_read_lock_sched_notrace()``, ``rcu_read_unlock_sched_notrace()``,
+``rcu_dereference_sched()``, ``rcu_dereference_sched_check()``,
+``synchronize_sched()``, ``synchronize_rcu_sched_expedited()``,
+``call_rcu_sched()``, ``rcu_barrier_sched()``, and
+``rcu_read_lock_sched_held()``. However, anything that disables
+preemption also marks an RCU-sched read-side critical section, including
+``preempt_disable()`` and ``preempt_enable()``, ``local_irq_save()`` and
+``local_irq_restore()``, and so on.
+
+Sleepable RCU
+~~~~~~~~~~~~~
+
+For well over a decade, someone saying “I need to block within an RCU
+read-side critical section” was a reliable indication that this someone
+did not understand RCU. After all, if you are always blocking in an RCU
+read-side critical section, you can probably afford to use a
+higher-overhead synchronization mechanism. However, that changed with
+the advent of the Linux kernel's notifiers, whose RCU read-side critical
+sections almost never sleep, but sometimes need to. This resulted in the
+introduction of `sleepable RCU <https://lwn.net/Articles/202847/>`__, or
+*SRCU*.
+
+SRCU allows different domains to be defined, with each such domain
+defined by an instance of an ``srcu_struct`` structure. A pointer to
+this structure must be passed in to each SRCU function, for example,
+``synchronize_srcu(&ss)``, where ``ss`` is the ``srcu_struct``
+structure. The key benefit of these domains is that a slow SRCU reader
+in one domain does not delay an SRCU grace period in some other domain.
+That said, one consequence of these domains is that read-side code must
+pass a “cookie” from ``srcu_read_lock()`` to ``srcu_read_unlock()``, for
+example, as follows:
+
+   ::
+
+       1 int idx;
+       2
+       3 idx = srcu_read_lock(&ss);
+       4 do_something();
+       5 srcu_read_unlock(&ss, idx);
+
+As noted above, it is legal to block within SRCU read-side critical
+sections, however, with great power comes great responsibility. If you
+block forever in one of a given domain's SRCU read-side critical
+sections, then that domain's grace periods will also be blocked forever.
+Of course, one good way to block forever is to deadlock, which can
+happen if any operation in a given domain's SRCU read-side critical
+section can wait, either directly or indirectly, for that domain's grace
+period to elapse. For example, this results in a self-deadlock:
+
+   ::
+
+       1 int idx;
+       2
+       3 idx = srcu_read_lock(&ss);
+       4 do_something();
+       5 synchronize_srcu(&ss);
+       6 srcu_read_unlock(&ss, idx);
+
+However, if line 5 acquired a mutex that was held across a
+``synchronize_srcu()`` for domain ``ss``, deadlock would still be
+possible. Furthermore, if line 5 acquired a mutex that was held across a
+``synchronize_srcu()`` for some other domain ``ss1``, and if an
+``ss1``-domain SRCU read-side critical section acquired another mutex
+that was held across as ``ss``-domain ``synchronize_srcu()``, deadlock
+would again be possible. Such a deadlock cycle could extend across an
+arbitrarily large number of different SRCU domains. Again, with great
+power comes great responsibility.
+
+Unlike the other RCU flavors, SRCU read-side critical sections can run
+on idle and even offline CPUs. This ability requires that
+``srcu_read_lock()`` and ``srcu_read_unlock()`` contain memory barriers,
+which means that SRCU readers will run a bit slower than would RCU
+readers. It also motivates the ``smp_mb__after_srcu_read_unlock()`` API,
+which, in combination with ``srcu_read_unlock()``, guarantees a full
+memory barrier.
+
+Also unlike other RCU flavors, ``synchronize_srcu()`` may **not** be
+invoked from CPU-hotplug notifiers, due to the fact that SRCU grace
+periods make use of timers and the possibility of timers being
+temporarily “stranded” on the outgoing CPU. This stranding of timers
+means that timers posted to the outgoing CPU will not fire until late in
+the CPU-hotplug process. The problem is that if a notifier is waiting on
+an SRCU grace period, that grace period is waiting on a timer, and that
+timer is stranded on the outgoing CPU, then the notifier will never be
+awakened, in other words, deadlock has occurred. This same situation of
+course also prohibits ``srcu_barrier()`` from being invoked from
+CPU-hotplug notifiers.
+
+SRCU also differs from other RCU flavors in that SRCU's expedited and
+non-expedited grace periods are implemented by the same mechanism. This
+means that in the current SRCU implementation, expediting a future grace
+period has the side effect of expediting all prior grace periods that
+have not yet completed. (But please note that this is a property of the
+current implementation, not necessarily of future implementations.) In
+addition, if SRCU has been idle for longer than the interval specified
+by the ``srcutree.exp_holdoff`` kernel boot parameter (25 microseconds
+by default), and if a ``synchronize_srcu()`` invocation ends this idle
+period, that invocation will be automatically expedited.
+
+As of v4.12, SRCU's callbacks are maintained per-CPU, eliminating a
+locking bottleneck present in prior kernel versions. Although this will
+allow users to put much heavier stress on ``call_srcu()``, it is
+important to note that SRCU does not yet take any special steps to deal
+with callback flooding. So if you are posting (say) 10,000 SRCU
+callbacks per second per CPU, you are probably totally OK, but if you
+intend to post (say) 1,000,000 SRCU callbacks per second per CPU, please
+run some tests first. SRCU just might need a few adjustment to deal with
+that sort of load. Of course, your mileage may vary based on the speed
+of your CPUs and the size of your memory.
+
+The `SRCU
+API <https://lwn.net/Articles/609973/#RCU%20Per-Flavor%20API%20Table>`__
+includes ``srcu_read_lock()``, ``srcu_read_unlock()``,
+``srcu_dereference()``, ``srcu_dereference_check()``,
+``synchronize_srcu()``, ``synchronize_srcu_expedited()``,
+``call_srcu()``, ``srcu_barrier()``, and ``srcu_read_lock_held()``. It
+also includes ``DEFINE_SRCU()``, ``DEFINE_STATIC_SRCU()``, and
+``init_srcu_struct()`` APIs for defining and initializing
+``srcu_struct`` structures.
+
+Tasks RCU
+~~~~~~~~~
+
+Some forms of tracing use “trampolines” to handle the binary rewriting
+required to install different types of probes. It would be good to be
+able to free old trampolines, which sounds like a job for some form of
+RCU. However, because it is necessary to be able to install a trace
+anywhere in the code, it is not possible to use read-side markers such
+as ``rcu_read_lock()`` and ``rcu_read_unlock()``. In addition, it does
+not work to have these markers in the trampoline itself, because there
+would need to be instructions following ``rcu_read_unlock()``. Although
+``synchronize_rcu()`` would guarantee that execution reached the
+``rcu_read_unlock()``, it would not be able to guarantee that execution
+had completely left the trampoline.
+
+The solution, in the form of `Tasks
+RCU <https://lwn.net/Articles/607117/>`__, is to have implicit read-side
+critical sections that are delimited by voluntary context switches, that
+is, calls to ``schedule()``, ``cond_resched()``, and
+``synchronize_rcu_tasks()``. In addition, transitions to and from
+userspace execution also delimit tasks-RCU read-side critical sections.
+
+The tasks-RCU API is quite compact, consisting only of
+``call_rcu_tasks()``, ``synchronize_rcu_tasks()``, and
+``rcu_barrier_tasks()``. In ``CONFIG_PREEMPT=n`` kernels, trampolines
+cannot be preempted, so these APIs map to ``call_rcu()``,
+``synchronize_rcu()``, and ``rcu_barrier()``, respectively. In
+``CONFIG_PREEMPT=y`` kernels, trampolines can be preempted, and these
+three APIs are therefore implemented by separate functions that check
+for voluntary context switches.
+
+Possible Future Changes
+-----------------------
+
+One of the tricks that RCU uses to attain update-side scalability is to
+increase grace-period latency with increasing numbers of CPUs. If this
+becomes a serious problem, it will be necessary to rework the
+grace-period state machine so as to avoid the need for the additional
+latency.
+
+RCU disables CPU hotplug in a few places, perhaps most notably in the
+``rcu_barrier()`` operations. If there is a strong reason to use
+``rcu_barrier()`` in CPU-hotplug notifiers, it will be necessary to
+avoid disabling CPU hotplug. This would introduce some complexity, so
+there had better be a *very* good reason.
+
+The tradeoff between grace-period latency on the one hand and
+interruptions of other CPUs on the other hand may need to be
+re-examined. The desire is of course for zero grace-period latency as
+well as zero interprocessor interrupts undertaken during an expedited
+grace period operation. While this ideal is unlikely to be achievable,
+it is quite possible that further improvements can be made.
+
+The multiprocessor implementations of RCU use a combining tree that
+groups CPUs so as to reduce lock contention and increase cache locality.
+However, this combining tree does not spread its memory across NUMA
+nodes nor does it align the CPU groups with hardware features such as
+sockets or cores. Such spreading and alignment is currently believed to
+be unnecessary because the hotpath read-side primitives do not access
+the combining tree, nor does ``call_rcu()`` in the common case. If you
+believe that your architecture needs such spreading and alignment, then
+your architecture should also benefit from the
+``rcutree.rcu_fanout_leaf`` boot parameter, which can be set to the
+number of CPUs in a socket, NUMA node, or whatever. If the number of
+CPUs is too large, use a fraction of the number of CPUs. If the number
+of CPUs is a large prime number, well, that certainly is an
+“interesting” architectural choice! More flexible arrangements might be
+considered, but only if ``rcutree.rcu_fanout_leaf`` has proven
+inadequate, and only if the inadequacy has been demonstrated by a
+carefully run and realistic system-level workload.
+
+Please note that arrangements that require RCU to remap CPU numbers will
+require extremely good demonstration of need and full exploration of
+alternatives.
+
+RCU's various kthreads are reasonably recent additions. It is quite
+likely that adjustments will be required to more gracefully handle
+extreme loads. It might also be necessary to be able to relate CPU
+utilization by RCU's kthreads and softirq handlers to the code that
+instigated this CPU utilization. For example, RCU callback overhead
+might be charged back to the originating ``call_rcu()`` instance, though
+probably not in production kernels.
+
+Additional work may be required to provide reasonable forward-progress
+guarantees under heavy load for grace periods and for callback
+invocation.
+
+Summary
+-------
+
+This document has presented more than two decade's worth of RCU
+requirements. Given that the requirements keep changing, this will not
+be the last word on this subject, but at least it serves to get an
+important subset of the requirements set forth.
+
+Acknowledgments
+---------------
+
+I am grateful to Steven Rostedt, Lai Jiangshan, Ingo Molnar, Oleg
+Nesterov, Borislav Petkov, Peter Zijlstra, Boqun Feng, and Andy
+Lutomirski for their help in rendering this article human readable, and
+to Michelle Rankin for her support of this effort. Other contributions
+are acknowledged in the Linux kernel's git archive.
diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 340a9725676c..94427dc1f23d 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -11,6 +11,11 @@ RCU concepts
    listRCU
    UP
 
+   Design/Memory-Ordering/Tree-RCU-Memory-Ordering
+   Design/Expedited-Grace-Periods/Expedited-Grace-Periods
+   Design/Requirements/Requirements
+   Design/Data-Structures/Data-Structures
+
 .. only:: subproject and html
 
    Indices
diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index 7e1a8721637a..17f48319ee16 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -302,7 +302,7 @@ rcu_dereference()
 	must prohibit.	The rcu_dereference_protected() variant takes
 	a lockdep expression to indicate which locks must be acquired
 	by the caller. If the indicated protection is not provided,
-	a lockdep splat is emitted.  See RCU/Design/Requirements/Requirements.html
+	a lockdep splat is emitted.  See Documentation/RCU/Design/Requirements/Requirements.rst
 	and the API's code comments for more details and example usage.
 
 The following diagram shows how each API communicates among the
@@ -630,7 +630,7 @@ been able to write-acquire the lock otherwise.  The smp_mb__after_spinlock()
 promotes synchronize_rcu() to a full memory barrier in compliance with
 the "Memory-Barrier Guarantees" listed in:
 
-	Documentation/RCU/Design/Requirements/Requirements.html.
+	Documentation/RCU/Design/Requirements/Requirements.rst
 
 It is possible to nest rcu_read_lock(), since reader-writer locks may
 be recursively acquired.  Note also that rcu_read_lock() is immune
-- 
2.22.0.770.g0f2c4a37fd-goog

