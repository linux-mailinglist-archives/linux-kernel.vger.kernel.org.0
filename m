Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58F2A68F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 20:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfEYSnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 14:43:01 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:51535 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfEYSm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 14:42:59 -0400
Received: by mail-wm1-f41.google.com with SMTP id f10so4938035wmb.1;
        Sat, 25 May 2019 11:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JblYDeip/cu/np5TrjPkU/VB6LfiCVo/c8uzC3L4NAY=;
        b=iYt8TpiXO5PmwDFS9au2jsYzWS0LU9WE9PW7PbQ5apSLeSysy/dL/FE40P3+L/RYym
         eIXa/1UIDsQZcGmzmJqLS3NUsf1RDfh5I+W1gAwARSiM7cAUQAN6PptuiW3VE/BMN0mz
         b788gzEPxLrmo2qyLufinuDc2GGXhTtSNpYWG012AEVVChyVVxotdkCjWH4JTDeEedXJ
         YbWWAEmNiFk2SQmCOVSIWNJSOlCan6Bl8SGJrIwF2aig0FmxpVLl2jJA8ohP/gxM4zLl
         0KabzHglytHdBxMFl02UtE3wjf/2BpSkaK2QWdMJH4DDx8HXY0y0XWRsBdrApVVDKvNZ
         03XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JblYDeip/cu/np5TrjPkU/VB6LfiCVo/c8uzC3L4NAY=;
        b=fN6FaCOukZujTpAojews1cLQZr0/uSRRhUlAhr+VD0/cTbXFFIGk8EwrbiD3Cg3iQO
         PLKV0pTvbeYdj890ruzwWYvH3Sh22PjogAdqWgds1h08R0qRocQjmlz1D++9n9uierHA
         6es0sOqZeCD8guWOQpa/J911xtXdnM34ijI29NCSUAe+nlDz7gCCQ9RlVsjlTZSNHv4V
         ubrmyqyKI4UfY4799lP648O98GbPR1py7mXUcPmzPBdxX3f9/1R/hicZIEEGXkY8uiWP
         CcUdMVxXBSGpRucJMkmFrD+It0EtDWitJrqwMHqICJtkc+PgE9bYzw+cPHNeyoYhwz+P
         Apfw==
X-Gm-Message-State: APjAAAUhMZi1Rcq4crufvkfeqKemEA3puAtW7fehec7O96m5dMKYP3/j
        PueVCX1sBgPD3F+YJs7MAMxgc2TD
X-Google-Smtp-Source: APXvYqzHYiwJxVmG7PLqyeJmJB19ooNHM+PoHQRFVchjbNYf/tnnw9l6jaBXdgLYloIwBLFovhMCjg==
X-Received: by 2002:a1c:7001:: with SMTP id l1mr7189264wmc.40.1558809777105;
        Sat, 25 May 2019 11:42:57 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id f20sm5327546wmh.22.2019.05.25.11.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:42:56 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] clk-pwm: show duty cycle in debugfs
Date:   Sat, 25 May 2019 20:42:52 +0200
Message-Id: <20190525184253.3088-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch that I had lying around in my tree for a while. I was
planning to use it back when I was debugging CPU clock issues on
Meson8b a while ago but it turned out that PWM was not related to that.

Feel free to apply or drop this patch, depending on whether it might or
might not be useful for anyone.

I have successfully tested it with the 32.768kHz LPO clock for the SDIO
wifi chipset on my Khadas VIM (Amlogic Meson GXL SoC):
  wifi32k  [...]  32768  [...]  50000


Martin Blumenstingl (1):
  clk: pwm: implement the .get_duty_cycle callback

 drivers/clk/clk-pwm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.21.0

