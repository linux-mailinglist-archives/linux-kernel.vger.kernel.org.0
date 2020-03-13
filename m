Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A2C184A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 16:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgCMPMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 11:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgCMPMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:12:17 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0452B20724;
        Fri, 13 Mar 2020 15:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584112336;
        bh=FZ8yTerpUOgwUw5O66SMbr6zAH38c4GmF1VmN0/QOu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OayoPXPwYIQef1mldvV53lJWl+ZZjy3yJCHqcRDjGBZxqeu3zc6oHRUe7u9yox8Pw
         umrcT3CB5dL4sUymaPe5M4RW6i2SwpXcGKX9XQMeZ3MU6ULScvTj3DqeTvVs/k42QN
         nf2wkldPgVrsqcDKID3xU9u1qxBhl/5ljgQJy1ys=
Date:   Fri, 13 Mar 2020 16:12:14 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: [patch part-II V2 06/13] x86/entry/common: Mark syscall entry
 points notrace and NOKPROBE
Message-ID: <20200313151213.GA32144@lenoir>
References: <20200308222359.370649591@linutronix.de>
 <20200308222609.522613084@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308222609.522613084@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 11:24:05PM +0100, Thomas Gleixner wrote:
> The entry code has some limitations for instrumentation. Anything before
> invoking enter_from_user_mode() cannot be probed because kprobes depend on
> RCU and with NOHZ_FULL user mode can be accounted similar to idle from a
> RCU point of view. enter_from_user_mode() calls into context tracking which
> adjusts the RCU state.
> 
> A similar problem exists vs. function tracing. The function entry/exit
> points can be used by BPF which again is not safe before CONTEXT_KERNEL has
> been reached.
> 
> Mark the C-entry points for the various syscalls with notrace and
> NOKPROBE_SYMBOL().
> 
> Note, that this still leaves the ASM invocations of trace_hardirqs_off()
> unprotected. While this is safe vs. RCU at least from the ftrace POV, these
> are trace points which can be utilized by BPF... This will be addressed in
> later patches.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> ---
> V2: Amend changelog

Thanks for the detailed explanations!

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
