Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4709DBC4A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 07:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441961AbfJRFA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 01:00:27 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:49588 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441967AbfJRFAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:00:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 3F21DCA7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 04:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jTgX8G42rgdX for <linux-kernel@vger.kernel.org>;
        Thu, 17 Oct 2019 23:53:12 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 1780BC9D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 23:53:12 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id t15so3082735ios.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 21:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PiAvGPBAd5r/3XyVj4aUHP7AUeXoHl9s9vGj/rL2vBE=;
        b=SSAw+mF6f+5B+nirGSGu/AIgxkBVez4C2mLwuOn2tdvSW6D2qgygO+CJhg/4C5A4UY
         xWLJlB3gN5EseI5nGlOxXzBh17l243fYEsLjpBwMlbcyftv/av5pE+ARJqX4V6h3fEVb
         apUsF/OH+V+/oXLedtF3gnfl3I+r5VDk4FJpUI4VC2joMHaMKxpbl+T4BOTeZ1qvYq3J
         9sgaWLiyFSDyQPKt8y46jMtH/uo8saK+v/LqHHNuPDs3YPlY8kVkUpk3MQfwTOR5HcIa
         Tx4igdKciSEATWOcEVUnHHCFtyOgsKlDcT64tagQdJdLbSr4LvX88ddY8tEER3peRXg/
         7pGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PiAvGPBAd5r/3XyVj4aUHP7AUeXoHl9s9vGj/rL2vBE=;
        b=XVu6bd+BzwYlzmnlYnYjptQlS+QLMFa5AgT93c/WFChkluGBlr4Gu8q/FyTGUdjUrR
         PfRHEM5QMkqZIdwgprQXZm2WG1hlZuM7u9uBA78Kjszunxd3ECZIpG/twElwuQKkZmmT
         FAj3mn3bjL1Wl8oQxie7W5RrnTxvtmLoCzlnEtnfHzT4OfEgtmqAFo3TcPV6rn0Cvphw
         2OPLeHdseEmChSNsuv+jvCSx+vJWGIzbal+qjOSXKW8Yyh74W2pISNN714nTU52Rw9MF
         4l6aA1Eselz6yBVCR3fWC5VZfqWsmdkgSVwfHk5RZuKh91l3/1bOyeNDMtREUvRU/uJ7
         9vYA==
X-Gm-Message-State: APjAAAVKgwqC2KBT0Qqg0KdXdpWiyNT0UTPKq6fh2qXLnbOc/Qv4snRl
        R0fx2GFgWHOCiHO1FzU+l0IrlRekpyGadFO18U73Le7/RnrSbAXI/A/jYUdF3xx2T+9g3Dal7uq
        46dogT/TKb/0LNkZv2bKoq1kq0TaJ
X-Received: by 2002:a92:48cf:: with SMTP id j76mr7837586ilg.246.1571374391564;
        Thu, 17 Oct 2019 21:53:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyC/JNn6/bb1kk/U+cLwblGbXmpbY/tAAsujMTaZdpNNs4/lNdEfWgzh72OP1sSvTEK7SUrdw==
X-Received: by 2002:a92:48cf:: with SMTP id j76mr7837569ilg.246.1571374391314;
        Thu, 17 Oct 2019 21:53:11 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id 197sm1639719ioc.78.2019.10.17.21.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 21:53:10 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net/lib80211: scrubbing the buffer for key
Date:   Thu, 17 Oct 2019 23:53:05 -0500
Message-Id: <20191018045305.8108-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "key" is not scrubbed. As what peer modules do, the fixes zeros
out the key buffer.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 net/wireless/lib80211_crypt_wep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/lib80211_crypt_wep.c b/net/wireless/lib80211_crypt_wep.c
index dafc6f3571db..08e511aaa1ff 100644
--- a/net/wireless/lib80211_crypt_wep.c
+++ b/net/wireless/lib80211_crypt_wep.c
@@ -202,6 +202,7 @@ static int lib80211_wep_set_key(void *key, int len, u8 * seq, void *priv)
 	if (len < 0 || len > WEP_KEY_LEN)
 		return -1;
 
+	memset(wep, 0, sizeof(*wep));
 	memcpy(wep->key, key, len);
 	wep->key_len = len;
 
-- 
2.17.1

