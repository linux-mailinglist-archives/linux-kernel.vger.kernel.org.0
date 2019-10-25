Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38787E4B56
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 14:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504581AbfJYMmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 08:42:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38058 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504544AbfJYMlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id q28so1629509lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vlC6c2mLi3OFOrUlQdhK/IVokJUA43/TPqoeSB5eKTw=;
        b=jKc8arHSmx2y4WG6E6pxme2fpIipCQg3lj3xfo/NE13M78vwKaac8r87bS926CIlOe
         G8HjFyTR6NrrVEFfD2f145q33utez8HIUqLF7wEvHmOg4BYXyAYRqgdqUUut5SdZTL4F
         2f2wUM68LsShYG8dX6rYt18eoJRknZHtyrkIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vlC6c2mLi3OFOrUlQdhK/IVokJUA43/TPqoeSB5eKTw=;
        b=TU2aBZCrYMDH8geQ6HWbuyMm85GxEA0B2AMtmeX7IqS1KlRGuBV+E8GMYlUCt+d3Hl
         LgWwjx2PEYev3IpcIIkffV9OuzKP4BzploWDS3qU7NqT61g9mQ0LB0S3Tq1cV93NfQhJ
         gcx2Kg8UTwKnmFp3qPLWVpXkdtjjt4fyDI6LU2WM1mroYeTMYpoQHv7mRdS2dP1I11Gr
         Yskw+L5gEGH+lymON6yLX6eRyAuD8G7dfMTR1Q+Th8IOP8f4iGnI5ZUcDAI9Vzx84imZ
         Zf+UeqQbVr2PQLUt4nXxHskgFzzQoBiiu2OGMNKKJc+hnEbhfflWmasnThF93gRArIWJ
         sTVw==
X-Gm-Message-State: APjAAAVuTNepuuj60TsH/EWMQO66txlLoYoOX8v+GKQxJ/+9CHGTgJK8
        aHmCx6+oZaYQ7RZSDxKyrlWb2A==
X-Google-Smtp-Source: APXvYqyOmmWKDKIwnL+Dz+ZoHsEg95l0xY0B31Vt0IMF9adkil2MZ7+eec85cG8dv6k9ac6S6ZK0SA==
X-Received: by 2002:a19:f018:: with SMTP id p24mr2542630lfc.93.1572007288855;
        Fri, 25 Oct 2019 05:41:28 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:28 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v2 20/23] serial: make SERIAL_QE depend on PPC32
Date:   Fri, 25 Oct 2019 14:40:55 +0200
Message-Id: <20191025124058.22580-21-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently SERIAL_QE depends on QUICC_ENGINE, which in turn depends on
PPC32, so this doesn't add any extra dependency. However, the QUICC
Engine IP block also exists on some arm boards, so this serves as
preparation for removing the PPC32 dependency from QUICC_ENGINE and
build the QE support in drivers/soc/fsl/qe, while preventing
allmodconfig/randconfig failures due to SERIAL_QE not being supported
yet.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 67a9eb3f94ce..78246f535809 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1056,6 +1056,7 @@ config SERIAL_LANTIQ
 config SERIAL_QE
 	tristate "Freescale QUICC Engine serial port support"
 	depends on QUICC_ENGINE
+	depends on PPC32
 	select SERIAL_CORE
 	select FW_LOADER
 	help
-- 
2.23.0

