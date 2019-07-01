Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE304608A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 16:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfFNOVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 10:21:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46268 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbfFNOVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:21:49 -0400
Received: from zn.tnic (p200300EC2F097F0010F3CEDA9C41B474.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:7f00:10f3:ceda:9c41:b474])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 496A71EC0911;
        Fri, 14 Jun 2019 16:21:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560522107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Kd2BmJ/VXblZTT3gLSLXJLYjaN5iAPtQd3WhH81IpNQ=;
        b=j+hEwIBvwfZ4djUkW4ZqQmh+IwRxMijTvkTpmILg7VM0tA9fOP1FGYv4iyTSomge7xNqXR
        kckp2rCvweIbLiOmAA5/GItGHhF8sYkTnN0xOa4zg3AOEkszNJdD1T3IRUGsPRejFr37TA
        XT5j79Vy6cFtC82tPBNpn0eZ7YyvUbk=
Date:   Fri, 14 Jun 2019 16:21:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 2/3] x86/cpufeatures: Combine word 11 and 12 into new
 scattered features word 11
Message-ID: <20190614142139.GH2586@zn.tnic>
References: <1560459064-195037-1-git-send-email-fenghua.yu@intel.com>
 <1560459064-195037-3-git-send-email-fenghua.yu@intel.com>
 <20190614114410.GD2586@zn.tnic>
 <20190614122749.GE2586@zn.tnic>
 <20190614131701.GA198207@romley-ivt3.sc.intel.com>
 <20190614134123.GF2586@zn.tnic>
 <20190614141424.GA12191@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614141424.GA12191@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 07:14:24AM -0700, Sean Christopherson wrote:
> This is wrong.  KVM isn't complaining about shuffling the order of feature
> words, it's complaining that code is trying to do a reverse CPUID lookup
> to a feature that isn't in the reverse_cpuid table.   Filtering out
> checks dynamically is just hiding bugs.

No no, reverse_cpuid is hardcoding our feature leafs. This is wrong as
we want to be able to change those. And reverse_cpuid[] should be able
to handle that.

KVM is complaining because he removed one leaf. He adds it later in
patch 3 as a Linux-defined leaf.

All that doesn't matter for KVM - if KVM wants to do reverse lookup,
then it should handle Linux-defined leafs just fine.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
