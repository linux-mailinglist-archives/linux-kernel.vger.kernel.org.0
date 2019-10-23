Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27878E222E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 19:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbfJWR45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 13:56:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:51382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731633AbfJWR45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:56:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42A24AD29;
        Wed, 23 Oct 2019 17:56:54 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/fadump: Remove duplicate message.
Date:   Wed, 23 Oct 2019 19:56:51 +0200
Message-Id: <20191023175651.24833-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190923075406.5854-1-msuchanek@suse.de>
References: <20190923075406.5854-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is duplicate message about lack of support by firmware in
fadump_reserve_mem and setup_fadump. Due to different capitalization it
is clear that the one in setup_fadump is shown on boot. Remove the
duplicate that is not shown.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/fadump.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index cdcdea6c6453..f40dc713f089 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -438,10 +438,8 @@ int __init fadump_reserve_mem(void)
 	if (!fw_dump.fadump_enabled)
 		return 0;
 
-	if (!fw_dump.fadump_supported) {
-		pr_info("Firmware-Assisted Dump is not supported on this hardware\n");
+	if (!fw_dump.fadump_supported)
 		goto error_out;
-	}
 
 	/*
 	 * Initialize boot memory size
-- 
2.23.0

