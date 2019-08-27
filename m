Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75FC99E530
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 12:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfH0KDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 06:03:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33113 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfH0KDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:03:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so18173404wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nFvBQ+ASUXIFlVmkozv/yv2UYrSxjvTzp86D19iRVSk=;
        b=OQfE/BrI+i52OcYL2jZ5opgZ0p8C159XYYM9sMXYdxUyYIUr4nHp7lAp2Uq+YzYw9R
         b1vNxfP8QjKQa0gI0xuAPADk1vdLA4HHznp91WI/dU353VlSQ/CFNaoINzl7neegNX17
         V6503t8RaAyLtaN2Xhm9izG7Jo6eRliH6scgAp4FmvrA0RApgWDDy9a/aMC4QYXGDwL1
         nFK3MoD2M+sgJU8Baq+FZnuHPoDT6xDLpJawv6HXxby0g2Yj/EAGsOu2L4MU3Lx3Mcrk
         fbF0Arms9OxgmGNeYI6RSJuJ9alDV5PX/v0mOeqw6R6e0DoLTUFEd4s05vzysrR00ZEH
         JYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFvBQ+ASUXIFlVmkozv/yv2UYrSxjvTzp86D19iRVSk=;
        b=MKfcbYtxD4aOZjVkSPi60MqmiKl34Bdz7jGzOOqzmuA2OV7M1Oiv3rtbLlpXpOE4NL
         qRSdt0SdeM0MHEDX6KHGzc/Gh4JcDc1x+nq6ZRgWYUN+YRxILnvflfZX/ncsSmOFJbfH
         iBjA4cbDE7YP7Y7dyDngnChirtMN5nIKs+1IfSErPXvRWvkXSYezutOUVIMGaVjRcm5L
         hjUMGJjx780lxiScmYSVA3Gj9KfygQvj8EJQDDzQnNSKp4lK9VOgccCZ0ZjfX2eg9hcZ
         a/rRXXeQ1eyWiiWxfQ9mAINm6oYF7Z5waiRSuhF2H/PdYyZiPzhPRfaoQJqf5FHqWoie
         E9lQ==
X-Gm-Message-State: APjAAAWYE9ykcpuuNfEDY1NCJDPCub2AZIbF3byaQopgcLKjSKnKTKN1
        C9KQTn832OkQJ1rAS8KMHfez2g==
X-Google-Smtp-Source: APXvYqyXg1CwX3b4xu5v1NJTgayfPDThhDxBvEtvylLfIoV3nJiJJMzI9qbPJJaPyUyDDamtHKAzAA==
X-Received: by 2002:adf:9484:: with SMTP id 4mr27109881wrr.14.1566900192197;
        Tue, 27 Aug 2019 03:03:12 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o25sm1816289wmc.36.2019.08.27.03.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 03:03:11 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/3] arm64: dts: meson-sm1: specify suspend OPP
Date:   Tue, 27 Aug 2019 12:03:06 +0200
Message-Id: <20190827100307.21661-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190827100307.21661-1-narmstrong@baylibre.com>
References: <20190827100307.21661-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag the 1,2GHz OPP as suspend OPP to be set before going in suspend mode.

It has been reported that using various OPPs can lead to error or
resume with a different OPP from the ROM, thus use this safe OPP as
it is the default OPP used by the BL2 boot firmware.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index e4830cbf7ed5..32e2de2614b1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -82,6 +82,7 @@
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <780000>;
+			opp-suspend;
 		};
 
 		opp-1404000000 {
-- 
2.22.0

