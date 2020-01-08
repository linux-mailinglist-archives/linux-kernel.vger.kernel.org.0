Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47151133F4D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 11:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgAHKax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 05:30:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45080 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgAHKaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:30:52 -0500
Received: from zn.tnic (p200300EC2F0BD40034469522243F337C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:d400:3446:9522:243f:337c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 116DC1EC0CC9;
        Wed,  8 Jan 2020 11:30:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578479451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=taKxhErl92ubSBBYp1djuoXl7LfBrUvCb2etYgMFOcY=;
        b=ASf04qi56AORsfwfq9pUSRNWqPGxmJC/U2lnXR4PkfV6xEOeky+8De2dK/sCGfo10jiQMM
        QJG+i9+2yxeXsVWIVNSrZq926cUc5xTy3iS9b78LDvttshGzNZd2H4Og4shW+PiM53p/z6
        7CaWgeiRnmb5ntrNl8uIqLysnA1XCcE=
Date:   Wed, 8 Jan 2020 11:30:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpufeatures: Add support for fast short rep mov
Message-ID: <20200108103040.GB27363@zn.tnic>
References: <20191212225210.GA22094@zn.tnic>
 <20191216214254.26492-1-tony.luck@intel.com>
 <20200107184003.GK29542@zn.tnic>
 <20200107223606.GA32598@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200107223606.GA32598@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 02:36:06PM -0800, Luck, Tony wrote:
> Yes FSRM implies ERMS

Ok, I've added this comment ontop so that it is clear what's going on
there:

	/* FSRM implies ERMS => no length checks, do the copy directly */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
