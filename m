Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6055348347
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 14:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfFQM5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 08:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfFQM5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:57:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57C212089E;
        Mon, 17 Jun 2019 12:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560776224;
        bh=xdETj5mf6aeUoLj5hEhq8+dwhZFws6OLsC2VvsYVJ5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsEF4PxvDA0r6DHB4M8Djp8eU2sl7B8TBIQry4L9GCDem3Dfb8yTpDqmotIUb0OZy
         hZpHMWVKkPrWYMhyuTH5/sQkNhYAP9BD8EXtxx9xuT7EXQPVLEeRcIM8v4VM5TfdW6
         Q6QpII6vbYQCzD3w6o6EMQjuqfgzdxkH8KHx218o=
Date:   Mon, 17 Jun 2019 14:57:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 03/16] scripts: add an script to parse the ABI files
Message-ID: <20190617125702.GA20042@kroah.com>
References: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
 <680fb978ef9322c705eca9927c79b220cd3ccc4a.1560534648.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680fb978ef9322c705eca9927c79b220cd3ccc4a.1560534648.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 02:52:17PM -0300, Mauro Carvalho Chehab wrote:
> Add a script to parse the Documentation/ABI files and produce
> an output with all entries inside an ABI (sub)directory.
> 
> Right now, it outputs its contents on ReST format. It shouldn't
> be hard to make it produce other kind of outputs, since the ABI
> file parser is implemented in separate than the output generator.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  scripts/get_abi.pl | 212 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 212 insertions(+)
>  create mode 100755 scripts/get_abi.pl
> 
> diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
> new file mode 100755
> index 000000000000..f7c9944a833c
> --- /dev/null
> +++ b/scripts/get_abi.pl
> @@ -0,0 +1,212 @@
> +#!/usr/bin/perl
> +

Ok, I was going to apply this, but there is no SPDX line on the script.
Can you resend this series with that on it, so that I can apply the
patches of the series that adds the script to the kernel tree?

thanks,

greg k-h
