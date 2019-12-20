Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF8A51271A6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 00:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfLSXl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 18:41:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46158 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfLSXl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 18:41:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id y8so3267663pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 15:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=43LknG5z6bO6b1jirRWQ3OMn0IwVLrmac7Ek+kzqWi4=;
        b=wCILxctCW8G9X5XBw2VwbNAppjxq6085IDCbS41g8TMKp3aEF9iVIOjWvFw4/szWZc
         PuObOSY5Hog39wOrRTgQWeV2kk40S8PrDWF9rVhtsEFKRBgNMSGw3tMBXv1wr5XPBDe5
         IktY3NwjfBIDkLj97i9kQkx7g1XKsnxJQ7XuNdWTadHZdY2otvWoIZKWJoLJI/7hXJZX
         n+LElsBwh4mI4ao/EWjSYwRkIEJZr/iAiYUKtW9DYGvOTBfc4hPGu18kTxVgtuTXNXaY
         gUygXqwN/uy1PiEHTQ71+7hNF1m6ZNC3SSS5tn4RfLSHmmDDCQWac2KWkTeuB2qO6yLZ
         oLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=43LknG5z6bO6b1jirRWQ3OMn0IwVLrmac7Ek+kzqWi4=;
        b=eFaLj6Fg74E7HB3LYwG/5HB5Loc2XjgPL3MK1owTZT0CyRQa29PziI3E1iPIYHXsa1
         90D+Fy2toU4Jr0dfrCP1JFn91YeqUkM8C9KDz74tFGhMUgaa2Rm7jKA3ReobdIqB3v2k
         ylO7TlRuvUlZ8s6i6gfy45+k5vWsnNcQ29sxaEgdbWf5gT69yMAALJ6ET0p1gpa4AFhi
         5OJdn2J3Upp7g9rvQgB9OZ4Ze5w1mb+li/6aV4Uh0/jHDsbmut9Q+uhFuqAI2hVIdSkC
         2pRg2SijOTQ3/Lc9XePftzd46jzu6skQXaR2tr9Bp5a/GyqOLoNpOPop5bsns1fiiqTx
         Dt0A==
X-Gm-Message-State: APjAAAVCKCzJH3cB8c6z10qQC7FboZJzUgatRKU/6YwHM77jgK4zYkgl
        pLmAPyjnGxdfcwtOqhaya9BXHg==
X-Google-Smtp-Source: APXvYqxPqbKcXuZXeBirlhTjoQMKgjvHy1iW9+l9NjMaBzSnwIpy6e9a6vUUAEoz3F3tPyCgcvAi4g==
X-Received: by 2002:a17:90a:1696:: with SMTP id o22mr12479837pja.78.1576798886222;
        Thu, 19 Dec 2019 15:41:26 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id l15sm7979746pjl.24.2019.12.19.15.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 15:41:25 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] netfilter: nf_flow_table: big endian fix for TCP flags
Date:   Thu, 19 Dec 2019 15:40:47 -0800
Message-Id: <20191219234047.97315-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCP_FLAG_* are 32-bit big endian constants, not 16-bit. So on big endian
machines, you need to shift them down to fit the 16-bit tcp.mask here.

This surfaced through ARM allmodconfig, which is big endian:

net/netfilter/nf_flow_table_offload.c: In function 'nf_flow_rule_match':
net/netfilter/nf_flow_table_offload.c:91:21: warning: unsigned conversion from 'int' to '__be16' {aka 'short unsigned int'} changes value from '327680' to '0' [-Woverflow]

Need to convert to/from host word order to keep LE/BE behaving the same.

Fixes: c29f74e0df7a ("netfilter: nf_flow_table: hardware offload support")
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 net/netfilter/nf_flow_table_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index de7a0d1e15c88..e32ff796378c6 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -88,7 +88,7 @@ static int nf_flow_rule_match(struct nf_flow_match *match,
 	switch (tuple->l4proto) {
 	case IPPROTO_TCP:
 		key->tcp.flags = 0;
-		mask->tcp.flags = TCP_FLAG_RST | TCP_FLAG_FIN;
+		mask->tcp.flags = htons(ntohl(TCP_FLAG_RST | TCP_FLAG_FIN) >> 16);
 		match->dissector.used_keys |= BIT(FLOW_DISSECTOR_KEY_TCP);
 		break;
 	case IPPROTO_UDP:
-- 
2.11.0

