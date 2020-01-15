Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB99E13CEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 22:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgAOVPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 16:15:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40510 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729605AbgAOVPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579122923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=muxxPebkhn0816OH3sFQELSDbHRR8DpTYRznlvVGJa4=;
        b=VNmywsPbgevR9vgB36yWIw5kDP6PA+6T8OZGrDDmBeHDkvRsGDX9q8CG7mKzshZccpeEnN
        V5m02vJ+eKhYw9uH/GA6TlIS9b/q+UBR9+jJ3Tawxsg+66XrwqxcGRQ2i88qWTub4lcZUg
        0dl/wxXCfEeLt72l4UYfn8Nwdapv+mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-7a51uNlGMiaVLisYQv0icw-1; Wed, 15 Jan 2020 16:15:19 -0500
X-MC-Unique: 7a51uNlGMiaVLisYQv0icw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDB941005502;
        Wed, 15 Jan 2020 21:15:17 +0000 (UTC)
Received: from treble (ovpn-121-224.rdu2.redhat.com [10.10.121.224])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D31AD60BE0;
        Wed, 15 Jan 2020 21:15:15 +0000 (UTC)
Date:   Wed, 15 Jan 2020 15:15:13 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Neelima Krishnan <neelima.krishnan@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86/cpu: Update cached HLE state on write to
 TSX_CTRL_CPUID_CLEAR
Message-ID: <20200115211513.mxzembrm4hf44d6j@treble>
References: <2529b99546294c893dfa1c89e2b3e46da3369a59.1578685425.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2529b99546294c893dfa1c89e2b3e46da3369a59.1578685425.git.pawan.kumar.gupta@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 02:50:54PM -0800, Pawan Gupta wrote:
> /proc/cpuinfo currently reports Hardware Lock Elision (HLE) feature to
> be present on boot cpu even if it was disabled during the bootup. This
> is because cpuinfo_x86->x86_capability HLE bit is not updated after TSX
> state is changed via a new MSR IA32_TSX_CTRL.
> 
> Update the cached HLE bit also since it is expected to change after an
> update to CPUID_CLEAR bit in MSR IA32_TSX_CTRL.
> 
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

From the Intel TAA deep dive page [1], it says:

  "On processors that enumerate IA32_ARCH_CAPABILITIES[TSX_CTRL] (bit
   7)=1, HLE prefix hints are always ignored."

So if the CPU has IA32_TSX_CTRL, HLE is implicitly disabled, so why
would the HLE bit have been set in CPUID in the first place?

[1] https://software.intel.com/security-software-guidance/insights/deep-dive-intel-transactional-synchronization-extensions-intel-tsx-asynchronous-abort

-- 
Josh

