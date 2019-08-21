Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D36971CD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 07:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfHUF46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 01:56:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53776 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfHUF46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:56:58 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i0Jc2-0003p4-FK; Wed, 21 Aug 2019 07:56:50 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v4 4/9] printk-rb: initialize new descriptors as invalid
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-5-john.ogness@linutronix.de>
        <20190820092337.cudkfdfhsu44vlhh@pathway.suse.cz>
Date:   Wed, 21 Aug 2019 07:56:48 +0200
Message-ID: <87o90jdpsv.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-20, Petr Mladek <pmladek@suse.com> wrote:
>> Initialize never-used descriptors as permanently invalid so there
>
> The word "permanently" is confusing. It suggests that it will
> never ever be valid again. I would just remove the word.

Agreed.

>> is no risk of the descriptor unexpectedly being determined as
>> valid due to dataring head overflowing/wrapping.
>
> Please, provide more details about the solved race.

OK.

> Is it because some reader could have reference to an invalid
> (reused) descriptor?

Yes, but not because it is reused. If a writer succeeded in reserving a
descriptor, but failed to reserve a datablock, that (invalid) descriptor
is put on the committed list (see fA). By setting the lpos values to
something that could _never_ be valid, there is no risk of the
descriptor suddenly becoming valid due to head overflowing.

My RFCv2 did not account for this and instead invalid descriptors just
held on to whatever lpos values they last had. Although they are invalid
at that moment, if not set to something "permanently" invalid, those
values could become valid again. We talked about that here[0].

> Can be these invalid descriptors be member of the list?

Yes (as Sergey shows in his followup post). Readers see them as invalid
and treat them as dropped records.

> Also it might be worth to mention where is the check that might
> detect such invalid descriptors and what will be the consequences.
> Well, this might be clear from the race description.

The check itself is not special. However, readers do have to be aware of
and correctly handle the case of invalid descriptors on the list. I will
find an appropriate place to document this.

John Ogness

[0] https://lkml.kernel.org/r/20190624140948.l7ekcmz5ser3zfr2@pathway.suse.cz
