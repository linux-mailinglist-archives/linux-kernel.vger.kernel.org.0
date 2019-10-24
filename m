Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4D80E3CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 22:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfJXUOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 16:14:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33113 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfJXUOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:14:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id 6so2746914wmf.0;
        Thu, 24 Oct 2019 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=71EpT05RPGfdV2MRDW2h3g+re/Vo/U/4wOhVseH1/1o=;
        b=t/1pSz37TaDlYsdlTF+jQPUSyX9Hu+JvBp9tLXFbPZWlXf6IO3fwDWBqPOLS/SgrJC
         HnJ6JmIXE82CJmwzA1cQ+4JfTzNCebkwbcJMz6UgNqQr0nhLd7gb0+enDztDGjd4Op20
         cc6j9VR8besuhXe/xghQ3CGvA2wZT9Bw7Nj+6G0geLLSdDrIdXp8jyWlwjfZDgmMeGwn
         h7gYmba3AL8JtCz89AJxEv2qaapQ17kOuInpMh6rn0kK2y+UR10GKkCdja5KaL4HbiBY
         fZ637k+f3sPbI29SwJ7dtFzyja2jiCkvOEbA+qXCaVJiF/jU7+qOgpm22xhmXCorpFBG
         vFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=71EpT05RPGfdV2MRDW2h3g+re/Vo/U/4wOhVseH1/1o=;
        b=cxC0DxkK6BE/WSPdxghhjQGhZgh8IV69HBoSEq4sm5lolJpXY85cpyHanFmXFstNPo
         Se3gW57EjnFscC/vcSX8hAoFB+VEESEbONFl2gpNfGt5aZPOucLWmGmNZ58+enkFL78P
         ZzBDtzBM2Oj6EYTCziKnGrgaxnIqn4IAFmC+e0b6pkBWmGuCrxsBp2xoM+ITjTnrROZm
         CE4EGDV5QovjpVtHxbmw/LhW9rLzTQoI5sTTwd8e7fEoZPMcZ9LVidWuuhSMVS1GYI+s
         x/efRegRLmjTdGWVcXUG2tV7Ka14IWYEH10AxVLkLVLjo4P09onO9FxrJpzIDGPGM2ga
         CB9Q==
X-Gm-Message-State: APjAAAUWYFkS7lMHalQI+kIEj/HS3iDXCniwOphaIjrx2qM3q8s3pPbc
        +nXry8QrDkt7qJVYi7xuWxt965Db
X-Google-Smtp-Source: APXvYqxIGWOBea0c+/zjuLO8hKzNVktbp9/3uDIdKy+vVTY7pD8lVAM4eP/sywlQ4ma8JdPxyiqtUw==
X-Received: by 2002:a1c:2d49:: with SMTP id t70mr119405wmt.131.1571948072447;
        Thu, 24 Oct 2019 13:14:32 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u21sm4788536wmu.27.2019.10.24.13.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 13:14:31 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE)
Subject: [PATCH v3 3/5] irqchip/irq-bcm7038-l1: Enable parent IRQ if necessary
Date:   Thu, 24 Oct 2019 13:14:13 -0700
Message-Id: <20191024201415.23454-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024201415.23454-1-f.fainelli@gmail.com>
References: <20191024201415.23454-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the 'brcm,irq-can-wake' property is specified, make sure we also
enable the corresponding parent interrupt we are attached to.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm7038-l1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 689e487be80c..45879e59e58b 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -286,6 +286,10 @@ static int __init bcm7038_l1_init_one(struct device_node *dn,
 		pr_err("failed to map parent interrupt %d\n", parent_irq);
 		return -EINVAL;
 	}
+
+	if (of_property_read_bool(dn, "brcm,irq-can-wake"))
+		enable_irq_wake(parent_irq);
+
 	irq_set_chained_handler_and_data(parent_irq, bcm7038_l1_irq_handle,
 					 intc);
 
-- 
2.17.1

