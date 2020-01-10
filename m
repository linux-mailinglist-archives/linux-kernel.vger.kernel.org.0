Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6422E136DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 14:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgAJNZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 08:25:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50511 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbgAJNZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:25:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so2009665wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 05:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pPkkayMqoY404hwMIWti3s+tl9smeoH8DKQs1LSa8V4=;
        b=Vh0GCGNeW4bRhhYlzpky0Y1SiaDf4HTWvITnqtsIimZNbZd61XZNuTT7JdXyszOYFY
         nlJMifjThgw+w7+kHxFAGI9rsKGHFZiapxKPIT9UgVfmIY7Z1W4SfmRcJ0f949TUTHjY
         kJ7J6GTkKlxSiM3vvdzlv8EjThPKbQMKMYMzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pPkkayMqoY404hwMIWti3s+tl9smeoH8DKQs1LSa8V4=;
        b=bFNp9pSC0i1xhKXRaQUg26pTCC6zQoEMC0xLNpYOACRs8FZHIyoVqOFygx5tzwTFG4
         qabSp2vhpSYKyQx9gb0AGjV8oFOkDw2CR1N7vB9rD1CjG00vG0mcuCidZqm/M4+OJUpq
         jSlRIFsokpa83TpUes41PNKa0K6XbyDHh6MNsqz0GZmU5UbQ2iqyXRgc8RzWWTGCQvER
         Z/c9Xz0YsufZMKG6Tiz/0wWo1Fk+33TMljB0RpeXbaYNWSnrOH3K2rDOkGBgV1ghuEJG
         eo0gPjP3o+YYctScjgn6uIZdiY+OI1HBM1R5UwTOLmtBGfW5OBnWyXrqeGqAfeTGdFQA
         iBYA==
X-Gm-Message-State: APjAAAX+4BOdobtuWbpd3POQeRpPShkX2g6EoGUWHlZI1QrB4sHciXED
        0IWiby9Ww5cCbz+0bTJKr5XA5g==
X-Google-Smtp-Source: APXvYqx8F4gmAh17IOiAHcyqfmcB4I8c278zpNEdGxnNwMArdEe2yyt01GfDbRva8CjnkY0S1x2NkA==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr4290073wml.83.1578662749896;
        Fri, 10 Jan 2020 05:25:49 -0800 (PST)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:51ce:3bcb:24c3:4be9])
        by smtp.gmail.com with ESMTPSA id m10sm2204033wrx.19.2020.01.10.05.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 05:25:49 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     kafai@fb.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Joe Stringer <joe@isovalent.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@cloudflare.com
Subject: [PATCH bpf v2] net: bpf: don't leak time wait and request sockets
Date:   Fri, 10 Jan 2020 13:23:36 +0000
Message-Id: <20200110132336.26099-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109115749.12283-1-lmb@cloudflare.com>
References: <20200109115749.12283-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible to leak time wait and request sockets via the following
BPF pseudo code:
 
  sk = bpf_skc_lookup_tcp(...)
  if (sk)
    bpf_sk_release(sk)

If sk->sk_state is TCP_NEW_SYN_RECV or TCP_TIME_WAIT the refcount taken
by bpf_skc_lookup_tcp is not undone by bpf_sk_release. This is because
sk_flags is re-used for other data in both kinds of sockets. The check

  !sock_flag(sk, SOCK_RCU_FREE)

therefore returns a bogus result. Check that sk_flags is valid by calling
sk_fullsock. Skip checking SOCK_RCU_FREE if we already know that sk is
not a full socket.

Fixes: edbf8c01de5a ("bpf: add skc_lookup_tcp helper")
Fixes: f7355a6c0497 ("bpf: Check sk_fullsock() before returning from bpf_sk_lookup()")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 net/core/filter.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 42fd17c48c5f..41820ba0774c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5277,8 +5277,7 @@ __bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 	if (sk) {
 		sk = sk_to_full_sk(sk);
 		if (!sk_fullsock(sk)) {
-			if (!sock_flag(sk, SOCK_RCU_FREE))
-				sock_gen_put(sk);
+			sock_gen_put(sk);
 			return NULL;
 		}
 	}
@@ -5315,8 +5314,7 @@ bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 	if (sk) {
 		sk = sk_to_full_sk(sk);
 		if (!sk_fullsock(sk)) {
-			if (!sock_flag(sk, SOCK_RCU_FREE))
-				sock_gen_put(sk);
+			sock_gen_put(sk);
 			return NULL;
 		}
 	}
@@ -5383,7 +5381,8 @@ static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
 
 BPF_CALL_1(bpf_sk_release, struct sock *, sk)
 {
-	if (!sock_flag(sk, SOCK_RCU_FREE))
+	/* Only full sockets have sk->sk_flags. */
+	if (!sk_fullsock(sk) || !sock_flag(sk, SOCK_RCU_FREE))
 		sock_gen_put(sk);
 	return 0;
 }
-- 
2.20.1

