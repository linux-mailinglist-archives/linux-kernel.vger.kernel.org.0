Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15565EE4BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 17:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfKDQgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 11:36:33 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38015 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfKDQgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:36:33 -0500
Received: by mail-lj1-f193.google.com with SMTP id v8so2713507ljh.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 08:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T1bx/DaPDC6OwApDRf773PArCGhjTMdLqdzsWIpne4I=;
        b=hw0cwtZSChsco/dnelTqXZkBYy9t+LpaBwMCFbA3T4BmkjZqilTc7yu2BUVbyQzzA0
         s0VDDnWEE2tJKTVymARFE7zvEpnfg/OS9q8XDCnHC5XwZ0Bn5lZ8yNquKmdnlZSEJHO9
         eRxkx303BHSMCSVPG1Qs7jB7XYNENiibOPLwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T1bx/DaPDC6OwApDRf773PArCGhjTMdLqdzsWIpne4I=;
        b=GSCyUCv+BvqHjPpxg+ASXmiRniwuF+zNTpOrm3Rt/Km1DTblGgg+QBX31xKibQy+Jg
         uVB07v5FXRULKbaV8B4VjbjtlIMh8x2sZqqP9e4pOZXGadREO9/niyBC6WHC9kyHUINT
         sgiEOwNlJ6nGFk47ZdpG5BqORRPMfNCpx+vAXxYeWT4bpgBB5ZXURZQS2NNfCHQpe+sS
         Rg6myspQa1Os5nWoypZ7HQtSyMwR4w3OzUNl0pz1TAcOwtalr/qPayJTBGtgPzp8zbjA
         2bp2eydesJ4XHWBEatVeJYg558wrGYQzA5XfRprIvFpS8nagJLUfVQ5I+5y5+/8SS9Ec
         ZNyg==
X-Gm-Message-State: APjAAAWWGHD79IgS95nGqr1D3OFNWe+f9XlAV27HgGvbHGYX+4cOR9pL
        tVzOi49lyGPtalPGA6y47lNczOKXW7Y=
X-Google-Smtp-Source: APXvYqx7uiKGuz0f6JDgvWFTK+5VFxyl60u0AguOO3WbhNHm8exn0uFaTriudD6HnEoni3qFEXWPBA==
X-Received: by 2002:a2e:88c9:: with SMTP id a9mr7633730ljk.30.1572885388955;
        Mon, 04 Nov 2019 08:36:28 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 81sm8005869lje.70.2019.11.04.08.36.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 08:36:27 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id q2so11806367ljg.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 08:36:27 -0800 (PST)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr19511439ljp.133.1572885387047;
 Mon, 04 Nov 2019 08:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20191014132204.7721-1-thomas_os@shipmail.org> <a31f0d40-d8a5-faca-016b-0066f5ac31a2@shipmail.org>
In-Reply-To: <a31f0d40-d8a5-faca-016b-0066f5ac31a2@shipmail.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Nov 2019 08:36:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjPo0s+8NC+NKeYWeWbszVXHW+Dh3k9NG1DV0-cHoP0OA@mail.gmail.com>
Message-ID: <CAHk-=wjPo0s+8NC+NKeYWeWbszVXHW+Dh3k9NG1DV0-cHoP0OA@mail.gmail.com>
Subject: Re: -mm maintainer? WAS Re: [PATCH v6 0/8] Emulated coherent graphics
 memory take 2
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 1:21 AM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> I'm a bit confused as how to get this merged? Is there an -mm maintainer
> or who is supposed to ack -mm patches and get them into the kernel?

I was assuming they'd go through Andrew Morton.. Andrew?

            Linus
