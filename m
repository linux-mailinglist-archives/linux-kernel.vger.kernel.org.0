Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1D85E45C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 14:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfGCMsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 08:48:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43914 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfGCMr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:47:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id cl9so1188303plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E66BJBj0lKscdTHg8FShQPxIXv/lJtWJWNrVUu1xJMU=;
        b=cFs6VL7Eip5vd6GVRMF6w9dh3WpNqCCuUcJFLQ/wXyTN2v3gkf3M4w5Y26tBoYY4n0
         OLBQ+tBKEyBOVVgz7hh1zm2aZ6yVKhuZSihzJUoEBDjKT5fnLdSSNev3x4gB0AwOU2H3
         y2ByBCs/R4D0eyreMR6DxumQHomvywl0KgU4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E66BJBj0lKscdTHg8FShQPxIXv/lJtWJWNrVUu1xJMU=;
        b=VsD4PIStYXZVT0AFT83PYuwKuVoUqvFU7vnxyBvFXCYg8fvYBxzwai9hsJ3RK7ySt+
         /2wcn/C65sYSYF6TFXwjC2W5uSajr/0AGa1W+t0gVuEj9LSRWbde+MLQO4ttTXKSqeQN
         br2LMIEScKqmVNVbuA4JGUGpZk1n7nYRi1Sb0/8MtYax7FhBEqu2iI7v/PztkYLsFyh2
         MKNANqIL7v/Lf5qQKHKN/b674caJ7EOcru7NdACSJu9K8o6yYoav2N6Zm3c4cjJKJOBB
         LI+cqx1IsGQ6TMojIhB1i4xQqkwRob508ymWTWQhyslUU2xXrDVtmlSnhLDKR9RBpH66
         TJTQ==
X-Gm-Message-State: APjAAAXTilmz5vTziY8cCXgx80WLAtOMeUh6EfqCbeC+bzm3fGQywYEA
        UEFxE1QcvysfJlrjfkrJZb4FIw==
X-Google-Smtp-Source: APXvYqzMJkEPdNiqyC9uGCqfZ9XypYQFC276AVboo57ryVdTNUuX5YprAGGDnwlCqlrIfs0WrT1QqQ==
X-Received: by 2002:a17:902:ba8e:: with SMTP id k14mr42156993pls.256.1562158077970;
        Wed, 03 Jul 2019 05:47:57 -0700 (PDT)
Received: from localhost.localdomain ([183.82.231.32])
        by smtp.gmail.com with ESMTPSA id q1sm3735890pfn.178.2019.07.03.05.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 05:47:57 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 22/25] ARM: dts: axp223: Switch to use SPDX identifier
Date:   Wed,  3 Jul 2019 18:16:06 +0530
Message-Id: <20190703124609.21435-23-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190703124609.21435-1-jagan@amarulasolutions.com>
References: <20190703124609.21435-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license
compliance management on axp223.dtsi.

While the text specifies "of the GPL or the X11 license"
but the actual license text matches the MIT license as
specified at [0]

[0] https://spdx.org/licenses/MIT.html

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/axp223.dtsi | 39 +----------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/axp223.dtsi b/arch/arm/boot/dts/axp223.dtsi
index b91b6c1278c7..77e8e26f1314 100644
--- a/arch/arm/boot/dts/axp223.dtsi
+++ b/arch/arm/boot/dts/axp223.dtsi
@@ -1,45 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright 2016 Free Electrons
  *
  * Quentin Schulz <quentin.schulz@free-electrons.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
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
 
 /*
-- 
2.18.0.321.gffc6fa0e3

