Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63DB7179FE5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 07:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgCEGWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 01:22:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgCEGWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 01:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8Uv8yfjAePAyCPwv9/ehe9yX6LBL9Q9lCZWm2Tx3ZcM=; b=qOTBdj4gqNy6LTESqeLIZIB3Fs
        FOmFYttafyaItPS3h+s+Z62K0y4Y+6nRqEdujd4k5wELPJuEcKHHxDDnIqTmbg7yEoCgq/+RYaZo9
        YLfh5A7xmJwO9zbBD44lvTsG7++UMGroyGYj6pfmnmZb7VPs7b/rWRTms+m/1Kj4JrnZYaWqw28Nl
        txzKVRn1EHOSO2hcyQ3F9JpWf/STOL/i+877LXzRzZrw4XduVuTBrh51N5oDCp1l2VZELbMyl0Wil
        xRpW4R5oO2qUccguiasEClmoCXJlk3HErDRK4URCRUTP6AxKs8qPoEyYhMAgdfPHhQqBnh2oTYOiF
        gFRnqMiw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9jtG-0006Qj-9J; Thu, 05 Mar 2020 06:21:50 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc:     Vitaly Andrianov <vitalya@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matt Mackall <mpm@selenic.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] hw_random: move TI Keystone driver into the config menu
 structure
Message-ID: <06417e19-57fe-c090-c493-d4c481dfee00@infradead.org>
Date:   Wed, 4 Mar 2020 22:21:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Move the TI Keystone hardware random number generator into the
same menu as all of the other hardware random number generators.

This makes the driver config be listed in the correct place in
the kconfig tools.

Fixes: eb428ee0e3ca ("hwrng: ks-sa - add hw_random driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vitaly Andrianov <vitalya@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Matt Mackall <mpm@selenic.com>
Cc: linux-crypto@vger.kernel.org
---
 drivers/char/hw_random/Kconfig |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- linux-next-20200304.orig/drivers/char/hw_random/Kconfig
+++ linux-next-20200304/drivers/char/hw_random/Kconfig
@@ -467,6 +467,13 @@ config HW_RANDOM_NPCM
 
  	  If unsure, say Y.
 
+config HW_RANDOM_KEYSTONE
+	depends on ARCH_KEYSTONE || COMPILE_TEST
+	default HW_RANDOM
+	tristate "TI Keystone NETCP SA Hardware random number generator"
+	help
+	  This option enables Keystone's hardware random generator.
+
 endif # HW_RANDOM
 
 config UML_RANDOM
@@ -483,10 +490,3 @@ config UML_RANDOM
 	  (check your distro, or download from
 	  http://sourceforge.net/projects/gkernel/).  rngd periodically reads
 	  /dev/hwrng and injects the entropy into /dev/random.
-
-config HW_RANDOM_KEYSTONE
-	depends on ARCH_KEYSTONE || COMPILE_TEST
-	default HW_RANDOM
-	tristate "TI Keystone NETCP SA Hardware random number generator"
-	help
-	  This option enables Keystone's hardware random generator.

