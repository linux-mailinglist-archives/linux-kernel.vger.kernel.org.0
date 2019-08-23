Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09A949B70A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 21:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391551AbfHWT2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 15:28:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbfHWT2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 15:28:50 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F23A421874;
        Fri, 23 Aug 2019 19:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566588529;
        bh=U/A0momVqhHaFlm7Hx1Y+nXg1DiM3+yBHhPlu6jm9N0=;
        h=Subject:From:To:Date:From;
        b=nsomjWOqMsAxjQ1VYs8nJ339Cpcf8IUcOkPhhrfFUxC43FVpT5c4Fkq/ON3N1R7gr
         wysvNNGlxt9fMWDZE7EsGO6y1UlZU1HYKxuOKz1t6uLPRbwA1lQYD15oyoY1RxYQlV
         HedH3SkOUU65CV2WGF8X/2CpFoai+IVJJYSfI2EY=
Message-ID: <1566588528.26856.11.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.139-rt66
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Date:   Fri, 23 Aug 2019 14:28:48 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.139-rt66 stable release.

This release is just an update to the new stable 4.14.139
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: a201ac2897512d77f5984a2618ebbb3a84f29d5e

Or to build 4.14.139-rt66 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.139.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.139-rt66.patch.xz

Enjoy!

   Tom
