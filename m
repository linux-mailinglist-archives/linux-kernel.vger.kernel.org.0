Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7F3228B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 22:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388048AbfEWUcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 16:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387666AbfEWUcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:32:11 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B95DE2175B;
        Thu, 23 May 2019 20:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558643530;
        bh=NElWUzJvif1deH6MO8Vjb5akrs/yWZctQSPiNSP6HTQ=;
        h=Subject:From:To:Date:From;
        b=cuuuCEyaO0+tVw1eQ0dQR8jPOtypqqL8Cc8zic90c7MmH6RxafnnFzEZe06rXWdC2
         kqBah+LhE21Q4qImSE9Aqff5WyHEK1R5n1UwJZDqZu9+nXzOcRN/Qwsd97JmP0mDcl
         gtjvqqDnc3vS/rXMLxhdMB+udIeCjrPY0B0PN428=
Message-ID: <1558643528.2934.3.camel@kernel.org>
Subject: [ANNOUNCE] 3.18.140-rt117
From:   Tom Zanussi <zanussi@kernel.org>
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
Date:   Thu, 23 May 2019 15:32:08 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 3.18.140-rt117 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt-rebase
  Head SHA1: f7fa9a750011e58fbc407b2cd6e58207a187f4b9

Or to build 3.18.140-rt117 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  https://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.140.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.140-rt117.patch.xz


Enjoy!

   Tom
