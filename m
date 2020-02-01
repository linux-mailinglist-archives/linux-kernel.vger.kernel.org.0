Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE7BA14F80E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 15:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgBAO2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Feb 2020 09:28:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33351 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgBAO2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 09:28:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so5215073pgk.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 06:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RM8QljI8F7IDMHfQopnocrrlGfYFPT7dWalw647v8Do=;
        b=WUzfyz1JTZSUgXLrjnH3f8NAQ5p69+G3gvHAyOpYpa6PLj/44vExJD0v7HgYEW/Igu
         wYNkDHPsZaZQCWmaLou6Jo98RVUvCMhcOueSmFxnIIc97en3fxv2Mb79PXROSW3dPHBM
         bEhB/jNWd9uMo6n/amhvhoWE+yR0wzxiREZHzfFPxjhwKLvUiJnKLoCVxUxImNcdW+Tv
         yLMuqH2Mxygqr2on6tW6nRywF165y0NESRplTz0lSZ8DFzKhVA4tARli4jvIl9vUjGtB
         9yoL9gKuEpDq9q5cfdJBfuqpq6tKmARIzWKUdILYf57ehj12HU4XLRcdfeklJatitQqF
         DkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RM8QljI8F7IDMHfQopnocrrlGfYFPT7dWalw647v8Do=;
        b=sRnfDUn/k21hWEUIrCvCe55wK2BidP29c7qFMAURoyRGpUXmQC3xvrJ+2UvNpMZTny
         5ZLsJznXLsoVlOdOGntq+Si53g9IvYn1/53lHceaCQkPAkyjp4kVSKDnznC3EKUA/pFK
         myicSL+z0lbzNAQFYkDNp6Z6zTL2jteMhs2vHRLeNu94R+PkV28tfx8F9UlCc4Klaj7G
         hWS9ZgbOECkFurjyZv1Lqk63tdv6uDXjG2LUcn7178ikEOcJlbnoa4+cdPB+twH28wmg
         kc2UJs1q/TGA1Jewf71ddG5uk/u5HcfHe50ojhU7AZ5ze41uuTOqadrVwKtg/4d0nkVf
         tSbw==
X-Gm-Message-State: APjAAAWZt5n4A8mF5xfebQJbF5tlShg2rQbzn7Y/eoLeStT91glr61Vl
        m8GVlyDbK8beuvQSSufhf795Qr+ndHcGFw==
X-Google-Smtp-Source: APXvYqyQAKCu9Bkxu0fnQZjzRJD/oKMCqEhMHHKAMRQ8hzQ5RgKH5x0tR5WrNo54xv9o3190n72JHQ==
X-Received: by 2002:a63:1e1d:: with SMTP id e29mr16111087pge.347.1580567294622;
        Sat, 01 Feb 2020 06:28:14 -0800 (PST)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id f8sm14006494pfn.2.2020.02.01.06.28.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Feb 2020 06:28:14 -0800 (PST)
Date:   Sat, 1 Feb 2020 19:58:08 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: netlogic: Use the correct style for SPDX License
 Identifier
Message-ID: <20200201142804.GA12814@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to Netlogic network devices.
It assigns explicit block comment to the SPDX License Identifier.

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/netlogic/platform_net.h | 4 ++--
 drivers/staging/netlogic/xlr_net.h      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/netlogic/platform_net.h b/drivers/staging/netlogic/platform_net.h
index f152d84099a2..c8d4c13424c6 100644
--- a/drivers/staging/netlogic/platform_net.h
+++ b/drivers/staging/netlogic/platform_net.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
- *
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
+/*
  * Copyright (c) 2003-2012 Broadcom Corporation
  * All Rights Reserved
  */
diff --git a/drivers/staging/netlogic/xlr_net.h b/drivers/staging/netlogic/xlr_net.h
index 518ea809b8fa..8365b744f9b3 100644
--- a/drivers/staging/netlogic/xlr_net.h
+++ b/drivers/staging/netlogic/xlr_net.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
- *
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
+/*
  * Copyright (c) 2003-2012 Broadcom Corporation
  * All Rights Reserved
  */
-- 
2.17.1

