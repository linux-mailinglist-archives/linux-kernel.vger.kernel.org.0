Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0B119363
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 22:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfEIUaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 16:30:08 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40283 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfEIUaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 16:30:08 -0400
Received: by mail-yw1-f66.google.com with SMTP id 18so2925741ywe.7;
        Thu, 09 May 2019 13:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4Uc1sxWlZenzjNtw/v4Bu0vw6ThmoS5rTB+EikbKMzw=;
        b=g0xmpFiIyYDNtnP8/cR+PuL+UNRGGblsJgGR0K8vdvAZrBMnyWKNYLS0wwM/ZbaeyN
         54df6yMCkkZ+zVvQwuPDCaHQ0vO1qgsZPoLeZV9d/vNJkXdz5Jzak9cjocWm7tsLddHG
         sdR14VQ0GlXDvDnM0YMQo8jOc3c2V2KVmDbVEd/GNksGjBgWqsgTG1Mgprf0cLnm162s
         OuNWgFHVmY9/YfW11U8qxVgwgRFpxeufexjKccS8OrWFY+nOtUdiwPCREAqoZbTESVl9
         fwas8BeS3epJXxPT3tP3AG2dPgNoBUUP/OHi7kP9tM+ckVoUU2g41G9JAw7JdgvQuIYe
         Jr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4Uc1sxWlZenzjNtw/v4Bu0vw6ThmoS5rTB+EikbKMzw=;
        b=dcoTrezVqkBgFqmwU7np0JI1iHpMjiR9/xdDiRYE0wUM26hFysqjPRhWSqKgRXmwl0
         4aE/AuNzdw2vU9YTpbxDAOv27MN0D7PGh18tECb4VF9FcySD42ru3FNLuBefxuk5X1Ot
         adzftitnX5QRfONN02QeAoQwBQTenUYLF7Kli+s4Fw7nVRYECEKuVjWdzfsV2zVdrsv/
         A1BJZgzflsgxRFqLxY9GpcLr41lOC11lEloRUsl6YsFoUVEC2ZR8b//PczHrf8t7x7Q3
         3ASnYbXX6dlqGlNTtaBbpZd2rPP6vbyK2n4YJYImAEcmIdx3JZRrGPdr3kAoHYI3VfEs
         HTrg==
X-Gm-Message-State: APjAAAWokHFI5Jiy5EbAmYOPvPj+UdTLCM/XU1eA7dWOjr5iV3LjnZAK
        oZRd75DWNjII6j+20f4VGlMzlSSx
X-Google-Smtp-Source: APXvYqzy38NnSBuSt1HdIcLK+5diag01BsVcL6xGPpIwXjbp51WMU2vzQXUWPwyJKxLRIno94pgVLg==
X-Received: by 2002:a81:48b:: with SMTP id 133mr1684226ywe.11.1557433807088;
        Thu, 09 May 2019 13:30:07 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id u6sm896150ywl.71.2019.05.09.13.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 13:30:05 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list),
        bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net,
        eric@anholt.net, stefan.wahren@i2se.com
Subject: [PATCH 0/2] clk: bcm: Allow CLK_BCM2835 for ARCH_BRCMSTB
Date:   Thu,  9 May 2019 13:29:54 -0700
Message-Id: <20190509202956.6320-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

This small patch series allows making use of the CLK_BCM2835 driver(s)
on ARCH_BRCMSTB since we have newer chips that make use of the CPRMAN
block that this driver supports.

Thanks!

Florian Fainelli (2):
  clk: bcm: Make BCM2835 clock drivers selectable
  clk: bcm: Allow CLK_BCM2835 for ARCH_BRCMSTB

 drivers/clk/bcm/Kconfig  | 9 +++++++++
 drivers/clk/bcm/Makefile | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.17.1

