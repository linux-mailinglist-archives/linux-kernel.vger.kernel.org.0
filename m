Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1AD15FB72
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBOA3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:29:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbgBOA3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:29:09 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C3A9206D7;
        Sat, 15 Feb 2020 00:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581726549;
        bh=tl3u23Rh/qeAmhWSpAVu6UVi9OCXgBBp/Y8/HQIOyGk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Q5/YfDT3HqF1T3UCedTwvA+iN/1uMTH0op6DT6FiRPp3nOblaUxOhIqV/mY9G7kCZ
         L0ij6uVpKZTuaE4BNm1+hezwM9OaOwyhd2G1o+HhlTCgEQIs2UhvYugr1ABkNAhgff
         AIIUXafteoV19GKZIrrMERpipKO8Qy6qpxfEsmsQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 277793520D46; Fri, 14 Feb 2020 16:29:07 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:29:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/4] SRCU updates for v5.7
Message-ID: <20200215002907.GA15895@paulmck-ThinkPad-P72>
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

This series contains SRCU updates.

1.	Fix __call_srcu()/process_srcu() datarace.

2.	Fix __call_srcu()/srcu_get_delay() datarace.

3.	Fix process_srcu()/srcu_batches_completed() datarace.

4.	Add READ_ONCE() to srcu_struct ->srcu_gp_seq load.

							Thanx, Paul

------------------------------------------------------------------------

 srcutree.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)
