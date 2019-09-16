Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0EAB3E91
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 18:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389708AbfIPQPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 12:15:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39135 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389779AbfIPQPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:15:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id bd8so101055plb.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a/DBFL5pnFxmW7r8pfJ654oUFkPKTYmOJJb8EXbuSt0=;
        b=sYJTtMzaFQwnHrfE0d9bJhN5rJL+SO2sue5FpfF9LXaYmhdpitHfR1Mc6XMxU1Oth+
         JQAA2gJlVkMivG0TmPvinQOqimNim8N/21fhacTw0RdNDLtxPidi7L9R2U43pM6SLVaQ
         ua24bR6jkaW/OpEH84OUVaTt5s3KO3zFAZPV1earH/37b07DVZ/iKbah7H78F9ruW6dn
         BckDQs5uhXLjdbUq/WfcMG7QausOcDfiKMi/tFmNhYQCx/ddbG/CDzBXCEc2cH0dGrc5
         KFx+mQF1bn5iJK9R3+e439dl8iIWf/BRAUXaj7JeJ9DvsUXa1qV0jRfO6F4Q3IyBRncZ
         dtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a/DBFL5pnFxmW7r8pfJ654oUFkPKTYmOJJb8EXbuSt0=;
        b=GHic4jLZW3cKE5eSqID0HYRSKyjcb9FSedD55fHPny2OVPWRaVFGeD+5VitZtPrMkB
         kqxQ8olVCM4Ui3CuhFJrh8mIfnTvDyHQGptUPg3AWjzoVRAhvU2sb79hBpS/FKrlJoqP
         F1BuWhsvnnQ6Q8qjqO7F55fzwmWsK9FVzHaUxfTHXF5VtJ8RFG4eopV4aVfbKpEQJ+dW
         OTCa9XcefK9nWUdkYm29SmSqWHjNkPGsXpNPVKmljArQO9tYjIMxFIWI83jnx/Xtnbfc
         TysVaujdiCKDVTfPDRbNGz6sPBL5sQGf/iT49fflMS5O/kueFdEJydG7SdDFS9+91uis
         AWjQ==
X-Gm-Message-State: APjAAAU69beZ8lw15h9AHJXgqmniG4dZh2grgovCbHWmk01dv2NtuMLr
        1udogfmPMsiMqFz9XwaKbq/j
X-Google-Smtp-Source: APXvYqwai5hRsIjr6Sio2D633cSZ/kBiyCycKeMWSitnZm0JKjOMYo+90556s/ze4/hobdpZhKTxwA==
X-Received: by 2002:a17:902:7296:: with SMTP id d22mr607247pll.41.1568650510819;
        Mon, 16 Sep 2019 09:15:10 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:90b:91ce:94c2:ef93:5bd:cfe8])
        by smtp.gmail.com with ESMTPSA id h66sm614134pjb.0.2019.09.16.09.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 09:15:10 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 2/8] clk: Warn if clk_init_data is not zero initialized
Date:   Mon, 16 Sep 2019 21:44:41 +0530
Message-Id: <20190916161447.32715-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916161447.32715-1-manivannan.sadhasivam@linaro.org>
References: <20190916161447.32715-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new implementation for determining parent map uses multiple ways
to pass parent info. The order in which it gets processed depends on
the first available member. Hence, it is necessary to zero init the
clk_init_data struct so that the expected member gets processed correctly.
So, add a warning if multiple clk_init_data members are available during
clk registration.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/clk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c0990703ce54..7d6d6984c979 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3497,6 +3497,14 @@ static int clk_core_populate_parent_map(struct clk_core *core)
 	if (!num_parents)
 		return 0;
 
+	/*
+	 * Check for non-zero initialized clk_init_data struct. This is
+	 * required because, we only require one of the (parent_names/
+	 * parent_data/parent_hws) to be set at a time. Otherwise, the
+	 * current code would use first available member.
+	 */
+	WARN_ON((parent_names && parent_data) || (parent_names && parent_hws));
+
 	/*
 	 * Avoid unnecessary string look-ups of clk_core's possible parents by
 	 * having a cache of names/clk_hw pointers to clk_core pointers.
-- 
2.17.1

