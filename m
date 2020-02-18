Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6513D16316C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 21:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgBRUAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 15:00:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55012 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728522AbgBRUAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:00:12 -0500
Received: from zn.tnic (p200300EC2F0C1F00DCB96C3517B36067.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1f00:dcb9:6c35:17b3:6067])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4BC741EC0CF3;
        Tue, 18 Feb 2020 21:00:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582056011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=M7FeIuaaEw2kt/luaqzhrd/OTft0vjwkL2w9pvYIVaA=;
        b=gAaJMjvEDuDgQZOY7IvD7Bf1WdJ86K66jxhCfQ/JdAHX5bBSXHFTGeHeB8ESBABfGA2Ki8
        75StIVi7iL0kjYwZvURvM2oMkKnq2ucHLqPcBam5CEk/14o+i+/83J/fvjhO3ctnBcD1y/
        QLUCfHTsP19UnTygXBBmNrw9/8ulOPI=
Date:   Tue, 18 Feb 2020 21:00:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] #MC mess
Message-ID: <20200218200011.GP14449@zn.tnic>
References: <20200218173150.GK14449@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
 <20200218195130.GO14449@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F57BD54@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F57BD54@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 07:54:54PM +0000, Luck, Tony wrote:
> Recoverable machine checks are a normal (hopefully rare) event on a server.  But you wouldn't
> want to lose tracing capability just because we took a page offline and killed a process to recover.

Yeah, ok. How do you want to select which ones? What mce_no_way_out()
says or severity or...?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
