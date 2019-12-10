Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B0C118701
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 12:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLJLsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 06:48:04 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33206 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfLJLsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:48:01 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so13511968lfl.0;
        Tue, 10 Dec 2019 03:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fo/kQPoTgufoLl6OwS4X1boPbPzO5kmha82cPWUC2hI=;
        b=OdNe0vn+8QvjfD8P6ecHAg/78T9yojBKTgVES0rTqrwJ1Zmy20dX2afqpFVknXapY2
         W3OZQTRXrUhYcPcKcD4IgjlU+ioQDUYOLP1NmWBGHlhvoBsyu8k46DA+eaXWFEcnpe8/
         zT4i5XuL1KmwBMabU7yV/yN4C86cCw0vxffqwWge9WYZR8gr7/k4ukoviGHai4kOO+Eg
         1DOfZ/+aI6DCRAsP5FzTGeZ5yZFUfSWHRe/2jCUpcRiIztCGP3nRmEWUr7YKE+Ukuwm2
         hykpNogYp3dWv6bLP7yr6B1eZtbqtGLOojYHj4Jxa/Q+Un10S7EsdDw2fmvbRN7ccE91
         cRRA==
X-Gm-Message-State: APjAAAXJ+LrgAJncIsn7f9e8n0hCcPlHf9ECqnTBt4QSzkR2JZaia4Xb
        CbOjeZ5acO93W4UQIUzarFmM/hSS
X-Google-Smtp-Source: APXvYqxRUBIZ41AnH3QnCgB0Q1gJnSjg59UHuxgq9xRqKYyhr1qDqMrwe00Je2S+QZyu/YP+ZLbnuA==
X-Received: by 2002:ac2:4849:: with SMTP id 9mr18316401lfy.11.1575978478770;
        Tue, 10 Dec 2019 03:47:58 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id e21sm1757836lfc.63.2019.12.10.03.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 03:47:58 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1iedzk-0001LN-An; Tue, 10 Dec 2019 12:48:00 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] staging: fix USB altsetting bugs
Date:   Tue, 10 Dec 2019 12:47:49 +0100
Message-Id: <20191210114751.5119-1-johan@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We had quite a few drivers using the first alternate setting instead of
the current one when doing descriptor sanity checks. This is mostly an
issue on kernels with panic_on_warn set due to a WARN() in
usb_submit_urb(), but since we've started backporting such fixes (e.g.
as reported by syzbot), I've marked these for stable as well.

Johan


Johan Hovold (2):
  staging: rtl8188eu: fix interface sanity check
  staging: rtl8712: fix interface sanity check

 drivers/staging/rtl8188eu/os_dep/usb_intf.c | 2 +-
 drivers/staging/rtl8712/usb_intf.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.24.0

