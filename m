Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215F22B692
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 15:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfE0NjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 09:39:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36253 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfE0NjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:39:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id v22so8640112wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=verJ2TtoOCB8JmW8F70UDjfoCp/cGBMV0EuzVh2W1as=;
        b=di7iNvnui7FhLrNe5R7wm7HudrjyzbQi94oSfDaZu4LWq8akC9LiUFa+RHumrQcLEA
         aOhH7queUJ9e0VbTh3LORPtzI+VWRq31fSwU0hCvOI554q1EXtLsxaWBRmo1x4ppmDDJ
         +EIncHx/MDk0NuxHkyPuaStxM7Xfps2rGWP2k1fzRoWucdDtkJkpH6l9GfqtHIL5DdLq
         XcImVYBi13I+SG39PDvZ8rfaxadr03MA/ZfHVK6LHCCmX2mpqy1TJZrchrtOCMx6K6JZ
         DoFLVeVGp8SpmASbDcXGj9Xba7xZIn76sb2s9BKmDFbxnIaVlbLABt57dYK7QzKaF4tV
         YCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=verJ2TtoOCB8JmW8F70UDjfoCp/cGBMV0EuzVh2W1as=;
        b=sJBrY+p7O6qRnei61C4L1xF0jiqGz3i0z5+Xm8R/XKR9TTkJ3fktJqPegbgSXhdb2n
         Hq5QbwH7HuP3eo8+DPKKMQZnqXG6EnNwmvqQ2yx2tovdslg9Cgr5WkgBv8wVNmEVGMU4
         7znzZER4kgN/I95C8v+nmQxciPtBy8nqhDWU/Ro4vBHXaGGSceVKCWNiDWn8uFDcEW02
         MSQ8WjLSYGqbJBYB3b727WUrdEz5Xq7exTWj4ml6RWQtB+iDzetgm1NNrun1DvoHfjWF
         srlsuhKE6dfSuDLXYRZLLZMQ7378g/8WfpgrBoDEj49Yqy0K4FzMPpECU2d7H5aEKCu8
         xqtQ==
X-Gm-Message-State: APjAAAWh+PQYvznsQa0qZCkmYdEPMrLfsh/0b2gtB/O7qUuVXDuhf9jE
        9LQkApzCEYZdeXaDJ90ksQBStA==
X-Google-Smtp-Source: APXvYqyd/kK2slKqdVMOm7do4U1lyX83rjJItaXdUFe1Fo2m7B4apmdNOOZfK2IQ34qBHCqw24Uajg==
X-Received: by 2002:a7b:c3c3:: with SMTP id t3mr27136443wmj.88.1558964349041;
        Mon, 27 May 2019 06:39:09 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a124sm7838335wmh.3.2019.05.27.06.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:39:08 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 08/10] ARM: dts: meson8b: update with SPDX Licence identifier
Date:   Mon, 27 May 2019 15:38:55 +0200
Message-Id: <20190527133857.30108-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527133857.30108-1-narmstrong@baylibre.com>
References: <20190527133857.30108-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the text specifies "of the GPL or the X11 license" the actual
license text matches the MIT license as specified at [0]

[0] https://spdx.org/licenses/MIT.html

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 42 +---------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 800cd65fc50a..6e48182962de 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -1,47 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
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

