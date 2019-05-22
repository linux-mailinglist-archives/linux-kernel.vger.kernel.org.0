Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0D425BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 03:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfEVB0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 21:26:48 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:44226 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbfEVB0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 21:26:48 -0400
Received: by mail-pg1-f171.google.com with SMTP id n2so399033pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 18:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XzkZpLUXOKW7m6+mZ2WcIQDMuFvLDmkmvdyAaZy5wu0=;
        b=oFH7pGT17S+xMx8HG3afPL2D5gRK+wpsgupbtM9RSGc6A42rw+I+EDo+N8/CqTI7EZ
         uXpY0tObv9H7bswn4azKL+PSf9E5vgl5x5lMxN9fWIZognqP7NCHkyqnC5kdpCId6h6W
         X7/k0veibbbrV5Wl7/8Trcg+gOr87y0rBAP+FMOMMb6UOQhE78WJnNr3kQ4efJAMaRns
         JrUgDESLmKAbXV1h1hHhUo1QRVvq+tPUGOlGtw8mC+8OxhbK2wSIa1GYQ60h6H59DpMn
         0PPLGYuMyu5s0vxISfp6nsnb64I1eeRLMqcfx4E5pEM8tyd7GCkp69O9ozLnyeRM4PEb
         Qc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XzkZpLUXOKW7m6+mZ2WcIQDMuFvLDmkmvdyAaZy5wu0=;
        b=iOfQp17qCk9ic97HcsTiy4RdChzAQM4xLEcEcDFGo6/yBV9HVp8RZ2Boe3I1BROMRo
         jNtcndV7CLPsU8cTKOlxAp5tkVY7hcbtniYq4NeNYssldvaEISn9JA+Ps/zoZxUtXY2z
         6PFJVygydlSIS/HbA++s4e2JEJw1QpEuARZp6nkUOlQug1i2YrbhZx0lcSyMNEgEdWmy
         cVzPveeFglT14MM4Q2fWDWiFBHwjSGHwK5oxS/KhFP7TL16+ZT03/tDq3dPYPOVHFEHQ
         NmOUZUN+ryiPLrmBqp7MLJEl/mU5KvC4KeMw7eNWlSQGr1I8kd2mV6D9RJrnUGFKDJTd
         Njhw==
X-Gm-Message-State: APjAAAUqIBliaXj3Cp2NKHA8g6UO+KPZMXuwC0xk2M57d2l7XdY1vKGm
        8hyKkEn/l3W3YmbXA5natIEMog==
X-Google-Smtp-Source: APXvYqzdlFW/NK7EZH++8V24vCPikB705TpZHx+gJUVw9LaQBV4dYBXdDOh0OIbz1I96qLodf0EVhQ==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr21977722pgq.399.1558488407887;
        Tue, 21 May 2019 18:26:47 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g17sm14562071pfb.56.2019.05.21.18.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 18:26:47 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 0/3] Return immediately if sprd_clk_regmap_init() fails
Date:   Wed, 22 May 2019 09:26:40 +0800
Message-Id: <20190522012640.19910-1-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522011504.19342-1-zhang.chunyan@linaro.org>
References: <20190522011504.19342-1-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function sprd_clk_regmap_init() doesn't always return success,
drivers should return immediately when it fails rather than
continue the clock initialization.

The patch 1/3 in this set switchs to use devm_ioremap_resources()
instead of of_iomap(), that will make caller programs more simple.

Changes from V1:
- Split out the patch 2/3 from 1/2 of the first version;
- Added reviewed-by from Baolin.

Chunyan Zhang (3):
  clk: sprd: Switch from of_iomap() to devm_ioremap_resource()
  clk: sprd: Check error only for devm_regmap_init_mmio()
  clk: sprd: Add check the return value of sprd_clk_regmap_init()

 drivers/clk/sprd/common.c     | 9 +++++++--
 drivers/clk/sprd/sc9860-clk.c | 4 +++-
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.17.1

