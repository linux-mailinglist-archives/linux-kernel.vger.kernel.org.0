Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65EB186AB3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 21:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390242AbfHHToQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 15:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730768AbfHHToQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:44:16 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ADC62173E;
        Thu,  8 Aug 2019 19:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565293455;
        bh=OQrIwJerPWfoySkt0blmJAgpcXMR3umUGbRJrpHLS4U=;
        h=Subject:From:To:Date:From;
        b=pL9LX3dk6VjvCGyLizf4P3MedKWWltByH8Z2N3R6HG8aW/DW0/k/k0PaSjQtYPTJ+
         gX6QNHuiCbzvDrgBoMXFg/fgobVCqWmWdqKHtanHjKNCx/1WQ0lL6coYkSwCpLJXlE
         nwai2OElsqq7Az5mBHUUlfVqYX4vP5aq2eHf7JuQ=
Message-ID: <1565293453.2623.4.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.137-rt64
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
Date:   Thu, 08 Aug 2019 14:44:13 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.137-rt64 stable release.

This release is just an update to the new stable 4.14.137
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: b86042812cec9871bba4a0da843cccdc77682ee3

Or to build 4.14.137-rt64 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.137.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.137-rt64.patch.xz

Enjoy!

   Tom
