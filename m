Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3E96BB8F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 13:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbfGQLhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 07:37:20 -0400
Received: from mail.monom.org ([188.138.9.77]:43202 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbfGQLhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 07:37:19 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id C991A50048A;
        Wed, 17 Jul 2019 13:37:17 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_MID autolearn=no autolearn_force=no version=3.4.2
Received: from localhost (b9168f23.cgn.dg-w.de [185.22.143.35])
        by mail.monom.org (Postfix) with ESMTPSA id 74843500294;
        Wed, 17 Jul 2019 13:37:17 +0200 (CEST)
Date:   Wed, 17 Jul 2019 13:37:17 +0200
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.185-rt184
Data:   Wed, 17 Jul 2019 11:28:31 -0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>, Pavel Machek <pavel@denx.de>
Message-Id: <20190717113717.C991A50048A@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.185-rt184 stable release.

This release is just an update to the new stable 4.4.185 version and
no RT specific changes have been made.

There were a couple of merge conflicts. Nothing too scary but please
verify the intermediated releases (v4.4.180-rt182 and v4.4.181-rt183)
if I fixed the merge conflicts correctly.

Known issues:

- The stable v4.4.178 update includes bdf3c006b9a2 ("vmstat: make
  vmstat_updater deferrable again and shut down on idle") which brakes
  -rt. f01f17d3705b ("mm, vmstat: make quiet_vmstat lighter") fixes
  this problem and was send to stable-rt but rejected. The patch
  brakes NVIDIAs Jetson hardware. More investigation or even better
  hardware to test is needed.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 7ccd9a25e258c003b801fb59492752efab279b2e

Or to build 4.4.185-rt184 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.185.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.185-rt184.patch.xz

Enjoy!
   Daniel
