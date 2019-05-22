Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC36D26825
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 18:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfEVQYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 12:24:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42668 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729475AbfEVQYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:24:53 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4MGOiAF001557
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 May 2019 12:24:45 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 528AF420481; Wed, 22 May 2019 12:24:44 -0400 (EDT)
Date:   Wed, 22 May 2019 12:24:44 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: Re: eb9d1bf079 [   88.881528] EIP: _random_read
Message-ID: <20190522162444.GB2744@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        kernel test robot <rong.a.chen@intel.com>,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>
References: <20190516071405.GO31424@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516071405.GO31424@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you check and see if this addresses the issue?  I'm not able to
easily repro the softlockup.

Thanks!

						- Ted

commit f93d3e94983bf8b4697ceb121c79afd941862860
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Wed May 22 12:02:16 2019 -0400

    random: fix soft lockup when trying to read from an uninitialized blocking pool
    
    Fixes: eb9d1bf079bb: "random: only read from /dev/random after its pool has received 128 bits"
    Reported-by: kernel test robot <lkp@intel.com>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a42b3d764da8..9cea93d0bfb3 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1936,8 +1936,8 @@ _random_read(int nonblock, char __user *buf, size_t nbytes)
 			return -EAGAIN;
 
 		wait_event_interruptible(random_read_wait,
-			ENTROPY_BITS(&input_pool) >=
-			random_read_wakeup_bits);
+		    blocking_pool.initialized &&
+		    (ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits));
 		if (signal_pending(current))
 			return -ERESTARTSYS;
 	}
