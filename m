Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11C23C1171
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 19:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfI1RFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Sep 2019 13:05:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53166 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfI1RFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 13:05:43 -0400
Received: from zn.tnic (p200300EC2F1EDB0090155002B4D741D2.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:db00:9015:5002:b4d7:41d2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0FC801EC03F6;
        Sat, 28 Sep 2019 19:05:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569690342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=JVuqw/6wKu4h5BZuuUMzqmNrLQztcCUaQl0HjOjQWdU=;
        b=deNXMkm5T7m5lWK88EmFNbdz4FVA9qq3/aTy4bKVW4PUiI8Zoq7iSNb5a0v/SHadivZXNv
        z6QyEsWa1mPAMTNDaHAYh3xRF201JelZXNjLbZk51AYbK5rdIk537rDcPbUjXNcV9EXEyP
        6Zsp9F4lul5d1x2o3hWclxgtxdageTo=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/mce/amd: Make disable_err_thresholding() static
Date:   Sat, 28 Sep 2019 19:05:39 +0200
Message-Id: <20190928170539.2729-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6ea7fdc82f3c..5167bd2bb6b1 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -583,7 +583,7 @@ bool amd_filter_mce(struct mce *m)
  * - Prevent possible spurious interrupts from the IF bank on Family 0x17
  *   Models 0x10-0x2F due to Erratum #1114.
  */
-void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
+static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 {
 	int i, num_msrs;
 	u64 hwcr;
-- 
2.21.0

