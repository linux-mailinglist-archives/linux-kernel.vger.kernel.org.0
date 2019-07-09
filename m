Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD3A63B89
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 21:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfGITAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 15:00:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39959 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfGITAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:00:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so9910852pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 12:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=agNl784XHpZcC5LqJknrXQYgxU0CtqquUElpKGVsi2U=;
        b=mM+cViIx9xyiXexrT0Zh5UFoRyGLEmGjKHq5xGLVtu+6hX2D9Xflb35m087yPOGTEv
         2Xd3YFtFbsxce06tMJnfUqCnxvQ8BI99jPS6rnPRrckKhk2lty/H/3JDLY34nN0jGr+0
         Jhznan7TeSV+j2PqhnFvH4vf4Y2JUaaRQLcvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=agNl784XHpZcC5LqJknrXQYgxU0CtqquUElpKGVsi2U=;
        b=V0+1EzXssE3rnJP1dRdvf4wh2qo33IUeM+jrnZIZv7qduMtaXW8wDyQ2DPJbsSoI9C
         Kh82OZM6hlw07rK8xJGjAtOxDKzpprt+zBWB4MITRP2hXxTd1Xbc6JCdYm7I3d1sdlNu
         hyz2rVOfIOrwSGDHiPppgy12O2ail8Uhcwy0ZUbM2lHFXBA6vR0X3LioqP7xNf/7DFdF
         g45Oi6/zTiBOgJLUYffg/uAKXr9YFF7eYXMqlWDiQgSaGcLK7oJ+ys6Nh5VcUSfM0743
         TjEtmO851Uf30P7Rso6UeRBSbDA/1DtZUsrYq9/vuxxyV9GOETvc+eMXOLW3fCu3Fd3h
         sYhw==
X-Gm-Message-State: APjAAAWBW4aXG67pgobFm6ftIYCAnaIBDG/63KDwIpxG0kxlQiSB+LjL
        wBpuK6w3ag4bRAjMWzWikVY1iQ==
X-Google-Smtp-Source: APXvYqzgiljPNQtmksVwQeu0mnKjNy5a2B+0y32N9WtWnsDmQw+D32h0y78iStJjuRbgrXwJH1vfTw==
X-Received: by 2002:a63:1658:: with SMTP id 24mr33215318pgw.167.1562698812609;
        Tue, 09 Jul 2019 12:00:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id x26sm22747410pfq.69.2019.07.09.12.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 12:00:12 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 0/4] backlight: Expose brightness curve type through sysfs
Date:   Tue,  9 Jul 2019 12:00:03 -0700
Message-Id: <20190709190007.91260-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Backlight brightness curves can have different shapes. The two main
types are linear and non-linear curves. The human eye doesn't
perceive linearly increasing/decreasing brightness as linear (see
also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
linearly to human eye"), hence many backlights use non-linear (often
logarithmic) brightness curves. The type of curve is currently opaque
to userspace, so userspace often relies on more or less reliable
heuristics (like the number of brightness levels) to decide whether
to treat a backlight device as linear or non-linear.

Export the type of the brightness curve via a new sysfs attribute.

Matthias Kaehlcke (4):
  MAINTAINERS: Add entry for stable backlight sysfs ABI documentation
  backlight: Expose brightness curve type through sysfs
  backlight: pwm_bl: Set scale type for CIE 1931 curves
  backlight: pwm_bl: Set scale type for brightness curves specified in
    the DT

 .../ABI/testing/sysfs-class-backlight         | 26 ++++++++++++++
 MAINTAINERS                                   |  2 ++
 drivers/video/backlight/backlight.c           | 19 ++++++++++
 drivers/video/backlight/pwm_bl.c              | 35 ++++++++++++++++++-
 include/linux/backlight.h                     |  8 +++++
 5 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight

-- 
2.22.0.410.gd8fdbe21b5-goog

