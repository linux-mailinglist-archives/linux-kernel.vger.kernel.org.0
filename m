Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3577D1003E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 12:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfKRLXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 06:23:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41360 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfKRLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:23:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id b18so17544413wrj.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KLof2Ot2O0jJsk//b5zfFITAj/UOtVeGro1UsWAolSk=;
        b=elWWomxSPHebcZk0Trubc8L5kEP6wL9XtO81YdT8gyx9ra6Yr3MR5kKzXGMCkwMPVs
         BE+RcvcswFqurNh9OLFzWLMEdrpQ/+hCHpDuRZypdrHKclsc+fUSGJJDI5J16D1jRXdj
         xLoYw3vg0JRJyZxqERNDWO9d1v7l5RpPLJXv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KLof2Ot2O0jJsk//b5zfFITAj/UOtVeGro1UsWAolSk=;
        b=bo+UXotihh6VmYhPfZ3TUVvTattksVYZUKZAf/xapvYLaUt0Ovlg+iWb+iWos2UWz6
         j2igkU5RFcw4M81ppAwpgLxWE/AxsCKE7Qd+NbLVEQ5X8NUHIg3jpME2VG1/eXIOsyXx
         +c2K64yrYMmwepkYrCOh0kM4uny76E1nhc/5+HtZmU6H2oo174JpRDNUPrXCIkuvcLC1
         zmIV1s4tPzoK/+m/f9pXN2hXbPFqFnSQqMDkFDGJlLfz7aETC7EGH0BwXDAuA4mkBEUY
         jfP9fFcpsoXE0PLtgfgLHm8/vl8oymdpW44CvUDpw/kAyegFID1E4sMakQYr2tOB3HdZ
         LJww==
X-Gm-Message-State: APjAAAUCy9h77ztYzk4Kb2/PIloxcKAepWvw1aShEk+UOH9bdm5RqzxT
        XtciOFm0in08o0CG0hkNBZeRpw==
X-Google-Smtp-Source: APXvYqyl3A2G9VNz+dkcU5PQ4A0FsewbXzROuzUM5ftNla2BArLG225nHfRbNT+dpPvsMh39OwZHnw==
X-Received: by 2002:a5d:448a:: with SMTP id j10mr21121634wrq.79.1574076218309;
        Mon, 18 Nov 2019 03:23:38 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:23:37 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 06/48] soc: fsl: qe: replace spin_event_timeout by readx_poll_timeout_atomic
Date:   Mon, 18 Nov 2019 12:22:42 +0100
Message-Id: <20191118112324.22725-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for allowing QE to be built for architectures other
than ppc, use the generic readx_poll_timeout_atomic() helper from
iopoll.h rather than the ppc-only spin_event_timeout().

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 456bd7416876..85737e6f5b62 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
+#include <linux/iopoll.h>
 #include <linux/crc32.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of_platform.h>
@@ -108,7 +109,8 @@ int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input)
 {
 	unsigned long flags;
 	u8 mcn_shift = 0, dev_shift = 0;
-	u32 ret;
+	u32 val;
+	int ret;
 
 	spin_lock_irqsave(&qe_lock, flags);
 	if (cmd == QE_RESET) {
@@ -135,13 +137,12 @@ int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input)
 	}
 
 	/* wait for the QE_CR_FLG to clear */
-	ret = spin_event_timeout((qe_ioread32be(&qe_immr->cp.cecr) & QE_CR_FLG) == 0,
-				 100, 0);
-	/* On timeout (e.g. failure), the expression will be false (ret == 0),
-	   otherwise it will be true (ret == 1). */
+	ret = readx_poll_timeout_atomic(qe_ioread32be, &qe_immr->cp.cecr, val,
+					(val & QE_CR_FLG) == 0, 0, 100);
+	/* On timeout, ret is -ETIMEDOUT, otherwise it will be 0. */
 	spin_unlock_irqrestore(&qe_lock, flags);
 
-	return ret == 1;
+	return ret == 0;
 }
 EXPORT_SYMBOL(qe_issue_cmd);
 
-- 
2.23.0

