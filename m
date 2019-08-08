Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8061986D3E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 00:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404860AbfHHW1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 18:27:54 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:40745 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404609AbfHHW1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:27:54 -0400
Received: by mail-vs1-f73.google.com with SMTP id v9so24645053vsq.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=glpAp26pMe1icqRitidp26IFh6a5KAtyBMYwIFTDOcE=;
        b=W30psaFiIA0cn7RWVZd0TkcI9INoc97phuYQojQUCOq3c0E5XAVZFJaBVeq28e0pnt
         B1oAMa1fipofqyBGlFrKnFec3xqxe14lkG+twN4ilhOwv6VjIBbG4RQMiQqwGw4KaKec
         O6LroXNEUlZnHbw6AHPXrR+fGbtWdEdC0TLEaQZXpKjaq5EEdcv0nu+0jtmC7yYZIu+A
         w8YfnjbxsWMC8980xatvwDxWe2a8hN4VID/95HRkGqf+wrj1fBMNtHMMcT5uydwSxzVs
         UOLbyX0L1dkCzNUH8u91KSnUSaII8kop5QeHfDvXlC907fCwc0i7aKc/tipfQoxLT2Q/
         8oQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=glpAp26pMe1icqRitidp26IFh6a5KAtyBMYwIFTDOcE=;
        b=oUtUYIx5twPp1rqocX4ALa15X3kC87BoVlTZDob7CZ5xAKntXEe2L9sofs/2gtHnBi
         nm/1Gx78Dx8QYCpdqBfeli0h9eYEmUVzSjfXBObQ4LayCDubHe5+H8trTd6i2MTxPLnd
         nhGpIzU3bdcjrqnhL+BjbMUQVhZbVpL6bIj16SaOz6vfDdc07bkJ91GLLq4lWrFNokE4
         WlpBVwxRhrHRugFIXAzrE9Gua5xMVEjMrRQMgRabENHPRHwVMWXOrswpJM53Ls2b9TJT
         PU1BVb43IPf8M253L2DV3+ZKLD69het2REuHECWYHgEe/mbISQ2Aes5q+nqrjC2tzuNd
         Ge/g==
X-Gm-Message-State: APjAAAXQO7cDJF5BthSPCKWe76YKr2bMtfAX1PaUzenm7NVv0yBocQ3w
        emDeOMS43WlzHLFZfZ23Orp2W1x8P3o=
X-Google-Smtp-Source: APXvYqwYMoyVBc6m3h6T6jZEVwv9fndM5Olrygl81LtMf4cJkPsvtJbWFB6STk1qAyP4VcI4ifMWkynE+ak=
X-Received: by 2002:a1f:8bc4:: with SMTP id n187mr7001133vkd.32.1565303272993;
 Thu, 08 Aug 2019 15:27:52 -0700 (PDT)
Date:   Thu,  8 Aug 2019 15:27:26 -0700
In-Reply-To: <20190808222727.132744-1-hridya@google.com>
Message-Id: <20190808222727.132744-3-hridya@google.com>
Mime-Version: 1.0
References: <20190808222727.132744-1-hridya@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v3 2/2] binder: Validate the default binderfs device names.
From:   Hridya Valsaraju <hridya@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Hridya Valsaraju <hridya@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Length of a binderfs device name cannot exceed BINDERFS_MAX_NAME.
This patch adds a check in binderfs_init() to ensure the same
for the default binder devices that will be created in every
binderfs instance.

Co-developed-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Hridya Valsaraju <hridya@google.com>
---
 drivers/android/binderfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index aee46dd1be91..55c5adb87585 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -570,6 +570,18 @@ static struct file_system_type binder_fs_type = {
 int __init init_binderfs(void)
 {
 	int ret;
+	const char *name;
+	size_t len;
+
+	/* Verify that the default binderfs device names are valid. */
+	name = binder_devices_param;
+	for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
+		if (len > BINDERFS_MAX_NAME)
+			return -E2BIG;
+		name += len;
+		if (*name == ',')
+			name++;
+	}
 
 	/* Allocate new major number for binderfs. */
 	ret = alloc_chrdev_region(&binderfs_dev, 0, BINDERFS_MAX_MINOR,
-- 
2.22.0.770.g0f2c4a37fd-goog

