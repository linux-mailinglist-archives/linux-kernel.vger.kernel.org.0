Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0F0A4CB4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 01:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfIAX2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 19:28:03 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34479 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbfIAX2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 19:28:03 -0400
Received: by mail-qk1-f195.google.com with SMTP id q203so1878568qke.1;
        Sun, 01 Sep 2019 16:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1kozcKzQ4CvOoVfv0dTOcnn6A5MPYzpBrY4kRBgeQw0=;
        b=ah+dDoqnW4TuaON/5pYCW/XcECVuDDaXr31caAmApBR+XMcVyoz1PRejPGKCo0pCCN
         3gq4NlhZlhS0K4x2nAXu1Jbvlb5nmvZbls9XbObor8au65lgAs5ZDjeMpDQeu5+gwLjc
         piP/vZfpmZzmbcphA/d16/BrHtITgrirdyQCRS7a/Y0gXY485u6/nJJxV8B7yEVmuHQQ
         0S6m74ur5i5WIaZ5Oy1w6WjYIZtfXmn/WgUS1v74cRUURkGIOtBl38H4dX7SP0r5eXFI
         OFMMszYgLJYCPQb5j7fvTsAnoB6it9y8uRr0N4o1swLFhwP43e2vjFD1+yskQPiQPyGw
         UGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1kozcKzQ4CvOoVfv0dTOcnn6A5MPYzpBrY4kRBgeQw0=;
        b=jkwCAzTpi48uXZPvys6ZIE2Lwl93wNHB08a7fBp/thcivtHrSUIg9sl5PQO0U6ZPUp
         qr4E1HEiPWW7DaWwkx69ZErn61lwxwNqx7tQHBvSz8/LybeC2z5NcxypkWk6CVt/DLv1
         n7a7BUoq7sfCqdA+0NXJJk5hFJzQD0dKvi6MXprt5sdgxKUxS+N91PZ9VqrkrNKDqI/u
         52/3u0iXPOuYJ/OXeYT80NAcUlbjL8217tOP+ShfM5P0GebVB9uQJjyl9E6KMjKFT4/c
         gq6t9N5jkvHY20XfbDtr3B/DE5K/KCAT2ADDK6R9QqorOvgPoBsgCbbKa3X/4WCP6OIl
         Q/HQ==
X-Gm-Message-State: APjAAAXHUXg2R9PZAvKB0yzssiPJDXwYCS+DtUs4XxBS7AH0aeF6NmWe
        UdWt9vq02TsJGtrFgncBf2z6Wm3s
X-Google-Smtp-Source: APXvYqzNdFxno04LZdZvzxy6JnbNaNaeMi7lOsrU+GMyiGhtNAMipm2QoJFRI6PXUakdMKZMyLmtmg==
X-Received: by 2002:a37:4986:: with SMTP id w128mr25342869qka.417.1567380481908;
        Sun, 01 Sep 2019 16:28:01 -0700 (PDT)
Received: from localhost.localdomain (200.146.53.87.dynamic.dialup.gvt.net.br. [200.146.53.87])
        by smtp.gmail.com with ESMTPSA id p59sm5684085qtd.75.2019.09.01.16.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 16:28:01 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Hannes Reinecke <hare@suse.com>, Bob Liu <bob.liu@oracle.com>
Subject: [PATCH v2 1/4] block: elevator.c: Remove now unused elevator= argument
Date:   Sun,  1 Sep 2019 20:29:13 -0300
Message-Id: <20190901232916.4692-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190901232916.4692-1-marcos.souza.org@gmail.com>
References: <20190828011930.29791-5-marcos.souza.org@gmail.com>
 <20190901232916.4692-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the inclusion of blk-mq, elevator argument was not being
considered anymore, and it's utility died long with the legacy IO path,
now removed too.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Bob Liu <bob.liu@oracle.com>
---
 block/elevator.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 4781c4205a5d..86100de88883 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -135,20 +135,6 @@ static struct elevator_type *elevator_get(struct request_queue *q,
 	return e;
 }
 
-static char chosen_elevator[ELV_NAME_MAX];
-
-static int __init elevator_setup(char *str)
-{
-	/*
-	 * Be backwards-compatible with previous kernels, so users
-	 * won't get the wrong elevator.
-	 */
-	strncpy(chosen_elevator, str, sizeof(chosen_elevator) - 1);
-	return 1;
-}
-
-__setup("elevator=", elevator_setup);
-
 static struct kobj_type elv_ktype;
 
 struct elevator_queue *elevator_alloc(struct request_queue *q,
-- 
2.22.0

