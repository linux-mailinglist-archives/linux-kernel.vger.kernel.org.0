Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A25B712030B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 11:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfLPK5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 05:57:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60582 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfLPK5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:57:00 -0500
Received: from zn.tnic (p4FED3450.dip0.t-ipconnect.de [79.237.52.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F9C71EC09F1;
        Mon, 16 Dec 2019 11:56:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576493815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QJiNMAg/GcgzaQCJvUqpS4i6rcn+NVQocqxvPz+M2GE=;
        b=Gb2IOJSJuu/dh35XxyYuJc/OY2oU4XlmL4iWtLXcpQe3Ob3vcNvsPSHRvcrU4l0IAT01Xx
        UP/4ENS+Rgl3XEL3f3W7Qp1+XaLCxHzbd+rchK+GG0MNJlJTzQh3xLOg27Ep9mAOUOwETN
        JV14P8JYiSbuVvGIfuJsJQkCibzfSH8=
Date:   Mon, 16 Dec 2019 11:54:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: Oops booting 5.5.0-rc2
Message-ID: <20191216105439.GB32241@zn.tnic>
References: <3f2f9d0a-887a-6d44-994c-c53bd1c6a4e8@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f2f9d0a-887a-6d44-994c-c53bd1c6a4e8@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:41:18AM +0000, Chris Clayton wrote:
> I get an oops during boot of 5.5.0-rc2. My root partition is on an SSD - /dev/nvme0n1p5.

Here's the fix:

https://lore.kernel.org/lkml/CAHk-=wh8VLe3AEKhz=1bzSO=1fv4EM71EhufxuC=Gp=+bLhXoA@mail.gmail.com/

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
