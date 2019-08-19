Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9817D9219C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 12:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfHSKri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 06:47:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:57640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbfHSKrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:47:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C51EAB643;
        Mon, 19 Aug 2019 10:47:36 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/3] watchdog/softlockup: Make softlockup reports more reliable and useful
Date:   Mon, 19 Aug 2019 12:47:29 +0200
Message-Id: <20190819104732.20966-1-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

( Resending this as a proper patch with updated commit messages.
  The original was
  https://lkml.kernel.org/r/20190605140954.28471-1-pmladek@suse.com )

We were analyzing logs with several softlockup reports in flush_tlb_kernel_range().
They were confusing. Especially it was not clear whether it was deadlock,
livelock, or separate softlockups.

It went out that even a simple busy loop:

	while (true)
	      cpu_relax();

is able to produce several softlockups reports:

  [  168.277520] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
  [  196.277604] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
  [  236.277522] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [cat:4865]
                                                              ^^^^

This patchset fixes the problem in two steps:

+ 1st patch prevents restart of the watchdog from unrelated locations.
  Each softlockup is reported only once:

  [  320.248948] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4916]


+ 2nd patch helps to distinguish several possible situations by
  regular reports. The report looks like:

  [  480.372418] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4943]
  [  508.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 52s! [cat:4943]
  [  548.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 89s! [cat:4943]
  [  576.372351] watchdog: BUG: soft lockup - CPU#2 stuck for 115s! [cat:4943]
                                                              ^^^^^

3rd patch provides a sample code to trigger a softlockup.


Petr Mladek (3):
  watchdog/softlockup: Preserve original timestamp when touching
    watchdog externally
  watchdog/softlockup: Report the same softlockup regularly
  Test softlockup

 fs/proc/consoles.c |  5 ++++
 fs/proc/version.c  |  7 +++++
 kernel/watchdog.c  | 85 +++++++++++++++++++++++++++++++-----------------------
 3 files changed, 61 insertions(+), 36 deletions(-)

-- 
2.16.4

