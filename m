Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D3FD1EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 05:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbfJJDJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 23:09:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40226 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfJJDJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 23:09:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so2046611pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 20:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=suMFKZQEGEwZr8PRAVj7Gyv2/NzjvEqwMzv67rGfm+k=;
        b=Bmua95JQ8Gp4DKSJGPuU+V73PT1xBrJUUOEmk+MkDx6be98iCs8yRGHFL+rdSgDoa5
         2w5BmBLPT5T43AREMJjHkYI5WusYapm2Pixdd7QtJ925mTNYfEyXtHH1RtQ3+6UuxJUT
         sPs9HoAYW3iG2UjgkMBPPJ0tEnYFxuKsOcthVfXRQtZ0vn0J+6JmbmEzQPLAJ8hyuaCR
         TN/iuNtKagXlnzyhsqClpAHp9KkpNELImOQFYdxZl3U0AIHenVm4dcUa2VEJ3zy1zF5w
         NX1k8hbf+nUOnommX5uL8Z3JA5zTrb8CejvAwaE4lm17MOacaZ2ECFWmOmYGQ+CzPyVl
         wvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=suMFKZQEGEwZr8PRAVj7Gyv2/NzjvEqwMzv67rGfm+k=;
        b=FfhEzmtc8mESEXNQIsGduas+y1hBc9VSm7yvAEEPddDw9Y1ELAOl5iUb66oeJ0Ya/5
         oTghln438M6pCyf0wPHUorznz4mly54b6gmh1UiBQQq6RZSNUADnjOsdFEaXmB+3Ofe6
         2+0FqqxNmSkv5x2kuwl5DfukKp1z/bRMSxvf5Bejg8uWBeEknqKqVg3LpixKbt9nEPdz
         BrETR/F31gb4WxA7cxSEW0LOn5aRHgI1PRtL+LDQzFGPFlUuNDL+l89ImQ4UJpdVBvDI
         KNtuqf1v8eeh4DE35XnAuk3/dVad+fX9Zz4tR/mU8a/b7ahmwT7kSSxFsjPwaqv850d2
         MEsg==
X-Gm-Message-State: APjAAAXqa7BTg8ddaZvKzqFGIYSmhuQKbWqvaLLsuBO6CrW39DvA2yL3
        JfEgSkqyWWI4rN23UYyj2W0=
X-Google-Smtp-Source: APXvYqwyj4UgbldcCqsMP605uHyuy2dA8ef1zfiZvkS6zJoecbO4KkZkKGNsoDshNSSb2DIv4dbGkA==
X-Received: by 2002:a17:902:d90e:: with SMTP id c14mr6652911plz.91.1570676983514;
        Wed, 09 Oct 2019 20:09:43 -0700 (PDT)
Received: from panther.hsd1.or.comcast.net ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id v8sm9713196pje.6.2019.10.09.20.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Oct 2019 20:09:42 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, chandra627@gmail.com, dan.carpenter@oracle.com,
        fabian.krueger@fau.de, simon@nikanor.nu,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KPC2000: kpc2000_spi.c: Fix style issues (missing blank line)
Date:   Wed,  9 Oct 2019 20:09:32 -0700
Message-Id: <1570676972-4032-1-git-send-email-chandra627@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved: "CHECK: Please use a blank line after.." from checkpatch.pl

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index ef78b6d..0d510f0 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -50,6 +50,7 @@ static struct flash_platform_data p2kr0_spi0_pdata = {
 	.nr_parts =	ARRAY_SIZE(p2kr0_spi0_parts),
 	.parts =	p2kr0_spi0_parts,
 };
+
 static struct flash_platform_data p2kr0_spi1_pdata = {
 	.name =		"SPI1",
 	.nr_parts =	ARRAY_SIZE(p2kr0_spi1_parts),
-- 
2.7.4

