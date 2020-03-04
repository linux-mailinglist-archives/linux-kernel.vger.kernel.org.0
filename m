Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92E98179302
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 16:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgCDPLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 10:11:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45222 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgCDPLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:11:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id v2so2806032wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 07:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VOLjflFVC/lWbN0oTsQoOMlRo2O6lU0WwAevEZ9SEdI=;
        b=LK9qIEqAos8I+5PbVxeMUNEQowsGtb2yvZBfKLIL9byiCFb2lM/Z1VX1MUVZ2vTsq4
         uUKx54WRPsWHJ9c28c79a62LXsGPnzf2yJKMxPLnsTDVKJWC7TdavhOj0h5vL2NN2CbN
         v7K/pyiwWMEWyHrPwkv0ylf6chj5d2kI0PN6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VOLjflFVC/lWbN0oTsQoOMlRo2O6lU0WwAevEZ9SEdI=;
        b=o8NpCyV0ybheUxBH2yHhxSryheVNjkFEYY3M8XYkmr+1P8wakuwV15sBG0YsgBFDAi
         xJsW9KUDU6aOFPs7KNMoDRZqS31ahRC3aXMxcJKqDtVJLAIgsUAJq+ElDIuYe7ryxEh3
         EMPnfrGoEwRHVLb8XY/KZ+1mRgFdfqAcUGvxvVn3HIO+tlNI7GyCw8cwPGlyYP/LR8ox
         tV1AhpKGk84B9n1W4Dl5nuQz9bb9JOqUueAmm/43yWHw20PL1NbJj9OMZfBCRazFS35f
         JhVnSOkkcvi+sE2IG6RKH0XgwE3eHEih6oU/XOqPje1YIKSTAuyvXFhScZlaWE2TS6K1
         E6AA==
X-Gm-Message-State: ANhLgQ02+ILs/RzLQUMqxV9OTzYr0NG4XzTrGn9WbGw1AZLEqDJx5N2f
        7DZAtLqsFxaow52Wu3xqYB4WOw==
X-Google-Smtp-Source: ADFU+vvmwLJVhHP8ankCTyjBG5OOGXMaCLj3M653APMUHZ2b0hi7BJdsXPK8oA0X1aSIXr+EIHZPIw==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr4443265wrk.407.1583334707456;
        Wed, 04 Mar 2020 07:11:47 -0800 (PST)
Received: from chromium.org ([2a00:79e1:abc:308:8ca0:6f80:af01:b24])
        by smtp.gmail.com with ESMTPSA id z16sm38642092wrp.33.2020.03.04.07.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:11:46 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 4 Mar 2020 16:11:45 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next v2 2/7] bpf: JIT helpers for fmod_ret progs
Message-ID: <20200304151145.GB9984@chromium.org>
References: <20200304015528.29661-1-kpsingh@chromium.org>
 <20200304015528.29661-3-kpsingh@chromium.org>
 <CAEf4Bzah9CpWJ1vLuy+V1K26Ka1ovKvvAnbRuYBJ1GF-xcQbJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzah9CpWJ1vLuy+V1K26Ka1ovKvvAnbRuYBJ1GF-xcQbJQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-M�r 20:52, Andrii Nakryiko wrote:
> On Tue, Mar 3, 2020 at 5:56 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > * Split the invoke_bpf program to prepare for special handling of
> >   fmod_ret programs introduced in a subsequent patch.
> > * Move the definition of emit_cond_near_jump and emit_nops as they are
> >   needed for fmod_ret.
> > * Refactor branch target alignment into its own function
> >   align16_branch_target.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> 
> I trust invoke_bpf_prog logic didn't change, code was just moved around, right?

Yes, that's correct.

- KP

> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> 
> >  arch/x86/net/bpf_jit_comp.c | 148 +++++++++++++++++++++---------------
> >  1 file changed, 85 insertions(+), 63 deletions(-)
> >
> 
> [...]
