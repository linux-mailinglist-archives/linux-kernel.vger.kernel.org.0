Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83E2729438
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 11:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389814AbfEXJIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 05:08:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59446 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389475AbfEXJIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 05:08:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E513B60A42; Fri, 24 May 2019 09:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558688929;
        bh=igHrawF1Hx5/t3YXD5o3/vFat11DDmRNhqFNnJql4as=;
        h=From:To:Cc:Subject:Date:From;
        b=OVeYHX0PwxRU44++vsWaFR/tQi5BR+PuNbFD5LR5ixE768ee8bwrNuZdGA7xkl6g1
         ueZhFvgTMasVknQsmmkdF3KPYfdO4PQotq7JGNO8wzuGfuiuWbY/dOOC1PwP9UZC/Z
         mfYtmKKuLrNnIOefVTkVFMhtcmqs8y7Ho2YJmIjo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C5B1605FC;
        Fri, 24 May 2019 09:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558688929;
        bh=igHrawF1Hx5/t3YXD5o3/vFat11DDmRNhqFNnJql4as=;
        h=From:To:Cc:Subject:Date:From;
        b=OVeYHX0PwxRU44++vsWaFR/tQi5BR+PuNbFD5LR5ixE768ee8bwrNuZdGA7xkl6g1
         ueZhFvgTMasVknQsmmkdF3KPYfdO4PQotq7JGNO8wzuGfuiuWbY/dOOC1PwP9UZC/Z
         mfYtmKKuLrNnIOefVTkVFMhtcmqs8y7Ho2YJmIjo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C5B1605FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: fix f2fs_show_options to show nodiscard mount option
Date:   Fri, 24 May 2019 14:38:39 +0530
Message-Id: <1558688919-561-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix f2fs_show_options to show nodiscard mount option.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2c9d4f7..353feda 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1410,6 +1410,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",disable_roll_forward");
 	if (test_opt(sbi, DISCARD))
 		seq_puts(seq, ",discard");
+	else
+		seq_puts(seq, ",nodiscard");
 	if (test_opt(sbi, NOHEAP))
 		seq_puts(seq, ",no_heap");
 	else
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

