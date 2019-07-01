Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 258B616D02
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 23:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfEGVSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 17:18:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbfEGVSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:18:01 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EACB2206A3;
        Tue,  7 May 2019 21:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557263880;
        bh=YLIDXlk7vf33uGJ4OmyE/Ux19bP+mR6qauEpC2zYtvE=;
        h=Subject:From:To:Cc:Date:From;
        b=VyHnEnNK3BmfE+LlOIW7Nh32EjssOcWHQueznsZWI5WYFaMaE2yplZkhI11JfuDh2
         lQq7xfuVRZ+oSrzt0Rlo6GmKCI/vhl/iigXrRYL450cQYIXf5qrhIqfzSjNiO3Jg2e
         OCKNEYvXyquPC6TdveQgyQenpn/ktZ6ju1yU7eVQ=
Message-ID: <1557263879.2167.3.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.115-rt59
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Julia Cartwright <julia@ni.com>
Date:   Tue, 07 May 2019 16:17:59 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.115-rt59 stable release.

This release is just an update to the new stable 4.14.115 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 9a1d3ac30fa261dc84546225f5b1683b0cb12464

Or to build 4.14.115-rt59 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.115.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.115-rt59.patch.xz


Enjoy!
   
   Tom
