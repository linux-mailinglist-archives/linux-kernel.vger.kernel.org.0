Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9B7D86B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 05:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403857AbfJPDdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 23:33:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45902 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403829AbfJPDdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:33:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id u12so10556141pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 20:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NtLLzsDOIuiH39rP2uuMmF0oaTj9DHzaakbaIjXt74A=;
        b=vPB51r4EZ8stXyXSv4G88Vclvyv30hhGw3Tpf379BTU6tuj4TcKIJfGOECfS9HgZxC
         sOrbB6xhou5OBa2HlB+vuU2WBsw4f/epqpY2AKZc4vX3zf/GGEi7NTWl3NRCe7TWT4xh
         gWLBrp4TL0Jjk5b9CCugv6PxSzCLRtTIAkR1zEpMsBJX8R06I74CldwORwLPGQGe6qTL
         HJEJ0mLdHAx4O2EJZm2EdpYqyXc00yPju4FmuoIeGvCO0cyES07xGg+PZECCBEsIKeIj
         drFgq8KvXV8U7VRXLDSQCSN3+2iDEOUJ+cCsx3GB7nVHoDqZcrH2wKcd/RNABDOj72qN
         WTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NtLLzsDOIuiH39rP2uuMmF0oaTj9DHzaakbaIjXt74A=;
        b=lSzD4D03UGYJiaDFByNUSv0ZGQBiR4px0XrhIRbJdJX9wAW/0UBwHT6RtWeP4yjHri
         MCD7vY90jKb0lqE/EwqlHozQ5JOxlzmDIkeJ1ZhtgxGGmi48yNZjupFWPk3S0r22hf0z
         vqXGyLT8/4kZ72b6/SI24D+TIz+aTxSApshBompSyJMk0tCklM2rkt0bUHH2H3F6AE8T
         WMy7HPb0FM6d0fyUIz6zBCpFyAx0GNwcoR/RGFD8Pi31AMZW0kmrNKhUlG2rqbXz+kDQ
         4cXeTEbrz49Q42oufO/4ttY7UTZ1Fdc01HN0jg35D/dWGZBYnokB9n4KHiqaQCq1lHcO
         cV4w==
X-Gm-Message-State: APjAAAVnova9fzAAHkEGVyAnjwz+CBDqovd3OGnAak87TYrXXL5pWUpL
        pU9s+HAbiPe9wY9DLn9yF3zMbeLLhfg=
X-Google-Smtp-Source: APXvYqzFCD/6MuKpzLdXxEtnegE2Po5uAh/iIxgZiDEZd0o2kcUaDRjQ4rIow2Sz5ik6Cxtqptfa3w==
X-Received: by 2002:a17:902:d691:: with SMTP id v17mr37578925ply.340.1571196827898;
        Tue, 15 Oct 2019 20:33:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id l23sm748356pjy.12.2019.10.15.20.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 20:33:47 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Subject: [RFC][PATCH v3 03/11] usb: dwc3: Increase timeout for CmdAct cleared by device controller
Date:   Wed, 16 Oct 2019 03:33:32 +0000
Message-Id: <20191016033340.1288-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016033340.1288-1-john.stultz@linaro.org>
References: <20191016033340.1288-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

It needs more time for the device controller to clear the CmdAct of
DEPCMD on Hisilicon Kirin Soc.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
CC: ShuFan Lee <shufan_lee@richtek.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 86dc1db788a9..168eb4a0a9b0 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -270,7 +270,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 {
 	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
 	struct dwc3		*dwc = dep->dwc;
-	u32			timeout = 1000;
+	u32			timeout = 5000;
 	u32			saved_config = 0;
 	u32			reg;
 
-- 
2.17.1

