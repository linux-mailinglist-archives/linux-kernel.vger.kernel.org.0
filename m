Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E34579EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 05:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfF0DZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 23:25:35 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39537 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfF0DZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 23:25:35 -0400
Received: by mail-ot1-f66.google.com with SMTP id r21so99567otq.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 20:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HjN3R4taWV9ZkzqtfFfYqtTJoGWa+sVZ87kMP8YXV64=;
        b=p73g0i/lWc+fOBoO5RiaEgcznFDaujrFRpK8nrpjNqvGjrawC2EaPVvV4w+W4qMSNj
         kPn5pFRhuvQUd9x2sgIAVHXF2eeTLxWFP/Q58yokH46HloqfSSpAeKShM5EbcaODu9M6
         QznKz+hpJersSvp2oXpnu1SX3GtQQFR6urwFGAEDK4trHAPFepXs+Gg0ZVamM/NH5T11
         6avK6vXC6QN0QSrYQ+Une0tiKfRAHPum6xt4rRhPYQzmiH1CKrAdACQCVRJFkhGJR76J
         GshTMOVTzJFEPyZKt49AKANlEsI5xpd9uxfcHBqSRQ7LzU3VYAkPffH6bH40AxELynMj
         DbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HjN3R4taWV9ZkzqtfFfYqtTJoGWa+sVZ87kMP8YXV64=;
        b=K+cVrzLf8pKOsG+DRae+teZ2HiesynZZmEm2yutvaaZf8oBM1LoJIkWKf5oke4x8km
         4CctEk3oMOfMxkAyF8mJWfnPQxqAiepe5uf+pVlfjiz1UgzzWAIBgCXgc2PJE10tFQ6u
         MuV27/BqiCHtiMk6u/mlB+EFSMFSaRoGxFh6G4IT3RSI0fkkXneoyptbcueZ2HNSrFlW
         DR4GWfChJKj12FbXFIgDih69NZxBNMhuORIUoiAKKA/ZrzqcwFYJRhfm4LTZE/rpHqsw
         ZjtvDMhehng8noLp/DtMXdvQ3wZitfaTaXH6QP4zkRVcZY9hG/VlYc7qpqJ9zICIGW4b
         Ir5w==
X-Gm-Message-State: APjAAAWdl6x+NPHdz/K9tonsduaMjTrdfQM8yLh22wyk1AuzWb/ai8Dx
        adFlaz07PBxmrkT2A/agg/E=
X-Google-Smtp-Source: APXvYqw8EnmlfwshdOVKyWDk3h/vd06XTuBwLqic2iEJQoYlW52eCytOnrZasY+djy59hIiS3GdOEw==
X-Received: by 2002:a9d:6385:: with SMTP id w5mr1320187otk.227.1561605934166;
        Wed, 26 Jun 2019 20:25:34 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id y184sm417647oie.33.2019.06.26.20.25.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 20:25:33 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: [Linux-kernel-mentees][PATCH] ethtool: Fix undefined behavior in bit shift
Date:   Wed, 26 Jun 2019 22:25:29 -0500
Message-Id: <20190627032532.18374-1-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shifting signed 32-bit value by 31 bits is undefined.  Changing most
significant bit to unsigned.

Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
---
 include/uapi/linux/ethtool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 3534ce157ae9..859b2e99c000 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1691,7 +1691,7 @@ static inline int ethtool_validate_duplex(__u8 duplex)
 #define	RXH_IP_DST	(1 << 5)
 #define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
 #define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
-#define	RXH_DISCARD	(1 << 31)
+#define	RXH_DISCARD	(1U << 31)
 
 #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL
 #define RX_CLS_FLOW_WAKE	0xfffffffffffffffeULL
-- 
2.22.0

