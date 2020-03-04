Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E41179C81
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 00:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbgCDXjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 18:39:45 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:35633 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388513AbgCDXjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 18:39:44 -0500
Received: by mail-pj1-f73.google.com with SMTP id ep22so1941153pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 15:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=a2ls/0+XhOrLTmzZ82TksSq7Jty/zbg+jikoqthrwds=;
        b=Wh+3HRWnRFld+I3x/Iifo4+Qouth/uqsuqouyd2n/JVRzs9fT4wd7TvoPNIYriz/Kp
         q/ZzDURRIGkj4pUguk91KE/6rt+WdnjL0J5r6Qz0wKMf4mZmTjGIBYrLk+a9icvBsfWy
         PzVErlzx+MQRl34XA1leAHz1Ui4XPsgnEjvPb6bFxpbQ8c0zsORYd/0t1HdfNr7eUipJ
         UYaLKuTFBQU3V4w48Zs6JfULm4w7tz/MYUXXUZGzPjsKpKo2/vhRg0oXzHVj9LREpp7Q
         eaLrpnMd04umIx9Pfv/QovyVUcvq4z5TO9ANWCic7ekQ/kF+iashcbQirvtdtNHDBSkw
         gmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=a2ls/0+XhOrLTmzZ82TksSq7Jty/zbg+jikoqthrwds=;
        b=MHGu8OgWh8yl6AU5+t1ZzCpAN2OLH8dWYgKXSUIXISUHWesObGUPaBJkd2TpFEP8It
         gsl99fKn5WiRPQW+GclHyCSyRCpdCYCAAX6m0pivNfvgyArheAh4OFGpsrPrSOVQDNEg
         Tzx6Hs9ayKGuQUyznpTrKoTcX1ci2cpZWkpoOwEx+r8rGKhiMlOSuckSR+/OriSwqaYb
         jXWgxHg571cmNJ1UTUD1pQgHi91DvqQTEAhNae46DRF+ArWX9B2jT6qFpPzMErYf8gN0
         c9I9bCvJu1ecugspD9mkTkMLt4C+LZ9oxdcDKsYEHxPjN/McAd1LHzRHplw8a/68zlNl
         G8XA==
X-Gm-Message-State: ANhLgQ1lVkv3eaFOIk6Ru2ulclkJkYMgbafplDzf9PLjlPrDjh9I5xsL
        Vv7t9KayFsgqgD0WnAcx/+J0IwQe8NGfPA==
X-Google-Smtp-Source: ADFU+vsMk53h0+vE5U7wBkmRmT2KSMldVQZ0OPGijtXBgWljM7h4j+abzTpnMdLnMtsyvZtdLF1qFkjtxpGxZA==
X-Received: by 2002:a63:7783:: with SMTP id s125mr4643014pgc.214.1583365183575;
 Wed, 04 Mar 2020 15:39:43 -0800 (PST)
Date:   Wed,  4 Mar 2020 15:38:56 -0800
Message-Id: <20200304233856.257891-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2] net: memcg: late association of sock to memcg
From:   Shakeel Butt <shakeelb@google.com>
To:     Eric Dumazet <edumazet@google.com>, Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a TCP socket is allocated in IRQ context or cloned from unassociated
(i.e. not associated to a memcg) in IRQ context then it will remain
unassociated for its whole life. Almost half of the TCPs created on the
system are created in IRQ context, so, memory used by such sockets will
not be accounted by the memcg.

This issue is more widespread in cgroup v1 where network memory
accounting is opt-in but it can happen in cgroup v2 if the source socket
for the cloning was created in root memcg.

To fix the issue, just do the late association of the unassociated
sockets at accept() time in the process context and then force charge
the memory buffer already reserved by the socket.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changes since v1:
- added sk->sk_rmem_alloc to initial charging.
- added synchronization to get memory usage and set sk_memcg race-free.

 net/ipv4/inet_connection_sock.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index a4db79b1b643..7bcd657cd45e 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -482,6 +482,25 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
 		}
 		spin_unlock_bh(&queue->fastopenq.lock);
 	}
+
+	if (mem_cgroup_sockets_enabled && !newsk->sk_memcg) {
+		int amt;
+
+		/* atomically get the memory usage and set sk->sk_memcg. */
+		lock_sock(newsk);
+
+		/* The sk has not been accepted yet, no need to look at
+		 * sk->sk_wmem_queued.
+		 */
+		amt = sk_mem_pages(newsk->sk_forward_alloc +
+				   atomic_read(&sk->sk_rmem_alloc));
+		mem_cgroup_sk_alloc(newsk);
+
+		release_sock(newsk);
+
+		if (newsk->sk_memcg)
+			mem_cgroup_charge_skmem(newsk->sk_memcg, amt);
+	}
 out:
 	release_sock(sk);
 	if (req)
-- 
2.25.0.265.gbab2e86ba0-goog

