Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40DE3174A09
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 00:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgB2XTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 18:19:18 -0500
Received: from hosting.gsystem.sk ([212.5.213.30]:33938 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgB2XTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 18:19:18 -0500
Received: from [192.168.0.2] (188-167-68-178.dynamic.chello.sk [188.167.68.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id CB2B47A0469;
        Sun,  1 Mar 2020 00:19:16 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 00/10] floppy driver cleanups (deobfuscation)
Date:   Sun, 1 Mar 2020 00:19:14 +0100
User-Agent: KMail/1.9.10
Cc:     Willy Tarreau <w@1wt.eu>, Denis Efremov <efremov@linux.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-block" <linux-block@vger.kernel.org>
References: <20200224212352.8640-1-w@1wt.eu> <20200229141354.GA23095@1wt.eu> <CAHk-=whFAAV_TOLFNnj=wu4mD2L9OvgB6n2sKDdmd8buMKFv8A@mail.gmail.com>
In-Reply-To: <CAHk-=whFAAV_TOLFNnj=wu4mD2L9OvgB6n2sKDdmd8buMKFv8A@mail.gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202003010019.14391.linux@zary.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 February 2020 16:58:11 Linus Torvalds wrote:
> On Sat, Feb 29, 2020 at 8:14 AM Willy Tarreau <w@1wt.eu> wrote:
> >
> > So if you or Denis think there's some value in me continuing to explore
> > one of these areas, I can continue, otherwise I can simply resend the
> > last part of my series with the few missing Cc and be done with it.
> 
> It's fine - this driver isn't worth spending a ton of effort on.
> 
> The only users are virtualization, and even they are going away
> because floppies are so small, and other things have become more
> standard anyway (ie USB disk) or easier to emulate (NVMe or whatever).
> 
> So I suspect the only reason floppy is used even in that area is just
> legacy "we haven't bothered updating to anything better and we have
> old scripts and images that work".
> 
>               Linus
> 

There are real users with real floppy drives out there.

-- 
Ondrej Zary
