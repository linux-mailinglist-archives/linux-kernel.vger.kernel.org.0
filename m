Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC46B11D248
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfLLQ3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 11:29:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbfLLQ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IidiBxDJM+VIT+v37VGMG28TIHnD27VtPSaxTsIJSpI=; b=F8XIWu5dE5QOlZY+5UkEYA1bl
        klREN3ImvGQJucbjAIGPeNrcq8me7SFVJlVcnaEwVNT5l2jewD90OPG2jPNyrUe76CsZb1v0Qf5Gc
        C6wSuddKzvJiG5oNjTpMJOayfosQqjkzPhKT0OsQEQdHhSBURHFLlSyGPZ2RSqRrw9AfZBrViP0dd
        iC3JlCiXTt0XmaODIFZX6AGQ5BhXDjALGdZF7WNLYnL8FfLRyLDglEacEhmyk9UFRF+gNH3aNSQkQ
        a7Vs1AVgrostmvjB2/AU+D1QMt5L5wIOFxjsqMVmMZW8RyIDxB9gAaIWC8Oq750u3ABjiOVVafTwC
        RBtcsphWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifRLX-0004nE-4h; Thu, 12 Dec 2019 16:29:47 +0000
Date:   Thu, 12 Dec 2019 08:29:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Hannes Reinecke <hare@suse.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 20/24] compat_ioctl: move HDIO ioctl handling into
 drivers/ide
Message-ID: <20191212162947.GC27991@infradead.org>
References: <20191211204306.1207817-1-arnd@arndb.de>
 <20191211204306.1207817-21-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211204306.1207817-21-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int put_user_long(long val, unsigned long arg)
> +{
> +#ifdef CONFIG_COMPAT
> +	if (in_compat_syscall())
> +		return put_user(val, (compat_long_t __user *)compat_ptr(arg));
> +#endif
> +	return put_user(val, (long __user *)arg);
> +}

We had this

#ifdef CONFIG_COMPAT
	if (in_compat_syscall())
		...
	...
#endif

patter quite frequently.  Can we define a in_compat_syscall stub
and make sure compat_ptr and the compat_* types are available available
to clean this up a bit?

> -	if (NULL == (void *) arg) {
> +	if (NULL == argp) {

	if (!argp) {

?
