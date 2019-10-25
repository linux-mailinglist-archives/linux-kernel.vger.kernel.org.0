Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15549E5291
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 19:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfJYRvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 13:51:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43543 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfJYRvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:51:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id 3so2038035pfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0u0Pm2MaDUwplKmc1bNNC1kj7B+w8FbdiY927/v2PRE=;
        b=fB1gL4Q10Ah/2YfT9z2if2xKcCXqbQhWuRT7CMJRE6ePg7WD7AuVGYlwOsjXOsAUzI
         QBmebtaHd9bpyAzwmy9Vo2nJuiKX/ElyqnYPFm0zrnM1ALkwlUpJE2bjwz7ue/pEMMX5
         jgbQC10zmfRF7xSc/IjDNXBsRya5lmu2+FMvU7tVut7kfSlkPNhjK7zMghJdljWQDN3r
         V60DmjicYEjFxDbfU5ZA6yINx8M9/bRCNl6aymRsB8jIFbYnqtBHGvjLM3Ox/nISEOBk
         EbEyeqUHPz7g3h5OSUMcbq6ZlqiJx6w6vp0PwlpoutOjsqoHMkeeJMZnyQQ/1YLf94DM
         AVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0u0Pm2MaDUwplKmc1bNNC1kj7B+w8FbdiY927/v2PRE=;
        b=lc6DSlsGH4VgXMgxJGzVousnGgapCkiViAUKdbMVmOgMSGp4FKXhYV6nnLdFhJW2Dl
         uyKnJZWzGGLQ6vR7JdewKy2acLmoIq8mXy3F3ytSrIpuwvmOzE2kiIcTTcm166SI0/Jh
         pz4iVlFE5HxladeZ2z44WnhWiHVeXDavjRpDFov1MCXKH974Ken3JdUv3mJQmwQJa4U1
         BVHhNq9hMYO0/l8f2Q01iHbtf7sJwfTtib/0ATM3QKwXEHUdJMCnGH8/Vf0qfOmSdXm+
         sNoZa5ZAgb8WSUGfh4XvXX+EiLCaJ0zhSV/jSgV78E1L07mp+iRnFoOTjEgY0KgKm95A
         9U9Q==
X-Gm-Message-State: APjAAAXe3XyLMIwinZpyHiz+AZO0Ro47q0Yerv7WSE+SRclX7k9UocGd
        9J/PkAY6g/E6Hk4JsMHDVfmO
X-Google-Smtp-Source: APXvYqzRIk413kYwXUWGVwVmwRUj/Tq9t6WKTxMk1Hf4QEPGYM3So4lhZhQUhTsYLNJstkpWUBKkQw==
X-Received: by 2002:a63:4e1e:: with SMTP id c30mr5686911pgb.89.1572025896500;
        Fri, 25 Oct 2019 10:51:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7108:7f86:4131:5b00:9fc5:5eaa])
        by smtp.gmail.com with ESMTPSA id d14sm3916345pfh.36.2019.10.25.10.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:51:35 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org, sakari.ailus@iki.fi
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/2] Add IMX296 CMOS image sensor support
Date:   Fri, 25 Oct 2019 23:21:16 +0530
Message-Id: <20191025175118.13307-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds support for IMX296 CMOS image sensor from Sony.
Sensor can be programmed through I2C and 4-wire interface but the
current driver only supports I2C interface. The sensor is
capable of outputting frames in CSI2 format (1 Lane). In the case
of sensor resolution, driver only supports 1440x1088 at 30 FPS.

The driver has been validated using Framos IMX296 module interfaced to
96Boards Dragonboard410c.

Thanks,
Mani

Changes in v2:

* Switched to YAML binding

Manivannan Sadhasivam (2):
  dt-bindings: media: i2c: Add IMX296 CMOS sensor binding
  media: i2c: Add IMX296 CMOS image sensor driver

 .../devicetree/bindings/media/i2c/imx296.yaml |  98 +++
 MAINTAINERS                                   |   8 +
 drivers/media/i2c/Kconfig                     |  11 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/imx296.c                    | 733 ++++++++++++++++++
 5 files changed, 851 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/imx296.yaml
 create mode 100644 drivers/media/i2c/imx296.c

-- 
2.17.1

