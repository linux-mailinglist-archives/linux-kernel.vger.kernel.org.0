Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F363087327
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 09:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405891AbfHIHhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 03:37:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46872 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405881AbfHIHhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:37:21 -0400
Received: from zn.tnic (p200300EC2F0BAF001CD97DA1D84759A1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:af00:1cd9:7da1:d847:59a1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D88331EC0503;
        Fri,  9 Aug 2019 09:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565336240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZppeEZaFY6xSLbiFc5H8vVrCDN0qMD4mc9pMNB2IsBw=;
        b=jSX9rhUl+h8KeSjXmO+aau7bHshPqlQJXYeMYC0XYdlJRX0Fj0QLbGuVP5CTXlNl8tR4A8
        WkI/bT2dCrljsJybGXf47QeYuYAFGilBatibEgUntW1eNNcTpirpvMlk1K30fzrhPHXaR/
        y3flv9z9rD0UiZOh9BZ2J3edP+15iJI=
Date:   Fri, 9 Aug 2019 09:38:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 09/10] x86/resctrl: Pseudo-lock portions of multiple
 resources
Message-ID: <20190809073807.GC2152@zn.tnic>
References: <cover.1564504901.git.reinette.chatre@intel.com>
 <c0095fd15488d87be06deddf43abb4a2834dc7e6.1564504902.git.reinette.chatre@intel.com>
 <20190807152511.GB24328@zn.tnic>
 <e9145623-bf5a-b96c-d802-7b61caa406e0@intel.com>
 <20190808084416.GC20745@zn.tnic>
 <a69981df-80f5-d8cf-e118-2ee639dcdb77@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a69981df-80f5-d8cf-e118-2ee639dcdb77@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 01:13:46PM -0700, Reinette Chatre wrote:
> There is a locking order dependency between cpu_hotplug_lock and
> rdtgroup_mutex (cpu_hotplug_lock before rdtgroup_mutex) that has to be
> maintained. To do so in this flow you will find cpus_read_lock() in
> rdtgroup_schemata_write(), so quite a distance from where it is needed.
> 
> Perhaps I should add a comment at the location where the lock is
> required to document where the lock is obtained?

Even better - you can add:

	lockdep_assert_cpus_held();

above it which documents *and* checks too. :-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
