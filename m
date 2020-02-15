Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A04615FB6B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgBOAYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:24:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgBOAYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:24:48 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B181C206D7;
        Sat, 15 Feb 2020 00:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581726287;
        bh=YFsIW4ZIbL87oBAFgIiddTmWNgwoa/40z5hBp8G73IU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ruarJtvrgIZHUj9ftWYx2kResrLljnbcfGEPesqw9QFTTxMMJmHs+i6V4VT1bTRLw
         QOpVhprhSJZyh4UgcsdiHWaEbEfKUYAzIgjTRcevzNaGQjd7tCS1TAqonXI9qRE+DH
         3p+Exri1xOfY7I2HVpszoccwPhjTp9IGtMjgLy+E=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 30AEB3520D46; Fri, 14 Feb 2020 16:24:46 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:24:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/3] Tasks-RCU updates for v5.7
Message-ID: <20200215002446.GA15663@paulmck-ThinkPad-P72>
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

This series contains Tasks-RCU updates.

1.	Add *_ONCE() for rcu_tasks_cbs_head.

2.	Add missing annotation for exit_tasks_rcu_start(), courtesy
	of Jules Irenge.

3.	Add missing annotation for exit_tasks_rcu_finish(), courtesy
	of Jules Irenge.

							Thanx, Paul

------------------------------------------------------------------------

 update.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
