Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 852CA1941BF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 15:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgCZOoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 10:44:24 -0400
Received: from mail-wm1-f73.google.com ([209.85.128.73]:56095 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgCZOoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:44:21 -0400
Received: by mail-wm1-f73.google.com with SMTP id i9so704826wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pUHuESTKj8oX3rFdN5fYGgzuMeb9qfGw8IwhPoMTDMA=;
        b=FhIoyUmrn4ShByWsJAyife9npYZwAwtImGROiYB3g54hnYVqJHuVPKFwiLyFVD2JjF
         4hH1g2oXBbrKMrLg45cPPblaUO8K5EKVM53f49H9ca8i6t3BfL7OfI1PAYb6Y6VMND9M
         sqGui/aWUV+7roKV6oKPGulSLk3qzR1qMb3We2uY1F16QGAYN0KjbFnZxuyO6p4pywi+
         532T1vUIQRpkS1a7CCJ0moHhsFP1WuN06DKLupDZQ/RoADiJUGpfMTUthW/b7VHoZ1nu
         /wCHuS57uOKExIDF+B1o8DHWja5DUTEy06HKQPs4LFR3+AEr0o1tFXhqigq2DiMhtNMA
         2f2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pUHuESTKj8oX3rFdN5fYGgzuMeb9qfGw8IwhPoMTDMA=;
        b=ji0Q3Y+ZgG12OkD+C1H9zl/9diFVdHfyivWmKoc5rmW3sv6sdE9hG8u4tJTUb1f/q5
         559vOpOQ0VjH+4Bb2NUOCGmoJ5S8rAtHJnkNmT4AIu2bFtOcAHdvug2/c5PWjveluY26
         cEr1kvvKC2MF04gxM3pTpzkbCVL8YrKq9cLmbZIr1imFbX+VgKSMK1ath3DRree1DIRz
         +DcfWpJXFctmdE0nkNlzb9sl3K2wrDsYKvSIdrBLXjr02uU72n9aZVnMPFqxxZz03HzY
         7pASZtbAt7kizqDPMK30Z5a27UW3teUxqlbo5m4sD4kgEbQu8zpcM2Iqscw+C4U865H8
         M7Gw==
X-Gm-Message-State: ANhLgQ3VSoHMhjYNp/Qz0XJIq7Y6BZiPqnGxhpEa0E3wBNNksm3cexz1
        5yWPF6l2AMHYTn4xuKW7FPqfTven1op65rKE
X-Google-Smtp-Source: ADFU+vs0KXaxlxADpXExCJIuRumete/6F3eTe5emAyvJp6l9dhGeqpsgqwUVVX03+S11UXk7EkQ4taSnSeGcmyij
X-Received: by 2002:a5d:4003:: with SMTP id n3mr9356095wrp.176.1585233859680;
 Thu, 26 Mar 2020 07:44:19 -0700 (PDT)
Date:   Thu, 26 Mar 2020 15:44:01 +0100
In-Reply-To: <cover.1585233617.git.andreyknvl@google.com>
Message-Id: <9d9134359725a965627b7e8f2652069f86f1d1fa.1585233617.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1585233617.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v4 2/7] kcov: fix potential use-after-free in kcov_remote_start
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If vmalloc() fails in kcov_remote_start() we'll access remote->kcov
without holding kcov_remote_lock, so remote might potentially be freed
at that point. Cache kcov pointer in a local variable.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/kcov.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index f6bd119c9419..cc5900ac2467 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -748,6 +748,7 @@ static const struct file_operations kcov_fops = {
 void kcov_remote_start(u64 handle)
 {
 	struct kcov_remote *remote;
+	struct kcov *kcov;
 	void *area;
 	struct task_struct *t;
 	unsigned int size;
@@ -774,16 +775,17 @@ void kcov_remote_start(u64 handle)
 		spin_unlock(&kcov_remote_lock);
 		return;
 	}
+	kcov = remote->kcov;
 	/* Put in kcov_remote_stop(). */
-	kcov_get(remote->kcov);
-	t->kcov = remote->kcov;
+	kcov_get(kcov);
+	t->kcov = kcov;
 	/*
 	 * Read kcov fields before unlock to prevent races with
 	 * KCOV_DISABLE / kcov_remote_reset().
 	 */
-	size = remote->kcov->remote_size;
-	mode = remote->kcov->mode;
-	sequence = remote->kcov->sequence;
+	size = kcov->remote_size;
+	mode = kcov->mode;
+	sequence = kcov->sequence;
 	area = kcov_remote_area_get(size);
 	spin_unlock(&kcov_remote_lock);
 
@@ -791,7 +793,7 @@ void kcov_remote_start(u64 handle)
 		area = vmalloc(size * sizeof(unsigned long));
 		if (!area) {
 			t->kcov = NULL;
-			kcov_put(remote->kcov);
+			kcov_put(kcov);
 			return;
 		}
 	}
-- 
2.26.0.rc2.310.g2932bb562d-goog

