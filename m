Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDB92A8F1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2019 09:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfEZHN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 May 2019 03:13:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40434 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfEZHN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 03:13:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id d30so7315787pgm.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 00:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cz2fi9b1NEdvG3USz4empRfMlJ8de9OfWLCS3YX3h5I=;
        b=vZ+5axblbVTq6lqFclbj+ZWvS6CR33hW7FI3rTwB08+YsSclCieOvcZKR0BYiKd246
         wPWV6pqKQ0o9IMGhNxPduLOwa3kOP/XqV/Tf3r70Nz2iiGOAZQftzsqPmesb4mjRhGIT
         j8cOq902MreDIdxtNL+BbCYMEb4kix5xvAK/sh4F8JNZKJCaw9Xh7JNiBzXFHlnWYMdW
         ZKiIYvljPHe4WyVochIUE08b78Gg05gorUM8SK27BuBrjAiSFmg5tMaxxBO6Zrk0SCea
         XbgSKYFbF13vYgDRe/WsYXVpfaRPigMBlYdovZN3ahxzcYtUm3h1rYFN+z65zvuXJjqq
         pyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cz2fi9b1NEdvG3USz4empRfMlJ8de9OfWLCS3YX3h5I=;
        b=Js1/thUW3gf2HC2OOzVVCHn0DCL/S0oluIdLLLkVkY85Pk0WR4y0zmQgjG3N+crysE
         c4C2xFCvq2FhnkFe0J6NLAswWXG6XOgv7wclqYwfZ+EJ+VRVmEQyxRL/VzGR+awIRl51
         BD5RzQVGzWKZaa/+OhFCzfCK9s3/39USBRpLj3YZP1kospIHBw7zTr1+gDSAYseVmcLs
         tqebvYGRpsIS9Sf0C34MjirlibpgwdtpStPWmSoih2Kj/U0xfzoLQsT3yE+CF+XKHh4s
         LXrmezUMCqM/r9pm84z+S2F/y0cKV1xTqOUoEKMrCOGsUVvq1bg3xbLtaPcvl5MUpjhE
         tAxw==
X-Gm-Message-State: APjAAAX+5GXXb1yEXW1qob7KnXyNGf2p2HrFPFYmnwb1k1YO1OIR3MrO
        /eSF6nLv3KjjkxrQC5gDh/o=
X-Google-Smtp-Source: APXvYqzfx47Hb0iOhg81v85bCDZ2+5/0lnmGrEVIuTBo06UnNUVy7bpwJ3UxVttqvYAdqz0DBJ47tg==
X-Received: by 2002:a63:d615:: with SMTP id q21mr114467914pgg.401.1558854808818;
        Sun, 26 May 2019 00:13:28 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id c129sm9381274pfg.178.2019.05.26.00.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 00:13:27 -0700 (PDT)
Date:   Sun, 26 May 2019 12:43:22 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: staging: speakup: serialio: fix warning
 linux/serial.h is included more than once
Message-ID: <20190526071322.GA3830@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warning reported by  includecheck

./drivers/staging/speakup/serialio.h: linux/serial.h is included more
than once.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/speakup/serialio.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/speakup/serialio.h b/drivers/staging/speakup/serialio.h
index aa691e4..6f8f86f 100644
--- a/drivers/staging/speakup/serialio.h
+++ b/drivers/staging/speakup/serialio.h
@@ -4,9 +4,6 @@
 
 #include <linux/serial.h>	/* for rs_table, serial constants */
 #include <linux/serial_reg.h>	/* for more serial constants */
-#ifndef __sparc__
-#include <linux/serial.h>
-#endif
 #include <linux/serial_core.h>
 
 #include "spk_priv.h"
-- 
2.7.4

