Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC78988D5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 03:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfHVBCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 21:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729135AbfHVBCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 21:02:07 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2556A206BB;
        Thu, 22 Aug 2019 01:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566435726;
        bh=VQaB+kr/Uopl875xoy3KOCNc0UlOEIUPvKYog9+Y0yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1pQ3/HNaawqGH4rDlwwSCo6Iy6DXAlt2903rmXjKyov/TZVzKO5fgT4cUgV6sxFD
         QS/5JhY0EI1jog4VPDEqvRgXJEHQd93FbXD7QXiyNTjq8E0ISlPZjKwN60fcr3q8RK
         L1R1uC2fY+MGXYGW8Pdufhz/i8MUCMX9bK7vCang=
Date:   Thu, 22 Aug 2019 03:02:04 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch V2 00/38] posix-cpu-timers: Cleanup and consolidation
Message-ID: <20190822010203.GG22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190822005434.GA10938@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822005434.GA10938@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 02:54:34AM +0200, Christoph Hellwig wrote:
> > The series applies on top of:
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
> > 
> > and is available from git as well:
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.timers/core
> 
> Btw, for some reason git here seems to be very unhappy about that remote:
> 
> Fetching tip
> error: cannot lock ref 'refs/remotes/tip/WIP.timers/core': 'refs/remotes/tip/WIP.timers' exists; cannot create 'refs/remotes/tip/WIP.timers/core'
> From https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> ! [new branch]                WIP.timers/core -> tip/WIP.timers/core  (unable to update local ref)
> error: Could not fetch tip
> 
> which repeats every time I fetch.  I can't of anythign particular on
> my side that would cause this.

Yeah I had to run "git remote prune tip" and fetch again.

Apparently there was an old remote branch tip/WIP.timers and git
seem to refuse to have a new subpath branch.
