Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19E109BC7C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 10:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfHXIFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 04:05:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41484 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfHXIFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 04:05:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id j16so10579947wrr.8;
        Sat, 24 Aug 2019 01:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QxuDzkK00aaOAlXF/Oj/CO+qrmGUaqzzWbuNX1BI4gs=;
        b=p+deEbblvZep63OJ0tg1ZKNocoHPtca5rUFwIcNYqjzJQ6fz3J4MFZx1TfRKM9Zquo
         puHSAqkeniym3CgmDQJk+r12Tz8UNQL3FWo/qhM9DEHEfb1UDSyvVOcnczXcMEt5KOLf
         ByK6/vbFyNUoGTF7qjLR0fwX2f3oAgmxLhqeP69pGoFB/49Oq/GVgNzJ8aeV1PyjeiQ1
         KbBySZ7q6CLmlCHrfsnW1tIBF1PgjAtRBb4pvOPlvY/jrjbin6F303vdKv2wYHb1GaNU
         v42PuoVnuVo3fA6TG5+fNl3ocDAjOGiVPgyqXVUCS71tZX63lshDW1iGT0pnDUPXV8Bv
         52xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QxuDzkK00aaOAlXF/Oj/CO+qrmGUaqzzWbuNX1BI4gs=;
        b=BqsR4z6dDqsiQOtDIQfOh9d+3pwA32Hrdtnbw5OG8Ms0xwz8iMrxlOwc3g+MN+OTWJ
         GJpGcZJOaUfIFs5ZAqnNPoEmBVKXOzB2btZWGQ3kCLw3DyxziBkGhgV/Lazil2T1Zx5Q
         FMtxTDWHGrWXVxWxVudyTsgrReqH9kfodtIIXipPrbDX2akqevBbVizmpjG5ZbK5puug
         8j7ReTJGURlrcJHx/PtyhJ+sHq9NBw44Tfu+gzaX3pnQww893JRxb36JwMM3htXANHrN
         ccaom//ewjuRHDLtOg4Wlaq/poxpgva6fmE6EX/zSrpH+WcISieGYWddNtkHV0XfyI5s
         XHqQ==
X-Gm-Message-State: APjAAAU4JT1PTJuw16oJ90XHpWmCjnYHvwjCp+yj1dQzRHjpQ3qFbQ/7
        LmLJ952WBKnvLapO0p0LJXM=
X-Google-Smtp-Source: APXvYqwWknuBhaNc3FSges1Tbji5oWqWhpZ+K1p772146QPQkalYEinGlEhMb/GbaP5Fuxtfph/2+w==
X-Received: by 2002:adf:ecc3:: with SMTP id s3mr9944795wro.302.1566633900177;
        Sat, 24 Aug 2019 01:05:00 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id w8sm16615656wmc.1.2019.08.24.01.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Aug 2019 01:04:59 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>,
        Oleg Ivanov <balbes-150@yandex.ru>
Subject: [PATCH v2,0/3] arm64: meson-g12b: Add support for the Ugoos AM6
Date:   Sat, 24 Aug 2019 12:04:07 +0400
Message-Id: <1566633850-9421-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the Ugoos AM6, an Android STB based on
the Amlogic W400 reference design with the S922X chipset.

v2: correction of minor nits

Christian Hewitt (3):
  dt-bindings: arm: amlogic: Add support for the Ugoos AM6
  dt-bindings: Add vendor prefix for Ugoos
  arm64: dts: meson-g12b-ugoos-am6: add initial device-tree

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts      | 567 +++++++++++++++++++++
 4 files changed, 571 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts

-- 
2.7.4

