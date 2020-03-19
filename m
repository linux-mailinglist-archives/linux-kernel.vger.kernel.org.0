Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4BA18BDC5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 18:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgCSRPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 13:15:21 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40199 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgCSRPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:15:20 -0400
Received: by mail-yb1-f196.google.com with SMTP id o1so695896ybp.7;
        Thu, 19 Mar 2020 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hzpubp9i8SsqTlwC3LCJ95ttPAhD1RlFUzct1mHWetQ=;
        b=q2u8UMKNXbHC8/9zuqzuEVdPhjNC09kZnVdZmOBTwhhd2YxKRECX07icWI1i55epGt
         VMn+plnypKJh49e6p7ymM8+4/CdimigPDSHUe5dsA/EgwovyE4YArBBO/NcSVpmSPiZx
         U96jjfEkonHFDlxCe7Y2Q3+Ch3psKdmrjytZ7yDhdBAz11EWUOG6mGkT0qcELFAlLtxl
         vXj79cB790yAZ+gzeHQUAfrgL4Ohm5d4b/IzFS9EvyXq1XOIhsY/qIe4h8Akm5NHt67g
         Ilyt4ZDd7KTBnfjPqtaf0aHhGznmFnrfm1EhO778ctN8Tbel0zkKanXs7xr74IYvaulC
         tD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hzpubp9i8SsqTlwC3LCJ95ttPAhD1RlFUzct1mHWetQ=;
        b=aHjbkFBpeXqiWUREdM7H5cxKNZzbzsZwjHZzDpcGn4rJRbfrDwiJwEqtrU+wdCDDVS
         G9S3b3t23b3FkqHI8v/nszc2g700fCqf9NAPNuBaKN7Qk/BbbA5Fra25317Zc3n0Cnqc
         V8R6T6FPXHzHAXsoArJx6Dk4jrDpmXLrPVJSRLn1/b+bbK3H1jlJ3IlkkUEsPIRJfqGU
         gz6u6tHHgt2C9dIJwXlBeN52Bh0XUWeycdcN/icATu03jMXhbbyzBTNsZ76qJhdweAz4
         702NQfPspBK03b8yu25MfqKXE0+c9hsv7sbxZ+0L4B0ijPXHNUzK48f3pL8Z0ajKvP6t
         hfzA==
X-Gm-Message-State: ANhLgQ2+4ZhiIk10UYATcpPqVkOEpy4kQT8VjHw/Bfscp6KjJedIM8oB
        DaClaNeyI7Zk46QXmzLrYu29CKNpM2R1So2xaMEA/5dZ
X-Google-Smtp-Source: ADFU+vt70xGjWkFksBjc7eCJA86pHD5jfMC8o9dGDS0TUrTpekiq7yiCh1fSRHQmUTj6nI+D9E/4ZEIjfU7c7F9GCI8=
X-Received: by 2002:a25:e805:: with SMTP id k5mr6504675ybd.14.1584638119480;
 Thu, 19 Mar 2020 10:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msOYEYH_YrSwGn6KYW83U0kyNS9U04xLgVFMx4xr32J1Q@mail.gmail.com>
 <CAHk-=whGupJv0ge7epQViXayTmD=SCkqsONsnRNZmEOZ9_3eqg@mail.gmail.com>
In-Reply-To: <CAHk-=whGupJv0ge7epQViXayTmD=SCkqsONsnRNZmEOZ9_3eqg@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 19 Mar 2020 12:15:08 -0500
Message-ID: <CAH2r5msfM0_7meWxPMMiK1BP-9Su_OF-SeCLUn6HNQpi=8N0yg@mail.gmail.com>
Subject: Re: [GIT PULL] CIFS/SMB3 fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to push the tag.   Now tag is pushed.  Sorry about that

On Thu, Mar 19, 2020 at 12:03 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Mar 18, 2020 at 9:51 PM Steve French <smfrench@gmail.com> wrote:
> >
> >   git://git.samba.org/sfrench/cifs-2.6.git 5.6-rc6-smb3-fixes
>
> Forgot to push?
>
>    fatal: couldn't find remote ref 5.6-rc6-smb3-fixes
>
> I do see the commit you reference in the "for-linus" branch, but then
> I wouldn't get the tag with signature.
>
> Please push it out,
>
>               Linus



-- 
Thanks,

Steve
