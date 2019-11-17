Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20763FF771
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 04:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfKQDck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Nov 2019 22:32:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36854 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfKQDcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 22:32:39 -0500
Received: by mail-pl1-f193.google.com with SMTP id d7so7532544pls.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 19:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vs97VLHwrjNmXAs3KmNunTfygPvSITJlC0MBfMzcaAk=;
        b=KyAxbJ7QjPWlzidZ9Hy+/kS5UOn7yzjfJZSETN9Uz60Rg9FifpEHOA+oyVmlmXeqLw
         /FIe2gL/GOAhS9T5RJJyTXC3389epjMQ5vmm2J98pWb0Ct67tyqLnUy7GF75/wcDuzUW
         JGUUY0CGeOTIyUUvLLFh6KsO4mtBEI46BUaaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vs97VLHwrjNmXAs3KmNunTfygPvSITJlC0MBfMzcaAk=;
        b=HwJLsdU38UKtlFV1rkCC/tj443W1rNknQO/Gy8jVeb6cdssuW7VntFRZNOCqbOjxmx
         fuVrDdWaYj59wxG9efvVlELmICET3cJhTOXuv56YZCsOjfjNrmNgd6cpv9aNUGQe0hJ0
         YWk8KmTgXECykUiRwmjTjACffCGlxoFQhDtAXVxjcQzcz118YlJWAh9mO9wQ3LR3wpd8
         tE0O8Wi9ED+JIRqyug24KTXmNQwhGIcLOngBOe+iHVnsRPogBS+F6yJLPoLzToJCPaQ+
         T69lx7JjoZKMXnc8+3xkmSXVWWhgi6ZEK6G+vkFZgi3NrS/95SieCJimbP0eBW4ElQ3J
         KKaQ==
X-Gm-Message-State: APjAAAWgnPold6BzZqHafh/SkZe++mE4am/GCgDQD//kat8jjue7UBF/
        qxyhVbNNodjUxJlxm0CUOKO94w==
X-Google-Smtp-Source: APXvYqzHAQhYp8fNINjjPUWkd0MOy9SXxzzg5tWBkiGTCGadZ7EkYEkFk4nG09bRMrnr33/HOr0rWw==
X-Received: by 2002:a17:902:5a41:: with SMTP id f1mr23668391plm.168.1573961558911;
        Sat, 16 Nov 2019 19:32:38 -0800 (PST)
Received: from ikjn-glaptop.roam.corp.google.com (2001-b400-e27e-4718-13bf-d274-f5e0-91a5.emome-ip6.hinet.net. [2001:b400:e27e:4718:13bf:d274:f5e0:91a5])
        by smtp.gmail.com with ESMTPSA id b5sm4596448pjp.13.2019.11.16.19.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 19:32:38 -0800 (PST)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Suwan Kim <suwan.kim027@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Johan Hovold <johan@kernel.org>,
        Nicolas Boitchat <drinkcat@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH 1/2] dt-bindings: usb: add "hub,interval" property
Date:   Sun, 17 Nov 2019 11:32:30 +0800
Message-Id: <20191117033230.259647-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "hub,interval" property to usb-device, so hub device can override
endpoint descriptor's bInterval.

Some existing hub devices have adjustable interval so the device is
allowed to use different bInterval. This is useful when the hub's default
bInterval is too big, so child device's waking up from autosuspend
takes much time.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 Documentation/devicetree/bindings/usb/usb-device.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
index 036be172b1ae..44bef2ff2704 100644
--- a/Documentation/devicetree/bindings/usb/usb-device.txt
+++ b/Documentation/devicetree/bindings/usb/usb-device.txt
@@ -66,6 +66,9 @@ Required properties for host-controller nodes with device nodes:
 - #size-cells: shall be 0
 
 
+Optional properties for hub nodes
+- hub,interval: bInterval of status change endpoint. The range is 1-255.
+
 Example:
 
 &usb1 {	/* host controller */
@@ -75,6 +78,7 @@ Example:
 	hub@1 {		/* hub connected to port 1 */
 		compatible = "usb5e3,608";
 		reg = <1>;
+		hub,interval = <8>;
 	};
 
 	device@2 {	/* device connected to port 2 */
-- 
2.24.0.432.g9d3f5f5b63-goog

