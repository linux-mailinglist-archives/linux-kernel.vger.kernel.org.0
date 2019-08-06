Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15491838BB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 20:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfHFSkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 14:40:51 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:48845 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfHFSks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:40:48 -0400
Received: by mail-vk1-f201.google.com with SMTP id x71so29362580vkd.15
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 11:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KgzH53PwLND1jLbrm/0exiWYFdiM2SzHVv8Uf5Mh6WA=;
        b=TO8OuL1BlbirCPPWqGBbRPnqwohgpSqYuh+mhD9Fan+N5xQ1xSkyjcwfXIqmsy4UCP
         9XcJI/4gKegHjuZT9J96o6CEHzcowSFVIEEH8eLjEVCKjWtcE6XaEeaavb0XxUegiXe+
         ZmzLJa6mwQpxrwLxiwrEDMxmoyNGiEeyXQ9BQ2VpoIA4LVG9HwGTXVcg74DWpEKIApEK
         TIB5s9aGPzn5c59x+rXxXBEIWx49BC1LVuUnpN/Nf3jbUw1qZIqz9dgxYeMnOS6c3rGg
         6KpnF9tEFyWR48Xn35qMlIJaALvbd7W09HjbGGX/vD8US+B03GIHucPGf9rOIKjcKdZt
         lH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KgzH53PwLND1jLbrm/0exiWYFdiM2SzHVv8Uf5Mh6WA=;
        b=GfNv5YzKicfvAnduSkp07FF+nCRMijWe93A2P/mSbsotWtcuIygaShaXrncirMXyup
         dyBKXUO3qbAxuis4stO2vTKpqH4j30LVxAT9EgSU5CxNnp4KsGt+3wm4hJkfzCqFqzUJ
         kAJHNEtDEeGt8gnJXnzOuHy3JMZk4ZFd5XR+HNbXvrT2/kuB9CPLwn+hrH7nKT8Ry+/3
         qhsZMAkr9w/bP0y9BqGpQ4GC54hGN32KcJV80sTmD0SN3iOgk1tf1PqkAKXxa5wEyWOD
         1qdnxVmtkd4kL/tTOT/6gu+fyrCOSP7do1uyIh2IesJLJzHtv5bp80Hna1s/dDpWRJSc
         3p5Q==
X-Gm-Message-State: APjAAAVIegutzS2xfTPfKIuut5KWVG/kJvl0G/q2j5YkMCv2KxDw1JaO
        q1riTQQ6A3w0WKgs+U7h40d7uCE2Ses=
X-Google-Smtp-Source: APXvYqyj/C1aMKroLXjnt52133U+mF/4/m9/pdxH6SIvZVODYB8EP6DW0aydx4KyYo0ko4Aw4zZlgx5Prrg=
X-Received: by 2002:ab0:5398:: with SMTP id k24mr1923016uaa.6.1565116847615;
 Tue, 06 Aug 2019 11:40:47 -0700 (PDT)
Date:   Tue,  6 Aug 2019 11:40:06 -0700
In-Reply-To: <20190806184007.60739-1-hridya@google.com>
Message-Id: <20190806184007.60739-3-hridya@google.com>
Mime-Version: 1.0
References: <20190806184007.60739-1-hridya@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v2 2/2] binder: Validate the default binderfs device names.
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
index 886b4e0f482f..52c8bd361906 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -572,6 +572,18 @@ static struct file_system_type binder_fs_type = {
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

