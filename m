Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9712629F8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 21:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404751AbfGHT5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 15:57:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbfGHT5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tyIU8Xl8fLThIKAr6zqxMx7FOywQgDqCMdJ/sBnvBco=; b=Yvr2PMV3+PME9ZodMlr+o2tDL
        smW8WnTyJtbru4ahuLbmqiEebKvVAD6dzv988MYeTHrvJKbjMCueRAJo5OoX5dBjUWdGO5HH8Riry
        mtMQeMuzPwvuzg5xbJA9bHkclUUfGnzzN2AXS+/N6bWAJG/jKcUuq8izSn3IREEauJqkRCvRNbxxe
        AL8kBCM3WFVgZmMYZpB3pOVgicpc9nmVe33xLWUwkxX3JNoKVhWp+40LGWA14goWIMBqM/vBigR1J
        tNdURDFD73hWudGIXawMv6/9tW03IDAyf5Fte3wt1ZJn9Rq5BA35UpHkx6SMuIwgMUPaPD00qUGFm
        2ZDhcpS2Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hkZlF-0001lt-OK; Mon, 08 Jul 2019 19:57:17 +0000
Date:   Mon, 8 Jul 2019 12:57:17 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] Documentation: filesystems:
 Convert jfs.txt to reStructedText format.
Message-ID: <20190708195717.GG32320@bombadil.infradead.org>
References: <20190706232236.GA24717@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706232236.GA24717@t-1000>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2019 at 04:22:39PM -0700, Shobhit Kukreti wrote:
> +++ b/Documentation/filesystems/index.rst
> @@ -41,3 +41,4 @@ Documentation for individual filesystem types can be found here.
>     :maxdepth: 2
>  
>     binderfs.rst
> +   jfs

This is the wrong place for this file.  See earlier conversation with
Sheriff Esseson, and the patch from me to move binderfs.

> diff --git a/Documentation/filesystems/jfs.rst b/Documentation/filesystems/jfs.rst
> new file mode 100644
> index 0000000..bfb6110
> --- /dev/null
> +++ b/Documentation/filesystems/jfs.rst

Why is git not detecting this as (mostly) a rename?

