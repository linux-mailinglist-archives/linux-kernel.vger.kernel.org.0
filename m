Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611451949A2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 21:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgCZU4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 16:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgCZU4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:56:45 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51ADD20722;
        Thu, 26 Mar 2020 20:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585256205;
        bh=iiSdTqkLDRwK7LvruCCeWue1ynuARz02GYEhyA4VgFU=;
        h=Subject:From:To:Date:From;
        b=OTk5eiK1JUQJhNTQUIz6M5fMaeBclE7EI2irNPU9LcqX1Sa6dGe8o4gY7zOzzZ3xb
         6ePVUl1W+nX32Nvo3h701tCET6f7IKfum+OyQuH3jQDKCYbAa8NtYN6qttzJw/QKpE
         d/1TnKRgm5/hj1FNk0N65pLmKKS7uAhVyBYdX6bE=
Message-ID: <91b23f5a400f433a262a54716a39c3489e2bde23.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.174-rt79
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
Date:   Thu, 26 Mar 2020 15:56:43 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.174-rt79 stable release.

This release is just an update to the new stable 4.14.174
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 6345c1bdf52c25e579c9804e8410d75b1c618b2e

Or to build 4.14.174-rt79 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.174.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.174-rt79.patch.xz

Enjoy!

   Tom

