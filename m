Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3DC15FB42
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgBOAAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:00:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgBOAAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:00:34 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 533EE2072D;
        Sat, 15 Feb 2020 00:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724833;
        bh=8A+lUFd9vw/q9Wo++mR8OA9LMasIZj70bS7RBZE1bws=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=s7n2f3+0WpxTwMES/RiBb3VOHGivLspaJ4RCzKZJOThRaSyz6bcgElfiyDqxCmECf
         7nVlcamN+IzG/aTVOv9t/mZWzLwFYMQrj+CE0EMRfw04xSbZubNrTJxawuS4f6EZ4a
         X/dRUXx1eZd6iAg5hkvDWdwdhMRql+ryOPnzWeVU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CD9BD3520D46; Fri, 14 Feb 2020 16:00:31 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:00:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/2] kfree_rcu() updates for v5.7
Message-ID: <20200215000031.GA14315@paulmck-ThinkPad-P72>
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

This series provides kfree_rcu() updates, all courtesy of Uladzislau
Rezki.

1.	Support kfree_bulk() interface in kfree_rcu().

2.	Add a trace event for kfree_rcu() use of kfree_bulk().

							Thanx, Paul

------------------------------------------------------------------------

 include/trace/events/rcu.h |   28 ++++++
 kernel/rcu/tree.c          |  207 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 200 insertions(+), 35 deletions(-)
