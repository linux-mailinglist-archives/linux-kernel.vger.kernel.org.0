Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 470715F70B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 13:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfGDLIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 07:08:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:36466 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727436AbfGDLIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 07:08:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A88AAD2B;
        Thu,  4 Jul 2019 11:08:51 +0000 (UTC)
Date:   Thu, 4 Jul 2019 13:08:50 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/vsprintf: Reinstate printing of legacy clock IDs
Message-ID: <20190704110850.fssbdji7tvokaa4l@pathway.suse.cz>
References: <20190701140009.23683-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701140009.23683-1-geert+renesas@glider.be>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-07-01 16:00:09, Geert Uytterhoeven wrote:
> When using the legacy clock framework, clock pointers are no longer
> printed as IDs, as the !CONFIG_COMMON_CLK case was accidentally
> considered an error case.
> 
> Fix this by reverting to the old behavior, which allows to distinguish
> clocks by ID, as the legacy clock framework does not store names with
> clocks.
> 
> Fixes: 0b74d4d763fd4ee9 ("vsprintf: Consolidate handling of unknown pointer specifiers")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

The patch has been commited into printk.git, branch for-5.3.

Best Regards,
Petr
