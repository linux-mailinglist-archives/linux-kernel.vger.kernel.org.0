Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9144C11D9D4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 00:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbfLLXQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 18:16:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43422 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731337AbfLLXQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 18:16:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id p27so273925pli.10;
        Thu, 12 Dec 2019 15:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6RmPSySB6yaq33KtHs8XUNhrbCfHLQh1/I6bnoO7bOU=;
        b=bKH9jNlxo+A2rwduZywwg1nKEr08Ppi/z84u9kTTiy/LU/3n7XeUEmRWWF3XFOuExZ
         D1Y99V2zbwDgmJN06eBZcmpdm+ytzlZlbhWa2Z77UW8yChFuuc3dhaS0oK8KNUrIrXAO
         S/O4LVHu/glTYi3b+HhiU089OEeV7M+WZU2N2Xo/9x/llfsErnkx49I5oCwuS71MWLL2
         WGP5adS0EUc5+N5RcpLO9tr7vnhs5DKa5EG1fM34Vdc80t8Gu+vtmWn0/C+8S8U1OjSv
         FN/J8dGBvcE+VhSYnQholdvV6D/MkzdWflJ/wjbgGE5sV9CEN/v5mqS/x3SIWeSb+I63
         GP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6RmPSySB6yaq33KtHs8XUNhrbCfHLQh1/I6bnoO7bOU=;
        b=f/p7RE0bdWuCkJ2Ty8iFQkmCEIVEb7NXD61L3ht8yZn0gZl2jo0frJj7HRmLk6J4p2
         PDwd/OQWSaViD7G72qmCzRhlr2v0O5mLjObwoNby7UpbKS49j9+B5VimJrDWFKo0K4KY
         NIsGbPo8tjVHV05OzIJohLLuNdh0mcacxyUBqc5FzHSrWRlp5uWSo/cn2n97eup3OlBJ
         NFNNmAnoAmB3giqbZh7lMaoJ7vnEwdCJ3OTi3TjxTrD3CDcOQGqtnMe1LVh0qPIPeSCJ
         niQ49HCxHubN1B2o2YR8wDYtkQHNBcm7An6FfdaK4JpZSjigji+pQxhyUsTAv27skx1Y
         +COw==
X-Gm-Message-State: APjAAAWjDtevlLT8mny6QRZQkHTJt1iplHN2vgRjTR+b4UwY0jtkr/5w
        fFz1KOlz1LPr4Mu+8UgMS4U=
X-Google-Smtp-Source: APXvYqzMJkjYW1LUjKBbYMB1MnB4ShrNNsXMvWSY/vdGaL1YzXcdKJXiZJDWzU6pYvq9i5fxGyp73g==
X-Received: by 2002:a17:90a:d807:: with SMTP id a7mr13304783pjv.15.1576192611097;
        Thu, 12 Dec 2019 15:16:51 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::1072])
        by smtp.gmail.com with ESMTPSA id ev11sm9423307pjb.1.2019.12.12.15.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 15:16:50 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 2/2] ARM: dts: aspeed: delete no-hw-checksum from yamp dts
Date:   Thu, 12 Dec 2019 15:16:22 -0800
Message-Id: <20191212231622.302-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212231622.302-1-rentao.bupt@gmail.com>
References: <20191212231622.302-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Delete "no-hw-checksum" property from yamp dts file because ftgmac100's
checksum issue has been fixed by commit 88824e3bf29a ("net: ethernet:
ftgmac100: Fix DMA coherency issue with SW checksum").

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
index 52933598aac6..fe2e11c2da15 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
@@ -35,7 +35,6 @@
 &mac0 {
 	status = "okay";
 	use-ncsi;
-	no-hw-checksum;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii1_default>;
 	clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
-- 
2.17.1

