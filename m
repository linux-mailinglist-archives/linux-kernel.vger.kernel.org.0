Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 252C910F253
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 22:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfLBVrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 16:47:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfLBVrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:47:02 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3CDE20705;
        Mon,  2 Dec 2019 21:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575323221;
        bh=bgMgj4k2UecyY3AWQVMc128zn5HGkTSDwtH4A4TuZ6g=;
        h=Subject:From:To:Date:From;
        b=hv98VLOQWElQlDECYtAdFXPPVXhBwXw6F3L8cyJ60++7qFsookhq/dizbwRHjIeAA
         obWT+x4UXjOxGNyNtsNEmI4wMOaxYjDt+XaVrnFQudNg+jIDzlNDH/2v4FTEbq2Zpi
         I+sNj8e4b9iulGP5+IiuCTq82S+KaZU4xzttPjkU=
Message-ID: <1575323220.2386.17.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.155-rt70
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Mon, 02 Dec 2019 15:47:00 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.155-rt70 stable release.

This release is just an update to the new stable 4.14.155
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 7f79da3081404c0b0118ff4b9a241dbf9cfbe4b4

Or to build 4.14.155-rt70 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.155.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.155-rt70.patch.xz

Enjoy!

   Tom
