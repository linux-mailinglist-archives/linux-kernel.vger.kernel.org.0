Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E91A332088
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 20:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfFASoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jun 2019 14:44:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41994 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfFASoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 14:44:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id r22so8168791pfh.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ler6yPgxESvUZWosJ0/vEoXdp3cJUy8thsd7nZFz1rc=;
        b=c8ky2V27u5c8brbvTUUqoVnmaumy+r4hb5An+cK7Mg2jLy9SkQ5FrB+HXnr8AJuMI+
         SuuJvrcqUuobTltG5TBS0vPSrwBTbcCiTAwTBSMbAZRHZ9702cLMHZ+o2lLLDlq9N4wU
         WA/iw+SwGUpeGBQjHLo5r3O7A4H82Kv3uqjwC202U1j99DDIeEHiZN3Qqjrif6kSdv77
         Nw8exKlf/Uf005i354wTzdvREdLLYszkU6y+44C5BhGylIquOfvnE3QQk1ish3gyjeph
         /44Ff/4d/wH1PXYuaRHoFLZ6SQ9D8heUcNIGmiEFfC351FmFpRn1lzXJ9d83xx1sHM1P
         W0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ler6yPgxESvUZWosJ0/vEoXdp3cJUy8thsd7nZFz1rc=;
        b=ErUnls9iGC5yI3Gkdy8VpLc3/21JSWr+U47BP9gGPFDFgmEDtXee5gawHY74VfoKi5
         gBz2LeydKgQSrejenBCVVVmEQYCKRxuQA6QlBQt9zkp87TKcPnzf71dadGHLk6ZeBw+o
         axnzZ9+5pN0yakMIlTRGLVrhLjHPutNvJAYAQH7HzCfQTNQeR1lVugpO/LyYif+ZWjOw
         Vt/+5yN+/oZQDYQDq3nQeERwsuGlHqPC33Lf4SYcW4+HiAtz+ce2NVPo56FYhdzrZw5n
         3xuM85fTv8Msv207bdnWr6gl1MnQpMMGNIt7Kxyg7UFIRw34Tvw4PaCfTgCwtEqykVA2
         Qixw==
X-Gm-Message-State: APjAAAUCoIUoEph2oR12MN+Rj8THRxd5NMXWmzr4vX06esxduyNbmh+N
        oGikSsGEw/es9I8/d56Wvq8XhpgS
X-Google-Smtp-Source: APXvYqw8GtLttu4UnfzCKLtI9SLCW39xWDLiR5WlIiSm7jhg7QJeya6ZmaL1uivGwso2iBwey7PfjA==
X-Received: by 2002:a17:90a:1a84:: with SMTP id p4mr18458908pjp.15.1559414641956;
        Sat, 01 Jun 2019 11:44:01 -0700 (PDT)
Received: from localhost.localdomain ([117.192.16.207])
        by smtp.googlemail.com with ESMTPSA id w187sm13287950pfw.20.2019.06.01.11.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 11:44:00 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux.dkm@gmail.com,
        himadri18.07@gmail.com, straube.linux@gmail.com
Subject: [PATCH 0/8] staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
Date:   Sun,  2 Jun 2019 00:13:34 +0530
Message-Id: <cover.1559412149.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes CamelCase checks in struct _adapter in drv_types.h
and in files where struct _adapter is used by renaming the variables
without camel case. 

These check were reported by checkpatch.pl
  
Deepak Mishra (8):
  staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
  staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
  staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
  staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
  staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
  staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
  staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
  staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h

 drivers/staging/rtl8712/drv_types.h        | 18 +++++++++---------
 drivers/staging/rtl8712/os_intfs.c         |  6 +++---
 drivers/staging/rtl8712/rtl871x_cmd.c      |  2 +-
 drivers/staging/rtl8712/rtl871x_eeprom.c   |  6 +++---
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c |  2 +-
 drivers/staging/rtl8712/rtl871x_pwrctrl.h  |  2 +-
 drivers/staging/rtl8712/rtl871x_xmit.c     |  2 +-
 drivers/staging/rtl8712/usb_intf.c         |  2 +-
 drivers/staging/rtl8712/xmit_linux.c       |  6 +++---
 9 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.19.1

