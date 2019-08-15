Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80FF28F47A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 21:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbfHOTZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 15:25:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38086 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbfHOTZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:25:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id x4so3537596qts.5;
        Thu, 15 Aug 2019 12:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VqHwIynmGrKgqY+nHdfPQktZY37Sg0s5gGwFKh7tZZA=;
        b=ah3cZCrDLz+hC9ug8hgYGTl8gXP1zafRFk2hKslTt9xpBrwf+o4L1cVWCz9ZTFadP9
         uqbweIXyXAnQRAR8KS/9CQbNQ2Ifp+PvcgieV52JZapVueVkVFXnz3wq2v3A7y62jEvX
         GoSZHLESJLRnXCaW66Gl5WrRWSxmluaR6qzoSIBJ+Y9fnEMLrmXVqgJxDyMtU5MdQhBV
         m/Ld/N5QzGwF6L8WVonGM78+NODF4H6l2FtHWeCjbsB/cdymv9J8pspEJB3Uh2KCyl20
         xq4HelVmj+8kKO2D3mFpGtfM9YL1wQqPd875auUKl5/L1viQWjxJ88iDjkfAXVDXCU+O
         xq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VqHwIynmGrKgqY+nHdfPQktZY37Sg0s5gGwFKh7tZZA=;
        b=P5UBfklpKVN1mZPA/XeVH5ItAUEuf4Gr0uZfWUT9YEIvGMSS/b+Clgs75Hg7ACHvl7
         0we1ifir838fuvuVlBl8Us+00q1OGb7PsS3t4OWBlAe+jBWvehbAXIg8bAUJV7XcvB1B
         89MZ7OhmMWJrv9D2XB6Ehhh7n00uZKOSNSliwd99fgTONpBtXi5NvAY7uNdpnooSGWdT
         DOJ9M66QsO7g7vVzDJxoBmZhpJc7jsUm4r2WbWl2K/JkfB1QFsPjHIKIY5FCrUf07Yvh
         DPbLuwpjymAueWVaZy8GvJQ5A168PEt0wF3p67u7PYVMCtjTZ1HcVfw5fIPX+zPALuC6
         1+FA==
X-Gm-Message-State: APjAAAURS6LxYhCaiFtfCNCA2T9gIZEx8mMARie2hqPjzWGYZIxkbpIt
        cuBXzQBMMU2A4dfPYt0u8W5obc8M
X-Google-Smtp-Source: APXvYqzB29L4nILMp6U0eQCVyc9qYHk5Zl3/Dy4gC/rNKNLQuQ0Ji2+Lc00bwgB6x8sY1nqSjAdvGw==
X-Received: by 2002:a0c:94a4:: with SMTP id j33mr4402041qvj.135.1565897129952;
        Thu, 15 Aug 2019 12:25:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:25cd])
        by smtp.gmail.com with ESMTPSA id n93sm1741247qte.1.2019.08.15.12.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 12:25:29 -0700 (PDT)
Date:   Thu, 15 Aug 2019 12:25:28 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 block 1/2] writeback, cgroup: Adjust WB_FRN_TIME_CUT_DIV
 to accelerate foreign inode switching
Message-ID: <20190815192528.GA2240241@devbig004.ftw2.facebook.com>
References: <20190802190738.GB136335@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802190738.GB136335@devbig004.ftw2.facebook.com>
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

v2: Add comment explaining what's going on with the foreign detection
    parameters.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -224,10 +224,28 @@ static void wb_wait_for_completion(struc
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 
-/* parameters for foreign inode detection, see wb_detach_inode() */
+/*
+ * Parameters for foreign inode detection, see wbc_detach_inode() to see
+ * how they're used.
+ *
+ * These paramters are inherently heuristical as the detection target
+ * itself is fuzzy.  All we want to do is detaching an inode from the
+ * current owner if it's being written to by some other cgroups too much.
+ *
+ * The current cgroup writeback is built on the assumption that multiple
+ * cgroups writing to the same inode concurrently is very rare and a mode
+ * of operation which isn't well supported.  As such, the goal is not
+ * taking too long when a different cgroup takes over an inode while
+ * avoiding too aggressive flip-flops from occasional foreign writes.
+ *
+ * We record, very roughly, 2s worth of IO time history and if more than
+ * half of that is foreign, trigger the switch.  The recording is quantized
+ * to 16 slots.  To avoid tiny writes from swinging the decision too much,
+ * writes smaller than 1/8 of avg size are ignored.
+ */
 #define WB_FRN_TIME_SHIFT	13	/* 1s = 2^13, upto 8 secs w/ 16bit */
 #define WB_FRN_TIME_AVG_SHIFT	3	/* avg = avg * 7/8 + new * 1/8 */
-#define WB_FRN_TIME_CUT_DIV	2	/* ignore rounds < avg / 2 */
+#define WB_FRN_TIME_CUT_DIV	8	/* ignore rounds < avg / 8 */
 #define WB_FRN_TIME_PERIOD	(2 * (1 << WB_FRN_TIME_SHIFT))	/* 2s */
 
 #define WB_FRN_HIST_SLOTS	16	/* inode->i_wb_frn_history is 16bit */
