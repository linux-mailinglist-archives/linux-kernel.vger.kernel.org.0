Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC19FE7EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 04:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfJ2Dkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 23:40:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36768 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731114AbfJ2Dkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 23:40:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id j22so2503270pgh.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 20:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cTJ/5ueE8SvgUdZQJcjb9C4BjM0/MnFjXu7d16hPfEE=;
        b=uayqepFLEbT17OItKInIgyzSaTQTIU3+znFT/Q6z1MZIPCyS7kpDuUrQDiwgsYXecG
         OWhMrS50AGiSKNP/pVNclWclacE0R+YH/aIeDbS3T2jompGDdJVW0wHSEQ3VMgrBFZit
         uj21rhz/iBfP7emBcKGLuoyXjimJbIbpjqt515gEowuzwqNVx1oG7sdp0kliDyaQr8Ja
         8FnZ+O3+/IGjSFRzI3cV8PxzPiCcMUvvnCZ6Wt8R2DoE2JqtD+h/4kPN5+KdhVaQVfmA
         GLMA9aVzLCuYh9pHSe5X0VMd54qRAR11Prf9uRq9gWq0MBSJPPRHoTeN3U8QJzTKFRhS
         EuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cTJ/5ueE8SvgUdZQJcjb9C4BjM0/MnFjXu7d16hPfEE=;
        b=sV6jR6oFDN/bslGTeitqxY+YSAlTB4kB5WMlQ5KqMZ85M7bDjKlkCcctelxET8q9K5
         /OCyrJJBWKFjbysWnBtplQLicqFGdXOqJFZe2r6BjW1qsR1hYxWzIGfTwn75FwYbeBQ9
         DzuwZENfamDsbGn2Ib1tSIELLXosMn/l1H4fJhoeZbaugArGdchsNF3216namt18q2Tm
         WigQ9pkEbLVbw8N7rGsjk5yW7skHtZCcjczdE4teQPJSNyd5Hz8e45NHUUlNJvhJSe63
         QYpCLtZ3A9HR26wp1Px/j/6wlkLxBV6kE7LYBn+meqx/64ZWllFnzgbTysU104mYQ4ma
         ULEA==
X-Gm-Message-State: APjAAAUOvoAL3c3zjn5qyKDtTWclT4yUM24v5iIiRvohkRsWGmx4Vvgl
        o3M0yWFJXskEsfmGk1N9wO0=
X-Google-Smtp-Source: APXvYqwnKoU9U846A1HWXHnbxkTSiV3L1FbA3LwJy2VUUEt7swz4KjWlyX6zJbeAP06Tfd4x/oM5dQ==
X-Received: by 2002:a63:9543:: with SMTP id t3mr24798812pgn.350.1572320435280;
        Mon, 28 Oct 2019 20:40:35 -0700 (PDT)
Received: from saurav ([27.62.167.137])
        by smtp.gmail.com with ESMTPSA id l11sm13911499pgf.73.2019.10.28.20.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 20:40:34 -0700 (PDT)
Date:   Tue, 29 Oct 2019 09:10:27 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        groug@kaod.org, clg@kaod.org, christophe.jaillet@wanadoo.fr,
        tglx@linutronix.de, saurav.girepunje@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] powerpc: sysdev: xive: Fix use true/false for bool type
Message-ID: <20191029034027.GA7226@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use true/false for bool return type in xive_spapr_cleanup_queue
function.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 arch/powerpc/sysdev/xive/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index 33c10749edec..74e3ffae0be6 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -533,7 +533,7 @@ static void xive_spapr_cleanup_queue(unsigned int cpu, struct xive_cpu *xc,
 static bool xive_spapr_match(struct device_node *node)
 {
 	/* Ignore cascaded controllers for the moment */
-	return 1;
+	return true;
 }
 
 #ifdef CONFIG_SMP
-- 
2.20.1

