Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA0ED4DE2A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 02:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfFUArs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 20:47:48 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:39260 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfFUArr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 20:47:47 -0400
Received: by mail-lf1-f53.google.com with SMTP id p24so3727615lfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 17:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YlzusH+D6N8YHoX3PYLBUDWKLaxzoz4gcWq9gAaKXVo=;
        b=AWUaT7lCpTIWK+6Kqbv+5luD3tg5ZWaIJkH24j7mgKQv5rz2+SPyMuUzS0tHIvSw3w
         XONeOllWVItjefdGQIJh2dtQnZZZPy26IYT6QyQ6BcsWMAIpXKAP0puHgMrY2lCHABZk
         Y9/N36d3vSzUjjSpe7mCxCKsc9PKcnvHM1iwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YlzusH+D6N8YHoX3PYLBUDWKLaxzoz4gcWq9gAaKXVo=;
        b=Qhppo4zoxrylkk85RITIxFSf6duSmDYYtQVgaKk5npR5XbVSa6LrnRt8zkghAacQuI
         zUYDEF/JxtMbbgXHHBZWXxNubu7Ur7v/Yy1rHlGRxWBOSOw3sAd7KCgUPcxAvzkwFwAb
         QzI61ipIoLPZVr5TlQIbbJLx7OfC8sebWkF7L2dGpKvUUCuDtDk0OE/CHjcGVWlh1lCb
         gvrC21JWFAXEJQgtO1ZtybG++o5twgIO9T0Rz0HOkOBk4HMWp/CrZsiULagl7Aucu71c
         5GXkBOZGeTP08ShSdIL48q5ZtQYiO2gGrj9Jgq7Mp24KdPqkZacnWlGcsp+LBpiAe1pB
         +MTg==
X-Gm-Message-State: APjAAAUDC7Hk3PFOm8LIxND32U9bESI8qBybAYi6kcNVz5x2cRRX+QQW
        nLzup259dGvFGvKOKGL24nTf7br4piw=
X-Google-Smtp-Source: APXvYqxDCduRs355A4Q20FkJ3d4v4BKETz99fs1TcLFpD6uaoYyA99fCBZNxtqAmWGRaFGNil3RWuQ==
X-Received: by 2002:ac2:51ab:: with SMTP id f11mr22594773lfk.55.1561078065279;
        Thu, 20 Jun 2019 17:47:45 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id p27sm166914lfh.8.2019.06.20.17.47.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 17:47:44 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id d11so3733025lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 17:47:44 -0700 (PDT)
X-Received: by 2002:a19:f808:: with SMTP id a8mr2996820lff.29.1561078063824;
 Thu, 20 Jun 2019 17:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190522100808.66994f6b@canb.auug.org.au> <20190528114320.30637398@canb.auug.org.au>
 <20190621095907.4a6a50fa@canb.auug.org.au> <CAHk-=whVBjssws88tSeoVLG5o5ZWXQu=S7rv-0Hd3qt9=VYsTQ@mail.gmail.com>
 <1561077341.7970.47.camel@HansenPartnership.com>
In-Reply-To: <1561077341.7970.47.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Jun 2019 17:47:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiprB8PKsFa+VxfSHheGUpWZaAjnqq3KD_M_CMHa4qkMQ@mail.gmail.com>
Message-ID: <CAHk-=wiprB8PKsFa+VxfSHheGUpWZaAjnqq3KD_M_CMHa4qkMQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the scsi tree with Linus' tree
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 5:35 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> * This file is licensed under GPLv2.
>
> In all the libsas files, but then muddied the water by quoting GPLv2
> verbatim (which includes the or later than language).

Ok, thanks for the explanation. And yes, that would have likely
confused people who just looked at the license text.

            Linus
