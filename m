Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0626379A41
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 22:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbfG2UsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 16:48:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40403 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387816AbfG2UsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:48:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so63304125wrl.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RDzvvOLuO0FrlKWxE2OmL3qzW6ImORMj+8bQNrB211w=;
        b=bqYg2vf6S77RfIIDwmBpPvt98JMouraDjU/7gkOw4RUdkILM9kHRrxPCO1GPEiAfrB
         8k7HgMX7cALTWMIvmrVFh6Z7j8UypTjrSThLnoXQzgJQEUXYLwVrpd/FYWZ3uJol2rHH
         Kl+IJS7l+LdQCn41iD/kRCqtErAV//frDl3lYXeMfyWBR94TF9FzeDw0owWo+OEEHPSG
         8uwvF5QvbEjNHE17mrI6MRB4xoeMNHwwsqAISapLtlap5lQkdueROuTAewOxp+Z9mS11
         6fPixvDgOIu7s/zq1LWwASsumNqNj8nmbp+waUiGMVX33yO5DWFgPQnkrzaBnVoeHVTY
         E4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RDzvvOLuO0FrlKWxE2OmL3qzW6ImORMj+8bQNrB211w=;
        b=SrOym6XetfqUS9Mygsf5BZE597IYprN+KIUKN0E+MCzdt7v4DAf95nVeyzuO+4T1BX
         JSLmCrGLav6yps5ERjm8IbfNz2xYTy+4PcTfZJDv5Qktwl8ouK8c7Q41MCTHgaa0u09Q
         S4VigcIMsfwEhAMCSc0XZBkJg8ypfgm4/voqYebI1F+xK8ZbTThyiBGq3O9eLU8HBcM6
         W4KtKGWLd0m461GsRqgoBy+mAn+SveLRd3Tkwkk6tgD8/tpJTq2D5sjRFh1LjEdEmbWz
         Gu7pDGmO8OU5Kr0QN0cRdEfOAbBkw5R9gqKNOPIKEOR91teJ32Q+Zfp8wFYj1rI1r3O5
         txcA==
X-Gm-Message-State: APjAAAVROinU6BxmxTaLRuM9YmXztWU7cK41/0LmS7VkOWKgprJcqlwH
        ObUe9/m5ToB6A6/0gYKBteI=
X-Google-Smtp-Source: APXvYqz0cYI4K316CGTDakDGyEqSptDOdhcM8y/dijSRlDVX+fk7T3qYCFFRPauHBHOlOJ6IkHwRUg==
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr20910659wrw.178.1564433277503;
        Mon, 29 Jul 2019 13:47:57 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id s188sm51874539wmf.40.2019.07.29.13.47.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 13:47:57 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:47:55 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kbuild test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] powerpc: workaround clang codegen bug in dcbz
Message-ID: <20190729204755.GA118622@archlinux-threadripper>
References: <20190729202542.205309-1-ndesaulniers@google.com>
 <20190729203246.GA117371@archlinux-threadripper>
 <CAKwvOdm7GRBWYhPy4Ni2jbsXJp8gDF-AqaAxeLbZ03+LvHxADQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm7GRBWYhPy4Ni2jbsXJp8gDF-AqaAxeLbZ03+LvHxADQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 01:45:35PM -0700, Nick Desaulniers wrote:
> On Mon, Jul 29, 2019 at 1:32 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Mon, Jul 29, 2019 at 01:25:41PM -0700, Nick Desaulniers wrote:
> > > But I'm not sure how the inlined code generated would be affected.
> >
> > For the record:
> >
> > https://godbolt.org/z/z57VU7
> >
> > This seems consistent with what Michael found so I don't think a revert
> > is entirely unreasonable.
> 
> Thanks for debugging/reporting/testing and the Godbolt link which
> clearly shows that the codegen for out of line versions is no
> different.  The case I can't comment on is what happens when those
> `static inline` functions get inlined (maybe the original patch
> improves those cases?).
> -- 
> Thanks,
> ~Nick Desaulniers

I'll try to build with various versions of GCC and compare the
disassembly of the one problematic location that I found and see
what it looks like.

Cheers,
Nathan
