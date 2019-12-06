Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5429B114F2B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 11:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfLFKrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 05:47:04 -0500
Received: from mail.monom.org ([188.138.9.77]:60908 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfLFKrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:47:03 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id CC686500518;
        Fri,  6 Dec 2019 11:47:01 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_MID autolearn=no autolearn_force=no version=3.4.2
Received: from localhost (b9168f78.cgn.dg-w.de [185.22.143.120])
        by mail.monom.org (Postfix) with ESMTPSA id 3DF92500243;
        Fri,  6 Dec 2019 11:47:01 +0100 (CET)
Date:   Fri, 06 Dec 2019 11:47:01 +0100
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.206-rt190
Data:   Fri, 06 Dec 2019 10:45:27 -0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>, Pavel Machek <pavel@denx.de>
Message-Id: <20191206104701.CC686500518@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.206-rt190 stable release.

This release is just an update to the new stable 4.4.206 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 6e21651a7aae9bcec1d261564c2b8038ef0cdca7

Or to build 4.4.206-rt190 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.206.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.206-rt190.patch.xz

Enjoy!
   Daniel
