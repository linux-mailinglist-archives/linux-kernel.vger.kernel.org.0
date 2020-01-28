Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C438914BD94
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 17:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgA1QUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 11:20:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49350 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgA1QUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:20:19 -0500
Received: from [5.158.153.53] (helo=g2noscherz.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1iwTap-0001xK-7S; Tue, 28 Jan 2020 17:19:59 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] printk: replace ringbuffer
Date:   Tue, 28 Jan 2020 17:25:46 +0106
Message-Id: <20200128161948.8524-1-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After several RFC series [0][1][2][3][4], here is the first set of
patches to rework the printk subsystem. This first set of patches
only replace the existing ringbuffer implementation. No locking is
removed. No semantics/behavior of printk are changed.

The VMCOREINFO is updated, which will require changes to the
external crash [5] tool. I will be preparing a patch to add support
for the new VMCOREINFO.

This series is in line with the agreements [6] made at the meeting
during LPC2019 in Lisbon, with 1 exception: support for dictionaries
will _not_ be discontinued [7]. Dictionaries are stored in a separate
buffer so that they cannot interfere with the human-readable buffer.

John Ogness

[0] https://lkml.kernel.org/r/20190212143003.48446-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/20190607162349.18199-1-john.ogness@linutronix.de
[2] https://lkml.kernel.org/r/20190727013333.11260-1-john.ogness@linutronix.de
[3] https://lkml.kernel.org/r/20190807222634.1723-1-john.ogness@linutronix.de
[4] https://lkml.kernel.org/r/20191128015235.12940-1-john.ogness@linutronix.de
[5] https://github.com/crash-utility/crash
[6] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de
[7] https://lkml.kernel.org/r/20191007120134.ciywr3wale4gxa6v@pathway.suse.cz

John Ogness (2):
  printk: add lockless buffer
  printk: use the lockless ringbuffer

 include/linux/kmsg_dump.h         |    2 -
 kernel/printk/Makefile            |    1 +
 kernel/printk/printk.c            |  836 +++++++++---------
 kernel/printk/printk_ringbuffer.c | 1370 +++++++++++++++++++++++++++++
 kernel/printk/printk_ringbuffer.h |  328 +++++++
 5 files changed, 2114 insertions(+), 423 deletions(-)
 create mode 100644 kernel/printk/printk_ringbuffer.c
 create mode 100644 kernel/printk/printk_ringbuffer.h

-- 
2.20.1

