Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2615B23A59
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 16:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391777AbfETOid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 10:38:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40618 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391707AbfETOiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:38:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so14910784wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W4dXOOf/ZwsiW1E42PXFWmoJeaO05v5ew8hdRVBHcrM=;
        b=gNuDfq7Seiwsb/4awLd8eeGTPx1iFkm/88M8WNnmTdQ/pDN+0yba0HrktlM12aWf/j
         QyBLF/n9TePpd19j2T8Ph+SczdNZe3bn2/QpGFDFMzr6GBXOuaLat6EWkBG+PIZn0cUG
         OdllZO1gzCCVMeF9P3HDB2EgaxRlTjDST9sPjp0QC1rXQCpweQ4c4j1hv6u/cpcho9Pn
         h3uQCJNDdhD7QaUredWkBSbAkREC4kl+7rJLrm7KzDMoXS63BOGM4tbouCJx8+Zqend7
         XDpUbPcNdAgDOdTShO3nM7OvWIQa2ebu1V0NQoi1IfJDvC1XV4O3qq2gluDPFWl+pCoO
         kr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W4dXOOf/ZwsiW1E42PXFWmoJeaO05v5ew8hdRVBHcrM=;
        b=FV3Yv3n9AGvQ/HzchCM2R4736KFjsIi5+G1QhApzmTJqkcfnU6/a8LSjz4hh0rvoSN
         X2ZtxuQHDhuCyku1mmBcXM9dw0wwJbtzC7cUMiyJWP7zYEPjHBddb7lGdt++OQdHsKmg
         qfg3r49SF20Zp3dlV4/NBCMAKRD20Go+WLQhQ6OHkUvZPN4z55aBi2tPpErdofOFyBXv
         InCyv7LgIDIflLygXiJ2B1NP9VzEg2EDHPxgbmI9LxCkNdeFMraKY++cszEtnz4O++Ny
         373t9oRk1aCLlwXC63JTyK3zz9jVtNkHj3F2Q6dWsHE5P1uLJApggjQrO4mTlLD6Nbzm
         m0xg==
X-Gm-Message-State: APjAAAVBIbFmOKIccigO3jpabR2hp7LTQlajsR3t/5sLZpKbhE0rvLSM
        cMnJSe++ZQPMlNSM0mo/fKKFSw==
X-Google-Smtp-Source: APXvYqwHNVVduLD11lg0McpRS1gvBdd0l++uuorvdFMNVhf087yWX8LFiIBRLtA8BtN7QUYuFfw/eA==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr8791748wru.142.1558363101062;
        Mon, 20 May 2019 07:38:21 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y4sm12505976wmj.20.2019.05.20.07.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:38:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 08/10] ARM: dts: meson8b: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:38:10 +0200
Message-Id: <20190520143812.2801-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520143812.2801-1-narmstrong@baylibre.com>
References: <20190520143812.2801-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 42 +---------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 800cd65fc50a..c38b0828b7ec 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -1,47 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
 /*
  * Copyright 2015 Endless Mobile, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *     You should have received a copy of the GNU General Public License
- *     along with this program. If not, see <http://www.gnu.org/licenses/>.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
 #include <dt-bindings/clock/meson8b-clkc.h>
-- 
2.21.0

