Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D27D44A7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 17:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfJKPot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 11:44:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38592 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfJKPot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:44:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id y18so3005148wrn.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvfCxVclTy6ShzV/vDD4x14oYnHfjCHog9kicmW4dcM=;
        b=UxN1NFTc47siaqQofM9vtgi+trRicCmJOy0vprOyEv1qhi6BHxkXaXA/2b02UUh0Mt
         tYwxRkBK3tE71JJtISGt0m4royxB+4o9x4Ox7RcFiGh7LiLzT84IO7z7ffGNgReKWtMN
         3dcMaxEYTuD7fkjQVVooBjt6JISkUED3abo8L3H9cmGjoJRYFNybplWC2k084IPjGXoX
         oQomlBvIjM750TSEz/ulYnH/4UfIOrIdO5J1jQ37XGH7iweoklsJmMppGms98b7AZmd2
         Mnu/2UgrZN9E0vfDmsuUOltT7ZfEFo7tkwWKfQJ7XenrOSe8GnLqG1lC7KR8P1gQeDHH
         5p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvfCxVclTy6ShzV/vDD4x14oYnHfjCHog9kicmW4dcM=;
        b=Py6xxQrgMjhMdwmMCo+C19ZQOiH2z/SqKe2JA2UrkqOPXkVVir/a1wQ421LzOZsqta
         AWuFlucLhKm0WKnNKDpiJvAb1c6kFbJyqG5FeP2mxMgOVKg9ynkmzjrE00c5yiCx+n1N
         xztx+Meys22ET9sNqJ3hMZAEOUJ4YQsAme7el07poF6JPbmy+VexIwdXQh6tLo2eYwgc
         N8dwIk8GatHJI+z+rqF6UpWF7X+ZLdc30XloJbvteiK2fMPripflV3F5irzi5j/4cE84
         LMTMkVwdg2XGr2RkF1Kl+CKhkQJnEzd5Akf984P7solDpPHxC1nRNrH56rqWTwPRboPK
         1wxQ==
X-Gm-Message-State: APjAAAWwZMdSZmVCyXUBbxYFVH3gNAwR97oSKvVeEskM5X1gE+Vbw9pb
        f2CNgmQpbZES98+jxct0KiYHxg==
X-Google-Smtp-Source: APXvYqwIhb0tYcjlG6emnKIqHFasuJrequA13bxaiRFpYFxvsgNTAQ0iUDkvvpWFO/LV54MurBnajQ==
X-Received: by 2002:adf:e646:: with SMTP id b6mr13267380wrn.373.1570808686953;
        Fri, 11 Oct 2019 08:44:46 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id y3sm3453044wro.36.2019.10.11.08.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 08:44:46 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh@kernel.org, vkoul@kernel.org
Cc:     broonie@kernel.org, bgoswami@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/2] soundwire: Add support to Qualcomm SoundWire master
Date:   Fri, 11 Oct 2019 16:44:21 +0100
Message-Id: <20191011154423.2506-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing the v2 patchset.
Here is new patchset addressing all the comments from v2

This patchset adds support for Qualcomm SoundWire Master Controller
found in most of Qualcomm SoCs and WCD audio codecs.

This driver along with WCD934x codec and WSA881x Class-D Smart Speaker
Amplifier drivers is tested on on DragonBoard DB845c based of SDM845
SoC and Lenovo YOGA C630 Laptop based on SDM850.

SoundWire controller on SDM845 is integrated in WCD934x audio codec via
SlimBus interface.

Currently this driver is very minimal and only supports PDM.

Most of the code in this driver is rework of Qualcomm downstream drivers
used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.

TODO:
	Test and add PCM support.

Thanks,
srini

Changes since v2:
- Added support to set_sdw_stream

Srinivas Kandagatla (2):
  dt-bindings: soundwire: add bindings for Qcom controller
  soundwire: qcom: add support for SoundWire controller

 .../bindings/soundwire/qcom,sdw.txt           | 167 ++++
 drivers/soundwire/Kconfig                     |   9 +
 drivers/soundwire/Makefile                    |   4 +
 drivers/soundwire/qcom.c                      | 935 ++++++++++++++++++
 4 files changed, 1115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
 create mode 100644 drivers/soundwire/qcom.c

-- 
2.21.0

