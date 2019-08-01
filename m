Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 338A77D8F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 12:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfHAKDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 06:03:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47690 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfHAKDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:03:43 -0400
Received: from nazgul.tnic (x2f7f685.dyn.telefonica.de [2.247.246.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6027A1EC0586;
        Thu,  1 Aug 2019 12:03:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1564653822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KenONt+LZuRArBYuertEu7WnAg7BfqumlnaXUqEWSzQ=;
        b=VIduQ7/KJfQqW/zKCqE/MyPAepf+cu1BCvQDM0NbMezVQMCF8vdHe7sKbW/VYiuumLjolH
        fh+1r0KTAL8g2dl+IRBemgjTJZKwJpZyzVTl644qQ87gd6Rczd6i2tR+hPuJ1+cBd7ccEV
        uotdt9evBKqpKvhwBppymCPAUCV933Y=
Date:   Thu, 1 Aug 2019 12:03:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Luck, Tony" <tony.luck@intel.com>,
        "Lin, Jing" <jing.lin@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86/asm: Add support for MOVDIR64B instruction
Message-ID: <20190801095928.GA32138@nazgul.tnic>
References: <20190730230554.8291-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190730230554.8291-1-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 02:05:54AM +0300, Kirill A. Shutemov wrote:
> Add support for a new instruction MOVDIR64B. The instruction moves
> 64-bytes as direct-store with 64-byte write atomicity from source memory
> address to destination memory address.
> 
> MOVDIR64B requires the destination address to be 64-byte aligned. No
> alignment restriction is enforced for source operand.
> 
> See Intel Software Developer’s Manual for more information on the
> instruction.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
> 
> Several upcoming patchsets will make use of the helper.

... so why aren't you sending it together with its first user?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
