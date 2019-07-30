Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4DCC7AAE9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 16:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbfG3O0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 10:26:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33035 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfG3O0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:26:02 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so9618380iog.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+uMhQitWksYRbr8SuacmJdvNd2BY02Qb3I7uzgGDJds=;
        b=b/YGcvOirV6UwIvBt+Purp8CgdiD9jP1on0NcrCT5Qurn4xc367fLIjtoVqv/eZCjy
         mQEJA4mEJedVCjjuN+E2p6XuNrfXSnx8ddMP0aO8xjxeBQXKGZ5gIb/NgHOlHmMsk/Cy
         ioNicb4yOIp8oHSqgvAg9uedJ9fH8mMcR44Hkil3zhBOMGJUDCa5VTkvhKrIT9cI3XkU
         HUrm7tVU4Me8UnEepJ1rMVuS9A55Roa1Fe+/9Vmks95jlkCsAPvKSaxbb/55rNuH9ljc
         u5BzddUKGVIBQsRCmFmx67XmASOwHt/pk4WSLkTQFlCpfYye6oLgWhwoQYWKb+KX9G2C
         9OGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+uMhQitWksYRbr8SuacmJdvNd2BY02Qb3I7uzgGDJds=;
        b=Irv3dfuY7Uxy1LD3WOU8VuZN/ZkUsQwii/+6j2s8WHsLw0CBGSga9pJ6p3CqHUlvEE
         lJA1lbDt/OyLZ1mhI6q7X/Q0h7n7n27wZltYM6VFa3eRlUx3vOA1sJ4ckGVsk3YyPvrQ
         IDZ/7PDsToH2gkIvTDqvXUbyaOzYHUbmgtry5bJGI2GGeCfN4OFVsLS4EfIS4mKC572h
         KPPMESS0nTuERuHYjGWjEpTaW7NsMo3LWSyzqDj5A9282S/I1A7nf/S745eyDpDr0wxt
         b85r+Eclfu/BQv/TxnnlfzXenvJrCd6b7nJtXMLJfDTF0QxrUqWyXvt9nAyfRZ9LCXr9
         1DIQ==
X-Gm-Message-State: APjAAAVsxN5V9Ut62qARVjMxQQsHXsTvv4De0FQIpSxRcbjGCn6xb6/C
        r9EMESOg+k3JGgMAPMjHukQ=
X-Google-Smtp-Source: APXvYqxoRIqZ5FFC0f94kR6D3gBHlSMJJRHb790MkhvJ49D+YhJD96NUahg3+O5aFQ7RJbQtSmm2Zg==
X-Received: by 2002:a6b:b9c2:: with SMTP id j185mr104642239iof.148.1564496761324;
        Tue, 30 Jul 2019 07:26:01 -0700 (PDT)
Received: from hash ([2607:fea8:5ac0:1dd8:230:48ff:fe9d:9c89])
        by smtp.gmail.com with ESMTPSA id c11sm36501054ioi.72.2019.07.30.07.26.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 07:26:00 -0700 (PDT)
Received: from bob by hash with local (Exim 4.92)
        (envelope-from <me@bobcopeland.com>)
        id 1hsT4h-0003Uj-Qd; Tue, 30 Jul 2019 10:25:59 -0400
Date:   Tue, 30 Jul 2019 10:25:59 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, linux-karma-devel@lists.sourceforge.net
Subject: Re: [PATCH 18/20] fs: omfs: Initialize filesystem timestamp ranges
Message-ID: <20190730142559.GA4332@localhost>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
 <20190730014924.2193-19-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730014924.2193-19-deepa.kernel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 06:49:22PM -0700, Deepa Dinamani wrote:
> Fill in the appropriate limits to avoid inconsistencies
> in the vfs cached inode times when timestamps are
> outside the permitted range.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: me@bobcopeland.com
> Cc: linux-karma-devel@lists.sourceforge.net
> ---
>  fs/omfs/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
> index 08226a835ec3..b76ec6b88ded 100644
> --- a/fs/omfs/inode.c
> +++ b/fs/omfs/inode.c
> @@ -478,6 +478,10 @@ static int omfs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	sb->s_maxbytes = 0xffffffff;
>  
> +	sb->s_time_gran = NSEC_PER_MSEC;
> +	sb->s_time_min = 0;
> +	sb->s_time_max = U64_MAX / MSEC_PER_SEC;
> +

I honestly don't know if it should be s64 rather than u64, but considering
that none of the devices with this filesystem ever exposed dates to users in
the negative era, it should be fine.

Acked-by: Bob Copeland <me@bobcopeland.com>

-- 
Bob Copeland %% https://bobcopeland.com/
