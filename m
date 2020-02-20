Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9FC416671B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 20:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgBTT1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 14:27:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54446 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbgBTT1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:27:17 -0500
Received: from zn.tnic (p200300EC2F0ADE00D4B58F3D7A4EE0EA.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:de00:d4b5:8f3d:7a4e:e0ea])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A8011EC0CFF;
        Thu, 20 Feb 2020 20:27:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582226836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XgfWKf0Mxmz9+KIb4qScrwbVofOZQQvjCRbAo/W/lJA=;
        b=Tzt/MsWBzUT9peQW31UzGbDa4/f4K2wK6PxNM+HFy78sYG+avvClK/1CKZLZlZ6WFXsnsu
        3D0viOqOs2KyV0letSbO/OPpMEw7q+1MAp28QlwNMmPBKT7RchO5W4J+Ph77UQU3P1v9lF
        Sf3jsFD0BMqdDWiJNrJ9RDIv38q+3W0=
Date:   Thu, 20 Feb 2020 20:27:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 0/2] objtool: clang-related fixes
Message-ID: <20200220192709.GF30188@zn.tnic>
References: <cover.1581997059.git.jpoimboe@redhat.com>
 <CAKwvOdnOrezCVzRSFfrXxXXgfPCNxeyi8=2-k9Fz=Y4xAe8fAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdnOrezCVzRSFfrXxXXgfPCNxeyi8=2-k9Fz=Y4xAe8fAw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 11:06:30AM -0800, Nick Desaulniers wrote:
> Hello, can one of the x86 maintainers please pick up this series? Our
> CI has been red *for days* now without it.

I'll queue them tomorrow.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
