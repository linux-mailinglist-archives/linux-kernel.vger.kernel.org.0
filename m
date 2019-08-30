Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9584A4012
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 00:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfH3WEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 18:04:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41401 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfH3WEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:04:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id z9so4338723edq.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 15:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+CLMhNM5gPu732EY0YQc5MeoyNi9A2+mkByQgSox020=;
        b=WgwqfRjCXhL1vF6NjwfGzSOjDnhkh8u+SJL9yPVcRIkdSN6FMYls+gJNd0DBqY+ebX
         pLaZoSxnuBIgEHqABrKiFjo1iX37kfvjHkJIDMn/tZuMfgQYreNprSssm64szgVc3OUP
         YWGMqT5WmISbE5woFDfuJPXUT24nKFCnoO97E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+CLMhNM5gPu732EY0YQc5MeoyNi9A2+mkByQgSox020=;
        b=QOrDGx7aVLnzQaatq6GjwHc2flEKRVUamtEpng/QG6mc3oqKYYVzzULsYSL1zr4cbR
         AlopmJWW8EXNK1DX5yriov6kWLkPtXYjqjaEdTp3aLtbikNgWksaFKNatlmXXpBKRbAW
         TK7u64pafIly9Q9bZosvn35Pn06Ye5CLoxbFJIxSpqM1Ipg92+M/hyLhDgseleur4VKv
         3kXbSbiwJIUjfDwvHy69aNhV7bMsrQDtVdjimUE4Tqwr05LcdTf/mDkEXnUp76j5cc6S
         c0UScxKnb2KlBikTIAdjAL3E4nXsHtqe0hvMaueIEDy5CsE1vCIYvjWmGFAPE0m5Wu3l
         McDw==
X-Gm-Message-State: APjAAAUkwXuBs381YrgkDJVgb1Ez1EX8ME2uO7lywjOLKNoluM4AARvy
        rFxmnhCG2t7qnucQNvtiup+aPa3iPFa87G4x
X-Google-Smtp-Source: APXvYqz0T4mR7t35IkGgU7GPMFDrR+32WgLGxOPr798JywjnVKrMRIqLA7wYp/GFF8+RDmrHNeHsTA==
X-Received: by 2002:a50:fa05:: with SMTP id b5mr18013381edq.84.1567202640321;
        Fri, 30 Aug 2019 15:04:00 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id i4sm930846ejs.39.2019.08.30.15.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 15:03:59 -0700 (PDT)
Subject: Re: [PATCH] printf: add support for printing symbolic error codes
To:     Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
References: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
 <64a000cc3b0fcd7c99b5cd41b0db7f1b5e9e6db7.camel@perches.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <9fecd3a9-e1ae-a1f9-a0c5-f5db3430c81d@rasmusvillemoes.dk>
Date:   Sat, 31 Aug 2019 00:03:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <64a000cc3b0fcd7c99b5cd41b0db7f1b5e9e6db7.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2019 23.53, Joe Perches wrote:
> 
>> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> []
>> @@ -2178,8 +2204,6 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>>  		return flags_string(buf, end, ptr, spec, fmt);
>>  	case 'O':
>>  		return kobject_string(buf, end, ptr, spec, fmt);
>> -	case 'x':
>> -		return pointer_string(buf, end, ptr, spec);
>>  	}
>>  
>>  	/* default is to _not_ leak addresses, hash before printing */
> 
> why remove this?
> 

The handling of %px is moved above the test for ptr being an ERR_PTR, so
that %px, ptr continues to be (roughly) equivalent to %08lx, (long)ptr.

Rasmus
