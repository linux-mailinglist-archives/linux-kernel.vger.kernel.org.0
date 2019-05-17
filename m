Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32678220BE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 01:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfEQXjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 19:39:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46022 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfEQXjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 19:39:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id a5so4000853pls.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 16:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8gZh6LcPIYENuLrq70OVrhE14Oi6QufFQBK4s4YRnTA=;
        b=EhXvzRJ2UNIKuLYIDrYvKv7KlCJ6hRvEdoKK4G+NX9Cy3ga1z8x2Nr1dLy4TCfWI1O
         qL0ke7KwVeOA+vRJ6MaIRQjOJNX2BIEvwwIdYyAi9G3mbKCsFsQA/hW+8kxDoeg3Suoa
         0FjzyYPtbOwgzRugPy26xg40vCKMm7clLdCfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8gZh6LcPIYENuLrq70OVrhE14Oi6QufFQBK4s4YRnTA=;
        b=SNY3wnq4R4gpLBAwPn1CFteJwlBcSiYlGXscuM/NcZygKFlG199D5pGkb3PVgvJw/3
         abG6AwyfbDH349gBcSj4lwFhIAIA427+kSJzRGOSdKT76gLHOiIcAdiH3JeFzjo5m89W
         1/QRsLAmZLdtIpKJvqM5nbXTM0pUV2aa1PxlJIY4zGaER9CNwNKjj8qXWJvLTrcdP0on
         9o1jUwk6lX+OaduFozW1IcO4+RaYbS4xXzU/g5rR3LW5FEnI9yrUjP/QG7uLYdipPEj0
         PFa0Sbhwfj9U/+mVYmBwiPoohYoofGSFttx6vspcNbtXeIZgWAibKT0QCAkeosT1CmPb
         +ktQ==
X-Gm-Message-State: APjAAAWDEYxggSs0hD3XMQSIWSJAOQpKnUBbnQuBGnhVvMEj1lN5BFFP
        ugYTfqi6UJMb5RtLX1yLrvtQTQ==
X-Google-Smtp-Source: APXvYqwnCjmbdahiVCeyMEGBBy/0dbUgS20VbJ6HKGzQTQ7jzlmlJtcP33gai1+X0v2x8vrlINpAkg==
X-Received: by 2002:a17:902:56d:: with SMTP id 100mr59564890plf.246.1558136342873;
        Fri, 17 May 2019 16:39:02 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id j184sm10081827pge.83.2019.05.17.16.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 16:39:02 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 0/2] iio: cros_ec: Add lid angle driver
Date:   Fri, 17 May 2019 16:38:54 -0700
Message-Id: <20190517233856.155793-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a IIO driver that reports the angle between the lid and the base for
ChromeOS convertible device.

Tested on eve with ToT EC firmware.
Check driver is loaded and lid angle is correct.

Changes in v7:
- Split the patch in two, as there are no build dependency between
  mfd and iio changes.

Gwendal Grignou (2):
  mfd: cros_ec: Register cros_ec_lid_angle driver when present
  iio: cros_ec: Add lid angle driver

 drivers/iio/common/cros_ec_sensors/Kconfig    |   9 ++
 drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
 .../cros_ec_sensors/cros_ec_lid_angle.c       | 139 ++++++++++++++++++
 drivers/mfd/cros_ec_dev.c                     |  13 +-
 4 files changed, 159 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c

-- 
2.21.0.1020.gf2820cf01a-goog

