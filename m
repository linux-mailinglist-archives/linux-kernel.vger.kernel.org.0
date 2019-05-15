Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1E081E9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 10:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfEOIA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 04:00:29 -0400
Received: from mail.monom.org ([188.138.9.77]:53992 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfEOIA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:00:29 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 862D450065D;
        Wed, 15 May 2019 10:00:27 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_MID autolearn=no autolearn_force=no version=3.4.2
Received: from localhost (ppp-93-104-188-73.dynamic.mnet-online.de [93.104.188.73])
        by mail.monom.org (Postfix) with ESMTPSA id 8F549500222;
        Wed, 15 May 2019 10:00:26 +0200 (CEST)
Date:   Wed, 15 May 2019 10:00:25 +0200
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.179-rt181
Data:   Wed, 15 May 2019 07:52:02 -0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Message-Id: <20190515080027.862D450065D@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.179-rt181 stable release. This release
is just an update to the new stable v4.4.179 version and no RT specific
changes have been made.

You'll notice there is also a v4.4.178-rt180 release available. The
stable v4.4.178 update includes bdf3c006b9a2 ("vmstat: make
vmstat_updater deferrable again and shut down on idle") which brakes
-rt. f01f17d3705b ("mm, vmstat: make quiet_vmstat lighter") fixes this
problem; it's part of the -rt1181 release. Furthermore, Greg queued up
in the patch and it will be part of the next stable v4.4.y release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 0da4f74126bb1ff309a97bacd0c7a2fbb8d42553

Or to build 4.4.179-rt181 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.179.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.179-rt181.patch.xz


Enjoy!
   Daniel
