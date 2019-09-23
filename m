Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D63E8BB1A5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 11:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407323AbfIWJtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 05:49:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50744 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407253AbfIWJtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:49:16 -0400
Received: from zn.tnic (p200300EC2F060400856443B6AC31000F.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:400:8564:43b6:ac31:f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E2BD1EC0819;
        Mon, 23 Sep 2019 11:49:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569232155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/OX4YybCwZ8WEZGCJvP1SseCQZ1Y013Yl5Cn9n0qEmE=;
        b=VULaxlovaWUhOyw+mhmgLyRqqxm9woh5jl1y6aEX9yllFsCal2/AW2q+3OfyDyY68xwhny
        0R8wWfKvFm94TSqgXyq3rRsG26GsoLNNdluBN28ZZR6laEI8yMljh49eikUqtvIiy+9Et3
        oU/pFJBO/1uT+GnZJKD++h6nUxSDEt8=
Date:   Mon, 23 Sep 2019 11:49:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH] seccomp: remove unused arg from secure_computing()
Message-ID: <20190923094916.GB15355@zn.tnic>
References: <20190920131907.6886-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190920131907.6886-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 03:19:09PM +0200, Christian Brauner wrote:
> While touching seccomp code I realized that the struct seccomp_data
> argument to secure_computing() seems to be unused by all current
> callers. So let's remove it unless there is some subtlety I missed.
> Note, I only tested this on x86.

What was amluto thinking in

2f275de5d1ed ("seccomp: Add a seccomp_data parameter secure_computing()")

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
