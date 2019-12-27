Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D89EF12B349
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Dec 2019 09:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfL0ImP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Dec 2019 03:42:15 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41418 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfL0ImP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 03:42:15 -0500
Received: by mail-qt1-f196.google.com with SMTP id k40so24109090qtk.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 00:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Anodsp7HhKNo2COqD0EzVnUmrpQEB4ruVuLqYxaKVKI=;
        b=FaaKKhNodJIMTsMa8679JHazvL379a59zpE7JGE0WoT0ajb/r5nQioatXVOK/0zGUi
         Lt0c2EdHg+Kwhl8f6XHqugkkAFEnNaYPB1PCp9UP+Ii4gvDO+b6xckebXtExVzDgUyb8
         A7wTmOPvmse7VdGVShYgiKcHBmdBAzDhKspsoO1V/4XeIHZnN5DN2KC44kmqxRCI8/oy
         rwvWuS4hg+JkdO2sQ35dq4IgklE0VcbhSKkRNnhIrAbTsNqotAo4E+FA8DeyGXq7ekhm
         r1j6sREdX0j1PqO+x9lR2+zre0aJUqPuyDB4NW7v4KUBVIpSk5YV79+o4/uiJ4h3f7Q4
         W6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Anodsp7HhKNo2COqD0EzVnUmrpQEB4ruVuLqYxaKVKI=;
        b=UGj+n3BToh9jz2GvCtmxCaK0mwwQ2HBTNo4RYBlzT4X4ww9BSln4SwQsRxB9eWT6kx
         d3HTbcBrASR76JihLs9avKVuV8w1IJlcklaTwdVvFEeWkcg/rJYOK2PsdOPh17GXvn3j
         8KLUSA9IQS6kLsByZU6hY57yGgFhHTTT1hyc//TgtgWf/44R6nXWmuDBOSeMeIH0jehJ
         kiP6srvAMn9c4nKmRRwuhdvW+ubnTFljuxbH0CbvignnvdXiM519BiN1eeSV3jKQ3ahX
         pTYS/RQXnvk6qta5J6dPBz14BHOLOL+JHBE41Ido/RYDGmBkx3Kc113tRQR/MmnEepeR
         e2Wg==
X-Gm-Message-State: APjAAAUDMbGHJjYsFFGTwM3ZaatXMdWpx/DuwjIHcVGRXKBDSzQCpBKp
        rIkj3xDfkKq5NrrCxhzj9z3mfGvu
X-Google-Smtp-Source: APXvYqxoXNxINuI+zJVJWk5IUvkPkuygIji6JWYiWR32IMWCk44nVD+LOYBFTBvJK/tNSiqTtgfHJw==
X-Received: by 2002:ac8:6f04:: with SMTP id g4mr36752946qtv.314.1577436134769;
        Fri, 27 Dec 2019 00:42:14 -0800 (PST)
Received: from mandalore.localdomain (pool-71-244-100-50.phlapa.fios.verizon.net. [71.244.100.50])
        by smtp.gmail.com with ESMTPSA id g62sm9499559qkd.25.2019.12.27.00.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 00:42:14 -0800 (PST)
Date:   Fri, 27 Dec 2019 03:41:55 -0500
From:   Matthew Hanzelik <mrhanzelik@gmail.com>
To:     gregkh@linuxfoundation.com, christian.gromm@microchip.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Staging: most: core: Fix SPDX License Identifier style
 issue
Message-ID: <20191227084155.xpmv2thwrrsij5kx@mandalore.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a style issue with the SPDX License Identifier style.

Signed-off-by: Matthew Hanzelik <mrhanzelik@gmail.com>
---
Changes in v2:
  - Fix trailing space in patch diff

 drivers/staging/most/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/most/core.h b/drivers/staging/most/core.h
index 49859aef98df..1380e7586376 100644
--- a/drivers/staging/most/core.h
+++ b/drivers/staging/most/core.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * most.h - API for component and adapter drivers
  *
--
2.24.1

