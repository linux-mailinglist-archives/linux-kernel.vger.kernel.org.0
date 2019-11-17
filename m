Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC5DFFB4E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 19:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfKQSH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 13:07:59 -0500
Received: from mta-p0.oit.umn.edu ([134.84.196.200]:47148 "EHLO
        mta-p0.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfKQSH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 13:07:59 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p0.oit.umn.edu (Postfix) with ESMTP id 47GKnV2xZyzcnW
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 18:07:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p0.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p0.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MZrnhsVrFF4q for <linux-kernel@vger.kernel.org>;
        Sun, 17 Nov 2019 12:07:58 -0600 (CST)
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com [209.85.161.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p0.oit.umn.edu (Postfix) with ESMTPS id 47GKnV1dDgzcnY
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 12:07:58 -0600 (CST)
Received: by mail-yw1-f69.google.com with SMTP id b184so11067153ywa.15
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 10:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rMpew6zjYt8BPuA5TZf/KmQkS9FbG3A+IGOU7KV/r/s=;
        b=YSAzwdKlPw8jVl+9ukfREsB6qTIq9HzlTnyIAkpxF5MZLdjE3vVJkhtRt1Ki6gfbgX
         nlnuj1bmxllbk7oSuG6eHo7sMUAjbNjwwXZmIXy9oy3fSor9X4Sdc8+qtJoWFAm+AQAG
         Fbib6TmCw+iyq6UnDx8HMQv1mIf0o5QIrRMyndcXkvykkfmeH+L8wk2kc/bSiud/YISm
         LmnJyRyGuwdD0hZDF3XpW3K7KL/n8RE1vaanwkHV5/rt9jEedJQJNFGnggEDazJ5DVSN
         XiZtcVVEvS/l03SsDpqpiD/o6yiiUkivEPeJHdYqN1CWc6MTsbilNvyQB99z+Db0/jku
         HQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rMpew6zjYt8BPuA5TZf/KmQkS9FbG3A+IGOU7KV/r/s=;
        b=lZGMHXK4WeRTJF7wb3LAbWiB4AAe7G3VPoN0kY2UhD+imC+KlT1ZP5xjUhke+6IAL6
         fK42ZTaDz5pg2/CUCjPbTXzYKWTdi+9ixsChbeMqxyuZ5bZjNLIQHKS/Zc9fskd4IopO
         x58OJgtQEDzrPBY7xR+zNJzuToG8qamcCo1W02YGFsiBl6oqLkctueDEB2yXXP4IWHeZ
         4Zd/Tah4aRZAY0dNF6JeA9g8CCufEEqZqk3O2jF+qxgzIBZkCKEysg+OQhN0yjDsDNYt
         JRm8qVLAbAahwqXYb0rLSr7X9k/SBd+7PvBqK1HNoAsenwZn9PGwl/xcujKNQ5RhVslW
         7NDg==
X-Gm-Message-State: APjAAAVRX1a4uNvM2QPYbJXJz8yGgUyawbkXMNsNyDDIpF6Vx2eMjrel
        gWmV3mdu9DpE+0VDMJzHvqQeNx/A2CD6QYr5ASkUBpBLsDnqQhqz8BmUvG7ir6Zdi2ICEcgOkZF
        BwXstcAgVfOj8IzzbYwJ/duNAYE1H
X-Received: by 2002:a0d:e1c5:: with SMTP id k188mr17317122ywe.470.1574014077667;
        Sun, 17 Nov 2019 10:07:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqz6mHLu72MhlrM+7cXvK++5H4c+YI4TXvAKytt9EKyUjBcaA4OHjW1IFsudo+oMSTzW8UfANA==
X-Received: by 2002:a0d:e1c5:: with SMTP id k188mr17317105ywe.470.1574014077419;
        Sun, 17 Nov 2019 10:07:57 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id l1sm8019506ywh.9.2019.11.17.10.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 10:07:57 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: megaraid_mbox: change the error level of crit to warning
Date:   Sun, 17 Nov 2019 12:07:52 -0600
Message-Id: <20191117180752.3974-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In megaraid_alloc_cmd_packets(), incorrect mbox alignment and other
out of memory failures are processed similarly. The patch makes the
error logging consistent by replacing KERN_CRIT with KERN_WARNING.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/scsi/megaraid/megaraid_mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index f6ac819e6e96..5595a7655c54 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -1046,7 +1046,7 @@ megaraid_alloc_cmd_packets(adapter_t *adapter)
 
 		// make sure the mailbox is aligned properly
 		if (ccb->mbox_dma_h & 0x0F) {
-			con_log(CL_ANN, (KERN_CRIT
+			con_log(CL_ANN, (KERN_WARNING
 				"megaraid mbox: not aligned on 16-bytes\n"));
 
 			goto out_teardown_dma_pools;
-- 
2.17.1

