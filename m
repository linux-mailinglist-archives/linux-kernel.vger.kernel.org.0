Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3373FD82E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 09:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKOI44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 03:56:56 -0500
Received: from mail.monom.org ([188.138.9.77]:49562 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOI4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:56:55 -0500
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Nov 2019 03:56:55 EST
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id D37BC50064D;
        Fri, 15 Nov 2019 09:48:34 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_MID autolearn=no autolearn_force=no version=3.4.2
Received: from localhost (b9168fab.cgn.dg-w.de [185.22.143.171])
        by mail.monom.org (Postfix) with ESMTPSA id 535655004AF;
        Fri, 15 Nov 2019 09:48:34 +0100 (CET)
Date:   Fri, 15 Nov 2019 09:48:33 +0100
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.201-rt189
Data:   Fri, 15 Nov 2019 08:39:05 -0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>, Pavel Machek <pavel@denx.de>
Message-Id: <20191115084834.D37BC50064D@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.201-rt189 stable release.

This release is just an update to the new stable 4.4.201 version and
no RT specific changes have been made. -rt188 points to the tiny merge
conflict in a Makefile, just in case you are wondering.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: fd812331da09b85713fdb0f3ce44640180dfad97

Or to build 4.4.201-rt189 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.201.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.201-rt189.patch.xz

Enjoy!
   Daniel
