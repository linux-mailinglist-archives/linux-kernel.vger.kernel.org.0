Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1388A6318
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 09:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfICHwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 03:52:23 -0400
Received: from mail.monom.org ([188.138.9.77]:57608 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfICHwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:52:23 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 587A6500696;
        Tue,  3 Sep 2019 09:52:21 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_MID autolearn=no autolearn_force=no version=3.4.2
Received: from localhost (b9168f76.cgn.dg-w.de [185.22.143.118])
        by mail.monom.org (Postfix) with ESMTPSA id C6A2B5001C9;
        Tue,  3 Sep 2019 09:52:20 +0200 (CEST)
Date:   Tue, 03 Sep 2019 09:52:20 +0200
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.190-rt187
Data:   Tue, 03 Sep 2019 07:40:28 -0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>, Pavel Machek <pavel@denx.de>
Message-Id: <20190903075221.587A6500696@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.190-rt187 stable release.

This release is just an update to the new stable 4.4.190 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: fe150dfd33d9f7e53823755788dd23bce58236bd

Or to build 4.4.190-rt187 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.190.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.190-rt187.patch.xz

Enjoy!
   Daniel
