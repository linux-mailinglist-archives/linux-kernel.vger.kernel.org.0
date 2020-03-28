Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF321962A7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 01:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgC1AmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 20:42:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38838 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1AmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 20:42:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id f6so8121623wmj.3;
        Fri, 27 Mar 2020 17:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CyGjashJridaD7EOncRRtljYVEVx0U+lNGZaPp2V68Y=;
        b=IptMWCxZLROI05RPdivzL/MiF45cGIjZgNtc4RWBqeNsCIeOsisxtfQTPTt8Frvkew
         GN/AxvkeF6atRjS6S3g9JimBi6e+6Bk82g8Kht9L/S2NyD5pdcnOoFcg6aMxUMN7S7/u
         9DmgWye5ERHiBSRmiJVyop0S9l/19iYR7YoPc5B/PmaQbJROP7HSsMhoD8qFkmqU7SI+
         +9J1dr3mbTpX/ha7onANt5lsOl1GTqzf1YdcHKEgMCx4uvTtHWNiSVf7Urvn53nWD4uL
         vkx8ECR9Qg+8tqrr/FJk/rLzrqcjuIG3FB9/ejW24U2df8cK+RUZkhLP3bARtDZUy+ex
         HboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CyGjashJridaD7EOncRRtljYVEVx0U+lNGZaPp2V68Y=;
        b=icjj/fMwoDEk0rFGJ8okzqLij4RkcR8CZPyn6navIfNpig86U3weh7FAml2bsAdIA3
         eICjc5+ompzzRc3cRF90peGLhyOAPPHMMk6758Kp0TsYz/aWRuZS+Z05b5Nq28BX72aJ
         gBQZ2ME2JEk/4z1PAecQ8BaJ7Y46VnRz7hwFIPxL99MQwg3VvcehpEmysUEINpgtKwg8
         g03MKPOIt/FyVmIUi8GGsjG4XRawX183moJTYVvdsg1ZvVQa+Zzx3oA8vO76pL8T0r19
         xsotIRFqyRPrWpYGane19nlSugNGoLVTXjcc1sg3WxFouqyw2FiZyGjDGahQazRj4L+P
         f/JQ==
X-Gm-Message-State: ANhLgQ0fSHNKhCP3Ic6xKBikewjTksAJbJ29dunTh0rYQ66B84Eta65u
        p65nhtcV5Dep2lyonM8Qx+w=
X-Google-Smtp-Source: ADFU+vvlJnYzsX+ao1dSJir0qYJy7B2HfzwRuyqzEeXskD58u19UIKeamdohRQLTKyIpvAMohyf5Ng==
X-Received: by 2002:a1c:96d1:: with SMTP id y200mr1376296wmd.114.1585356135213;
        Fri, 27 Mar 2020 17:42:15 -0700 (PDT)
Received: from localhost.localdomain (p200300F13710ED00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3710:ed00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id p21sm10783857wma.0.2020.03.27.17.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 17:42:14 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] dt-bindings: display: meson-vpu: fix indentation of reg-names' "items"
Date:   Sat, 28 Mar 2020 01:41:57 +0100
Message-Id: <20200328004157.1259385-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use two spaces for indentation instead of one to be consistent with the
rest of the file. No functional changes.

Fixes: 6b9ebf1e0e678b ("dt-bindings: display: amlogic, meson-vpu: convert to yaml")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/display/amlogic,meson-vpu.yaml      | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
index d1205a6697a0..cd8ad2af52c9 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
@@ -71,9 +71,9 @@ properties:
     maxItems: 2
 
   reg-names:
-   items:
-     - const: vpu
-     - const: hhi
+    items:
+      - const: vpu
+      - const: hhi
 
   interrupts:
     maxItems: 1
-- 
2.26.0

