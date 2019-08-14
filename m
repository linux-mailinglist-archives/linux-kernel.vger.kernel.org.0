Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 301A58D619
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 16:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfHNOaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 10:30:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43007 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbfHNO32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:29:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id b16so14592363wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eAFiTbS9tUsX23wvX/LxXnBM46JN5Jo6L8dXcPl3X0s=;
        b=I0uu0tb7hCj7NOzVQ9cxQqyxLj2ts/mcabRUsP2x/js53uYLjxjpmy9xUxR92i0vVk
         HkjNwwuBeSllIocHQNIVn7rVWwgfNk06xctYCAUklo05hcWc0h3ZMMtX1L4/YjEtTirl
         auQJ9EqjnJiEVyUw7UD4xZxTQAPQe4AtCltZgS0FsPzzE48Adn83e951uj63o4dLj4ak
         gpZ5LU8pKqnDwcj5Z2iFXdGO9/FcUWZWE7NOJcLwnekcZNrtLVUGB4ABOl6i9idkZCnu
         Ccy13esI8dtih+gCHB6bRKtJMIip975/2Xb9nAhp2/NYFe0A+I8FlDGoeWiNRDcEPB6I
         55Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eAFiTbS9tUsX23wvX/LxXnBM46JN5Jo6L8dXcPl3X0s=;
        b=QUi7XeZw+2Odm3J6J3MVvBYWdtUMutEqZufp5dD7dMUiijeZ2eiGOjly+MI2sh0DQN
         HNloLtBH88TaXiH4OweLrwGvKI+FhPlfr4NYIEx5wEpgIQtVf+tHWuRkl9WOHmv01Rta
         ubGIwI/pt980MH9Bc1tP8qx0p9dpguGLskYwtOTUb5iWWjMsQwrn8CeSsrCVi0Il1J7Z
         pOtE4nDxcfY4V9zzx42UodmDy4oKmzlXtstnjOysXtaPhO73zHrgc5cj0A2iQ88l2EBc
         O3TKyzp9U6hHVlpdS7xnFTPbfIjLWjMfu3d2LQSNuUVkU3PlzkB7oawaXnyb6qOBidLY
         gWBg==
X-Gm-Message-State: APjAAAWwM/yZQD0eowk4/W6mC6Bk51/N2d1dRFvs7gFcqyYcXFq2vnIG
        2TvMaJmu7tZRPWckjDPje1cNYg==
X-Google-Smtp-Source: APXvYqw2v0j/k9m0jX2dRH/od4sgZO9K4GyqV4f6kOpOSECtwsplxNzyoaB+k3+nqd8UXQjoU3OmrQ==
X-Received: by 2002:adf:a48f:: with SMTP id g15mr8286783wrb.172.1565792966037;
        Wed, 14 Aug 2019 07:29:26 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o7sm4202908wmc.36.2019.08.14.07.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 07:29:25 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 03/14] arm64: dts: meson-gx: fix reset controller compatible
Date:   Wed, 14 Aug 2019 16:29:07 +0200
Message-Id: <20190814142918.11636-4-narmstrong@baylibre.com>
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
meson-gxbb-nanopi-k2.dt.yaml: reset-controller@4404: compatible:0: 'amlogic,meson-gx-reset' is not one of ['amlogic,meson8b-reset', 'amlogic,meson-gxbb-reset', 'amlogic,meson-axg-reset']

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index c2d3fffea8a7..5b3dfd03c3d3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -220,7 +220,7 @@
 			};
 
 			reset: reset-controller@4404 {
-				compatible = "amlogic,meson-gx-reset", "amlogic,meson-gxbb-reset";
+				compatible = "amlogic,meson-gxbb-reset";
 				reg = <0x0 0x04404 0x0 0x9c>;
 				#reset-cells = <1>;
 			};
-- 
2.22.0

