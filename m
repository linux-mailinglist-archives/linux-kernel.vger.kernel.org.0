Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D918B4350
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 23:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfIPVjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 17:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfIPVjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:39:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F0D220644;
        Mon, 16 Sep 2019 21:39:22 +0000 (UTC)
Date:   Mon, 16 Sep 2019 17:39:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>, tom.zanussi@linux.intel.com
Subject: [ANNOUNCE] 4.19.72-rt25
Message-ID: <20190916173921.6368cd62@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.19.72-rt25 stable release.

**** <NOTE> ****

As you probably have noticed, it has been a long time since I released
a stable 4.19-rt. The reason for this delay is that one of my tests
failed after merging with the latest stable upstream. I refuse to push
releases with a known bug in it, so I figured I would find the bug
before releasing. I only spend around 4 to 6 hours a week on upstream
stable RT as I have other responsibilities, and I could not debug this
bug during that time (after several weeks of trying).

The bug is a random NULL pointer dereference that only happens with
lockdep enabled and on 32bit x86. I also found that this bug existed
before the latest stable pull release but now it is much easier to
trigger.

I have not been able to trigger this bug in the 64 bit kernel, and as I
rather do a release than waste more time on this bug and postpone the
release further, I am now doing that. As a consequence, I am no longer
supporting 32bit x86, as it is known to have this bug.

If you are interested in this, I am willing to send out the config I am
using and one of the dmesg crashes. Just ask.

**** </NOTE> ****


This release is just an update to the new stable 4.19.72 version
and no RT specific changes have been made.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 9cd04ab6a9a162ac4189a80032261d243563ff45


Or to build 4.19.72-rt25 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.72.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.72-rt25.patch.xz




Enjoy,

-- Steve

