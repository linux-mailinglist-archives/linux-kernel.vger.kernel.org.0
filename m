Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96B319476C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 20:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgCZT3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 15:29:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgCZT3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RiybZnpQ2WaLYTPz6WPtaCIYyJYUacUfjAVruDdMh28=; b=WyNS53qVaBPLJxtnyg6zCRT8aW
        NAQI18Fv5s/ccyV5MYoUvVjm9fZ/8VhPGZDJDezjc+jtIBJS9D3KHB5vZ12w1IMDa/Q9izMz8Z83v
        5wodJSYCjlOoMtWFOB29IdV1qxCD6qGhT1w/KRDFoAuAweulmwlo46fVxKlB7pyqRpYV2korbzWWB
        bPTZQn/LZm1RvvVfDidjUO2UnCuna1AmNMSdxt/R7tbEhmPRKz8/4RwC22ROwd1Zs+cj+kouAN10L
        pLuWABYvg9fVxcVuJCIb0UDE/zWdLLBcAR8qq+23S9RUGIe70n0euFuQuTQaQxJYeyGCjW6L5hN0c
        eViGdNag==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHYCJ-0004JK-Qg; Thu, 26 Mar 2020 19:29:47 +0000
Date:   Thu, 26 Mar 2020 12:29:47 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     peter@bikeshed.quignogs.org.uk
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 1/1] A compact idiom to add code examples in kerneldoc
 comments.
Message-ID: <20200326192947.GM22483@bombadil.infradead.org>
References: <20200311133027.2c77f348@lwn.net>
 <20200326191628.10052-1-peter@bikeshed.quignogs.org.uk>
 <20200326191628.10052-2-peter@bikeshed.quignogs.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326191628.10052-2-peter@bikeshed.quignogs.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 07:16:28PM +0000, peter@bikeshed.quignogs.org.uk wrote:
> From: Peter Lister <peter@bikeshed.quignogs.org.uk>
> 
> scripts/kernel-doc - When a double colon follows a section heading
> (e.g. Example::), write a double colon line to the ReST output to make
> the following text (e.g. a code snippet) into a literal block.

I think this is a good idea

> -
> +    # $doc_sect is a regex which searches for section names.
> +    # If it matches:
> +    #   $1 is the section name
> +    #   $2 is a colon if the section name was followed by a double colon.
> +    #   $3 the rest of the content after the colon (or double colon).

I would add an extra 'is' after $3.

>      if (/$doc_sect/i) { # case insensitive for supported section names
>  	$newsection = $1;
> -	$newcontents = $2;
> -
> +	# If $2 is ':', the section name was followed by a double
> +	# colon, so insert a containing just '::' to make the

Missing word between 'a' and 'containing'?

