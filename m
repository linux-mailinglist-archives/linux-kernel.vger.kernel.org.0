Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E659ACBEF8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 17:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389861AbfJDPTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 11:19:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:46946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389461AbfJDPTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:19:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02FADAF35;
        Fri,  4 Oct 2019 15:19:50 +0000 (UTC)
Date:   Fri, 4 Oct 2019 17:20:03 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>
Subject: [PATCH] firmware: dmi: Fix unlikely out-of-bounds read in
 save_mem_devices
Message-ID: <20191004172003.689f2c04@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before reading the Extended Size field, we should ensure it fits in
the DMI record. There is already a record length check but it does
not cover that field.

It would take a seriously corrupted DMI table to hit that bug, so no
need to worry, but we should still fix it.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 6deae96b42eb ("firmware, DMI: Add function to look up a handle and return DIMM size")
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
---
 drivers/firmware/dmi_scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-5.3.orig/drivers/firmware/dmi_scan.c	2019-10-04 16:14:24.575714482 +0200
+++ linux-5.3/drivers/firmware/dmi_scan.c	2019-10-04 16:18:18.878669652 +0200
@@ -408,7 +408,7 @@ static void __init save_mem_devices(cons
 		bytes = ~0ull;
 	else if (size & 0x8000)
 		bytes = (u64)(size & 0x7fff) << 10;
-	else if (size != 0x7fff)
+	else if (size != 0x7fff || dm->length < 0x20)
 		bytes = (u64)size << 20;
 	else
 		bytes = (u64)get_unaligned((u32 *)&d[0x1C]) << 20;


-- 
Jean Delvare
SUSE L3 Support
