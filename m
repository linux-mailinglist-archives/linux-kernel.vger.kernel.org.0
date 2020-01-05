Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB195130A8D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jan 2020 23:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbgAEWzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 17:55:19 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:36065 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgAEWzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 17:55:18 -0500
Received: by mail-pl1-f182.google.com with SMTP id a6so20389465plm.3;
        Sun, 05 Jan 2020 14:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYZvTD2Hhh9EDNEJ70SbgSydilCYXoX3qCEplTAXj14=;
        b=XD5cg7/r3P8qQCucl/gndiwqIjS5znNNVdz19MjDNA4/TB8iId/DnArS3P95qUJWwP
         0P6M52KfsLItmS1CPvHlFmVsXyz+DiRA3B1kW98Fq8oV7Lv0I6L0JyISSdBxXNBUbtNW
         Kr3+ZeGpZQL4lTCQh957BOnzV0tORkMIAQCJ/bKoQdv3K361uCj+h17ZyHGogMrY1DQK
         3LlyBuXYaREuVjwgidHwTgs9+dEU7G80BGHbteHKFi+iVN9UxOChW0UsQ60ILkOA2j14
         ZFvSzvZfxBxFUDRqsAao5BMNqIcm5yQ+9x7+xgug6u/nEkE2X2nC9DURQDMp8EKyjcZ4
         ipQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYZvTD2Hhh9EDNEJ70SbgSydilCYXoX3qCEplTAXj14=;
        b=Xco87EgT5ATklCUsPtSB66JnJLNbJmW56s8NVubAJJF+W9gqNzIiwIqBTAW7A27s/T
         QL5u557bJNh5Eb4KHP+02stXsbJtoCQwAWwefdEJUdxz5/bDgxmIKIiyYaAAObolIsgY
         wGcHbMuN8Kdm6Bn8lADvSNENZRtRfW66XQhFKwH1YsRi0EciFZbh1uAPHLGikwuTg1TW
         09Nnl/t3WIesXaxtLsMQXEMlPOInBIz3NcauscxY1RL3/J4tvNdhLGsHzjBat/f0Huz0
         j00vWgkrQZJu70eJwH7iMMoN9VRHxCvUJrpz6uISftL5YlDHoJjiJw4glEXYvDeUjA8e
         lCyA==
X-Gm-Message-State: APjAAAU1zMzTHnDhzps1IL5oiUyfuuJw7DrG0QuiFQJ7HEPRM7uHO+Fy
        ej2MlvKIb6QEGlIUNaYPEUg=
X-Google-Smtp-Source: APXvYqzIJXzFUCwK9ttAIpKMaBqM5ShRKNUggVw8BaaQEFinm6E0J2rkJqLVuxpaOs277pQoJqo/yw==
X-Received: by 2002:a17:902:441:: with SMTP id 59mr38342671ple.190.1578264917901;
        Sun, 05 Jan 2020 14:55:17 -0800 (PST)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id q22sm77059940pfg.170.2020.01.05.14.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 14:55:17 -0800 (PST)
From:   jassisinghbrar@gmail.com
To:     balbi@kernel.org, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH v2 0/2] Max3420 udc driver
Date:   Sun,  5 Jan 2020 16:55:09 -0600
Message-Id: <20200105225509.21590-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

Changes since v1:
 # No functional changes, just cosmetic changes as suggested in review.
   o prepend everything with MAX3420_
   o avoid CaMeLcAsE
   o use GENMASK some more
   o reorder struct max3420_ep and struct max3420_udc members
   o added some comments
   o changed license in dt-bindings
   o changed interrupt property to names

Jassi Brar (2):
  dt-bindings: max3421-udc: add dt bindings for MAX3420 UDC
  usb: gadget: add udc driver for max3420

 .../bindings/usb/maxim,max3420-udc.yaml       |   69 +
 drivers/usb/gadget/udc/Kconfig                |   10 +
 drivers/usb/gadget/udc/Makefile               |    1 +
 drivers/usb/gadget/udc/max3420_udc.c          | 1333 +++++++++++++++++
 4 files changed, 1413 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
 create mode 100644 drivers/usb/gadget/udc/max3420_udc.c

-- 
2.20.1

