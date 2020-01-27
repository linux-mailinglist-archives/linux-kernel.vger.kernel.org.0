Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D1114ACDC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 00:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgA0X41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 18:56:27 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43832 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgA0X41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:56:27 -0500
Received: by mail-pf1-f201.google.com with SMTP id x199so7449358pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 15:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dRo8BvIKoRhSD2Tn9OfOhx2I4O53vRoQo3RBdWWB7eE=;
        b=Uw9ndpoLPLVM3Cb40YS7MHZg7Y4O9skGXttW8XbPWDLLxAteeFE7drT1tLrpPPaQsI
         bZEVdNVizBQmdzyxz/rcBZfQL7Kjg/iV5kJRlP8AJmOsDvs7nHGQrmKj4p9giBwu4kHT
         0E7xh8ZTLk0nQPUuMGp9wt/mWAdev1sz+7QRIgYGhxRlhjQneEFOuokB3v9RyXXLz6pp
         G31wPOoFFSDHz2FIFeSUupUc7GtKVv2bN+lIn8HzwO4kXJSLK++wGduZroloS9CHphd/
         ZiqHyvK5tg2zw1+NbIUDE8tw7R0JeZDnnccNFJzAVU8W4JIPbVUc4icJnHbKdeQ7d9MC
         BNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dRo8BvIKoRhSD2Tn9OfOhx2I4O53vRoQo3RBdWWB7eE=;
        b=kBmNEcL3LP4hBTKJL+21zmtqCkwIileQxTI+0vTcnCK+2XnwzK4xt+QnO2BXe/2CMX
         SKph1LL0hO8wwSk2BAErHLxUAOtTQSr4bHwUtUyhrCtQGy5zbIg6JPaEF874wYwUWNm+
         D+9TzBTPaZG37uEPIrPDF8tK8XXZso8RVbjbxKEc/Z0B/94PoujQLOjkCjdW21pkA1+6
         gOoav/dkOFnYKxZySbZLnlFXL+Iaymn214hOqvn9xBZCl3mW5TcpcGcmZg397O6U76oH
         15GSnoCnIKwf5fmCvbNioBQdOK9lPFkekhVTdtk1Hg7QhTky69HkaDibJ6bm9qDjeFOF
         NADQ==
X-Gm-Message-State: APjAAAUxH+tM+y+XTXJwIyH2NyCBajnveQhgbduxv73wallH75eiOWiB
        uQnoi5xE94ODJV1QG+Q6uFLm0aGwYQ==
X-Google-Smtp-Source: APXvYqwz2z0aFgThZxhvv3L6SvsHVrydMHnFK5ay+ILi5QybHwC3uagUqAF2vWJs7qoiwmhLBLKiXgYFZQ==
X-Received: by 2002:a63:bc01:: with SMTP id q1mr23355022pge.442.1580169386231;
 Mon, 27 Jan 2020 15:56:26 -0800 (PST)
Date:   Mon, 27 Jan 2020 15:56:16 -0800
Message-Id: <20200127235616.48920-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2] staging: android: ashmem: Disallow ashmem memory from
 being remapped
From:   Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, surenb@google.com, gregkh@linuxfoundation.org,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        Jann Horn <jannh@google.com>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suren Baghdasaryan <surenb@google.com>

When ashmem file is mmapped, the resulting vma->vm_file points to the
backing shmem file with the generic fops that do not check ashmem
permissions like fops of ashmem do. If an mremap is done on the ashmem
region, then the permission checks will be skipped. Fix that by disallowing
mapping operation on the backing shmem file.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable <stable@vger.kernel.org> # 4.4,4.9,4.14,4.18,5.4
Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/staging/android/ashmem.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

v2: update commit message as suggested by joelaf@google.com.

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 74d497d39c5a..c6695354b123 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -351,8 +351,23 @@ static inline vm_flags_t calc_vm_may_flags(unsigned long prot)
 	       _calc_vm_trans(prot, PROT_EXEC,  VM_MAYEXEC);
 }
 
+static int ashmem_vmfile_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	/* do not allow to mmap ashmem backing shmem file directly */
+	return -EPERM;
+}
+
+static unsigned long
+ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
+				unsigned long len, unsigned long pgoff,
+				unsigned long flags)
+{
+	return current->mm->get_unmapped_area(file, addr, len, pgoff, flags);
+}
+
 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	static struct file_operations vmfile_fops;
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;
 
@@ -393,6 +408,19 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 		}
 		vmfile->f_mode |= FMODE_LSEEK;
 		asma->file = vmfile;
+		/*
+		 * override mmap operation of the vmfile so that it can't be
+		 * remapped which would lead to creation of a new vma with no
+		 * asma permission checks. Have to override get_unmapped_area
+		 * as well to prevent VM_BUG_ON check for f_ops modification.
+		 */
+		if (!vmfile_fops.mmap) {
+			vmfile_fops = *vmfile->f_op;
+			vmfile_fops.mmap = ashmem_vmfile_mmap;
+			vmfile_fops.get_unmapped_area =
+					ashmem_vmfile_get_unmapped_area;
+		}
+		vmfile->f_op = &vmfile_fops;
 	}
 	get_file(asma->file);
 
-- 
2.25.0.341.g760bfbb309-goog

