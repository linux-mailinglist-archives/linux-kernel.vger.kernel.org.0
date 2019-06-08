Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B013A26F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 00:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfFHWxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 18:53:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:38570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727486AbfFHWwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 18:52:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD34FAF90
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2019 22:52:47 +0000 (UTC)
Received: from mx1.suse.de (mx1.suse.de [195.135.220.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 29CBD2C16B
        for <bp@suse.de>; Sat,  8 Jun 2019 21:28:23 +0000 (UTC)
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.suse.de (Postfix) with ESMTPS id C5A3AAD00
        for <bp@suse.de>; Sat,  8 Jun 2019 21:28:22 +0000 (UTC)
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x58LSFng3145764
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 8 Jun 2019 14:28:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x58LSFng3145764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560029296;
        bh=/wqbX3ovIyCjqGMK/GOr5YTjEumFjkx8ZVuSVwR4PiA=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=IH7Mzf4M/OuANv3NZUzK7vQGnTWyhSsrHpKxLKYsuDb/s8P6FxzOg1OrRtjablLvu
         kmHY7s11M2J+fV5AM9s9DRlD7vLpjc8ntAlKXwj/oGKdcfGmzznKnJ5w+M5MicHafz
         rwDYOxmsWRb2EC7WGM+t4EENCXFEwzyftJ14+Lfmy8cSWJRvNgmJakaorvaevy6hJf
         CYpMu2CjZF9Lz0mGZ2dpL+w8Q6fU3xv64xoPOjIULtFcQzbjVYOxFsUvQL5bQncRhc
         pL85BrF49+fMu+YI7CwM/8Q/RmchxyALXqIIv1pwVv6vXILpBU01EVCB7Etrj04zL5
         GhPk95mcR7aWw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x58LSE223145761;
        Sat, 8 Jun 2019 14:28:14 -0700
Date:   Sat, 8 Jun 2019 14:28:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-9632a3299bb1897f01c6a485ff035b20e61d7ae1@git.kernel.org>
Cc:     hpa@zytor.com, bp@suse.de, mingo@kernel.org,
        linux-edac@vger.kernel.org, tony.luck@intel.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          tony.luck@intel.com, linux-edac@vger.kernel.org, hpa@zytor.com,
          mingo@kernel.org, bp@suse.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] RAS/CEC: Sanity-check array on every insertion
Git-Commit-ID: 9632a3299bb1897f01c6a485ff035b20e61d7ae1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9632a3299bb1897f01c6a485ff035b20e61d7ae1
Gitweb:     https://git.kernel.org/tip/9632a3299bb1897f01c6a485ff035b20e61d7ae1
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sun, 21 Apr 2019 21:41:45 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 8 Jun 2019 17:35:34 +0200

RAS/CEC: Sanity-check array on every insertion

Check the elements order in the array after every insertion.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---
 drivers/ras/cec.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index f57e869dfea2..da5797c38051 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -276,11 +276,39 @@ static u64 __maybe_unused del_lru_elem(void)
 	return pfn;
 }
 
+static bool sanity_check(struct ce_array *ca)
+{
+	bool ret = false;
+	u64 prev = 0;
+	int i;
+
+	for (i = 0; i < ca->n; i++) {
+		u64 this = PFN(ca->array[i]);
+
+		if (WARN(prev > this, "prev: 0x%016llx <-> this: 0x%016llx\n", prev, this))
+			ret = true;
+
+		prev = this;
+	}
+
+	if (!ret)
+		return ret;
+
+	pr_info("Sanity check dump:\n{ n: %d\n", ca->n);
+	for (i = 0; i < ca->n; i++) {
+		u64 this = PFN(ca->array[i]);
+
+		pr_info(" %03d: [%016llx|%03llx]\n", i, this, FULL_COUNT(ca->array[i]));
+	}
+	pr_info("}\n");
+
+	return ret;
+}
 
 int cec_add_elem(u64 pfn)
 {
 	struct ce_array *ca = &ce_arr;
-	unsigned int to;
+	unsigned int to = 0;
 	int count, ret = 0;
 
 	/*
@@ -345,6 +373,8 @@ int cec_add_elem(u64 pfn)
 	if (ca->decay_count >= CLEAN_ELEMS)
 		do_spring_cleaning(ca);
 
+	WARN_ON_ONCE(sanity_check(ca));
+
 unlock:
 	mutex_unlock(&ce_mutex);
 
@@ -402,7 +432,6 @@ DEFINE_DEBUGFS_ATTRIBUTE(count_threshold_ops, u64_get, count_threshold_set, "%ll
 static int array_dump(struct seq_file *m, void *v)
 {
 	struct ce_array *ca = &ce_arr;
-	u64 prev = 0;
 	int i;
 
 	mutex_lock(&ce_mutex);
@@ -412,10 +441,6 @@ static int array_dump(struct seq_file *m, void *v)
 		u64 this = PFN(ca->array[i]);
 
 		seq_printf(m, " %03d: [%016llx|%03llx]\n", i, this, FULL_COUNT(ca->array[i]));
-
-		WARN_ON(prev > this);
-
-		prev = this;
 	}
 
 	seq_printf(m, "}\n");
