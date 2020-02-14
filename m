Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8F815FAB9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 00:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgBNXiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 18:38:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbgBNXiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:38:51 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59F1620848;
        Fri, 14 Feb 2020 23:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581723530;
        bh=RamZCpL9UShWknmSeCle1+sKcm4p8M9LAY+ZU9ekvho=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=cwpNIMXInEXeJukQOGiirbAPqxVFFDE9Ixqo/77X6S2411p/ueJSsDgZ5PbABErSN
         M0HUyYfPEY9d0PCffamnv+Xp8i42yl0EY2eCDxUJao+QAPTe4W7IR+sE3fPIcujMgh
         NjPQQVDsVLw4+rJPGtTmDaZXB53jzTmWA6zt+o30=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D32D93520D46; Fri, 14 Feb 2020 15:38:48 -0800 (PST)
Date:   Fri, 14 Feb 2020 15:38:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/9] Documentation updates for v5.7
Message-ID: <20200214233848.GA12744@paulmck-ThinkPad-P72>
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

This series provides documentation updates.

1.	Add some more RCU list patterns in the kernel, courtesy of
	Joel Fernandes and Amol Grover.

2.	Remove remaining HTML tags in ReST files, courtesy of SeongJae
	Park.

3.	Fix typos in a example code snippets, courtesy of SeongJae Park.

4.	Update example function name, courtesy of SeongJae Park.

5.	Use ':ref:' for links to other docs, courtesy of SeongJae Park.

6.	Use absolute paths for non-rst files, courtesy of SeongJae Park.

7.	Use https instead of http if possible, courtesy of SeongJae Park.

8.	Add description of rcutorture scripting to torture.txt.

9.	Fix memory-barriers.txt typos, courtesy of SeongJae Park.

							Thanx, Paul

------------------------------------------------------------------------

 RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst |    8 
 RCU/listRCU.rst                                         |  285 ++++++++++++----
 RCU/rcu.rst                                             |   18 -
 RCU/torture.txt                                         |  147 +++++++-
 memory-barriers.txt                                     |    8 
 5 files changed, 373 insertions(+), 93 deletions(-)
