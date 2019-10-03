Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F65CA023
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 16:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfJCOPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 10:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729311AbfJCOPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:15:01 -0400
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B187A207FF;
        Thu,  3 Oct 2019 14:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570112101;
        bh=FqDlb1Rwc/xpHJ7qw5aClKOmelJXqFwY55ekxtX+iUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JHwYkLnx2aNLH1hc3eZrX8jB3QdwTnt6mJGtRMi9f3dXRHtAmzeH5SOdov/dWPWuY
         /Y57kehhhhi3F/IyMdxexMw9RjFZS1jRhwQzIvdYvs7TW8ucJ6i6eJVxXrG6f7odAb
         ZttFkc0y/hsPnfj1XYDQkujeRA+0Ix9yCW9kXARw=
Date:   Thu, 3 Oct 2019 16:14:58 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH tip/core/rcu 04/12] rcutorture: Force on tick for readers
 and callback flooders
Message-ID: <20191003141457.GA27555@lenoir>
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
 <20191003013903.13079-4-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003013903.13079-4-paulmck@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 06:38:55PM -0700, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@linux.ibm.com>
> 
> Readers and callback flooders in the rcutorture stress-test suite run for
> extended time periods by design.  They do take pains to relinquish the
> CPU from time to time, but in some cases this relies on the scheduler
> being active, which in turn relies on the scheduler-clock interrupt
> firing from time to time.
> 
> This commit therefore forces scheduling-clock interrupts within
> these loops.  While in the area, this commit also prevents
> rcu_torture_reader()'s occasional timed sleeps from delaying shutdown.
> 
> [ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

You can also remove all the IS_ENABLED here.

Thanks!
