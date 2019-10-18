Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6C9DC574
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 14:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410079AbfJRMwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 08:52:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38026 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410072AbfJRMww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:52:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id b20so6110654ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 05:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFyIkShUP070T1MCe1PZHDrW/Mw93dXatTsiD8H58Vo=;
        b=TidEzT1giC2Jh121pQGun9aW1g6lMhBfTyTOD0z3AV8CZfc/kN8w6/T5TIOp6CwnyL
         Lp+Ce/mQ73ZwV/P4bEPMVvAqsTBSu+GsCShsUoPBJF0/etODAuZGq8d9uag7/34zzBrt
         MMymPFrUp1zyB/TcGssfWaGbpiAqQyFzb35P4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFyIkShUP070T1MCe1PZHDrW/Mw93dXatTsiD8H58Vo=;
        b=NWwqmvdmCH4N4bYfEofOS9AQqzxkYt5hjTPAqU7tm0nNzxggWgj35sG9v5bhfDkQvZ
         hYhMFqSyUk7A2vf1Q4dFFuPUJHZcJXEKu/0nt967Qwnh1dZ8PkRI90fVuYrTOrhp4e+I
         JfH6sl3pGHPHd50WZO9AGzzDUKe0aUV+x4kEFmVAxMt1fid9zyB/Q/pMjGeoL6yD+g3u
         iowg3F9CU7OxQSuq+pFgNm0Z0nkxzLVgyIyj4Ebm/krUShV5M1a4SAZL1J5NjLSx71Vh
         /w4cTfZQrSmOsv3IpIoe1JELr1n1BEwBCps+exItSgr7k0ZEn0UeOagLdk1dja7I5J9w
         bn8A==
X-Gm-Message-State: APjAAAX1Q6Zgh0cHliOGk4A1Mnt25dKrx5G9LdjASdBL5OzEnyVXrYQO
        xf2P5RXILa7B6nTSdKdeVd0c0Q==
X-Google-Smtp-Source: APXvYqx3Q7vbfdx4DL4qphQSptphuCSVjI5Ms226wcgo4SYrpulmH7OUNwVi/mF3j1JenZroGCEqZg==
X-Received: by 2002:a2e:b010:: with SMTP id y16mr6295556ljk.147.1571403170007;
        Fri, 18 Oct 2019 05:52:50 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m17sm7454792lje.0.2019.10.18.05.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:52:49 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] serial: make SERIAL_QE depend on PPC32
Date:   Fri, 18 Oct 2019 14:52:32 +0200
Message-Id: <20191018125234.21825-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
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
2.20.1

