Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF0D14697B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 14:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAWNrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 08:47:02 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43694 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbgAWNrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:47:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id u131so1402855pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 05:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ztEalupp6BA2B+aVvucMD9r9wzMzPi+seVlAfbkGBSY=;
        b=r2TdoJh3xNcI6aPSASEmM7iVrVjviU5MeW5jnthU0vB/kcfqFr1FiiRWiPbmfx68SC
         KB+gldgRCAcRl9GljoTr8lfedMt80CfwxE9rqrcVUwFUFTApepBPwrNSU5GpvlBbTEnf
         jQpTUp3N0cyod2pFFZDcpGDcBCwTPZ8tTu7so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztEalupp6BA2B+aVvucMD9r9wzMzPi+seVlAfbkGBSY=;
        b=c0yn6btH4aSasL32KfXQ7cLZbrQkDEBjxsOm1nNm4n/OGvG0p1F46/U8yO748AMl6f
         6UOeNcwZT3S5CLskWqQq8kbHYXf1+TfnTGrYkISeCmvoXonOJ21Bjw+h43xL1OFI+MEE
         TJj8/UpAN4L1Q+Jq59ixLc2udLrCODnvYgZbEsSkzSOSFwxIK2SmOJ4EyyP0yxI6l3UR
         E5OqnfKv4+H+4V7QyuMiqfn6SnAD3BkOy104vTZjZN9nSnekcNjpmB47E4uLXF6NwXon
         544b27/ZO3mlaHayh+f14bFeY0uRcJDNPr2FdiUTsPTh11Tvp0hOIoYfEsVl+SLvQyIM
         bgHg==
X-Gm-Message-State: APjAAAVWbJ6i1bwHBFvFAfWIbTgFZ+VI1DJ09TaEwRVDGMRpq2eVYAn3
        UTqBds+VPHZ90BEzbXHN2SGygQ==
X-Google-Smtp-Source: APXvYqxFydOJhKTAqNJ/gjtGiD+8xdXtBtmxRScl0NEraMgo7kIjEDWa7r9V30TPrrfAY7WNIg7mcA==
X-Received: by 2002:a62:5544:: with SMTP id j65mr7702003pfb.121.1579787221444;
        Thu, 23 Jan 2020 05:47:01 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.109])
        by smtp.gmail.com with ESMTPSA id a10sm3119275pgm.81.2020.01.23.05.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 05:47:00 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/3] ARM: dts: rockchip: Fix ddc-i2c-bus for rk3288-vyasa
Date:   Thu, 23 Jan 2020 19:16:40 +0530
Message-Id: <20200123134641.30720-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20200123134641.30720-1-jagan@amarulasolutions.com>
References: <20200123134641.30720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ddc-i2c-bus routed for HDMI is i2c2 not i2c5 on
Vyasa RK3288 board.

Add support for fixing the same.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-vyasa.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index d2f79e5bee87..88c63946f2a3 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -150,7 +150,7 @@
 };
 
 &hdmi {
-	ddc-i2c-bus = <&i2c2>;
+	ddc-i2c-bus = <&i2c5>;
 	status = "okay";
 };
 
@@ -347,7 +347,7 @@
 	};
 };
 
-&i2c2 {
+&i2c5 {
 	status = "okay";
 };
 
-- 
2.18.0.321.gffc6fa0e3

