Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8582587E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 21:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfEUTyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 15:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfEUTyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 15:54:54 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3724217D7;
        Tue, 21 May 2019 19:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558468493;
        bh=h1xx92l5nqd/qYNS+wyRkS2AwUm9f2Ch9PbuYX/0z7U=;
        h=Subject:From:To:Date:From;
        b=P76UUBQEGfSDa25/fzsc/iQUoYkPFhwUkIvIMdgGqGITF2+TzKDfocZXk3bZqhK98
         CSGgz4wI2OMTg1OlalneC/U7jZOFXWAqqFMuFAgeCWSHCg/0nYLuI1BMBdC+6UGsc8
         KvO+eDBmv/sAMPZrsHShKoHnJuPF1brXlwlMwbXU=
Message-ID: <1558468491.3056.6.camel@kernel.org>
Subject: [ANNOUNCE] 3.18.138-rt116
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
Date:   Tue, 21 May 2019 14:54:51 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 3.18.138-rt116 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: 32e860e0679fce1ccfa8395df41f8790e24172b6

Or to build 3.18.138-rt116 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  https://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.138.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.138-rt116.patch.xz


You can also build from 3.18.138-rt115 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.138-rt115-rt116.patch.xz

Enjoy!

   Tom
