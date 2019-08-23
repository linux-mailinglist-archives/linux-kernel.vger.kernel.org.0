Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBE799B3BD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 17:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436499AbfHWPop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 11:44:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32785 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405934AbfHWPoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:44:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id u16so9077838wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 08:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=obK+l1ULf2sodNI7EPFbhk9WngUPNNkAHt9c2x+XLfQ=;
        b=VrnX7YAoRNF2QXB/FmCbyyvtgPhaISGZTOHNHnruEsnUUq7c4eYdDOnHo3qfvrRSTa
         cAXo+g/zyoNk5o+EsAvX1XPOPH9/D81X/Ci+mXOhZZ04EN8P4nhp7PhMkaInSnUzc2sX
         ZtOvgfBPw4JBXjTODebypaABuXJ0lUAUOzS/8W03s446qQqOY/9qMfWejUXsNRc/y7Wv
         lkSXpz4ufPzWTognDuwvsDHKaeu9gneIPzKwuVVQCpesXf0W9J7ihvwqVcWSeTMdlLHb
         FIBcdYt0YwnWmLsdUTYk+qmuwAv3KMxsao8y16G8BtQHtO+lfl+VLStWDXxXnJgobyWy
         eWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=obK+l1ULf2sodNI7EPFbhk9WngUPNNkAHt9c2x+XLfQ=;
        b=jpYsroFGcV2//YzP3yaXAeQgnyu7Jg3GUPki4SvCgr2iHAQY60lmWiDAvCm7OoJ8YD
         2IlCsfVFoYDrLDQYErXBt4FwzxN4KY4ywSgyBFNBROmoCHx1ita0uNi4BT2Jt+WoEcUR
         FagGKdJFGuLoKh//57U/kc5PUNy52dselVMlHMm7q1rFlJ4OgGGGrsunSZyOpCysceSd
         cN/xDOVu+wRRb5iK3xuX2FL5LOU/pV0C9cG1DtQwP58HIw8mIRMJnyTNZbDk/mSwsePF
         CFtm4JkjpOPZuWheAO9vod8Ie7Hyq87PlHkKgQmaElNTrOJDc4NyBac5zB/xdvON1wkO
         lmCg==
X-Gm-Message-State: APjAAAVCMHXfSZ2JSa6hHO213FQa1trjiMs4duGFzkBbsf50Kad38l8f
        gp7bK0MMvTOdBLgFfEK/wem6LQ==
X-Google-Smtp-Source: APXvYqyizMhVOpr7iAgAyLE1B+VmNli3JIySiusqNQ07frIHgweG1flrCh0CFLEoaYVhqaKS57axvg==
X-Received: by 2002:adf:e8c3:: with SMTP id k3mr6265714wrn.8.1566575076760;
        Fri, 23 Aug 2019 08:44:36 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v7sm3567342wrn.41.2019.08.23.08.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 08:44:36 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 1/2] arm64: dts: meson: g12a: audio clock controller provides resets
Date:   Fri, 23 Aug 2019 17:44:31 +0200
Message-Id: <20190823154432.16268-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823154432.16268-1-jbrunet@baylibre.com>
References: <20190823154432.16268-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock controller dedicated to audio clocks also provides reset lines
on the g12 SoC family

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index cd3d23d2c6a2..edbc30572958 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1434,6 +1434,7 @@
 					compatible = "amlogic,g12a-audio-clkc";
 					reg = <0x0 0x0 0x0 0xb4>;
 					#clock-cells = <1>;
+					#reset-cells = <1>;
 
 					clocks = <&clkc CLKID_AUDIO>,
 						 <&clkc CLKID_MPLL0>,
-- 
2.21.0

