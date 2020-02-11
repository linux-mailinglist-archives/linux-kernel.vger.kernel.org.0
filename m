Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE64F1591F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 15:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgBKO3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 09:29:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:36498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbgBKO3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:29:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 020EAC06A;
        Tue, 11 Feb 2020 14:29:47 +0000 (UTC)
Date:   Tue, 11 Feb 2020 15:29:47 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] printk: Move console matching logic into a
 separate function
Message-ID: <20200211142947.favkq56gkyexqkpg@pathway.suse.cz>
References: <e6b63bc26108c6e3645f9ea9e03aba38fd8b8464.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6b63bc26108c6e3645f9ea9e03aba38fd8b8464.camel@kernel.crashing.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-02-06 15:02:18, Benjamin Herrenschmidt wrote:
> This moves the loop that tries to match a newly registered console
> with the command line or add_preferred_console list into a separate
> helper, in order to be able to call it multiple times in subsequent
> patches.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Looks fine to me.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Just few nits below.

> @@ -2626,6 +2627,60 @@ static int __init keep_bootcon_setup(char *str)
> +	/*
> +         * Some consoles, such as pstore and netconsole, can be enabled even
> +         * without matching.
> +         */

There are few lines in the patchset where the indentation is done
by spaces instead of tabs. The above 3 lines are just one example.

I'll fix this when pushing. But please, be more careful next time ;-)
I suggest to use some more clever editor that helps with code
formatting.

Also I suggest to run ./scripts/checkpatch.pl on the patches
before sending.


Also the three patches were not send in a single thread so that
it was harder to find all the pieces. I personally use:

    git format-patch --cover-letter origin/master -o some-dir
    ./scripts/checkpatch.pl some-dir/*
    $> edit some-dir/0000-*.patch
    git send-email --smtp-server=... --to= --cc= ... some-dir/*

Best Regards,
Petr
