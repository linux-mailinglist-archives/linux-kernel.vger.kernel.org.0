Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15181155FA9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 21:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgBGUiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 15:38:03 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:44653 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgBGUiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:38:03 -0500
Received: by mail-pl1-f177.google.com with SMTP id d9so203259plo.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ifCbiBJDktUTJhTkv9KSAGNf4cll4FIlR1vlR2WCup0=;
        b=ebfLute2BqyBNSLfR3/rTFEZ9Lk6VvKLon7hSktz5FbtUuroU4kw1HVg918t1ASWc7
         1VrAUpvhGqVUYciYlLyARi5kCxpQc5AN4QdSH3i2LH/WX+U2wnm3531IFn0HB6HT+769
         49PmXTNWg0jrtAg0Z34mvxgtr9Tqt3IDQac9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ifCbiBJDktUTJhTkv9KSAGNf4cll4FIlR1vlR2WCup0=;
        b=j4xAB/j++4quL1KtBca+pqVCPEJB1yE2qXu3WGMfdm/nXGosR8tWcYH8PzzmDqi+9y
         8AYJY3MgqhCpHeXInKeRYuU/HIDd6kVgxS5PqEg4MAn4tgIykG0njnzwBYsUcBYR+OE/
         E5aKcGb8g9fCa9hN223TIUUbM1x0J+CxXYwiDmRgvyik5rH4mcNyyjCyePsQjCKJgqRN
         xFg0Xxyz7kxd7PWGnxLvnUvsaHiN404J4yOLtYJapALQdkThnixSKLMh79D+JnN0P6+h
         xvwTmkoA5VNq3tXUwkFXvz0taD+9BJBnbGpvBdZwYHUs7WnCz0gqEPblJXSaChjV7LmD
         u7VQ==
X-Gm-Message-State: APjAAAUCs03sw+S0DBmU0+MJYnCcEOXXv0Ty+o7gd6P4WiEM5FwCNeYZ
        DQhCybsRJ40yjix7jekEsfP1Q2VQE18=
X-Google-Smtp-Source: APXvYqzk42NKqsohxngK4S9f5vG7B8djpKPCB3LdmBDlJ8WzumloON87AggSCNxJk0WZvSKUC0oGcg==
X-Received: by 2002:a17:90b:3115:: with SMTP id gc21mr5649351pjb.54.1581107882002;
        Fri, 07 Feb 2020 12:38:02 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id 4sm4051001pfn.90.2020.02.07.12.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 12:38:01 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, enric.balletbo@collabora.com,
        bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 0/4] platform/chrome: Add Type C connector class driver
Date:   Fri,  7 Feb 2020 12:37:42 -0800
Message-Id: <20200207203752.209296-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series introduces a Type C port driver for Chrome OS devices
that have an EC (Embedded Controller). It derives port information from
ACPI or DT entries. This patch series adds basic support, including
registering ports, and setting certain basic attributes.

v1: https://lkml.org/lkml/2020/2/5/676

Changes in v2:
- Added DT bindings entry in Documentation.
- Fixed minor comments in cros_ec_typec.c driver file.
- Incorporated get_num_ports() code into probe() function.

Prashant Malani (4):
  dt-bindings: Add cros-ec Type C port driver
  platform/chrome: Add Type C connector class driver
  platform/chrome: typec: Get PD_CONTROL cmd version
  platform/chrome: typec: Update port info from EC

 .../bindings/chrome/google,cros-ec-typec.yaml |  77 ++++
 drivers/platform/chrome/Kconfig               |  11 +
 drivers/platform/chrome/Makefile              |   1 +
 drivers/platform/chrome/cros_ec_typec.c       | 337 ++++++++++++++++++
 4 files changed, 426 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
 create mode 100644 drivers/platform/chrome/cros_ec_typec.c

-- 
2.25.0.341.g760bfbb309-goog

