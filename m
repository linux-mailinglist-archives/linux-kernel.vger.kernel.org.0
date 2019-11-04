Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07637EE733
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 19:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfKDSTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 13:19:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45987 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDSTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:19:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id q13so18248658wrs.12;
        Mon, 04 Nov 2019 10:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I+QRfJpzWYcc0VUlAj0QtfzbI2Rjy1BtEqPONYKKsns=;
        b=nrI6pyFxlJJ/Sh5yCFYgIIOi896ksb2VdZyU45EOv3Zbik2WxeX55euQZkTeLXI/UU
         uNsGBkBvwS9+MseS40qMVkNh87BdmAh5qoHY/H0UxjHs0B/1zevL6lIEEvjoYCGGBgDs
         ybFGmU42Rv8stZLkqQDDkUrKTWfxwOpezFtHQnWMX7z/DqQVwKCMQCXbzQ58f079T7nZ
         kAR9evzHmclrrmcuXa8W9vQ5jb33s6GU34VBJB+cLq1Mvuz6Rg8LspPMhOZlQaTL1NZU
         IGSiqD6JLtX8Ns55EwXuRoBhAZOLGX7H9JiVBR1jyc+C/KzflMWIgbNCyg8l7Vqn4PGH
         qG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I+QRfJpzWYcc0VUlAj0QtfzbI2Rjy1BtEqPONYKKsns=;
        b=Qt6FzRvbiynLJjdnXLYPJVdZKP+pvkjNNDy1eIjSyCBK+mZ6GIxxgACvqh7AmJID2m
         HNBXSEc6A/8O5BvZWQkvr0jwHEujtaVwxRwWMv+C8pSASgUiLVcpc0gveXN4fHRciRxn
         8jckLVv9ooqw/RpZ609YuBC8Cb2Wr+NjBU6SsW0A+2R6+BLR90JJkUG2Dp23FcFIcwTd
         nqof7+9okrNlwjSAczVy8qa77lkCRuaNWwasiQ36V14G5PdJ59ekLjlhGncypFWMVVGo
         cjDWnB0auZm2nvXzHS1tg78FAgqjGb5WtnMGZ2hECC5CcZD6ZSprlemP+4gl2tivAyPB
         ti5A==
X-Gm-Message-State: APjAAAU9NGgJNhqqe+0PmARfGVQEeq50pgk45pTcjU79kxRrJ6kb+bGG
        Hw3SKJOeCHaQTciYTLXOIBOd8vCJ
X-Google-Smtp-Source: APXvYqwSEOrggiVd5Rc/9kIWu4FLMEPqYNsz2bL+qeBa7mKcroomsBYJ5tLn/GC3BAy/gEMO83Beqw==
X-Received: by 2002:a5d:4748:: with SMTP id o8mr25403387wrs.239.1572891554760;
        Mon, 04 Nov 2019 10:19:14 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w8sm23127580wrr.44.2019.11.04.10.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:19:14 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] Couple of reset-brcmstb fixes
Date:   Mon,  4 Nov 2019 10:15:00 -0800
Message-Id: <20191104181502.15679-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

This series replaces the previously submitted fixes to the reset-brcmstb
driver and also fix the dt binding example.

Thank you!

Florian Fainelli (2):
  dt-bindings: reset: Fix brcmstb-reset example
  reset: brcmstb: Remove resource checks

 .../devicetree/bindings/reset/brcm,brcmstb-reset.txt        | 2 +-
 drivers/reset/reset-brcmstb.c                               | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

-- 
2.17.1

