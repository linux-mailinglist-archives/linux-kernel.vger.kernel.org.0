Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E50AB9909
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 23:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfITV1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 17:27:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbfITV1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 17:27:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3039D18CB8EF;
        Fri, 20 Sep 2019 21:27:51 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4756E5DA8D;
        Fri, 20 Sep 2019 21:27:47 +0000 (UTC)
Date:   Fri, 20 Sep 2019 17:27:46 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: dm-crypt error when CONFIG_CRYPTO_AUTHENC is disabled
Message-ID: <20190920212746.GA22061@redhat.com>
References: <20190920154434.GA923@gandi.net>
 <20190920173707.GA21143@redhat.com>
 <13e25b01-f344-ea1d-8f6c-9d0a60eb1e0f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13e25b01-f344-ea1d-8f6c-9d0a60eb1e0f@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Fri, 20 Sep 2019 21:27:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20 2019 at  3:21pm -0400,
Milan Broz <gmazyland@gmail.com> wrote:

> On 20/09/2019 19:37, Mike Snitzer wrote:
> > On Fri, Sep 20 2019 at 11:44am -0400,
> > Thibaut Sautereau <thibaut.sautereau@clip-os.org> wrote:
> > 
> >> Hi,
> >>
> >> I just got a dm-crypt "crypt: Error allocating crypto tfm" error when
> >> trying to "cryptsetup open" a volume. I found out that it was only
> >> happening when I disabled CONFIG_CRYPTO_AUTHENC.
> >>
> >> drivers/md/dm-crypt.c includes the crypto/authenc.h header and seems to
> >> use some CRYPTO_AUTHENC-related stuff. Therefore, shouldn't
> >> CONFIG_DM_CRYPT select CONFIG_CRYPTO_AUTHENC?
> > 
> > Yes, it looks like commit ef43aa38063a6 ("dm crypt: add cryptographic
> > data integrity protection (authenticated encryption)") should've added
> > 'select CRYPTO_AUTHENC' to dm-crypt's Kconfig.  I'll let Milan weigh-in
> > but that seems like the right way forward.
> 
> No, I don't this so. It is like you use some algorithm that is just not compiled-in,
> or it is disabled in the current state (because of FIPS mode od so) - it fails
> to initialize it.
> 
> I think we should not force dm-crypt to depend on AEAD - most users
> do not use authenticated encryption, it is perfectly ok to keep this compiled out.
> 
> I do not see any principal difference from disabling any other crypto
> (if you disable XTS mode, it fails to open device that uses it).
> 
> IMO the current config dependence is ok.

That is a good point.  I hadn't considered the kernel compiles just fine
without CRYPTO_AUTHENC.. which it clearly does.

SO I retract the question/thought of updating the Kconfig for dm-crypt
in my previous mail.

Though in hindsight: wonder whether the dm-integrity based dm-crypt
authenticated encryption support should have been exposed as a proper
CONFIG option within the DM_CRYPT section?  Rather than lean on the
crypto subsystem to happily stub out the dm-crypt AEAD and AUTHENC
related code dm-crypt could've established #ifdef boundaries for that
code.

I'm open to suggestions and/or confirmation that the way things are now
is perfectly fine.  But I do see this report as something that should
drive some improvement.

Mike
