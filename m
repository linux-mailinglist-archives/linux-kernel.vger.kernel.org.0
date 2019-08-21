Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B30982E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 20:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfHUSca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 14:32:30 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38091 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfHUScZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:32:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id u190so2737489qkh.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kCOV/SKGyCS/idoYOjNn3DaQRL2Ie2fUru8T4/v0tiY=;
        b=GlTWlepJvHyRbDlaHEFdDhjwr7ME6G3tgiH11e6zSHF0Yx3tG8+rX1LzQN9AxSvN5F
         eJHnR/A5iyS53ubpbQ7M2Rb0Qk3777oAjf3dYhxU7TssIsqeiE3gzsBsc9dNRK5JSwOs
         F3poSqq52q3oMa0JaQRQWhCbsmu3f7EurINkJ7fjV+5baUeM9/xWwhc1XLqecXGet8Ba
         ZpPa40huaT3e2j+zey0uLbMYFT1k0FKom6uI7dZJN69YlvG5TVagA+YBRsDBHENaAFPw
         VBZD6f/PTENBGtIIAdu1MbJ97QZQP0c/22pFDOAsvhBB7MgcQAQHsiaQkMXDjwSbIT+/
         ywIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kCOV/SKGyCS/idoYOjNn3DaQRL2Ie2fUru8T4/v0tiY=;
        b=Dpcujgw7yHDfLdvAJ/Q+Iwpx4rI2seJulSuxyzpjldzKqx6XaMOTy/maxZ3mL15Q63
         aDXdOABYhfGPdqcebmfBPtvyxrKISKrj5DhMnOQqYAndbe2pIsOpUrRISL2KvdaHBxzF
         DO9OqXfKvbBF0+hBKGBN77YU3wFwKXVN36NzNj77Q6yR1pcO4EaPXW9E7xED80lTKWsd
         QTcWhXtXQryUQbTkwQiRrpVmRChchmdk37a3dKjqZz86atBK6Zq8xckkAQyz/onAY+wT
         oJ8veRtIFSimc1D6LQBL78eXonq+8oLdk4xMhCJUKRlxGSYZTDeO+QDE7elcher20Djn
         A3Hg==
X-Gm-Message-State: APjAAAXJSw8NCqoK4hs87AQY+9KsUXyjJn/SV3jnibWGFmrnd86PFz9f
        PVLVhQAvOwoAYIzL61TRxBhzcQ==
X-Google-Smtp-Source: APXvYqwt48uvxRp+EENQtSiynp6FQfq8H8l0y0bSzNIwyq4yP+ezYfhMfD/LoNrfv6n+23xSn0fbQA==
X-Received: by 2002:a05:620a:126d:: with SMTP id b13mr33824244qkl.452.1566412344835;
        Wed, 21 Aug 2019 11:32:24 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q13sm10443332qkm.120.2019.08.21.11.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:32:24 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v3 13/17] kexec: add machine_kexec_post_load()
Date:   Wed, 21 Aug 2019 14:32:00 -0400
Message-Id: <20190821183204.23576-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190821183204.23576-1-pasha.tatashin@soleen.com>
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is the same as machine_kexec_prepare(), but is called after segments are
loaded. This way, can do processing work with already loaded relocation
segments. One such example is arm64: it has to have segments loaded in
order to create a page table, but it cannot do it during kexec time,
because at that time allocations won't be possible anymore.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec.c          | 4 ++++
 kernel/kexec_core.c     | 6 ++++++
 kernel/kexec_file.c     | 4 ++++
 kernel/kexec_internal.h | 2 ++
 4 files changed, 16 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 1b018f1a6e0d..27b71dc7b35a 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -159,6 +159,10 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	kimage_terminate(image);
 
+	ret = machine_kexec_post_load(image);
+	if (ret)
+		goto out;
+
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 2c5b72863b7b..8360645d1bbe 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -587,6 +587,12 @@ static void kimage_free_extra_pages(struct kimage *image)
 	kimage_free_page_list(&image->unusable_pages);
 
 }
+
+int __weak machine_kexec_post_load(struct kimage *image)
+{
+	return 0;
+}
+
 void kimage_terminate(struct kimage *image)
 {
 	if (*image->entry != 0)
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b8cc032d5620..cb531d768114 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -391,6 +391,10 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
+	ret = machine_kexec_post_load(image);
+	if (ret)
+		goto out;
+
 	/*
 	 * Free up any temporary buffers allocated which are not needed
 	 * after image has been loaded
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 48aaf2ac0d0d..39d30ccf8d87 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -13,6 +13,8 @@ void kimage_terminate(struct kimage *image);
 int kimage_is_destination_range(struct kimage *image,
 				unsigned long start, unsigned long end);
 
+int machine_kexec_post_load(struct kimage *image);
+
 extern struct mutex kexec_mutex;
 
 #ifdef CONFIG_KEXEC_FILE
-- 
2.23.0

