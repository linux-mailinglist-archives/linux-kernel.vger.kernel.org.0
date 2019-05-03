Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C3112B9F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 12:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfECKiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 06:38:11 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:65306 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfECKiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 06:38:10 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x43Ac1Qc000661;
        Fri, 3 May 2019 19:38:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x43Ac1Qc000661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556879882;
        bh=z7qWPYt54zXPnY1EHO1cINwnW/JOhWqqFZK66vlin2o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qTiSEkhrKRNzxyDZ6OyGXLFW0WKpoTZOlYF/wcAHv3aXafw5Mpgq+L+pAMkc/78rJ
         3BWurpHpT7b2FBoPBK+jkg3r1Zyv5DLJNrMu9g6tWKFOekKnq+QVWbllf23r/qXAAy
         ZADcg9mJ6Qc5Zhegs/CLMoukkNVea4QdNJYWjcx2XDZT6AYqnK43kumeu5QTdEK/eL
         QcEVWn6fl8qDBN8TTLlr3SXLWjHbTF74gK9cqKTeQxeq9rk3pnVzH7zyIBNPF37txb
         Zmo35si3C4VJfkM+Af/HZk+PxGMavoY3O8JPq6+PbUHe4fcmAdOrDGpVQElCvrsZ1G
         zcSW6UxT3GBkg==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id p13so1817057uaa.11;
        Fri, 03 May 2019 03:38:02 -0700 (PDT)
X-Gm-Message-State: APjAAAX6gEXlYaEXGgprzFxLP96IYFOAyk6R9RiAHghPFWr5OWmQeFcg
        Z2iM/mEo5E+iOiLku9a6RLOfgsZ7fyBykHyruMw=
X-Google-Smtp-Source: APXvYqzCdsz3KhcSYohvrcVFpo5/mdG5kB41e90KjS/S/j/YeN38wNo4yGewST3tmzRw0ZSncJyz61Uqws6KXQbsQzI=
X-Received: by 2002:ab0:3058:: with SMTP id x24mr4656573ual.95.1556879881034;
 Fri, 03 May 2019 03:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190502074207.01ae28ba@canb.auug.org.au>
In-Reply-To: <20190502074207.01ae28ba@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 3 May 2019 19:37:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNATR7X0zTjp6ny_qdfxeJg0nBtixpPawW-3MUwjipCzz-w@mail.gmail.com>
Message-ID: <CAK7LNATR7X0zTjp6ny_qdfxeJg0nBtixpPawW-3MUwjipCzz-w@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,


On Thu, May 2, 2019 at 6:43 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Masahiro,
>
> Commit
>
>   7b6954a982e7 ("scripts: override locale from environment when running recordmcount.pl")
>
> is missing a Signed-off-by from its committer.

Fixed it now.
Thanks.


> --
> Cheers,
> Stephen Rothwell



-- 
Best Regards
Masahiro Yamada
