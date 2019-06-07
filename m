Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBD4639676
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 22:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbfFGUJ1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Jun 2019 16:09:27 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:46050 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbfFGUJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 16:09:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 12E096074CC1;
        Fri,  7 Jun 2019 22:09:25 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kNthjU-GYg1E; Fri,  7 Jun 2019 22:09:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B8741608310F;
        Fri,  7 Jun 2019 22:09:24 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qx-a-PPfJeha; Fri,  7 Jun 2019 22:09:24 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8D0BC608F45A;
        Fri,  7 Jun 2019 22:09:24 +0200 (CEST)
Date:   Fri, 7 Jun 2019 22:09:24 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michele Dionisio <michele.dionisio@gmail.com>
Message-ID: <1644731533.84685.1559938164477.JavaMail.zimbra@nod.at>
In-Reply-To: <CAO1O6sdU=kAYS2sTKwiagxrbg+fMer9nvbwA9C4LoFMgH7e1dQ@mail.gmail.com>
References: <20190515210202.21169-1-richard@nod.at> <CAO1O6sdU=kAYS2sTKwiagxrbg+fMer9nvbwA9C4LoFMgH7e1dQ@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Add support for zstd compression.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.8_GA_3025 (ZimbraWebClient - FF60 (Linux)/8.8.8_GA_1703)
Thread-Topic: ubifs: Add support for zstd compression.
Thread-Index: rnvHZUv9ubNCdBXV/imbNn3Xo5b/uw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emil,

----- Ursprüngliche Mail -----
> In fs/ubifs/sb.c we have
> 
> static int get_default_compressor(struct ubifs_info *c)
> {
>    if (ubifs_compr_present(c, UBIFS_COMPR_LZO))
>        return UBIFS_COMPR_LZO;
> 
>    if (ubifs_compr_present(c, UBIFS_COMPR_ZLIB))
>        return UBIFS_COMPR_ZLIB;
> 
>    return UBIFS_COMPR_NONE;
> }
> 
> Maybe add an entry for zstd here as well?

Where would you add it? If we add it after UBIFS_COMPR_ZLIB,
it will effectively never get selected, unless someone builds a kernel
without lzo and zlib but zstd.
If we add it before UBIFS_COMPR_ZLIB, it will be used always and users
end up with unreadable files if they reboot to an older kernel.
Please note that we didn't raise the UBIFS format version for zstd.

So I'm not sure what is the best choice for the default filesystem.

Thanks,
//richard
