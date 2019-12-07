Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9901A115EC5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2019 22:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfLGV30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Dec 2019 16:29:26 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37890 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfLGV3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 16:29:25 -0500
Received: by mail-pj1-f68.google.com with SMTP id l4so4208556pjt.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 13:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=VSt+6+RxN+ngtZtzcjXuc8nTvxksoum1JuKvq2Ql5sg=;
        b=zOevuRPu/tVt8TS7J5KttwWizUBeGQkN0ITicML1mI6x5OAiyq7GfSoODxLaOKvhfy
         lJwyBJd4+zfiyYFstz7KcyghJ2qdBvllY6+DJjRFeFu4OL0Isu6W08QQ5NGCfjo+gkvT
         7RPK8Aobq5OWZRIkr41rCNN135TEl/nNEyvV11JNyBMs+Wlj3MKJqfOwEozEe+k88R/Q
         XGquH7HY8sa9ehOaIpEyiIyXdI2vgnbkWXEBaKY4CzzOh2XR2EQ1q+h53sNRY6/C/9z2
         pZnbVSzVAc3NceTJplZyHvpylkKat79O6sWW51t6ZqVZtHTDCpQ3lGhLKQXI8DoKCnFT
         cT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VSt+6+RxN+ngtZtzcjXuc8nTvxksoum1JuKvq2Ql5sg=;
        b=chvbcCsn7yBC+ppPdGX+qpot1aCeUWN0FNXDMDGYJPZeL9p5L9wtybk0UtXpdokM1y
         XKJ2Hkpnv5si7z5xwcCQ/jp8MVKdaiOrMZ1jGCaE+pu4cSSVT0GaQhqdEyA2GkW+jemW
         NnbFB6XcUBEXHi2LC9egz/rWblT0Llkbd4zYhiYQ6ImcPgpVjEMpMcOrHUk/OLqt9Pb3
         4BgcE/A2wCA2O6cHY7pgz1sIUzmJh6bfzHnrtl3ANQ5gXcoWuJJ+GuiEZ6v6o8RZxDhN
         g15QF1tyNN3y3aX2/zmpXJeBbj6tOsDahrHfSUu+6b+gzA9yVEMwIUtNSqvuFznaqpKK
         /fOg==
X-Gm-Message-State: APjAAAUGDEWHo+VVLnDVa0OF6TVFx5X/sHxJNtPSXT2XBnVq0RqrsuUi
        SuCFvYFpS73nIjE72kTV8TIAOA==
X-Google-Smtp-Source: APXvYqzFC3GMHXUGEUDK6KLYKA1CQWnfA106/qYuSJ9km6BCLDQgjaLz2dIFbK9TR6zthTrxe30nvQ==
X-Received: by 2002:a17:90a:a798:: with SMTP id f24mr24031614pjq.27.1575754164952;
        Sat, 07 Dec 2019 13:29:24 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id 23sm11683377pfj.148.2019.12.07.13.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 13:29:24 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] riscv: Fix build dependency for loader
Date:   Sat,  7 Dec 2019 13:29:16 -0800
Message-Id: <20191207212916.130825-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Makefile addition for the flat image loader missed an obj prefix.

For most parallel builds this worked out fine, but with -j1 the dependency
wasn't fulfilled and thus fails:

arch/riscv/boot/loader.S: Assembler messages:
arch/riscv/boot/loader.S:7: Error: file not found: arch/riscv/boot/Image

Fixes: 405fe7aa0dba ("riscv: provide a flat image loader")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/riscv/boot/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index a474f98ce4fae..36db8145f9f46 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -24,7 +24,7 @@ $(obj)/Image: vmlinux FORCE
 $(obj)/Image.gz: $(obj)/Image FORCE
 	$(call if_changed,gzip)
 
-loader.o: $(src)/loader.S $(obj)/Image
+$(obj)/loader.o: $(src)/loader.S $(obj)/Image
 
 $(obj)/loader: $(obj)/loader.o $(obj)/Image $(obj)/loader.lds FORCE
 	$(Q)$(LD) -T $(obj)/loader.lds -o $@ $(obj)/loader.o
-- 
2.11.0

