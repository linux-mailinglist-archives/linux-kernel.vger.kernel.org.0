Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B112E7E35E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 21:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388699AbfHATg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 15:36:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43994 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388668AbfHATg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:36:28 -0400
Received: from zn.tnic (p200300EC2F159F00604C6CF9032D9ED3.dip0.t-ipconnect.de [IPv6:2003:ec:2f15:9f00:604c:6cf9:32d:9ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 474D11EC074B;
        Thu,  1 Aug 2019 21:36:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1564688186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Wj8mRbobMSud+T3lGNLliqvBRTHfWGxvPzm0IzQzcmQ=;
        b=PGunn+YjazMw/w+6oOlCIvfur7M+8Fhx4XWWeFQcrypfUdB5QIafb+T11S5lgzgMK/odR7
        Yht5LDKnOWde3+lCrNutvl92KZ8ltY2l73xcpkT+RJO4+0HHaSC8cjPjLEIb6WJV4BvXSU
        3buqKwW9vMMnEFhfICNDJmk74APHVZE=
Date:   Thu, 1 Aug 2019 21:36:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Lin, Jing" <jing.lin@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86/asm: Add support for MOVDIR64B instruction
Message-ID: <20190801193606.GA16031@zn.tnic>
References: <20190730230554.8291-1-kirill.shutemov@linux.intel.com>
 <20190801095928.GA32138@nazgul.tnic>
 <20190801192030.GA11781@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190801192030.GA11781@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:20:30PM -0700, Luck, Tony wrote:
> Just to get another of the non-controversial bits out of the
> way before the main course arrives.

Let's submit functions together with their respective users pls. Like we
always do.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
