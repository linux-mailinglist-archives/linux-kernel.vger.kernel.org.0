Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD6FC185AFF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 08:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgCOHQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 03:16:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgCOHPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 03:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=Va4hKd5UNxovGjVSxksW2kq4jkfcUPbqde9Oaz+go/c=; b=rcYdKyFvOVbMXkJsWJ4j39OuWV
        LztEjhk8AYp0LBMKYFosLO5hXiKZcXQG+X64+9zbzjLy7n9nQ3Q3CKZ2u4j9naJb3rW0t5YBB+ont
        1RM3Yw71w99ROvZDW1a1FCtulbooAp0uyavD+RdD1yTIAYOgmciTdJqF9uEXixLdMW8gP3icOpVM2
        VlGJftnoYsamCg98ZdS47t+J51YOIEmK8K7qNFYQRW+tebbBWqzXlrB3xLr9URuugr43TYAM5mzg/
        IygbqCJLHojxQveps9ropruKVmcvtp/u0AQV2L8tBX29l0EE86jsdZ9v57ewAX66zHgG48KezL5Yn
        j5BPnSlw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDKbF-0003dY-Gm; Sun, 15 Mar 2020 04:10:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Antonino Daplas <adaplas@gmail.com>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: [PATCH 3/6] fbdev: matrox: fix -Wextra build warnings
Date:   Sat, 14 Mar 2020 21:09:59 -0700
Message-Id: <20200315041002.24473-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200315041002.24473-1-rdunlap@infradead.org>
References: <20200315041002.24473-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 'DEBUG' is not defined, modify the dprintk() macro to use the
no_printk() macro instead of using <empty>.
This fixes build warnings when -Wextra is used and provides
printk format checking:

../drivers/video/fbdev/matrox/matroxfb_base.c:635:77: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../drivers/video/fbdev/matrox/matroxfb_Ti3026.c:632:54: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]
../drivers/video/fbdev/matrox/matroxfb_Ti3026.c:654:53: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
Alternative: use pr_debug() so that CONFIG_DYNAMIC_DEBUG can be used
at these sites.

 drivers/video/fbdev/matrox/matroxfb_base.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200313.orig/drivers/video/fbdev/matrox/matroxfb_base.h
+++ linux-next-20200313/drivers/video/fbdev/matrox/matroxfb_base.h
@@ -86,7 +86,7 @@
 #ifdef DEBUG
 #define dprintk(X...)	printk(X)
 #else
-#define dprintk(X...)
+#define dprintk(X...)	no_printk(X)
 #endif
 
 #ifndef PCI_SS_VENDOR_ID_SIEMENS_NIXDORF
