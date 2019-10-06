Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D96ECD907
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 21:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfJFT7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 15:59:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44244 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJFT7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 15:59:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id u40so16253176qth.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 12:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VIkpy/BTy4mETTGYhXyFaeQ00CMXQeC2LlAguquFlNU=;
        b=pDwKgK4YdK/MSdTSfrC/TmAWkbMFvvFSShd8fVkQMfx3aAXzSj8hex2s7n1x7COIIt
         h4KQdh2r+KpzkQ0A3CKgE7jJEsLD2LTpKHEBf4z70qBU16XRy5AySI6bgtzj6q+T0v7n
         LCGTtoVf28CCk2wij8bzGt4CX0DQS4Uh/GI7/UEqg3wEjj8NAlti8YamJ9Mt3bHxzU8P
         Q4VrFiuo7EoO9Yw68JbP7n7MEVO5UhsID7REX6KWnCk/DwDApBMGvzxLybTTauqcTJDi
         QPjIRW2HwX04ziBiFo4jNELLUkWuOZ4KOrkNBxfvYYcuAUYprjEPLlI6xrlkd0IvZz3a
         +AEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VIkpy/BTy4mETTGYhXyFaeQ00CMXQeC2LlAguquFlNU=;
        b=dvU7KopEh6S16HuJ78EEAk7qPCOiaeA1rz861xXkQ0tLxYVbNDWUjLnvtciuLmmJUX
         BlrrpHRpetkgznLlx7TcsK+P4D6+gpSanZJ+YWXHHMv/swSwB4EP/hXSUBVw7DBdISoX
         w3lcMRr5LANau1Gvi5g8tShv2IiI9PvsP6uF+esH1srgaQbUTgsGkX7vslJaoJGLMWJN
         X83a55cZilibC89xwMYw6u4Nkb9kYNwZ4GrB27BnysVIW4f30Q1xSavkkeaqDdRYxL1o
         L1Kx34XbI0Utn4ZSxrMygWw2QW+qy9bagJf97P8Tv7QE1ywziJXr0F6Xs8o8+VtPbuqO
         tMtQ==
X-Gm-Message-State: APjAAAXGF4h+H18ujuwTBot3qgbRwyEKtvGXM4A4kad91c2f/NAn8+j1
        p0zjmuNZpdi08KAvUPhkTY8=
X-Google-Smtp-Source: APXvYqx7veuDUF0aEJ2IVMT+VXi/lM3pCmKBg1TD15llbzkY0LhmaMrCug97yL5C8QkcY+WsZnYp/g==
X-Received: by 2002:a0c:db94:: with SMTP id m20mr24595199qvk.142.1570391941678;
        Sun, 06 Oct 2019 12:59:01 -0700 (PDT)
Received: from GBdebian.terracota.local ([177.103.155.130])
        by smtp.gmail.com with ESMTPSA id k54sm9623911qtf.28.2019.10.06.12.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 12:59:01 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, forest@alittletooquiet.net,
        gregkh@linuxfoundation.org, quentin.deslandes@itdev.co.uk,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH] staging: vt6656: remove duplicated blank line
Date:   Sun,  6 Oct 2019 16:58:54 -0300
Message-Id: <20191006195854.9843-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "don't use multiple blank line"

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/vt6656/main_usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index 856ba97aec4f..a1884b5cc915 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -362,7 +362,6 @@ static int vnt_init_registers(struct vnt_private *priv)
 			goto end;
 	}
 
-
 	ret = vnt_mac_set_led(priv, LEDSTS_TMLEN, 0x38);
 	if (ret)
 		goto end;
-- 
2.20.1

