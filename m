Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F39A13389D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 20:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfFCSyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 14:54:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44508 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfFCSyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:54:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id c5so7316752pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=OW/dmyNaGaVJoTyF3MoMrO/1pdIZuVh4e6+v5z0In/s=;
        b=QU37X96yUb+WqrlP0wwOS5x4Pn52G1X3+V/xa7s2j7M8nZn7pGnH9/BkYMJSpDNRKe
         9P2KZn1BDdDqZ36p3lHJra1PA5b/DaZlPNomnfoRMitiRf5Z5ewrFBakupBCLsD7uhGB
         EVDijmUj+cFQ2hzrWJ4Zs/67t9aDccvzTxHruhZQN+B5vJL94okoRy2Vxy6CHdJjcfyX
         +TPAZEn8A20asvY+uno099GtyV1qO7/HFFMncmr26n+u+72eAs3NWTGuowTCgIt6Tnj3
         lsuVsa6Oh3aRtEQVlwVXIvqKZKU7XVxt5UVSb/IhJ3HEPv/lpsF/s+yABgLLPlQVG9GU
         UxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OW/dmyNaGaVJoTyF3MoMrO/1pdIZuVh4e6+v5z0In/s=;
        b=gp6zea1x0LMzhl36PgbyNxucR5AC27t8scKar4bfdWJqjBu+WSWzc3B1KsX+KTX4Ad
         EU6UdqeSNNo9QJtYO1HSXOUAujRleyBFgUTY+tpoJqy0N4cWi1nDQwbvSYHbitw0Nlqq
         wPoVN9T29CskA5jDJ4uqvUvb3Wy83DSAMD9OCJJODmy7pZqM+ZHEQAHxmQ02Dg+ropIj
         gbX5AWxq1XCiWHr+xCNiWi2ZBwKPokq6ZQRfgiiqWdthTmAG30WknQ5ZVziTF9bfC+49
         sDoKiCRehMQRum4cvkMOEhmKpN7gLdGyaaXXqvSQaL8p7ovLNjE53W2Tv5yXZKIKMf5G
         CZSQ==
X-Gm-Message-State: APjAAAVETX18KlOPI4c3+GP0lmWBWdxpX6ZHdi0pscy9sKGBmqNDwVLP
        4BNE/tlIDXNe3zhFYMXOPqKRYrf3
X-Google-Smtp-Source: APXvYqx8QtZUnGrkvDs6bvqITl79TneNWtxFrYaz2XWOJRy/tM6baO9gejR3+HC3/7Tk2mboJhS0RQ==
X-Received: by 2002:a17:902:bd06:: with SMTP id p6mr31370665pls.112.1559588057354;
        Mon, 03 Jun 2019 11:54:17 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id d13sm25827511pfh.113.2019.06.03.11.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:54:16 -0700 (PDT)
Date:   Tue, 4 Jun 2019 00:24:12 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carmeli Tamir <carmeli.tamir@gmail.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: emxx_udc: fix warning "sum of probable bitmasks,
 consider |"
Message-ID: <20190603185412.GA11183@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Knowing the fact that operator '|' is faster than '+'.
Its better we replace + with | in this case.

Issue reported by coccicheck
drivers/staging/emxx_udc/emxx_udc.h:94:34-35: WARNING: sum of probable
bitmasks, consider |

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.h b/drivers/staging/emxx_udc/emxx_udc.h
index b8c3dee..88d6bda 100644
--- a/drivers/staging/emxx_udc/emxx_udc.h
+++ b/drivers/staging/emxx_udc/emxx_udc.h
@@ -91,7 +91,7 @@ int vbus_irq;
 #define BIT30		0x40000000
 #define BIT31		0x80000000
 
-#define TEST_FORCE_ENABLE		(BIT18 + BIT16)
+#define TEST_FORCE_ENABLE		(BIT18 | BIT16)
 
 #define INT_SEL				BIT10
 #define CONSTFS				BIT09
-- 
2.7.4

