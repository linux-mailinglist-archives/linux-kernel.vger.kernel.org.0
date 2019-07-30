Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B62A57AD68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 18:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfG3QTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 12:19:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfG3QTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:19:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 559E0206A2;
        Tue, 30 Jul 2019 16:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564503582;
        bh=tTV+Jl6auAGhs/hyed91Bsj5Kf/yoCGhVH+TBLTnh58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=co5nS52O/HQwLu29w64zrIEC76bTZ7cNjs1EX2Idq7/6F7SQWXr3FjJj2h3VmjfLD
         +07A0oajMHIWC34B0dDU4OsyveWwJlE+cCy0ufkZjSCQi53mK/7IUZntkzVwLZOtvL
         BGZCZ24FEIKKnFCIMmWiSU76Vx8XdyYzbaGHrxGU=
Date:   Tue, 30 Jul 2019 18:19:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 7/7] n_tty: Provide an informational line on VSTATUS
 receipt
Message-ID: <20190730161940.GA15798@kroah.com>
References: <20190625161153.29811-1-ar@cs.msu.ru>
 <20190625161153.29811-8-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625161153.29811-8-ar@cs.msu.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 07:11:53PM +0300, Arseny Maslennikov wrote:
> If the three termios local flags isig, icanon, iexten are enabled
> and the local flag nokerninfo is disabled for a tty governed
> by the n_tty line discipline, then on receiving the keyboard status
> character n_tty will generate a status message and write it out to
> the tty before sending SIGINFO to the tty's foreground process group.
> 
> This kerninfo line contains information about the current system load
> as well as some properties of "the most interesting" process in the
> tty's current foreground process group, namely:
>  - its PID as seen inside its deepest PID namespace;
>    * the whole process group ought to be in a single PID namespace,
>      so this is actually deterministic
>  - its saved command name truncated to 16 bytes (task_struct::comm);
>    * at the time of writing TASK_COMM_LEN == 16
>  - its state and some related bits, procps-style;
>  - for S and D: its symbolic wait channel, if available; or a short
>    description for other process states instead;
>  - its user, system and real rusage time values;
>  - its resident set size (as well as the high watermark) in kilobytes.

Why is this really all needed as we have the SysRq handlers that report
all of this today?

> The "most interesting" process is chosen as follows:
>  - runnables over everything
>  - uninterruptibles over everything else
>  - among 2 runnables pick the biggest utime + stime
>  - any unresolved ties are decided in favour of greatest PID.

This does not feel like something that the tty core code should be doing
at all.

> While the kerninfo line is not very useful for debugging the kernel
> itself, since we have much more powerful debugging tools, it still gives
> the user behind the terminal some meaningful feedback to a VSTATUS that
> works even if no processes respond.

That's what SysRq is for.  If there's a specific set of values that we
don't currently report in that facility, why not just add the
information there?  It's much simpler and "safer" that way.

thanks,

greg k-h
