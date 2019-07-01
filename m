Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A24D75C4C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 23:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfGAVGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 17:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfGAVGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:06:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6619920665;
        Mon,  1 Jul 2019 21:06:04 +0000 (UTC)
Date:   Mon, 1 Jul 2019 17:06:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Corey Minyard <cminyard@mvista.com>
Cc:     Corey Minyard <minyard@acm.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190701170602.2fdb35c2@gandalf.local.home>
In-Reply-To: <20190701204325.GD5041@minyard.net>
References: <20190509193320.21105-1-minyard@acm.org>
        <20190510103318.6cieoifz27eph4n5@linutronix.de>
        <20190628214903.6f92a9ea@oasis.local.home>
        <20190701190949.GB4336@minyard.net>
        <20190701161840.1a53c9e4@gandalf.local.home>
        <20190701204325.GD5041@minyard.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2019 15:43:25 -0500
Corey Minyard <cminyard@mvista.com> wrote:


> I show that patch is already applied at
> 
>     1921ea799b7dc561c97185538100271d88ee47db
>     sched/completion: Fix a lockup in wait_for_completion()
> 
> git describe --contains 1921ea799b7dc561c97185538100271d88ee47db
> v4.19.37-rt20~1
> 
> So I'm not sure what is going on.

Bah, I'm replying to the wrong commit that I'm having issues with.

I searched your name to find the patch that is of trouble, and picked
this one.

I'll go find the problem patch, sorry for the noise on this one.

-- Steve
