Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5717312A45D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Dec 2019 00:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLXXLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 18:11:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfLXXLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 18:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0pRi+c65pSscSRiXyp6K1Nirdvxio/XKkWahRVr+k5k=; b=dtpCqSr51k0Ij2NXEXoUKxejj
        EjrQ8KTFowTSxzlTMXe9vvPVDBVWaIedobHxAuD+v1aGY25eV56jYkZI5POtE2JRvaEMHzvxgKtyy
        UshspwY+3EsVli4mlkwzrYLI9FxYZo7XHiaMaQ9OBmncIeiKqSeMYEd0Spur3yybaTYSU84htgGqs
        IMiEOmeY+rmKSeYPCT2S1wa6TQlercm17LFvCnnwK6KVaLt8qoZn++y1PTLovh7PdQMOtw1y209Rf
        hg/OTBWyIFfKK2ZaQNRe5W1BzA/QnyB5v27NydKyR2XxxGNqmTTB0CuOwM2mmX444SvRmBQ0KedGH
        Kold8zqXA==;
Received: from [2601:1c0:6280:3f0::fee9]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ijtKy-0004wi-8o; Tue, 24 Dec 2019 23:11:36 +0000
Subject: Re: [PATCH 2/3] docs: ftrace: Fix typos
To:     "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org,
        nachukannan@gmail.com
References: <cover.1577209218.git.frank@generalsoftwareinc.com>
 <638f1c8b6f4a47e4e25b62a01fe960e70a8364bc.1577209218.git.frank@generalsoftwareinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4d8a764c-88fe-56c0-e655-ed4052ab6d2d@infradead.org>
Date:   Tue, 24 Dec 2019 15:11:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <638f1c8b6f4a47e4e25b62a01fe960e70a8364bc.1577209218.git.frank@generalsoftwareinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/19 9:57 AM, Frank A. Cancio Bello wrote:
> Fix minor typos in the doc.
> 
> Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
> ---
>  Documentation/trace/ftrace.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 5a037bedbf6a..6c9f40d5a2f9 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -236,7 +236,7 @@ of ftrace. Here is a list of some of the key files:
>  	This interface also allows for commands to be used. See the
>  	"Filter commands" section for more details.
>  
> -	As a speed up, since processing strings can't be quite expensive
> +	As a speed up, since processing strings can be quite expensive
>  	and requires a check of all functions registered to tracing, instead
>  	an index can be written into this file. A number (starting with "1")
>  	written will instead select the same corresponding at the line position
> @@ -383,7 +383,7 @@ of ftrace. Here is a list of some of the key files:
>  
>  	By default, 128 comms are saved (see "saved_cmdlines" above). To
>  	increase or decrease the amount of comms that are cached, echo
> -	in a the number of comms to cache, into this file.
> +	in the number of comms to cache, into this file.

That repeats the inwardness of the echo (in + into).  How about:

+	the number of comms to cache into this file.

>  
>    saved_tgids:
>  
> @@ -3325,7 +3325,7 @@ directories after it is created.
>  
>  As you can see, the new directory looks similar to the tracing directory
>  itself. In fact, it is very similar, except that the buffer and
> -events are agnostic from the main director, or from any other
> +events are agnostic from the main directory, or from any other
>  instances that are created.
>  
>  The files in the new directory work just like the files with the
> 


-- 
~Randy

