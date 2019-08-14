Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D90B8D5FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 16:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfHNO3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 10:29:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55477 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbfHNO3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:29:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id f72so4784590wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YgaOioBZlXiCl+6+Qenig7yRj93M4S2LcZjul0tGl00=;
        b=JeIke4j2+vBHiU/gxigtg0yTHMObUZbzehCSiQXx94BkdSyCEhiTVNLTTLwxQ5Xmi4
         oCV3XX2zi2KfuiTrK+nQKZWgLwzvfPQC8D5WUBEkT2xPw6pC7HKqeEu3jSeqLuLlVo53
         DCa2pJhNATJuCheITjlk6httU8tTwqF6DT5oPzPzXRT4BruyZ6WDoBabNEhKqfpKlctc
         WW2JB7Ema7hWWv+J7ygbqyVKCKXgogSg8EDSSnQ6Hiqp2X9pZOChQzWi+LPbhrgdpKON
         dBzEG3aETyEudLoUfo/N5X42uAjAKlvYZfCF4BGUQ0lUGWykLHriXpj5uCArXW49psOT
         cIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YgaOioBZlXiCl+6+Qenig7yRj93M4S2LcZjul0tGl00=;
        b=jlrFI3YL/n/5dE+MCHH4qwY8NM4I8OVMRDkXQ+DAoEjDPKH11of+tvPeqT4O5YkacO
         WKesfxZ/v79GrGM2VxxN0ovFVXZ5WOWhNxzfkzMPCICX0U545MyV1srZE+Vxw3gbFtB8
         JNw1j23q9lsRoe26Otv3ob0rSU0sRv3SkdJ+XroQgmNlFhmHkx4tfB+XE6FUBTIrePwo
         dvcLQUObQ8rF5i0NgUT/nQZndrIGr18FJcvqAmRYc/MEuzlDck+5BWnREDkb5x4dTH5/
         bxw9Tdti1DE2oq9LSWfeGi8FmMufRr/4gJEZbXMqROQNK63CNd8/gQRWYPtq2xhnIQ9p
         n0/w==
X-Gm-Message-State: APjAAAXMHeDVkroTalDTx8NfirxlqvOm6HCzp1AqE7+sCBP0FWlofqDM
        sQnxBzoeWo9tt7VkJa1Pcx82dg==
X-Google-Smtp-Source: APXvYqyzIAp/InEQpA/Ec2lH8RrkSyLE8Ef6LLXUs3RtFpmU1+uYke3b4NG0Ke/GRABR+kSETfNBLw==
X-Received: by 2002:a05:600c:224c:: with SMTP id a12mr8832448wmm.12.1565792976746;
        Wed, 14 Aug 2019 07:29:36 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o7sm4202908wmc.36.2019.08.14.07.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 07:29:36 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 13/14] arm64: dts: meson-gxbb-p201: fix snps,reset-delays-us format
Date:   Wed, 14 Aug 2019 16:29:17 +0200
Message-Id: <20190814142918.11636-14-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814142918.11636-1-narmstrong@baylibre.com>
References: <20190814142918.11636-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-gxbb-p201.dt.yaml: ethernet@c9410000: snps,reset-delays-us: [[0, 10000, 1000000]] is too short

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
index 56e0dd1ff55c..150a82f3b2d7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
@@ -21,6 +21,6 @@
 	phy-mode = "rmii";
 
 	snps,reset-gpio = <&gpio GPIOZ_14 0>;
-	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-delays-us = <0>, <10000>, <1000000>;
 	snps,reset-active-low;
 };
-- 
2.22.0

