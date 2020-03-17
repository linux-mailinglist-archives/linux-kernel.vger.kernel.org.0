Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19AA1188A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 17:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCQQiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 12:38:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:24776 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbgCQQiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584463089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1cmo9yvmEUOjZCY2QATmsaxzi5lWYanxsFcnQm9/fag=;
        b=IETX7sTeoraQTvKexvlfbCHjFkgsrYiA2PRE6LnJrj2RblUElzNaFIkPcz7513yUblrJ9v
        tvRYG+kiTCRpZS3sol5IWmK87ulkqUFK/Dd0XY0v7Qk4kM82EembdOccoveRXyadlfHy6f
        isFp3Uvji5YtzZb+WhbSaIb6jLqQgbs=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-F5Usw7kcMkOyVjCVFh85Kw-1; Tue, 17 Mar 2020 12:38:06 -0400
X-MC-Unique: F5Usw7kcMkOyVjCVFh85Kw-1
Received: by mail-io1-f69.google.com with SMTP id c7so14530279iog.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 09:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1cmo9yvmEUOjZCY2QATmsaxzi5lWYanxsFcnQm9/fag=;
        b=S/ntu6PnbkafLyVBofOdgbKl/5ppRryuPacbyQ8noRmNTsMC4U8BKFw3dG8RUwNHS2
         tdpjVodSqe6Tdn43czrR1NiklroE2kTZKLcmL2au682LpSry6js1exTN4WtTti/jEfbQ
         L1foeE10o9SoqQ2V1DQ4rWpEufWvFIWX+cgXgr/DFweShMaF6b8MGm4Te/Hs7YQoeojc
         S4XWryJFx/kVSl8NkTCHYz+0LpeAc5Jp/A0zYBL/Uog8WbpVSHngJHDa74piwMFp/KMN
         VDJlUT0SdVM5s/Yc3Dj0Gz+ZFi0oHLQQhw3vIp8tB6M8vcNJva5tOHyP58JqbuCTKs+J
         U/vA==
X-Gm-Message-State: ANhLgQ3mqu9HXd0IcYpafCny1Kyo5TRXzAKtNevsUMPgQ1wpditcBtI7
        3++PKA1onl5MDf/CCr6znIKh4NixGiS4WrK1zbPKxu/oW3+DcEM/ZXvEJnKwEx6/eyXePyvf7A/
        415Uq0o1HPue6JVpaI+fNXf+rFJRPJ/aMhlf3Y50s
X-Received: by 2002:a02:86:: with SMTP id 128mr195326jaa.3.1584463085791;
        Tue, 17 Mar 2020 09:38:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtaDELQPtZX9WKJ1+skbJrbn1BKu58HWv6Zj5HtMcnUzSOIzNHw/Ku3ZCqVS5xSXt8qf7dpVnbQ3f3/xI+1kTM=
X-Received: by 2002:a02:86:: with SMTP id 128mr195293jaa.3.1584463085470; Tue,
 17 Mar 2020 09:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAOASepPi4byhQ21hngsSx8tosCC-xa=y6r4j=pWo2MZGeyhi4Q@mail.gmail.com>
 <20200315012523.GC208715@linux.intel.com> <CAOASepP9GeTEqs1DSfPiSm9ER0whj9qwSc46ZiNj_K4dMekOfQ@mail.gmail.com>
 <94ce05323c4de721c4a6347223885f2ad9f541af.camel@linux.intel.com>
 <CAOASepM1pp1emPwSdFcaRkZfFm6sNmwPCJH+iFMiaJpFjU0VxQ@mail.gmail.com>
 <5dc2ec4bc9433f9beae824759f411c32b45d4b74.camel@linux.intel.com>
 <20200316225322.GJ24267@linux.intel.com> <fa773504-4cc1-5cbd-c018-890f7a5d3152@intel.com>
 <20200316235934.GM24267@linux.intel.com> <ca2c9ac0-b717-ee96-c7df-4e39f03a9193@intel.com>
 <20200317002706.GN24267@linux.intel.com>
