Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8316C7544E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 18:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389793AbfGYQlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 12:41:47 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:44115 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389434AbfGYQlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:41:46 -0400
Received: by mail-wr1-f41.google.com with SMTP id p17so51461699wrf.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=k3owj89F9XfdBkrf47dCANR14zVA50NeVSBAUPPeOPs=;
        b=umW0sPsijyVEs9DewxFfVmBnd2sgqpy2A5TDYly45YOZVg+e6lcZGkAsggcArbEi1o
         he4Cg9YBfldmG3hxvat9Naz2uLBE/pRRenuCA6Kddum/X3DPqXkdn999wFqDb0gQ8mnN
         1nQQ12cfttNg0NMX4LGYQ3ejD4bJj67nWPOE9qXxn9eF5otUBqDmqJCFRCxrHQWl7Ufw
         xkRiVOQGhCkI0hiOWyMYBbxltt2IuBW1XihVA42EoN0IcVTYgBAo9qoOydRjP3QvUT9E
         p8mGmfrJ931/M+hbgxFfqwEdwflDVYx7cH1S9yqiydezGJxgIv7bLVg961Cd+y8BySES
         k3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k3owj89F9XfdBkrf47dCANR14zVA50NeVSBAUPPeOPs=;
        b=i0f4RPvcS6FVDRJYZ9vlXX+6n1qZv/S+vk6Lv4u2CTt/XebcWDB+0rqnkGBACNiZ6R
         XclQtOR88w+PNoN/Z//953fJMzJlpj8O0h0n8jkRrYJdnnqt/V4MqstbK1aoY1gytNLX
         z3OEULIr2djOSTJ3PldVTMGW3iwnJSO/fJmYeyElSlZgVXc5Q8gOldmJVUGf9STJ0PcK
         6EAKJI72xoGs85bTmTtZfDFewKuXIq0hnN9N+kYCWghVwJPmVV4VUELJy3cHVsKt0Gsx
         QtgmvDVK1SDnCtTwsOO4N6U3sdxwpj0N/q9YQTxOzeoOzVlLc3j9qZf3iMLon8vCk0/k
         HgGA==
X-Gm-Message-State: APjAAAWzpOCrmGIjfREdVotwbcsnzZPGHaKKGaT7OXnt3Fsgb5dqRzP3
        Vxj4S/jksc4uG7vBOEOzZbiI1EFqwag=
X-Google-Smtp-Source: APXvYqz7o0o69gasiQIG+rfUkpDkVoXb5hycjwGXWhYjF6LgNk/JI9765FCz1bEwLJOV1/QXnPsxmQ==
X-Received: by 2002:a5d:5448:: with SMTP id w8mr95321121wrv.180.1564072904380;
        Thu, 25 Jul 2019 09:41:44 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id y16sm102488858wrg.85.2019.07.25.09.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:41:43 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 0/4] clk: meson: ao: use the new parent description method
Date:   Thu, 25 Jul 2019 18:41:22 +0200
Message-Id: <20190725164126.27919-1-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meson SoCs clock controllers use the string comparison method to describe
parent relation between the clocks, which is not optimized.

Its also use bypass clock made from device-tree clock to provide an input
clock which can be access through global name, but it still not optimal.

A recent patch [0] allows parents to be directly specified with
device-tree clock name or without string names from localy declared clocks.

This patchset replaces clock string names by clock pointers (as possible),
removes bypass clocks and uses directly device-tree clock names in parent
assignment.

Tested on GXL, GXBB, Meson8b, AXG SoCs by comparing the clock summary
(orphan too) before and after migration.

[0] commit fc0c209c147f ("clk: Allow parents to be specified without string names")

Change since v1:
- Improve clock parent assignment for "fixme" using name instead of fw_name.

Alexandre Mergnat (4):
  clk: meson: g12a-aoclk: migrate to the new parent description method
  clk: meson: gxbb-aoclk: migrate to the new parent description method
  clk: meson: axg-aoclk: migrate to the new parent description method
  clk: meson: remove ao input bypass clocks

 drivers/clk/meson/Kconfig       |  1 -
 drivers/clk/meson/axg-aoclk.c   | 63 ++++++++++++++-----------
 drivers/clk/meson/g12a-aoclk.c  | 81 ++++++++++++++++++++-------------
 drivers/clk/meson/gxbb-aoclk.c  | 55 +++++++++++-----------
 drivers/clk/meson/meson-aoclk.c | 37 ---------------
 drivers/clk/meson/meson-aoclk.h |  8 ----
 6 files changed, 114 insertions(+), 131 deletions(-)

-- 
2.17.1

