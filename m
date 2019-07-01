Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452EF10670
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 11:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfEAJib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 05:38:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37943 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfEAJib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 05:38:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so8392916pfo.5;
        Wed, 01 May 2019 02:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=owh1+96njcn9ahbDynNjb5P6yOXw37D/n4qns3X2QwA=;
        b=iE5hb9iFNRyVWnqSKpD3spBTWeadh31zroyhlGL7jJwEB1mAqk47Tk5b6T+JT5+F5v
         wGdkEqc2jpdtjIWNe1whifJzYfWS4w3D7ZLYZ2T7TlrJPr6wDxS/u9lrYEGhc2algPGj
         cmETf8WKLGW/dSJhS8Ad4dDFkbF8ZK8HniP2/v7KGXLV8xisnUysBrSlCXYRUEFZHGa+
         vr/FKaHUoRIptzQqN8zWZYnYVt5HTqdcsWBvzvSAQlH9WUnC/JBDefMtU8AjTO/+ebrc
         IW2EYFnieHGK7HlM94wjBdQAzN1qAw/85AlGsGp34zpBdBKYaqltvFtJ1YMqLpksusHD
         ELsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=owh1+96njcn9ahbDynNjb5P6yOXw37D/n4qns3X2QwA=;
        b=L30g5iyQNheXqplq1XNPdH5/PA2o7yNDcO3M1Fh0CuzCuFl/E8VefhFDCPfEZYVO53
         qldB0OX2f6jB0qU7PAtncz5mTECt3//xMy6i7tlYuVv2kZeWu4BU79Ig4BARAGbHhlnE
         zJyNq0Li0JcFe3gEizMWZGUsdS4SIBxjNhC6eo7pEDeWcWEFswnoTXF1MDp4BOrCmGtf
         zRmVcIXnParolV09QVurkQ8k7HOEF29x2SHzT4P2S9KIpo/hnlJs25CGE1A965eaSNkf
         2zbsiPmUd8zK1Jqmai0XMMJ4lMcRcr5wybpSDB4TIZmsWRcDg64LJBuHlxdiTSHTUbDf
         sVyA==
X-Gm-Message-State: APjAAAUxu3gk+zFrU0VU8Cwuih5MnCdlbp4bF0rU1YWpTENIVf9ud6iJ
        KIpI89ZZfcZ6B7oGykNOMos=
X-Google-Smtp-Source: APXvYqzGuCKntJdJEwVJAk71kSWaYWfCEBpo6FZ13iZkWeJVS+FrxwKKZXy9FkxRB0zReNDIP3DdSg==
X-Received: by 2002:a63:a18:: with SMTP id 24mr70870555pgk.332.1556703510326;
        Wed, 01 May 2019 02:38:30 -0700 (PDT)
Received: from nishad ([106.51.235.3])
        by smtp.gmail.com with ESMTPSA id 13sm55356715pfi.172.2019.05.01.02.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 02:38:29 -0700 (PDT)
Date:   Wed, 1 May 2019 15:08:22 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: sprd: Use the correct style for SPDX License Identifier
Message-ID: <20190501093818.GA8671@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in header files related to Clock Drivers for Spreadtrum SoCs.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/clk/sprd/common.h    | 2 +-
 drivers/clk/sprd/composite.h | 2 +-
 drivers/clk/sprd/div.h       | 2 +-
 drivers/clk/sprd/gate.h      | 2 +-
 drivers/clk/sprd/mux.h       | 2 +-
 drivers/clk/sprd/pll.h       | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sprd/common.h b/drivers/clk/sprd/common.h
index abd9ff5ef448..1d077b39cef6 100644
--- a/drivers/clk/sprd/common.h
+++ b/drivers/clk/sprd/common.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Spreadtrum clock infrastructure
 //
diff --git a/drivers/clk/sprd/composite.h b/drivers/clk/sprd/composite.h
index 0984e9e252dc..04ab3f587ee2 100644
--- a/drivers/clk/sprd/composite.h
+++ b/drivers/clk/sprd/composite.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Spreadtrum composite clock driver
 //
diff --git a/drivers/clk/sprd/div.h b/drivers/clk/sprd/div.h
index b3033d24d431..87510e3d0e14 100644
--- a/drivers/clk/sprd/div.h
+++ b/drivers/clk/sprd/div.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Spreadtrum divider clock driver
 //
diff --git a/drivers/clk/sprd/gate.h b/drivers/clk/sprd/gate.h
index 2e582c68a08b..dc352ea55e1f 100644
--- a/drivers/clk/sprd/gate.h
+++ b/drivers/clk/sprd/gate.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Spreadtrum gate clock driver
 //
diff --git a/drivers/clk/sprd/mux.h b/drivers/clk/sprd/mux.h
index 548cfa0f145c..892e4191cc7f 100644
--- a/drivers/clk/sprd/mux.h
+++ b/drivers/clk/sprd/mux.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Spreadtrum multiplexer clock driver
 //
diff --git a/drivers/clk/sprd/pll.h b/drivers/clk/sprd/pll.h
index 514175621099..e95f11e91ffe 100644
--- a/drivers/clk/sprd/pll.h
+++ b/drivers/clk/sprd/pll.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Spreadtrum pll clock driver
 //
-- 
2.17.1

