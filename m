Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954CF1A2C3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 20:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfEJSBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 14:01:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34128 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfEJSBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:01:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id n19so3631243pfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y3PrSmEv0h+7/cgWARZro1mk4o7JJ5uqr2jnlJfBMOU=;
        b=lPyZnidehOoRFVfodpmKqMrBiAPD4Vl/EDIWjlRe1C8tP9h+82DqG7zBoqpSk1ZCz5
         j89xvOlA+S0CiI67jOr8EKYaWf3nABwuAxAAfzfgqBotGGLfhcrf3BQ+YCuZ7kzWKiga
         xA8BjNCS8QEFBiUbU8nlZ8aGjqVentskDBatk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y3PrSmEv0h+7/cgWARZro1mk4o7JJ5uqr2jnlJfBMOU=;
        b=sxfEQ9WYi5d317VFxf5Hw8Mvy+Co8UIBijr2pQB9p/+ezbxXx7NnddQ0D6IgE/dy9b
         3gB1+zjTHr7NMYCCotvvH0cXcW/hiZ4C2qEc6gMrgJFh3iY/fdnCDJF7YawILO+UlAvq
         r1wip+NtJ2DIMZuCRdMWBjMVMnTNKxZYKIxAJk25KvGhnNdKiFRc3lqtY08fMarKnBs6
         NlUowXw+AAZ/Fgw0iao+M7K0VOlXjRVsnhKUBQgt67K03icyOT8+a7aKzgnFqB1sRoL7
         11XwmjC2PD1QCZZ2m7oP7hIJf9bxDViyl666CnVxedFiIgNI3Wes7RG2Eh6OGUeK5Zj6
         QglA==
X-Gm-Message-State: APjAAAWzRvtnnY8Gpgy9+oTvSQTQ3PFL1FdJcs6N4OUGp6htpIAoJ4az
        WZkYVb4+DpHj3AiR4DCxcQoV5A==
X-Google-Smtp-Source: APXvYqwBpQDlwPke7rKvsN423OVXQF1GFNgq1sCOrE2t15RQs1y7ADILVN1RMq4WP22p5zaS6qjTpg==
X-Received: by 2002:a62:d44a:: with SMTP id u10mr15943614pfl.227.1557511313621;
        Fri, 10 May 2019 11:01:53 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s19sm7556740pfe.74.2019.05.10.11.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 11:01:52 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 0/5] Misc Google coreboot driver fixes/cleanups
Date:   Fri, 10 May 2019 11:01:46 -0700
Message-Id: <20190510180151.115254-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's some minor fixes and cleanups for the Google coreboot drivers
that I've had lying around in my tree for a little bit. They
tighten up the code a bit and get rid of some boiler plate.

Stephen Boyd (5):
  firmware: google: Add a module_coreboot_driver() macro and use it
  firmware: google: memconsole: Use devm_memremap()
  firmware: google: memconsole: Drop __iomem on memremap memory
  firmware: google: memconsole: Drop global func pointer
  firmware: google: coreboot: Drop unnecessary headers

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Guenter Roeck <groeck@chromium.org>

 drivers/firmware/google/coreboot_table.h      | 11 ++++++++-
 .../firmware/google/framebuffer-coreboot.c    | 14 +----------
 drivers/firmware/google/memconsole-coreboot.c | 24 ++++---------------
 drivers/firmware/google/memconsole.c          |  9 +++----
 drivers/firmware/google/vpd.c                 | 14 +----------
 drivers/firmware/google/vpd_decode.c          |  2 --
 6 files changed, 22 insertions(+), 52 deletions(-)


base-commit: e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd
-- 
Sent by a computer through tubes

