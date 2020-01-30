Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A90E14E559
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 23:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgA3WH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 17:07:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38201 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgA3WH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:07:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id a33so2360545pgm.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 14:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvzH8AbjRqYwgZSCRrElyzrgMEOt2lnPLlhKUNsXczA=;
        b=CmkpkPGI6f48Ao3Qlk/PNgYIRFJjocvirRL4tBBm+LycmtA/9rRZa13azqr/NS1mfg
         Lu2Sp6Do3Jl1Dk3E9ikKRiSLt48VSUcJ181zaLX0OarwB5tRkXPZOFGDmM5TtGyDgaOO
         ylKkfJm9nG3h2oi/LAhNmyd5s636vr+NYqkss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvzH8AbjRqYwgZSCRrElyzrgMEOt2lnPLlhKUNsXczA=;
        b=L3UaO42UJ98zmrhYymV2KCSoJR5cqVXmoDv2D1i5Q+7bgJcebcj0OcHWoA8LqpNrRM
         cJe8Tvs7eQ89fknohBb/Q/NnUslzl06fzZ1lbNb3lEPcl5Zh8DH0PnuLkOsZhu7XzcCn
         Wc4HfhkI3tTK3xWmOlUXjRxD2GAEoCDXChA+nuBSHi0nOBFngKV27E3ZZj/6tsKmPUBF
         pC6jH0T6xtp9cgle7GthfyZzXXEKPrB9ZR2PhDQQhDyi1sLaTM9qQTzdH8FyjTkxIdbn
         Odu+/xidyW7XrXb9QQBSpPFih5ZYbUL2fa4vGQ5fMg/x3AkmBMC30ILIVeG4C16YcF33
         SY7A==
X-Gm-Message-State: APjAAAXuRWFaH4jnuIRhC7tdqUu0/yQ813Bn89I3ue+bKAfYsPFYuJmG
        xBpsoU7wMG7OcRcHWdYXhMd5fOLGH0VrGw==
X-Google-Smtp-Source: APXvYqwTRDbdc7AEz402e2Hl3thBZPYLzNc7grGJ1pNwpwz3ync9CnOPORWkCXjEJE8SpqRtUHmdEA==
X-Received: by 2002:a63:6d8d:: with SMTP id i135mr6915831pgc.90.1580422077085;
        Thu, 30 Jan 2020 14:07:57 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id p16sm7403859pgi.50.2020.01.30.14.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 14:07:56 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, enric.balletbo@collabora.com,
        bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [RFC 0/3] platform/chrome: Add Type C connector class driver
Date:   Thu, 30 Jan 2020 14:07:42 -0800
Message-Id: <20200130220747.163053-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series introduces a Type C port driver for Chrome OS devices
that have an EC (Embedded Controller). It derives port information from
ACPI or DT entries. This patch series adds basic support, including
registering ports, and setting certain basic attributes.

I thought I’d send it out as an RFC to get some comments on whether the
general approach is right. Subsequent iterations of the series will
include adding port partner information as well as integration with mux
agents. This might tie in with Heikki’s work here:

https://github.com/krohei/linux/commit/976378fbfe4a29b892d39ade07efce042640ff4c

Based on feedback, I can incorporate comments or adopt another approach altogether.

Changes in v2:
- Fixed errors in PATCH tag in cover-letter
- Patch 2/3: Fixed commit title typo

v1: https://lkml.org/lkml/2020/1/30/868

Prashant Malani (3):
  platform/chrome: Add Type C connector class driver
  platform/chrome: typec: Get PD_CONTROL version
  platform/chrome: Update Type C port info from EC

 drivers/platform/chrome/Kconfig         |  11 +
 drivers/platform/chrome/Makefile        |   1 +
 drivers/platform/chrome/cros_ec_typec.c | 319 ++++++++++++++++++++++++
 3 files changed, 331 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_ec_typec.c

-- 
2.25.0.341.g760bfbb309-goog

