Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16CAB9D89F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 23:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfHZVlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 17:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfHZVly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 17:41:54 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98202217F5;
        Mon, 26 Aug 2019 21:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566855714;
        bh=E5K9lnKrRzdVRyjayweCBoAWKKLWCWmwI1ZXdq/wbQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ghC7AwZcI2nNQBmrTq0dJxOSGYWrNe/A+OTDoPCeyzMhB4mLEqngfhKFqV/EU3zh3
         vWd3cHffZtlgNo5PbtcvQya/GokLs5wWRS3Uv6gj7+nX+gkRNijhhep74J3CqMRVst
         PbMCuKSujXwa3fL80vx9xnolhmX4L2prYCB++CpU=
Date:   Mon, 26 Aug 2019 23:41:51 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [patch V2 31/38] rlimit: Rewrite non-sensical RLIMIT_CPU comment
Message-ID: <20190826214151.GF14309@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192922.185511287@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192922.185511287@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:18PM +0200, Thomas Gleixner wrote:
> The comment above the function which arms RLIMIT_CPU in the posix CPU timer
> code makes no sense at all. It claims that the kernel does not return an
> error code when it rejected the attempt to set RLIMIT_CPU. That's clearly
> bogus as the code does an error check and the rlimit is only set and
> activated when the permission checks are ok. In case of a rejection an
> appropriate error code is returned.
> 
> This is a historical and outdated comment which got dragged along even when
> the rlimit handling code was rewritten.
> 
> Replace it with an explanation why the setup function is not called when
> the rlimit value is RLIM_INFINITY and how the 'disarming' is handled.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
