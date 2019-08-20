Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A5396A44
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 22:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbfHTUYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 16:24:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39182 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731015AbfHTUYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:24:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so3855632pgi.6;
        Tue, 20 Aug 2019 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZ57Pwy9goeqWEy3kYnd3ji6rloSpMikDBJgK5eV04c=;
        b=SpoHEF8JKQXNsQgtY6MnkDzhzwb9ByhFwBJsASEX0AKWMcxDYzmNOi9pz8Z89Y4trr
         2S+g2E6Dsm/DAyYBloM241ZMHz/ysqfS3ZLpZB2kdjLiNexnLqwzLMQO8gl5VSacmYDl
         zjE7mu4e4017UyHHkLTRBVh1A5aBLT4A5QzalORPfgRTQfQOQTyc72vdWV3W92ck6gj4
         Eq1vm/1kEMfQNCMwZYG+QEgU146bE47lU/ORjQE6lM/n4vjsiximZpMd0h5idRGlKZe+
         Mwupm6rAQFK4wqQsRWTeXSmcacHkP/J1k/BNWFWaz8T+zgyRx2us60GQPx0fVee30hvo
         sv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZ57Pwy9goeqWEy3kYnd3ji6rloSpMikDBJgK5eV04c=;
        b=cwQ4mQbooZEGIb+6GjvgU/fkjapGORlbqfBsfBM1plnHdSzbTcxiQlVF4XegHQ5EEa
         USypBAlOYgXUtmZ2+ekaYWscLrLRHWGCN3pMNXeW0DJ/lPkXBz7r2skynbyeQd1ILpBr
         zerTdpr/HbcypDxSdNqT0l6nCp5WP5xlHIywV8ppgYlHV88cKSRmsBhvf9htCZDIAfd3
         JT5uuRuoHvS9x5eHb8VKk8TeUhuE9XiSLFINQD5SIVwYzaP2BtnIkrClnSyG/FblXS31
         L6WdUgobfW13HjnI+x1gqwegq6XFQsaD/1GJfU2TxJ2kWj6hYP9Xk71u2YBwBD4wvKzd
         PlKA==
X-Gm-Message-State: APjAAAVSzYG1lWLGWwkwJ0Dpt0aYax43ZNTovH827D9HvuX2KzGepdgl
        0k/a3/hgh40fCuc0dtbJzMX3r4mqRWA=
X-Google-Smtp-Source: APXvYqyYyVb8wi394gehiRN2LOM//a0CEXglEwzHvtDHQqME2sxHtR8HGD6ekiKWSBs17JjBs5hxIQ==
X-Received: by 2002:a62:1d93:: with SMTP id d141mr13086841pfd.40.1566332678184;
        Tue, 20 Aug 2019 13:24:38 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id k3sm36149846pfg.23.2019.08.20.13.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 13:24:37 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Spencer <christopher.spencer@sea.co.uk>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 14/16] crypto: caam - always select job ring via RSR on i.MX8MQ
Date:   Tue, 20 Aug 2019 13:24:00 -0700
Message-Id: <20190820202402.24951-15-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820202402.24951-1-andrew.smirnov@gmail.com>
References: <20190820202402.24951-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per feedback from NXP tech support the way to use register based
service interface on i.MX8MQ is to follow the same set of steps
outlined for the case when virtualization is enabled, regardless if it
is. Current version of SRM for i.MX8MQ speaks of DECO DID_MS and DECO
DID_LS registers, but apparently those are not implemented, so the
case when SCFGR[VIRT_EN]=0 should be handled the same as the case when
SCFGR[VIRT_EN]=1

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Spencer <christopher.spencer@sea.co.uk>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/ctrl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 4b7f95f64e34..3b18e7e8da1f 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -97,7 +97,12 @@ static inline int run_descriptor_deco0(struct device *ctrldev, u32 *desc,
 	int i;
 
 
-	if (ctrlpriv->virt_en == 1) {
+	if (ctrlpriv->virt_en == 1 ||
+	    /*
+	     * Apparently on i.MX8MQ it doesn't matter if virt_en == 1
+	     * and the following steps should be performed regardless
+	     */
+	    of_machine_is_compatible("fsl,imx8mq")) {
 		clrsetbits_32(&ctrl->deco_rsr, 0, DECORSR_JR0);
 
 		while (!(rd_reg32(&ctrl->deco_rsr) & DECORSR_VALID) &&
-- 
2.21.0

