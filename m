Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D5CAE628
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 10:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfIJI7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 04:59:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45380 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfIJI7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 04:59:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so11120694pfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 01:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BVZkeB8kcfbAhGWCwFmsi+Af79YcNd2rTDIYMad/gaM=;
        b=GMqgtLrwt3KM8f3wheWQ7WpLBzaMDWSTCw5oTy8E406J0B6emHLl1jKtsM+6vYT72P
         VweUtZAmpCf6H/wVVMayc3KsdLLcGrydwRc+pZKkjJZPadftpD6K7raTMiVSPhaLV+dr
         PdGEZMyKA66nEZoTsUqvbTm1f6HMlCuf8pNeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BVZkeB8kcfbAhGWCwFmsi+Af79YcNd2rTDIYMad/gaM=;
        b=GDMKk3d1fdhkkNkg9zw+B9A8Qwcp9wXhZgV060ihgzV6VIx9Xkrua8mbAWHE9U0AYF
         nM5lUJy12C7/2mtUzjsN2v3ChX+BP1Xoa7nTr4zrO/VA7m8L2hvcwaZP3l4aEu8CTR/H
         M5k1NgzCrUmwysI+f0cuFNzd0tS9n/kE9e7lHR+F57sFfYZgq6ltKPWnkI8oQH4h24D0
         4lnO1eIC0AMZrc9ozK3vlxtTdWr6HwzZskNu9I+E0iuQROKoLSP6LA/Zpl35K5xoQq7Q
         5LabUbR8r4niYhNs50Eu/5bxkT7DHbwkftcaiub8/VxoosnQwsg29PKxnFvQLAa7u3Al
         dT5Q==
X-Gm-Message-State: APjAAAUSmw+2j/VwdDjXe9kxyDk3giH2DYjuNYXLKc/Y1wlbaCQL7YtK
        7w3yBg7APc5DRQOiMzY0LLcDbg==
X-Google-Smtp-Source: APXvYqzK0Ttf4/Xi57wL2oeea0djC4HNgeahFaJrMzpGlfeG86fQuDKcRSHD3yi1HIq4tDv9kNpaSA==
X-Received: by 2002:a63:6888:: with SMTP id d130mr25498575pgc.197.1568105972826;
        Tue, 10 Sep 2019 01:59:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 127sm34965672pfw.6.2019.09.10.01.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 01:59:31 -0700 (PDT)
Date:   Tue, 10 Sep 2019 01:59:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     20190819234111.9019-8-keescook@chromium.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Drew Davenport <ddavenport@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception
 handler
Message-ID: <201909100157.CEE99802C@keescook>
References: <201908200943.601DD59DCE@keescook>
 <20190909160539.GA989@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909160539.GA989@tigerII.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 01:05:39AM +0900, Sergey Senozhatsky wrote:
> On (08/20/19 09:47), Kees Cook wrote:
> [..]
> > @@ -181,6 +181,15 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * BUG() and WARN_ON() families don't print a custom debug message
> > +	 * before triggering the exception handler, so we must add the
> > +	 * "cut here" line now. WARN() issues its own "cut here" before the
> > +	 * extra debugging message it writes before triggering the handler.
> > +	 */
> > +	if ((bug->flags & BUGFLAG_NO_CUT_HERE) == 0)
> > +		printk(KERN_DEFAULT CUT_HERE);
> 
> Shouldn't this be pr_warn() or pr_crit()?

The pr_* helpers here would (potentially) add unwanted prefixes, so
those aren't used. KERN_DEFAULT is used here because that's how it's
always been printed. I didn't want to change that for this refactoring
work. I'm not opposed to it, generally speaking, though. :)

-- 
Kees Cook
