Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF2C9A710E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 18:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfICQxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 12:53:45 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:18167 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbfICQxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:53:44 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x83GrQpe037061;
        Wed, 4 Sep 2019 01:53:26 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Wed, 04 Sep 2019 01:53:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from localhost.localdomain (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x83GrNwn037038
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 4 Sep 2019 01:53:26 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Mark Brown <broonie@kernel.org>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH v3 4/4] ASoC: es8316: add DT-bindings
Date:   Wed,  4 Sep 2019 01:53:22 +0900
Message-Id: <20190903165322.20791-4-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190903165322.20791-1-katsuhiro@katsuster.net>
References: <20190903165322.20791-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing DT-bindings document for Everest ES8316.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 .../bindings/sound/everest,es8316.txt         | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es8316.txt

diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.txt b/Documentation/devicetree/bindings/sound/everest,es8316.txt
new file mode 100644
index 000000000000..aefcff9c48a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es8316.txt
@@ -0,0 +1,20 @@
+Everest ES8316 audio CODEC
+
+This device supports both I2C and SPI.
+
+Required properties:
+
+  - compatible  : should be "everest,es8316"
+  - reg : the I2C address of the device for I2C
+  - clocks : a list of phandle, should contain entries for clock-names
+  - clock-names : should include as follows:
+         "mclk" : master clock (MCLK) of the device
+
+Example:
+
+es8316: codec@11 {
+	compatible = "everest,es8316";
+	reg = <0x11>;
+	clocks = <&clks 10>;
+	clock-names = "mclk";
+};
-- 
2.23.0.rc1

