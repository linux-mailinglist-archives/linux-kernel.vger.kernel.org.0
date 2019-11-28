Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B40110CB10
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 15:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfK1O7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 09:59:20 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39230 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbfK1O5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:43 -0500
Received: by mail-lf1-f66.google.com with SMTP id f18so20235946lfj.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+/uGhuZC6bGDe/vY5pHErjTk2s243PKPkhdUERJxYak=;
        b=DA9W24cKzldoyLYNRJ2Y6/1zVnkA1lJTOnZNVCGLnBtLy9SDw6v1MH1Lm6m8gUytky
         c/CaDP3iN1dNJBfmYpol42g9n5EFLkk812cLsAvU7B2qNvOG91C4+6uQAfeMnsMVXDe4
         rOJD9KS0Hi/+zmyHdu2abRIo6OPt5+3pur4ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+/uGhuZC6bGDe/vY5pHErjTk2s243PKPkhdUERJxYak=;
        b=OFdrUQmS56H3ls/815hES9hSyfXlKKAJ05GgEiF7u8rxDsds9XAVwjTigItftGJDvz
         tQL7vxcvwsRjRdYkpfeC/5ze/8FssZwfEuWKCYJiC0odUJjbnbwS0v4l/8XlR3jrGPlw
         gC3kY+NWEc7zMVTt/EdHH3UxcjeMAOIgXqb211/1s3zSlqFEcVpLaQt3rBLIH3R1Q7Rd
         3f+rIPXBvPMkaq+0Z8uJyng/dcxzAdzY8gaJ7swIO65yicMc/eXE5+NGfY9IVx1nB4KQ
         ZUJfoJq+K9Ovh6TMhubzH29mM1SgmpJN73/D58KZf+qk5gsn68OsM9nbMQ/vtHf9JERX
         DuYA==
X-Gm-Message-State: APjAAAX3xsu9it9qJfSa0O2qRTKj75IkMVcEKGb6lBMoAD8wvuPzuDpT
        EhWOLr1VFVwcr8IuMmhrlxI6Ug==
X-Google-Smtp-Source: APXvYqzw/jYuIoVJsHxaPiDPkjZLXx2+FnqCB2evJQRnfVYU2j3q8zmQHgBLElskKwZbaunbylGJGw==
X-Received: by 2002:a19:756:: with SMTP id 83mr6610746lfh.173.1574953061494;
        Thu, 28 Nov 2019 06:57:41 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:41 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v6 28/49] serial: ucc_uart: explicitly include soc/fsl/cpm.h
Date:   Thu, 28 Nov 2019 15:55:33 +0100
Message-Id: <20191128145554.1297-29-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver uses #defines from soc/fsl/cpm.h, so instead of relying on
some other header pulling that in, do that explicitly. This is
preparation for allowing this driver to build on ARM.

Reviewed-by: Timur Tabi <timur@kernel.org>
Acked-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index a0555ae2b1ef..7e802616cba8 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -32,6 +32,7 @@
 #include <soc/fsl/qe/ucc_slow.h>
 
 #include <linux/firmware.h>
+#include <soc/fsl/cpm.h>
 #include <asm/reg.h>
 
 /*
-- 
2.23.0

