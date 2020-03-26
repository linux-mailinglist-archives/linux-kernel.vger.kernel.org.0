Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 117DE1941BE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 15:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgCZOoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 10:44:22 -0400
Received: from mail-wr1-f74.google.com ([209.85.221.74]:47980 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZOoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:44:20 -0400
Received: by mail-wr1-f74.google.com with SMTP id u16so133715wrp.14
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 07:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GbETiUgT64s7N54cDqIoGj6dWJrQUmDSafvr3l6+BU4=;
        b=Of70chDFsS+raLmZssCv6MBdjh8AvQ812eLg3x6wFZR10hHFOAyVzxG5YidgWquT4E
         I0kGyd+LisxCbY8SBLcQmdG5D1hCXHCnNGT6HlrC0remGw2MZdpGAfDCAOuhQ36s1lW6
         9bPXk8T7KjwruWTjLrM3qWvP4iuzWX6qN2FHRf46bwfqGhy4AOFedaOb7C9993F2Z+B/
         0LrJC/0WnOTbxVufOcpTmidG7T4DGxwtAzAGXyhkgwDGbtxQoCufUajx4SzaGEKIxxFi
         Hg7SskpwC/pISxApikn5yt9VOjwBDhClDsYcjzfTnncFx6aR5r/fZnVZwNF1sQy+0WRR
         pemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GbETiUgT64s7N54cDqIoGj6dWJrQUmDSafvr3l6+BU4=;
        b=n/93o7DboRATdKnJVE9YB7klieMh/trEWp3iSqrWKg7HULPgncFH3wL28ZpwhPlEJ5
         Qk6DmectnLwtsXEaz2QxCwjbRnl+3dpQiCXn0Fn6plpO3gTsidy1mc8wRkFHxGxeSBik
         TtDtA4A2BQl7rqAA3GB6Tti3fvR4a3AJSI2NF2ldc6QUaR7Csw8PWf/E+Qb32oNayItE
         INENsjpaRRDWf30jG5oIMuXTw8UeKdPZBK7zmrtNzqRBPwYX6lmX6WPDYlBEUHJ5VEqP
         P5MgHQ0JOXgNm4ytykhefVWlC7HhRIY1DWgcP9roMrIg//N+1oNXcLypR1rnDtHFf9UF
         WWjA==
X-Gm-Message-State: ANhLgQ3/FpudgSVzjnKA0fHAZZySy14NvSgSmK89GtYEnIWt/C+oc62m
        E81Q3O0mpKzt7p6RRCVDdnr9x9NfAgoiMvRn
X-Google-Smtp-Source: ADFU+vt4V9MvjgmktXXnFFA0QdyXgAfatYdSBrYl1qMecxvvVZBEVlPA1HaDXmYHCa1p/V6wmmEnOQASWyRdFjmo
X-Received: by 2002:adf:df04:: with SMTP id y4mr9596663wrl.318.1585233856669;
 Thu, 26 Mar 2020 07:44:16 -0700 (PDT)
Date:   Thu, 26 Mar 2020 15:44:00 +0100
In-Reply-To: <cover.1585233617.git.andreyknvl@google.com>
Message-Id: <ab5e2885ce674ba6e04368551e51eeb6a2c11baf.1585233617.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1585233617.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v4 1/7] kcov: cleanup debug messages
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

Previous commit left a lot of excessive debug messages, clean them up.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/kcov.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index f50354202dbe..f6bd119c9419 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -98,6 +98,7 @@ static struct kcov_remote *kcov_remote_find(u64 handle)
 	return NULL;
 }
 
+/* Must be called with kcov_remote_lock locked. */
 static struct kcov_remote *kcov_remote_add(struct kcov *kcov, u64 handle)
 {
 	struct kcov_remote *remote;
@@ -119,16 +120,13 @@ static struct kcov_remote_area *kcov_remote_area_get(unsigned int size)
 	struct kcov_remote_area *area;
 	struct list_head *pos;
 
-	kcov_debug("size = %u\n", size);
 	list_for_each(pos, &kcov_remote_areas) {
 		area = list_entry(pos, struct kcov_remote_area, list);
 		if (area->size == size) {
 			list_del(&area->list);
-			kcov_debug("rv = %px\n", area);
 			return area;
 		}
 	}
-	kcov_debug("rv = NULL\n");
 	return NULL;
 }
 
