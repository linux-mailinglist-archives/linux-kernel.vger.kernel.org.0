Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A2814FC62
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 10:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBBJXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Feb 2020 04:23:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33165 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgBBJXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 04:23:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id u6so767407wrt.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 01:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sXuMcOH+VNjc67NNOI8dzekDLyq1aGZf4jXoBS5IWHM=;
        b=Aow+/nTstuVKaafEv2axDGAPg+3kTMYgMkwpX6tNWRdMJ/VCKJXa8Rz74ri5/jotA+
         idCY8iCWla69uLQlehcipA624SYvjzvj2Z0/beZfFzeQE9mlydjI3izPrEHE8dSZeqrh
         3dftGBYgnmkVw+8LHNHrfurQcgwXvse/yqHO4Ux3blcySeb+eEBsw+lzmYWtPGckgB39
         FOYlNXBXTQdkMs1qBAUj3823Zub+nXZJ8IriXPNMuuy01dDFyotXlVwCq79QhOU0IYyG
         mJibOpAim6RPqQNXTtf65vwxbEIgV6m0kibm/DTvb3NOxDuzBm1FbzAGcUNKMIb1/Yad
         8vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sXuMcOH+VNjc67NNOI8dzekDLyq1aGZf4jXoBS5IWHM=;
        b=dTllFNNzb7h5YRkWVB+e+3dPyx/4Jf7UopqRcgmaOj8CuimlJrEO1N7xDRhKFv7mcU
         ZOTfUsu7IYz2KO8jDiCz23VpEyVWdCJqFqKRFQVZr4D6yQLQOhd5mGtYYSashXn/0S6I
         llbofKYalBy+VKjRoQmv+ZOPWNW5yKRUtFCbmqTMlZvXEUlXmwEBsoJI8ZfOmPiDkj4R
         JK4tGaNhHSAZuUg7fvQOsoKUIupWKqm1x2l3IAlz+il9gwyzwae410tegUecS9SXftT6
         duSauuKyInhfRhsgh7h0bsgk64tnzQdNBbtwdB7TiND11uY6VjEyWcYOqXydGRN9EW09
         DjAA==
X-Gm-Message-State: APjAAAVFrHuNBi5TNEKVCESHrAfPO2SFagCyZk1/5n28DsKirp8z49L6
        r8UI4oChs/uF+Mwlprx27Mc=
X-Google-Smtp-Source: APXvYqy7X5t+bStwQAjrK0M/mteO0hQAUOcbGYJ3vLizuMioZu52WPJxQolXuHuaFe5hqJ6ULk1n/Q==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr9309738wrp.1.1580635377934;
        Sun, 02 Feb 2020 01:22:57 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x10sm20617722wrp.58.2020.02.02.01.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 01:22:57 -0800 (PST)
Date:   Sun, 2 Feb 2020 10:22:55 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     =?iso-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: EFI boot crash regression (was: Re: 5.6-### doesn't boot)
Message-ID: <20200202092255.GA72728@gmail.com>
References: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
 <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
 <20200131064327.GB130017@gmail.com>
 <CADDKRnATVt9JjgV+dAZDH9C3=goJ5=TzdZ8EJMjT8tKP+Uhezw@mail.gmail.com>
 <20200131183658.GA71555@gmail.com>
 <CAPcyv4iYSptWo42p1Lnbr4NWRiWG2sat+f3t8Q0kPeiiXHx3fg@mail.gmail.com>
 <CADDKRnBeB5T7ZW2LxJQMR=AjD-OyOGBs4gqH0O9_frJ5zR5E7Q@mail.gmail.com>
 <CAKv+Gu9C2gR629xegjVfVkrPhAuG5brONzbL9iDgPSPW0Ffbbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKv+Gu9C2gR629xegjVfVkrPhAuG5brONzbL9iDgPSPW0Ffbbw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> Hello Jörg,
> 
> Could you please try whether the change below fixes the issue?
> 
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 59f7f6d60cf6..ae923ee8e2b4 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -308,7 +308,7 @@ static void __init efi_clean_memmap(void)
>                         .phys_map = efi.memmap.phys_map,
>                         .desc_version = efi.memmap.desc_version,
>                         .desc_size = efi.memmap.desc_size,
> -                       .size = data.desc_size * (efi.memmap.nr_map - n_removal),
> +                       .size = efi.memmap.desc_size * (efi.memmap.nr_map - n_removal),
>                         .flags = 0,

Oh, I actually noticed this one, but convinced myself that it's correct, 
because GCC didn't warn about uninitialized data.

But maybe in this weird case data.desc_size as used within its own 
initializer is zero?

Thanks,

	Ingo
