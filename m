Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB09142F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 17:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgATQEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 11:04:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36967 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729016AbgATQEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579536251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p4ejQ2/oe91bnyA0QOnuHtrCvG5ijZh9PVgfR3T6gU8=;
        b=EgKfywjuXiYjewNhok12RHl3ly1/ZIUcCFGNl4K1J5z02gvIsPMFEmEf8pTVU2TP8SqcLT
        O+hIsB6Fn7uUqJggxP0gAneyCjxLrrIoKlDxISpQlJWtUswqeHkzzJ5Vm4as/v6wVwIHbj
        j0Y+CXa6pQtgNXDFQS95Fz5xCMFb4fw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-Hk5GbMLvONaFujzTtsGtJA-1; Mon, 20 Jan 2020 11:04:08 -0500
X-MC-Unique: Hk5GbMLvONaFujzTtsGtJA-1
Received: by mail-qk1-f198.google.com with SMTP id u10so25329qkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p4ejQ2/oe91bnyA0QOnuHtrCvG5ijZh9PVgfR3T6gU8=;
        b=qTcfU6VJt/0qgTxowH3ZG80hhUalvc9HnaBtC2MmZbEJ1uLHlr+q5Pcsk00K8oJCVf
         uoyhHT4NENBt6FAx1rHVfCJeZSiwg/onwi44OFkhi7sBoHid9KcUTWn55ochLs6hfnrA
         jB1p/6wqxD1ANG9KbDwpFIh5OEnlPE/PGr4B4MON4oEwLTBevrVOmFiCCdbcP0t+q3WG
         vey1gk8TP1hvenEpRWTyv2bTyPbSgdV0dAeAjxUoc/agplSeZmaWR2bHfHPt01aR2DwZ
         cV3iDy/6eurLszj98lH2gL4t1fMbXV7Uk8ntxwLwlsnjnQHajRaxtaKMPTJC5i/GK4iC
         TpTA==
X-Gm-Message-State: APjAAAUSPaScWcd2hFdYYqUlr6T/ba5kiSNTIk+o6B+Fu1NeJY8JKYab
        mruUG+akCTaiT0gpXMRXOoMFO+bkGqX2CiDJfsWM0xnHkPutPQUIJXj84QARsDmK0UUq+1xZvw8
        yhD8TxZn7am9zpxdO0k4WSNHq
X-Received: by 2002:aed:2d67:: with SMTP id h94mr14152qtd.74.1579536247742;
        Mon, 20 Jan 2020 08:04:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyHYHZZeb/F+oSnPwvaj7ijjCP3wY5WXEKtUs5DPKrE69F2FmzJea/xoQ0/lmBxFbbg2H6+0w==
X-Received: by 2002:aed:2d67:: with SMTP id h94mr14119qtd.74.1579536247441;
        Mon, 20 Jan 2020 08:04:07 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
        by smtp.gmail.com with ESMTPSA id 68sm16186184qkj.102.2020.01.20.08.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:04:06 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:04:00 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
        Jason Wang <jasowang@redhat.com>, kvm <kvm@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <20200120110319-mutt-send-email-mst@kernel.org>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
 <20200120.100610.546818167633238909.davem@davemloft.net>
 <20200120101735.uyh4o64gb4njakw5@steredhat>
 <20200120060601-mutt-send-email-mst@kernel.org>
 <CAGxU2F6VH8Eb5UH_9KjN6MONbZEo1D7EHAiocVVus6jW55BJDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F6VH8Eb5UH_9KjN6MONbZEo1D7EHAiocVVus6jW55BJDg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 02:58:01PM +0100, Stefano Garzarella wrote:
> On Mon, Jan 20, 2020 at 1:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Mon, Jan 20, 2020 at 11:17:35AM +0100, Stefano Garzarella wrote:
> > > On Mon, Jan 20, 2020 at 10:06:10AM +0100, David Miller wrote:
> > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > > Date: Thu, 16 Jan 2020 18:24:26 +0100
> > > >
> > > > > This patch adds 'netns' module param to enable this new feature
> > > > > (disabled by default), because it changes vsock's behavior with
> > > > > network namespaces and could break existing applications.
> > > >
> > > > Sorry, no.
> > > >
> > > > I wonder if you can even design a legitimate, reasonable, use case
> > > > where these netns changes could break things.
> > >
> > > I forgot to mention the use case.
> > > I tried the RFC with Kata containers and we found that Kata shim-v1
> > > doesn't work (Kata shim-v2 works as is) because there are the following
> > > processes involved:
> > > - kata-runtime (runs in the init_netns) opens /dev/vhost-vsock and
> > >   passes it to qemu
> > > - kata-shim (runs in a container) wants to talk with the guest but the
> > >   vsock device is assigned to the init_netns and kata-shim runs in a
> > >   different netns, so the communication is not allowed
> > > But, as you said, this could be a wrong design, indeed they already
> > > found a fix, but I was not sure if others could have the same issue.
> > >
> > > In this case, do you think it is acceptable to make this change in
> > > the vsock's behavior with netns and ask the user to change the design?
> >
> > David's question is what would be a usecase that's broken
> > (as opposed to fixed) by enabling this by default.
> 
> Yes, I got that. Thanks for clarifying.
> I just reported a broken example that can be fixed with a different
> design (due to the fact that before this series, vsock devices were
> accessible to all netns).
> 
> >
> > If it does exist, you need a way for userspace to opt-in,
> > module parameter isn't that.
> 
> Okay, but I honestly can't find a case that can't be solved.
> So I don't know whether to add an option (ioctl, sysfs ?) or wait for
> a real case to come up.
> 
> I'll try to see better if there's any particular case where we need
> to disable netns in vsock.
> 
> Thanks,
> Stefano

Me neither. so what did you have in mind when you wrote:
"could break existing applications"?

