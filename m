Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B127BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 13:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfEWLgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 07:36:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45772 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbfEWLgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:36:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id n22so4120970lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MMfGJf5frnUDLRDsQYeuqMunOFEwSP2w0GYWkV6PgaI=;
        b=XAtK57P0NZaxIhWEoFwQxeeQk0DFldgXk/hYNnvn36KLtzGgyXnm+oNoWdK6Z0zkk7
         +JgWI6BDBU83ZcE1znfUsuShCPqqGJN0NOfoNxKMWNRQr1QwkPnd0MfFh2xkwNek14LR
         yb+XQv875anXhOLnQJHqqoo1bAZ/a2Q/n9KkSMRTZQGgFSDkjAEpKKGLLPPW+n113l7a
         XG45xGvcfgZ+N4JNtcv5cBW4+DxBH8/40LBmVZNu19IzlVnscV9d1Ew8Uf6ddAoGmFNN
         8LnDwcjW+WMnTScaP/Bw34cT2Nz7o5WhYpcAuqrMz4DuhTi3CUMBlatKwa745yFSk/Vs
         GXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMfGJf5frnUDLRDsQYeuqMunOFEwSP2w0GYWkV6PgaI=;
        b=CD5o4CpJ9AtQPl6weK7ZzWGpz7sQBKrBNCXJjLTltXiVrWr4faXKq0E7XdHlh8Is+a
         Lzu+E+DXVIP0vGGcK3LkylGcOe5pnKk4kYRLG6YGv6kGGl6lLMJtZxjctYrVuQCrQR/f
         fJqn/hcYhCziw6n+ybZVTMHu5jDsf1PaNzHnINeqgoXSbAaqsnDI+uND3q3nVEPV/rpE
         La9dRGLf1gI6UAwvYJDhvZ1NQzm4MQAHRGdy3wFGJ8g0o4BlHhvy3MvU4vA/e6E2+a03
         7vmwbU8prhTP7BGfJi0ufRF+6hw2S/0KwjERGc0pmYYfV+sZgFlSSNKc3OwnIEBAuB6R
         gehw==
X-Gm-Message-State: APjAAAV7VrhfpmHPHWuEnTIXHSZ19Rvn0ZzKSvmMKoGMDTBii25WYffJ
        UC48a1MeyDK6O4nP5j3CSxgtug==
X-Google-Smtp-Source: APXvYqyeGFkmgQDfdbxxObn5avwCTog9iSt4jZ/lHZZHaqQNyYwSHPi1nHkwQuKtdATqm5FLL3IHWA==
X-Received: by 2002:ac2:4c36:: with SMTP id u22mr1907383lfq.33.1558611398327;
        Thu, 23 May 2019 04:36:38 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id d68sm5269287lfg.23.2019.05.23.04.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 04:36:37 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] staging: kpc2000: remove unnecessary include in cell_probe.c
Date:   Thu, 23 May 2019 13:36:13 +0200
Message-Id: <20190523113613.28342-9-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523113613.28342-1-simon@nikanor.nu>
References: <20190523113613.28342-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warning "Use #include <linux/io.h> instead of
<asm/io.h>".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index b1ce1e715d9a..00005017c850 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -4,7 +4,6 @@
 #include <linux/types.h>
 #include <linux/export.h>
 #include <linux/slab.h>
-#include <asm/io.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/mfd/core.h>
-- 
2.20.1

