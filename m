Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D82E13D321
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 05:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgAPE3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 23:29:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34975 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgAPE3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 23:29:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so2319965wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 20:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fdDF50I5hxOY/uPvyTi5Nyzs/7Qte+oY6PsGo1nyL58=;
        b=VJZd2J3EFk4ApDAMA0KbDnAQusdZC6K5RRRZ4scnAuuUXCdOd7bkkyKATo3LVHqGfc
         7+Y2mXmYskr27gV6fWdm2yaZ3EhnQGcM86zrXjhQFrFjgSNc7pTO2vd541y2uQbQr5mV
         ThYe9oy1kI5ia7dtARf11oWgcp0HBfN0QtCKqoQpcatBifaj9SNUd5SWpr0rHhWvWd4l
         zS8cMHIrVSZ/nC3cIfbSbYrPL/t4VrFQlPrEbKPbliWdVH8VkpE3nPQdW8k1mMYCN0LU
         tFVhCB0X+cph3Ck6dc79N+jsk6K9A6NAczEle4XN7zkxo0BDuU0UOtaIPX4rBPQWnIBJ
         T60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fdDF50I5hxOY/uPvyTi5Nyzs/7Qte+oY6PsGo1nyL58=;
        b=UkZJuI4mALEvdOYvP+Uh3G9WuA33VsMhIWcKzl7ypiTRWO7m33VUTbs9hWndpZwm76
         5EH5Qmbqnur+8sK5y7uMsDVYFu4gUneLdhCUYMRoR/u/q2UQkuk6zCdbW4Q9dhhLRF+s
         I97aFDPC7Qf+yMvs1+oMtEyj23vhUbPJeGLYBY9zm/GhIBMUdXZ6TJ7kWS1ybny5l9QI
         wpnGRkx4HscQ3FaTJpOROLji+vF1nE/6TQ7wpKigjE1l4vMotSLMPi2wA0iTIO6Gka9Z
         S9bhteYi0hLRxmE4lVAj/bBjNrZpVObQFeKKOK0dmfeNK8sf79Zvq4vuThfOGv+HDDCF
         muyQ==
X-Gm-Message-State: APjAAAW8tHyM8NCI7Btnf73C5416Knt7h1ZBSiXcWo8lsskJk8NN5IlX
        d9WGF9j58A0//gDNzvZpkDykz95WXq5Y9GKNKLCXBg==
X-Google-Smtp-Source: APXvYqypT/bLy+NNQni/dEXiQ2hXcvwwOV1Jt+QjqxuT3KVv1AgYCM0umVbd9agiKV4gTPlgz17zzqhzBlat53lL0Zg=
X-Received: by 2002:a1c:9602:: with SMTP id y2mr3733923wmd.23.1579148943558;
 Wed, 15 Jan 2020 20:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20200115065436.7702-1-greentime.hu@sifive.com> <alpine.DEB.2.21.9999.2001151832001.98477@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.2001151832001.98477@viisi.sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 16 Jan 2020 09:58:53 +0530
Message-ID: <CAAhSdy0r1AZVW3JL-KoUi5eh_b78Bw2VogOBA8CidydK5RzJAw@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: make sure the cores stay looping in .Lsecondary_park
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Greentime Hu <green.hu@gmail.com>, greentime@kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 8:02 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Wed, 15 Jan 2020, Greentime Hu wrote:
>
> > The code in secondary_park is currently placed in the .init section. The
> > kernel reclaims and clears this code when it finishes booting. That
> > causes the cores parked in it to go to somewhere unpredictable, so we
> > move this function out of init to make sure the cores stay looping there.
> >
> > The instruction bgeu a0, t0, .Lsecondary_park may have "a relocation
> > truncated to fit" issue during linking time. It is because that sections
> > are too far to jump. Let's use tail to jump to the .Lsecondary_park.
> >
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
>
> Thanks, queued for v5.5-rc.  Anup's Reviewed-by: has been dropped since
> the patch changed significantly - Anup, if you are still happy with it,
> please reply with another Reviewed-by:.  Thanks,

You can keep my Reviewed-by. I did not see any functional
changes in the patch so I am fine.

Thanks,
Anup
