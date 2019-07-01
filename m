Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7609842540
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 14:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbfFLMNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 08:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbfFLMNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:13:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D67208CA;
        Wed, 12 Jun 2019 12:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560341596;
        bh=4SmLU4+bYJ493/LkbHQOOJEWVZjXMM4kmuEWI0pnj34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xOic1LtMPlrND0Iel66b8vgdJ7aZZGUHA0gdaxVVqLFftppZ4ge75LL2t1hQUAec+
         jQXWgUFJKI7Y8Teo8jvMjZWX9IfBLmuowqfKCNpxj4+S9sQjAVtC0HnDjaseaU71IO
         chGqJDMMpFCgcs98V/JHE1/9vwIzRY2GMJ8baHSo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dvhart@infradead.org, andy@infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] platform: x86: dell-laptop: no need to check return value of debugfs_create functions
Date:   Wed, 12 Jun 2019 14:12:53 +0200
Message-Id: <20190612121258.19535-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612121258.19535-1-gregkh@linuxfoundation.org>
References: <20190612121258.19535-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Pali Rohár" <pali.rohar@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/dell-laptop.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index a561f653cf13..94a2f259031c 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -2176,9 +2176,8 @@ static int __init dell_init(void)
 	kbd_led_init(&platform_device->dev);
 
 	dell_laptop_dir = debugfs_create_dir("dell_laptop", NULL);
-	if (dell_laptop_dir != NULL)
-		debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
-				    &dell_debugfs_fops);
+	debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
+			    &dell_debugfs_fops);
 
 	dell_laptop_register_notifier(&dell_laptop_notifier);
 
-- 
2.22.0

