Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A507E9FD66
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 10:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfH1IqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 04:46:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38182 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfH1IqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:46:01 -0400
Received: from zn.tnic (p200300EC2F0A5300709FCF54A47702A2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5300:709f:cf54:a477:2a2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 612F31EC058B;
        Wed, 28 Aug 2019 10:46:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566981960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rVRBMbPy163RbzHyWyI7SHMNRU6wR9fy8f+dHHgyUC4=;
        b=ZmHtKHNf44kbevGS5LTb2i1WfnrxRVYgRUREhVv+ygaQLJKjND4XQZpJaRO6uETglpIKCO
        wLzHnJxM5IN8ZRe0XM8l2duVWwF9x+LrYvcawPfS/oyC/exFUy9Q+dhHcWAeHyH1OFdFZz
        hFMVBvuMwertY4IynQ2NJlBjOTiG4P8=
Date:   Wed, 28 Aug 2019 10:45:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        dri-devel@lists.freedekstop.org, Doug Covelli <dcovelli@vmware.com>
Subject: Re: [PATCH v2 1/4] x86/vmware: Update platform detection code for
 VMCALL/VMMCALL hypercalls
Message-ID: <20190828084555.GD4920@zn.tnic>
References: <20190823081316.28478-1-thomas_os@shipmail.org>
 <20190823081316.28478-2-thomas_os@shipmail.org>
 <20190827125636.GE29752@zn.tnic>
 <471e1f6b-56eb-281e-155d-3149f6915f81@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <471e1f6b-56eb-281e-155d-3149f6915f81@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 09:45:19AM +0200, Thomas Hellström (VMware) wrote:
> Hmm, we're missing a return 0; here. The number of return points and the
> moved up variable declarations worries me a little. I'll see if I can clean
> this up a bit, but would prefer to make a follow-up patch in that case.

By all means.

It was just a suggestion anyway - see if you prefer this better or would
like to keep the old style.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
