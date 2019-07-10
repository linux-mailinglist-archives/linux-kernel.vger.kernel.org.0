Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3EB6441F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 11:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfGJJHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 05:07:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52323 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfGJJHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 05:07:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6A97DsD2346267
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Jul 2019 02:07:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6A97DsD2346267
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562749634;
        bh=k2XgUqem8wugl0/LusrCJ5O8ZS54avaoFu7nzRJ3o5E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=eqmag5RsaKIJ14cY62b3WLhOZdkOaje6maBBSAtge8Z9aRgdzsMLvuXJMMjEnaoO4
         V4+VnFMCO2dhtQDScTWiifH+gR2r7c7lrVheaxCzwFHNTKVgPU4IhXvGlfQ/3xSy7S
         Qu5qjlnfIZKrFj9dyZ0GrXQ1A9IY7FLm5ughPmAKZWTRmlrp3rsrion3eKdWOpqlTf
         ee1Zhmn+Vi7ukRu0h+q7TWQe+s+jdX/wKtEDSExO1SvFX5lEPsvnK/mExwFsOclwFT
         WB2Ax1kOcGSBCVK2Z34jb/rThFUkLqyA/kzYvopKXzIh4Dyf6j866kQ85SG9J5zQ3t
         rWwWHXYMlFRQg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6A97Dft2346264;
        Wed, 10 Jul 2019 02:07:13 -0700
Date:   Wed, 10 Jul 2019 02:07:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joe Perches <tipbot@zytor.com>
Message-ID: <tip-20faba848752901de23a4d45a1174d64d2069dde@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        marc.zyngier@arm.com, mingo@kernel.org, joe@perches.com
Reply-To: marc.zyngier@arm.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, joe@perches.com, mingo@kernel.org,
          tglx@linutronix.de
In-Reply-To: <ab5deb4fc3cd604cb620054770b7d00016d736bc.1562734889.git.joe@perches.com>
References: <ab5deb4fc3cd604cb620054770b7d00016d736bc.1562734889.git.joe@perches.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] irqchip/gic-v3-its: Fix misuse of GENMASK macro
Git-Commit-ID: 20faba848752901de23a4d45a1174d64d2069dde
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  20faba848752901de23a4d45a1174d64d2069dde
Gitweb:     https://git.kernel.org/tip/20faba848752901de23a4d45a1174d64d2069dde
Author:     Joe Perches <joe@perches.com>
AuthorDate: Tue, 9 Jul 2019 22:04:18 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 10 Jul 2019 11:04:17 +0200

irqchip/gic-v3-its: Fix misuse of GENMASK macro

Arguments are supposed to be ordered high then low.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Link: https://lkml.kernel.org/r/ab5deb4fc3cd604cb620054770b7d00016d736bc.1562734889.git.joe@perches.com

---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 35500801dc2b..730fbe0e2a9d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -185,7 +185,7 @@ static struct its_collection *dev_event_to_col(struct its_device *its_dev,
 
 static struct its_collection *valid_col(struct its_collection *col)
 {
-	if (WARN_ON_ONCE(col->target_address & GENMASK_ULL(0, 15)))
+	if (WARN_ON_ONCE(col->target_address & GENMASK_ULL(15, 0)))
 		return NULL;
 
 	return col;
