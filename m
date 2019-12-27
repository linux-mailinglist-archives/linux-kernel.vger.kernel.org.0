Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A562212B0B5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Dec 2019 03:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfL0Cq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Dec 2019 21:46:57 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33166 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfL0Cq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 21:46:56 -0500
Received: by mail-qk1-f196.google.com with SMTP id d71so12817172qkc.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 18:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2Hv1x68b8uF72qZPygwNHPWxK1D9MzKDqh0OxaP6oOI=;
        b=OaCSuZ44PA0LdWeOuVkFrholvWC9bErIn/en6QZwNf9L+FHl4AWu1v1JbH4gXdDwbn
         Z0nw66O2leUQmi80oPajFbGinKO7zUDWmxXGpm0E7OvM9pRxqsdzO3SDhLPQx6Zjd934
         Ycr5icaoh087v26l2m6LYODHMOjeqXZDUSBdBpJRboZJSVldByQqYuK5BFnO842b9FLx
         QtfX67/PL9jcrjUGyg7tZzxCYazODBPTfWkmMq8a9owIN0SNpga9b2bRP0m1Q4lcuVQt
         3ROzAwwm0S+1MPcPhWr+YfABg8oh8xFvvbCt8V+yfoW1UhMp5e6L02UrMFU5bkkKZAET
         3rUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2Hv1x68b8uF72qZPygwNHPWxK1D9MzKDqh0OxaP6oOI=;
        b=Ey3HJweHufMkFo8Fi5NHICjO6aU/cJ0ovIFD+nI+rOkgK3ENu4GB5li/mJtaoDRuHT
         YdOSPxJOJCQumOPjJqLeFzNYbXH0tKMzGJnW/87MiDHtbXjEOWAQaLHs/bX90V3sVWmp
         5sBja6YCFsmtJWrj6298ZBb2/2CMBeQaopsdEDOSVRr3aUNU4jeF8p41Ecge/gK1FpQ6
         ngprqEbmy4zQVgGfxMa0PlU5VDHUIQn++mEdkAg5/YfwpQ19vi/qvPoP5Pgdrg7tLEgO
         roO/sAL0MiLVVQ9j94uNDEiJ4/Fz1ZvnlRsEYWU9/OnWR5nw0yTC8S2QcfCfLxCbOecL
         mXtA==
X-Gm-Message-State: APjAAAVxmVhqTQNiUSyTa2uFoVt8jVpm4u+Fb0D/D97GYdo3iKFGi1Uj
        CH7retiJ+3RpwsRxNvXYvVkJHqxy
X-Google-Smtp-Source: APXvYqyV5WbssGxs6t/AbINJ8WaBk8lSHDKGfTZCyAsOSSMhdPG9vd4MR+31MoRlg7OvvNfZyjWsMQ==
X-Received: by 2002:a37:4dc1:: with SMTP id a184mr41587857qkb.62.1577414815698;
        Thu, 26 Dec 2019 18:46:55 -0800 (PST)
Received: from mandalore.localdomain (pool-71-244-100-50.phlapa.fios.verizon.net. [71.244.100.50])
        by smtp.gmail.com with ESMTPSA id c8sm10087054qtv.61.2019.12.26.18.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 18:46:55 -0800 (PST)
Date:   Thu, 26 Dec 2019 21:46:38 -0500
From:   Matthew Hanzelik <mrhanzelik@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: most: core: Fix SPDX License Identifier style issue
Message-ID: <20191227024638.okfsc2ikeuibujnl@mandalore.localdomain>
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

