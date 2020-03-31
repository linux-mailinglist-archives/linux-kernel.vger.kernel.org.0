Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC4CC19A109
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 23:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgCaVpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 17:45:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42753 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgCaVpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:45:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id s13so7470684lfb.9;
        Tue, 31 Mar 2020 14:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lu4NmQIheqOb4fNgKBK5hseC1xsQyAK34HxW6ZLtH+k=;
        b=M3xPolKxnqJc2kG0dRRqVsoGTMVc530sLxrd1bYJU3VBgSa73NuFCr4YptJNFLPxGk
         QHAMsLrBfqwNvH4w3n+a3RT2nEnom0La607m5I/88oLLz/azYZuS5UQ9SNQ9VO4XgetG
         bOAgep5Stx+9358WFfQ/VHcmb75OwSWxy0BySH01rHrM21JuKcV3TJrFYmAvDK1+0Ljj
         ixK/PaIsWe56mnHNHJ9SkvE5YrOpWnXYcaQEG2go2O0HQ0Y6+lUjU1fv70IWi8wm5KRh
         50VZjxhwkFrBb1rUA/hbfCKKNM1VYkM2AYBL2aqPrcWxgyRFUmYc+kO2gfpfM9HpnADw
         +Ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lu4NmQIheqOb4fNgKBK5hseC1xsQyAK34HxW6ZLtH+k=;
        b=m44folDyy+rOrm2pEo4ppDlLLEBQYkcbe9we1p25LTqfcSGs0Jc2ml4iDQrbDqnW3m
         BLLCjsDlxtjhStEDYTDBezK3cwTmfZPtI7A78xfB3iSdE/VJmTXB76TpJHlA1sISc+u/
         00PiWRfMlX5GQNDMotuBQBgEiLIE/bFw6ymOQDwFUFwjtUUvPEhysMeb00sZyQFXQi2X
         KTeyHWgVGY8KNLST+nSFuZyFJpKEDeIaGXYB+JTXy6KBaG8sXFpOLqB4lU26MvoSENlb
         Lz6r6mjKUo9LuDDRN5pNPl/HPvuWUaJe/QbquNuad7UB1iCwcXg/Ogf9Czf4IihIWnd7
         Fxhg==
X-Gm-Message-State: AGi0PuaOQENF/eoKl0R84qj2Df6LWhZhWZF/S26wHhVw6HaZ/Uet53+H
        QgfJQ9LEZ9B4IAayme9P3dI=
X-Google-Smtp-Source: APiQypLr14dB3iv3cftOawtG+8I8jschkuiqmaqV8m8xPs6jesWKJm6n41f1RDl4PtiYgsxd4JDVUQ==
X-Received: by 2002:a19:ad43:: with SMTP id s3mr12821715lfd.63.1585691119177;
        Tue, 31 Mar 2020 14:45:19 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id a4sm3757826ljb.27.2020.03.31.14.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:45:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Pedro=20=C3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/6] Support NVIDIA Tegra-based Acer A500 and Nexus 7 devices
Date:   Wed,  1 Apr 2020 00:43:21 +0300
Message-Id: <20200331214327.6496-1-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series introduces upstream kernel support for Acer Iconia Tab A500
and ASUS Google Nexus 7 tablet devices. Please review and apply, thanks
in advance.

Dmitry Osipenko (6):
  ARM: tegra: Add device-tree for Acer Iconia Tab A500
  ARM: tegra: Add device-tree for ASUS Google Nexus 7
  dt-bindings: Add vendor prefix for Acer Inc.
  dt-bindings: ARM: tegra: Add Acer Iconia Tab A500
  dt-bindings: ARM: tegra: Add ASUS Google Nexus 7
  ARM: tegra_defconfig: Enable options useful for Nexus 7 and Acer A500

 .../devicetree/bindings/arm/tegra.yaml        |   10 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 arch/arm/boot/dts/Makefile                    |    3 +
 .../boot/dts/tegra20-acer-a500-picasso.dts    | 1444 +++++++++
 .../tegra30-asus-nexus7-grouper-common.dtsi   | 2646 +++++++++++++++++
 .../boot/dts/tegra30-asus-nexus7-grouper.dts  |  463 +++
 .../boot/dts/tegra30-asus-nexus7-tilapia.dts  |  549 ++++
 arch/arm/configs/tegra_defconfig              |   28 +
 8 files changed, 5145 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dts

-- 
2.25.1

