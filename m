Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF2CA2102
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 18:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfH2Qgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 12:36:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46174 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfH2Qgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:36:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so2779091wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N+c0qA0XM3CJtKzSOyldE7zb5NKzBbtoCRXB4ExOIbU=;
        b=ILi2D94OAOQwwctQJ3w2ApbF1WkWInktVYqIS55gOb8Ugdl0wE1ny8VP9sSvWelKlX
         hlZrFOecE0RCikC+Hr0LnSzMXqUQrhmMHQ6gWvFPDtIOfSec8yagELdOWLrI9QJE7ITW
         I8n7kp71OEqALz6VefXsWjdvQICRVkrq9TpNOYbmIYWIJiTysdeOwGc5/n4I4EIJJp14
         3qgN1gNIibA+7B3ls4IaUhmPxTj/RnwzRy5nzdO6YKsAEt+AzzYSjQRtKN2Zxb9/b30m
         PvMtJ3Wmpovn6Sf5JixDwUQahojbgiQIESTmVF9vnP6UVP5EwgJjTpHWiCid2hf9c66O
         u2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N+c0qA0XM3CJtKzSOyldE7zb5NKzBbtoCRXB4ExOIbU=;
        b=tUca2GPQdli6QWbuuo77zr+TvSvKwJFrGjQt7xzLbqKkaiZBXTzPhFJ/ld1iy747e1
         pZNexLgRbsjlLAG1P4HJen5EunWco9JYWAnDnhBh0WG8NZE7YqLsLPfvP7Ok5T+GKEq7
         9HodpEnhE+mWJsCyRXT+gBmQrWhGxIswRVTcBw79A4SG3itrHP7BDvFxzSXU/ben4z53
         kKzOOrWU9pKMDtQyiSHJWxD2yhTMiPYeo+f+uZqR7EaliNz1k2gzj6vGhSz8VHHKFmIu
         93sD3vIPWD65mmJPnLgsPXLufXgxhwjuvDnqOxZGqT4jgYz+KOAacEEDMN27kbZeTojn
         HbYg==
X-Gm-Message-State: APjAAAXP8Cx1dVeqjbNEy2MWmYEq+m/Dw2jCVP5cSiCmbONLgOq40D5H
        dEub5friVeS6um4fMcwriZUNww==
X-Google-Smtp-Source: APXvYqycd8fi72Kcd8HMVvxvRzc0dAVNmyoMC+kJmLPG7uQ3k/lN/mNd0JQBtiMLUhXA93Y8EAKJAA==
X-Received: by 2002:a5d:5343:: with SMTP id t3mr12508573wrv.156.1567096595281;
        Thu, 29 Aug 2019 09:36:35 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id k9sm4398243wrq.15.2019.08.29.09.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 09:36:34 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     spapothi@codeaurora.org, bgoswami@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 0/4] ASoC: codecs: Add WSA881x Smart Speaker amplifier support
Date:   Thu, 29 Aug 2019 17:35:10 +0100
Message-Id: <20190829163514.11221-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support to WSA8810/WSA8815 Class-D Smart Speaker
Amplifier which is SoundWire interfaced.
This also adds support to some missing bits in SoundWire bus layer like
Device Tree support.

This patchset along with DB845c machine driver and WCD934x codec driver
has been tested on SDM845 SoC based DragonBoard DB845c with two
WSA8810 speakers.

Most of the code in this driver is rework of Qualcomm downstream drivers
used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.

TODO:
        Add thermal sensor support in WSA881x.

Thanks,
srini

Changes since v5:
 - updated slave bindings with proper licencing and fixed up examples.

Srinivas Kandagatla (4):
  dt-bindings: soundwire: add slave bindings
  soundwire: core: add device tree support for slave devices
  dt-bindings: ASoC: Add WSA881x bindings
  ASoC: codecs: add wsa881x amplifier support

 .../bindings/sound/qcom,wsa881x.yaml          |   62 +
 .../soundwire/soundwire-controller.yaml       |   82 ++
 drivers/soundwire/bus.c                       |    2 +
 drivers/soundwire/bus.h                       |    1 +
 drivers/soundwire/slave.c                     |   52 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wsa881x.c                    | 1134 +++++++++++++++++
 8 files changed, 1345 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
 create mode 100644 Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
 create mode 100644 sound/soc/codecs/wsa881x.c

-- 
2.21.0

