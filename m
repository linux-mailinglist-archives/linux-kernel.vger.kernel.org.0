Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D397519C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 19:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732594AbfFXRkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 13:40:41 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:45470 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfFXRkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:40:40 -0400
Received: by mail-ed1-f45.google.com with SMTP id a14so22881660edv.12;
        Mon, 24 Jun 2019 10:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YEf44NckoojchV2t803u1KHUvq5MtxaQriFFSpdRzc8=;
        b=oaN9PGk/uGPEzPIKcQE/tKUFOPtzzpCaazbg6IBD1A6C2l1BpibdzGm0N/mUBAO5qV
         7wda1EyVdHlqnsEv2ugqYDYsDcvOt8n2FCGqjeCYkdgELUUgJh97DqV2El7Vz7h151Sa
         CgPiIV6AYhOQC3/tJn+wn+3ny02yAbkLZL+2KPmeD+c6P/OCqCSqfjy2OIT4YtiXeNSk
         34/HRpClj8rrlLMs/z9RlAB6zaAPOB19ZA+Wtw2EkjnlTMKn1DhiR0fM4hBDEgHewf2o
         +5dQvhX8f/KmcKiTtG9FAP08X5MBG0JppLqRclVqt+zfN54cs50PaqGC4GTwmuiKMfsa
         Mh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YEf44NckoojchV2t803u1KHUvq5MtxaQriFFSpdRzc8=;
        b=jKf+0J8e3M8hXB2TLupc4xX+8NjLTrntTxXKb/0zaqx4I5bK2xmg7W375BBUIOUpk7
         T59Tug9MbMDDgbuTiGYOKRaZcCETRIyhxFjkkMXdgAakNL0ND/F9XB1BVIZsFES1fmbb
         eLQ3MbycGDycPt3wNQ0j/jEJY1ZV/kQb8sUZiBIPk8NlJORJfz6rAGbSITfVICIF+jVU
         7ORpom6lFA//BHYHhGBG1PBwn1k4R8075fW3HjZiSoZ8La2gpi6tMHYlXtX19wWyoAZO
         UVcs/cM7tjcipmsb4yRBPDXEW7avwJnqGHJ3vFW0MCe+dg6K57cQaU2DZXXY1SfaPUSB
         eV4Q==
X-Gm-Message-State: APjAAAVQON54KPV7HsxYp77w+MK97wX34zrRck/ykEdk3WqxfAlxbDen
        wJcv8HoJvg5DiM91+b+5RWw=
X-Google-Smtp-Source: APXvYqztEpKwQn+ta3o3Tu+kPfn4EvkAYUI6Xwu0TggpiOoJ9fdGSV3MxncuSSJzGZi6cEYgUjoeSw==
X-Received: by 2002:a50:9846:: with SMTP id h6mr109519938edb.263.1561398038772;
        Mon, 24 Jun 2019 10:40:38 -0700 (PDT)
Received: from localhost (ip1f10d6e1.dynamic.kabel-deutschland.de. [31.16.214.225])
        by smtp.gmail.com with ESMTPSA id d23sm1311595ejj.50.2019.06.24.10.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 10:40:37 -0700 (PDT)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     oliver.graute@gmail.com
Cc:     narmstrong@baylibre.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv4 0/2] Variscite DART-6UL SoM support
Date:   Mon, 24 Jun 2019 19:40:11 +0200
Message-Id: <1561398017-10548-1-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need feedback to the following patches which adds support for a DART-6UL Board

Need feedback howto document propertys and compatible the right way

Product Page: https://www.variscite.com/product/evaluation-kits/dart-6ul-kits

Oliver Graute (2):
  ARM: dts: imx6ul: Add Variscite DART-6UL SoM support
  ARM: dts: Add support for i.MX6 UltraLite DART Variscite Customboard

 arch/arm/boot/dts/Makefile                         |   1 +
 .../boot/dts/imx6ul-imx6ull-var-dart-common.dtsi   | 458 +++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts    | 203 +++++++++
 3 files changed, 662 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts

-- 
2.7.4

