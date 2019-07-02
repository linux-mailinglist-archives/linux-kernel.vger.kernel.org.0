Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26E055CA16
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 09:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfGBH4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 03:56:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42885 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfGBH4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:56:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so7847923pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6MHHoTlJEAE6sY1Ks3ufUvy8PVNDBt/S9EU1VSQMB80=;
        b=I9KeXjkZVTzTQBBTqX9yUWzU28ox3EWk0/kIRsqKyidDY+Rg7E9E6gLHBX7sDeonxl
         szjWW9ZGain8H0x/Y+1uDPGUuOC0AgYrRaPPXTO0ENyST3q43X6wIhlmOLEWgjVVnERF
         yXVUKUnHtoy09X12+OFOa8HPjJr5GtijOJi/IBam7DJYJ42SzNro1Bs0XeWufSFAcLe2
         Ium9tq5qBH7FFuobQhxWyk7grWH8fmunCfvC/uhUJxmBdS7tIUo3oJLRvf2jhACVlrjj
         sxTKqa+rS5w6AfXtVn9qXSVOacsYDKsO0qIq4P3UNhKDArB7iNVlG3950BMI/oQcehqp
         Fh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6MHHoTlJEAE6sY1Ks3ufUvy8PVNDBt/S9EU1VSQMB80=;
        b=O6z4Qv23TMUdVTrRMwI3wLtV4fxNRzMSnFW1E8/KgM5Uik0c/i0sM0QxQ4uZbmrsve
         SBKm+/VQBNEPbOiPLUFshsoUEv4cAjoRVJ/+TiQ5z0xUNPFixLuH2wKNxlC0gszUgycO
         LYVr54ITGNLJQGjQc1cH1TiPjjvJKEWWvUsTuu+79UyxB8hdHLfnmQ8bPFOjml5aUlS9
         60fM/Pct0AzeklqDYW4Qvsk81XiPcCWcWJnAEryHlbxgCgSfdCy8YlOMUGkV2B3b5TQT
         k6TKi87Mv2aM1fzrlB3JJG9UH9QziMRTp70Ode7CrWa0ifY0LEM+uLk0q7R+ogKmYzqo
         5LOg==
X-Gm-Message-State: APjAAAUhHCghtLW70YyCBJPyFvCZj1cN6LRIh36IqQs6poJRbuNCUgB4
        znFKQoyw+o9wcMA9hMFigYM6AKC3HGY=
X-Google-Smtp-Source: APXvYqzLYXslWl81y8TzBD8gQPgdtMdxUjpjOZLe7ZxpGle572w2hgpQSe0viQio0WzE8gZ3Y1sTKA==
X-Received: by 2002:a63:e953:: with SMTP id q19mr29596458pgj.313.1562054208786;
        Tue, 02 Jul 2019 00:56:48 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id r1sm14223790pfq.100.2019.07.02.00.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:56:48 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 01/27] sh: mm: Remove call to memset after dma_alloc_coherent
Date:   Tue,  2 Jul 2019 15:55:31 +0800
Message-Id: <20190702075531.23545-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 arch/sh/mm/consistent.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 792f36129062..b09510adfae9 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -58,8 +58,6 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	memset(buf, 0, memsize);
-
 	r->flags = IORESOURCE_MEM;
 	r->start = dma_handle;
 	r->end = r->start + memsize - 1;
-- 
2.11.0

