Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9AA165784
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 07:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgBTGXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 01:23:12 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40651 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgBTGXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:23:09 -0500
Received: by mail-pj1-f65.google.com with SMTP id 12so427455pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pwqRC5ctrH1VdFS0fVMzPmvmSqkqB6gbtE10lNJENwg=;
        b=lkhUfWRBv1xyrfKXpHNpejXY5tjKati7oNSoxKJHDX6rEjBakEh/pvJ6R5b0vKWa+8
         fFuI8to+e/O2K/EkjZncq5qHsxh23YMJ/zGsLCISXUDcwHodtMjokQjvVof8FpTN2Cfe
         ep5kI5K973MmaHtbRS/OMeRU1o3JsZKE/zgdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pwqRC5ctrH1VdFS0fVMzPmvmSqkqB6gbtE10lNJENwg=;
        b=g4EjQY2/QgmkFRXQoe/FddSVJibcXwamK89Vlvr6s2Kj2pWZdkGSljTHCC3//T3d6M
         qQimvI4JHU6DVThO0tXNZYMg++GwZJUvnM5WVvXQbjnX8CMaDFTNs9zpFy2aTDsb7nJ3
         Kf/ortEKMeovSzfSxQ2WrvRNBt/Kbs17SFrcMvAW41duksBXOtQ4CG69HCKyx4eC/wmY
         5ryTG7WRpD57AsUendZdz1NRlKjJfdH/mjcR1iI+Kw5cPSqFJL+La4TAzOp4P6GR+ClD
         pkruIbLcVgOTv9kmIGh0ORvbEXBT0cjtiaJ9yZuePSOiHPGoa2xns0tQWBkqkeZX5RLX
         L/qw==
X-Gm-Message-State: APjAAAUr9TxJvP3++RsJtfR7L4MOqzg5yBWWFnOX72fvlCQz0A2jSBnz
        BNp9Tg/mcQoxBB5Csb1qN7s0IFslNqI=
X-Google-Smtp-Source: APXvYqxc7SwRv9hJB9uXL69HhsVrSo4krcpz/lGSTLscsB/VcFhXiDBgLa0uNSXkKjSieR7n61U/VA==
X-Received: by 2002:a17:90a:f0c1:: with SMTP id fa1mr1784818pjb.129.1582179788586;
        Wed, 19 Feb 2020 22:23:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g9sm1814442pfm.150.2020.02.19.22.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 22:23:07 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: core: Distribute switch variables for initialization
Date:   Wed, 19 Feb 2020 22:23:04 -0800
Message-Id: <20200220062304.68942-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables declared in a switch statement before any case statements
cannot be automatically initialized with compiler instrumentation (as
they are not part of any execution flow). With GCC's proposed automatic
stack variable initialization feature, this triggers a warning (and they
don't get initialized). Clang's automatic stack variable initialization
(via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
doesn't initialize such variables[1]. Note that these warnings (or silent
skipping) happen before the dead-store elimination optimization phase,
so even when the automatic initializations are later elided in favor of
direct initializations, the warnings remain.

To avoid these problems, move such variables into the "case" where
they're used or lift them up into the main function body.

net/core/skbuff.c: In function ‘skb_checksum_setup_ip’:
net/core/skbuff.c:4809:7: warning: statement will never be executed [-Wswitch-unreachable]
 4809 |   int err;
      |       ^~~

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/core/skbuff.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 864cb9e9622f..03d5bb1d469e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4805,9 +4805,9 @@ static __sum16 *skb_checksum_setup_ip(struct sk_buff *skb,
 				      typeof(IPPROTO_IP) proto,
 				      unsigned int off)
 {
-	switch (proto) {
-		int err;
+	int err;
 
+	switch (proto) {
 	case IPPROTO_TCP:
 		err = skb_maybe_pull_tail(skb, off + sizeof(struct tcphdr),
 					  off + MAX_TCP_HDR_LEN);

