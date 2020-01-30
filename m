Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA86914D821
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 10:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgA3JJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 04:09:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:35888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgA3JJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 04:09:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C8A94ACCA;
        Thu, 30 Jan 2020 09:09:17 +0000 (UTC)
Date:   Thu, 30 Jan 2020 10:09:17 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] console: Introduce ->exit() callback
Message-ID: <20200130090917.sg5vnwvlng4ox6ua@pathway.suse.cz>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127114719.69114-5-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-01-27 13:47:19, Andy Shevchenko wrote:
> Some consoles might require special operations on unregistering. For example,
> serial console, when registered in the kernel, keeps power on for entire time,
> until it gets unregistered. For such cases to have a balance we would provide
> ->exit() callback.

Is there any plan to use this callback, please?

The console init, setup, registration code needs a clean up,
definitely. If you plan some rework, I would like to understand
the bigger picture before we start adding new callbacks.

Best Regards,
Petr
