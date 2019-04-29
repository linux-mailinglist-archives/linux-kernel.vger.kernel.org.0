Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A95F5E348
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 15:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfD2NJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 09:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfD2NJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 09:09:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AFD42084B;
        Mon, 29 Apr 2019 13:09:22 +0000 (UTC)
Date:   Mon, 29 Apr 2019 09:09:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [ANNOUNCE] 4.9.170-rt129
Message-ID: <20190429090920.53c8c1a1@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.9.170-rt129 stable release.


This release is just an update to the new stable 4.9.170 version
and no RT specific changes have been made.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: dc5db1cbfebf8571ecf5837e42013639d11f3e74


Or to build 4.9.170-rt129 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.170.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.170-rt129.patch.xz




Enjoy,

-- Steve

