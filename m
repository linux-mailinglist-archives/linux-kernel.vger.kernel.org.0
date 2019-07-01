Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E8D12281
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 21:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEBTQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 15:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBTQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:16:02 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7FC72081C;
        Thu,  2 May 2019 19:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556824561;
        bh=zy/1znpb3qH9WbV7S/PVCYknNXVm9bYSk7gKgBnxCmQ=;
        h=From:To:Subject:Date:From;
        b=cNAzpwKjrX2RNH/V9waM1B2GSTZqxh6ZE3Mmh9l24o49izD1uTEcsu6OX99GSxI9B
         kzOcbzD3vqY+UeDQbXHgYZznfithLXSaAIdETQH7L3MltTMSxqVVF0I6d02I7oLWO+
         PvK+nvKlQ7bP5F8FZkjnQo+sYuKyjSyTiaVvgZvo=
From:   zanussi@kernel.org
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
Subject: [PATCH RT 0/4] Linux v3.18.138-rt116-rc1
Date:   Thu,  2 May 2019 14:15:35 -0500
Message-Id: <cover.1556824516.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Dear RT Folks,

This is the RT stable review cycle of patch 3.18.138-rt116-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2019-05-09.

To build 3.18.138-rt116-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  https://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.138.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.138-rt116-rc1.patch.xz

You can also build from 3.18.138-rt115 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.138-rt115-rt116-rc1.patch.xz


Enjoy,

-- Tom


Julien Grall (1):
  tty/sysrq: Convert show_lock to raw_spinlock_t

Sebastian Andrzej Siewior (2):
  softirq: Avoid "local_softirq_pending" messages if ksoftirqd is
    blocked
  powerpc/pseries/iommu: Use a locallock instead local_irq_save()

Tom Zanussi (1):
  Linux 3.18.138-rt116-rc1

 arch/powerpc/platforms/pseries/iommu.c | 16 ++++++----
 drivers/tty/sysrq.c                    |  6 ++--
 kernel/softirq.c                       | 57 ++++++++++++++++++++++++----------
 localversion-rt                        |  2 +-
 4 files changed, 55 insertions(+), 26 deletions(-)

-- 
2.14.1

