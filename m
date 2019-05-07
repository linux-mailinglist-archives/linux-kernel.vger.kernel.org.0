Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 234411632B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 13:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfEGL5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 07:57:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39183 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfEGL5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 07:57:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so19601741wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 04:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cMIohpfoq8ydYsh8yqcuhIMeQYx+QNBx59vvj52nmtM=;
        b=KvxZZuB2MX2DVl3lnqgiZt+iGtjzeQEPj/COF446peA5i69RRFXamMwhvQA1o7OAXe
         yXSCHgvlPe5qLe0o/xmVXnAvDe2bM/A541S/CmyMwog6ZlEivLmsWC/NLIYQ3tdWtYVb
         4u70QE/SUbU0vByzmAgzAJG1KxRjUKcaj2NuOhIhZ/bbMDkRE368iE7xnOtKn3Z8Kt2S
         +rNaRAZmXagI+0cUwgfn4mR1X9+S2ePWl/L1NZqjtDGjdiiBX/cyIf9wlsn41zKM/rOG
         /BReYnLgRTFAa9uaP9fn3YTUqEgnLGJYtvV1OOwTskbJsrSMQvdgC0a69/Coxxuqj9rh
         AEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cMIohpfoq8ydYsh8yqcuhIMeQYx+QNBx59vvj52nmtM=;
        b=ql0Z4hMSBVl3D6lDkr7XDP724AF5pXfUVl2f7vikrE+vaV6qms9cvuKeQWhy5+QkX+
         lmYEAfkOniGIFxvVnmELMUpJoVGYIV3Rgm06qqOsgyXZUqDPwUb/YOHUOGqXeoDe5vHy
         j0tm76Gm/wyWTDma2zU9AgHQ9WazRyc+6vKxBEDCRxoouHMd8FsbS/z0S+vfxMEFv2pT
         I5zupD/Q5sotzveHRUGuggKw70ORw+AHJ3ah6oLQ1S/TgUzlGp2NpqQIAD7xsifW+c7L
         zrWoEGbxWibqf9j2Z06AqdfjveghA3L/Ehzp4OIH8NpYBhmF/jXHQaFMxHf4tYUE5Lsc
         tguw==
X-Gm-Message-State: APjAAAUX60ANQ9GfJeR6rKB7hta7py9iDzTOvSYHKug0kd7Dp8ZT724i
        qgyxHZV1fkCTjhqfdB14tzQ0wQ==
X-Google-Smtp-Source: APXvYqzmj2Rq5RP6yyQou3bzdy9uJ/w14kHqMcuRNezp/SQ/B/6RzFds9x8L9gkQSErOSrCkXWefOw==
X-Received: by 2002:a05:600c:2298:: with SMTP id 24mr19775725wmf.21.1557230249232;
        Tue, 07 May 2019 04:57:29 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s11sm7120274wrb.71.2019.05.07.04.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 04:57:28 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] dt-bindings: pinctrl: add a 'drive-strength-microamp' property
Date:   Tue,  7 May 2019 13:57:21 +0200
Message-Id: <20190507115726.23714-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190507115726.23714-1-glaroque@baylibre.com>
References: <20190507115726.23714-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property allow drive-strength parameter in uA instead of mA.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
index cef2b5855d60..84adce9f2a75 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
@@ -258,6 +258,7 @@ drive-push-pull		- drive actively high and low
 drive-open-drain	- drive with open drain
 drive-open-source	- drive with open source
 drive-strength		- sink or source at most X mA
+drive-strength-microamp	- sink or source at most X uA
 input-enable		- enable input on pin (no effect on output, such as
 			  enabling an input buffer)
 input-disable		- disable input on pin (no effect on output, such as
@@ -326,6 +327,8 @@ arguments are described below.
 
 - drive-strength takes as argument the target strength in mA.
 
+- drive-strength-microamp takes as argument the target strength in uA.
+
 - input-debounce takes the debounce time in usec as argument
   or 0 to disable debouncing
 
-- 
2.17.1

