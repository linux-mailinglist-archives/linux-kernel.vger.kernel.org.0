Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD2613729D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 17:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgAJQQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 11:16:21 -0500
Received: from mail.monom.org ([188.138.9.77]:60308 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbgAJQQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:16:20 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id C0A4D50036A;
        Fri, 10 Jan 2020 17:16:18 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_MID autolearn=no autolearn_force=no version=3.4.2
Received: from localhost (b9168f78.cgn.dg-w.de [185.22.143.120])
        by mail.monom.org (Postfix) with ESMTPSA id 347E3500190;
        Fri, 10 Jan 2020 17:16:18 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:16:17 +0100
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.208-rt191
Data:   Fri, 10 Jan 2020 16:12:17 -0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>, Pavel Machek <pavel@denx.de>
Message-Id: <20200110161618.C0A4D50036A@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.208-rt191 stable release.

This release is just an update to the new stable 4.4.208 version
and no RT specific changes have been made.

Note the patch "x86/ioapic: Do not unmask io_apic when interrupt is in
progress" has been dropped from the queue because stable gained the
commit 2d63906f8a78 ("x86/ioapic: Prevent inconsistent state when
moving an interrupt").

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: ba5eb0751f977d70dc5843195072547acf2de362

Or to build 4.4.208-rt191 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.208.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.208-rt191.patch.xz

Enjoy!
   Daniel
