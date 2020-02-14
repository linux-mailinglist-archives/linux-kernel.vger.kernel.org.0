Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C38CF15D43B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 09:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgBNI7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 03:59:42 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34968 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728332AbgBNI7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:59:41 -0500
Received: from zn.tnic (p200300EC2F0D5A00F0C2F03C7F1C4548.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5a00:f0c2:f03c:7f1c:4548])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B376D1EC0570;
        Fri, 14 Feb 2020 09:59:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581670780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tHpuhpThWYiJc5ShfynF3YmUpHN1USUoVA55JgrpWxE=;
        b=dkwgy0cDQGprM780gxQFgzAY+dJl+6ftwMuJDdjGCLxPKRo8iTt4GZL27/EvbaS7Hkbsy4
        d/skJZi/8svliM5+mrGSYcfoGK8TQ94GYDZs0+mGjE8rqycdd35ZiRoGmnpLgFFM5ZtQEC
        7xGe3rT1cXsEnrw42MnIb+FeevSKy1A=
Date:   Fri, 14 Feb 2020 09:59:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] x86/mce: Fix all mce notifiers to update the
 mce->handled bitmask
Message-ID: <20200214085936.GD13395@zn.tnic>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200212204652.1489-5-tony.luck@intel.com>
 <20200213170308.GM31799@zn.tnic>
 <20200213221913.GB21107@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213221913.GB21107@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:19:13PM -0800, Luck, Tony wrote:
> > Because this one bit would basically determine whether the error gets
> > printed or not. Which would mean that all EDAC drivers should print
> > it...
> 
> Alternative wording "An EDAC driver should only set the bit if it printed
> something useful about the error."

ACK.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
