Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8C611F578
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 15:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfEONT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 09:19:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44843 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfEONTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:19:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id c5so2624332wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7q3OboSn1Utxth2w6fivo99umEKJDOfPqrO+oZXrXms=;
        b=tvLa8z4mV3sY8knydD6Essai3H/kETAk/KI6JrKEK9QfiMUVTA38wqcQXDTOKehNHs
         k2TtGeTDDK3LQqAzrQsZsVKG+2mpEueikBtU76P4zE2IQ7ycRuw+/V2kZN1vIjkAoDZx
         NlHijfa0NIjgCu5/dDXqGiAnen31TVrdqtPS/5/Ge6NBsVeuoW9yJu3WjwmfsDw6cWoV
         eaMTsRQEoQhINML/KY6ON9L3nrEsrG+HJLuqaGxbSmA2K6Kl2b6XMvxlRT8Et9gXPKTB
         BZGMAW4O/3zkOsw/gXXKQt0I0XanyVNSE1soMo7aCi3h/tlGAj/gk8KfrMo0eTgsRAxU
         N2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7q3OboSn1Utxth2w6fivo99umEKJDOfPqrO+oZXrXms=;
        b=Si7Ma7MLNBm+I+DzIlfSgB1wifI6q2z7RoNakH35zHascKyxqU978/qhzrZKzXF0in
         IuSkeV8odfiKDHnSiuyUwLIi9xsd0nX5mv3w6dOnwhNqMhtSWrFm1a6y2OVourOVGoTs
         zom6G5SW3V9POe61AUIod7fOjjh/NvqNq/VwcB/9vNGzB9xF9WET3yhb1nA2UXKs36wc
         AMLjwZeHcaLJWcpO9wFQkiMIXcX8A6mEpSnFWQwMyffLp1CABLnMCxuWbM29T2lYVySX
         ccKyj5gMWz4qVj1YLMJj/N6unsb7iKieuTj+RIRYW7mwB644vE+Tj1k9+jctjBXNFhU0
         VpuA==
X-Gm-Message-State: APjAAAUoe7owJKdBhpMOajK9MH23sahZ7SJtJuNYNfi14zbIv02z94jb
        f301DykqCs9FQS/Zn0nGjh4qyQ==
X-Google-Smtp-Source: APXvYqzd0y4lCucxlNEcZkrCxWfuLOprdX+AerEPcc1L9Cd78ryiISSjyaQQLjM/Tnd5vmfnDB0Wfg==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr26304190wrn.156.1557926346200;
        Wed, 15 May 2019 06:19:06 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b206sm2789848wmd.28.2019.05.15.06.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:19:05 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 3/5] ASoC: meson: add tohdmitx DT bindings
Date:   Wed, 15 May 2019 15:18:56 +0200
Message-Id: <20190515131858.32130-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190515131858.32130-1-jbrunet@baylibre.com>
References: <20190515131858.32130-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the bindings and the related documentation for the audio hdmitx
control glue of the Amlogic g12a SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,g12a-tohdmitx.txt  | 55 +++++++++++++++++++
 .../dt-bindings/sound/meson-g12a-tohdmitx.h   | 13 +++++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
 create mode 100644 include/dt-bindings/sound/meson-g12a-tohdmitx.h

diff --git a/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt b/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
new file mode 100644
index 000000000000..aa6c35570d31
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
@@ -0,0 +1,55 @@
+* Amlogic HDMI Tx control glue
+
+Required properties:
+- compatible: "amlogic,g12a-tohdmitx"
+- reg: physical base address of the controller and length of memory
+       mapped region.
+- #sound-dai-cells: should be 1.
+
+Example on the S905X2 SoC:
+
+tohdmitx: audio-controller@744 {
+	compatible = "amlogic,g12a-tohdmitx";
+	reg = <0x0 0x744 0x0 0x4>;
+	#sound-dai-cells = <1>;
+};
+
+Example of an 'amlogic,axg-sound-card':
+
+sound {
+	compatible = "amlogic,axg-sound-card";
+
+[...]
+
+	dai-link-x {
+		sound-dai = <&tdmif_a>;
+		dai-format = "i2s";
+		dai-tdm-slot-tx-mask-0 = <1 1>;
+
+		codec-0 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_IN_A>;
+		};
+
+		codec-1 {
+			sound-dai = <&external_dac>;
+		};
+	};
+
+	dai-link-y {
+		sound-dai = <&tdmif_c>;
+		dai-format = "i2s";
+		dai-tdm-slot-tx-mask-0 = <1 1>;
+
+		codec {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_IN_C>;
+		};
+	};
+
+	dai-link-z {
+		sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+		codec {
+			sound-dai = <&hdmi_tx>;
+		};
+	};
+};
diff --git a/include/dt-bindings/sound/meson-g12a-tohdmitx.h b/include/dt-bindings/sound/meson-g12a-tohdmitx.h
new file mode 100644
index 000000000000..c5e1f48d30d0
--- /dev/null
+++ b/include/dt-bindings/sound/meson-g12a-tohdmitx.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_MESON_G12A_TOHDMITX_H
+#define __DT_MESON_G12A_TOHDMITX_H
+
+#define TOHDMITX_I2S_IN_A	0
+#define TOHDMITX_I2S_IN_B	1
+#define TOHDMITX_I2S_IN_C	2
+#define TOHDMITX_I2S_OUT	3
+#define TOHDMITX_SPDIF_IN_A	4
+#define TOHDMITX_SPDIF_IN_B	5
+#define TOHDMITX_SPDIF_OUT	6
+
+#endif /* __DT_MESON_G12A_TOHDMITX_H */
-- 
2.20.1

