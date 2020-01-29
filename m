Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1804014C453
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 02:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgA2BGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 20:06:54 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41098 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgA2BGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 20:06:54 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so12364972oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 17:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uf7ZtdoPuDYnW6BY3uedFbO/qLdqSJUxxoOzopLMW9M=;
        b=Pt8QwOzBXjW66PxCSTX99DDGcRWg6jtxSkrcuZ+wgWsoXokzro3CWrc+Wx3z7/MkoJ
         gHEQKS2HN2F0y1Isx6JzDfLU7YEiassIw5tUFpRk5JWtu8WI8RmVpdHdSDyA7YrQmZLm
         Tk7sZqODy75bpBGJbuTNN3kAI2it4EGM+1nQCPyikfol0yEN01JeMSPyCLYe7EzOZrM0
         CRY1t9kNDplrz753e5ji24lpFO3Wp9YhdR2SdV2X0Ok/9OQ8dxb23jeo6s0o3OWXJQUt
         JRs//7lc5+4leRNtm20P2zXmoqgXHntEraBuQym7IWr9/SK19ZOlqqcLpJ8PI7w0TTa0
         kg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uf7ZtdoPuDYnW6BY3uedFbO/qLdqSJUxxoOzopLMW9M=;
        b=cMvOOA2HMBil0FGOgFeJQJpbElyQqlTgRK+Zhgj33SojNdqqYlNcvdWlAjmC3He8pe
         8CSW+QiipaDhXY/YVMSbIdtcbwid5eGMIGRLov+FjH66IUQpvNX1AU4i0utZhKy356K1
         iOm3ANiLLfXbm0c3tuzJt/IXGBT7aODZTZt/jLob2lfNtcE8QZzI61J/fKCEneaLooId
         jSWN3RsiZOfBZ5hhC421rxkQFpQ1JvAQZN74x0dV6he/y0VtvzaL9fHU337JTg4EEwha
         4qx3kATWbbUBjrqqMMReQcp1+H/uanoS07IOn1hxv/Zv1eDvWzGgdMxcpyeM5lIUMPEL
         VAYA==
X-Gm-Message-State: APjAAAXNuyNiKA8+rLxuUIXwBRVB1WgM3mJRwrqTD4gWMGJ72CJ/0xmZ
        8sGWtgWkgkIFIXLDJIMpCI6eRRNXixYVGgT8E4XB3Q==
X-Google-Smtp-Source: APXvYqxBiTzP51y2MtQD9sHQn3uWViwsP4arDIb8LMfzcBjsxOFfG7RGcAyoDI9mJDTfzfaT1GfOt1mul0igU61QQDs=
X-Received: by 2002:aca:6542:: with SMTP id j2mr4877351oiw.69.1580260012836;
 Tue, 28 Jan 2020 17:06:52 -0800 (PST)
MIME-Version: 1.0
References: <20200129002222.213154-1-shakeelb@google.com> <20200129005922.GA74965@romley-ivt3.sc.intel.com>
In-Reply-To: <20200129005922.GA74965@romley-ivt3.sc.intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Jan 2020 17:06:41 -0800
Message-ID: <CALvZod7RnRBcNdEdAwOo=rnCO9E7Ap8j=sDDsK0dHVkh9uq+Dw@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: fix redundant task movement
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 4:49 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> On Tue, Jan 28, 2020 at 04:22:22PM -0800, Shakeel Butt wrote:
> > Currently a task can be moved to a rdtgroup multiple times or between
> > resource or monitoring groups. This can cause multiple task works are
> > added, waste memory and degrade performance.
> >
> > To fix the issue, only move the task to a rdtgroup when the task
> > is not in the rdgroup. Don't try to move the task to the rdtgroup
> > again when the task is already in the rdtgroup.
>
> Hi, Shakeel,
>
> Acutally we are working on replacing the callback by a synchronous way
> to update closid and rmid when moving a task to a resource group. The
> reason is the task may use old (even invalid) closid and rmid before
> they are updated.
>
> With the new way to update closid and rmid, the issues related to
> the callbacks will be fixed as well.
>
> We will release the new patches soon.
>
> Thanks.

Sounds good to me. I didn't get any response on the previous email
therefore I code this up.

Shakeel
