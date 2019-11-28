Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96C5F10C9C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 14:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfK1Nnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 08:43:52 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:54368 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfK1Nnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:43:51 -0500
Received: by mail-wm1-f51.google.com with SMTP id b11so10972793wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 05:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o+iHIxlIN4MptFBLCWkD6Hnybsie41iIVhFreDdUdvs=;
        b=R7zh1lfko1DMn6/CVNUdzYrx7i0Lbnb6Y73yYqnaEr7tb/4QZB4NqcxmB2eSNqhAbM
         493lYZgCtfOOrlSFfZvlVP/LrokhGWVgwd919bYCo9OBcATQDo2eSMZzZpzw0AOaM2yo
         nomr+u1Flwa4XMgwnQt0aK9sQnCEkSSgZmiJf1xdVi6JIMTA0I8UUak69FUXCDn2e5WN
         ryWNleR1eI+IvBjeCH8ZSgZUuuLx1/EjciuafJOyy5iEOgYyJaky4YVgo11JZ8WgSCcs
         YOa97w59/7yf9GD2/YPCR0y/cgapaBZsl5l0MvDzLkIVyLgxCK5yrL/d4FKz8ZoDQPKa
         cUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o+iHIxlIN4MptFBLCWkD6Hnybsie41iIVhFreDdUdvs=;
        b=ks1u1Q9cc5RseQQgC7wjqUmeZhF/BSpWBnafCVJ4mH5auWc5wlRUX6QRtE/eUIA4hs
         WXgGxrlQOeMWlkCYlvZtYmBx+SzrAu0Nmm0ZIW4Ncfj4JWOjVO2pG5TDfiCfVdnPPMHK
         gK755fE+EFIfQvxxrxsR1s1XqqvM5yA7JZAWRDyfUXjg6MmECLLpyB1BBUKvLu52BS8M
         dEPlt8chKpdRaZLshkivB1TtbF+CFu5pwblSragv3p8fpHOeWCv1eGgYR0Nfp6Yt8kVs
         /AHG1ZY4jgEhk6nA+xlAEk38p/wcG7cGOCjikGytrT2zYd+i3Rzb6R86e60HdYSdJH+l
         trjw==
X-Gm-Message-State: APjAAAVM+co8/OXCQul1FBX3h5NRsQGG7IffhRZbYEFaEFXOJcHshHks
        sL6LT8PYZLRBuj/11ePBR41GAq8salI=
X-Google-Smtp-Source: APXvYqwQq5k81aEfW2o6MsMt6nrxm9MGC22wBYXxX2SkF/MpRhdORS/Y2lwvt+cOdPSGA3i4YKjm7A==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr4659024wmo.12.1574948627390;
        Thu, 28 Nov 2019 05:43:47 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id u26sm10743407wmj.9.2019.11.28.05.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 05:43:46 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/2] Two minor USB related fixes
Date:   Thu, 28 Nov 2019 13:43:56 +0000
Message-Id: <20191128134358.3880498-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set contains two minor USB related fixes.

The first patch fixes usb-conn-gpio. We should not print out an error
message when trying to get a handle to a VBUS regulator, if it is a simple
deferral.

The second patch fixes the description of the USB connector bindings. It
reads a little funny lacking indefinite articles.

Bryan O'Donoghue (2):
  usb: common: usb-conn-gpio: Don't log an error on probe deferral
  dt-bindings: connector: Improve the english of the initial description

 Documentation/devicetree/bindings/connector/usb-connector.txt | 4 ++--
 drivers/usb/common/usb-conn-gpio.c                            | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.24.0

