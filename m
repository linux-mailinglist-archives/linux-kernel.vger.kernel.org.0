Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C633A5598
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 14:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbfIBMK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 08:10:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55612 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730117AbfIBMKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:10:25 -0400
Received: from zn.tnic (p200300EC2F06430009E289DB508BD3C2.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:4300:9e2:89db:508b:d3c2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 35F531EC0A91;
        Mon,  2 Sep 2019 14:10:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567426224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Jh82SzAHwxj/SwEPxncTN2/OkaRBdF2BdHpBbMrJGuc=;
        b=MTiwUkdKKIz2o5gvwNOMhHu2TKunJkJl+THZYXwbz5Y4lJuWD8O1Xcjrii4cdd3jTuBkeF
        6HM45qbZauqypd6YkxuiMsCWayV5MPt9l8UsmiFrxBa4eIyFXjNPv/B6ZExn/4r1Etbaku
        HhtlshkElDwZMLV02377hmWT6dEVoLw=
Date:   Mon, 2 Sep 2019 14:10:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Marco Ammon <marco.ammon@fau.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH 1/3] x86: fix typo in comment for poke_text_early
Message-ID: <20190902121017.GD9605@zn.tnic>
References: <20190902102436.27396-1-marco.ammon@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190902102436.27396-1-marco.ammon@fau.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 12:24:34PM +0200, Marco Ammon wrote:
> In the documentation for text_poke_early, "protected again" should
> actually be "protected against". This patch fixes the spelling mistake.

For the future:

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

I've merged those patches into a single one and have applied it.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
