Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08308D86AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 05:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404002AbfJPDee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 23:34:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43922 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403888AbfJPDd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:33:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id f21so10567253plj.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 20:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2keRpRTlNq//agdfEU+WzxjuweOfNeyW5raNbEYcYgw=;
        b=v2mpFWC0YeHuM2R8yAg/xDpZt4YlyYEVb2YKwXwoQsMjqhvV4fsR1Q+zHo3hChIz74
         MW6PS7z0+vutQPyCMifBfWFJu7BomzYe3pJZZNJX9fBPaYzen1Y83jxgqRXYBaS7U9H5
         scyF2ijATEZVAZbM+jVPL3xBacyxLHMqGCOE2s+vXhdWKMN15J0X1c+Sg2O7EyOWXzvH
         V52YtiHaU85DASd1pNaSNMJRInWisTGPtptGEwmH6o7Nnegid13neEpqqP3dKTUMjQnJ
         tvTz2rC2F9gEnOwqvQdfEPwBq0sMvAzaAjD+WU5GOr/0YMnusEvDyJFkLqPqltkOQGC4
         Vz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2keRpRTlNq//agdfEU+WzxjuweOfNeyW5raNbEYcYgw=;
        b=avLExexQKTrnkU07U5P9C28wXGFYBl8Npg0DeJ6Eoz8yZN3aarywoUF6reLFPRc/c4
         Wzur2mhN5uOMR0Lx46sjCqX1ec8Pzlxu6n+oEiaYS1MQ42gPiPSl7NWgDwCGzeiVxkqi
         KMs6Mc1sjjgsGjm2EQM7dIKvxDq5kkDmEC7n2fyNiQHpk4jB0K6bHj2wpbvfbyixBoPy
         ti23ArtjCntSK5Ilz2gQ3puszur6OpTUZVETOFyYxn1lJlIgIRKKCX7FC7b13HGABAp+
         w2mhAGJ0/oU8NxHW/YRgUHP78KZs0h+d4ZoGq8S9xFnE0YXW8yJ1XmyJqzNs7/0/tG2b
         0YWg==
X-Gm-Message-State: APjAAAUU6s3V/WkjBd4b7oMuDIyCpTDx+I3odhPTVgMbFBuYckViXAFx
        cG+u+KAhgnCmdisT7NiFGj+N2eKlEKg=
X-Google-Smtp-Source: APXvYqzHJcZTagsu+7PgWeGgCQGg5oFBlQy68utODPD6pCC+Bv83uRYHQVAk7xRaFQ4dZKLhn4gl5g==
X-Received: by 2002:a17:902:7891:: with SMTP id q17mr15072798pll.241.1571196835824;
        Tue, 15 Oct 2019 20:33:55 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id l23sm748356pjy.12.2019.10.15.20.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 20:33:55 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC][PATCH v3 08/11] dt-bindings: usb: generic: Add role-switch-default-host binding
Date:   Wed, 16 Oct 2019 03:33:37 +0000
Message-Id: <20191016033340.1288-9-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016033340.1288-1-john.stultz@linaro.org>
References: <20191016033340.1288-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding to configure the default role the controller
assumes is host mode when the usb role is USB_ROLE_NONE.

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
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 Documentation/devicetree/bindings/usb/generic.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
index cf5a1ad456e6..013782fde293 100644
--- a/Documentation/devicetree/bindings/usb/generic.txt
+++ b/Documentation/devicetree/bindings/usb/generic.txt
@@ -34,6 +34,11 @@ Optional properties:
 			the USB data role (USB host or USB device) for a given
 			USB connector, such as Type-C, Type-B(micro).
 			see connector/usb-connector.txt.
+ - role-switch-default-host: boolean, indicating if usb-role-switch is enabled
+			the device default operation mode of controller while
+			usb role is USB_ROLE_NONE is host mode. If this is not
+			set or false, it will be assumed the default is device
+			mode.
 
 This is an attribute to a USB controller such as:
 
-- 
2.17.1

