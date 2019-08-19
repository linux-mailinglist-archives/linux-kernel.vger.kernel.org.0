Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4011A924C5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 15:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfHSNXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 09:23:14 -0400
Received: from 8bytes.org ([81.169.241.247]:50372 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbfHSNXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:23:03 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A799872E; Mon, 19 Aug 2019 15:23:00 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     corbet@lwn.net, tony.luck@intel.com, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Thomas.Lendacky@amd.com,
        Suravee.Suthikulpanit@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 11/11] Documentation: Update Documentation for iommu.passthrough
Date:   Mon, 19 Aug 2019 15:22:56 +0200
Message-Id: <20190819132256.14436-12-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819132256.14436-1-joro@8bytes.org>
References: <20190819132256.14436-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

This kernel parameter now takes also effect on X86.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 47d981a86e2f..2d5dfa46e88a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1811,7 +1811,7 @@
 			  synchronously.
 
 	iommu.passthrough=
-			[ARM64] Configure DMA to bypass the IOMMU by default.
+			[ARM64, X86] Configure DMA to bypass the IOMMU by default.
 			Format: { "0" | "1" }
 			0 - Use IOMMU translation for DMA.
 			1 - Bypass the IOMMU for DMA.
-- 
2.16.4

