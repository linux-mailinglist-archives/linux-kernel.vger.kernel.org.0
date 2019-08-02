Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5058800A9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 21:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391651AbfHBTHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 15:07:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41208 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfHBTHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:07:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id t187so2946758qke.8;
        Fri, 02 Aug 2019 12:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yXeb/334wdusxPScUNzeSB+PGSbTfn0Z0UcuX0+E19Y=;
        b=DKdDnqLHmtUZamMODcolZy2NsTJmTvlAo4dETivNrXpPSId26Pu/lrdh3sTdx9iLDp
         I5wA7tvbKQDZ7yEEksTL89QpdOskzS9vJIGD6PuT9JyhZ9Hcv5ENdJFt/jePUunm1ynB
         +P3M+rh9PFrQni/8WxvcBmPvaPWPK4egT3V6z/mhmP9J9ZKvywrnPczayXZaf3CNLMzo
         xAx0nvYPMa+KBCP//afrqsW+hdeJlCQvbPB8FoYpoGDXGdeLTlsO/Anhj0qiBKWAuWfR
         pJgeZjFxheT+SFBluFhVx0eQ59C6Pbd6jGik/hBHXUVWF13jKIUveDkXfLYjCwskD4W5
         2DiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=yXeb/334wdusxPScUNzeSB+PGSbTfn0Z0UcuX0+E19Y=;
        b=YmRpcwlB17pslOHMcKrMfOATdbw6MWEPNtV7gowevCCOjGx9weQ9WRUpNn6rkGeWYY
         qsUl/GA72EOo+C7kq3gh1ssqKK7VLrQM2o/CpAKwewWzPjIIR6jY4H8QGRoXClScV2LP
         5vq0rPy8bWenur4Wpcllmu0wte8wJ/30dp5d3Skm2GqOzHZOCK86AGKTGsb9kuVYo0oj
         snxw/+5fMxnGaFcDR66SJ8oNQjk1RxWMs5A9XdJNmmk0C8v6H5yducATvL1vuxiq49Ya
         i7RBoO5zYvyZtP94KDS6nEc7sVKApqDOkpR/sRF4QZC7N4L6z5XvhdaBE9/0Wn8UHi0g
         OqUw==
X-Gm-Message-State: APjAAAVIB/J1HJ5snL8CuFqqulzsfnXO3xC12emn+6iBCwMoSPkF4f81
        KqLaVnKDbWvQe4KNprYUjzc=
X-Google-Smtp-Source: APXvYqwPMp4vGeLuJNJCyZpAYXlBEK1tAZkakV+YN1LKa4qnEik64q77D0iISDarNfWmaNCwYUjaPQ==
X-Received: by 2002:a37:5f82:: with SMTP id t124mr83228741qkb.180.1564772862217;
        Fri, 02 Aug 2019 12:07:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::38f0])
        by smtp.gmail.com with ESMTPSA id k38sm42106580qtk.10.2019.08.02.12.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 12:07:41 -0700 (PDT)
Date:   Fri, 2 Aug 2019 12:07:38 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH block 1/2] writeback, cgroup: Adjust WB_FRN_TIME_CUT_DIV to
 accelerate foreign inode switching
Message-ID: <20190802190738.GB136335@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WB_FRN_TIME_CUT_DIV is used to tell the foreign inode detection logic
to ignore short writeback rounds to prevent getting confused by a
burst of short writebacks.  The parameter is currently 2 meaning that
anything smaller than half of the running average writback duration
will be ignored.

This is unnecessarily aggressive.  The detection logic uses 16 history
slots and is already reasonably protected against some short bursts
confusing it and the current parameter can lead to tens of seconds of
missed detection depending on the writeback pattern.

Let's change the parameter to 8, so that it only ignores writeback
with are smaller than 12.5% of the current running average.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 fs/fs-writeback.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -227,7 +227,7 @@ static void wb_wait_for_completion(struc
 /* parameters for foreign inode detection, see wb_detach_inode() */
 #define WB_FRN_TIME_SHIFT	13	/* 1s = 2^13, upto 8 secs w/ 16bit */
 #define WB_FRN_TIME_AVG_SHIFT	3	/* avg = avg * 7/8 + new * 1/8 */
-#define WB_FRN_TIME_CUT_DIV	2	/* ignore rounds < avg / 2 */
+#define WB_FRN_TIME_CUT_DIV	8	/* ignore rounds < avg / 8 */
 #define WB_FRN_TIME_PERIOD	(2 * (1 << WB_FRN_TIME_SHIFT))	/* 2s */
 
 #define WB_FRN_HIST_SLOTS	16	/* inode->i_wb_frn_history is 16bit */
