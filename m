Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D02EC23A54
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 16:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391703AbfETOiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 10:38:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34061 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732877AbfETOiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:38:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so90502wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPErLrIi2TqGTXmqPusukwp+5dK1tRC/mOkp9SybAko=;
        b=LKmA84tLspOC3dfQvPmPXP4G3MGwvU9fFL1Qw8krD5TnvhXLlsPrBYz4SDv+771req
         tZ28MfmFpF8aV+qH22r9G89LNY7z/5BM8vRbLyxq0unrjvsEZSNLjaZJIcamsElvr9Wi
         7v0Atn04/0XH5KhhL1WTm9fJ8NhpFRiL6x55i0VHCM+zaEt24js9GiijnKCIhGhD7Kmx
         aR3ZcZpV071XAM8c1vPLxbF2H2l+AJ2Qg9CYRJMJYdh3QPOEV2ld6DDP6+314na/6TzE
         Bt2ZjVKD0nV80O3y29GEi2CpaajMEAFCw3U/suvT1vDxiYh0Z8oVdOuKvyre+1Cu6zz1
         r2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPErLrIi2TqGTXmqPusukwp+5dK1tRC/mOkp9SybAko=;
        b=DnX4IaxT3yTHOeIngccG0/+BUBfz2XZdm4EGFn/5niWHcG6gj7A4ktDDw837szLf6g
         9RrMp+3GkNTUy4qsFYoRFzoyyaaHok/Ol/CZwYQU8RNcwhRpMD1wNCgQWu0kYgZ+eZ7e
         kO92kHJpa/FcUOvDySTTa9u4H4CD4Hl2of14W3Yqohd0nNAPD2oP1Mhqi6M/KqBm5/Wj
         tsw49XCPLhDIjEusV+e+Tpj30QrjG7zBn9eL62oprVc9Hi1HuEOwAb5I10frd+J2Ws7c
         0wlzeYDuQJrFcYqpJ/uy5dyV+Pred6PnIkSw+4CQdFB+KGhmxkWQHgQHb8ls7uFCeQ0d
         ydxA==
X-Gm-Message-State: APjAAAXdSfgAWhS9ZMai+/Y2f9p1CSvEh50N/P0EUG5Ewwd/+vELBwZ4
        nFbTJh/MaBajJ7XcfWRGtDlLhw==
X-Google-Smtp-Source: APXvYqzqGlMUt7XMKaF9kFn8qoRcnhBeXJcmp0cRColc1Kpm2osu1wfI5WPOgJXKJ0djYeIX+7dboQ==
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr5582854wmh.96.1558363094267;
        Mon, 20 May 2019 07:38:14 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y4sm12505976wmj.20.2019.05.20.07.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:38:13 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 00/10] ARM: meson: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:38:02 +0200
Message-Id: <20190520143812.2801-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the SPDX Licence identifier for the Amlogic DT and mach-meson
files.

Neil Armstrong (10):
  ARM: dts: meson: update with SPDX Licence identifier
  ARM: dts: meson6-atv1200: update with SPDX Licence identifier
  ARM: dts: meson6: update with SPDX Licence identifier
  ARM: dts: meson8-minix-neo-x8: update with SPDX Licence identifier
  ARM: dts: meson8: update with SPDX Licence identifier
  ARM: dts: meson8b-mxq: update with SPDX Licence identifier
  ARM: dts: meson8b-odroidc1: update with SPDX Licence identifier
  ARM: dts: meson8b: update with SPDX Licence identifier
  ARM: debug: meson.S: update with SPDX Licence identifier
  ARM: mach-meson: update with SPDX Licence identifier

 arch/arm/boot/dts/meson.dtsi              | 44 +----------------------
 arch/arm/boot/dts/meson6-atv1200.dts      | 44 +----------------------
 arch/arm/boot/dts/meson6.dtsi             | 44 +----------------------
 arch/arm/boot/dts/meson8-minix-neo-x8.dts | 39 +-------------------
 arch/arm/boot/dts/meson8.dtsi             | 42 +---------------------
 arch/arm/boot/dts/meson8b-mxq.dts         | 42 +---------------------
 arch/arm/boot/dts/meson8b-odroidc1.dts    | 42 +---------------------
 arch/arm/boot/dts/meson8b.dtsi            | 42 +---------------------
 arch/arm/include/debug/meson.S            |  5 +--
 arch/arm/mach-meson/meson.c               | 12 +------
 10 files changed, 10 insertions(+), 346 deletions(-)

-- 
2.21.0

