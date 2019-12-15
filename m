Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACDC811FA93
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 19:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfLOSye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 13:54:34 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35338 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfLOSyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 13:54:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id j6so4317954lja.2;
        Sun, 15 Dec 2019 10:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lWviGd0q9M7mX9BtKeMbyBIvqQbgGAAL9cMMxClvQgg=;
        b=ahQQFLVq8VEuKSkuR/NnhDV1T3CEomWC4pJOJnVTPTe2lIAQRYLghoLWitFyVqEPj8
         M4Hhl9kXueLUPgTARXRNEykYsRvK6wEhli1Cit+YOtageWnpJkqPBIucdYcd23GsLSmQ
         DOLkQ5N3SorE5aYMDJuOQg2MSXtoCbMsNLLrv/KfgFAF970KNHuYcAZlrw/z4NT4H/2S
         T1FFQCD4J2CZn/v3D8d3UF9ttsJo0Q/+D+qWiZ7ySSwxyEwAU0UdYf4hNi4QjdWTx9H6
         ktmb2XyanPVYw+fqEUjZUGyuFtbDgCinPCqULdjGxpGpbTa+5KBiXNU4JznnuH+JBO2u
         dXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lWviGd0q9M7mX9BtKeMbyBIvqQbgGAAL9cMMxClvQgg=;
        b=rXoOjctx6pFjsxRa/XKhD3E9cmhs9x2Vzyc2logxqIY8v3TkegmvcXLjafqkzyiJVS
         JdqwX2R77suIeXI28WG2hgKXnSciube32RAfXgx1j/oodwqR/pIBpnK7zyychmxUsWZu
         gMLnWoDR7aAbWR0T0+UTKk/wdRCZOoRVPRGQxHv157+zv8LzYItxa14/KvoB7iIndWLe
         2KM/pfFjTSlEFTNU2KP+EK7Rz30drbKwFaP2nzpjrqa1DF9YhFzM/IbPsu9CtfmVwE9Q
         YHvsLTXpcxbKdWMfA3obOtxVYhZ3OKZjhzCqho2mFRURm42T/zZyzVK77JzsOeAikOfj
         esoA==
X-Gm-Message-State: APjAAAXIE8CIDXElAWJr8KZOMBK2OymJWhGwVj9PyWIUfGcdwVVfW8JR
        LNa+eacMz5f7koHZeQ73GCY=
X-Google-Smtp-Source: APXvYqwjQnuQA16yy6o3m75gF/sZExlEHtLc1G0qzNYWc1Ck1n6372OKLFumw5uApIRe7vpO+8muKA==
X-Received: by 2002:a2e:8505:: with SMTP id j5mr15075021lji.235.1576436071558;
        Sun, 15 Dec 2019 10:54:31 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id t2sm8738514ljj.11.2019.12.15.10.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 10:54:30 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] dt-bindings: net: broadcom-bluetooth: Document BCM4329 support
Date:   Sun, 15 Dec 2019 21:52:53 +0300
Message-Id: <20191215185253.14024-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191215185253.14024-1-digetx@gmail.com>
References: <20191215185253.14024-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM4329 is a 802.11 a/b/g/n WiFi + Bluetooth 2.1 chip which is found
in Azurewave AW-NH611 WiFi+BT module.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index b5eadee4a9a7..c44a30dbe43d 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -11,6 +11,7 @@ Required properties:
 
  - compatible: should contain one of the following:
    * "brcm,bcm20702a1"
+   * "brcm,bcm4329-bt"
    * "brcm,bcm4330-bt"
    * "brcm,bcm43438-bt"
    * "brcm,bcm4345c5"
-- 
2.24.0

