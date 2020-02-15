Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C2D15FB48
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgBOADP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:03:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbgBOADP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:03:15 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BC69217F4;
        Sat, 15 Feb 2020 00:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724994;
        bh=ICpoRPwQD8Ty9TGcGvKircWD/ay458MKKna6BT5DhIE=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=YJQ9Ev3YsLVby6qFmgFAVKN0Pj8xThogI3f7njcdOo/1iGP2W6N0WZLvF7n2eE9CY
         FkFPPKmi5WVkBN5Bva0xBZJGptxxonbPzmiFzDWb5taQKjiNdh+03p1q2SsUM9Amos
         Z4C9Hh6tOSjB70hgmzbg3//nb39xFEZ+q23Gd4ls=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C33953520D46; Fri, 14 Feb 2020 16:03:12 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:03:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/4] Lock torture-test updates for v5.7
Message-ID: <20200215000312.GA14585@paulmck-ThinkPad-P72>
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

This series provides locktorture updates.

1.	Print ratio of acquisitions, not failures.

2.	Allow CPU-hotplug to be disabled via --bootargs.

3.	Use private random-number generators.

4.	Forgive apparent unfairness if CPU hotplug.

							Thanx, Paul

------------------------------------------------------------------------

 kernel/locking/locktorture.c                        |   15 ++++++++-------
 tools/testing/selftests/rcutorture/bin/functions.sh |    2 +-
 2 files changed, 9 insertions(+), 8 deletions(-)
