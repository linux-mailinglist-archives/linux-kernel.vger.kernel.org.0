Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2851819AA8D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 13:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbgDALPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 07:15:35 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:38114 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732121AbgDALPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 07:15:34 -0400
Received: by mail-pg1-f182.google.com with SMTP id x7so11958072pgh.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 04:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJvDhSSCxal8nc7/4hqNu5B0Qf//zaQn+mBl8x66a8M=;
        b=r51+mqUYzvwPVGhqITkmqq1cqVhoNgG+Qllt6g/nZviVJMZ3eEa++/x8/0Iwi4Ufdc
         Yl7X1fFryID9b+CPXS0JDQOOw/z0dlYKHWeK2NzJDndd/gGxTKFo3RBLpW4HYSl42AOJ
         V0A6Tl/J27swinL+ADGMaTqzy4oZ05GAxCdW0ELq7NKr7zgb3sO7cwoDH3WqE+ItzWuL
         m9G5NZq1fJ0iUxMjzR7J3X8fkrQF6WbM3Nchm4GJWiH2xQtHp+/yrVJeJtoWdYqno7ns
         rF1gWOwzwoCzEODCl28aMYbHuGd8/FKnsrEyFR/vEHFeC0LzfV4Zi+dBwHxP1DdQ5h3J
         r6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJvDhSSCxal8nc7/4hqNu5B0Qf//zaQn+mBl8x66a8M=;
        b=Nk0rcCooa8y5W3Lagg/63LGVPUGYwLooyk8D/7NxfUAIIAUvNn3R+z83vA//k1fqiF
         GqfMGaTtbaiPMyToOKgk/d1PPkm5Uc20bIfoRd/5OZCSpFmtEY1iL0Y4wdqbQZEvH/t/
         EMgebmvS2nAysBRaFEZs4LyC4XsCy7HDl4t+TTNtTSPIGPPeVS0hs9yszcV8Xh8m16KP
         BR4qe0hrV78qsSbKpZ53UDSmn9aJ+X+s5iMEtuqnBLCuo0JwyP7iWypoIs5pwoXWJFPj
         Y80ig9QLTfLpJW6h/RUWbuzPG9HvgY/sRBvr6Rseslu4EVnmqvgQAQzPgUfRYNXXVBLb
         YRlg==
X-Gm-Message-State: AGi0Pub6hrW4FCrfB0xlmWC98QX4nOQfrZ5ZCiDG9cA4oRLvU09XdyQl
        rcbh24tds1hFEYWDdDh2pXL6Cbgx96o=
X-Google-Smtp-Source: APiQypK5w/tIU9iltgk0S//GSiFM4is2ST6A7jeGTJE5LnB3hYTQ3RTt0MsFB/En+OKzf7Let6Defw==
X-Received: by 2002:aa7:82c3:: with SMTP id f3mr6600295pfn.228.1585739732992;
        Wed, 01 Apr 2020 04:15:32 -0700 (PDT)
Received: from localhost ([103.195.202.232])
        by smtp.gmail.com with ESMTPSA id q12sm1358354pfs.48.2020.04.01.04.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 04:15:31 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, lukasz.luba@arm.com, mka@chromium.org,
        daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v4 0/3] Convert thermal bindings to yaml
Date:   Wed,  1 Apr 2020 16:45:24 +0530
Message-Id: <cover.1585738725.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is a series splitting up the thermal bindings into 3 separate bindings
in YAML, one each of the sensor, cooling-device and the thermal zones.

A series to remove thermal.txt and change over all references to it will
follow shortly. Another series to fixup problems found by enforcing this
yaml definition across dts files will also follow.

Changes since v3:
- Clarify example by using cooling state numbers and a comment
- Restrict thermal-sensors to a single reference to reflect actual code
  where there is a one-to-one mapping between sensors and thermal zones
- Add two optional properties that were missed in earlier submissions:
  coefficients and sustainable-power
- Improve description of hysteresis and contribution properties
- Added Acks.

Changes since v2:
- Addressed review comment from Rob
- Added required properties for thermal-zones node
- Added select: true to thermal-cooling-devices.yaml
- Fixed up example to pass dt_binding_check

Changes since v1:
- Addressed review comments from Rob
- Moved the license back to GPLv2, waiting for other authors to give
  permission to relicense to BSD-2-Clause as well
- Fixed up warnings thrown by dt_binding_check

I have to add that the bindings as they exist today, don't really follow
the "describe the hardware" model of devicetree. e.g. the entire
thermal-zone binding is a software abstraction to tie arbitrary,
board-specific trip points to cooling strategies. This doesn't fit well
into the model where the same SoC in two different form-factor devices e.g.
mobile and laptop, will have fairly different thermal profiles and might
benefit from different trip points and mitigation heuristics. I've started
some experiments with moving the thermal zone data to a board-specific
platform data that is used to initialise a "thermal zone driver".

In any case, if we ever move down that path, it'll probably end up being v2
of the binding, so this series is still relevant.

Regards,
Amit

Amit Kucheria (3):
  dt-bindings: thermal: Add yaml bindings for thermal sensors
  dt-bindings: thermal: Add yaml bindings for thermal cooling-devices
  dt-bindings: thermal: Add yaml bindings for thermal zones

 .../thermal/thermal-cooling-devices.yaml      | 116 ++++++
 .../bindings/thermal/thermal-sensor.yaml      |  72 ++++
 .../bindings/thermal/thermal-zones.yaml       | 341 ++++++++++++++++++
 3 files changed, 529 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml

-- 
2.20.1

