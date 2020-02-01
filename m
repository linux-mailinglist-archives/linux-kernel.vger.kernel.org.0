Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B6814FA14
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 20:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgBATC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Feb 2020 14:02:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36840 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgBATC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 14:02:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so12685894wru.3;
        Sat, 01 Feb 2020 11:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m+fKGz4irTrvx15zBCp1Wm5j4aNzAse0q/n0LmFx72A=;
        b=cJgiXPY44BLUH5tkRbaNMmFgzbCieVyUtBHRfFdA9pw7q88xT2THX/+qOTB+PCLiWE
         126fc+yFJpfClpoQNT9xCt9ZqK4diP7ztnHV0xwFEw+z0VhMS76g0uROeDMRVje5zGSG
         qoPKKH+khE515ujUFDN5BI9HhRt/1/L9obLdagcQtE/KvY2sszfE09rgEMMgnRIh3y13
         erbWT2Kg/Qm56VXMzN33ffAWUEZpXxwKnnLKA/VVsKnTNRtWO9kKsY0yksXAiU4jViV2
         lT4W06ABM92nywlnSEfY2kK6jWcqZEFm6hcdWGMoUvW2cT3rCIcysh5JNFp0rdXz1BYj
         ksqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m+fKGz4irTrvx15zBCp1Wm5j4aNzAse0q/n0LmFx72A=;
        b=Zt5R9szIBznvx0Qp9PGbUkTi3sQw0wiWsUeie5dnP25J3io93hYhH05VBPuOiohpNL
         qPVH4A0UMgHB65SbMRIc96tOyL2JOGKoVtRrVo6SQ1pTXxdEP56UiUtz17jKAraFuMFW
         IzQu9rZkyLLGMDR2IhE74muOHwJxsJTHFz7dzO7miq9nbIzL7BEMbIfGBm/NQKLFHWQ8
         LFArPxsCE7XJCGIf7S9qaM/IZ/5w8XH6GCzU1beRCQcZZtATu3OlqjItZXWNGf1b7rUT
         MgAmyuigKP6O831MUQbhPYCSnrXroVItlVMLQtMPxvxEQXONU/gBRfcv7kV7/mpexZbJ
         IzHg==
X-Gm-Message-State: APjAAAU4lXWQcKnPx0MInvD5BZYz9XR17UpXivyBSnZKvxFCU9eCyvOj
        Dot1V25U9kpbwRfYzWO42mY=
X-Google-Smtp-Source: APXvYqyDXSUBloCuQMsqfu8YYKW2zaODc4GiI7M2lWs7Egwl0hUxd7jSwsiTXWRHo2nCJ3rDEyGVYQ==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr5861755wrr.73.1580583744481;
        Sat, 01 Feb 2020 11:02:24 -0800 (PST)
Received: from quaco.ghostprotocols.net (catv-212-96-54-169.catv.broadband.hu. [212.96.54.169])
        by smtp.gmail.com with ESMTPSA id s1sm9104812wro.66.2020.02.01.11.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2020 11:02:23 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6B9E040A7D; Sat,  1 Feb 2020 20:02:22 +0100 (CET)
Date:   Sat, 1 Feb 2020 20:02:22 +0100
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] MAINTAINERS: add TRACE EVENT LIBRARY section
Message-ID: <20200201190222.GC13359@kernel.org>
References: <20200201161931.29665-1-lukas.bulwahn@gmail.com>
 <20200201131453.32018229@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201131453.32018229@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Feb 01, 2020 at 01:14:53PM -0500, Steven Rostedt escreveu:
> On Sat,  1 Feb 2020 17:19:31 +0100
> Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> 
> > The git history shows that the files under ./tools/lib/traceevent/ are
> > being developed and maintained by Tzetomir Stoyanov and Steven Rostedt
> > and are discussed on the linux-trace-devel list.
> > 
> > Add a suitable section in MAINTAINERS for patches to reach them.
> > 
> > This was identified with a small script that finds all files only
> > belonging to "THE REST" according to the current MAINTAINERS file, and I
> > acted upon its output.
> 
> Thanks Lukas!
> 
> Arnaldo, would you like to take this?
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Sure
 
> -- Steve
> 
> > 
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Ceco, Steven, I added the information based on what I could see from an
> > outsider view. Please change and more files to the entry if needed.
> > 
> > applies cleanly on current master and next-20200131
> > 
> > Ceco, congrats becoming a kernel maintainer :)
> > 
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1f77fb8cdde3..17eb358c3fda 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16903,6 +16903,13 @@ T:	git git://git.infradead.org/users/jjs/linux-tpmdd.git
> >  S:	Maintained
> >  F:	drivers/char/tpm/
> >  
> > +TRACE EVENT LIBRARY
> > +M:	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
> > +M:	Steven Rostedt <rostedt@goodmis.org>
> > +L:	linux-trace-devel@vger.kernel.org
> > +S:	Maintained
> > +F:	tools/lib/traceevent/
> > +
> >  TRACING
> >  M:	Steven Rostedt <rostedt@goodmis.org>
> >  M:	Ingo Molnar <mingo@redhat.com>
> 

-- 

- Arnaldo
