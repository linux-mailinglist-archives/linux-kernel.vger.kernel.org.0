Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8384A47E05
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 11:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfFQJOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 05:14:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54694 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbfFQJOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:14:07 -0400
Received: from zn.tnic (p200300EC2F061300E197F1B82D7E4667.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:1300:e197:f1b8:2d7e:4667])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E4CCC1EC0AB9;
        Mon, 17 Jun 2019 11:14:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560762846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=esWtvvaU+HTDTE+bUZUafraMPobPs9RAIBfZm9WP3nE=;
        b=jqYp+0dJxQc41097/0iTI7yAt2X7EbZ8TpnXunoKsxcrr+01XbII9oCW9JxWUA7kkEMc1b
        pUUOWsQMvGmH4ri+t72y6IFGrRO5sjMF/ZNyR+EoECFC/EDM2KFWW/dhfWf27G/uhyI26Y
        YQEhkhdqYKYjCGt7EjK3Hmg5Q885ygs=
Date:   Mon, 17 Jun 2019 11:13:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/3] x86/resctrl: Get max rmid and occupancy scale
 directly from CPUID instead of cpuinfo_x86
Message-ID: <20190617091357.GF27127@zn.tnic>
References: <1560705250-211820-1-git-send-email-fenghua.yu@intel.com>
 <1560705250-211820-2-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1906162141301.1760@nanos.tec.linutronix.de>
 <20190617031808.GA214090@romley-ivt3.sc.intel.com>
 <20190617075214.GB27127@zn.tnic>
 <20190617080909.GC214090@romley-ivt3.sc.intel.com>
 <20190617083048.GE27127@zn.tnic>
 <20190617083502.GD214090@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190617083502.GD214090@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 01:35:02AM -0700, Fenghua Yu wrote:
> Is this OK? Or the patch 0002 is unnecessary?

One patch: carve out and move it where you think it should belong.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
