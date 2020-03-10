Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D19E417F2C6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 10:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCJJJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 05:09:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55146 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgCJJJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:09:09 -0400
Received: from zn.tnic (p200300EC2F09B400A5B1E817268DA3C3.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:b400:a5b1:e817:268d:a3c3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D127A1EC0CAA;
        Tue, 10 Mar 2020 10:09:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1583831347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SR1NMyFy2J0Mm1Wny9URsw1cCDuET94HMMrVJkWGEfk=;
        b=fiRLl0lQoR8XIgODRA2GH7Frn7UgehjiVDZ/gsIderdbtvpqqEKLDWZdatVS38vdOkAU6E
        brD1xpMyj2Gs45dQ6DSyarxCADiM+Lx8s4G1DE1BM9JVtKdaosCtnasEwwBV8zLTnf/VQj
        qGmTlvnJsZoiC3LJjysXm8zOpwN8SOM=
Date:   Tue, 10 Mar 2020 10:09:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        DavidWang@zhaoxin.com, CooperYan@zhaoxin.com,
        QiyuanWang@zhaoxin.com, HerryYang@zhaoxin.com, CobeChen@zhaoxin.com
Subject: Re: [PATCH] x86/Kconfig: make X86_UMIP to cover any X86 CPU
Message-ID: <20200310090917.GB29372@zn.tnic>
References: <1583733990-2587-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <20200309203632.GB9002@zn.tnic>
 <79c4bc05-0482-3ce7-0f93-544977e466dc@zytor.com>
 <621e255f-f497-a324-b004-4cb9b84784d0@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <621e255f-f497-a324-b004-4cb9b84784d0@zhaoxin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 03:24:37PM +0800, Tony W Wang-oc wrote:
> Moreover, if remove the X86_UMIP config, a kernel-parameter like
> "noumip" may be needed?

Not the same thing. Also, why would one need it? If one did, one would
need it now too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
