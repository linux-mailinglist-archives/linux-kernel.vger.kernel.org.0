Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F081BED711
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 02:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfKDBks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 20:40:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:55756 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728432AbfKDBk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:40:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6856B228;
        Mon,  4 Nov 2019 01:40:26 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [RFC 4/7] dt-bindings: gpu: mali-utgard: Add Realtek RTD1195
Date:   Mon,  4 Nov 2019 02:39:29 +0100
Message-Id: <20191104013932.22505-5-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104013932.22505-1-afaerber@suse.de>
References: <20191104013932.22505-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a compatible string for Realtek RTD1195 SoC family.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index afde81be3c29..b01b95cf5cdf 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
@@ -26,6 +26,7 @@ properties:
               - allwinner,sun7i-a20-mali
               - allwinner,sun8i-h3-mali
               - allwinner,sun50i-a64-mali
+              - realtek,rtd1195-mali
               - rockchip,rk3036-mali
               - rockchip,rk3066-mali
               - rockchip,rk3188-mali
-- 
2.16.4

