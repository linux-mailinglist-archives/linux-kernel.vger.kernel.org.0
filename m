Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE026FAFEF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 12:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfKMLoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 06:44:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57812 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbfKMLoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:44:21 -0500
Received: from zn.tnic (p200300EC2F0FA700DC7A154839E5798B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:a700:dc7a:1548:39e5:798b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3C54D1EC0CD1;
        Wed, 13 Nov 2019 12:44:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573645459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dYoX4UXsTe7ufyqNTeBdZN0Ea5/ndlS2p6eaJOVNeZo=;
        b=TTWtoxFzL3HfkTAx8vj7ucRx3nexwwiyGGsNyTEGyS55nZQHRsgJz2QXFP+FXBtwr53ATg
        iyqoOF6vYtAlvF/SSXP2g7YxnQshNSY3Y08mDZXFTVWKHWEf2FuX6fiemoE/gbF9zwuQSs
        sg/F30H5krcjwf6aAUsGZNsS7BANNHk=
Date:   Wed, 13 Nov 2019 12:44:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Xiaochen Shen <xiaochen.shen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, pei.p.jia@intel.com
Subject: Re: [PATCH] x86/resctrl: Fix potential lockdep warning
Message-ID: <20191113114334.GA1647@zn.tnic>
References: <1573079796-11713-1-git-send-email-xiaochen.shen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1573079796-11713-1-git-send-email-xiaochen.shen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 06:36:36AM +0800, Xiaochen Shen wrote:
> rdtgroup_cpus_write() and mkdir_rdt_prepare() call
> rdtgroup_kn_lock_live() -> kernfs_to_rdtgroup() to get 'rdtgrp', and
> then call rdt_last_cmd_xxx() functions which will check if

Write those names like this:

rdt_last_cmd_{clear,puts,...} but not with an "xxx" which confuses
people unfamiliar with the code.

> rdtgroup_mutex is held/requires its caller to hold rdtgroup_mutex.
> But if 'rdtgrp' returned from kernfs_to_rdtgroup() is NULL,
> rdtgroup_mutex is not held and calling rdt_last_cmd_xxx() will result
> in a lockdep warning.

That's more of a self-incurred lockdep warning. You can't be calling
lockdep_assert_held() after a function which doesn't always grab the
mutex. Looks like the design needs changing here...

> Remove rdt_last_cmd_xxx() in these two paths. Just returning error
> should be sufficient to report to the user that the entry doesn't exist
> any more.

... or that.

In any case, you should consider fixing such patterns in the code as it
looks sub-optimal from where I'm standing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
