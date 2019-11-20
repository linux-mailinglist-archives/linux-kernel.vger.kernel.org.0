Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 025051041C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 18:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfKTRKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 12:10:46 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:54774 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfKTRKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1574269836; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p087/TKJl58xmr/mCSc7t3gOix/8kRa6rUsT9WmaGBM=;
        b=I3GBVEvwvIQNliiFmT8oB4T//hCyBmlIDicuGsFWwhUWRivLfTvy2t4zpHbIUg4sjFOewl
        sptUJLsJ2nj7beoscoWDSbTNfyISQ5gqnL27m3Os+tN6scydL7wx6Q1hVysRX9qxRi0tEb
        DUL/srmrAKsORGnSDQNF9jcI5fYXWOg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/3] dt-bindings: panel: Document Frida FRD350H54004 LCD panel
Date:   Wed, 20 Nov 2019 18:10:26 +0100
Message-Id: <20191120171027.1102250-2-paul@crapouillou.net>
In-Reply-To: <20191120171027.1102250-1-paul@crapouillou.net>
References: <20191120171027.1102250-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation for the Frida 3.5" (320x240 pixels) 24-bit
TFT LCD panel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../bindings/display/panel/frida,frd350h54004.txt    | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/frida,frd350h54004.txt

diff --git a/Documentation/devicetree/bindings/display/panel/frida,frd350h54004.txt b/Documentation/devicetree/bindings/display/panel/frida,frd350h54004.txt
new file mode 100644
index 000000000000..8428f8b05b93
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/frida,frd350h54004.txt
@@ -0,0 +1,12 @@
+Frida 3.5" (320x240 pixels) 24-bit TFT LCD panel
+
+Required properties:
+- compatible: should be "frida,frd350h54004"
+- power-supply: as specified in the base binding
+
+Optional properties:
+- backlight: as specified in the base binding
+- enable-gpios: as specified in the base binding
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.24.0

