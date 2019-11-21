Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD31105315
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 14:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfKUN3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 08:29:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfKUN3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:29:40 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A4E4214DA;
        Thu, 21 Nov 2019 13:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574342980;
        bh=0R4Ar318xIMMrKKDyOvPURJgpXcwotUCVc4m7Yx9gPc=;
        h=From:To:Cc:Subject:Date:From;
        b=W3U2VdZtoB369d5xUrc2zRcoLezlLlS8WAvKLmzWYrDQ6ul4HWAKIdcxT0A0tFINF
         bfeQha2RoveKTTQ1QjoYGEmgTOjZ0YrTNp8uZuR56lozW6eHNvZ9qB39N4qlUzasKI
         4N9pIqx/8iUlpG/C+l5EAdDNImr21wzXbH0lK6/w=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH] zram: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 21:29:35 +0800
Message-Id: <20191121132935.29604-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/block/zram/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index fe7a4b7d30cf..f7ad14f53516 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -15,9 +15,9 @@ config ZRAM
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
 
 config ZRAM_WRITEBACK
-       bool "Write back incompressible or idle page to backing device"
-       depends on ZRAM
-       help
+	bool "Write back incompressible or idle page to backing device"
+	depends on ZRAM
+	help
 	 With incompressible page, there is no memory saving to keep it
 	 in memory. Instead, write it out to backing device.
 	 For this feature, admin should set up backing device via
-- 
2.17.1

