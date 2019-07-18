Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D01B06D3C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 20:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390494AbfGRSXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 14:23:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39050 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfGRSXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:23:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so13258626pgi.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NfeU7C+4cQYfAuh2am+KuzQ3c0bYfoeWeqp96pcMW98=;
        b=AOso9T90+nC8FC7UpIKhHVQNz/XM9XiXEx3kny7xcy3c0FhyOB/ZkcjLeiEC6QnMEy
         MQuSLHlhIpCTGc3NzkFU5FoqEsR5QGxFrKSygOfnkPDVgrot0bWeJKJbxO4xTKWpca/0
         srDMPgL6ACS+cNYSNeRph5lGocRvlP4LMfdbvpeXqzvriNg7XRSimJZf7ITwJnAtKRih
         pPOVo846YmHDQnttO5KHw46sfT2Q0FuO3K1q0luJ7JhLgEJb5x+6TcdVF3hLGzFCSUI+
         EMxTQYFPbn2kxYPW/dHBUjnutwYlKdvYA6ymcB6tdmNkNe7Gt6Ukmwz11nP5NZKbeD+k
         yr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NfeU7C+4cQYfAuh2am+KuzQ3c0bYfoeWeqp96pcMW98=;
        b=ld63Quzbq01ve/QTRpp0JMbLrHqQasW4dqnrzFlTKt+pRkQLr0sScWZWTNWBaheknv
         Qg0dJkel50UxMuiniOTARqQSrrAxJXuCQyxheY4FvHwCL8tXo1TmO8QQeXkOp87PE4h5
         BOM4xtLAMbgl1hZXYtvykwByOg3rsrp5KMXi3s1aJTuhNcr/bLS0aASFCF88uZkrEE+D
         1pkup7inYq2Q8qsY5IbcZH38FTl+gXS8MU5dPrHeNSQMZixT4dWc3J17duSf7Fs0TYw/
         CYa0t1kGOm5N0/Jm3eR0oOPzVHKsIWT9/uHuwg7HaJZPOYQOi6WHV6MzUb9jF2qhBb+8
         BwlA==
X-Gm-Message-State: APjAAAXC+/oyyxHFrh4Qm3jPZyX6iAmnn2Nhr9DDy7nI+G/hhBt12kHM
        4D1N1mqcoTwYSXL20teMRko=
X-Google-Smtp-Source: APXvYqym0j3JZFUtP4NlY1qtgqBml4ehvMqrjvgbUNRrnZdAUGNjPrRAqaxDD+nNvbnD/zBvgEjw3w==
X-Received: by 2002:a65:5144:: with SMTP id g4mr49111581pgq.202.1563474180700;
        Thu, 18 Jul 2019 11:23:00 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id k8sm28351747pgm.14.2019.07.18.11.22.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 11:22:57 -0700 (PDT)
Date:   Thu, 18 Jul 2019 23:52:50 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geordan Neukum <gneukum1@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        Fabian Krueger <fabian.krueger@fau.de>,
        Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>,
        Jeremy Sowden <jeremy@azazel.net>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: kpc2000: Remove null check before kfree
Message-ID: <20190718182250.GA3011@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As kfree already has NULL check we may not need null check before
calling same.

Issue found with coccicheck

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 35ac1d7..c07d2fc 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -411,9 +411,7 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 kp_spi_cleanup(struct spi_device *spidev)
 {
 	struct kp_spi_controller_state *cs = spidev->controller_state;
-
-	if (cs)
-		kfree(cs);
+	kfree(cs);
 }
 
 /******************
-- 
2.7.4

