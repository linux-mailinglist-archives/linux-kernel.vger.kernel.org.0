Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8EAB166B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 01:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgBUAVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 19:21:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729392AbgBUAVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:21:15 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9989424654;
        Fri, 21 Feb 2020 00:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582244474;
        bh=Hyd2ABFVo1kBeYwCK2oi93oNf6lC5RwcHhN2Ky8uVJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vG91CCT7/IFH2MsfgsCkJYzC5fpIA20e7zIFoSDetbtBtuQnFZMeogQUutZe2fUqN
         TsHMH/F8ME+CZrWtK9U+i1wMxaqlUimPg3rQ9m8t0k5jBVr0y2GK5fH9wlDrAm3sqi
         oOIxHy8qghrpLnjgCXRgWHnHhBDc1/zyaEdjwLGU=
Date:   Thu, 20 Feb 2020 16:21:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] cvt_fallthrough: A tool to convert /* fallthrough */
 comments to fallthrough;
Message-Id: <20200220162114.138f976ae16a5e58e13a51ae@linux-foundation.org>
In-Reply-To: <b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com>
References: <b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 12:30:21 -0800 Joe Perches <joe@perches.com> wrote:

> Convert /* fallthrough */ style comments to the pseudo-keyword fallthrough
> to allow clang 10 and higher to work at finding missing fallthroughs too.
> 
> Requires a git repository and overwrites the input files.
> 
> Typical command use:
>     ./scripts/cvt_fallthrough.pl <path|file>
> 
> i.e.:
> 
>    $ ./scripts/cvt_fallthrough.pl block
>      converts all files in block and its subdirectories
>    $ ./scripts/cvt_fallthrough.pl drivers/net/wireless/zydas/zd1201.c
>      converts a single file
> 
> A fallthrough comment with additional comments is converted akin to:
> 
> -		/* fall through - maybe userspace knows this conn_id. */
> +		fallthrough;    /* maybe userspace knows this conn_id */
> 
> A fallthrough comment or fallthrough; between successive case statements
> is deleted.
> 
> e.g.:
> 
>     case FOO:
>     	/* fallthrough */ (or fallthrough;)
>     case BAR:
> 
> is converted to:
> 
>     case FOO:
>     case BAR:
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  scripts/cvt_fallthrough.pl | 215 +++++++++++++++++++++++++++++++++++++

Do we need this in the tree long-term?  Or is it a matters of "hey
Linus, please run this" then something like add a checkpatch rule to
catch future slipups?

