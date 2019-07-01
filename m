Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11BAE1CB8B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 17:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfENPNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 11:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfENPNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:13:51 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 821092189E
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 15:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557846830;
        bh=4s1JH387kDlibhLwvYQPkEPbjY6Gw9eLhkTj339NheI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lJRjQ7wIvnVVqhMeibjj0qkL1n8Ukyqx/inG9XnyS7L77Il3cTy3JkZTYYglghl6u
         2+YrWLNZhDK/jAIUmVHUrOOVIquh0KUaPXHvI6oG3RGwipTYJ/5PLapHSpPwm3GZM8
         bu4C5x6jCIUtq2Jv7kNeGmHuGNIHvhxBDEMZ1rTo=
Received: by mail-wr1-f49.google.com with SMTP id e15so7258115wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 08:13:50 -0700 (PDT)
X-Gm-Message-State: APjAAAXB/secy9iSrCUWKZE7tF4MbHBrj5iKAdC6sDDObn0ARQ3VmleI
        d9ondSXmzrrUBVGZaPOz6t24P95M/hlUOBHyYT2TrA==
X-Google-Smtp-Source: APXvYqzLv5DYWAo0v/h3Fw4xdAQX6813reZpYcna4ZZGgdSyCyedEpv2RbQy+PBGxmg9xoXjFQOvTRWzmzvDojnm+Fg=
X-Received: by 2002:adf:fb4a:: with SMTP id c10mr21405885wrs.309.1557846828943;
 Tue, 14 May 2019 08:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <5854e66a-950e-1b12-5393-d9cdd15367dc@fortanix.com>
 <CALCETrV7CcDnx1hVtmBnDNABG11GuMqyspJMMpV+zHpVeFu3ow@mail.gmail.com>
 <960B34DE67B9E140824F1DCDEC400C0F4E885F9D@ORSMSX116.amr.corp.intel.com>
 <979615a8-fd03-e3fd-fbdb-65c1e51afd93@fortanix.com> <8fe520bb-30bd-f246-a3d8-c5443e47a014@intel.com>
 <358e9b36-230f-eb18-efdb-b472be8438b4@fortanix.com> <960B34DE67B9E140824F1DCDEC400C0F4E886094@ORSMSX116.amr.corp.intel.com>
 <6da269d8-7ebb-4177-b6a7-50cc5b435cf4@fortanix.com> <CALCETrWCZQwg-TUCm58DVG43=xCKRsMe1tVHrR8vdt06hf4fWA@mail.gmail.com>
 <20190513102926.GD8743@linux.intel.com> <20190514104323.GA7591@linux.intel.com>
In-Reply-To: <20190514104323.GA7591@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 14 May 2019 08:13:36 -0700
X-Gmail-Original-Message-ID: <CALCETrVbgTCnPo=PAq0-KoaRwt--urrPzn==quAJ8wodCpkBkw@mail.gmail.com>
Message-ID: <CALCETrVbgTCnPo=PAq0-KoaRwt--urrPzn==quAJ8wodCpkBkw@mail.gmail.com>
Subject: Re: [PATCH v20 00/28] Intel SGX1 support
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Dr. Greg" <greg@enjellic.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "npmccallum@redhat.com" <npmccallum@redhat.com>,
        "Ayoun, Serge" <serge.ayoun@intel.com>,
        "Katz-zamir, Shay" <shay.katz-zamir@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Borislav Petkov <bp@alien8.de>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 3:43 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, May 13, 2019 at 01:29:26PM +0300, Jarkko Sakkinen wrote:
> > I did study through SDK's file format and realized that it does not
> > does make sense after all to embed one.
> >
> > To implement it properly you would probably need a new syscall (lets say
> > sgx_load_enclave) and also that enclaves are not just executables
> > binaries. It is hard to find a generic format for them as applications
> > range from simply protecting part of an application to running a
> > containter inside enclave.
>
> I'm still puzzling what kind of changes you were discussing considering
> SGX_IOC_ENCLAVE_ADD_PAGE.

I think it's as simple as requiring that, if SECINFO.X is set, then
the src pointer points to the appropriate number of bytes of
executable memory.  (Unless there's some way for an enclave to change
SECINFO after the fact -- is there?)  Sadly, we don't really have the
a nice in-kernel API for that right now.  You could do
down_read(mmap_sem) and find_vma().  Arguably there is no value to
checking that PKRU allows execute to the data.

Hey, Dave, if you're still paying attention to this thread, should we
have copy_from_user_exec() that does the right thing wrt the page
permissions and PKRU.
