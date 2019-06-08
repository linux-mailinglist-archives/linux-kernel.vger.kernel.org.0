Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA6203A269
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 00:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfFHWwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 18:52:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:38564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727791AbfFHWwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 18:52:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2640BAFA5
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2019 22:52:47 +0000 (UTC)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9B7972C16B
        for <bp@suse.de>; Sat,  8 Jun 2019 21:27:38 +0000 (UTC)
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.suse.de (Postfix) with ESMTPS id 65E9BAD93
        for <bp@suse.de>; Sat,  8 Jun 2019 21:27:38 +0000 (UTC)
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x58LRVXO3145700
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 8 Jun 2019 14:27:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x58LRVXO3145700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560029252;
        bh=NFzuBwTDRGe4YyWmom5QRb9DTpqofUFsUJTSlurXxKY=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=FFR9dnjPXFOUzy4WBQslH43uC+gIlQRYzylZL/8/Qx+5AiQ74KbTyd4/WivT+ghf5
         Q4VVrA0dvQi7T6tLQyYiW3leyuHnmspU1beshplWqK2yImaZyzGrZbjaVHpoz8VuSh
         rzVYukzhxc/OImi/WEjRNYj3fL6H8rjt10o1+wEpUXBxMUVOjkU3UrpebvxDywMzIA
         +0gIsTNHPd7/94EtJLzqbtuVnxLkrstNfG4/OBVg7t2p+SrdVOWr2C689BckjdA1od
         2FHLwUgUjke8Eg0/fWEj+4rjQtBgVQQ1eRwlYYu5hKbzfhe3nfVKael8hPtTxI/LXn
         Tlazqu/fCnDxw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x58LRVbI3145697;
        Sat, 8 Jun 2019 14:27:31 -0700
Date:   Sat, 8 Jun 2019 14:27:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-d0e375e8f26edd2e577e3afa9d952f91037cbd87@git.kernel.org>
Cc:     bp@suse.de, mingo@kernel.org, tony.luck@intel.com, hpa@zytor.com,
        tglx@linutronix.de, linux-edac@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, tony.luck@intel.com,
          tglx@linutronix.de, hpa@zytor.com, linux-edac@vger.kernel.org,
          bp@suse.de, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] RAS/CEC: Fix potential memory leak
Git-Commit-ID: d0e375e8f26edd2e577e3afa9d952f91037cbd87
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

Commit-ID:  d0e375e8f26edd2e577e3afa9d952f91037cbd87
Gitweb:     https://git.kernel.org/tip/d0e375e8f26edd2e577e3afa9d952f91037cbd87
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sat, 20 Apr 2019 21:39:24 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 8 Jun 2019 17:35:04 +0200

RAS/CEC: Fix potential memory leak

Free the array page if a failure is encountered while creating the
debugfs nodes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---
 drivers/ras/cec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 31868bd99e8d..f57e869dfea2 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -504,8 +504,10 @@ void __init cec_init(void)
 		return;
 	}
 
-	if (create_debugfs_nodes())
+	if (create_debugfs_nodes()) {
+		free_page((unsigned long)ce_arr.array);
 		return;
+	}
 
 	INIT_DELAYED_WORK(&cec_work, cec_work_fn);
 	schedule_delayed_work(&cec_work, CEC_DECAY_DEFAULT_INTERVAL);
