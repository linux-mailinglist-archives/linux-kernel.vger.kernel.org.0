Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA5BF14107
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2019 18:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfEEQZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 May 2019 12:25:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45481 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfEEQZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 12:25:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id q23so3734549lfc.12;
        Sun, 05 May 2019 09:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MXT8MsjumpSbK0LF9e/6Gx85Nar5yEV08NRp9tHP9QI=;
        b=kk7hTRVOzXx5yOJy1lSbpR9QDLa2XWBTPhV89BMJNa3v3Q0ZEIfXjZNd9HsC5YNMia
         UPWHBRR4PBsSHcE01N4Yh5A6j9SqMb5b73khgsRhhT8caUSPP+sFu47enLFjuZbdjuTk
         40URvZ4DSC5wYyE86rch2mfaJGCKKmU8so11GdImksw5Q5mZyewBdURQ8zSMurBKeSIS
         lvojsuuNmn7FzekaRIcycgPeVWc2zobneKSi7XwyVXGB2AqwLrqiNUMkrpDzQmf4PvMh
         VN5uDb5qhbigIdCs4fjFHHB1t7EvQRVWlJ/H1RSHA6LEpBz+Vmczlmq4cEOn/BVgwPcV
         plIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MXT8MsjumpSbK0LF9e/6Gx85Nar5yEV08NRp9tHP9QI=;
        b=CtZonK92bmtu87cwwp2/7HYuyU5UFBD/cthBHvyeGR+3Fbus+JOjMrP5HhRK8sTKwv
         JcxSDjWDN+XNIRiyz2ySBfJpsYx1ZILcwrto5r5+kROq4+k/ImP0MDtf/AXVSR2fkXzR
         P6fwLNgaMcaMuSSXOX1E+zQChOm5PVG8JvVU11RIvFulQto+7ONjfXG+OvL8uSzyWFzv
         NiK+NIpgDcsrBN9WP3Dg905VH8zS5eHQGkK2yuWEg/IH4tA+nb+hUDy+M2bS6xCExVyq
         npS+jFhbHJWsmb6tvt9QisR9joQd6B8nq0hmqZMIe02j8cvYxzPwQi178ofwuSYx/1X5
         fHgw==
X-Gm-Message-State: APjAAAXItXlgehU+HKqgLsvD3XJ9W4urv9/H8Xa57tNeBtZ+td6TtxhT
        1jcAz/gHH97lClaPFQrzLNg=
X-Google-Smtp-Source: APXvYqxZLY9A7LXk6p9FfJOCA2owRihp7/bDf3R3d6wPXesiNMoMBxey1kmewzQ6mL/ETYfoygGydg==
X-Received: by 2002:ac2:59d9:: with SMTP id x25mr3113603lfn.123.1557073514282;
        Sun, 05 May 2019 09:25:14 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id g13sm1581649lfh.49.2019.05.05.09.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 09:25:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] NVIDIA Tegra clocksource improvements and clean up
Date:   Sun,  5 May 2019 19:24:29 +0300
Message-Id: <20190505162436.23125-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series primarily unifies the driver code across all Tegra SoC
generations. In a result the clocksources are allocated per-CPU on
older Tegra's and have a higher rating than the arch-timer, the newer
Tegra210 is getting support for microsecond clocksource / delay-timer
and the driver's code is getting much cleaner. Note that arch-timer usage
is discouraged on all Tegra's due to the time jitter caused by the CPU
frequency scaling.

The series was extensively tested on Tegra20 and Tegra30.

Changelog:

v2: Rebased on recent linux-next. Now all of #ifdef's are removed from the
    code due to the recent patch that generalized persistent clocksource.

    Couple other minor cosmetic changes.

Dmitry Osipenko (7):
  clocksource/drivers/tegra: Support per-CPU timers on all Tegra's
  clocksource/drivers/tegra: Unify timer code
  clocksource/drivers/tegra: Reset hardware state on init
  clocksource/drivers/tegra: Replace readl/writel with relaxed versions
  clocksource/drivers/tegra: Release all IRQ's on request_irq() error
  clocksource/drivers/tegra: Minor code clean up
  clocksource/drivers/tegra: Use SPDX identifier

 drivers/clocksource/timer-tegra20.c | 272 +++++++++++++---------------
 1 file changed, 121 insertions(+), 151 deletions(-)

-- 
2.21.0

