Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 405BBE09BD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 18:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbfJVQw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 12:52:26 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34969 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbfJVQw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:52:26 -0400
Received: by mail-oi1-f194.google.com with SMTP id x3so14816695oig.2;
        Tue, 22 Oct 2019 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vxt2BZlQ+53rWMwmVviD+TwDtnO3WTo/KugRQtRT0Hk=;
        b=hp8pOtAjAB1FU2Ve7em50M7AMTnbgeZogItfSSnQgZluLX+t786AlYjCy12P6wad0W
         b/Ngt8oyL1mSgvqzAdXaWhY6sBwMCzsi3O+rkDJUoBsvu+iZ53HwhtW+WZBlRxR1by4+
         k97hSaDRPIlK+yv9BYltD4IXMipDICnw2+IKK1fHbdXrfTWTJIo+HwBW7CeqVloQEXPZ
         ABOeYi5v7RpPmIT94FR3v3M3iG+yVoBehtcQu2UuaunJtIjgfJdN6dQ42ejD573sBZay
         qMMgk6aNO9wFEncAB67R1vtk/U3gVmIx3Bsve9Kcs6b6N2gwG6UmyJvPkLe4q59bdazA
         EQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vxt2BZlQ+53rWMwmVviD+TwDtnO3WTo/KugRQtRT0Hk=;
        b=njov1SHV9J97Kg7x1pZsGKD7obddB9/A0Ko+T1i3UBsLB5ZPXax/A+iQa+B///c4yU
         yby0JWUO+/EwR0LPD/zWiTwxsVAN5Dsj+1goQ9FngsJanXVz8AswFziZklq8O33T2veU
         iZ624RNxB+/FIPzd8YxzDc/S+gGmMNE9qP/I6GHm1aXI/T20/Yxxhv4Dub7ab5OepglJ
         m+Woe9umD8P4vxEY01sKAfouN2LTGXHWWBl5v9xQA/Lg6eXTa1zHwi/ey2Cd6Ozhkfbv
         Ig99i/vP8JIekMQmc7tbQVEbJptyWbStXeQlr4nU9XdQ5xSFfJLoH5J+OOILonG81OVo
         kggw==
X-Gm-Message-State: APjAAAXwtfRQwCy8amMxUpwD9Vh+OM/i9JJ36aEugH7YxTAtHqxwcweh
        1oml04Ik0pQH6GaDuPGNLBA=
X-Google-Smtp-Source: APXvYqz/bBY7HDB1zRkrDNQyzP753kDbijKRJnKXe7SQX/AeICng2K8PMN6kR1y/bEt1IyvKmqKyVg==
X-Received: by 2002:aca:f005:: with SMTP id o5mr3744584oih.36.1571763144136;
        Tue, 22 Oct 2019 09:52:24 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id z24sm613884oib.21.2019.10.22.09.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 09:52:23 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] clk: sunxi: Fix operator precedence in sunxi_divs_clk_setup
Date:   Tue, 22 Oct 2019 09:50:54 -0700
Message-Id: <20191022165054.48302-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

r375326 in Clang exposes an issue with operator precedence in
sunxi_div_clk_setup:

drivers/clk/sunxi/clk-sunxi.c:1083:30: warning: operator '?:' has lower
precedence than '|'; '|' will be evaluated first
[-Wbitwise-conditional-parentheses]
                                                 data->div[i].critical ?
                                                 ~~~~~~~~~~~~~~~~~~~~~ ^
drivers/clk/sunxi/clk-sunxi.c:1083:30: note: place parentheses around
the '|' expression to silence this warning
                                                 data->div[i].critical ?
                                                                       ^
                                                                      )
drivers/clk/sunxi/clk-sunxi.c:1083:30: note: place parentheses around
the '?:' expression to evaluate it first
                                                 data->div[i].critical ?
                                                                       ^
                                                 (
1 warning generated.

It appears that the intention was for ?: to be evaluated first so that
CLK_IS_CRITICAL could be added to clkflags if the critical boolean was
set; right now, | is being evaluated first. Add parentheses around the
?: block to have it be evaluated first.

Fixes: 9919d44ff297 ("clk: sunxi: Use CLK_IS_CRITICAL flag for critical clks")
Link: https://github.com/ClangBuiltLinux/linux/issues/745
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index d3a43381a792..27201fd26e44 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1080,8 +1080,8 @@ static struct clk ** __init sunxi_divs_clk_setup(struct device_node *node,
 						 rate_hw, rate_ops,
 						 gate_hw, &clk_gate_ops,
 						 clkflags |
-						 data->div[i].critical ?
-							CLK_IS_CRITICAL : 0);
+						 (data->div[i].critical ?
+							CLK_IS_CRITICAL : 0));
 
 		WARN_ON(IS_ERR(clk_data->clks[i]));
 	}
-- 
2.23.0

