Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1012612023C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 11:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLPKV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 05:21:57 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54582 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbfLPKV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:21:57 -0500
Received: from zn.tnic (p4FED3450.dip0.t-ipconnect.de [79.237.52.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 27F181EC0AB5;
        Mon, 16 Dec 2019 11:21:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576491716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PlXJ6iijV+JtLwuqUX7aC8TAlBiVTPqvWsuHuEDokPY=;
        b=Wc1/8vqovVdNKX7aMShs61YwhJ0CrIN9t83u0kKVGJ63sZrTw0JbCfI0tZ3IOgItryA5IK
        Ic6LOOLpXKf3UBW7/7HPZ9fLZyb0Jq1Xrnr7WRl1367OV0okKkmfHu9bqEBXhzUrRsbaZx
        V1WLOJUG1qWCHfQrrUnKV+flU+nLobg=
Date:   Mon, 16 Dec 2019 11:19:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] init: use do_mount() instead of ksys_mount()
Message-ID: <20191216101939.GA17380@zn.tnic>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <20191212181422.31033-4-linux@dominikbrodowski.net>
 <20191216094556.GA32241@zn.tnic>
 <20191216095137.omiovbgt5bwjahku@isilmar-4.linta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216095137.omiovbgt5bwjahku@isilmar-4.linta.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:51:37AM +0100, Dominik Brodowski wrote:
> Does
> 
> https://lore.kernel.org/lkml/CAHk-=wh8VLe3AEKhz=1bzSO=1fv4EM71EhufxuC=Gp=+bLhXoA@mail.gmail.com/
> 
> solve the issue?

Yap, it does.

Reported-by: Borislav Petkov <bp@suse.de>
Tested-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
