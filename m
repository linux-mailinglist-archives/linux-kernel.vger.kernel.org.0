Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB831C787
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 13:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfENLPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 07:15:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50619 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfENLPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 07:15:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id f204so2442313wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 04:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q7xsW/BOqJsCwgtal4qtDTg4ltIl/wE9sOygtXfjPeA=;
        b=VtJkORK/int8nHN6cmzQjp1Ji18eM5y9IACvX/eNBYaP1YLpFQCbfiruihBnN61HJh
         +blQr9Kd+oZabfYJSjvxO9gHcvCe3eXZIIaE8a7IVrM97WBCy0MgUJiIzodlRZA+SCV4
         EcRNBbv0C44ug8Bl1H9Q3K/JzpNDizBOJdKYD2qL/h4UNDHsolEqlqxxKXQxbo8BAWfM
         G6xl+DrU9QMQvainmAAz9OFra3np8NjFmdnaMVr/2CYUPmEHCRZR5OnWg+/VCTsZZV0d
         BPARqcc2vMyL1UrMSXWko0GpenqlXL2TBsIukJChFqDceHFeKZDaNzawnyhBM41vpx1/
         e6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q7xsW/BOqJsCwgtal4qtDTg4ltIl/wE9sOygtXfjPeA=;
        b=j2TwViYjA1GgzmOfLbnWrN2S7zkelXO6ECBwUj4Z7rL9V9v8dcbfdpqbN8Ulnwo6dX
         6FeID1nDM3BRKvVZyq/7Xrjl6ceid7q2l7GTty8V9fYQ1xhLzfQvjVOrb8PFj0SuVG6j
         DwJ6bTrnVeIDl0K3fdW98JauG0H8BQuEFQsYMbGBvHEjB01dwrBa8QQ7jmpFWr2TUfeM
         pRtza3/zxRS2kyZPl7xmuiTIdRN94/pq4/0sGEGNnyPrhK0H1G+xcvvwi0J79wqfyF1I
         A2nEyISNtYGiQBowr6Ud9mFPAjBbG8smn5pDwUgPJ9KasrEgSKuk9la0kOT93ajTUiwg
         norg==
X-Gm-Message-State: APjAAAXLG2itTXCtC6Yb+PllBHMkGKpDdUdwRbvOXcUU3AG62SQ7s+jx
        sp79Ut7nQUQc8RqnExEmQ5PrAQ==
X-Google-Smtp-Source: APXvYqwnQNFTMvQOm2DZEC2cil/Y5FxH3KxccUo/gq+bPu+lW7WLk5n0PrVPzsen43A3CmDIdODIMA==
X-Received: by 2002:a1c:4045:: with SMTP id n66mr2088020wma.142.1557832517491;
        Tue, 14 May 2019 04:15:17 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c130sm7289922wmf.47.2019.05.14.04.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 04:15:16 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] arm64: dts: meson: g12a: add audio devices
Date:   Tue, 14 May 2019 13:15:02 +0200
Message-Id: <20190514111510.23299-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds audio related devices to g12a SoC family.
It adds the clock controller as well as the memory, tdm, spdif
and pdm interfaces.

At this stage, the HDMI and internal audio DAC are still missing.

Notice the use of the pinconf DT property 'drive-strength-microamp'.
Support for this property is not yet merged in meson pinctrl driver but
the DT part as been acked by the DT maintainer [0] so it should be safe
to use.

[0]: https://lkml.kernel.org/r/20190513152451.GA25690@bogus

Jerome Brunet (8):
  arm64: dts: meson: g12a: add audio clock controller
  arm64: dts: meson: g12a: add audio memory arbitrer
  arm64: dts: meson: g12a: add audio fifos
  arm64: dts: meson: g12a: add tdm
  arm64: dts: meson: g12a: add spdifouts
  arm64: dts: meson: g12a: add pdm
  arm64: dts: meson: g12a: add spdifin
  arm64: dts: meson: g12a: enable hdmi_tx sound dai provider

 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 1227 +++++++++++++++++--
 1 file changed, 1136 insertions(+), 91 deletions(-)

-- 
2.20.1

