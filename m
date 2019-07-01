Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6EE249AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 10:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfEUICj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 04:02:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33366 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfEUICh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:02:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id d9so4441626wrx.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Qyb2ZjHa3whLh+RqF+kWmGToKxa/X+H2gjIFhEE6sE=;
        b=m7bAU2KR9Hevmy1UDUpkxJIc6hl7VJkvHANJ8apIiHD0MPfPmeVhfmwmBiqv0xnW5U
         U7sBem1g0ZFi17AZiIyn5lr67YmFGZLtUGJT2Yi7AnOUTx06OheejUmpQDECITXRrOWA
         vF2TO5BlHjaWelNSh4tcisdtFMooSP8wv6xouAoYrmzEVqXWzH14BO0408AE/NX0qkyC
         bNSbwXYi/kHVOFV1S02n0+Q2fvHHqq/qTdIx2LBMlfXS2J50a2MXvHwJ8D9UtNg3wYaM
         1ikr/rvUNlLo8YRBK3YoYJi0znS3KrI/WeIlqB+tN71t7f1OwE5jCANY38DY7RhUqVVm
         9e9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Qyb2ZjHa3whLh+RqF+kWmGToKxa/X+H2gjIFhEE6sE=;
        b=dwPZe7mDaXD6FQyNZCcKCVuOjw6enJnYZraOhHy/XT1zOeVbNOx1GY9jTAMnDVRupj
         oty3QnfGaRwnkK01zmTnecTzBi6PFW1jPLrKGI9ThKcHH165ZgF65G9bPccG6NlgoQ34
         zlgT3TG/Y4gNgvknZd9UoKhlKgbfk8Uh80IP8G+Fzlkth22NgLV/UYqridFDByw9MDS2
         hu5OrcNo0/jD1ceZrrb9jYS5plmD0sNb/RPZh5pvJpXsU0OPMUqnI0mSrIcBaWMMzgF/
         ajnNUPO8RgjzpmbJxbejNf32iAb3h9CGPAH0CfHILmIsnFUCWU46YMg/TFkNWHy6SctA
         9zqw==
X-Gm-Message-State: APjAAAUKm6AOqLeeKOQfF1CFTKlzYCAYN0uY6qi7CVJxxHaOORmpaKl+
        RQ+tNV8L0PDZd2Bw/LZEL1KHXA==
X-Google-Smtp-Source: APXvYqxQvIFwezlmIsaefzH0JpE22nHQ3G2Kc1TFLSAI7PUr2y4W50DvNzt5ZshZd4aBp6JoZsV48w==
X-Received: by 2002:a5d:4004:: with SMTP id n4mr15547070wrp.240.1558425755326;
        Tue, 21 May 2019 01:02:35 -0700 (PDT)
Received: from localhost.localdomain ([88.147.35.136])
        by smtp.gmail.com with ESMTPSA id p8sm11322301wro.0.2019.05.21.01.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 01:02:34 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Angelo Ruocco <angeloruocco90@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 1/2] cgroup: let a symlink too be created with a cftype file
Date:   Tue, 21 May 2019 10:01:54 +0200
Message-Id: <20190521080155.36178-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521080155.36178-1-paolo.valente@linaro.org>
References: <20190521080155.36178-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angelo Ruocco <angeloruocco90@gmail.com>

This commit enables a cftype to have a symlink (of any name) that
points to the file associated with the cftype.

Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 include/linux/cgroup-defs.h |  3 +++
 kernel/cgroup/cgroup.c      | 33 +++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 77258d276f93..2ad9f53ecefe 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -101,6 +101,8 @@ enum {
 	CFTYPE_WORLD_WRITABLE	= (1 << 4),	/* (DON'T USE FOR NEW FILES) S_IWUGO */
 	CFTYPE_DEBUG		= (1 << 5),	/* create when cgroup_debug */
 
+	CFTYPE_SYMLINKED	= (1 << 6),	/* pointed to by symlink too */
+
 	/* internal flags, do not use outside cgroup core proper */
 	__CFTYPE_ONLY_ON_DFL	= (1 << 16),	/* only on default hierarchy */
 	__CFTYPE_NOT_ON_DFL	= (1 << 17),	/* not on default hierarchy */
@@ -538,6 +540,7 @@ struct cftype {
 	 * end of cftype array.
 	 */
 	char name[MAX_CFTYPE_NAME];
+	char link_name[MAX_CFTYPE_NAME];
 	unsigned long private;
 
 	/*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 217cec4e22c6..f77dee5eb82a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1460,8 +1460,8 @@ struct cgroup *task_cgroup_from_root(struct task_struct *task,
 
 static struct kernfs_syscall_ops cgroup_kf_syscall_ops;
 
-static char *cgroup_file_name(struct cgroup *cgrp, const struct cftype *cft,
-			      char *buf)
+static char *cgroup_fill_name(struct cgroup *cgrp, const struct cftype *cft,
+			      char *buf, bool write_link_name)
 {
 	struct cgroup_subsys *ss = cft->ss;
 
@@ -1471,13 +1471,26 @@ static char *cgroup_file_name(struct cgroup *cgrp, const struct cftype *cft,
 
 		snprintf(buf, CGROUP_FILE_NAME_MAX, "%s%s.%s",
 			 dbg, cgroup_on_dfl(cgrp) ? ss->name : ss->legacy_name,
-			 cft->name);
+			 write_link_name ? cft->link_name : cft->name);
 	} else {
-		strscpy(buf, cft->name, CGROUP_FILE_NAME_MAX);
+		strscpy(buf, write_link_name ? cft->link_name : cft->name,
+			CGROUP_FILE_NAME_MAX);
 	}
 	return buf;
 }
 
+static char *cgroup_file_name(struct cgroup *cgrp, const struct cftype *cft,
+			      char *buf)
+{
+	return cgroup_fill_name(cgrp, cft, buf, false);
+}
+
+static char *cgroup_link_name(struct cgroup *cgrp, const struct cftype *cft,
+			      char *buf)
+{
+	return cgroup_fill_name(cgrp, cft, buf, true);
+}
+
 /**
  * cgroup_file_mode - deduce file mode of a control file
  * @cft: the control file in question
@@ -1636,6 +1649,9 @@ static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
 	}
 
 	kernfs_remove_by_name(cgrp->kn, cgroup_file_name(cgrp, cft, name));
+	if (cft->flags & CFTYPE_SYMLINKED)
+		kernfs_remove_by_name(cgrp->kn,
+				      cgroup_link_name(cgrp, cft, name));
 }
 
 /**
@@ -3809,6 +3825,7 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 {
 	char name[CGROUP_FILE_NAME_MAX];
 	struct kernfs_node *kn;
+	struct kernfs_node *kn_link;
 	struct lock_class_key *key = NULL;
 	int ret;
 
@@ -3839,6 +3856,14 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 		spin_unlock_irq(&cgroup_file_kn_lock);
 	}
 
+	if (cft->flags & CFTYPE_SYMLINKED) {
+		kn_link = kernfs_create_link(cgrp->kn,
+					     cgroup_link_name(cgrp, cft, name),
+					     kn);
+		if (IS_ERR(kn_link))
+			return PTR_ERR(kn_link);
+	}
+
 	return 0;
 }
 
-- 
2.20.1

