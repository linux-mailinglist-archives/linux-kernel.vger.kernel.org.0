Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97BC56EF7A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 15:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfGTNZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jul 2019 09:25:05 -0400
Received: from mx1.cock.li ([185.10.68.5]:33767 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbfGTNZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 09:25:04 -0400
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jul 2019 09:25:03 EDT
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on cock.li
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NO_RECEIVED,NO_RELAYS shortcircuit=_SCTYPE_
        autolearn=disabled version=3.4.2
From:   Robert Karszniewicz <avoidr@firemail.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1563628580; bh=T03mKEFFc55zmeKdDGqPIZVXFGNylYNZH2hF6DUQIKc=;
        h=From:To:Cc:Subject:Date:From;
        b=pNDrm8r0DYSQC3XbevN8dNzpq82uKBNQ+cDroXCENpPnR6XSYKIMTSjroT/gpkuhh
         Apig4jjG3OLbERIPrifKMyzcZQGnF2KnXcM6jDoxgTkZ+W6Wta99ZPFu0HjPV/9YV+
         VJXD2PjyE+CvDPBr8oeD/ht1t89ATjyOEnbv+tDfWml7RdGH2EhivRXMwjvsJe7QRG
         L3GtnLbMX0fP1PzEQszdlzNKHdNhwzwGUqv4IS7KReEI6Qe4hx+0796DJUgFqe65rw
         lxJaxVDwP4GB7wxi+SdydaUrW6MBmtQCajhUQbtXtGFmkCjkCLQxMoADV8KDSJpzIi
         74Y8QqWb5bNGg==
To:     Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Robert Karszniewicz <avoidr@firemail.cc>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hwmon: (k8temp) update to use new hwmon registration API
Date:   Sat, 20 Jul 2019 15:15:54 +0200
Message-Id: <cover.1563522498.git.avoidr@firemail.cc>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiled and ran against 5.2.0-next-20190718.

I did not know how to manipulate `type`, `attr`, and `channel` arguments
to is_visible() and read(), so I did not test that. But it works in
normal use (`sensors` and reading the sysfs files directly).

Robert Karszniewicz (2):
  hwmon: (k8temp) update to use new hwmon registration API
  hwmon: (k8temp) documentation: update URL of datasheet

 Documentation/hwmon/k8temp.rst |   2 +-
 drivers/hwmon/k8temp.c         | 204 +++++++++++++++------------------
 2 files changed, 93 insertions(+), 113 deletions(-)

-- 
2.22.0

