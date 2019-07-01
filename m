Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 814E513B9F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 20:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfEDSix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 14:38:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41150 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfEDSiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:38:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id k8so7841586lja.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b49wfhLOumPQgXr+cfKeJZHxCawjUFOzEyK1tzSAUts=;
        b=RwHJ7dZfVpqpBAYmi/ibFYlbZ/kYATHVpdcdtU9nc74g9me2OD/iV5iS4GzSkemCag
         VRd+qudbu3Iaz4JvKMCP3ayuscMbX9TFON/RoABmjyntW7MWjmkLraeLrn2zAevlyn5Q
         xC9fOwEVZRUQCB0NoYL5y5FCQhOdLss33UR12iyMiR3XD4g01iim+DVGQsmb07ceauVQ
         jojWtBBkILKBbRpNYwh2gABontBTZbK6mBkvrrwL/FSz40Wp7N9P+kgQruqH1ueDWOL8
         pgR1pIc1eEodYMUqMdfRPhTfKG2wLDpB2qI2OvCxiuRO8gldtHTKdVhBwV8qwkwVfldk
         cSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b49wfhLOumPQgXr+cfKeJZHxCawjUFOzEyK1tzSAUts=;
        b=HTD3HkzUfU18ax2HyP9gJBB97Jc0Ntj3oKv0aBb6rq3ve8jj+g+GTg168N4GlI17Ep
         g9mMN8rOMy/LKEuvtsNwfmcAFKtV3serSK2C9muTRLoTA0/nGwRPlmF+lnTWYsL1tCB9
         ZzMO1tAIZkJ2C3WsBTMA9gSIJ2KEspCsspKJlecT9w+0Bk/Ctt20asfkZyJC97grn7ly
         5OUoFGbMl8o0rLYBgm0d/r6jonR4exrfVf0DMjadzGpdvS9fvrBW4h94b0vklINRs0O9
         ksgfHROxuV8/iUxdbJCQWdQTI9/XTH7qM/3JnUb0NHUe2VM0/lGWr0rKoavNJ4+xFh2M
         GWDw==
X-Gm-Message-State: APjAAAU/W1QXK87/OkCDHUY5oOGnmQk1VQ8xpJKWz7zTxsDNb+FeK85p
        IU21eD/0D2CsTe1k/USryY3CRchbrE2mrg==
X-Google-Smtp-Source: APXvYqwwDDNDkYh/TIm9iL///KR7uA/jAIJx0/jMK8G2ANYER2hGicp76hXUrishFf8onWBWUqwkFg==
X-Received: by 2002:a2e:2f0e:: with SMTP id v14mr2823075ljv.77.1556995123997;
        Sat, 04 May 2019 11:38:43 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:43 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 19/26] lightnvm: pblk: remove internal IO timeout
Date:   Sat,  4 May 2019 20:38:04 +0200
Message-Id: <20190504183811.18725-20-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

Currently during pblk padding, there is internal IO timeout introduced,
which is smaller than default NVMe timeout. This can lead to various
use-after-free issues. Since in case of any IO timeouts NVMe and block
layer will handle timeout by themselves and report it back to use,
there is no need to keep this internal timeout in pblk.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-recovery.c | 7 +------
 drivers/lightnvm/pblk.h          | 2 --
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 137e963cd51d..865fe310cab4 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -290,12 +290,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 
 fail_complete:
 	kref_put(&pad_rq->ref, pblk_recov_complete);
-
-	if (!wait_for_completion_io_timeout(&pad_rq->wait,
-				msecs_to_jiffies(PBLK_COMMAND_TIMEOUT_MS))) {
-		pblk_err(pblk, "pad write timed out\n");
-		ret = -ETIME;
-	}
+	wait_for_completion(&pad_rq->wait);
 
 	if (!pblk_line_is_full(line))
 		pblk_err(pblk, "corrupted padded line: %d\n", line->id);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 381f0746a9cf..90c703d3f84c 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -43,8 +43,6 @@
 
 #define PBLK_CACHE_NAME_LEN (DISK_NAME_LEN + 16)
 
-#define PBLK_COMMAND_TIMEOUT_MS 30000
-
 /* Max 512 LUNs per device */
 #define PBLK_MAX_LUNS_BITMAP (4)
 
-- 
2.19.1

