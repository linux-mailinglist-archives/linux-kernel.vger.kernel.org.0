Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B48173A42
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 15:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgB1OuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 09:50:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:36030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgB1OuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:50:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 68370B147;
        Fri, 28 Feb 2020 14:50:12 +0000 (UTC)
Date:   Fri, 28 Feb 2020 15:50:11 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <mail@rasmusvillemoes.dk>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH v1] lib/vsprintf: update comment about
 simple_strto<foo>() functions
Message-ID: <20200228145011.oqacopw7k5dd7u37@pathway.suse.cz>
References: <20200221085723.42469-1-andriy.shevchenko@linux.intel.com>
 <20200221145141.pchim24oht7nxfir@pengutronix.de>
 <CAHp75VfR+X6Mw8ywKNW5mTomzmuHSM8ecQUhxtM=LUkWaSe9CA@mail.gmail.com>
 <20200221163334.w7pocmbbw4ymimlc@pengutronix.de>
 <d6c3b369-9777-9986-f41f-3f3a4f85d64c@rasmusvillemoes.dk>
 <20200227131428.5nhvslwdmocv6fkb@pathway.suse.cz>
 <7c43342d-bae7-8f52-d856-694264a87a69@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c43342d-bae7-8f52-d856-694264a87a69@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-02-27 17:01:15, Rasmus Villemoes wrote:
> On 27/02/2020 14.14, Petr Mladek wrote:
> > 
> > Is still anyone against the original patch updating the comments in
> > vsprintf.c. Otherwise, I would queue it for 5.7.
> 
> Please do.

The patch has been committed into printk.git, for-5.7 branch.

Best Regards,
Petr
