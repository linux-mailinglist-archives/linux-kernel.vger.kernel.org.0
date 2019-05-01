Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7431092A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 16:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfEAOfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 10:35:52 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51641 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfEAOfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:35:52 -0400
Received: by mail-it1-f196.google.com with SMTP id s3so10041041itk.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 07:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mSs2yNlHbY+wZB9lX3ZvKE2h2hErAuQE3Avn7VuEWec=;
        b=NDY7AD2XRMBP0hDJ69zNHsVssWK7Tr3fUPJSaL2hDV0oDfRvhOTbUfLs6Mlve/lYP/
         wexO8EV2+Eik7AypwiVfH8A+oVU/eK+EFYSax68iPi5wFTBCOXgiLz/hxikLeuWukbKN
         ckkg92HJK0b/Q/XCm/gxz2qCp/Y5/cSvZjE/qkx9EkFZiCN6Dm1Y1mq8aU6ctc007qE1
         WB3ws7/YnjtrukoAyne9rbZf8HHBZT1cnpU1s/rz2GqPBIXIINHeF6c+TElUfHPhxKhV
         DfQ8d0T7Qp3J4aU7uR/ibQTcZB3ECpK7n7+/4A4nmtRWCiorJdReEYoD0BS6bruEYIwt
         LMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mSs2yNlHbY+wZB9lX3ZvKE2h2hErAuQE3Avn7VuEWec=;
        b=ZSIN+tcj+CzRbssm8H22ROhSbHd9IEfbKV017NqeRZcVLURDI64MM5UNjwc8HadP96
         S2q7EAZaq15nsYf7e1ixAHJHFsP1+mhO2zBmmWYlgvAsrQ0CX3dQTp5h3kX3pNNsD60y
         ca6A8PZWyKYSzp/6dicW8Fwh1Tepp6N0l/TCAzkHXdhBdpGOWTF7cQPCiXit9T+4X14t
         6a4ekgZ2oZ3Aap3FiTI+OkHWBYp3EN/P8UsjXwoDMbcqPWkMZSpbkCggCid4XZaWCNtg
         YS5seH5OiEdGgk0wjc2qdlimjr6nciHGewsjtHvvHSqmODD7DLdH2NIkRrxCNqkgF26t
         fsRw==
X-Gm-Message-State: APjAAAWZHuDLVQViQJZ6qQSVIWLYr7gck4vQH+y71MkL+XU++fOSeWXE
        1lHFRuutf9d9vRyhWhrL7qw=
X-Google-Smtp-Source: APXvYqzP2B4MQBwP2GenDXvWUYlw6JuyWO4KSUsEUOhd9HS9n/FAwPS744l6hYa8B/viSZweJB518w==
X-Received: by 2002:a02:828c:: with SMTP id t12mr51123768jag.18.1556721351529;
        Wed, 01 May 2019 07:35:51 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id c72sm3067915itc.22.2019.05.01.07.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 07:35:50 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] staging: fieldbus: anybus-s: fix wait_for_completion_timeout return handling
Date:   Wed,  1 May 2019 10:35:43 -0400
Message-Id: <20190501143543.7586-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

wait_for_completion_timeout() returns unsigned long (0 on timeout or
remaining jiffies) not int. Assigning this return value to int may
theoretically overflow (though not in this case where TIMEOUT is
only HZ*2).

Fix this inconsistency by wrapping the wait_for_completion_timeout
into the if().

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Reviewed-by: Sven Van Asbroeck <TheSven73@googlemail.com>
---
 drivers/staging/fieldbus/anybuss/host.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fieldbus/anybuss/host.c b/drivers/staging/fieldbus/anybuss/host.c
index e34d4249f5a7..a64fe03b61fa 100644
--- a/drivers/staging/fieldbus/anybuss/host.c
+++ b/drivers/staging/fieldbus/anybuss/host.c
@@ -1325,11 +1325,10 @@ anybuss_host_common_probe(struct device *dev,
 	 *   interrupt came in: ready to go !
 	 */
 	reset_deassert(cd);
-	ret = wait_for_completion_timeout(&cd->card_boot, TIMEOUT);
-	if (ret == 0)
+	if (!wait_for_completion_timeout(&cd->card_boot, TIMEOUT)) {
 		ret = -ETIMEDOUT;
-	if (ret < 0)
 		goto err_reset;
+	}
 	/*
 	 * according to the anybus docs, we're allowed to read these
 	 * without handshaking / reserving the area
-- 
2.17.1

