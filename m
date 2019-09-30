Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7011C28BF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 23:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbfI3VXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 17:23:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37493 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfI3VXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:23:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so6320197pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 14:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GGW5YTXB7k7QAffkQ+fScbfTHXGGFiBFSDibbhauwME=;
        b=ddO9ZvygJD5jwLI0fO07174NlB0/rckqIoShTN/ebn3GwVz316fFEx2WakWKR5sYT1
         n1wUwL4TWIuKSmPK7EzKxoWzexpzPb8fvtxG0OWlv1rxrYwzi8mbbujhCqPMVfVfpAGB
         EiFhgPPdEASb6t7MJLkcrmY9zuDq/76TDIaqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GGW5YTXB7k7QAffkQ+fScbfTHXGGFiBFSDibbhauwME=;
        b=SL9HrrVDXK6qRISQJsueJk74ekcUuYA8AW0YLn88zTdU9qHgEfLCPQXLRF64kwPkIf
         c2LO5O8RJdG1YFRM96+22gFfNWr1MMy99ngqdOpTO6UfJCHScRDj/RX/5NDFmBhcJn19
         PowZrJdGkASmEHPBtIxmdKP54l5dICMWy4vWY/kOpVB0037UXmjeEdDloW1fMiFYFVFa
         nr9ZSfajKsc5hYoG0kiI1eTfiUdjQycqIFxfUFrCG/c3V1Ya5ScCrSsFeDwY6EVSsjHt
         u71PoeIcG+qIO/kL4ATd+tIQnbkuSi2xL3CmJGPYLa2yvnZyAESc4nUcBGytjLzXkrRd
         G/1w==
X-Gm-Message-State: APjAAAUgEar6RqA5n1ESekE8NHsCeDbeBT45x7LpQ7V0od2OMz1twy4R
        9eH8XzVVY0vNRvWQ/1OKwTO9G/Qel8Y=
X-Google-Smtp-Source: APXvYqzVvSQuFKi3OxDeHFdYnh9nwIIGKErryn+jU3ze4WyjYrcAVGpbNuJovH6XmCbtnOJ72fI7Mg==
X-Received: by 2002:a17:90a:ab85:: with SMTP id n5mr629907pjq.117.1569868143340;
        Mon, 30 Sep 2019 11:29:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u18sm14868888pge.69.2019.09.30.11.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 11:29:02 -0700 (PDT)
Date:   Mon, 30 Sep 2019 11:29:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau 
        <jeremie.galarneau@efficios.com>, s.mesoraca16@gmail.com,
        viro@zeniv.linux.org.uk, dan.carpenter@oracle.com,
        akpm@linux-foundation.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kernel-hardening@lists.openwall.com, linux-audit@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] audit: Report suspicious O_CREAT usage
Message-ID: <201909301128.5951C390@keescook>
References: <201909251348.A1542A52@keescook>
 <CAHC9VhRNmWw1__-haD1ZEekADTho3EJyXQMd6ETpOv4c8Qn9nw@mail.gmail.com>
 <2065829.xbNJnTdZ4q@x2>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2065829.xbNJnTdZ4q@x2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 09:50:00AM -0400, Steve Grubb wrote:
> On Thursday, September 26, 2019 11:31:32 AM EDT Paul Moore wrote:
> > On Wed, Sep 25, 2019 at 5:02 PM Kees Cook <keescook@chromium.org> wrote:
> > > This renames the very specific audit_log_link_denied() to
> > > audit_log_path_denied() and adds the AUDIT_* type as an argument. This
> > > allows for the creation of the new AUDIT_ANOM_CREAT that can be used to
> > > report the fifo/regular file creation restrictions that were introduced
> > > in commit 30aba6656f61 ("namei: allow restricted O_CREAT of FIFOs and
> > > regular files"). Without this change, discovering that the restriction
> > > is enabled can be very challenging:
> > > https://lore.kernel.org/lkml/CA+jJMxvkqjXHy3DnV5MVhFTL2RUhg0WQ-XVFW3ngDQO
> > > dkFq0PA@mail.gmail.com
> > > 
> > > Reported-by: J�r�mie Galarneau <jeremie.galarneau@efficios.com>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > This is not a complete fix because reporting was broken in commit
> > > 15564ff0a16e ("audit: make ANOM_LINK obey audit_enabled and
> > > audit_dummy_context")
> > > which specifically goes against the intention of these records: they
> > > should _always_ be reported. If auditing isn't enabled, they should be
> > > ratelimited.
> > > 
> > > Instead of using audit, should this just go back to using
> > > pr_ratelimited()?
> > 
> > I'm going to ignore the rename and other aspects of this patch for the
> > moment so we can focus on the topic of if/when/how these records
> > should be emitted by the kernel.
> > 
> > Unfortunately, people tend to get very upset if audit emits *any*
> > records when they haven't explicitly enabled audit, the significance
> > of the record doesn't seem to matter, which is why you see patches
> > like 15564ff0a16e ("audit: make ANOM_LINK obey audit_enabled and
> > audit_dummy_context").  We could consider converting some records to
> > printk()s, rate-limited or not, but we need to balance this with the
> > various security certifications which audit was created to satisfy.
> > In some cases a printk() isn't sufficient.
> > 
> > Steve is probably the only one who really keeps track of the various
> > auditing requirements of the different security certifications; what
> > say you Steve on this issue with ANOM_CREAT records?
> 
> Common Criteria and other security standards I track do not call out for 
> anomoly detection. So, there are no requirements on this. That said, we do 
> have other anomaly detections because they give early warning that something 
> strange is happening. I think adding this event is a nice improvement as long 
> as it obeys audit_enabled before emitting an event - for example, look at the 
> AUDIT_ANOM_ABEND event.

Okay, so the patch is good as-is? (The "report things always" issue I
will deal with separately. For now I'd just like to gain this anomaly
detection corner case...)

Paul, what do you see as next steps here?

-- 
Kees Cook
