Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5558E23E7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 22:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436524AbfJWUFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 16:05:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35439 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407364AbfJWUFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:05:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id l10so23031008wrb.2;
        Wed, 23 Oct 2019 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zV4+mJumjqZCVRf0c568eaULYg2KEJ/Mri+qUnmNENE=;
        b=kQFPfs47RtHcsf80dqIXL3rjiCublAPTudUJbBeVLZzSOsQ3Ijc26qGeeIrZ/gZfo/
         NVbwem0g5W+Qlgv+k6SRSejmUM9yw6SaR7unSaLpGwJbH9i7dBo/44auEuxZAT0ce7cD
         ZamjiqYAeDyMcp6jBvdMc1RLrBG+NHkWVoT6D5i040JWVniDaWJqIziRlir+NImuPa6t
         oBQQMEs8Ioi4DMR63LaY/RKWNw0/XJJkuq0YXDLn/IDH4a5rn5ZesW9rRm5e/xFnKEui
         eshGUrunzu0kIZpzAd4JT94VN4zbUBAFckmCIGoUIin7eHpOgT3fO3aghdzsqjYejVO0
         5/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zV4+mJumjqZCVRf0c568eaULYg2KEJ/Mri+qUnmNENE=;
        b=IwbKbHrecusQS+304laps6dhGpBCCP2i1kTlR21/PBzERK/X7sV1KffYefklZOj4b5
         NKP5e84bTzpDDw3WRRwAOCMnN6Wf+2TQVWlpEhai7J4XlGygmkwYtF/1wRfPLBozjoDh
         4Gpxgz6NtHjHBVGfMrvwolBfMoHmyKx6VkKkkcSF9p47CLehT9d18h4Ipu7xGIdPQYip
         LD/Di17/8lPJG0w+Xqro1fPGN/CqdFSySFTSYSf/54wzGETwuKuJCOS403O6W/I5UiEV
         DQu1n3D9RK5CyScgnWntZHq9+UHLT5XSMDi5dddUjCr773rWMFqsflcdu43qy4PcA1nL
         wU/w==
X-Gm-Message-State: APjAAAWKvjcJxTLoBcDj4F6APC0i4ZcyQD6IPm7kfxI6VloeFpu2KSHD
        +Dbi+84pzcv6GF+AvIf20W4=
X-Google-Smtp-Source: APXvYqxjk49XAlOMQGr2pv8HiBO+9mD2hbpz/bzCfds+uwws9lJV62gKPwuWndq6m69i6Irva1K6Gw==
X-Received: by 2002:a5d:4b51:: with SMTP id w17mr419192wrs.357.1571861131729;
        Wed, 23 Oct 2019 13:05:31 -0700 (PDT)
Received: from Red.localdomain (lfbn-1-7036-79.w90-116.abo.wanadoo.fr. [90.116.209.79])
        by smtp.googlemail.com with ESMTPSA id b5sm177555wmj.18.2019.10.23.13.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:05:31 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     catalin.marinas@arm.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux@armlinux.org.uk,
        mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v6 09/11] sunxi_defconfig: add new Allwinner crypto options
Date:   Wed, 23 Oct 2019 22:05:11 +0200
Message-Id: <20191023200513.22630-10-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023200513.22630-1-clabbe.montjoie@gmail.com>
References: <20191023200513.22630-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the new Allwinner crypto configs to sunxi_defconfig

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/configs/sunxi_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index df433abfcb02..d0ab8ba7710a 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -150,4 +150,6 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
+CONFIG_CRYPTO_DEV_ALLWINNER=y
+CONFIG_CRYPTO_DEV_SUN8I_CE=y
 CONFIG_CRYPTO_DEV_SUN4I_SS=y
-- 
2.21.0

