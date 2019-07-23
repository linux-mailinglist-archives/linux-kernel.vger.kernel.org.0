Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04A3E70F01
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 04:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbfGWCOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 22:14:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38801 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfGWCOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:14:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id az7so19933298plb.5;
        Mon, 22 Jul 2019 19:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bcJiCvbMXNOA/uN8ruxT781zjh9D6EPOuwlY9SZ0FHs=;
        b=IELyJyyym8TNmLoys+GUIZL8k3PcKiok4b+5IqeJ8Y25pV0llokCEjDZz8mGyrfJWr
         CHXZSc0HFJahfZu2W4OF+zGScl7nyYpuDc0mAhDg5Q8AAbTODW86wxpkeQ8uKT950+fi
         YoILo3U+D5L4tGecuRmsqZQeWuJzh7BMhdg6j+Z0ZXgtFA2PTvHkBsUDB7naHTaEl9GE
         flBHr8axRUDC6wtYgzlnWZrdHnYWwJ2ISyo22JRIp/GMGDxGxl3yAI9HRrqKGgca5Vf4
         IxEG0LUYyQaefZtRoU6BqKphhDMuSbKiqnRvW3rr0yRfi7tjlCR9Odc7gaLYDWC26Erv
         BhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bcJiCvbMXNOA/uN8ruxT781zjh9D6EPOuwlY9SZ0FHs=;
        b=B1TXYA+I6PmlVHIC8nftqh2Nb/Hz/l5VmhkH5/VQI4FE/3hCEawDHYvCsxeUrhkCLH
         tgaMmlJ2rH1gfEavg8IE+Q/frjlx4NUzSQGirYnv2kkFnHRuavKZGJmQhwfQCa8NIB39
         RDFYd0tgs9vtB9m0TQAz7l7sEktAyPDn1zuEGK3Wjkq/fHMyRf9+fnBl7UDO7VQ2hU4K
         AWKtUceNx7Lzrzf4GXvJpJ7R7UHyeOhhQcbrUV0Mzwz61mGmiwuI9K/SWq6R17uweFPy
         3Stbgo3rtkdP3KcRADLpSnjmXcj5lii5m9DT1kmfVqHY5ZSsxuZiXaTI7QR5KXBPQSHH
         CB0w==
X-Gm-Message-State: APjAAAWjbm/5w3xIbCPE3t0DMqArrrXLKkJxXB4Mrm3S8syOomVwkC/3
        xse+z4chI6oMROqcVa+jeYN76C4QLJ8=
X-Google-Smtp-Source: APXvYqwJlApLg8k9xUxoYw0CE/f4MdedKH2O4nqfxcLPO80QsXqJI7H8K5qQm2kHNNu+5G5eP+9BCg==
X-Received: by 2002:a17:902:4683:: with SMTP id p3mr72153269pld.31.1563848039881;
        Mon, 22 Jul 2019 19:13:59 -0700 (PDT)
Received: from continental.prv.suse.net ([191.248.110.143])
        by smtp.gmail.com with ESMTPSA id v126sm7999257pgb.23.2019.07.22.19.13.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 19:13:59 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, hare@suse.com
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 2/2] include: elevator.h: Remove started_request from elevator_mq_ops
Date:   Mon, 22 Jul 2019 23:14:39 -0300
Message-Id: <20190723021439.8419-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723021439.8419-1-marcos.souza.org@gmail.com>
References: <20190723021439.8419-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is not implemented by any available IO scheduler, so
remove it.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 include/linux/elevator.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 17cd0078377c..1dd014c9c87b 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -45,7 +45,6 @@ struct elevator_mq_ops {
 	struct request *(*dispatch_request)(struct blk_mq_hw_ctx *);
 	bool (*has_work)(struct blk_mq_hw_ctx *);
 	void (*completed_request)(struct request *, u64);
-	void (*started_request)(struct request *);
 	void (*requeue_request)(struct request *);
 	struct request *(*former_request)(struct request_queue *, struct request *);
 	struct request *(*next_request)(struct request_queue *, struct request *);
-- 
2.22.0

