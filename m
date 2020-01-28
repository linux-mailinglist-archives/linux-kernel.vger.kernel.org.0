Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7712014ACC8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 00:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgA0XzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 18:55:17 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:36079 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbgA0XzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:55:15 -0500
Received: by mail-pf1-f202.google.com with SMTP id 6so7456840pfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 15:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lQAaJOF70jpkpbgo3OKWXwDeISOpcrqAl/nKJxxpz8I=;
        b=rNFOFNSB6Pg92/nVyITfWgqaiTYud0bMb33xDqixTNQOq/2QFKGJTspVwiGjqiEHol
         pXrIgNPQkcZ7yhcGyUNMxOYTDeyNi4nk5v0DLZVGW7f35WCj4CpYY0BV+QiCJ7/LjfTK
         wR/VvA3wAETdLgOYcFLndJ4cWSttfI7XnOE6Hude8Dtm6Flirqve4TknqZl+mMgPzuwT
         1yJCA6VDlssrOkxal2JQTghrhpXiTXUoqltV/Sw/XeKRv4pVSnzUSrAisz2jLrfFewwj
         xidGeyZfGUpJnurRqT5xDSrGmpDJ9rs3o1HBrNb/E3XWPuPQV72R9bC+ltwtlkjGQabS
         Ms5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lQAaJOF70jpkpbgo3OKWXwDeISOpcrqAl/nKJxxpz8I=;
        b=p9k/K98udgY1yEREf3zPq6mQgnPl0V8zq/mKFPvTe8vUbFFBWE6y2YA61/ne+uohr8
         wmObSVLU839Q5fFJtoilkrwMTldo3GDqyIPNoR7nWrygw+Wx1ADLtJ35wWS4PdcA5dAF
         D/l+ZOqBp9e342v0P9Ld9xMaLJ87QnJo9bXnlS2BXUfrlzSf2JxEjjEshQDdtdwaGFw6
         Ygh+inAMmFj2gBPkgtUy/se4y2mkIcI2cQgexgdiyDSIvTa2dgCHNo5NBI/L6sJHYn68
         5HxjWMCmnMYf49MWLihjYeNoT4Vvf/BCnX4oyfBf1E8T/Dh/WnblMP19KaOO1BSX3Bmn
         bUUQ==
X-Gm-Message-State: APjAAAX8DaCGG1txGxWhCTs9mdlPUCmBng9fmvNjpTJ3Syg3plPIiuFs
        T9VZsOpoCuzHlIF9R5aBcz/9zvI/F7R1EIMEzoMQVw==
X-Google-Smtp-Source: APXvYqyPdtbN9DZT8FHWQNBJKmpfTGEpiSZRuvKVXpp6IV7WTXe3QBgDE+xT1lY2W+Mc5+T5G2jPTWwGlbE8hQlH33U92g==
X-Received: by 2002:a63:fa50:: with SMTP id g16mr21686970pgk.202.1580169314974;
 Mon, 27 Jan 2020 15:55:14 -0800 (PST)
Date:   Mon, 27 Jan 2020 15:53:56 -0800
In-Reply-To: <20200127235356.122031-1-brendanhiggins@google.com>
Message-Id: <20200127235356.122031-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200127235356.122031-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1 5/5] power: avs: qcom-cpr: add unspecified HAS_IOMEM dependency
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, heidifahim@google.com,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CONFIG_QCOM_CPR=y implicitly depends on CONFIG_HAS_IOMEM=y;
consequently, on architectures without IOMEM we get the following build
error:

/usr/bin/ld: drivers/power/avs/qcom-cpr.o: in function `cpr_probe':
drivers/power/avs/qcom-cpr.c:1690: undefined reference to `devm_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/power/avs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
index b8fe166cd0d9f..cdb4237bfd02e 100644
--- a/drivers/power/avs/Kconfig
+++ b/drivers/power/avs/Kconfig
@@ -14,7 +14,7 @@ menuconfig POWER_AVS
 
 config QCOM_CPR
 	tristate "QCOM Core Power Reduction (CPR) support"
-	depends on POWER_AVS
+	depends on POWER_AVS && HAS_IOMEM
 	select PM_OPP
 	select REGMAP
 	help
-- 
2.25.0.341.g760bfbb309-goog

