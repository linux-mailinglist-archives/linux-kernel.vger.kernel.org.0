Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13296E8A31
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 15:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388899AbfJ2OA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 10:00:56 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32844 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfJ2OA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:00:56 -0400
Received: by mail-qt1-f195.google.com with SMTP id y39so14953605qty.0;
        Tue, 29 Oct 2019 07:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rTascIDkhsRKyjbJRI9Qw1x1aWYBVRF+G+MqIT5POPs=;
        b=ZHc3abwNaK++Dko3PvPts93TVzUV3oubJdTfCEVwWK9owhBuh9xJMHmhF42CbLnl1T
         T536CeKakQQq4vJDI5jX0PW6Tdt+L07ZWrigvIW9xrao7PEjDwG9r5TEWIRi28RM2TrK
         jh8fGkKtJSNbN9nuJa+aIxxFEOLkvsL2mSAVY84Y6s8Y2kMBD2TETVQm/f4tXTwkZBQc
         oOmDa20AJsgnI3CbJh04OxeoBQPVodWKrbDp6XrJZ5uqj5CnBU87EEhhNAUS/396ePkd
         +b7rnVlzRRAvPOEfkqs7FFdS+GGiT2KHnAAh9BHbofsOOc2iq1v3OMM3TulhK0so1haB
         Ed/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rTascIDkhsRKyjbJRI9Qw1x1aWYBVRF+G+MqIT5POPs=;
        b=q+xbzr+vWUzO2vuY9n2RQfHAlwG128En4AXynd0+4V6e+L2YPF3092Xur2+Gsoruyq
         vrXXECcOe4q8snKVtiVq8cztT0rVq9fJjKyjr15+GlnoLDakOQDz4YOtl5QpDbpwIVjb
         5T/89o7KorqcWDU14qFlBDjjS9BwKqVpsLkspNp858VF9dEowt3+1M+3Ibnrn1KPnvfC
         jtVQ3DVWyshnDxxHBsHKins30zVIw59gZEyRt40BZtu5o2PmkCeyI5RFLCXRtA3j2eHS
         Jp5NBslY4PDGfyHz8G6gifRFH158aKusD+A9rTibGL7LzE1v3Re6wuuYBdfNOofzCxYM
         dO7g==
X-Gm-Message-State: APjAAAWmNvvzu1x65ZNFKNjvkRTXLeOUNf8FRru0LGY9AKVG2+rIWmBR
        qdsesnWCUCOa4SwRK0nFp1M=
X-Google-Smtp-Source: APXvYqxNLUDgaMCOSR9d6bxbT2x57hmz/rT4Sg4RvgfmDv4dGLRKXZSh8tg0VzRr/zldQ1vEeNuA5Q==
X-Received: by 2002:a05:6214:1812:: with SMTP id o18mr23804244qvw.33.1572357655321;
        Tue, 29 Oct 2019 07:00:55 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id j4sm7215922qkf.116.2019.10.29.07.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 07:00:54 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9D8E340D5C; Tue, 29 Oct 2019 11:00:52 -0300 (-03)
Date:   Tue, 29 Oct 2019 11:00:52 -0300
To:     James Clark <James.Clark@arm.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, "acme@redhat.com" <acme@redhat.com>,
        "irogers@google.com" <irogers@google.com>
Subject: Re: [PATCH] Fixes issue when debugging debug builds of Perf.
Message-ID: <20191029140052.GB4922@kernel.org>
References: <20191028113340.4282-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028113340.4282-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 28, 2019 at 11:34:01AM +0000, James Clark escreveu:
> When a 'make DEBUG=1' build is done, the command parser
> is still built with -O6 and is hard to step through.
> 
> This change also moves EXTRA_WARNINGS and EXTRA_FLAGS to
> the end of the compilation line, otherwise they cannot be
> used to override the default values.

The patch came mangled, so I'm applying by hand, and separating it into
two patches, the first for the first paragraph and the other for the
second, ok?

- Arnaldo
 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/lib/subcmd/Makefile | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
> index 5b2cd5e58df0..1c777a72bb39 100644
> --- a/tools/lib/subcmd/Makefile
> +++ b/tools/lib/subcmd/Makefile
> @@ -19,8 +19,7 @@ MAKEFLAGS += --no-print-directory
>  
>  LIBFILE = $(OUTPUT)libsubcmd.a
>  
> -CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
> -CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
> +CFLAGS := -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
>  
>  ifeq ($(DEBUG),0)
>    ifeq ($(feature-fortify-source), 1)
> @@ -28,7 +27,9 @@ ifeq ($(DEBUG),0)
>    endif
>  endif
>  
> -ifeq ($(CC_NO_CLANG), 0)
> +ifeq ($(DEBUG),1)
> +  CFLAGS += -O0
> +else ifeq ($(CC_NO_CLANG), 0)
>    CFLAGS += -O3
>  else
>    CFLAGS += -O6
> @@ -43,6 +44,8 @@ CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
>  
>  CFLAGS += -I$(srctree)/tools/include/
>  
> +CFLAGS += $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
> +
>  SUBCMD_IN := $(OUTPUT)libsubcmd-in.o
>  
>  all:
> -- 
> 2.23.0

-- 

- Arnaldo
