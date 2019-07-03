Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB6A35DDD6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 07:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfGCFz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 01:55:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37844 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfGCFz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 01:55:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id 131so1022281ljf.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 22:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9G7dahqqLBvpWifetVIRcTe56P9tGwywaRmRI7DVfM=;
        b=WarTlUlnWaTK3MA99/Eo051DVjcu20CodKEPYS65TJisSvxsw78y3F7ulzzkOCDRuP
         7JLRlmfDNMOYtEMrVkmMTckvpYu8O/pZkDVKsFgt5RK8du2XOA/r1SkwyajYIw1xKKCn
         5zQJiGasB1K7g6R6NHs08k6nLqhMoHOda3Rio0FL8uPeHB/1VdUskxNHuCgQloRfvIYH
         HhGN5KBWFTKPyQXdKqZO77vgALn1KQpid4RTKA6PFdzy0BZmwVLTpyBuLkSyNz5bQET2
         7RReYiAPMe1BoKcE5VmOicBWENLCIAFcAUheORMcAmsQuKITwV0rBqcT1ZeoxOr2m/EA
         S6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9G7dahqqLBvpWifetVIRcTe56P9tGwywaRmRI7DVfM=;
        b=e2m8WCBfvVErSIMot1+v/o7FS0U7FLI3MUhLTHLNMy4F+0zZ7r9O89bKBYSLw/k4ho
         gLVRpumiA9wp1dVC3SCf/PO9GOor4lpKTWUzO3muA2QhFFcVwoFyxbpeKrq20gI6HFsa
         Rw9NHCwkvQdXMuHuQM4PNGcr681t8+J24XVoC3fex70bo1yCVtPjnUWAbnXcNQ2d1R78
         JQTb4t0KzRa5GX7yOf8bE6ibhNRCcOjUkgwEnMuGBRwdRTiAiq3cbJ1xS2enFGe24jjw
         7QkfUjUX4hixJUvb/58VOVOwBr9DyUHCGeYMqm3dgVGyu86PVYbb+g24TzQFge+4FhDA
         sovg==
X-Gm-Message-State: APjAAAX73ujLnO7NsTqW1geJ1HAFAxzuWSowQgFLUg7uMmtHBzqQcIrA
        hVoxx8D4ay2Wk7nkonMVsgfEttPBOaPacarHphE=
X-Google-Smtp-Source: APXvYqxbYWrWiGbrJerEdqPo1pfbe/idItfy/Bn8xk0BK95BO1LruB1YeM1oZ4jyeNbc7V2VFV/xNXdxvPvz22kFobw=
X-Received: by 2002:a2e:86cc:: with SMTP id n12mr19527958ljj.146.1562133327468;
 Tue, 02 Jul 2019 22:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190702005122.41036-1-henryburns@google.com> <CALvZod5Fb+2mR_KjKq06AHeRYyykZatA4woNt_K5QZNETvw4nw@mail.gmail.com>
 <CAGQXPTjU0xAWCLTWej8DdZ5TbH91m8GzeiCh5pMJLQajtUGu_g@mail.gmail.com>
 <20190702141930.e31bf1c07a77514d976ef6e2@linux-foundation.org> <CAGQXPTiONoPARFTep-kzECtggS+zo2pCivbvPEakRF+qqq9SWA@mail.gmail.com>
In-Reply-To: <CAGQXPTiONoPARFTep-kzECtggS+zo2pCivbvPEakRF+qqq9SWA@mail.gmail.com>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Wed, 3 Jul 2019 07:54:29 +0200
Message-ID: <CAMJBoFPDKZScs-uKSH-YggE5Jqocb6e74FdCPTOGnO5qfUXd2Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm/z3fold.c: Lock z3fold page before __SetPageMovable()
To:     Henry Burns <henryburns@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 12:18 AM Henry Burns <henryburns@google.com> wrote:
>
> On Tue, Jul 2, 2019 at 2:19 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Mon, 1 Jul 2019 18:16:30 -0700 Henry Burns <henryburns@google.com> wrote:
> >
> > > Cc: Vitaly Wool <vitalywool@gmail.com>, Vitaly Vul <vitaly.vul@sony.com>
> >
> > Are these the same person?
> I Think it's the same person, but i wasn't sure which email to include
> because one was
> in the list of maintainers and I had contacted the other earlier.

This is the same person, it's the transliteration done differently
that caused this :)

~Vitaly
