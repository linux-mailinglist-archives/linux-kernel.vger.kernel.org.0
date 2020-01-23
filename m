Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 283E1146FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 18:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgAWR1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 12:27:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgAWR1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:27:08 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93AD521569;
        Thu, 23 Jan 2020 17:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579800427;
        bh=GSo5r3TWjpardWgDCzGMqZYl5XSsfkEFRtnZtAa6WCc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=AW0ZTo3ER/ioiD9u1ciduDzGBqLu2/pThLU/IrA7YWmM8jmQ08YzdRdlEUsHM5Ms9
         uL8sQroxU6wOI+/oAJv14TCP9nY5uoGNjr2sYnIH8yPPlcr9yFeyXFeJrcxJGhWgkL
         HXztwLsC27xk/4bJmEU8rQ0YYDqfgECakun3Emv0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6BA923520C31; Thu, 23 Jan 2020 09:27:07 -0800 (PST)
Date:   Thu, 23 Jan 2020 09:27:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     dave@stgolabs.net, josh@joshtriplett.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, peterz@infradead.org
Subject: [PATCH RFC locktorture] Print ratio of acquisitions, not failures
Message-ID: <20200123172707.GA24441@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __torture_print_stats() function in locktorture.c carefully
initializes local variable "min" to statp[0].n_lock_acquired, but
then compares it to statp[i].n_lock_fail.  Given that the .n_lock_fail
field should normally be zero, and given the initialization, it seems
reasonable to display the maximum and minimum number acquisitions
instead of miscomputing the maximum and minimum number of failures.
This commit therefore switches from failures to acquisitions.

Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Peter Zijlstra <peterz@infradead.org>

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 99475a6..687c1d8 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -696,10 +696,10 @@ static void __torture_print_stats(char *page,
 		if (statp[i].n_lock_fail)
 			fail = true;
 		sum += statp[i].n_lock_acquired;
-		if (max < statp[i].n_lock_fail)
-			max = statp[i].n_lock_fail;
-		if (min > statp[i].n_lock_fail)
-			min = statp[i].n_lock_fail;
+		if (max < statp[i].n_lock_acquired)
+			max = statp[i].n_lock_acquired;
+		if (min > statp[i].n_lock_acquired)
+			min = statp[i].n_lock_acquired;
 	}
 	page += sprintf(page,
 			"%s:  Total: %lld  Max/Min: %ld/%ld %s  Fail: %d %s\n",
