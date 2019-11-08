Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A86F50AF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 17:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfKHQJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 11:09:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfKHQJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:09:22 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1DEB21D7E;
        Fri,  8 Nov 2019 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573229362;
        bh=Xx/dOL0IB3Zn0i/XEIYpwQcyG2ipCwckQcaDSe8MyEQ=;
        h=From:To:Cc:Subject:Date:From;
        b=IwfTLvOpmNe65vZ9/1Lw90eIhJ2W6SDEutPlEUDvqdziTPyMaAxJty/Aj1pKSl7Eo
         NMRDuFi+GKDZ1mlsBkhu3Riy9DUYZp16x5B/CLRDlnV1+wcVg2J4Ip7xi7FwmVF0WW
         Hf5XZ5bQnX0cGZDR/03qCcpjqOx940zQy0cRRJPc=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/4] irq_work: Fix ordering issue
Date:   Fri,  8 Nov 2019 17:08:54 +0100
Message-Id: <20191108160858.31665-1-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches 1 and 2 are the fix part, 3 is a cleanup, 4 is
extra-optimization (rfc).

Thanks to Paul that confirmed my doubts about ordering on cmpxchg() failure.

Frederic Weisbecker (4):
  irq_work: Convert flags to atomic_t
  irq_work: Fix irq_work_claim() ordering
  irq_work: Slightly simplify IRQ_WORK_PENDING clearing
  irq_work: Weaken ordering in irq_work_run_list()

 include/linux/irq_work.h | 10 +++++++---
 kernel/irq_work.c        | 35 ++++++++++++++---------------------
 kernel/printk/printk.c   |  2 +-
 3 files changed, 22 insertions(+), 25 deletions(-)

-- 
2.23.0