@@ -136,7 +134,6 @@ static struct kcov_remote_area *kcov_remote_area_get(unsigned int size)
 static void kcov_remote_area_put(struct kcov_remote_area *area,
 					unsigned int size)
 {
-	kcov_debug("area = %px, size = %u\n", area, size);
 	INIT_LIST_HEAD(&area->list);
 	area->size = size;
 	list_add(&area->list, &kcov_remote_areas);
@@ -366,7 +363,6 @@ static void kcov_remote_reset(struct kcov *kcov)
 	hash_for_each_safe(kcov_remote_map, bkt, tmp, remote, hnode) {
 		if (remote->kcov != kcov)
 			continue;
-		kcov_debug("removing handle %llx\n", remote->handle);
 		hash_del(&remote->hnode);
 		kfree(remote);
 	}
@@ -553,7 +549,6 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 
 	switch (cmd) {
 	case KCOV_INIT_TRACE:
-		kcov_debug("KCOV_INIT_TRACE\n");
 		/*
 		 * Enable kcov in trace mode and setup buffer size.
 		 * Must happen before anything else.
@@ -572,7 +567,6 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 		kcov->mode = KCOV_MODE_INIT;
 		return 0;
 	case KCOV_ENABLE:
-		kcov_debug("KCOV_ENABLE\n");
 		/*
 		 * Enable coverage for the current task.
 		 * At this point user must have been enabled trace mode,
@@ -598,7 +592,6 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 		kcov_get(kcov);
 		return 0;
 	case KCOV_DISABLE:
-		kcov_debug("KCOV_DISABLE\n");
 		/* Disable coverage for the current task. */
 		unused = arg;
 		if (unused != 0 || current->kcov != kcov)
@@ -610,7 +603,6 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 		kcov_put(kcov);
 		return 0;
 	case KCOV_REMOTE_ENABLE:
-		kcov_debug("KCOV_REMOTE_ENABLE\n");
 		if (kcov->mode != KCOV_MODE_INIT || !kcov->area)
 			return -EINVAL;
 		t = current;
@@ -629,7 +621,6 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 		kcov->remote_size = remote_arg->area_size;
 		spin_lock(&kcov_remote_lock);
 		for (i = 0; i < remote_arg->num_handles; i++) {
-			kcov_debug("handle %llx\n", remote_arg->handles[i]);
 			if (!kcov_check_handle(remote_arg->handles[i],
 						false, true, false)) {
 				spin_unlock(&kcov_remote_lock);
@@ -644,8 +635,6 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 			}
 		}
 		if (remote_arg->common_handle) {
-			kcov_debug("common handle %llx\n",
-					remote_arg->common_handle);
 			if (!kcov_check_handle(remote_arg->common_handle,
 						true, false, false)) {
 				spin_unlock(&kcov_remote_lock);
@@ -782,7 +771,6 @@ void kcov_remote_start(u64 handle)
 	spin_lock(&kcov_remote_lock);
 	remote = kcov_remote_find(handle);
 	if (!remote) {
-		kcov_debug("no remote found");
 		spin_unlock(&kcov_remote_lock);
 		return;
 	}
@@ -810,8 +798,6 @@ void kcov_remote_start(u64 handle)
 	/* Reset coverage size. */
 	*(u64 *)area = 0;
 
-	kcov_debug("area = %px, size = %u", area, size);
-
 	kcov_start(t, size, area, mode, sequence);
 
 }
@@ -881,10 +867,8 @@ void kcov_remote_stop(void)
 	unsigned int size = t->kcov_size;
 	int sequence = t->kcov_sequence;
 
-	if (!kcov) {
-		kcov_debug("no kcov found\n");
+	if (!kcov)
 		return;
-	}
 
 	kcov_stop(t);
 	t->kcov = NULL;
@@ -894,8 +878,6 @@ void kcov_remote_stop(void)
 	 * KCOV_DISABLE could have been called between kcov_remote_start()
 	 * and kcov_remote_stop(), hence the check.
 	 */
-	kcov_debug("move if: %d == %d && %d\n",
-		sequence, kcov->sequence, (int)kcov->remote);
 	if (sequence == kcov->sequence && kcov->remote)
 		kcov_move_area(kcov->mode, kcov->area, kcov->size, area);
 	spin_unlock(&kcov->lock);
-- 
2.26.0.rc2.310.g2932bb562d-goog

