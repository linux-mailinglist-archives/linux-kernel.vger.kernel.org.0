Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6890318EE85
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 04:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgCWDcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 23:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgCWDcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 23:32:15 -0400
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F91720724;
        Mon, 23 Mar 2020 03:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584934335;
        bh=SR0y8/2/npMvAuUD12YQ8fKc3Cl8F903nYFcvJG2bLY=;
        h=From:To:Cc:Subject:Date:From;
        b=RHI7VrucIOnkf64qVlc6u07IEuxsHovvNrVSW08ac/ycYiOcE7RmUZv5r4Ui8EWwN
         Jh3P4FZehOCRRhC9nkm/TavMzyWW5LtjyNzbi1oMTyzAhrv05yT1HgrFSBEm8qgN40
         coVaxUCxk8WsYaVRZB0K933S3TLwSF7ah9VRCWLo=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 0/3] lockdep/irq: wait-type related cleanups
Date:   Mon, 23 Mar 2020 04:32:04 +0100
Message-Id: <20200323033207.32370-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few cleanups after reviewing the wait-type related changes.
It's RFC since I might not have guessed correctly all your aims.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	locking/core

HEAD: 2324f8c6891a858aa1c61933489ebc266282e67f

Thanks,
	Frederic
---

Frederic Weisbecker (3):
      lockdep/irq: Be more strict about IRQ-threadable code end
      lockdep: Merge hardirq_threaded and irq_config together
      lockdep: Briefly comment current->hardirq_threadable usecases


 include/linux/irqflags.h       | 80 +++++++++++++++++++-----------------------
 include/linux/sched.h          |  3 +-
 kernel/irq/handle.c            | 12 +++++--
 kernel/locking/lockdep.c       |  2 +-
 kernel/time/posix-cpu-timers.c |  7 ++--
 kernel/time/tick-sched.c       |  4 +++
 6 files changed, 56 insertions(+), 52 deletions(-)
