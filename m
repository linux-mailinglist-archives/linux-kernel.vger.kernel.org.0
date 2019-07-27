Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F415D7759D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 03:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfG0Bdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 21:33:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50698 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfG0Bdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 21:33:52 -0400
Received: from [5.158.153.52] (helo=lx-training.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hrBal-0005il-DE; Sat, 27 Jul 2019 03:33:47 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [RFC PATCH v3 0/2] printk: new ringbuffer implementation
Date:   Sat, 27 Jul 2019 03:33:31 +0200
Message-Id: <20190727013333.11260-1-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a follow-up RFC on the work to re-implement much of
the core of printk. The threads for the previous RFC versions
are here: v1[0], v2[1].

As was planned[2], this is only the first piece: a new
lockless ringbuffer.

Changes from v2:

- Moved all code into kernel/printk/. Let's keep it private
  for now.

- Split the ringbuffer into 3 components:

  * a data ringbuffer (dataring) to manage the raw data and
    data descriptors

  * a numbered list (numlist) to manage committed entries and
    their sequence numbers

  * the printk_ringbuffer, which is the high-level structure
    providing the reader/writer API and glue for the other
    structures

  Splitting the components apart helped to document their
  roles and their related memory barriers (and will hopefully
  also simplify the review process).

- Renamed most functions, structures, and variables based on
  v2 feedback.

- Rewrote and reformatted nearly all comments (particularly
  the memory barrier comments) based on v2 feedback.

- Addressed implementation issues with v2:

  * invalid data blocks potentially becoming valid because of
    overflows

  * weak associations between data blocks and descriptors

  * excessive freeing of data blocks due to unavailable
    descriptors

- Improved error handling and data integrity checks in the test
  module.

For the memory barrier work I wrote a litmus test for nearly
every memory barrier. I did not include these in the series.
Should I? If yes, where should they be placed?

I would like to point out that Petr Mladek posted a
proof-of-concept[3] alternate implementation. I wanted to base my
v3 on his work, but ran into too many problems getting it to
run acceptably. I will address those issues in that thread. This
is why my v3 is based directly on my v2.

John Ogness

[0] https://lkml.kernel.org/r/20190212143003.48446-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/20190607162349.18199-1-john.ogness@linutronix.de
[2] https://lkml.kernel.org/r/87y35hn6ih.fsf@linutronix.de
[3] https://lkml.kernel.org/r/20190704103321.10022-1-pmladek@suse.com

John Ogness (2):
  printk-rb: add a new printk ringbuffer implementation
  printk-rb: add test module

 kernel/printk/Makefile     |   5 +
 kernel/printk/dataring.c   | 761 ++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/dataring.h   |  95 ++++++
 kernel/printk/numlist.c    | 375 +++++++++++++++++++++
 kernel/printk/numlist.h    |  72 ++++
 kernel/printk/ringbuffer.c | 800 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/ringbuffer.h | 288 ++++++++++++++++
 kernel/printk/test_prb.c   | 256 +++++++++++++++
 8 files changed, 2652 insertions(+)
 create mode 100644 kernel/printk/dataring.c
 create mode 100644 kernel/printk/dataring.h
 create mode 100644 kernel/printk/numlist.c
 create mode 100644 kernel/printk/numlist.h
 create mode 100644 kernel/printk/ringbuffer.c
 create mode 100644 kernel/printk/ringbuffer.h
 create mode 100644 kernel/printk/test_prb.c

-- 
2.11.0

