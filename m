Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05BE0FE657
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 21:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKOUVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 15:21:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48708 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfKOUVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 15:21:49 -0500
Received: from [10.133.216.62] (unknown [46.114.32.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 269921EC0D0D;
        Fri, 15 Nov 2019 21:21:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573849307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CJ5nL9wzLm/h6B/VGer8ezaThD56Vy5DLPCRUmPBrP8=;
        b=M8kPyMeLjtA78o+y77W7UZgoXpRYA9GJPHacy+jFFUAoE3iBbe0I5QB98MugP/8j2dxtnf
        GY7XBlknM+BQsrnQ7tkDyLcv107QrWFewLcxI/swL4gWc9tomCuaJX9vUl9sUYmAw/vJj0
        pD3Hw5hGd4Yakc9SksgDzjBXhvrcUeE=
Date:   Fri, 15 Nov 2019 21:21:45 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.21.1911152027200.28787@nanos.tec.linutronix.de>
References: <20191115161445.30809-1-longman@redhat.com> <20191115161445.30809-2-longman@redhat.com> <7EAED44C-A93E-405E-B57B-89AC3F779A70@alien8.de> <alpine.DEB.2.21.1911152027200.28787@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] x86/speculation: Fix incorrect MDS/TAA mitigation status
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
From:   Boris Petkov <bp@alien8.de>
Message-ID: <C365EA60-3A23-4C39-B21C-2CBC0B450E3C@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 15, 2019 8:35:54 PM GMT+01:00, Thomas Gleixner <tglx@linutronix=
=2Ede> wrote:
>See the last sentence of the paragraph you replied to :)

Proves even more that this should be documented in *all* places that talk =
about TAA cmdline options and we should not rely on references but write st=
uff out everywhere so that people can see it directly=2E

>But serioulsy, yes we should mention the interaction in
>kernel-parameters=2Etxt as well=2E Something like:
>
>	off        - Unconditionally disable MDS mitigation=2E
>+		     On TAA affected machines, mds=3Doff can be prevented
>+		     by an active TAA mitigation as both vulnerabilities
>+		     are mitigated with the same mechanism=2E
>
>and the other way round for TAA=2E

Ack=2E

Thx=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
