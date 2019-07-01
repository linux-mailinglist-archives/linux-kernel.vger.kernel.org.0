Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C81A45038
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 01:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfFMXmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 19:42:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37386 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfFMXmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 19:42:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so215803pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 16:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=asAFKY/6kW404t0swx66t/dNtCEl6Thr0JYkBAqMaR4=;
        b=AtrQETD8maXPKp1qgnGxA8eeBx7Cjs5OFntvEBHxx8Y63Hfo8STjQB7T1kmrZIxhVv
         baf4wlarO3zBU4HJwEuF2UysuOBmjOTzr1oAY/Po2KQUJFEL9/7sBH979Ox2KI22TRcV
         NauLNa3uQxNcDx/j3YUJ7eaChBlNbfov6fKsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=asAFKY/6kW404t0swx66t/dNtCEl6Thr0JYkBAqMaR4=;
        b=WM9xHTXl4c0lNN/zP9nH8x9xRf6PwcK4A3RmO3Ybukp4J625hpT0YxgprJHnkfKxWF
         qr4MAhTahGMMdmiYNp966CoiqlvFFvZU/nXeU9/f+R5mtJ4klyX9uaDwycr+BwIyyqE8
         aoLZZrtPNxRa+rl2N7J+B5B0bB82PqGs9zxJMdSrGSwxTOd2aB2po2PoRVxosGSaWWYq
         0G7MYkv47OT0VUUzPpgkXGjyCmpvcZpi2qtF711DT1jFyiKs7rZtMteGQk+DvfwJHftS
         dwcEkTujPZd0AiEbqIVapI3xBGcoz3csKZJKca9DpyJwHYmY9ZZdBuBsoIkuBMJB3SPE
         ln4Q==
X-Gm-Message-State: APjAAAUXQp2kJtPQinvG93t4rgRR+byyXSHSOzndiYveWiYhd5RO4Gyy
        0n83lygvV2SBUrPazZLLQRHE0w==
X-Google-Smtp-Source: APXvYqw9ZPafeIz8wf7SJLyfTJw4AF/ZuccsnJmitqQ0R7cOeNBJgsKmhTK6uMW7wmx88DQONcxcAw==
X-Received: by 2002:a17:90a:ad89:: with SMTP id s9mr8114489pjq.41.1560469334233;
        Thu, 13 Jun 2019 16:42:14 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p7sm781088pfp.131.2019.06.13.16.42.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 16:42:13 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        linux-rockchip@lists.infradead.org,
        Double Lo <double.lo@cypress.com>, briannorris@chromium.org,
        linux-wireless@vger.kernel.org,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        netdev@vger.kernel.org, brcm80211-dev-list@cypress.com,
        Douglas Anderson <dianders@chromium.org>,
        Franky Lin <franky.lin@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Madhan Mohan R <MadhanMohan.R@cypress.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v4 5/5] brcmfmac: sdio: Don't tune while the card is off
Date:   Thu, 13 Jun 2019 16:41:53 -0700
Message-Id: <20190613234153.59309-6-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190613234153.59309-1-dianders@chromium.org>
References: <20190613234153.59309-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Broadcom SDIO cards are idled they go to sleep and a whole
separate subsystem takes over their SDIO communication.  This is the
Always-On-Subsystem (AOS) and it can't handle tuning requests.

Specifically, as tested on rk3288-veyron-minnie (which reports having
BCM4354/1 in dmesg), if I force a retune in brcmf_sdio_kso_control()
when "on = 1" (aka we're transition from sleep to wake) by whacking:
  bus->sdiodev->func1->card->host->need_retune = 1
...then I can often see tuning fail.  In this case dw_mmc reports "All
phases bad!").  Note that I don't get 100% failure, presumably because
sometimes the card itself has already transitioned away from the AOS
itself by the time we try to wake it up.  If I force retuning when "on
= 0" (AKA force retuning right before sending the command to go to
sleep) then retuning is always OK.

NOTE: we need _both_ this patch and the patch to avoid triggering
tuning due to CRC errors in the sleep/wake transition, AKA ("brcmfmac:
sdio: Disable auto-tuning around commands expected to fail").  Though
both patches handle issues with Broadcom's AOS, the problems are
distinct:
1. We want to defer (but not ignore) asynchronous (like
   timer-requested) tuning requests till the card is awake.  However,
   we want to ignore CRC errors during the transition, we don't want
   to queue deferred tuning request.
2. You could imagine that the AOS could implement retuning but we
   could still get errors while transitioning in and out of the AOS.
   Similarly you could imagine a seamless transition into and out of
   the AOS (with no CRC errors) even if the AOS couldn't handle
   tuning.

ALSO NOTE: presumably there is never a desperate need to retune in
order to wake up the card, since doing so is impossible.  Luckily the
only way the card can get into sleep state is if we had a good enough
tuning to send it a sleep command, so presumably that "good enough"
tuning is enough to wake us up, at least with a few retries.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- Adjust to API rename (Adrian).

Changes in v3:
- ("brcmfmac: sdio: Don't tune while the card is off") new for v3.

Changes in v2: None

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index ee76593259a7..629140b6d7e2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -669,6 +669,10 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
 
 	sdio_retune_crc_disable(bus->sdiodev->func1);
 
+	/* Cannot re-tune if device is asleep; defer till we're awake */
+	if (on)
+		sdio_retune_hold_now(bus->sdiodev->func1);
+
 	wr_val = (on << SBSDIO_FUNC1_SLEEPCSR_KSO_SHIFT);
 	/* 1st KSO write goes to AOS wake up core if device is asleep  */
 	brcmf_sdiod_writeb(bus->sdiodev, SBSDIO_FUNC1_SLEEPCSR, wr_val, &err);
@@ -729,6 +733,9 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
 	if (try_cnt > MAX_KSO_ATTEMPTS)
 		brcmf_err("max tries: rd_val=0x%x err=%d\n", rd_val, err);
 
+	if (on)
+		sdio_retune_release(bus->sdiodev->func1);
+
 	sdio_retune_crc_enable(bus->sdiodev->func1);
 
 	return err;
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

