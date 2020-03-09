Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB5C017E915
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 20:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgCITsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 15:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgCITsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:48:15 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F247420828;
        Mon,  9 Mar 2020 19:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583783294;
        bh=jkfB9NPaUoTZdcxqmU3FXV9oQzJGdB+CktplixLqUn0=;
        h=From:To:Subject:Date:From;
        b=EPx3cJuDZgFXVT/4XKvnEAY7Qu7neXFRXmp0rq5aCcB9KLzavlQNjCCdMH0xD/8D2
         DVH/1S4TMklpDtPhSE5bC2wEg2Iu196aQd5JZYPFvjnISlBCFYLh7GLe13I3TtCjHQ
         tICvbiHXyjU5PKjNJkIrFbRsEjPFDXKzcJI4gV4g=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 0/8] Linux v4.14.172-rt78-rc1
Date:   Mon,  9 Mar 2020 14:47:45 -0500
Message-Id: <cover.1583783251.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 4.14.172-rt78-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2020-03-16.

To build 4.14.172-rt78-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.172.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.172-rt78-rc1.patch.xz

You can also build from 4.14.172-rt77 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.172-rt77-rt78-rc1.patch.xz


Enjoy,

-- Tom


Matt Fleming (1):
  mm/memcontrol: Move misplaced local_unlock_irqrestore()

Scott Wood (2):
  sched: migrate_enable: Use per-cpu cpu_stop_work
  sched: migrate_enable: Remove __schedule() call

Sebastian Andrzej Siewior (4):
  userfaultfd: Use a seqlock instead of seqcount
  locallock: Include header for the `current' macro
  drm/vmwgfx: Drop preempt_disable() in vmw_fifo_ping_host()
  tracing: make preempt_lazy and migrate_disable counter smaller

Tom Zanussi (1):
  Linux 4.14.172-rt78-rc1

 drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c |  2 --
 fs/userfaultfd.c                     | 12 ++++++------
 include/linux/locallock.h            |  1 +
 include/linux/trace_events.h         |  3 +--
 kernel/sched/core.c                  | 23 ++++++++++++++---------
 kernel/trace/trace_events.c          |  4 ++--
 localversion-rt                      |  2 +-
 mm/memcontrol.c                      |  2 +-
 8 files changed, 26 insertions(+), 23 deletions(-)

-- 
2.14.1

