Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B06975FE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 11:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfHUJYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 05:24:16 -0400
Received: from foss.arm.com ([217.140.110.172]:55040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfHUJYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:24:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9824428;
        Wed, 21 Aug 2019 02:24:14 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AADA3F706;
        Wed, 21 Aug 2019 02:24:13 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-rt-users@vger.kernel.org
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, maz@kernel.org,
        bigeasy@linutronix.de, rostedt@goodmis.org,
        Julien Grall <julien.grall@arm.com>
Subject: [RT PATCH 0/3] hrtimer: RT fixes for hrtimer_grab_expiry_lock()
Date:   Wed, 21 Aug 2019 10:24:06 +0100
Message-Id: <20190821092409.13225-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This small series contains a few fixes for the hrtimer code in RT linux
(v5.2.9-rt3-rebase).

The patch #2 contains a error I managed to reproduce. The other two are
were found while looking at the code.

Cheers,

Julien Grall (3):
  hrtimer: Use READ_ONCE to access timer->base in
    hrimer_grab_expiry_lock()
  hrtimer: Don't grab the expiry lock for non-soft hrtimer
  hrtimer: Prevent using uninitialized spin_lock in
    hrtimer_grab_expiry_lock()

 kernel/time/hrtimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.11.0

