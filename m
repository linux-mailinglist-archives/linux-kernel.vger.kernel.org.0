Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B47A1CA3AE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 18:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfJCQR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 12:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389349AbfJCQRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:17:54 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11C6A215EA;
        Thu,  3 Oct 2019 16:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119473;
        bh=FERkCSeCrTfeA7B2Qv/31CeQdyCYPtev+CqxmGRT/hQ=;
        h=From:To:Cc:Subject:Date:From;
        b=l/z3fhRPTCw2Y7dHHmkDZx8PVF2MLMwofuA1vBfi5IjMaa+vFG+JtkBCCAL8f6If8
         eayCiWI4iyKiyr85gyQ3RKeATIZJ8RutysJUziJGRfuqAwdouYnB6ZByk0xPhd/C4+
         frbm2d4k57p/VfRX4JvUg/0+ZqgagDUuDzLNwE/k=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Rik van Riel <riel@redhat.com>
Subject: [PATCH 0/2] vtime: Remove pair of seqcount on context switch
Date:   Thu,  3 Oct 2019 18:17:43 +0200
Message-Id: <20191003161745.28464-1-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extracted from a larger queue that fixes kcpustat on nohz_full, these
two patches have value on their own as they remove two write barriers
on nohz_full context switch.

Frederic Weisbecker (2):
  vtime: Rename vtime_account_system() to vtime_account_kernel()
  vtime: Spare a seqcount lock/unlock cycle on context switch

 arch/ia64/kernel/time.c          |  4 +--
 arch/powerpc/kernel/time.c       |  6 ++--
 arch/s390/kernel/vtime.c         |  4 +--
 include/linux/context_tracking.h |  4 +--
 include/linux/vtime.h            | 38 ++++++++++++------------
 kernel/sched/cputime.c           | 50 ++++++++++++++++++--------------
 6 files changed, 57 insertions(+), 49 deletions(-)

-- 
2.23.0

