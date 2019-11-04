Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF44EEAE8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 22:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfKDVQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 16:16:49 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:34850 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbfKDVQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:16:49 -0500
Received: from localhost.localdomain (80-110-127-196.cgn.dynamic.surfer.at [80.110.127.196])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 9C6DEC79C0;
        Mon,  4 Nov 2019 21:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1572901798; bh=Gn3ce9J2FbN+mHmg7FuUk7jLgCYVhBF6tStil3ABUOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fyZNsjykKx0mq2GuxxRWiho0uqUXE5JkmpP7C5iBUESAlhZZLPjeYXGA1DVdh98Hx
         IaHc+BX2QFCBJVLid4pgwNYMxTMJLD7FtGxPAHgJrUUzgiKalryJiZRO7eW/eBBzdA
         hjB5cI8BMm5EfP7FCwhx/XwWM/977e0YBoxrE1JA=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     Luca Weiss <luca@z3ntu.xyz>, Russell King <linux@armlinux.org.uk>,
        Brian Masney <masneyb@onstation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: qcom_defconfig: Enable QRTR
Date:   Mon,  4 Nov 2019 22:09:41 +0100
Message-Id: <20191104210943.101393-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104210943.101393-1-luca@z3ntu.xyz>
References: <20191104210943.101393-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option is useful on msm8974, so enable it.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 94d5e1a8c61a..a71201fdc8c9 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -45,6 +45,8 @@ CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 # CONFIG_IPV6 is not set
+CONFIG_QRTR=y
+CONFIG_QRTR_SMD=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_RFKILL=y
-- 
2.23.0

