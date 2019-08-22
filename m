Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48F9A988BA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 02:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfHVAyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 20:54:38 -0400
Received: from verein.lst.de ([213.95.11.211]:42321 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbfHVAyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:54:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C7A8C68BFE; Thu, 22 Aug 2019 02:54:34 +0200 (CEST)
Date:   Thu, 22 Aug 2019 02:54:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 00/38] posix-cpu-timers: Cleanup and consolidation
Message-ID: <20190822005434.GA10938@lst.de>
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821190847.665673890@linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The series applies on top of:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
> 
> and is available from git as well:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.timers/core

Btw, for some reason git here seems to be very unhappy about that remote:

Fetching tip
error: cannot lock ref 'refs/remotes/tip/WIP.timers/core': 'refs/remotes/tip/WIP.timers' exists; cannot create 'refs/remotes/tip/WIP.timers/core'
From https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
! [new branch]                WIP.timers/core -> tip/WIP.timers/core  (unable to update local ref)
error: Could not fetch tip

which repeats every time I fetch.  I can't of anythign particular on
my side that would cause this.
