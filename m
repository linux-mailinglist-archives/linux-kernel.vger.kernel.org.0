Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDEE178E27
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 11:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387940AbgCDKOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 05:14:01 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38693 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387878AbgCDKN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:13:59 -0500
Received: by mail-lf1-f65.google.com with SMTP id x22so1020011lff.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3OAcsZlcP+NciTRj+t3SsmpQSQQtm0Lkv+kkDVIb/c=;
        b=QBGvANBcTboDyQvlqk5xAbmS2KzrtV6BTiwK71q4XUpWXwE1bfWarPhPDBTiqfwPcn
         C9sCR2yMGyrkd2NvpVjfdc6grf1XZL3euVQn8TofoAox9wmx7C1Iw/1WL+3kW11B18o1
         0xMsbz5bjS77Ohvgxar7hze/56KWA0lR1mwDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3OAcsZlcP+NciTRj+t3SsmpQSQQtm0Lkv+kkDVIb/c=;
        b=nDEHqvqnlr6OUAfHtcvvXSA9KaFtF0Wxdx7ET24fglpmDQsBkWmahU3uAUMEVB+gk+
         QkzcYtqvpRI2sH0oXQgCbFt7FSh4+Zdmb8ICdbsC7COoSHWDbOE/NGOiGTfVNl7F8ecJ
         zAXj6GVNIhlTMBj2Jnp3X8Zaw/qUf1Dtw9REr1CUn8e/TJ49rSRk7rDXTjn+Gyhekpm2
         XitZH0Wqh1xIPM/X/oTod5wEfbzEpJBX2g3DpEBTkCcxmFNwHsrJBPlpxu3PARUPhCkz
         mZq67HI3rWvwX2j5/lD1l+RQbtEeIf9CXJOXxyzDpmIL38YGGsssdCLbkVyBU1u6hXXm
         2ojw==
X-Gm-Message-State: ANhLgQ3nPlCtXsRtsp/ShKJprej8IXYZyOTNvX/Nv3AHygmmI3uWXBAR
        q+0NECNz8ewV1oajyEeg937FWA==
X-Google-Smtp-Source: ADFU+vuGcQpyUDCTfLOhZF/mUlERtCIb0YfcfvThHGkxb86ViN2qqBvRvEpxDLUcWd7emrwxoWmvIA==
X-Received: by 2002:ac2:532f:: with SMTP id f15mr1550329lfh.3.1583316836695;
        Wed, 04 Mar 2020 02:13:56 -0800 (PST)
Received: from localhost.localdomain ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id l7sm341777lfk.65.2020.03.04.02.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:13:55 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     john.fastabend@gmail.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 12/12] bpf, doc: update maintainers for L7 BPF
Date:   Wed,  4 Mar 2020 11:13:17 +0100
Message-Id: <20200304101318.5225-13-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304101318.5225-1-lmb@cloudflare.com>
References: <20200304101318.5225-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Jakub and myself as maintainers for sockmap related code.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2fae56dca9f..0b570b3b46d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9352,6 +9352,8 @@ F:	include/net/l3mdev.h
 L7 BPF FRAMEWORK
 M:	John Fastabend <john.fastabend@gmail.com>
 M:	Daniel Borkmann <daniel@iogearbox.net>
+M:	Jakub Sitnicki <jakub@cloudflare.com>
+M:	Lorenz Bauer <lmb@cloudflare.com>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained
-- 
2.20.1

