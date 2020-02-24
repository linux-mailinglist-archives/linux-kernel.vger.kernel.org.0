Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3A116AFC0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 19:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBXSzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 13:55:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56905 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726664AbgBXSzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582570550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qmy+/DcMDdUSTfHqKJLRQ4XAfLyXoIHclUXkSdOie50=;
        b=NCmLeD/RVoK2OcOb9iYPnBQwTMald18Bhh2Xol6+zK6D4nyuDDZf4MRYpD5+pUc4R/A1eN
        gJqi2YzIQdtpD/lQ+q34yhssi/HeC8Hy0ZqZFf3s4FkejuMiWb7K1iC/fXSHVk3G03Fu8E
        iORl2RIXgYgd31I9m6eMivmQqvyw0Cg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-7ETrrvy6P_W0JtIXWTFDjg-1; Mon, 24 Feb 2020 13:55:48 -0500
X-MC-Unique: 7ETrrvy6P_W0JtIXWTFDjg-1
Received: by mail-wr1-f70.google.com with SMTP id p8so6024074wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 10:55:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qmy+/DcMDdUSTfHqKJLRQ4XAfLyXoIHclUXkSdOie50=;
        b=MlyVP28ni/poeAZaE5Fjn47vOxgIekNPtQTmX95iw3fh8AhrhTERI+fR3N9vAOhuqw
         PNm4ZKNeG9gPjRwPN+HW/WDrArV3U3+s4RqOjVMBsWCCuj45bJWNcTRCG7wYyf0yNmf6
         23bDH/X9bBqnhAEpOMWP4gn+N+NjGgDOAV5UyLZ7muZ67YBhlVfT23sVRv6PowCcbhkR
         Bmyh/dRGidksRv8OqfkQQUrt6sNQsNt9FQoDuTpySPPKY1zf07587TnZRNEVwH2C8rMr
         lm9qo7cZIVsVz2gqSWiXwMK2BEpKgMHfx3DL5/I65KmAHSiXdz8jsN0obUH6bOaPRVgh
         v6xw==
X-Gm-Message-State: APjAAAVungzGErIZhFpCOTU7RjH71VfGhysHAVebme+ao3RE6VBpK/AG
        Dlf/atPkz2TlDmXrv8+WYYixSY1lZfJygJ20ye1G9qFRFTSKHetK8IFgpfRRXuROtNmyzgzvCth
        a2nU6vLW7TlBFo5SxQS4svlDz
X-Received: by 2002:a1c:f712:: with SMTP id v18mr231890wmh.155.1582570547365;
        Mon, 24 Feb 2020 10:55:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzLfrB7CCT2bx+Wtk4qiWRW9LrVB55nuO7bRVFcYHNgHZmNeHEgXbVGS3DRcBeETJNyhQeCjg==
X-Received: by 2002:a1c:f712:: with SMTP id v18mr231880wmh.155.1582570547171;
        Mon, 24 Feb 2020 10:55:47 -0800 (PST)
Received: from raver.teknoraver.net (net-47-53-225-50.cust.vodafonedsl.it. [47.53.225.50])
        by smtp.gmail.com with ESMTPSA id c15sm19949531wrt.1.2020.02.24.10.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:55:46 -0800 (PST)
From:   Matteo Croce <mcroce@redhat.com>
To:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stephen Suryaputra <ssuryaextr@gmail.com>
Subject: [PATCH nf] netfilter: ensure rcu_read_lock() in ipv4_find_option()
Date:   Mon, 24 Feb 2020 19:55:29 +0100
Message-Id: <20200224185529.50530-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As in commit c543cb4a5f07 ("ipv4: ensure rcu_read_lock() in ipv4_link_failure()")
and commit 3e72dfdf8227 ("ipv4: ensure rcu_read_lock() in cipso_v4_error()"),
__ip_options_compile() must be called under rcu protection.

Fixes: dbb5281a1f84 ("netfilter: nf_tables: add support for matching IPv4 options")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 net/netfilter/nft_exthdr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index a5e8469859e3..752264b3043a 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -77,6 +77,7 @@ static int ipv4_find_option(struct net *net, struct sk_buff *skb,
 	bool found = false;
 	__be32 info;
 	int optlen;
+	int ret;
 
 	iph = skb_header_pointer(skb, 0, sizeof(_iph), &_iph);
 	if (!iph)
@@ -95,7 +96,11 @@ static int ipv4_find_option(struct net *net, struct sk_buff *skb,
 		return -EBADMSG;
 	opt->optlen = optlen;
 
-	if (__ip_options_compile(net, opt, NULL, &info))
+	rcu_read_lock();
+	ret = __ip_options_compile(net, opt, NULL, &info);
+	rcu_read_unlock();
+
+	if (ret)
 		return -EBADMSG;
 
 	switch (target) {
-- 
2.24.1

