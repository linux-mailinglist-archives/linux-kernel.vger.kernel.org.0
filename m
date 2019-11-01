Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81BA5EC4BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 15:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfKAObf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 10:31:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44274 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbfKAObe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:31:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id q16so4448325pll.11;
        Fri, 01 Nov 2019 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v3P4Nfs/f4DDEDkuO0DhQZmxaSsoKdeeybFv9GrZiS4=;
        b=peZ5yz7PiZB4AB4GxNEZuAgdW42izQMegYV24QXx31rtLrdiAEmo3PKGBiDAyxU8GU
         y0PVxetYpy59ZsuVdgQN5Mh820MTD2qXnJJLnhc0S65tnWGCTW5xFK+eUBdktKkxy3k2
         LR6j7t48WN4qop8gvzYwHxtregpdk7wQv12e6GdGetnXACZeIr7erMxdAqBNIn2LWKEX
         ZiSOCua9wRU6k7V/m5+6pSTcO8KbJkICDQf+ukH2Ixpj+5mWe1iuI2Ww8zYe203sdVQr
         nvsbV+hB/tqKmn8tcUc9Fw/by9bTswdO0VfRg+RmDb3S9HxyBX6n1P7ne9mR1AMI7N6n
         +ZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v3P4Nfs/f4DDEDkuO0DhQZmxaSsoKdeeybFv9GrZiS4=;
        b=a8z0IcRlBiUqRB5Y9BjAfG76kAmBmSo5j/R14WZO0GcjtA6pVzT72TdCghf/ejDcJX
         kw4l+QpYvceoRZ3a1L1phgu9XmTe5s4kS6E7+3+PAOwJ18/3zy7pZu+0xr4WR7/xHNxD
         nv9PXBniV/G+NmiG2JlYLfrQ81HwsSbSX2/wGKDz3y4EQOutLev1dMIB+uOfQ9TAy4/8
         kNABVq45hqRsQNA62YnYCQUmClzbctmPIf/fcJkOsyrBSKwPtnN8/tRAd5b4QMTZrKt8
         CKDKjCqSHwspxi67PaUlqVZ1qN9hDeyQqA2VGPzI2zwUgpJeeF7AMnxLl+I8q57QNRpN
         /V1A==
X-Gm-Message-State: APjAAAU5bEuXQKYcuUFFDyRL7qhGBholNk6y4sIGaFiWjbiS4hYHA0Br
        3OV/BFe4cAqSyuK2OUta7m8=
X-Google-Smtp-Source: APXvYqzIVaFOzABdHtSgRBIuKde8kZfF/0r+n7Ump6Oam46JfLfhx8fI8VNRZlg+DUBpC+SngGmivw==
X-Received: by 2002:a17:902:7885:: with SMTP id q5mr12444241pll.317.1572618694114;
        Fri, 01 Nov 2019 07:31:34 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.165])
        by smtp.gmail.com with ESMTPSA id x9sm9273061pje.27.2019.11.01.07.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 07:31:33 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC-next 0/1] Odroid C2: Enable DVFS for cpu
Date:   Fri,  1 Nov 2019 14:31:25 +0000
Message-Id: <20191101143126.2549-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some how this patch got lost, so resend this again.

[0] https://patchwork.kernel.org/patch/11136545/

This patch enable DVFS on GXBB Odroid C2.

DVFS has been tested by running the arm64 cpuburn
[1] https://github.com/ssvb/cpuburn-arm/blob/master/cpuburn-a53.S
PM-QA testing
[2] https://git.linaro.org/power/pm-qa.git [cpufreq testcase]

Tested on latest U-Boot 2019.07-1 (Aug 01 2019 - 23:58:01 +0000) Arch Linux ARM

Patch based on my next-20191031 for 5.5.x kernel.
Hope this is not late entry.

Best Regards
-Anand

Anand Moon (1):
  arm64: dts: meson: odroid-c2: Enable SCPI DVFS for cpu

 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.23.0

