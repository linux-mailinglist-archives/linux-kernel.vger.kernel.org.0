Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C718F9D8C1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 23:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfHZV5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 17:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfHZV5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 17:57:21 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2276920850;
        Mon, 26 Aug 2019 21:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566856640;
        bh=D9K92IFV4XsqcixfHYhV/oX9lfC7OT+SzS4AAi8rcJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLff1dIe8jDmY1CzJ6Vpbq9DDlJ+/QGJNLEciCOenlUYJMWcXAMLXls/mGMKhz43M
         8f8TEcR1bnZK3xWCcWNe/wxqReIAOHQ96zz3xNXw0yJgzW1mU9sDvR5IBxOiR/ncFk
         Tcb9dTv9UejSJPeCXFeI4ZwbWeurQ1DZZwphbHLk=
Date:   Mon, 26 Aug 2019 23:57:18 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 32/38] posix-cpu-timers: Get rid of zero checks
Message-ID: <20190826215717.GG14309@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192922.275086128@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192922.275086128@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:19PM +0200, Thomas Gleixner wrote:
> Deactivation of the expiry cache is done by setting all clock caches to
> 0. That requires to have a check for zero in all places which update the
> expiry cache:
> 
> 	if (cache == 0 || new < cache)
> 		cache = new;
> 
> Use U64_MAX as the deactivated value, which allows to remove the zero
> checks when updating the cache and reduces it to the obvious check:
> 
> 	if (new < cache)
> 		cache = new;
> 
> This also removes the weird workaround in do_prlimit() which was required
> to convert a RLIMIT_CPU value of 0 (immediate expiry) to 1 because handing
> in 0 to the posix CPU timer code would have effectively disarmed it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
