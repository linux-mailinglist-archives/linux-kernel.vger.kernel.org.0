Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABBCD83EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 00:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390044AbfJOWqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 18:46:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33034 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732531AbfJOWqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:46:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so10293064pls.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yhQWkXWNjNV9NCfLVkim7P+oXzCiBgFKHaj7Vfld3h0=;
        b=ebfL4NmRapRbv0ZmBKsvHFy1Qxvx9pIptJa62c02p3z9zOp4ABftnfHv4cWWRncyo8
         NmYzoq3cLdSf8tyZYsq9OQyIzOt3TZ0YPYsHlo2qVJSQ8P8M0yxMzG8Y4Og4kk4EahHp
         NQZKCiWSERfeFfNTH+PnCGfLuPbbNuYkAXG0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yhQWkXWNjNV9NCfLVkim7P+oXzCiBgFKHaj7Vfld3h0=;
        b=lEX4dfSRRWy3gIJlg3TsOz7zSGBJz+i0aOdA/xIN9kjYs1zwR2imT4taQz0T4bIlY7
         +KI8n0NJynddLwqbcGRvo1ONfb8YS7KfpDKeNhoYl+H1SjkYNPYB32Hz7UScx/avBdK8
         BC5dYrerkZJgI9/r41yHjGNeafKgR/rz7AtUIMqy7H4VwyDSUu2mFRREVi1e6vfrq2d2
         wW8OaNCauCzFLxpCGpH+f3Jct9iF+GR46RylyAsC3SXyX0PgVLTmbLXaqxCXENLwZCdZ
         49TflsAaPuleEM8iY2nXqa7GOSuKq0CtsSy6gwlmCyWpXJzd5BAeoS8zCJgWn+eCUMNC
         b3Fg==
X-Gm-Message-State: APjAAAXBaHStemUW/pUg3iFSDDQuUoZGtLnvPrvZ13Vo7b8Zjwx/HvTh
        QWLBl125vll7Vi13DXM+p3wAyfjYhekh2Q==
X-Google-Smtp-Source: APXvYqw7geQepjqZ2rTQCvplr5kCOtyuTtSaqnfAbFOW5tJtaaxxEaA3a/JQfnhfUpkFGETbQ2F2VQ==
X-Received: by 2002:a17:902:8bc4:: with SMTP id r4mr36236446plo.341.1571179564523;
        Tue, 15 Oct 2019 15:46:04 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e127sm23019837pfe.37.2019.10.15.15.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:46:04 -0700 (PDT)
From:   Markus Mayer <mmayer@broadcom.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/8] memory: brcmstb: dpfe: initialize priv->dev
Date:   Tue, 15 Oct 2019 15:45:07 -0700
Message-Id: <20191015224513.16969-3-mmayer@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015224513.16969-1-mmayer@broadcom.com>
References: <20191015224513.16969-1-mmayer@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing initialization of priv->dev. It is only used in an
emergency error message that is very unlikely to ever occur, which is
how this has remained unnoticed.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 0c4c01d2bf48..2ef3e365c1b5 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -817,6 +817,8 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->dev = dev;
+
 	mutex_init(&priv->lock);
 	platform_set_drvdata(pdev, priv);
 
-- 
2.17.1

