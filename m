Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB2213BEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 12:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbgAOLjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 06:39:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38262 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbgAOLjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 06:39:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id w1so18193233ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 03:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b99yf3V8kQex5BIi+mQnGvlxUrIVGOkE8WgpWWd/Eaw=;
        b=l3Z1hxfSM4kFVEY/xccCbXDwFfEPIvnoP0Bt4x6TKvKi6IgISWEGzhpkNbcHMjUEQD
         jkMFMnmgkw7rbjyJ0gIu/o6GGMf7CrTmRjzmfbRENzur3PNwpcfwczRbOM0KRSMF72oo
         bLRzy4Lf6MzxTxyoF9OreoWUrEq91+YBOZcWi4MsLa1OQSNsE12zL7AuF3xlHd0U7KHN
         Hhpy3t8mkIwxdlckceyqTnnMbl8aEYvV9xDgs5F+86driBR6NAUClIwuz9IwrWVkzxfU
         d5FHURsVN2A+3NqueyYGV6vLdO4FAQ3HfvVFJchXZxNUqfcRlpRCSsa32rGTErhy+4yT
         ASdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b99yf3V8kQex5BIi+mQnGvlxUrIVGOkE8WgpWWd/Eaw=;
        b=jvxVJW5rNNpEgi0kIonEJ3BM6c6Y9EMaqdfK4xCYQgN8dVrPoP0QRMsywx900ojQBY
         OisHl8gnPxQnfJoLOt5YGSKAobdoxJGNWn+JyuTpVcMMm9X/dGLnvz6lNVfv3wtOCEEA
         FVVxkPtk96G30dSUsBGcohqi9c8lo5RcgumMI9FgeIXJvZG8S4EZFZXDNErSeAykHKHO
         cQX9Anm+yZoExAz3+LtiMaVufqvkpkGhbcQVknYn4Obptr5n38X1vpnlamsHumFrKJFT
         2x8lYxKTVr639QuermbLOkCN6nx/iQjuEwuabHQsFKHWqpQZYpzC7v4cHzEfVT7JAHYy
         WKpg==
X-Gm-Message-State: APjAAAWfI8VlF7gNdXJUA83AHlJ9K8Jlqy/stLIcfnBQcNEh6aP/KiZd
        Jg7dIGe3N/Ib0f1aXvGsXwKq5bOZftjHdMhVdsdpaA==
X-Google-Smtp-Source: APXvYqwcughhs+hOBNiI2TbPRoBllhNNSKV6YODyUVFyGosqV6bXeFg7JRQfp3sxhL4JjfqQqnHjax82WYiwSM7UQGE=
X-Received: by 2002:a05:651c:1068:: with SMTP id y8mr1542693ljm.71.1579088350174;
 Wed, 15 Jan 2020 03:39:10 -0800 (PST)
MIME-Version: 1.0
References: <20200115132325.3ac3ca0f@canb.auug.org.au> <CAORVsuWs=0su+y2iLfL7zUygW8UgT8WzTXoCJiyBGFp_UG8yFA@mail.gmail.com>
 <20200115212739.474e8272@canb.auug.org.au>
In-Reply-To: <20200115212739.474e8272@canb.auug.org.au>
From:   Jean Pihet <jean.pihet@newoldbits.com>
Date:   Wed, 15 Jan 2020 12:38:59 +0100
Message-ID: <CAORVsuWoLimOmuV59vF_pbRN8msZyjMnVNfAuhuYACXpy_Ffew@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the spi tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

On Wed, Jan 15, 2020 at 11:28 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Jean,
>
> On Wed, 15 Jan 2020 10:10:09 +0100 Jean Pihet <jean.pihet@newoldbits.com> wrote:
> >
> > I did not have this warning, it may be a combination of compiler
> > version and build flags. Do you need a fixup patch for it?
>
> That is up to Mark, really.  Unfortunately, Linus will probably get
> this warning during the merge window which he will complain about.

Ok I just sent a fixup patch to Mark (on spi ML). Could it still reach 5.6?

>
> It is really weird, as there are three other references to rx_wlen
> immediately before the one complained about ... so maybe this is a bug
> in the compiler I am using (gcc 9.2.1 from Debian, cross compiler
> ppc64le hosted).
Yes indeed it is weird. Only some compiler versions are throwing the warning.

Thanks,
Jean

>
> --
> Cheers,
> Stephen Rothwell
