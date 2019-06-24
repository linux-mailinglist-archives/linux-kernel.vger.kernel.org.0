Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2E551C99
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 22:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbfFXUwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 16:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731382AbfFXUwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:52:07 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4A1C20665;
        Mon, 24 Jun 2019 20:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561409526;
        bh=iGNo9f0AIOmNbmZGf7xxru2gwdrvV3R+McATkxfXFHI=;
        h=Subject:From:To:Date:From;
        b=q0yjIW+gA8s/voDgwif9ZDlehtExrfnBhJRvxg88LVclO9K2vsUfybnwzuZqawMus
         7T2GQESfRqG+noi6+BInkrNZ1xF1scvKAzjPF0qrwS3xs0KGAhK941CKctNpwbNg8t
         sqAq2ZlhR0pNqfC+HvsYq93ex8rDJqubgMTib79c=
Message-ID: <1561409524.2683.4.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.126-rt62
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
Date:   Mon, 24 Jun 2019 15:52:04 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.126-rt62 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 443d081040ed8ad39053c084de4e6c3a54856529

Or to build 4.14.126-rt62 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.126.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.126-rt62.patch.xz

NOTE: This release contains the stable commit 5f138462c396 [genirq:
Prevent use-after-free and work list corruption] which doesn't apply
to RT since RT uses swork and doesn't implement the normal cancel
operation.  So this release doesn't fix that problem, which will
require backporting a few patches for the next 4.14 stable-rt backport
release.


Enjoy!

   Tom
