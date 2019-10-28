Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF2DE7CA1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 00:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbfJ1XDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 19:03:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33390 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730303AbfJ1XDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 19:03:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id t5so5316505ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 16:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6/4uxBpwbeTx+qNmlCApmqorecUwa/VAedjrtbrn7kk=;
        b=CCRl0YprkuIFzHjsOONkvK+qUWLZvBwpuIlYeGyN7sdQS2aIQRj3DfKuLlVbZpDxK4
         TXWS8mlLRRuwOrluYWGm0fStHMPHz3FlPnrEKWHvpYSlM324T0gxbFWXoIkZtdOYn5wM
         9f8eLvNLTmVyADQJL1Too/C63QhPzz/iea2LUEQlIBm/lA+sJriALNxf15uNX8B7oz0M
         /CIh/TSZe5QGHfIrLFd5ccf7hfgE3YtZnJoLivH/iNgMlRnuThXv8n+zA/jwCJn7VbhU
         JldbLtWH6QM8mEtunuRgdMmdAb39RTFlWC+YghYre4pJq30QMzU6NWcbJ+bCQZjSqIF8
         fMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6/4uxBpwbeTx+qNmlCApmqorecUwa/VAedjrtbrn7kk=;
        b=bh7igqpd+bnOiWuGUDL1is0/Qk2Qeopk4iKXDpnbFaJpZSvKDqyYYm8bmh8BLmwzzX
         N1vgUhK8Plu12v7HnRwiLC40GRiumlC3R303R12zwRDsOgAsAajz058igm4WR+V0HyTR
         Lo3Lq1ruPWS7J+7hVhR7aBfVuPpC+bGiS4A+0k/zxIkvFJLGU8/zzEO4d0WEBg/HrTWc
         v6SxDv3n+9BQUCl7aSFXpvDD1nXEOMv3TbF8uGqL2glbrzqDpSYLnIpqOB8I8FC6ar5U
         0hW82YUBu3Wygr2j2zUWxfFMBXi7stuULcwTV+JcoUVx+Wf2nFMT9VtGj/OBUT0DMOp3
         HmYQ==
X-Gm-Message-State: APjAAAVjoU8zOBiDmx66XffPIjkvT53F+uT/QlM+Iq4gM1ikyWRY3U8R
        iJ49CtjWK2RgvVIE3ngMcTY=
X-Google-Smtp-Source: APXvYqwnmA2MImdSpdiYa0nxe5c/trTnsj5N8YoeZJf3M3si9pkQXmILEhEmRfaJ+qOJ9GgiBRiZ4g==
X-Received: by 2002:a2e:80d6:: with SMTP id r22mr163787ljg.43.1572303779560;
        Mon, 28 Oct 2019 16:02:59 -0700 (PDT)
Received: from localhost.localdomain ([93.152.168.243])
        by smtp.gmail.com with ESMTPSA id v9sm5676566ljk.56.2019.10.28.16.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 16:02:59 -0700 (PDT)
From:   Samuil Ivanov <samuil.ivanovbg@gmail.com>
To:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Samuil Ivanov <samuil.ivanovbg@gmail.com>
Subject: [PATCH 1/2] Staging: gasket: implement apex_get_status() to check driver status
Date:   Tue, 29 Oct 2019 00:59:25 +0200
Message-Id: <20191028225926.8951-2-samuil.ivanovbg@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028225926.8951-1-samuil.ivanovbg@gmail.com>
References: <20191028225926.8951-1-samuil.ivanovbg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the TODO:
- apex_get_status() should actually check status

The function now checkes the status of the driver

Signed-off-by: Samuil Ivanov <samuil.ivanovbg@gmail.com>
---
 drivers/staging/gasket/apex_driver.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 46199c8ca441..a5dd6f3c367d 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -247,6 +247,9 @@ module_param(bypass_top_level, int, 0644);
 static int apex_get_status(struct gasket_dev *gasket_dev)
 {
 	/* TODO: Check device status. */
+	if (gasket_dev->status == GASKET_STATUS_DEAD)
+		return GASKET_STATUS_DEAD;
+
 	return GASKET_STATUS_ALIVE;
 }
 
-- 
2.17.1

