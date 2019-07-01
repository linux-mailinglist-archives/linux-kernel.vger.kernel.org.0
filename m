Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2772B13BA6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfEDSj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 14:39:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37978 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbfEDSiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:38:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id e18so7863704lja.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o0cDU1BXv5VFQHPh2ti7WsJqqFC+QgZJXmk2RElz7/4=;
        b=Yw9Rt8462pgPGQNH5YoTD4gO1SUCsji/TdAx5aRzo7lSmutgUdv2tjzEGTH14UPQQ+
         gT3Ll8Dbn68+2Ny7OHrxKZsq0pyqitPsTDhH7E9ouZTmeo4av1g4/x0fCDpO6PcMUUPN
         nofLR2t8f8fhZVZbTt2CV3v1CQ/2F0MGk8AqEjGeyfBw7X+/Dx/yi+OcRdPH0uV381Sy
         wro9yA675OjNMI6P4WPNQsPDeBd5dL4lg5ZkxkOth2rjhmYFXFX6LKecTR6sHZ+yXO8t
         HwN0TKLoBpwbcN4ksZf3AbHd+cDte4pU6rmu/Q0/qpynkRHJ3TSHeWEdXHuayWLYssn3
         ZTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o0cDU1BXv5VFQHPh2ti7WsJqqFC+QgZJXmk2RElz7/4=;
        b=f5MpuMdnqUJqRci5n+rYUt9OG/HFmn7A/DF0+lBwWRgJ5bH8PZJvQWb32xFrRD6cdi
         /iY5QgF2JjpEJ0ZFqi1/5+20FqYjbc+hiw7x2/YO63Yh/fAL8ZfmhudRYvirCsn9768O
         bGb9KK/qH0nWK2WNnmVX7XJvZ7xjFX8yH1lq+Vm/hY4MQnS5d80oThbmHpi4dz9kV0Hm
         nKrmF8+EtXQQohdUxhMJ+gbfxHcJZOaeEro1bhvBhADLGQN8w5JB7LT/qPzL7NUc+tUi
         NqH0/j3BWFHaTglv9DjFaCxkA6EdF6BtADt1BTTj4pkq6IoNLsoR3V+sJ2F47zyd79E9
         ztkg==
X-Gm-Message-State: APjAAAUaMqLgCkzyT9hX+nX5QLKxR3BCZ3c7jbBguthsLbKKYKpdtrhi
        1bHyCJKdAZPHyo/YTBEQHX0Avg==
X-Google-Smtp-Source: APXvYqw4JHliw8rAt42zU6TKO5tcUkqD3b3JbHhXJxYv5sshF7PsiThOnWntvJbYYitAicUNiKPnLw==
X-Received: by 2002:a2e:c41:: with SMTP id o1mr4742110ljd.23.1556995128468;
        Sat, 04 May 2019 11:38:48 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:47 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 22/26] lightnvm: pblk: recover only written metadata
Date:   Sat,  4 May 2019 20:38:07 +0200
Message-Id: <20190504183811.18725-23-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

This patch ensures that smeta was fully written before even
trying to read it based on chunk table state and write pointer.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-recovery.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 865fe310cab4..a9085b0e6611 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -655,10 +655,12 @@ static int pblk_line_was_written(struct pblk_line *line,
 	bppa = pblk->luns[smeta_blk].bppa;
 	chunk = &line->chks[pblk_ppa_to_pos(geo, bppa)];
 
-	if (chunk->state & NVM_CHK_ST_FREE)
-		return 0;
+	if (chunk->state & NVM_CHK_ST_CLOSED ||
+	    (chunk->state & NVM_CHK_ST_OPEN
+	     && chunk->wp >= lm->smeta_sec))
+		return 1;
 
-	return 1;
+	return 0;
 }
 
 static bool pblk_line_is_open(struct pblk *pblk, struct pblk_line *line)
-- 
2.19.1

