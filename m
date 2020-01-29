Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4086414CADB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 13:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgA2M31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 07:29:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:54604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbgA2M31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:29:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 86341AF92;
        Wed, 29 Jan 2020 12:29:25 +0000 (UTC)
Date:   Wed, 29 Jan 2020 13:29:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] console: Don't perform test for CON_BRL flag
Message-ID: <20200129122924.4chb44pp27kswlcy@pathway.suse.cz>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-01-27 13:47:15, Andy Shevchenko wrote:
> We don't call braille_register_console() without CON_BRL flag set.
> And the _braille_unregister_console() already tests for console to have
> CON_BRL flag. No need to repeat this in braille_unregister_console().
> 
> Drop the repetitive checks from Braille console driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I wish the braille console support was added a cleaner way.

I am always confused what is the generic code and what is specific
for the only supported VisioBraille console. And braile()
functions called from _braile() wrappers just add to the confusion.

Anyway, I am fine with this patch.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
