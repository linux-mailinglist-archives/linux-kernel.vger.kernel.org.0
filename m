Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB4810999
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 16:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfEAOtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 10:49:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfEAOtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:49:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6AA7EC024915;
        Wed,  1 May 2019 14:49:49 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E30A710021B4;
        Wed,  1 May 2019 14:49:44 +0000 (UTC)
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
To:     Khalid Aziz <khalid.aziz@oracle.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        keescook@google.com, konrad.wilk@oracle.com,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave@sr71.net>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com>
 <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <35c4635e-8214-7dde-b4ec-4cb266b2ea10@redhat.com>
Date:   Wed, 1 May 2019 10:49:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 01 May 2019 14:49:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 11:34:04AM -0600, Khalid Aziz wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
b/Documentation/admin-guide/kernel-parameters.txt

> index 858b6c0b9a15..9b36da94760e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2997,6 +2997,12 @@
>
>      nox2apic    [X86-64,APIC] Do not enable x2APIC mode.
>
> +    noxpfo        [XPFO] Disable eXclusive Page Frame Ownership (XPFO)
> +            when CONFIG_XPFO is on. Physical pages mapped into
> +            user applications will also be mapped in the
> +            kernel's address space as if CONFIG_XPFO was not
> +            enabled.
> +
>      cpu0_hotplug    [X86] Turn on CPU0 hotplug feature when
>              CONFIG_BO OTPARAM_HOTPLUG_CPU0 is off.
>              Some features depend on CPU0. Known dependencies are:

Given the big performance impact that XPFO can have. It should be off by
default when configured. Instead, the xpfo option should be used to
enable it.

Cheers,
Longman

