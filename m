Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA9419A39B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 01:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbfHVXPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 19:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730309AbfHVXPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:15:50 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33BC02173E;
        Thu, 22 Aug 2019 23:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566515750;
        bh=9klvzmm4SgliLDekMfe676XkWiJvbDBtkds5Yp8l2Vo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yB7CLcwbcd2S7DLuLbFOINev+ZuM9oPyN5r4np0gHWJSrdb6ZgV/vnE6ktz+qsEPh
         dUoQeexKblay3bHXJ/TxrSpHboS45fjtuP7dhlAv59uTos6OAyUTFxsaFt+QZoCZ4O
         Z+lJsj8NKsKPv5drJ0YjHbBkmLAuU5mEm7FugVac=
Date:   Thu, 22 Aug 2019 16:15:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Helge Deller <deller@gmx.de>, Qian Cai <cai@lca.pw>,
        James.Bottomley@HansenPartnership.com,
        kirill.shutemov@linux.intel.com, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: fix compilation errrors
Message-Id: <20190822161549.7eb9893b0e6cfc4c8efdb924@linux-foundation.org>
In-Reply-To: <1f6be421-5304-3d2c-1e6e-d9f464bdff88@roeck-us.net>
References: <20190815205305.1382-1-cai@lca.pw>
        <20190815210208.GA9868@roeck-us.net>
        <0f27b102-471a-e472-3e69-d9883a36efeb@gmx.de>
        <1f6be421-5304-3d2c-1e6e-d9f464bdff88@roeck-us.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019 16:04:38 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

> >>> Fixes: 0cfaee2af3a0 ("include/asm-generic/5level-fixup.h: fix variable 'p4d' set but not used")
> >>> Reported-by: Guenter Roeck <linux@roeck-us.net>
> >>> Signed-off-by: Qian Cai <cai@lca.pw>
> >>
> >> Tested-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > Acked-by: Helge Deller <deller@gmx.de>
> > 
> > Helge
> > 
> 
> Any chance to push this patch into mainline anytime soon ? It has been applied
> to -next, but all parisc builds in mainline are still broken.

I'll be including it in tomorrow's patchpile->Linus.
