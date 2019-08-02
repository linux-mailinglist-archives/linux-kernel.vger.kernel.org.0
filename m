Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3690B7F9A8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 15:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394812AbfHBN2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 09:28:04 -0400
Received: from ms.lwn.net ([45.79.88.28]:49532 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390660AbfHBN02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:26:28 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4C9687DA;
        Fri,  2 Aug 2019 13:26:27 +0000 (UTC)
Date:   Fri, 2 Aug 2019 07:26:26 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chao@kernel.org>, <jaegeuk@kernel.org>
Subject: Re: [PATCH] mailmap: add entry for Jaegeuk Kim
Message-ID: <20190802072626.405246e3@lwn.net>
In-Reply-To: <20190802012135.31419-1-yuchao0@huawei.com>
References: <20190802012135.31419-1-yuchao0@huawei.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2019 09:21:35 +0800
Chao Yu <yuchao0@huawei.com> wrote:

> Add entry to connect all Jaegeuk's email addresses.
> 
> Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  .mailmap | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/.mailmap b/.mailmap
> index 477debe3d960..70d41c86e644 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -89,6 +89,9 @@ Henrik Kretzschmar <henne@nachtwindheim.de>
>  Henrik Rydberg <rydberg@bitmath.org>
>  Herbert Xu <herbert@gondor.apana.org.au>
>  Jacob Shin <Jacob.Shin@amd.com>
> +Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@google.com>
> +Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@motorola.com>
> +Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk.kim@samsung.com>

So as I understand it, the mailmap file is there mostly to ensure that a
person's changesets are properly collected in 'git shortlog' and such.  As
documented on the man page, it is used when a person's name is spelled
differently at different times.

That doesn't appear to be the case here, and shortlog output is correct
already.  Given that, do we *really* need to maintain a collection of old
email addresses in the mailmap file?  What is the benefit of that?

Thanks,

jon
