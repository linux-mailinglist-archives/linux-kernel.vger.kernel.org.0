Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA893177249
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 10:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgCCJW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 04:22:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:38444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbgCCJW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:22:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 66B2DB195;
        Tue,  3 Mar 2020 09:22:56 +0000 (UTC)
Date:   Tue, 3 Mar 2020 10:22:55 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH 0/3] lib/test_printf: Clean up basic pointer testing
Message-ID: <20200303092255.c4j7q2r734t5upvz@pathway.suse.cz>
References: <20200227130123.32442-1-pmladek@suse.com>
 <20200303072456.GA904@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303072456.GA904@jagdpanzerIV.localdomain>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-03-03 16:24:56, Sergey Senozhatsky wrote:
> On (20/02/27 14:01), Petr Mladek wrote:
> > 
> > The discussion about hashing NULL pointer value[1] uncovered that
> > the basic tests of pointer formatting do not follow the original
> > structure and cause confusion.
> 
> FWIW, overall looks good to me.

Could I add Acked-by or Reviewed-by tag, please?

Best Regards,
Petr
