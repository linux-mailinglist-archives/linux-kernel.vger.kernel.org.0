Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB7515349A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 16:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbgBEPuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 10:50:10 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44584 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgBEPuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:50:10 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so1142728oia.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2aqjudvMlvh0oAgf6gAKgM5a6NLakebVIMf7FzqBKbA=;
        b=nmGxKmVUA2OhLkQUbH6y2A7L06mm6SHPFb68R7f3pP4pUroSQH0JWbkZCM7M8Xhzs+
         +Htv1A8a2S84oshAAOnk/7bkqKnm7ylp92krajzLWAS9G5pu10T39Ux6iwLeVkN4mJdB
         0VCyIVrZMcoqfv4qqGFqViNnTEwo3SmTWVIeSX5M7ge0xtltBr3zaVwUPjRdThyKsJX1
         vcZKJyLSe74nml8RTTTXuG/60HF1a3f3IrNPUWpMNJADbyZWp2NnUVA0D+G1r727Q59w
         XLsKAB8vuCKg09pT9dI0TzxQohaZD0qTPWLGuftRmd5u0y1v7EumeME6ehfp4VKHwqBe
         8/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2aqjudvMlvh0oAgf6gAKgM5a6NLakebVIMf7FzqBKbA=;
        b=YshAxfqAQ53fC3M4QUWtho2o/dK0aJ8GPMt9SSIXPdyH2bRJQCqpBkTBH2FZWPI8Bp
         suh31Pn4vDkFi4qF+kvkF9PIr7qbHq7im1cwV0aQKq8t2V4nQUM/XpT7BGgQ+h4gK4Qe
         7ozaAnEE343FM1N+a7P/zdXXYqfaCcyAOSiQqPwRzTg0aUkhgc3Nt0lWJhh9i/vqN4Vz
         iZOuDyebPvCLSEaGR6Jkfj72pB+nO1Pa9CSlfDnKp3ghLc7HEnirDa4cEL13YVcgdqwV
         TgwNT8ATtuc1cYwM3Tz+WHUTc2Rb1Ffcq9sFKrnfvGEr2DPTcudbVxcMYtBVWyCYoIhI
         2yeg==
X-Gm-Message-State: APjAAAVf0CR5cBWBG4r7tQX4K6OQdbagllx1d7/CSlX3GiT4oChZmjf3
        aTjzepjwufR9VLugamzgvlE=
X-Google-Smtp-Source: APXvYqyH/Bh0UsG1tQvvd7e5fjWDvkq6XoCFinipCyy/2s0bOgj8HY487C4+pGeW9f4qVxfOvreIHg==
X-Received: by 2002:a05:6808:b1c:: with SMTP id s28mr3416836oij.2.1580917809086;
        Wed, 05 Feb 2020 07:50:09 -0800 (PST)
Received: from ubuntu-x2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id v25sm1349otk.51.2020.02.05.07.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 07:50:08 -0800 (PST)
Date:   Wed, 5 Feb 2020 08:50:06 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ASoC: wcd934x: Remove some unnecessary NULL checks
Message-ID: <20200205155006.GA21667@ubuntu-x2-xlarge-x86>
References: <20200204060143.23393-1-natechancellor@gmail.com>
 <20200204100039.GX3897@sirena.org.uk>
 <20200204193215.GA44094@ubuntu-x2-xlarge-x86>
 <20200205102238.GG3897@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205102238.GG3897@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:22:38AM +0000, Mark Brown wrote:
> On Tue, Feb 04, 2020 at 12:32:15PM -0700, Nathan Chancellor wrote:
> > On Tue, Feb 04, 2020 at 10:00:39AM +0000, Mark Brown wrote:
> 
> > > I'm not convincd this is a sensible warning, at the use site a
> > > pointer to an array in a struct looks identical to an array
> > > embedded in the struct so it's not such a bad idea to check and
> > > refactoring of the struct could easily introduce problems.
> 
> > Other static checkers like smatch will warn about this as well (since I
> > am sure that is how Dan Carpenter found the same issue in the wcd9335
> > driver). Isn't an antipattern in the kernel to do things "just in
> > case we do something later"? There are plenty of NULL checks removed
> > from the kernel because they do not do anything now.
> 
> I'm not convinced it is an antipattern - adding the checks would
> be a bit silly but with the way C works the warnings feel like
> false positives.  If the compiler were able to warn about missing
> NULL checks in the case where the thing in the struct is a
> pointer I'd be a lot happier with this.

Yes, that would definitely be nice. I am not entirely sure that this is
possible with clang due to its architecture but I am far from a clang
internal expert.

> > I'd be fine with changing the check to something else that keeps the
> > same logic but doesn't create a warning; I am not exactly sure what that
> > would be because that is more of a specific driver logic thing, which I
> > am not familiar with.
> 
> I've queued the change to be applied since it's shuts the
> compiler up but I'm really not convinced the compiler is helping
> here.

Thank you :)

Cheers,
Nathan
