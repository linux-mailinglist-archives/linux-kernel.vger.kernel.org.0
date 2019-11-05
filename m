Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF49EF5C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 07:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387768AbfKEGuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 01:50:16 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:46325 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387569AbfKEGuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:50:16 -0500
Received: by mail-pl1-f202.google.com with SMTP id a5so2634969pln.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 22:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uOGehhWZgUVKoLCu9uPvy6GNYBcrgHwxU8kr8wE+agE=;
        b=kNXbtHFqBug+/oU8bSdHAs+qVLw4TxE9aiRKiowEJ21d0hfBCS6YHf/kqC5JAviop6
         ZELVuK1m500L8/nK08PErToeZYzfk4mHeZo5UvmKYPXkb9eLidNex7+SYhvOC953oNn3
         b+Kih+0HggJ4LjnpQwgSVisfSXxky5OPZuh/cz7u8F7X06dRI44sQVjACCIHmzada2gV
         9NIQUNHYW/HeRo6MIc5ur9zwHv/Ku4B0xkGa4k9vNz6JjEeJcDmet/pdaF28PEPRFNIu
         bNVKzrAMbpw4Kvgl0/yKVBxhLV9nzB7ZyMovUx3BILktQy4L+ADiidSYmMaGSKwlvqc3
         UEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uOGehhWZgUVKoLCu9uPvy6GNYBcrgHwxU8kr8wE+agE=;
        b=ZINoRMuFYTWXtDtvWXWtvl0dLP0yHCEjmYdqafPbmgiKTCKqnG1LnQuhrz6PpGGo5O
         jSsLLJoXa6gVD1gLsViMqxAJrtgdYv1SsmKgO2Z5yI6aXVow3FxBUoqndiP4A5WKWNlG
         JTlmd5Mkb1UE5U72tBTuOsQT1dj5LRKYkHbXDEW4kGuxIC/z0+eVPXBvzinY5+cQs8hJ
         3PX52sH9Lu8EEqQGBbfV76Y+zzIVdhj4ZGlg+MXZPaJtkceuzaQgG1uUFRiQ+hGXEi9u
         XbXpOwbU2GlQ1cbNSG05YX08INsh3cU/ZOseRnroh/XjOgTyrba1TPA7stiDNKRJp3sB
         ZH0w==
X-Gm-Message-State: APjAAAWjrIPA2DxFma0uzcbOb4hdqDt8oUgMShQ8WWOpB/3wHsOZiZiP
        N0+XYwo/gkDaa8QJ6nGJtH1PBkSNkbt6MqU=
X-Google-Smtp-Source: APXvYqxH7DTIrxXLzr6jLIklHMp5HeuCMdHVPfadC/hCVXWPxQo+eNZe9jARv5mXlPGzx8C3yGjcz4nA9zmOrU8=
X-Received: by 2002:a65:4c41:: with SMTP id l1mr35228412pgr.163.1572936613516;
 Mon, 04 Nov 2019 22:50:13 -0800 (PST)
Date:   Mon,  4 Nov 2019 22:50:00 -0800
In-Reply-To: <20191105065000.50407-1-saravanak@google.com>
Message-Id: <20191105065000.50407-4-saravanak@google.com>
Mime-Version: 1.0
References: <20191105065000.50407-1-saravanak@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v1 3/3] of: property: Add device link support for iommus,
 mboxes and io-channels
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for creating device links out of more DT properties.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 812b69a029d1..0fa04692e3cc 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1185,11 +1185,17 @@ struct supplier_bindings {
 
 DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
 DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
+DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
+DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
+DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells")
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 
 static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_clocks, },
 	{ .parse_prop = parse_interconnects, },
+	{ .parse_prop = parse_iommus, },
+	{ .parse_prop = parse_mboxes, },
+	{ .parse_prop = parse_io_channels, },
 	{ .parse_prop = parse_regulators, },
 	{}
 };
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

