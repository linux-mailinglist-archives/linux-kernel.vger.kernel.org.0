Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C56415EED9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 23:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfGCV4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 17:56:41 -0400
Received: from fieldses.org ([173.255.197.46]:40126 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfGCV4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 17:56:41 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 33BC72014; Wed,  3 Jul 2019 17:56:41 -0400 (EDT)
Date:   Wed, 3 Jul 2019 17:56:41 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: linux-next: Fixes tag needs some work in the nfsd tree
Message-ID: <20190703215641.GA11243@fieldses.org>
References: <20190704074048.65556740@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704074048.65556740@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 07:40:48AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   56496758e181 ("nfsd: Fix overflow causing non-working mounts on 1 TB machines")
> 
> Fixes tag
> 
>   Fixes: 10a68cdf10 (nfsd: fix performance-limiting session calculation)
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Did you mean
> 
> Fixes: c54f24e338ed ("nfsd: fix performance-limiting session calculation")

Thanks, fixed.

--b
