Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D978BC2BD2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 04:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfJACPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 22:15:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47730 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfJACPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 22:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Usp4uBqvNgfqCFNnVosTwQoRaLzYYVIoD5DJHdedcP0=; b=aBAWywPYKDi+ddDOA2rBxF+45
        eRgRUaL82n2a2OL46tbJ6RB5undqCD5jc2wXofljduL7zUHkD2ZYB17u2EtmM29xQVJjJ5FeQe2Ol
        uyPIzk/nwx8ZrfsZgZ/Nyaelrz3s0A6+jFa5NGvMrMcmLR0z5B5b12PnU4K99aAjBZu0XvrlrkMCW
        7JkCIS7izMtATy5WT40IYQ6lIwTsXeA/UAw6fjEIEWvYiLnqqhp0RMWrKMYBaRaNQqCmdgJWlWVXz
        8Upik72uGF8RHhJfnGNcj0o2HrVkAIoFuxsHGRuzA9uxh3ueIyJ2ihX2mtv/GNntoXQKfumwfeI7j
        QRIUL8rvA==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iF7h4-0007eq-3m; Tue, 01 Oct 2019 02:15:14 +0000
To:     LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Miller <davem@davemloft.net>,
        kbuild test robot <lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] tty: n_hdlc: fix build on SPARC
Message-ID: <675e7bd9-955b-3ff3-1101-a973b58b5b75@infradead.org>
Date:   Mon, 30 Sep 2019 19:15:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix tty driver build on SPARC by not using __exitdata.
It appears that SPARC does not support section .exit.data.

Fixes these build errors:

`.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
`.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
`.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
`.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 063246641d4a ("format-security: move static strings to const")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/tty/n_hdlc.c |    5 +++++
 1 file changed, 5 insertions(+)

--- mmotm-2019-0925-1810.orig/drivers/tty/n_hdlc.c
+++ mmotm-2019-0925-1810/drivers/tty/n_hdlc.c
@@ -968,6 +968,11 @@ static int __init n_hdlc_init(void)
 	
 }	/* end of init_module() */
 
+#ifdef CONFIG_SPARC
+#undef __exitdata
+#define __exitdata
+#endif
+
 static const char hdlc_unregister_ok[] __exitdata =
 	KERN_INFO "N_HDLC: line discipline unregistered\n";
 static const char hdlc_unregister_fail[] __exitdata =


