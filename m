Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9C7872B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 09:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405703AbfHIHIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 03:08:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55033 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfHIHIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:08:37 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hvz0l-0007YS-IM; Fri, 09 Aug 2019 09:08:27 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-10-john.ogness@linutronix.de>
        <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com>
        <20190809061437.GE2332@hirez.programming.kicks-ass.net>
Date:   Fri, 09 Aug 2019 09:08:25 +0200
In-Reply-To: <20190809061437.GE2332@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Fri, 9 Aug 2019 08:14:37 +0200")
Message-ID: <87mugix1cm.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-09, Peter Zijlstra <peterz@infradead.org> wrote:
>> End result: a DRAM buffer can work, but is not "reliable".
>> Particularly if you turn power on and off, data retention of DRAM is
>> iffy. But it's possible, at least in theory.
>> 
>> So I have a patch that implements a "stupid ring buffer" for thisa
>> case, with absolutely zero data structures (because in the presense of
>> DRAM corruption, all you can get is "hopefully only slightly garbled
>> ASCII".
>
> Note that you can hook this into printk as a fake early serial device;
> just have the serial device write to the DRAM buffer.

Or the other way around, implement a fake console to handle writing the
messages (as they are being emitted from printk) to some special
area. Then the messages would even be pre-processed so that all
meta-data is already in ASCII form.

John Ogness
