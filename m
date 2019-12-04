Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA91A112AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 13:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfLDMA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 07:00:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36475 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfLDMA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:00:58 -0500
Received: by mail-pf1-f195.google.com with SMTP id b19so3559617pfd.3;
        Wed, 04 Dec 2019 04:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JOUqYzaT4SrBpN3BgEAhNCOV53RcRoe9+46FLwrQlpE=;
        b=vVL5UBDjqC05ZC78IzTlCjRUT5vi7Utrv2LbE7JtNclsuVH6w/hRWdFAsV3rw4SqWW
         cOR8JQpnI6DnomMtt70ml+E38AsZu7MUSivGuTInzfGwwBkuoKefrhxRQ7xwzJTGX8ch
         7ylUGu46qOfJS80jsQO+tQzlKRqr80aRexpCrzKZS0Xo8PzFph93VpYnHhIbUHkRNEV/
         drj1Zld5ifKoxaRNYT7CeAqamqTWWlb/UKyyVmyeFiTwXz7Gqp6jDlsai1X0gE0R4KYJ
         u6F3d6mWyS8Ubam99uWP2VTgQpKW2Nq85uh3cSRrCosBWr/SgtLFsECYo4wLzipOsJlK
         r+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JOUqYzaT4SrBpN3BgEAhNCOV53RcRoe9+46FLwrQlpE=;
        b=H80bm+ZtbG3Da1kGRctRLx8LFgJQ/Oaetk50NNK2i1fO6AUPl5ylQBxaJho7IBNjfj
         xmYkgCMiYqTpMTR7gLsF/Hfo+vEGr1zSs9EHjaP8SFGNpc7A9+HLY7qUbWc5ZJpHvHu2
         /O0P+S2UHPgGkCcg5dom5WnXg3qoqHo/wwloONMBfjFf8f4CufqXVqQyiudIHu/RW/Q0
         cTpXSbEiF28Gvzs8xTTUXf7ib2qCk77118fyRm4jZhxjbqJVI/BmoaXGVz/ZgdoYhiD1
         ONxqEYkTnVfDyX71Dzxu9iYfXArEFauPc7/feinHoNfVcfV+5dwc1zkHitWP/3ZRSoLG
         /clw==
X-Gm-Message-State: APjAAAWemxvKJCubPOAI6SD0LyM+/yWNC6dr5LkbUIvQFoTBwUOsnjkt
        SVMklPCxZiDImjOtX0wI/zw=
X-Google-Smtp-Source: APXvYqzP9f9lsXxYUVaiQg/am2hRFTLDIm2bfMw6fHcfymyfqnLO5h3JJeO8Fjs2E1234WjteM2iAQ==
X-Received: by 2002:a63:5612:: with SMTP id k18mr3153813pgb.345.1575460857985;
        Wed, 04 Dec 2019 04:00:57 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id q200sm8311893pfq.87.2019.12.04.04.00.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 04:00:57 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, yonghan.ye@unisoc.com,
        lanqing.liu@unisoc.com, baolin.wang7@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: sprd: Add clearing break interrupt operation
Date:   Wed,  4 Dec 2019 20:00:07 +0800
Message-Id: <925e51b73099c90158e080b8f5bed9b3b38c4548.1575460601.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonghan Ye <yonghan.ye@unisoc.com>

A break interrupt will be generated if the RX line was pulled low, which
means some abnomal behaviors occurred of the UART. In this case, we still
need to clear this break interrupt status, otherwise it will cause irq
storm to crash the whole system.

Fixes: b7396a38fb28 ("tty/serial: Add Spreadtrum sc9836-uart driver support")
Signed-off-by: Yonghan Ye <yonghan.ye@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/tty/serial/sprd_serial.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 31df235..f60a59d 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -679,6 +679,9 @@ static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
 	if (ims & SPRD_IMSR_TIMEOUT)
 		serial_out(port, SPRD_ICLR, SPRD_ICLR_TIMEOUT);
 
+	if (ims & SPRD_IMSR_BREAK_DETECT)
+		serial_out(port, SPRD_ICLR, SPRD_IMSR_BREAK_DETECT);
+
 	if (ims & (SPRD_IMSR_RX_FIFO_FULL | SPRD_IMSR_BREAK_DETECT |
 		   SPRD_IMSR_TIMEOUT))
 		sprd_rx(port);
-- 
1.7.9.5

