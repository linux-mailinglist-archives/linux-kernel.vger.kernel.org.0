Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB2E29ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 21:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391664AbfEXTKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 15:10:19 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51443 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391106AbfEXTKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:10:19 -0400
Received: by mail-it1-f194.google.com with SMTP id m3so17584607itl.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P/mdSoe57BFheTRCW7JAtlZ6nF+RCpHBDMWwYpA7PIc=;
        b=bUCIj4y3+JaAFrLKcNRYKIdwbksAuznAJdve56ZbLYJHITXoF2tpjnTIIqt6BMGrYl
         UzNgBvQsQ2jD9ifAjHhcd6Ylw1Jw3/fjuL+0/z5SbQvxUx3XCUrV75X0TD5NCqXARccg
         26N8ruyGzEfc7veElu2xgDPEb20YOuJe8qh32appPK4XOZthOikWQQmfjS16i9TwJYhq
         NHOJ3kp/IkBQLmuFcdpGWR9dItYgjH4z0T2dGgKXJPviB3R2iGaW/RZcyJIarOCWtGgM
         e2sc8a87ykdScK5a4swqZ3dIVFj+ETBMUU9yCdBp4kEqqFJkPrpQ5rW7w0tPmHJIKceI
         1DnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P/mdSoe57BFheTRCW7JAtlZ6nF+RCpHBDMWwYpA7PIc=;
        b=jVxXUc3YuEg62FwwNBV50nymcQSKA7XqciVz/2CUK9vPsDsRMiS+hZknf0yIJeQkIC
         tlmxjJXZFL8PSjS7kvz87EIpMRqA8piQHdjF3Cspw0FAk8FylXtEmLdMn9YHhPJu3NVj
         G5p6A26JRri6DZWa/rO4NdGSjWhQmuD2pY95cj4Q3vqbCVVpFpNWIR49PKpi0A+ldP4p
         9O3XK/Nlckcc5Gsgol2b5LzhE/DuZHL7znOsH/0GUele5L18GAjA6XvlqWzJQQYUIiUu
         F8y/9aIi6BC6PAS3hO3h3Ye29CNuKdjJBT1qoFjdR6uPmKHJy/is2rpSeXBA3UATyAk3
         SHlQ==
X-Gm-Message-State: APjAAAX36QpaX+Tb4i0riK02A6Ob12+3USHB/d0CJBWh1iHSFfUSfWmf
        JdIOThhx08jTxhn/DXSoooU=
X-Google-Smtp-Source: APXvYqwNxw9klwRfZfU8vLpYq91zR+rJ18z9HSkart/8e54RbqSoCfsoSQgApo0bDFk5/zkBB2fkww==
X-Received: by 2002:a24:46d0:: with SMTP id j199mr18501950itb.63.1558725017875;
        Fri, 24 May 2019 12:10:17 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id j19sm756079ioo.17.2019.05.24.12.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 12:10:17 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org
Subject: [PATCH v3 1/2] MAINTAINERS: Add entry for fieldbus subsystem
Date:   Fri, 24 May 2019 15:10:12 -0400
Message-Id: <20190524191013.10139-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as the maintainer of the fieldbus subsystem.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---

v3:
	resend, no changes, forgot to attach history to patch set

v2:
	add Documentation directory to maintainer entry for fieldbus,
		suggested by Joe Perches

v1:
	first shot

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4ce575..50e164041e94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14905,6 +14905,12 @@ L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
 F:	drivers/staging/erofs/
 
+STAGING - FIELDBUS SUBSYSTEM
+M:	Sven Van Asbroeck <TheSven73@gmail.com>
+S:	Maintained
+F:	drivers/staging/fieldbus/*
+F:	drivers/staging/fieldbus/Documentation/
+
 STAGING - INDUSTRIAL IO
 M:	Jonathan Cameron <jic23@kernel.org>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

