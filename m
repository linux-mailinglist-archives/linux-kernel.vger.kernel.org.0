Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 693F66629A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 01:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfGKX4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 19:56:05 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40424 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfGKX4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 19:56:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id s145so5120050qke.7;
        Thu, 11 Jul 2019 16:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aRNuz2cGdh0jwMcd7BVODz2p7ghKkaxc8od21UOb/kY=;
        b=vNjXr5x8JB+9fSBHpxi735cLzfk78HGHCWQvj5ZOSlo6qDfuoufVsV9wW2kmEb7pnW
         WycwAmcuEWpVCYtLFP2f5tC3FJ5FMb4eBSzK9zvoF/M67PcbM6+lGFGxHFgtBWtHP5lq
         seCyziM5Dn+fXrzKCazn/NUnZix6ELDnqPqhAfUIL+QG8D3lbC7DLYCBOOoyqoSIlTuq
         A8iP6/dZvaD/PJLTw2oshOdd/dtSevSWKiGJmbjQSrrswAIKD45IqAt1giqACB1np1Ai
         BfDqSQRzKsL9lFXpBnSgmIhfnri1+Ljx9EQQQnZuSbZvxfXZMGFZls4BoGtqEIq7ctLw
         2oSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aRNuz2cGdh0jwMcd7BVODz2p7ghKkaxc8od21UOb/kY=;
        b=JcVmnqM+wJhX/KJEQ668NzwAVYp7RfOpnGd4Ofmh7GG27iKYDtre+AfGZ+nAuWyIVQ
         fqoODY/us0msOZwfnNKJhkUlO3PnLQfFiY8KRlTJGU8488IMpf1RqMshwXDAbY9c3czr
         BYKlRWLUP+3ipgxXgLSkET+T5W4/xIZaYOVU8dvlq8zxXvfujC6l98jSvCeOM8eWiRil
         00emxCxhY9NE8JSPjlB9aomwF4e6fKDddF+TVmyENudn/Y9DxDpD/PxrfBodz2PeAdrh
         MlTw4TKIWXCNp02fC6CohG6j/fUs1nKbDTSrN+kQNhSUWAzu6i6aR/gfD0l2ywKeZrJT
         4LJg==
X-Gm-Message-State: APjAAAXKFt2D+/EGLc+oZBwqyXgnV2gI2imtWsCjsrs8RoT+DYLLOPB9
        kVXNGW+ipGyzCwUCNkqTzA==
X-Google-Smtp-Source: APXvYqw2iOJ8mTp/sJ+7TcNM3IfKEeIWs2Yyihuj7jlMr0gl33hyizoIcR4XHLhP0gx8WLUJMj6V2w==
X-Received: by 2002:ae9:de05:: with SMTP id s5mr4175390qkf.184.1562889364204;
        Thu, 11 Jul 2019 16:56:04 -0700 (PDT)
Received: from localhost.localdomain (modemcable148.230-83-70.mc.videotron.ca. [70.83.230.148])
        by smtp.googlemail.com with ESMTPSA id v84sm2888699qkb.0.2019.07.11.16.56.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 16:56:03 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
Cc:     iamkeyur96@gmail.com, Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: g_NCR5380: Use !x in place of NULL comparisons
Date:   Thu, 11 Jul 2019 19:55:46 -0400
Message-Id: <20190711235546.28081-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change (x == NULL) to !x and (x != NULL) to x, to fix
following checkpatch.pl warnings:
CHECK: Comparison to NULL could be written "!x".

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
 drivers/scsi/g_NCR5380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/g_NCR5380.c b/drivers/scsi/g_NCR5380.c
index 2ab774e62e40..6813094155d3 100644
--- a/drivers/scsi/g_NCR5380.c
+++ b/drivers/scsi/g_NCR5380.c
@@ -312,7 +312,7 @@ static int generic_NCR5380_init_one(struct scsi_host_template *tpnt,
 	}
 
 	instance = scsi_host_alloc(tpnt, sizeof(struct NCR5380_hostdata));
-	if (instance == NULL) {
+	if (!instance) {
 		ret = -ENOMEM;
 		goto out_unmap;
 	}
-- 
2.22.0

