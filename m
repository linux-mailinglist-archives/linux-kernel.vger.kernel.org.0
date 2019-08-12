Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E82F8A038
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 15:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfHLN4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 09:56:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41672 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfHLN4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:56:17 -0400
Received: from zn.tnic (p200300EC2F0627009817776DE5A4173C.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:2700:9817:776d:e5a4:173c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 867A61EC0716;
        Mon, 12 Aug 2019 15:56:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565618176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sOTJPwoCws/W5B4gjQ5XrTQUGLpEMhk29kPSAYtagHs=;
        b=pYCNqKVDhyKc71xmMVdmJNJ0ZlCt2f7s+xxBa4SW2H6x/Zp/9VOq9niuE+n6B1/pGs0Y1a
        r0+PBSURnEi2J+zAcesR2CXAhK9mfXT8fZhzGZik0v5dLutGf3RDCBbFJW0Y9rjUqLHB9m
        jkk5BvQXM3nNjq7mashohehhgqmXgb0=
Date:   Mon, 12 Aug 2019 15:57:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        keescook@chromium.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 11/11] x86/alternatives: Adapt assembly for PIE support
Message-ID: <20190812135701.GH23772@zn.tnic>
References: <20190730191303.206365-1-thgarnie@chromium.org>
 <20190730191303.206365-12-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190730191303.206365-12-thgarnie@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 12:12:55PM -0700, Thomas Garnier wrote:
> Change the assembly options to work with pointers instead of integers.

This commit message is too vague. A before/after example would make it a
lot more clear why the change is needed.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
