Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9CD684BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 10:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfGOIAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 04:00:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39697 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfGOIAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 04:00:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so15951114wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=tRiygra6hSab9PFk7Z9l6xuTrrsQkkS59G9VqyWlvsE=;
        b=dBi+QnfIcUoydfxe/b9uChM0bWF1MH/g7YU3dK7ZPo33+WHMTkTstbA05nrHHROLUZ
         HREkBSKnMdTIjiO6AvOCbrnqjmEI/ylmmYUW1A91+QoeoTvMQv58UWgg2Wc0P7ohY2yo
         +8qa20aCc3FE7ii1++w2KBn851VxQrlJ/fEej5ww9SmJDjEzCPjCD9EOmpfKMFAFhl1/
         RkZqCsnabA/rt3uHq46eYmhYMnawKTdb56VkCOv1doi5ciN4Ft9Uqc5hnbI72xL99U2C
         4T+tsc8GOE/mZIZD14zpfnISxNbmC1pOIj/8fDbxit7b8/sMwm+TQJZeGpujG4KVMYp4
         9lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=tRiygra6hSab9PFk7Z9l6xuTrrsQkkS59G9VqyWlvsE=;
        b=AYJy/8cZlLPTx0TWzxKAz/+yQJ9dvwO03Y/tGKm+2D9BP+jgk5zmw+rqLHDNknrTjd
         DrhVs34QoGxtOO8peC2xb1DhmqNYhbo/g1wlTfuOcgBDOucBm/eY7QSd7zGKCVP/kmZ8
         w/cfPSljIio/TT37ApAmqx+CVSQtD5iZCNEkg5XS6OaZ8g5bSTPp8Ez9N2S8pgEpoQf7
         8tpwnD+S7CAchtB54tIWirusD8k5aVP/rrZU49p9YkmA/gyWSP4pHDH5/iP/wlRmeupP
         DPvPbWRn6QT3DQtgSrETU9vWMvGINkBIrQzm/3oV3sVHg5IPa0e/S/8mqKw8mCmFRaIs
         vXvA==
X-Gm-Message-State: APjAAAVbf7TELNxiRWKmkCKijg8K6kJAZmFECV8ilpN2YhkRkBEG3EI0
        DViFXcBfN9kQ2KbB5pjrdtS3sNxx4C4=
X-Google-Smtp-Source: APXvYqygs+Zsureb7Rdj9ooOAYh0zlgrKeh6Imi7zAWE9+6+ZFdavwB6KT3ZFonhfGNpYio1VO39vg==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr12695818wru.246.1563177611708;
        Mon, 15 Jul 2019 01:00:11 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id a2sm15850877wmj.9.2019.07.15.01.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jul 2019 01:00:10 -0700 (PDT)
Date:   Mon, 15 Jul 2019 09:00:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Backlight for v5.3
Message-ID: <20190715080009.GD4401@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.3

for you to fetch changes up to 73fbfc499448455f1e1c77717040e09e25f1d976:

  backlight: pwm_bl: Fix heuristic to determine number of brightness levels (2019-06-27 07:09:05 +0100)

----------------------------------------------------------------
 - New Functionality
   - Provide support for ACPI enumeration; gpio_backlight

 - Fix-ups
   - SPDX fixups; pwm_bl
   - Fix linear	brightness levels to include number available; pwm_bl

----------------------------------------------------------------
Andy Shevchenko (2):
      backlight: pwm_bl: Convert to use SPDX identifier
      backlight: gpio_backlight: Enable ACPI enumeration

Matthias Kaehlcke (1):
      backlight: pwm_bl: Fix heuristic to determine number of brightness levels

 drivers/video/backlight/gpio_backlight.c | 23 ++++++++-------------
 drivers/video/backlight/pwm_bl.c         | 35 ++++++++------------------------
 2 files changed, 18 insertions(+), 40 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
