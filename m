Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED9F14CC23
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 15:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgA2OLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 09:11:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:48656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgA2OLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:11:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4A86FB22E;
        Wed, 29 Jan 2020 14:11:49 +0000 (UTC)
Date:   Wed, 29 Jan 2020 15:11:48 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] console: Use for_each_console() helper in
 unregister_console()
Message-ID: <20200129141148.4zit4yy7t4cl3t4m@pathway.suse.cz>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127114719.69114-3-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-01-27 13:47:17, Andy Shevchenko wrote:
> We have rather open coded single linked list manipulations where we may
> simple use for_each_console() helper with properly set exit conditions.
> 
> Replace open coded single-linked list handling with for_each_console()
> helper in use.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nice simplification.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
