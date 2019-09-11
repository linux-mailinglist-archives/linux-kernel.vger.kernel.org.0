Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 565D5B05D4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 01:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfIKXA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 19:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbfIKXA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 19:00:28 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39A442081B;
        Wed, 11 Sep 2019 23:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568242828;
        bh=196sFvoWQ7iGU+CxdFPnNRP8OZaKhKGMQ9W8SEpqvq8=;
        h=From:To:Cc:Subject:Date:From;
        b=P+QJDyjTQVatkeqst+YOcCpl6/pJfs8dukOsbHnxqy9s2HUTrWGQSsgubT41oPFJE
         TnzWx6WCnd2GeKdTgYEtl86RHvDYxO0PkG2dAihvyYO4ZX2tmiJb1Rzngku26XWUsn
         vb8XY60AfiJGqmesht1DJhtX+8R0SGcWOo0P/gnc=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] module: Remove leftover '#undef' from export header
Date:   Thu, 12 Sep 2019 00:00:18 +0100
Message-Id: <20190911230018.20155-1-will@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7290d5809571 ("module: use relative references for __ksymtab
entries") converted the '__put' #define into an assembly macro in
asm-generic/export.h but forgot to remove the corresponding '#undef'.

Remove the leftover '#undef'.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---

I spotted this trivial issue when debugging the namespace issue earlier
today, so here's the patch.

 include/asm-generic/export.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 294d6ae785d4..153d9c2ee580 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -57,7 +57,6 @@ __kcrctab_\name:
 #endif
 #endif
 .endm
-#undef __put
 
 #if defined(CONFIG_TRIM_UNUSED_KSYMS)
 
-- 
2.23.0.237.gc6a4ce50a0-goog

