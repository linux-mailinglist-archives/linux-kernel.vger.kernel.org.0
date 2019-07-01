Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBD0346D4F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2019 02:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfFOAwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 20:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfFOAwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 20:52:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A8FC2183F;
        Sat, 15 Jun 2019 00:52:43 +0000 (UTC)
Date:   Fri, 14 Jun 2019 20:52:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [ANNOUNCE] 4.19.50-rt22
Message-ID: <20190614205241.2ad1d103@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.19.50-rt22 stable release.

This release is just an update to the new stable 4.19.50 version
and no RT specific changes have been made.

*** NOTE ***

The 4.19 stable fixed a "use after free" bug in kernel/irq/manage.c,
which was the use case of implementing a new work queue and removing
the old one. But if the old one was in transit, the data could be used
after it was freed. This was fixed in stable by canceling the work
before freeing it. The problem is that RT uses swork instead of the
normal work queues, and swork does not implement a cancel operation.

I simply kept the bug in as is (no regressions, it will fail just like
it has always done ;-). Then I will need to backport the rt-devel code
which makes it possible to use normal work queues in interrupt context.
But that change was too big for a "stable merge" release.

************


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 858848641fbecd42437e36adc9291b0ce5db379e


Or to build 4.19.50-rt22 directly, the following patches should be
applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.50.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.50-rt22.patch.xz




Enjoy,

-- Steve

