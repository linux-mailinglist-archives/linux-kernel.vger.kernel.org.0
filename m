Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 083C7789DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 12:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387532AbfG2Kxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 06:53:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51860 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbfG2Kxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:53:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1D20860ACE; Mon, 29 Jul 2019 10:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564397609;
        bh=v1bFXmDRap8qAsV2+SNP1+5F4LJNhstINlnmxvHMhpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RRSVy79W/mXBESlHUeJK4ezXBeVv/7CG6FwGhQhCtQ4SBZcZQSSFWkks4nQEYHoFm
         OO1+0OrEmwdVJ5BgNoe+Fkb+uYLrufioFoGZea/xlOSy8RQ7Lka35roUQ/UlIgKtkf
         YPv/55D/xPkiFsw/iJQa2lHxGjL6GxMHFJUftJCE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0774760790;
        Mon, 29 Jul 2019 10:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564397608;
        bh=v1bFXmDRap8qAsV2+SNP1+5F4LJNhstINlnmxvHMhpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CRp+qvPY9RabmQEmHdF4OG9pHAB7rsUE/QCwl708xi2HJiCYaDZYdLqoCehb44pRA
         bfL6hBIb+1OQIj6sV4RwDCBSzDSTwEmq+/sJd17ezd2aSqS4j+Ak1zcQw0skU2XIhj
         GbsZlMELh9WQpy1H0A0ql2adfkswTbQQve5Ujfdo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0774760790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 2/2] locking/mutex: Use mutex flags macro instead of hard code value
Date:   Mon, 29 Jul 2019 16:22:58 +0530
Message-Id: <1564397578-28423-2-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564397578-28423-1-git-send-email-mojha@codeaurora.org>
References: <1564397578-28423-1-git-send-email-mojha@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use the mutex flag macro(which got moved from mutex.c
to linux/mutex.h in the last patch) instead of hard code
value which was used in __mutex_owner().

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 include/linux/mutex.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 79b28be..c3833ba 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -87,7 +87,7 @@ struct mutex {
  */
 static inline struct task_struct *__mutex_owner(struct mutex *lock)
 {
-	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~0x07);
+	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
 }
 
 /*
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

