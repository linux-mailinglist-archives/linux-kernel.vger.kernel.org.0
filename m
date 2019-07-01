Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3441391D3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 18:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbfFGQYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 12:24:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50571 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730066AbfFGQYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:24:17 -0400
Received: from [5.158.153.52] (helo=noscherz.tec.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hZHep-0000ei-KF; Fri, 07 Jun 2019 18:23:59 +0200
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
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC PATCH v2 0/2] printk: new ringbuffer implementation
Date:   Fri,  7 Jun 2019 18:29:47 +0206
Message-Id: <20190607162349.18199-1-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a follow-up RFC on the work to reimplement much of
the core of printk. The original thread can be seen here[0].

One of the results of that thread was that the work needs to
be broken up into several pieces. A roadmap was laid out[1]
and this RFC is for the base component of the first piece:
a new ringbuffer implementation for printk.

This series does not touch any existing printk code. It is
only the ringbuffer implementation. I am particularly
interested in feedback relating to the design of the
ringbuffer and the use of memory barriers.

The series also includes a test module that performs some
heavy writer stress testing. I have successfully run these
tests on a 16-core ARM64 platform.

John Ogness

[0] https://lkml.kernel.org/r/20190212143003.48446-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/87y35hn6ih.fsf@linutronix.de

John Ogness (2):
  printk-rb: add a new printk ringbuffer implementation
  printk-rb: add test module

 Documentation/core-api/index.rst             |   1 +
 Documentation/core-api/printk-ringbuffer.rst | 104 +++
 include/linux/printk_ringbuffer.h            | 238 +++++++
 lib/Makefile                                 |   2 +
 lib/printk_ringbuffer.c                      | 924 +++++++++++++++++++++++++++
 lib/test_prb.c                               | 237 +++++++
 6 files changed, 1506 insertions(+)
 create mode 100644 Documentation/core-api/printk-ringbuffer.rst
 create mode 100644 include/linux/printk_ringbuffer.h
 create mode 100644 lib/printk_ringbuffer.c
 create mode 100644 lib/test_prb.c

-- 
2.11.0

