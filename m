Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA9FBA41D9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 05:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfHaDEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 23:04:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40343 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfHaDEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 23:04:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id h3so4169443pls.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 20:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l5S0szhfj3TgHUdOf3IXofgHxR1Ploqs1h0VtqnMnEA=;
        b=PYcFkmCIGWmNTKvGrznFUBp5UpoV9gEDIx9FCX9kO/sl7CRJIdyEHS18waynV1bQhg
         +wpayoA18qTZSF6hnN7/8dszqnjwyMUoFrvxZxb6B9gLNXeL8i7bOQ7M+ICJfVHOTiTU
         FcwGyQJXwWvAOYTeYwT9g8X1JEqxUTFFUGLuXP7vfTBPOekFHMVSvYTnoyNqwkD4KR8y
         xE4o7lV5VXWzcbXCx8R5KM/v0UkJVeLfivTeIx6PzyUHxeJtUAQV7zcP9jMWfIsbFG+1
         4WdKnIYH+KQ2ue0f47fxPA8j3uC3aWQBznC/04zK80IVkuxOlUP8SE+G29K00TZ8lVmK
         MWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l5S0szhfj3TgHUdOf3IXofgHxR1Ploqs1h0VtqnMnEA=;
        b=rSuVWCFRaexV88RhBr/4GgjOSFUBNSx0ukkBeicsvlcijKmVywt12YYFg4e7CafYkj
         tVsEoGg2CmOqPlWcSI5Zrbk2Qovf7wCgJkZfyjHzQXKSQULUt8t0rTfq/N/g5x8nmhRL
         Ky8YiOok+g2n0JqFYYac/BVJtuJT1STuaAe7LgPZ+HTtR5JcDmgEB359BtJgbubBPJjh
         ephmxxkE1rDJrKc8J7DA9YAxP9UOIscCZSGCcbuwL4sssKUj4371/LAv4Mc5R/7YwJOS
         AT4goBouIMKjt5we+GFMY7kV7yH6XDhpCeuWDMORsAjkEcUqhD1QiMtApztujmZ0PrMW
         wJig==
X-Gm-Message-State: APjAAAXvKGplnQuQCvzQv3z8IWeoK9eGgJH9HfSKSzp8StzM2XYnSsCV
        DLldGaMPYW0elkRXUwqumwk5R3M3/U8=
X-Google-Smtp-Source: APXvYqw6XdUNQ0RXOd1pfhoDDK9p3Vyb4hkS350BapTjgXNBdNZUjaEbvi8y95fIiESSALHKjqZNxw==
X-Received: by 2002:a17:902:581:: with SMTP id f1mr18686486plf.246.1567220644017;
        Fri, 30 Aug 2019 20:04:04 -0700 (PDT)
Received: from localhost (g75.222-224-160.ppp.wakwak.ne.jp. [222.224.160.75])
        by smtp.gmail.com with ESMTPSA id i9sm5647305pgg.38.2019.08.30.20.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 20:04:03 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>
Subject: [PATCH 0/2] OpenRISC ethoc device tree fixes
Date:   Sat, 31 Aug 2019 12:03:46 +0900
Message-Id: <20190831030348.6920-1-shorne@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix up and add ethoc device support to the OpenRISC device tree
definitions.  These have been confirmed to work with qemu and can be tested as
described on the qemu wiki:

  https://wiki.qemu.org/Documentation/Platforms/OpenRISC

I plan to submit during the 5.4 merge window.

Stafford Horne (2):
  or1k: dts: Fix ethoc network configuration in or1ksim devicetree
  or1k: dts: Add ethoc device to SMP devicetree

 arch/openrisc/boot/dts/or1ksim.dts    | 5 +++--
 arch/openrisc/boot/dts/simple_smp.dts | 6 ++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.21.0

