Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42BE969B98
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 21:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfGOTo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 15:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbfGOTo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:44:57 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D9952173B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 19:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563219896;
        bh=eR7tQFCtsIZZKhV6oeIXYXLEwaZdSRmOV4XGxmJFXSY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IXBGoqnwfx6gH4+R7zihNHPWlDyRp6A32ettpPl9uP5usiof27oZQ2CZTffpc8DgE
         WJLmcCzB4jdBz7uCznSI3hSGpm4GXMCCLdxwc7G96S7l2UzUK65oDwiATwlm2Mx8/3
         nGODe1obul03Hj2tDBIR0Yk36jMpDI4ihpjRLNc4=
Received: by mail-wr1-f43.google.com with SMTP id n9so18390121wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:56 -0700 (PDT)
X-Gm-Message-State: APjAAAXfZvARqqSDCZLiKS/5Pkw+QJvcVvmwKCDAUrrP7q6OLlNMTnCA
        sn/Vji8AuGAmfz4Oh74gY5+0fVvV8GmjefclKVwEkg==
X-Google-Smtp-Source: APXvYqyP5Axlqzykr7dAlNKuZWGUt5mky/R05HlYWR+XEesdGn3879zXtuswSqnZK2d5yZmvNBT76Mxtb4pzaacfFAs=
X-Received: by 2002:a5d:4309:: with SMTP id h9mr29584933wrq.221.1563219894946;
 Mon, 15 Jul 2019 12:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com>
 <8736j7gsza.fsf@linux.intel.com> <alpine.DEB.2.21.1907152033020.1767@nanos.tec.linutronix.de>
 <20190715193938.GG32439@tassilo.jf.intel.com>
In-Reply-To: <20190715193938.GG32439@tassilo.jf.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 15 Jul 2019 12:44:42 -0700
X-Gmail-Original-Message-ID: <CALCETrW1VobMKcDU_zbvgy1DBe5j=iZUp165_q_NHS7+ZffG4g@mail.gmail.com>
Message-ID: <CALCETrW1VobMKcDU_zbvgy1DBe5j=iZUp165_q_NHS7+ZffG4g@mail.gmail.com>
Subject: Re: [RFC PATCH, x86]: Disable CPA cache flush for selfsnoop targets
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 12:39 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> > Right, we don't know where the PAT invocation comes from and whether they
> > are safe to omit flushing the cache. The module load code would be one
> > obvious candidate.
>
> Module load just changes the writable/executable status, right? That shouldn't
> need to flush in any case because it doesn't change the caching attributes.
>

Indeed.  module load should require a single TLB flush and no cache
flushes.  I don't think we're currently efficient enough to do it with
a single TLB flush, but we should be able to...
