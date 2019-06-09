Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 428C23A49F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 12:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfFIKI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 06:08:58 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:46626 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728110AbfFIKIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 06:08:55 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 1AFF12E087D;
        Sun,  9 Jun 2019 13:08:53 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 13LYxQ2B9j-8pliI2hm;
        Sun, 09 Jun 2019 13:08:53 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1560074933; bh=vE25/fE3GbSUmEmrdF2LzH942xvuS41f5y8rGOLXdnQ=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=JRKbcrjIO3Qau84WEWIcAh/pGsYAjU0pBAE0iOqS7wdR0k5OSt+AWz7uKQJI4mJg6
         8827ndi69XToznkB0q2AePqeqDvA/uq02G6iPx4++PVKEp0BXjJpvgdvNRgAY29Sw6
         RRh4rf2ePf7A9V7TIg/fu2WM1HrJJvQgXF2H2b2Q=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d25:9e27:4f75:a150])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 2fhLdaNKBQ-8pYaK4tB;
        Sun, 09 Jun 2019 13:08:51 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2 1/6] proc: use down_read_killable mmap_sem for
 /proc/pid/maps
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal =?utf-8?q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Roman Gushchin <guro@fb.com>
Date:   Sun, 09 Jun 2019 13:08:51 +0300
Message-ID: <156007493160.3335.14447544314127417266.stgit@buzz>
In-Reply-To: <156007465229.3335.10259979070641486905.stgit@buzz>
References: <156007465229.3335.10259979070641486905.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not stuck forever if something wrong.
Killable lock allows to cleanup stuck tasks and simplifies investigation.

This function also used for /proc/pid/smaps.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reviewed-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 fs/proc/task_mmu.c   |    6 +++++-
 fs/proc/task_nommu.c |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 01d4eb0e6bd1..2bf210229daf 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -166,7 +166,11 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 	if (!mm || !mmget_not_zero(mm))
 		return NULL;
 
-	down_read(&mm->mmap_sem);
+	if (down_read_killable(&mm->mmap_sem)) {
+		mmput(mm);
+		return ERR_PTR(-EINTR);
+	}
+
 	hold_task_mempolicy(priv);
 	priv->tail_vma = get_gate_vma(mm);
 
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index 36bf0f2e102e..7907e6419e57 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -211,7 +211,11 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 	if (!mm || !mmget_not_zero(mm))
 		return NULL;
 
-	down_read(&mm->mmap_sem);
+	if (down_read_killable(&mm->mmap_sem)) {
+		mmput(mm);
+		return ERR_PTR(-EINTR);
+	}
+
 	/* start from the Nth VMA */
 	for (p = rb_first(&mm->mm_rb); p; p = rb_next(p))
 		if (n-- == 0)

