Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6CFB1539D2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 22:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgBEVAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 16:00:07 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44656 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBEVAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:00:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id g3so1544462pgs.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 13:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkdK+w3U6i8S/R8ybgWONyXqyKhVQqPu9Z8fgYXJMtg=;
        b=lMUbxPAEa6yxcDff7IbmI01EPoGO+TmSVV8ONWipypxT/qfJs95Zcchuv0LxjKAibz
         ykSsPcsXz3MZ/bOS5le+TaH8Tb3k+1PrvfCrts5hm9xue1/rA54dVkyDQPr6zhey7aBd
         6we4l3NBgnNYhVcsbUXgj2/E+ht+w6kp3e1Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkdK+w3U6i8S/R8ybgWONyXqyKhVQqPu9Z8fgYXJMtg=;
        b=VD5OrW+t07ZAqukr3sZx+MY0HdvOsSyNmuCJ1fWuKebvupR+YLIYRd45B9olMJbMmf
         7oOm4waNb81BDCG9kGw4LJUxTYKJoUN6FaRj6OY6zznX6+jD8tMEgYMN76xFRNsxFIE7
         Kcl8M9jVIrbDe1SSaLSxL3u+trvF6jUrtkthot75z8muFhRoGU8MJzPMgWSSC2YAgDBl
         Y9WaTGrCjEA5UuWnm0y5PrlJXJdJ/ilgYDZy6TYEI3riOr61ELyupkEwVC9pkciSlBLZ
         /WZnSxiIBrB8fqaVTOchBDgo2YkVCzx2uJsCoDkVoyGBMsAPVD4FSmfRioX8o1k8GY+v
         4AGQ==
X-Gm-Message-State: APjAAAXBj3ntUTyYRS4wdmxQk8BA/ZQc+EvOWIEg+iC+xYnYsxtbhKHj
        qUW/qxFYrdGJ5bwGucMLd7PrsqGyoZg=
X-Google-Smtp-Source: APXvYqxgljWDiYv68rVTNgd03FyySIH3BpVa+oX0FHJgstATcQO2R4k8tpdO+Ekspf5J97kGhzJ3eQ==
X-Received: by 2002:a63:8a42:: with SMTP id y63mr24148745pgd.266.1580936406610;
        Wed, 05 Feb 2020 13:00:06 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id f8sm648797pjg.28.2020.02.05.13.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 13:00:05 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, enric.balletbo@collabora.com,
        bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 0/3] platform/chrome: Add Type C connector class driver
Date:   Wed,  5 Feb 2020 12:59:48 -0800
Message-Id: <20200205205954.84503-1-pmalani@chromium.org>
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

Prashant Malani (3):
  platform/chrome: Add Type C connector class driver
  platform/chrome: typec: Get PD_CONTROL cmd version
  platform/chrome: typec: Update port info from EC

 drivers/platform/chrome/Kconfig         |  11 +
 drivers/platform/chrome/Makefile        |   1 +
 drivers/platform/chrome/cros_ec_typec.c | 346 ++++++++++++++++++++++++
 3 files changed, 358 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_ec_typec.c

-- 
2.25.0.341.g760bfbb309-goog

