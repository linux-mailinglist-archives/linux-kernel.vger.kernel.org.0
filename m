Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D90F9AA509
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 15:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbfIENuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 09:50:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42587 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731008AbfIENuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:50:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id q14so2865155wrm.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1rlOPeLcbrRYEui8i9Tv2ctLK7V5CEAitRoX5kcoRck=;
        b=Xq0Jn089ydtJsmFLStgJLjVq3WswCL5UIpIOZ0LDXluME1UCmRXmBC68TkxXDRaJnV
         Feyr3rChqjvQg1lEGsJl9FXQTG/Rznk0Cs++p0i7y+Lk+HmsvREF27u87db59hGqB67y
         s8XO4DYzKKp0xv05+aa9kg9HyZbbeD7OZokjXBOepQryeiHAGzrMbRAp1XJsNZYogxWR
         AVAadTBzo2m4PVmZIOVQDbifmFE86AZxXtt7Pu/z0AWDsfzwWE78G22hk+gg7XbeM+pH
         +J9cJRCAHCm/YB0TjmLljYuLgo9pkGB+VDRpnkV5nQGUlQg4cN/hY502blTPJgooopIP
         ssWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1rlOPeLcbrRYEui8i9Tv2ctLK7V5CEAitRoX5kcoRck=;
        b=irq38UvdyojZqzn+39FzQPUsnnJKvSScAtnxM1DtVUtM1qUXLQv5BM1fz95vPQScjx
         jCXd7HwOPjlUNCWKwMJzghMAVG7NSqH/NtQGHciFMoY8npz+GWursIA1UkicWP5KbuVc
         0KjxY6P9v9zLodY0zsfAKfOUdsBU14ACt2edq3L02VuFPg0Rn/+KvtInHKgEfzmzgA9+
         rC0yqr0+1x57tB1KA6Cel5hJa+pknfpQgYCwwOs/Q/OJG1jvmNT29B1bq3SPZLkPz7GB
         kDFRH6Z3FbVeM8VkO+cHyYdTnwsaPhNvTrUKqD6CxezMBI9vxb4oZ5WlffktlNweLiNo
         y7Sw==
X-Gm-Message-State: APjAAAWkT7j2wY6d2A1OR0uFf7fJekORzCZc6/eeQ+k2fl6/Rfw4Cxd3
        MLx+AAMTand3V013OMSP+K3EZw==
X-Google-Smtp-Source: APXvYqz1xEzk+JkowkEJrdXuXLrDLz0HPwzvqc1On9o10nh3kf0nJpBrTSnQbBG1GEQp6hTs1L65Pg==
X-Received: by 2002:adf:e591:: with SMTP id l17mr1918869wrm.199.1567691444242;
        Thu, 05 Sep 2019 06:50:44 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id y3sm3324893wra.88.2019.09.05.06.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 06:50:43 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] reset: meson-audio-arb: add sm1 support
Date:   Thu,  5 Sep 2019 15:50:38 +0200
Message-Id: <20190905135040.6635-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the new arb reset lines for the sm1 SoC family
It has been tested on the sei610 platform.

Changes since v1 [0]:
* Fix the mistake on the number of reset as reported by Phililpp (thx)

[0]:  https://lkml.kernel.org/r/20190820094625.13455-1-jbrunet@baylibre.com

Jerome Brunet (2):
  reset: dt-bindings: meson: update arb bindings for sm1
  reset: meson-audio-arb: add sm1 support

 .../reset/amlogic,meson-axg-audio-arb.txt     |  3 +-
 drivers/reset/reset-meson-audio-arb.c         | 43 +++++++++++++++++--
 .../reset/amlogic,meson-axg-audio-arb.h       |  2 +
 3 files changed, 44 insertions(+), 4 deletions(-)

-- 
2.21.0

