Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D29914D8A9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 11:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgA3KH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 05:07:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37380 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3KH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:07:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id v17so2673887ljg.4;
        Thu, 30 Jan 2020 02:07:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TRXV/R/FJjlldRcej4nDJXC0nf1bwm0Dx6qU6xuluz8=;
        b=jEqeZZtgvc5Go758UJAUgzYXRDftsyDh09xIxKNizpgYy0kJW24y0bnRPB3Wba+xMS
         YQdRzYYpOmTDWkqhPb7uBIf4529L0NXIUXKWE7W/NUX8oHEZJrokDfJQzPe1D4TUSXZd
         dtZzEdEl9TDeDypLtqYYk8o/6z6YD8OmvqB2lUH4keyY553CANetcJhcdMqDWTmWlxEk
         3fUZFP+u1UyKl2O1PAVbRFCvByAbtBwjkBuScwNIDr+C9VXTqW9PtG6/+GrHr+qQmZII
         Hn+2aVEeuXNXTSWPsHmzn5YC8uQ4rhfgMWF0+1nLH16INiM9kqZdi9vfgwsfGvr/3ePr
         oJIA==
X-Gm-Message-State: APjAAAXkyMARLRchSC8kN6Kf7f+i/5NB/Ax8DCxbu0ZGySp3jeuyd75a
        dPnM6kQLmC+g0sx0YckE/qrNUJd2
X-Google-Smtp-Source: APXvYqyZX0txkc7CTZ6KZgmtq3Tuka+XSMLsxaFc3ZaPtExrTA0sR8R4zzN9hyC74fU/7JFNUzsE9g==
X-Received: by 2002:a2e:7818:: with SMTP id t24mr2244584ljc.195.1580378877292;
        Thu, 30 Jan 2020 02:07:57 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id l8sm2561503ljh.65.2020.01.30.02.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 02:07:56 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1ix6jw-0000C3-UZ; Thu, 30 Jan 2020 11:08:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] USB: serial: relax unthrottle memory barrier
Date:   Thu, 30 Jan 2020 11:06:58 +0100
Message-Id: <20200130100658.683-1-johan@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a8d78d9f3856 ("USB: serial: clean up throttle handling")
converted the throttle handling to use atomic bitops. This means that we
can relax the smp_mb() in unthrottle() to smp_mb__after_atomic(), which
for example is a no-op on architectures like x86 that provide fully
ordered atomics.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
index 1be8bea372a2..546a1c2ce2f2 100644
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -417,7 +417,7 @@ void usb_serial_generic_read_bulk_callback(struct urb *urb)
 	/*
 	 * Make sure URB is marked as free before checking the throttled flag
 	 * to avoid racing with unthrottle() on another CPU. Matches the
-	 * smp_mb() in unthrottle().
+	 * smp_mb__after_atomic() in unthrottle().
 	 */
 	smp_mb__after_atomic();
 
@@ -489,7 +489,7 @@ void usb_serial_generic_unthrottle(struct tty_struct *tty)
 	 * Matches the smp_mb__after_atomic() in
 	 * usb_serial_generic_read_bulk_callback().
 	 */
-	smp_mb();
+	smp_mb__after_atomic();
 
 	usb_serial_generic_submit_read_urbs(port, GFP_KERNEL);
 }
-- 
2.24.1

