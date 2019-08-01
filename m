Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A107E502
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 23:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbfHAVxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 17:53:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38704 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfHAVxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:53:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so43130670wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 14:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nrK5VYG3frnI0dPT19ekGa5QOgRLyzUshpUSH8DEy3w=;
        b=IapEsavWifq9MMtfS+pSqtYQBiSMaWWZwsItdY5MmXzc/tfTosGEbKcSjBbk0rLlHs
         8WQKrrXZe8mHveH0D3Naj2ipWJ2NTx3UQnKZ5VJKH17f+9AOah0NzcGs+K/4lNT3EU4a
         xlbVo9VVNJ3kHlmXyCBpC0s+f5W1LVjHLy0LYEGfsF/UM8cTT3MChTDYgKUB+1g0DzMe
         Keqh8veN4y8W2ZECAku8GlDf3nBXJc49DVCxkH7r5psE3nlglJQea5w4bEBQIQzngiZe
         T4IO92Q4T718QN0nkoeOorIU7xMKz6vyfc2N6Nt8qERw73XxvFGvxq0Ctw6UrFQP622X
         hM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nrK5VYG3frnI0dPT19ekGa5QOgRLyzUshpUSH8DEy3w=;
        b=SF7PQ4FWWCnClliRSgER7A75TSUdmkdc+TkPls41Urt3ILOadoGdRBgahyQudYvoRI
         yBLbkyLSYBYCIXsTTFoCJz2BZEPkixk5Lv7c3E2mjbhK6nhkXoMjJ9GHIkJ1N3HYNTpC
         tUAN4yhtLvTyXyQ4uZ3UMZXBs7fPzdkKQ5tbTuE+Oa0eqOSYaGVxj+3HA5lAf+p3w2v7
         kXHDZkPp4Y+tWF2m2WgJ6HzVfCqnVeOV8MoSUApsv6ijehUtoLX3CLbiAdM3Uj6C2QzK
         Dt3BiPlQzdj2vN68N341YKrqSrTpvjCx7JXVbEYAB0EGarnhW747CQhLd+t8J4/D7zfb
         9fVg==
X-Gm-Message-State: APjAAAVwK2QJD66W5dO7qS3qeDPECKaq+1S1cmbRjHUIFDXcibOsKdvz
        uH6ejAKKFqi+FJR9aXCaKOmkcDQ=
X-Google-Smtp-Source: APXvYqwvgLxH3Gn3z5vik1rnTRWKuZ5qu4WddFDpB89hoMKrNLpXlWEf3II4gl8IyKLS7E/PjE0mrg==
X-Received: by 2002:a1c:f918:: with SMTP id x24mr510225wmh.132.1564696402302;
        Thu, 01 Aug 2019 14:53:22 -0700 (PDT)
Received: from avx2 ([46.53.248.54])
        by smtp.gmail.com with ESMTPSA id q18sm89245892wrw.36.2019.08.01.14.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 14:53:21 -0700 (PDT)
Date:   Fri, 2 Aug 2019 00:53:19 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        jing.lin@intel.com, bp@alien8.de, x86@kernel.org
Subject: Re: [PATCH] x86/asm: Add support for MOVDIR64B instruction
Message-ID: <20190801215319.GA8277@avx2>
References: <20190801194348.GA6059@avx2>
 <20190801194947.GA12033@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190801194947.GA12033@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:49:48PM -0700, Luck, Tony wrote:
> On Thu, Aug 01, 2019 at 10:43:48PM +0300, Alexey Dobriyan wrote:
> > > +static inline void movdir64b(void *dst, const void *src)
> > > +{
> > > +	/* movdir64b [rdx], rax */
> > > +	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> > > +			: "=m" (*(char *)dst)
> >                                ^^^^^^^^^^
> > 
> > > +			: "d" (src), "a" (dst));
> > > +}
> > 
> > Probably needs fake 64-byte type, so that compiler knows what is dirty.
> 
> Would that be something like this?
> 
> static inline void movdir64b(void *dst, const void *src)
> {
> 	struct dstbytes {
> 		char pad[64];
> 	};
> 
> 	/* movdir64b [rdx], rax */
> 	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> 		     : "=m" (*(struct dstbytes *)dst)
> 		     : "d" (src), "a" (dst));
> }
> 
> Or did you have something else in mind?

Well, it doesn't need a name:

	: "=m" (*(struct{char _[64];}*)dst)

But yes, something like that.

Can't cast to "char[64]" :-(
