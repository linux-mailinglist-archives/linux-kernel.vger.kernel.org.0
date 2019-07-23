Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5980D70FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 05:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbfGWDOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 23:14:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40647 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbfGWDON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:14:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id m8so5964838lji.7;
        Mon, 22 Jul 2019 20:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wvMj+TSXx0caGJICPDntAoDwA9dWuEv6I6M6qTAotek=;
        b=c3DnN9fvHRo3bFS88ask5fuq1tlYkD14UfLeszuyyZddq66MXARenKVJqIAtxZEgHK
         Iz3kGPEfDXbLxEVVY/cwgaouUL2eBDlawgisCzptJTR1h08UhiMtKDJGfJWNECYnAYkc
         efEoALX5ncGlM8R3Zc4eu2ZBHlcphQz3YCfN6wNoRsARpPSwBZzZNMuyM7tjMXgj8lXn
         PNlppXFRyeZQhfWi9YoUY/oL4POpU7NA3c50aQl4F+/Uq/zPJ/SGJeMkNpwU0Af+NeCP
         6oPBUqrfYxUSnIFLhIzn3Y6aQVbSSNeRwE2zWGFbLg+GNVDTeqx7gyFguM5j1VgEUaga
         spdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvMj+TSXx0caGJICPDntAoDwA9dWuEv6I6M6qTAotek=;
        b=pawCgAKYKcKh8/eD12R+N1+KRFqY9NAYAdethAg+IdlD35p/z3rmH6fLNnSNbwBJkQ
         AFB73G2u8Z4XdzP2Uesf/TQNOj/Y+Kdqj3W3gCt1wo/b4iB50WfWgpcDfHs3PM5tp8Yi
         7Au3yD4X4xAofuKis4RB5Y7BmHhnQv28nKrCyjOr5Nxoiuc31RvvjZWLtGnzJFOORaiS
         D5RxHZvnj5vIbMzJ72Xu0HUAm3GBWHDU82us6YkIJcUv7L605xtKp8oscUSdtUzSNQcV
         whVWJrIKTbCxaMZVHOq5P7FFhFYjVTfAtvD5VZAX9RhqFCqSNL52mvxHU6OedJe5Ow96
         axbA==
X-Gm-Message-State: APjAAAWpUHo8zc3iySk5zzRRPRtpEyG1B0Y6eGgs1lE0bmOvoJqhh66z
        CD4TYl20VfKXfFeYy4yR4dw=
X-Google-Smtp-Source: APXvYqyQMoSjpWDpz8HjV+IeC7++qgUHGShslJhSAysTu3MOdlrre8Y3tdmhF28QUhgHRjLSamqayQ==
X-Received: by 2002:a2e:a415:: with SMTP id p21mr38053838ljn.111.1563851650991;
        Mon, 22 Jul 2019 20:14:10 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id u18sm6217184lfe.65.2019.07.22.20.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 20:14:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 04/15] memory: tegra20-emc: Include io.h instead of iopoll.h
Date:   Tue, 23 Jul 2019 06:12:36 +0300
Message-Id: <20190723031247.31932-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723031247.31932-1-digetx@gmail.com>
References: <20190723031247.31932-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register polling code was gone, but the included header change was
missed. Fix it up for consistency.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index b519f02b0ee9..1ce351dd5461 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -10,7 +10,7 @@
 #include <linux/completion.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
-#include <linux/iopoll.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-- 
2.22.0

