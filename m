Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9225CA87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 10:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfGBIFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 04:05:13 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:34391 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfGBIFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:05:11 -0400
Received: by mail-qk1-f202.google.com with SMTP id h198so16026993qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 01:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NEsgFhBOsHO1SUu/GnNK2DPDOJTChWsbzIPYkeXfosU=;
        b=SUuiCpEyaak5XfddxqDhgd8CZLbHmyS+aWA9tOcpJKwvJ+lmczEa4pAv2doIL/MNAx
         oxbvwgOT7JP95TVpHvEKVEhqSCkHTaAIJ2qYLYjYX/sM5EVQ/ehuStA1RZaAx9WKHIu2
         HOMEvp+RFG18HWtxgTcDEihisRNtMoN4fr51BGqd0Y1aNZ9EUIBxSnArjNTNPZj0qKeC
         7lDfBfPvpuhQ5dGD+qwIbY14OOVkD/4L9H5Ax829EjB1ByMvbQVVg8/LyR1nThS/JZpC
         sGyguTYXTlq79AT/k0ECihTxoUZa47U8PBCFXFAtW0FYIKiTXq8syA+AF8rl0mZfO7q0
         9njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NEsgFhBOsHO1SUu/GnNK2DPDOJTChWsbzIPYkeXfosU=;
        b=XhX4ABfb61piUAR4e+a7WGvlLs6X63A7rFYWnaL5IU46EFudS/v5k9jkisI7rSuTPx
         6yWDG554XpEhBt3EO1sZcQBBmXWaFRQm2PmEGqnTl6JkQDQYlKqyJiQmnKo6E0+dyCpH
         +CKBOPPgjdjirMw7In/vuciMJ6LQ9hlbCHCOBKpUbYZdcBiW1Fh0Q15eDIWJOXdulALd
         IXq1/lPfWAg3w9rk8/sVNuGX0IDwKYInPyeiApGQquCJfc+HIZv3fzQmr1HO7NmiSsXQ
         6zghCUEOu4/cdCMcoGwCLVNSCSVbLhHnhR59J/GafsyIL5k71t3g5ASvsGGO0bNwy3nf
         Ur5A==
X-Gm-Message-State: APjAAAWh10ocJ2o1IMvKqL3C2abUXhJPjwBH1RMmS0pjU/fBF3Z1kD8U
        CiNh7HEOXH5eiRPvsO5RGwy0XGqPW4EqE+I=
X-Google-Smtp-Source: APXvYqwrXvbk11TVxxDHQCIkdbAtLKP9A2wasQz4c5X/idjoID/jWMQN/mQNqcB/Hw6wGFCTefiRv8WenyeupcE=
X-Received: by 2002:a37:ac0a:: with SMTP id e10mr24972711qkm.168.1562054710600;
 Tue, 02 Jul 2019 01:05:10 -0700 (PDT)
Date:   Tue,  2 Jul 2019 16:05:03 +0800
Message-Id: <20190702080503.175149-1-oceanchen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2] f2fs: avoid out-of-range memory access
From:   Ocean Chen <oceanchen@google.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     oceanchen@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_off might over 512 due to fs corrupt.
Use ENTRIES_IN_SUM to protect invalid memory access.

v2:
- fix typo
Signed-off-by: Ocean Chen <oceanchen@google.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8dee063c833f..a5e8af0bd62e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3403,6 +3403,8 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 
 		for (j = 0; j < blk_off; j++) {
 			struct f2fs_summary *s;
+			if (j >= ENTRIES_IN_SUM)
+				return -EFAULT;
 			s = (struct f2fs_summary *)(kaddr + offset);
 			seg_i->sum_blk->entries[j] = *s;
 			offset += SUMMARY_SIZE;
-- 
2.22.0.410.gd8fdbe21b5-goog

