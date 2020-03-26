Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29154194228
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 15:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgCZO5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 10:57:33 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42120 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgCZO5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:57:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id t9so5478868qto.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 07:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ae/cSBEsHntpDVcOFjQz46ynMe+UadTdLe4WT8p1RpU=;
        b=ovEuv/Sk3SHlUrsbYzcjLJ8FJjziOHL6wrJf4miHPFqHIFF6wEre4H/VvYqiUrbl6Y
         EYoU/yPN+QPgpXfxQXy5TDCE5MrcZSi0YvSyDU3oNhHCfDhmRwyJZdhzt0c6/9axFG8b
         6Gkeo06YdfTTGo4FM/gHL8Xpoghqp5L3hLFPjeVIGLlUJVvf2TnyEkIweGD8WPOlPYfj
         St8nb9gDjc2fbljl6WgnEumcDrahkX+1yRYJPX2PXYOJtyJE1oeqUG+e09FGPY/Dr76x
         5s61CepEz8PivIA6Pa6g/zJmQwiOA63otedD2m+Sdb6J//FBXLM4lHRair4Xv7jrpR0D
         ARKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ae/cSBEsHntpDVcOFjQz46ynMe+UadTdLe4WT8p1RpU=;
        b=W6MXdONLp2ianE3aveQ6+p8HDcrdna6FjV0g56Bg20LLCFSDDP8IdzizgdxEhPEyk7
         eT//wukFZWJ7zbuClslm1JLQ2V8UT370y4J4khRtobSnBJPkrobtDuZRGDb8yJZ8uJnP
         8LCSn97YXAwAYM8fgU3M+LSR5zMSgpHbGiNaXmXMPCBnmWZC1byvlX9SOMolq5QQooGx
         saKRnYfJFh5E5ueCuUN3Ag1I/0d5IreLXx9a7z2j1RWwqMw2vlT+qMIUDb9D3/uD+PtN
         tk01j+L7dHFXqYiqsko+qd0so3Uu4Y6k+PjIit7DYRvZaRvptTYFdXyxB0RPJE5ZUKNH
         20PA==
X-Gm-Message-State: ANhLgQ2TRrLPtWSIB23QUldi1GWzORY0WRpq7W0svNImH5w+fzAhjFDz
        LFMeFcja67x4fR8/dHtTfzA=
X-Google-Smtp-Source: ADFU+vtO86qMHCeT5oLRkvadbqZbTiUSR4B2NCmdCE9lY5uUnyAI4yzp89k7zaK7n5NJdIgsHt+a6A==
X-Received: by 2002:aed:3981:: with SMTP id m1mr8776154qte.35.1585234650090;
        Thu, 26 Mar 2020 07:57:30 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id f93sm1725423qtd.26.2020.03.26.07.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 07:57:29 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E650140061; Thu, 26 Mar 2020 11:57:26 -0300 (-03)
Date:   Thu, 26 Mar 2020 11:57:26 -0300
To:     "Hunter, Adrian" <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mingbo Zhang <whensungoes@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: perf: insn: Tweak opcode map for Intel CET
 instructions
Message-ID: <20200326145726.GC6411@kernel.org>
References: <20200303045033.6137-1-whensungoes@gmail.com>
 <20200326103153.de709903f26fee0918414bd2@kernel.org>
 <bac567dd-9810-4919-365e-b3dfb54a6c4b@intel.com>
 <20200326135547.GA20397@redhat.com>
 <363DA0ED52042842948283D2FC38E4649C72EFF3@IRSMSX106.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363DA0ED52042842948283D2FC38E4649C72EFF3@IRSMSX106.ger.corp.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 26, 2020 at 02:19:07PM +0000, Hunter, Adrian escreveu:
> > -----Original Message-----
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Sent: Thursday, March 26, 2020 3:56 PM
> > To: Hunter, Adrian <adrian.hunter@intel.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>; Mingbo Zhang
> > <whensungoes@gmail.com>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; x86@kernel.org; Thomas Gleixner
> > <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; Borislav Petkov
> > <bp@alien8.de>; H. Peter Anvin <hpa@zytor.com>; Andi Kleen
> > <ak@linux.intel.com>; Josh Poimboeuf <jpoimboe@redhat.com>; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH] x86: perf: insn: Tweak opcode map for Intel CET
> > instructions
> > 
> > Em Thu, Mar 26, 2020 at 07:09:45AM +0200, Adrian Hunter escreveu:
> > > On 26/03/20 3:31 am, Masami Hiramatsu wrote:
> > > > Hi,
> > > >
> > > > On Mon,  2 Mar 2020 23:50:30 -0500
> > > > Mingbo Zhang <whensungoes@gmail.com> wrote:
> > > >
> > > >> Intel CET instructions are not described in the Intel SDM. When
> > > >> trying to get the instruction length, the following instructions
> > > >> get wrong (missing ModR/M byte).
> > > >>
> > > >> RDSSPD r32
> > > >> RSDDPQ r64
> > > >> ENDBR32
> > > >> ENDBR64
> > > >> WRSSD r/m32, r32
> > > >> WRSSQ r/m64, r64
> > > >>
> > > >> RDSSPD/Q and ENDBR32/64 use the same opcode (f3 0f 1e) slot, which
> > > >> is described in SDM as Reserved-NOP with no encoding characters,
> > > >> and got an empty slot in the opcode map. WRSSD/Q (0f 38 f6) also got
> > an empty slot.
> > > >>
> > > >
> > > > This looks good to me. BTW, wouldn't we need to add decode test cases
> > to perf?
> > > >
> > > > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > >
> > > > Thank you,
> > > >
> > >
> > > We have correct patches that you ack'ed for CET here:
> > >
> > >
> > > https://lore.kernel.org/lkml/20200204171425.28073-1-yu-cheng.yu@intel.
> > > com/
> > >
> > > But they have not yet been applied.
> > >
> > > Sorry for the confusion.
> > 
> > I'll collect them, thanks for pointing this out.
> 
> The patches are in tip courtesy of Borislav Petkov thank you!

Ok, thanks Borislav,

- Arnaldo
