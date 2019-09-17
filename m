Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4B95B577E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 23:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfIQV1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 17:27:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36393 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfIQV1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 17:27:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so2913150pfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 14:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KQLz48qGupB3U3q6Hm9UR083MeuUpn5l8eEYZ8P5LH4=;
        b=BCnH8N+v2Ndf8nZ0xfh7LR+M4kkjyoeZ9PT63+Jj6BMVvaEbYgtYK8KXQItxswnrYd
         5VAsNknB30Szust6QXMPRDzNNgR6pSwWmDW0Cxodb6nQbCR0nWNkMebeWcW6oOxGJaOh
         Y6tn4n6yykauA7gfG2Q2Cz+h/TV3DMQ0bSVFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KQLz48qGupB3U3q6Hm9UR083MeuUpn5l8eEYZ8P5LH4=;
        b=dKT4STQ7hjU6VxgOYkwWJAwEa69qJd4WpuNy6wmz3j2h7eCl4saS/51Dwh/OFQLP5Z
         APDa5Fct3Mduw6dXWDOJdQQofVjDPUiEe89RqJ36WZGCfJtl6eqlJ7UE5OGW+HlVptDD
         JMqWwDWHt9+kj8TbP9OBxt0MvketYkN9bE2W02kxvgSDkxdQ8Kozg0e5GJu4TugQCj6A
         StQSYA6TXOvD/4/TxHY1Scw4p0R50g1CNp60kpt6g1xUmvOjjB0CBR9ASI7TZud18Rem
         AGGNJHcHvuNqwfrSbS+0gLEa+KFo2jM16lSRjrEWN/aSWcenMuYA0RvqoRixyQRjEebJ
         OgMQ==
X-Gm-Message-State: APjAAAWB/6VAoFW5lhxhS6qkZq8/19rGrJseTdfzopQYoLXuGdu8lNBu
        WMnnAy9t3sqV6pwLY20m1TfXEQ==
X-Google-Smtp-Source: APXvYqwrNqaZUJYT/gTjZKUsczgj5OqMIQHDe2jbqIfs1EULCI8Vl/6owKyGElJ4hykt9BdVCbqwUA==
X-Received: by 2002:a63:9245:: with SMTP id s5mr862110pgn.123.1568755624437;
        Tue, 17 Sep 2019 14:27:04 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id l7sm8489803pga.92.2019.09.17.14.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 14:27:04 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hui Peng <benquike@gmail.com>, linux-pm@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Len Brown <len.brown@intel.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mans Rullgard <mans@mansr.com>, Pavel Machek <pavel@ucw.cz>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 0/2] Reset realtek bluetooth devices during user suspend
Date:   Tue, 17 Sep 2019 14:27:00 -0700
Message-Id: <20190917212702.35747-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On a Realtek USB bluetooth device, I wanted a simple and consistent way
to put the device in reset during suspend (2 reasons: to save power and
disable BT as a wakeup source). Resetting it in the suspend callback
causes a detach and the resume callback is not called. Hence the changes
in this series to do the reset in suspend_noirq.

I looked into using PERSIST and reset on resume but those seem mainly
for misbehaving devices that reset themselves.

This patch series has been tested with Realtek BT hardware as well as
Intel BT (test procedure = disable as wake source, user suspend and
observe a detach + reattach on resume).



Abhishek Pandit-Subedi (2):
  usb: support suspend_noirq
  Bluetooth: btusb: Reset realtek devices on user suspend

 drivers/bluetooth/btusb.c | 26 ++++++++++++++++++
 drivers/usb/core/driver.c | 56 +++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.c    |  6 +++++
 include/linux/pm.h        |  8 ++++++
 include/linux/usb.h       |  3 +++
 5 files changed, 99 insertions(+)

-- 
2.23.0.237.gc6a4ce50a0-goog

