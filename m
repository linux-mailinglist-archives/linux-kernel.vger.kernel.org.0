Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD86167DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 14:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgBUNIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 08:08:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:44722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbgBUNIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:08:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 500DBAD43;
        Fri, 21 Feb 2020 13:08:04 +0000 (UTC)
Date:   Fri, 21 Feb 2020 14:08:03 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1] lib/vsprintf: update comment about
 simple_strto<foo>() functions
Message-ID: <20200221130803.q34oswagpdhbehzo@pathway.suse.cz>
References: <20200221085723.42469-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200221085723.42469-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-02-21 10:57:23, Andy Shevchenko wrote:
> The commit 885e68e8b7b1 ("kernel.h: update comment about simple_strto<foo>()
> functions") updated a comment regard to simple_strto<foo>() functions, but
> missed similar change in the vsprintf.c module.
> 
> Update comments in vsprintf.c as well for simple_strto<foo>() functions.
> 
> Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good to me.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
