Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9504419A10F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 23:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbgCaVpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 17:45:30 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36887 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgCaVp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:45:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id t11so6227779lfe.4;
        Tue, 31 Mar 2020 14:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9tkgMFNzJvbwS5Mj8KGdhRxtWizvU/2l3mcyErW424=;
        b=Xh8cN3+XZY5WG2wr8G+lXgRlETe2/mQEjF7Fy2E6IeSD7WXA1RH0PeQL81wTvbAT9F
         PGg1eBZ+/guSTJQ+fEKEQr8f2iI6i20maYi5eQaqwR/+1ELtYa7xzwDzZ7BxRnBQofss
         53MLLCcUp9pVG4yl4CbqHD+Jttp8bsrYi3yJnnzmXvgPi166zulUFlhrlMRYbqiY9mmN
         MMbGyQLA5mKXIEJC81AfLySBVGgyb+EaKauDCQU5sFhiCFER28C5WW8HhSLtAeO3K1Sy
         ChbDFx7DbGggIaDyxJY6uyOgRA2aQZIlYLcYQV5UMOgYsvzCyaIq+PXtf0WS2YsILCop
         Q+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9tkgMFNzJvbwS5Mj8KGdhRxtWizvU/2l3mcyErW424=;
        b=XdOzd5ETxJTkqi+3sZC3Tluh620qs+lJL1GPtpG1I2X7JAFxK9YSYvIQVGwagxDk2Q
         OLx/YuBGPF+ehrh3W44plcEdKv0qFXElw8D53ywLHTzr96FyBni530sIjPBoefcERE0b
         HcQEmRKC23pkurJxn24QlewVKKhQ39dh3Q/F4sUaultBEudIVeH6LicjEXcsW3J06+IP
         +TX6+66HVrpMmm9r/D9U4xQGR9/tkU+2xJxZ1cwhWdmMw9xuxGn4NV9H2Z2TW4Wf1ca3
         hHza8x7cgNOvOXSH9prQfpN9905JGLwvtswsch/M5cFKajxQExQjsqquxqyeNggB80ha
         WTGQ==
X-Gm-Message-State: AGi0PuZEHqPs7nfIfMNghAxaxevUAdplo9sdA0bteWPvSot9krR3Caz1
        yF1aK44UM2rI4TiIfQChKTs=
X-Google-Smtp-Source: APiQypJExWUnJfLTFyIbIrWjEXonMgSSwHZPYby9YmUEkVKAnJxvmdIYLHG8UujLkDzwCr5YaFXGWQ==
X-Received: by 2002:a19:be94:: with SMTP id o142mr12615936lff.13.1585691125114;
        Tue, 31 Mar 2020 14:45:25 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id a4sm3757826ljb.27.2020.03.31.14.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:45:24 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Pedro=20=C3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/6] dt-bindings: ARM: tegra: Add ASUS Google Nexus 7
Date:   Wed,  1 Apr 2020 00:43:26 +0300
Message-Id: <20200331214327.6496-6-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200331214327.6496-1-digetx@gmail.com>
References: <20200331214327.6496-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Tegra30-based ASUS Google Nexus 7 tablet device.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index 7fd0b66c69b2..fb3bbf7a5fb4 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -62,6 +62,13 @@ properties:
               - toradex,colibri_t30-eval-v3
           - const: toradex,colibri_t30
           - const: nvidia,tegra30
+      - items:
+          - const: asus,grouper
+          - const: nvidia,tegra30
+      - items:
+          - const: asus,tilapia
+          - const: asus,grouper
+          - const: nvidia,tegra30
       - items:
           - enum:
               - nvidia,dalmore
-- 
2.25.1

