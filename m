Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 680B826853
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 18:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfEVQc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 12:32:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55000 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730034AbfEVQc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:32:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id i3so2876404wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SFlmoRCfJXy1MNzDMKQ1EqKBillj1sU46hPl2u+x8nw=;
        b=ZarMeDypkpL8j+feQ85eA/RbxES+D2aqEuBpjm7hEMY2rdn167757VeKiZhf7QBVzW
         2wB+4A3BW9JezHwdoDGYkSlmyMgjHkLnQKUxK27rcLiEvQKAxCNEIpeol89skxqJnQVH
         MJF01SUNj/ObLYB5iMO9S1pmF7wYVYpfkSfmwbqxOQtDwA+98GahtEDJF0cDFjq+lSfs
         g/gAaFGc4MEt/GKVFLv6r8Xxe3BHLOVwmC14iLzhiz7Nr9mEOF6ytK1/LEeQ7eFxxdgc
         W09E8RiPOKSSlTzCD+G/oRv91ZQM3onkNVUospj3KzUdo5CONHcPhSBlCY0aFSQJIKFy
         9sKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SFlmoRCfJXy1MNzDMKQ1EqKBillj1sU46hPl2u+x8nw=;
        b=EV4LmNiJSubkV9iYQ2xNrX3Z1FygztjJFwrHx6muORH+4pb6eeY8z48qRZ2cUD98tm
         q1YT7tEEaOD7/gHFOLhdI3w7ESfGD8thU87/HrYC1F0ekpQojzgDUCbs1LMgn5MWuITR
         cjM6srYDYJ5P41Xr6wk5HVaI8Ppj89eaarMMHup0DAKiSHsUQxwWJ4GWh9KRZMIIoppz
         ONQjzw6VDdKKRWe4CUS5k88sbmgqX3dwm2BteI8rEPKrmQ2yga/5VA1m0tyKvtB7JLJg
         AIRU2HHIvFaX7JW7SRBGQ3sgMWrwLs7iHCB/XwWINpUVHre/EzkUKT/67q6HFHZPCmsg
         8k9A==
X-Gm-Message-State: APjAAAXzmUhFFHljRvAqlQ9l5FKHJv6iDW6sZG3wf2Hvh3Cxa5C8hQxU
        Htl0dGd/bWbXTwWzRgcORYAFMw==
X-Google-Smtp-Source: APXvYqxjq/TvDyfkJVZIPNwho++LD3IccPPdxvEjQJIJeBvE1Uk8B59OUQlYcPpPik2sAbZDbYkZGw==
X-Received: by 2002:a1c:20d7:: with SMTP id g206mr8093960wmg.136.1558542746950;
        Wed, 22 May 2019 09:32:26 -0700 (PDT)
Received: from localhost.localdomain ([185.197.132.10])
        by smtp.gmail.com with ESMTPSA id b5sm22556072wrp.92.2019.05.22.09.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 09:32:26 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jack@suse.cz, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, amir73il@gmail.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH] fanotify: remove redundant capable(CAP_SYS_ADMIN)s
Date:   Wed, 22 May 2019 18:31:50 +0200
Message-Id: <20190522163150.16849-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes two redundant capable(CAP_SYS_ADMIN) checks from
fanotify_init().
fanotify_init() guards the whole syscall with capable(CAP_SYS_ADMIN) at the
beginning. So the other two capable(CAP_SYS_ADMIN) checks are not needed.

Fixes: 5dd03f55fd2 ("fanotify: allow userspace to override max queue depth")
Fixes: ac7e22dcfaf ("fanotify: allow userspace to override max marks")
Signed-off-by: Christian Brauner <christian@brauner.io>
---
 fs/notify/fanotify/fanotify_user.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index a90bb19dcfa2..ec2739a66103 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -845,8 +845,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 
 	if (flags & FAN_UNLIMITED_QUEUE) {
 		fd = -EPERM;
-		if (!capable(CAP_SYS_ADMIN))
-			goto out_destroy_group;
 		group->max_events = UINT_MAX;
 	} else {
 		group->max_events = FANOTIFY_DEFAULT_MAX_EVENTS;
@@ -854,8 +852,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 
 	if (flags & FAN_UNLIMITED_MARKS) {
 		fd = -EPERM;
-		if (!capable(CAP_SYS_ADMIN))
-			goto out_destroy_group;
 		group->fanotify_data.max_marks = UINT_MAX;
 	} else {
 		group->fanotify_data.max_marks = FANOTIFY_DEFAULT_MAX_MARKS;
-- 
2.21.0

