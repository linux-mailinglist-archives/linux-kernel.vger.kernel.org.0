Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35FCA104819
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 02:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfKUBdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 20:33:04 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46576 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUBdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:33:04 -0500
Received: by mail-oi1-f196.google.com with SMTP id n14so1652205oie.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 17:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UhJHMTqQnmWIqxesSBnGsexK8t9okcFaiyDuQ7k24M0=;
        b=mRU7xzfWzlNkEvtTdz3pIlH+3O6kb04aJMU+hvjzP8JcMRn4vyRFSLFXwzgHY3OwPo
         YLw/quYtOCfsb3ffw0TSidvzYUKS7StgFRMC7rK/wrmY0Jp2VO1d9G4Fh6aH5Wk/sMwf
         axawgGcwEb9XHDFgon8i0dMk7WwXZN/EmGViYDyw038bvxXGd0wopHAyJGNvQGRm6uoJ
         xNHfRnqucCgURoB644Bvf/HzmOu7Q695RN+gv8E+hCfjiI8vtLMzXFR0wvletlY3nYFV
         P6ApOXU2rqnLLArdql3PlrztKWvC33xnc6Na99GPDm8VMiD4USMaA7V1Yz7BG3ouyVMS
         O4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UhJHMTqQnmWIqxesSBnGsexK8t9okcFaiyDuQ7k24M0=;
        b=dSOU2eq5nEvo8EUSYJX1CVXVbCON5JBBOOScBVdVjdgP1KXHL3C4I5oA3TCn8Ce4UD
         znzx7uT0bF3Spv+35bJqSAE3UORfaloqrXX+YBB6ECOMYnWB7QCsl3qkCpEQdqeQjM07
         VzElzmRPoQWnodi5P4VUsLbJODfDyVurS/DkT37PPyoF59UO2PsviTptqb/WVuOay5uc
         loYfm4styMtbrky2PKHCO4QEtI+hlNV8Havo5GwuMWNwxD15mqQxM0g52el4XgcL+SDJ
         Oj1jIUB596oPaNt4Tr8neciGIlOzAHGDBBaAAkKkso83OjGuvxQH8xC1xIyBPAJcJ5y5
         cUcg==
X-Gm-Message-State: APjAAAWqAbVHG2tPzM93k0HPP9vHyBGEKEKjkhCqCrhfRaET+VGz6q5W
        8LwG7bWTh+SiXSHZQ4j3Ba8hsm546gqBMb5h3LTQ+w==
X-Google-Smtp-Source: APXvYqy5tmgwRxWX41AQ9XnZeha9eExdYJyr4K4VvcRX0lydlUbNkCzkY541hqgxQW34OHd2w4cwj1NeHarUVFvSaXQ=
X-Received: by 2002:aca:ead7:: with SMTP id i206mr5618684oih.0.1574299983189;
 Wed, 20 Nov 2019 17:33:03 -0800 (PST)
MIME-Version: 1.0
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <20191120215338.GN2634@zn.tnic> <20191120231923.GA32680@agluck-desk2.amr.corp.intel.com>
 <20191120232645.GO2634@zn.tnic> <CAPcyv4gngO04iWuKu2_DV4_AXw5yssd6njTNKF=eKk+YJw3AfQ@mail.gmail.com>
 <alpine.DEB.2.21.1911210151590.29534@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911210151590.29534@nanos.tec.linutronix.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Nov 2019 17:32:51 -0800
Message-ID: <CAPcyv4iSv893n_gri+SC42Wcsr8EOGJfuWYUzi3v-fDnGBSriA@mail.gmail.com>
Subject: Re: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Jing Lin <jing.lin@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 4:53 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 20 Nov 2019, Dan Williams wrote:
> > On Wed, Nov 20, 2019 at 3:27 PM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Wed, Nov 20, 2019 at 03:19:23PM -0800, Luck, Tony wrote:
> > > > That's the underlying functionality of the MOVDIR64B instruction. A
> > > > posted write so no way to know if it succeeded.
> > >
> > > So how do you know whether any of the writes went through?
> >
> > It's identical to the writel() mmio-write to start a SATA command
> > transfer. The higher level device driver protocol validates that the
> > command went through, ultimately with a timeout. There's no return
> > value for iosubmit_cmds512() for the same reason there's no return
> > value for the other iowrite primitives.
>
> With the difference that other iowrite primitive have no dependencies on
> cpu feature bits and cannot fail on the software level.

True, but that would be a driver coding mistake flagged by the
WARN_ON_ONCE, and the failure is static. The driver must check for
static_cpu_has(X86_FEATURE_MOVDIR64B) once at init, but it need not
check again on every command submission.
