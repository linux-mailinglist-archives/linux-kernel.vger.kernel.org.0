Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC51B2B1E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2019 13:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfINLjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Sep 2019 07:39:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39970 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729982AbfINLjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 07:39:45 -0400
Received: from zn.tnic (p200300EC2F1C9800880C871C53BB2BF4.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:9800:880c:871c:53bb:2bf4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F42111EC0C48;
        Sat, 14 Sep 2019 13:39:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568461184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2oTHepezaAE9EkOCAGadNA75IAqW7ewhq7ozsC6F6IQ=;
        b=Si8Rm01W/UL9YljCOhzm6sNmimt6ZrbE3E1AcXAH1sNDpFwD+HcPvYxC4bg24pVpUR+VqY
        3K+dpDVY3I8+hCTje81CUdujNP+98U31afHlRubGmlaaMUQtwET+L1r0m1lIx3M31JOMBx
        wRQKUi4ikLl+pEYQxQB249zsuKQQ7Jk=
Date:   Sat, 14 Sep 2019 13:39:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org,
        linux@rasmusvillemoes.dk, torvalds@linux-foundation.org
Subject: Re: [RFC] Improve memset
Message-ID: <20190914113941.GB28054@zn.tnic>
References: <20190914092915.GA17409@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190914092915.GA17409@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 12:29:15PM +0300, Alexey Dobriyan wrote:
> eh... I'd just drop it. These registers screw up everything.

The intent is to not touch memset_orig and let it die with its users. It
is irrelevant now anyway.

If it can be shown that the extended list of clobbered registers hurt
performance, then we can improve it for the sake of keeping register
pressure low.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