In-Reply-To: <20200317002706.GN24267@linux.intel.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Tue, 17 Mar 2020 12:37:54 -0400
Message-ID: <CAOASepN8wdSL22+YodZW-8as7uGNCBqt3BdtgWBi9d0XD5xkJw@mail.gmail.com>
Subject: Re: [PATCH v28 21/22] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     "Xing, Cedric" <cedric.xing@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, Neil Horman <nhorman@redhat.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        "Svahn, Kai" <kai.svahn@intel.com>, bp@alien8.de,
        Josh Triplett <josh@joshtriplett.org>, luto@kernel.org,
        kai.huang@intel.com, David Rientjes <rientjes@google.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jethro Beekman <jethro@fortanix.com>,
        Connor Kuehl <ckuehl@redhat.com>,
        Harald Hoyer <harald@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 8:27 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Mon, Mar 16, 2020 at 05:18:14PM -0700, Xing, Cedric wrote:
> > On 3/16/2020 4:59 PM, Sean Christopherson wrote:
> > >On Mon, Mar 16, 2020 at 04:50:26PM -0700, Xing, Cedric wrote:
> > >>On 3/16/2020 3:53 PM, Sean Christopherson wrote:
> > >>>On Mon, Mar 16, 2020 at 11:38:24PM +0200, Jarkko Sakkinen wrote:
> > >>>>>My suggestions explicitly maintained robustness, and in fact increased
> > >>>>>it. If you think we've lost capability, please speak with specificity
> > >>>>>rather than in vague generalities. Under my suggestions we can:
> > >>>>>1. call the vDSO from C
> > >>>>>2. pass context to the handler
> > >>>>>3. have additional stack manipulation options in the handler
> > >>>>>
> > >>>>>The cost for this is a net 2 additional instructions. No existing
> > >>>>>capability is lost.
> > >>>>
> > >>>>My vague generality in this case is just that the whole design
> > >>>>approach so far has been to minimize the amount of wrapping to
> > >>>>EENTER.
> > >>>
> > >>>Yes and no.   If we wanted to minimize the amount of wrapping around the
> > >>>vDSO's ENCLU then we wouldn't have the exit handler shenanigans in the
> > >>>first place.  The whole process has been about balancing the wants of each
> > >>>use case against the overall quality of the API and code.
> > >>>
> > >>The design of this vDSO API was NOT to minimize wrapping, but to allow
> > >>maximal flexibility. More specifically, we strove not to restrict how info
> > >>was exchanged between the enclave and its host process. After all, calling
> > >>convention is compiler specific - i.e. the enclave could be built by a
> > >>different compiler (e.g. MSVC) that doesn't share the same list of CSRs as
> > >>the host process. Therefore, the API has been implemented to pass through
> > >>virtually all registers except those used by EENTER itself. Similarly, all
> > >>registers are passed back from enclave to the caller (or the exit handler)
> > >>except those used by EEXIT. %rbp is an exception because the vDSO API has to
> > >>anchor the stack, using either %rsp or %rbp. We picked %rbp to allow the
> > >>enclave to allocate space on the stack.
> > >
> > >And unless I'm missing something, using %rcx to pass @leaf would still
> > >satisfy the above, correct?  Ditto for saving/restoring %rbx.
> > >
> > >I.e. a runtime that's designed to work with enclave's using a different
> > >calling convention wouldn't be able to take advantage of being able to call
> > >the vDSO from C, but neither would it take on any meaningful burden.
> > >
> > Not exactly.
> >
> > If called directly from C code, the caller would expect CSRs to be
> > preserved. Then who should preserve CSRs? It can't be the enclave because it
> > may not follow the same calling convention. Moreover, the enclave may run
> > into an exception, in which case it doesn't have the ability to restore
> > CSRs. So it has to be done by the vDSO API. That means CSRs will be
> > overwritten upon enclave exits, which violates the goal of "passing all
> > registers back to the caller except those used by EEXIT".
>
> IIUC, Nathaniel's use case is to run only enclaves that are compatible
> with Linux's calling convention and to handle enclave exceptions in the
> exit handler.
>
> As I qualified above, there would certainly be runtimes and use cases that
> would find no advantage in passing @leaf via %rcx and preserving %rbx.  I'm
> well aware the Intel SDK falls into that bucket.  But again, the cost to
> such runtimes is precisely one reg->reg MOV instruction.

It seems to me that some think my proposal represents a shift in
strategic direction. I do not see it that way. I affirm the existing
strategic direction. My proposal only represents a specific
optimization of that strategic direction that benefits certain use
cases without significant cost to all other use cases.

