Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E42518C793
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 07:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgCTGi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 02:38:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34482 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCTGiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 02:38:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id t3so2593692pgn.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 23:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CukxtkxT+Q48qY1A9L3gFbMoquqPVUc6eYywVtaeaBE=;
        b=xxOqNTi8F/tJDEEGAAD3ujMU4drRNruFremRBVzXJtpxSMPgnGsESozPOfG77VJINq
         fx+Sv2RJrALdcBkcK+7mhrsNossC+WDOdwGfux7YQyW0BgjqXMe95LvWiEOG0dwZ8R2F
         QFKWbEwAwpfeIbRoDW5nd6m7JKwMi0dIEHFHEH/NlxetCp+GN8KmwuBbhEvmL1zbyuP3
         scDQNOw71jpjOn+cYniXGiRe+NstUeOFRbGzYlUcac8sGdwkkOgdLQK+3/sagtut8sEX
         eviDBUXy0EnV91cmHpmlDI2qTrT9bk1qddWrUi6LvwFa+nLSOAkbZmuxjuYMzea6Xk+J
         vNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CukxtkxT+Q48qY1A9L3gFbMoquqPVUc6eYywVtaeaBE=;
        b=FEkyMTTrXHLLyVsJru+yzi76rrkRJLqIVYScQrJBei2c3APb76iV2kOHByAd1ZLr8v
         QvkshDcjeSZba6JrGkjUZayOaXXbxfu2MzKJwQSyaETjKEP94NeihAETdERK9NGu1zAo
         tOM/zfIJT1HX4kpcJBHhRE//18F5fbVMQ5M0pHmOXObucil91ZLBipy4JeZR3sRab7ML
         q+g3SlBbow2OuJk5yS06LTOdSCIqCo2LHQHbrI6Iy5/Zz+br1N/1IP8FInKLxHDTdSp3
         b3AHEFlI80uNuvVcPVPnxmL7Wefl+J9UeyyuhKNTeOpIpB7T8+dBch5/0d6BsMGFlbEm
         cZzQ==
X-Gm-Message-State: ANhLgQ2w5x/YdVcMj5AdvBhZFQWt4oTYQ0HKuAR0aQQ1WS0gzsYmKMW6
        QxUMJxn8E+VJIIai2B92w056Pw==
X-Google-Smtp-Source: ADFU+vv4AHbODIomJVL8EQtqynYXfhSQeamUM8CVLJ7MWvtNVyKoNtcox4iLhGP0hxicCE940xYQiQ==
X-Received: by 2002:a63:ec4d:: with SMTP id r13mr7323900pgj.232.1584686333110;
        Thu, 19 Mar 2020 23:38:53 -0700 (PDT)
Received: from localhost.localdomain (59-127-47-126.HINET-IP.hinet.net. [59.127.47.126])
        by smtp.gmail.com with ESMTPSA id y3sm4370901pfy.158.2020.03.19.23.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 23:38:52 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: [PATCH v2 1/2] rtl8xxxu: add enumeration for channel bandwidth
Date:   Fri, 20 Mar 2020 14:38:32 +0800
Message-Id: <20200320063833.1058-2-chiu@endlessm.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200320063833.1058-1-chiu@endlessm.com>
References: <20200320063833.1058-1-chiu@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a data field in H2C and C2H commands which is used to
carry channel bandwidth information. Add enumeration to make it
more descriptive in code.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---

Note:
  v2: no change

 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      | 9 +++++++++
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 6598c8d786ea..86d1d50511a8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1133,6 +1133,15 @@ enum bt_mp_oper_opcode_8723b {
 	BT_MP_OP_ENABLE_CFO_TRACKING = 0x24,
 };
 
+enum rtl8xxxu_bw_mode {
+	RTL8XXXU_CHANNEL_WIDTH_20 = 0,
+	RTL8XXXU_CHANNEL_WIDTH_40 = 1,
+	RTL8XXXU_CHANNEL_WIDTH_80 = 2,
+	RTL8XXXU_CHANNEL_WIDTH_160 = 3,
+	RTL8XXXU_CHANNEL_WIDTH_80_80 = 4,
+	RTL8XXXU_CHANNEL_WIDTH_MAX = 5,
+};
+
 struct rtl8723bu_c2h {
 	u8 id;
 	u8 seq;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index daa6ce14c68b..c334418cd7ae 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4328,7 +4328,7 @@ void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
 				    u32 ramask, u8 rateid, int sgi)
 {
 	struct h2c_cmd h2c;
-	u8 bw = 0;
+	u8 bw = RTL8XXXU_CHANNEL_WIDTH_20;
 
 	memset(&h2c, 0, sizeof(struct h2c_cmd));
 
-- 
2.20.1

