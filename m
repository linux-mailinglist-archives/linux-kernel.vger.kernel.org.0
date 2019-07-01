Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 806E22E694
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 22:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfE2UzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 16:55:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55540 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfE2UzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:55:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E1A5B60F3F; Wed, 29 May 2019 20:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559163310;
        bh=ao1igd18u0fKnkzgWlolVx+hvnaOxQo8OJMI9HBKlt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jlh8ZatgBdfUYzda6tEzyZqE8+ObhJJCrv0D3nqtlgo6/sgkZW4Y/P6mRepiAKDZC
         GDTsegKrIFttDfIugupT/2G5HHqnszcofccBhEt3zho2wBIoJ6GqXXsubRwurDHE6N
         GmImIVqA3uSa5iJGNrbOYBOLC+gFIlGLVE35TzVs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B02F60E5C;
        Wed, 29 May 2019 20:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559163310;
        bh=ao1igd18u0fKnkzgWlolVx+hvnaOxQo8OJMI9HBKlt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jlh8ZatgBdfUYzda6tEzyZqE8+ObhJJCrv0D3nqtlgo6/sgkZW4Y/P6mRepiAKDZC
         GDTsegKrIFttDfIugupT/2G5HHqnszcofccBhEt3zho2wBIoJ6GqXXsubRwurDHE6N
         GmImIVqA3uSa5iJGNrbOYBOLC+gFIlGLVE35TzVs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B02F60E5C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        hoegsberg@google.com, dianders@chromium.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/16] iommu: Add DOMAIN_ATTR_SPLIT_TABLES
Date:   Wed, 29 May 2019 14:54:38 -0600
Message-Id: <1559163292-4792-3-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559163292-4792-1-git-send-email-jcrouse@codeaurora.org>
References: <1559163292-4792-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new domain attribute to enable split pagetable support for devices
devices that support it.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 include/linux/iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a815cf6..a2f07cf 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -128,6 +128,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+	DOMAIN_ATTR_SPLIT_TABLES,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
2.7.4

