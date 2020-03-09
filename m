Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEC517E398
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 16:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCIP2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 11:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgCIP2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:28:09 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A08452067C;
        Mon,  9 Mar 2020 15:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583767689;
        bh=iy97d7AS4hYZuiyT/+Gw8fkHNWhIyI3IitaWPoCESL8=;
        h=Subject:From:To:Date:From;
        b=q+NXa7aJoQ73EDTjfiazNleh3Ydr9I4IfrGC7f3iKYVBmx3k0L1g9kIor7gpHDmvE
         cXuzKHbef5iW/985zNGIsUi9Pvrs+kuDyKdNPGmf9r7MbZ7IaaB8d/rOoHXHwOKeqr
         jjFJxC/f/jN9oE/pO5CFuyaKeB+9d91gx+g0w50w=
Message-ID: <1583767687.2254.2.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.172-rt77
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
Date:   Mon, 09 Mar 2020 10:28:07 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.172-rt77 stable release.

This release is just an update to the new stable 4.14.172
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 6ae1399d6477ace1a9629b3cb0c6f3ac2722c405

Or to build 4.14.172-rt77 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.172.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.172-rt77.patch.xz

Enjoy!

   Tom
