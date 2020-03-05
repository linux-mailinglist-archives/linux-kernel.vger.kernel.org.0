Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBCC8179CFE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 01:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgCEAuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 19:50:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:57274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgCEAut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 19:50:49 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 456FC2084E;
        Thu,  5 Mar 2020 00:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583369449;
        bh=vChol9pO7kDygComiayrT41Ba8h4bUJcsrtBd1jCgbk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=JnlUnxZEjfbxuBRZyX6b5DSsTDWk/E65DK4GSJvLSgr1DCoONlpQSvJaFSfKT7UVa
         JMon4Qxr/KhMU1OhqKmqznD0tXuDA0ErOchQmvnUZxei9UJBwaGwp7IRK0i8zmNRnP
         Ar5YfzhPx9FuBBpjOu6gBGIu0AdaU3xuSr72wCNE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 155113522731; Wed,  4 Mar 2020 16:50:49 -0800 (PST)
Date:   Wed, 4 Mar 2020 16:50:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org
Subject: Pinning down a blocked task to extract diagnostics
Message-ID: <20200305005049.GA21120@paulmck-ThinkPad-P72>
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

Suppose that I need to extract diagnostics information from a blocked
task, but that I absolutely cannot tolerate this task awakening in the
midst of this extraction process.  Is the following code the right way
to make this work given a task "t"?

	raw_spin_lock_irq(&t->pi_lock);
	if (t->on_rq) {
		/* Task no longer blocked, so ignore it. */
	} else {
		/* Extract consistent diagnostic information. */
	}
	raw_spin_unlock_irq(&t->pi_lock);

It looks like all the wakeup paths acquire ->pi_lock, but I figured I
should actually ask...

							Thanx, Paul
