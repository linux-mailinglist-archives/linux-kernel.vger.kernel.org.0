Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34CAAC9622
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 03:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfJCB1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 21:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfJCB1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:27:44 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB8C21A4C;
        Thu,  3 Oct 2019 01:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066063;
        bh=8ZCaaA6AFUsU8OaxZpSsxPMAlRb869d3eZL7IS4H6LA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=E65ZuflvXYkzJZal68FQ6qjTb1rtYYQACP171ukJ3HMIH1csuET68YAWbwU8pKzpp
         sOtHBS93tSR3Lqw71IqCu4yNutSydRC77yubE3WmrTFsFB5gRtRmLbqsPiJOWwmHkB
         jOB4rk0V9y/jDX3Z/RXdk7dZN67NM5BLnRKQ8KJg=
Date:   Wed, 2 Oct 2019 18:27:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/9] Documentation updates for v5.5
Message-ID: <20191003012741.GA12456@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides documentation updates:

1-2.	Revert a pair of documentation updates conflicting with later
	ReST-ification, courtesy of Joel Fernandes.

3.	Convert some RCU articles to ReST, courtesy of Mauro Carvalho
	Chehab.

4-5.	ReST adjustments, courtesy of Joel Fernandes.

6-7.	Reapply the reverted pair of updates, but in ReST form,
	courtesy of Joel Fernandes.

8.	Update list_for_each_entry_rcu() documentation, courtesy of
	Joel Fernandes.

9.	Rename rcu_node_context_switch() to rcu_note_context_switch(),
	courtesy of Sebastian Andrzej Siewior.

							Thanx, Paul

------------------------------------------------------------------------

 /Documentation/RCU/Design/Requirements/Requirements.html                       | 3330 ----------
 Documentation/RCU/Design/Data-Structures/Data-Structures.html                  | 1391 ----
 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html  |  668 --
 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Diagram.html                 |    9 
 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html         |  704 --
 b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst                 | 1163 +++
 b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst |  521 +
 b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst        |  644 +
 b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg                      |    2 
 b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg                      |    2 
 b/Documentation/RCU/Design/Requirements/Requirements.html                      |   73 
 b/Documentation/RCU/Design/Requirements/Requirements.rst                       | 2808 ++++++++
 b/Documentation/RCU/index.rst                                                  |    7 
 b/Documentation/RCU/lockdep.txt                                                |   18 
 b/Documentation/RCU/whatisRCU.txt                                              |   14 
 15 files changed, 5108 insertions(+), 6246 deletions(-)
