Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC06178E31
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 11:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbgCDKOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 05:14:14 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33751 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387850AbgCDKNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:13:53 -0500
Received: by mail-lf1-f67.google.com with SMTP id c20so1037898lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Movn+41WzemIACV44Fj+5GKGifBnp1jThwTXCnphEII=;
        b=TddC90GRsrDTwSE8vyf7+jsQhS3OBT3oNLdpUk85sRr9mKFEFN7fhgP8a8w8iJ7WrQ
         p8qx8T10ne1R9vl9EUskFrdk8t8FieWCnI3VJh9Ea9KwTLbXHPgeEBaaX72MNf1ASuLR
         U22psr85+3QqLwLj7W6MZQgBaHNky/Wz9Oklk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Movn+41WzemIACV44Fj+5GKGifBnp1jThwTXCnphEII=;
        b=isEgNMD7GiUGOiefGv004l1f8ttEMX7iUPVpn9lABYMPgB/34o0eBRbV/WooLk/mhI
         H+8H4JMLxRsA3MeSYsDPgbaHTH80Iw6eJ5WICpu0uteMTiR0OTS53THsyV6C/2yTj9vz
         bLeUsIsjcBvxdMvsTy9YwQ3Z2bFWB/dHWFgsxGEx6QzzBSqXuNo+rw43/0KjF4irIakq
         v0ABs7sTPaqtwmoi2dsT+qTpsLxHiZKFoHeDd8VXFUEcbYaunaStvtuY0t+H+lOCv/Ds
         s3YKlWaJTCkYji53RuCqFbz7Kx99WlrPWt9FeLYwXFC96Qy+Gr3sckzMboCnXygHHqec
         yRzA==
X-Gm-Message-State: ANhLgQ1XPPIl8zwNQHCA1/DDz4Y/ok0kf8S2hbtQKCvsW6L6ahUu5JWZ
        ArwTbQjwZGHGOjO0vEA84ylIZw==
X-Google-Smtp-Source: ADFU+vsvVlRIf6CFlh+LzZRNmFJ1lIq+SfyC3CWjWypXJsqv11dvTSDvmc/RZ7grTaxoWXLbkA4R5Q==
X-Received: by 2002:ac2:4948:: with SMTP id o8mr1584139lfi.201.1583316830033;
        Wed, 04 Mar 2020 02:13:50 -0800 (PST)
Received: from localhost.localdomain ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id l7sm341777lfk.65.2020.03.04.02.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:13:49 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     john.fastabend@gmail.com, Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 08/12] bpf: sockmap: add UDP support
Date:   Wed,  4 Mar 2020 11:13:13 +0100
Message-Id: <20200304101318.5225-9-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304101318.5225-1-lmb@cloudflare.com>
References: <20200304101318.5225-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow adding hashed UDP sockets to sockmaps.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 83c5082cefd3..1485a8fd571c 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/jhash.h>
 #include <linux/sock_diag.h>
+#include <net/udp.h>
 
 struct bpf_stab {
 	struct bpf_map map;
@@ -147,7 +148,19 @@ static int sock_map_init_proto(struct sock *sk, struct sk_psock *psock)
 
 	sock_owned_by_me(sk);
 
-	prot = tcp_bpf_get_proto(sk, psock);
+	switch (sk->sk_type) {
+	case SOCK_STREAM:
+		prot = tcp_bpf_get_proto(sk, psock);
+		break;
+
+	case SOCK_DGRAM:
+		prot = udp_bpf_get_proto(sk, psock);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
 	if (IS_ERR(prot))
 		return PTR_ERR(prot);
 
@@ -162,7 +175,7 @@ static struct sk_psock *sock_map_psock_get_checked(struct sock *sk)
 	rcu_read_lock();
 	psock = sk_psock(sk);
 	if (psock) {
-		if (sk->sk_prot->recvmsg != tcp_bpf_recvmsg) {
+		if (sk->sk_prot->close != sock_map_close) {
 			psock = ERR_PTR(-EBUSY);
 			goto out;
 		}
@@ -474,15 +487,31 @@ static bool sock_map_op_okay(const struct bpf_sock_ops_kern *ops)
 	       ops->op == BPF_SOCK_OPS_TCP_LISTEN_CB;
 }
 
-static bool sock_map_sk_is_suitable(const struct sock *sk)
+static bool sk_is_tcp(const struct sock *sk)
 {
 	return sk->sk_type == SOCK_STREAM &&
 	       sk->sk_protocol == IPPROTO_TCP;
 }
 
+static bool sk_is_udp(const struct sock *sk)
+{
+	return sk->sk_type == SOCK_DGRAM &&
+	       sk->sk_protocol == IPPROTO_UDP;
+}
+
+static bool sock_map_sk_is_suitable(const struct sock *sk)
+{
+	return sk_is_tcp(sk) || sk_is_udp(sk);
+}
+
 static bool sock_map_sk_state_allowed(const struct sock *sk)
 {
-	return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
+	if (sk_is_tcp(sk))
+		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
+	else if (sk_is_udp(sk))
+		return sk_hashed(sk);
+
+	return false;
 }
 
 static int sock_map_update_elem(struct bpf_map *map, void *key,
-- 
2.20.1

