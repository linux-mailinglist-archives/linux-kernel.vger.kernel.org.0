Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDF45FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 16:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfFNN54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 09:57:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34840 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfFNN54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:57:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so1617734pgl.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MtruUp1oeG0LlHvhP1csrfrOTlear+t2x5W6tuqfW9o=;
        b=FjvxiB4m662o2o7ihDbvXVjViUXtQk/zRrBeU/gUIaSw1TlRXI6JnyJfn3fu5dtZ6R
         aIaF+yJ3UoM6FaeOs3csYpHm/yPfjXGru2XL6vh9s/LH2fyRySbxMndioIspefjKTrMN
         WqV8bXMxY3Y/bFB4Ngnan5KKSs9nM0/bjwaH0G/9Z/g9b4/fJQ03ndLIyFstyZ7UwuLQ
         hN7mx9JnBHJp2U/7Ne2mCLeVISASVcUERm2xuXhQUKKxspUgatHhCETiWJ21WjLFtxjy
         gANvQq7yP+pvO16p7yeIuUl+V1hJSlCIe+SuXfjQlxq0swPiI5/orL84Vdg+jFjhmNme
         FJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MtruUp1oeG0LlHvhP1csrfrOTlear+t2x5W6tuqfW9o=;
        b=ieRQCSGOyVWYlJvUQ3KYadbfQEmoMO99hkxX1+UTlRfv+E1xuKjct1OAFjBy3lu4J9
         qwDl66pExeekyVs3n5PAhD2hUuX8au6mKIOoY5pY623NiL+53nLV34ao/7sp/Zna1dtG
         3BAOBl+K4H5mC43saJhJT7XtQxrBmG+8wNV1N6FVtwhogwHN3Uzl1GdJO8RUhvX571PX
         PsyHtq7THIg0iN6qPw6xbFcwunFaU6aC/jmCirrw/B/1Qu3JSFXLl/rJ+j54xt3zbmNz
         l6Uxl3qJ7hwxPf0q9xLiXFz0WRwFdXzCFFyeKWT+hoMwnAMH+YvHdOKcZcS5z7v/dSx4
         PC1A==
X-Gm-Message-State: APjAAAXSFQOPPV+Kv3QNLbfShk5hXkxGg7xPzcTe+C9YAAJGJqqG4Nmy
        0hxjwMYgWmwoAGv8slApPX4=
X-Google-Smtp-Source: APXvYqwCuv7QBXZXeFNoRYeEMcV/bSanFhyVUI0XjKQwLWqnlL1ycXZR0IWC1MZ4dRWtWbcidAOa3g==
X-Received: by 2002:a63:3047:: with SMTP id w68mr18802903pgw.65.1560520675566;
        Fri, 14 Jun 2019 06:57:55 -0700 (PDT)
Received: from nishad (p3261240-ipngn21201hodogaya.kanagawa.ocn.ne.jp. [153.202.122.240])
        by smtp.gmail.com with ESMTPSA id y12sm3064887pgi.10.2019.06.14.06.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Jun 2019 06:57:55 -0700 (PDT)
Date:   Fri, 14 Jun 2019 19:27:45 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: ti_sci: Use the correct style for SPDX License
 Identifier
Message-ID: <20190614135741.GA7244@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in header file related to Firmware Drivers for Texas
Instruments SCI Protocol.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/firmware/ti_sci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 662dcffef311..d7b4cd3fce8f 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause */
 /*
  * Texas Instruments System Control Interface (TISCI) Protocol
  *
-- 
2.17.1

