Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF070153507
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 17:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgBEQMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 11:12:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35917 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgBEQMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:12:18 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1izNHi-00052E-DZ; Wed, 05 Feb 2020 17:12:14 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     lijiang <lijiang@redhat.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
References: <20200128161948.8524-1-john.ogness@linutronix.de>
        <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
        <20200205044848.GH41358@google.com>
        <20200205050204.GI41358@google.com>
        <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
        <20200205063640.GJ41358@google.com> <877e11h0ir.fsf@linutronix.de>
        <cd7509a5-48fd-e652-90f4-1e0fe2311134@redhat.com>
Date:   Wed, 05 Feb 2020 17:12:12 +0100
In-Reply-To: <cd7509a5-48fd-e652-90f4-1e0fe2311134@redhat.com>
        (lijiang@redhat.com's message of "Wed, 5 Feb 2020 18:19:02 +0800")
Message-ID: <87sgjp9foj.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-05, lijiang <lijiang@redhat.com> wrote:
> Do you have any suggestions about the size of CONFIG_LOG_* and
> CONFIG_PRINTK_* options by default?

The new printk implementation consumes more than double the memory that
the current printk implementation requires. This is because dictionaries
and meta-data are now stored separately.

If the old defaults (LOG_BUF_SHIFT=17 LOG_CPU_MAX_BUF_SHIFT=12) were
chosen because they are maximally acceptable defaults, then the defaults
should be reduced by 1 so that the final size is "similar" to the
current implementation.

If instead the defaults are left as-is, a machine with less than 64 CPUs
will reserve 336KiB for printk information (128KiB text, 128KiB
dictionary, 80KiB meta-data).

It might also be desirable to reduce the dictionary size (maybe 1/4 the
size of text?). However, since the new printk implementation allows for
non-intrusive dictionaries, we might see their usage increase and start
to be as large as the messages themselves.

John Ogness
