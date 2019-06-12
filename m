Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2109241E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 09:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436699AbfFLH4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 03:56:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:40138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436677AbfFLH4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:56:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BFCAADC1;
        Wed, 12 Jun 2019 07:56:29 +0000 (UTC)
Date:   Wed, 12 Jun 2019 09:56:28 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     =?utf-8?B?64Ko7JiB66+8?= <youngmin.nam@samsung.com>,
        andriy.shevchenko@linux.intel.com, sergey.senozhatsky@gmail.com,
        geert+renesas@glider.be, rostedt@goodmis.org, me@tobin.cc,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsprintf: fix data type of variable in string_nocheck()
Message-ID: <20190612075628.fmffeylp76wg4knv@pathway.suse.cz>
References: <CGME20190610074708epcas2p3dcbdc49d114c544c1de721666d574b43@epcas2p3.samsung.com>
 <040301d51f60$b4959100$1dc0b300$@samsung.com>
 <20190610081654.GA11709@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190610081654.GA11709@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-06-10 17:16:54, Sergey Senozhatsky wrote:
> On (06/10/19 16:47), 남영민 wrote:
> > This patch fixes data type of precision with int.
> > The precision is declared as signed int in struct printf_spec.
> > 
> > Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> 
> Looks OK to me.
> 
> FWIW
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

The patch has been committed into printk.git, branch for-5.3.

Best Regards,
Petr
