Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABE33A26A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 00:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfFHWww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 18:52:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:38584 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727912AbfFHWwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 18:52:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E9F3AFA5
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2019 22:52:49 +0000 (UTC)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5967B2C16B
        for <bp@suse.de>; Sat,  8 Jun 2019 21:29:49 +0000 (UTC)
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.suse.de (Postfix) with ESMTPS id F3C7DAD93
        for <bp@suse.de>; Sat,  8 Jun 2019 21:29:48 +0000 (UTC)
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x58LTfcb3145827
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 8 Jun 2019 14:29:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x58LTfcb3145827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560029381;
        bh=ggyYlir8gcf2gj4AxkHQrSsF3ZyY4XSgxOjurYhU5y4=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=v/tqO/DvuVKh9dhDD3bv8Cca7z6QjxnYiMUd5Jxu414OakKe54tmYIwPt1/uqsmq4
         GaUV3hUO8e83+4UxLQQ+4JkduWWm7qm59CPQ5uFT+fGaKNYGBt7pNqanUcVyH/bfW/
         z1AIm4PV0YYcP6TE8U9S6W+/jQkqlHtNe98jazi+zVjD1oL0aqrGHRZ6eEIVx2m3cb
         rrDUPNxffbesRqL8WCH4HRooo3mQGK8nBTJCORHSY2L/Tt3JY33vMB2CC69ZpKvje0
         CJIErOgodKSZDfhABJqf7T55cx4GVRgJTrJkrWf4ISlr0cW504jWeiro8JROiVoX1k
         O92UwQzNkp3Ow==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x58LTfcE3145824;
        Sat, 8 Jun 2019 14:29:41 -0700
Date:   Sat, 8 Jun 2019 14:29:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-f57518cd56e2919afbcef3839122a75e291c7f85@git.kernel.org>
Cc:     bp@suse.de, mingo@kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, linux-edac@vger.kernel.org, hpa@zytor.com
Reply-To: bp@suse.de, mingo@kernel.org, tglx@linutronix.de,
          tony.luck@intel.com, linux-edac@vger.kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] RAS/CEC: Dump the different array element sections
Git-Commit-ID: f57518cd56e2919afbcef3839122a75e291c7f85
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

Commit-ID:  f57518cd56e2919afbcef3839122a75e291c7f85
Gitweb:     https://git.kernel.org/tip/f57518cd56e2919afbcef3839122a75e291c7f85
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sat, 20 Apr 2019 23:01:03 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 8 Jun 2019 17:39:11 +0200

RAS/CEC: Dump the different array element sections

When dumping the array elements, print them in the following format:

  [ PFN | generation in binary | count ]

to be perfectly clear what all those sections are.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---
 drivers/ras/cec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 364f7e1a6bad..dc08c705b493 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -429,6 +429,8 @@ static int action_threshold_set(void *data, u64 val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(action_threshold_ops, u64_get, action_threshold_set, "%lld\n");
 
+static const char * const bins[] = { "00", "01", "10", "11" };
+
 static int array_dump(struct seq_file *m, void *v)
 {
 	struct ce_array *ca = &ce_arr;
@@ -440,7 +442,8 @@ static int array_dump(struct seq_file *m, void *v)
 	for (i = 0; i < ca->n; i++) {
 		u64 this = PFN(ca->array[i]);
 
-		seq_printf(m, " %03d: [%016llx|%03llx]\n", i, this, FULL_COUNT(ca->array[i]));
+		seq_printf(m, " %3d: [%016llx|%s|%03llx]\n",
+			   i, this, bins[DECAY(ca->array[i])], COUNT(ca->array[i]));
 	}
 
 	seq_printf(m, "}\n");
