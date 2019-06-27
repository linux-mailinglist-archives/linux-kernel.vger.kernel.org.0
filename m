Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99C6588BD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 19:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfF0RjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 13:39:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45222 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfF0RjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:39:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id bi6so1658852plb.12;
        Thu, 27 Jun 2019 10:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BmWQUcU2r9aSCalrpP1YGhOrzTxy2nd2SVISgnXVZz8=;
        b=cp82nNmVm2PRtqX0SqhkHVGfZeCKaWbud0R/fplCa38BlrKAgSDizqukEWxcEn7hzl
         QlZq0P7dITVjl1M2j4R5tHfhlW1gF3QdFps5V0Vi8H/MT1rT6JkgXkh0N5HRo2o3NWhN
         Y+zje59uKbRZ5iIpGrM1hfCXT8KnihceXAWsBARn1XG3fCrf2WHEk3b6/HwZ08+t4XX2
         m/lq41TF0lo8zCWBPVRLoyUWrhfb+TJCSV5OQCRE4hdQdJWB3hn7leG0+MlqxUm3aiv+
         sBNRZR8Cs1YoxSvMpjjQOeo60g3BN1KC/ryZOMJTCnij5zkyKvkUt+aweK8JJMkeKrcP
         Io1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BmWQUcU2r9aSCalrpP1YGhOrzTxy2nd2SVISgnXVZz8=;
        b=cjCMSmvBqP6G0Q95pnwMtUxTh/sfw7TyDuV13qW9ShnSNZpZupNsSGANDWBfQuSfAG
         XvhSlZvYmaEBPw8j0L30XRSxisyDW7+GUvz5WjTVRFrLQSI5lpOkmJmQ8UuCyIDaBBMT
         OJroE2LjxfElZPwVJ9FbBNo3o3E95y6xFMUHO7j6wodClE8ogVGRaPDHJWuxi90D5CXu
         r41AdHhIldGWewCJZepWvGe6jYq3aLGOsgCWlOnpwmNsD/lSgP9LEnPvbXBb0jFh7oSN
         rUBo0bJhqlYSaPIjM/ga6sYtxKnJzmmtRl6SyNlv5nnbsE8kxOaVtLwfIjo/KWcQPmwf
         ZESQ==
X-Gm-Message-State: APjAAAV0gJjOaOvOOSIZRbQXny8ChT3FxjvRj6LlAJzB4tz+NmB3ZjrJ
        zwDBobsJGgCPqf1Uc+3/IUM=
X-Google-Smtp-Source: APXvYqy/nNd1a2Q4D/H/QsqL/K3So4yhu1uB/GBPxayD3BZ4AhUnsEhyok8k4Vb8DMXd1bRAb00P4w==
X-Received: by 2002:a17:902:7c03:: with SMTP id x3mr6099922pll.242.1561657144057;
        Thu, 27 Jun 2019 10:39:04 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id r196sm2869217pgr.84.2019.06.27.10.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:39:03 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 34/87] message: fusion: remove memset after pci_alloc_consistent in mptbase.c
Date:   Fri, 28 Jun 2019 01:38:57 +0800
Message-Id: <20190627173858.3623-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_alloc_consistent calls dma_alloc_coherent directly
In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/message/fusion/mptbase.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index d8882b0a1338..845d1ef8abdf 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -4507,7 +4507,6 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 		dinitprintk(ioc, printk(MYIOC_s_DEBUG_FMT "Total alloc @ %p[%p], sz=%d[%x] bytes\n",
 			 	ioc->name, mem, (void *)(ulong)alloc_dma, total_size, total_size));
 
-		memset(mem, 0, total_size);
 		ioc->alloc_total += total_size;
 		ioc->alloc = mem;
 		ioc->alloc_dma = alloc_dma;
-- 
2.11.0

