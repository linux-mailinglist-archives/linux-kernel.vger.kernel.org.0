Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3995B117E94
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 04:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfLJDzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 22:55:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfLJDzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:55:40 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A099205C9;
        Tue, 10 Dec 2019 03:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950139;
        bh=T0eRrylaB+yqWaFPUnrO9eFyz+t+jDmLMxSOov6JvzM=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Gc1QJ7UWRZm4UY9ctx1F21uD+Mkep7WkIKML7nubBLJg3rh7vMHhGZ+7F6S+bdIG6
         wJUNhP4wyS8gtKmE+rYvjUTguuie/ZW0iekWquQeC0JfZOH55ZyTeqcwUqtacBw1IP
         BUGDj+WrgTg+H2ECY7GZwR9gXh0yubM5XjU0rKfg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 345403522768; Mon,  9 Dec 2019 19:55:39 -0800 (PST)
Date:   Mon, 9 Dec 2019 19:55:39 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/7] Documentation updates for v5.6
Message-ID: <20191210035539.GA792@paulmck-ThinkPad-P72>
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

This series contains documentation updates for v5.6:

1.	Convert arrayRCU.txt to arrayRCU.rst, courtesy of Madhuparna
	Bhowmik.

2.	Convert NMI-RCU.txt to NMI-RCU.rst, courtesy of Madhuparna
	Bhowmik.

3.	Convert whatisRCU.txt to .rst, courtesy of Phong Tran.

4.	Convert to rcu_dereference.txt to rcu_dereference.rst, courtesy
	of Amol Grover.

5.	Convert to rcubarrier.txt to ReST, courtesy of Amol Grover.

6.	Update full list of RCU API in whatisRCU.rst, courtesy of
	Madhuparna Bhowmik.

7.	Fix typo s/deference/dereference/.

							Thanx, Paul

------------------------------------------------------------------------

 NMI-RCU.rst         |   53 ++++-----
 arrayRCU.rst        |   30 +++--
 index.rst           |    5 
 lockdep-splat.txt   |    2 
 rcu_dereference.rst |   75 +++++++------
 rcubarrier.rst      |  222 ++++++++++++++++++++++-----------------
 whatisRCU.rst       |  293 ++++++++++++++++++++++++++++++++--------------------
 7 files changed, 405 insertions(+), 275 deletions(-)
