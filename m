Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA31D138564
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jan 2020 09:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbgALIFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 03:05:08 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51368 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732349AbgALIFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 03:05:08 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 36F8115A143EF;
        Sun, 12 Jan 2020 00:05:07 -0800 (PST)
Date:   Sun, 12 Jan 2020 00:05:04 -0800 (PST)
Message-Id: <20200112.000504.1994757840298424991.davem@davemloft.net>
To:     rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, lkp@intel.com
Subject: Re: [PATCH] tty: n_hdlc: fix build on SPARC
From:   David Miller <davem@davemloft.net>
In-Reply-To: <675e7bd9-955b-3ff3-1101-a973b58b5b75@infradead.org>
References: <675e7bd9-955b-3ff3-1101-a973b58b5b75@infradead.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 12 Jan 2020 00:05:07 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 30 Sep 2019 19:15:12 -0700

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix tty driver build on SPARC by not using __exitdata.
> It appears that SPARC does not support section .exit.data.
> 
> Fixes these build errors:
> 
> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 063246641d4a ("format-security: move static strings to const")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

I'll add an .exit.data to arch/sparc/kernel/vmlinux.lds.S to fix this.
