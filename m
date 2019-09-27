Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495BDC0BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 20:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfI0SuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 14:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfI0SuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:50:10 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC9B420872;
        Fri, 27 Sep 2019 18:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569610209;
        bh=5ptR2aDyxkXJB4ofipoAdkxYsBbU2gX1Ul3jd/wm28c=;
        h=Subject:From:To:Date:From;
        b=rIk/VAWCvCBX3rFBzRZYyFRNpcWF4PTphFScVPyUGAhHd4Pn6MjPQPvSqkJQlz/WS
         PBpe5Neq4G8hxk9Ep79vhLHmu2cPjsPJErUfTZOfCI5I1/oh2bWyb9gIopDojMXRoz
         1+DdjRQa12WajCKLSphyx440+O9Tp4cxm0/oQT8g=
Message-ID: <1569610207.2984.5.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.146-rt67
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
Date:   Fri, 27 Sep 2019 13:50:07 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.146-rt67 stable release.

This release is just an update to the new stable 4.14.146
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: e3bd8fc2e828293163262f52cab0cd4beeae7f4c

Or to build 4.14.146-rt67 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.146.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.146-rt67.patch.xz

Enjoy!

   Tom
