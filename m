Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1939317F2C3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 10:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgCJJIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 05:08:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54904 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgCJJIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:08:02 -0400
Received: from zn.tnic (p200300EC2F09B400A5B1E817268DA3C3.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:b400:a5b1:e817:268d:a3c3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1828D1EC0CAA;
        Tue, 10 Mar 2020 10:08:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1583831281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rqmq7MqrLcXz6NJsrkYnbB+Lr1QkPByv8PIiSXE40vk=;
        b=pv2LI/ni+TT8nTovomJcIMrk9dlFogVp/bdFBBlkd0w/binbvLrqto8yATm1AwCqFxNnMt
        SYs9tmFDNCbMxNXO8vpMEZEO/ZCLkzYW2UY39jbFSQWp6BI9HR/P6VnM8p3KK63Cf6YwY6
        m7yrBTy/k/d9k7Lnos3KzMD6Erz8vxg=
Date:   Tue, 10 Mar 2020 10:08:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        DavidWang@zhaoxin.com, CooperYan@zhaoxin.com,
        QiyuanWang@zhaoxin.com, HerryYang@zhaoxin.com, CobeChen@zhaoxin.com
Subject: Re: [PATCH] x86/Kconfig: make X86_UMIP to cover any X86 CPU
Message-ID: <20200310090805.GA29372@zn.tnic>
References: <1583733990-2587-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <20200309203632.GB9002@zn.tnic>
 <79c4bc05-0482-3ce7-0f93-544977e466dc@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79c4bc05-0482-3ce7-0f93-544977e466dc@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 05:25:59PM -0700, H. Peter Anvin wrote:
> Perhaps the super-tiny-embedded kernel guys care? Otherwise it seems
> pointless.

Yeah and I haven't heard anything from them in a while. I guess we can
leave it until someone removes it later.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
