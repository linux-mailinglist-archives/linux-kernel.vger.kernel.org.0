Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C23C11CBE6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfENPag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 11:30:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:4830 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfENPaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:30:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 08:30:34 -0700
X-ExtLoop1: 1
Received: from hhuan26-mobl.amr.corp.intel.com ([10.255.33.85])
  by fmsmga007.fm.intel.com with ESMTP; 14 May 2019 08:30:32 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Andy Lutomirski" <luto@kernel.org>
Cc:     "Jethro Beekman" <jethro@fortanix.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Dr. Greg" <greg@enjellic.com>,
        "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, "X86 ML" <x86@kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "npmccallum@redhat.com" <npmccallum@redhat.com>,
        "Ayoun, Serge" <serge.ayoun@intel.com>,
        "Katz-zamir, Shay" <shay.katz-zamir@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Josh Triplett" <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "David Rientjes" <rientjes@google.com>
Subject: Re: [PATCH v20 00/28] Intel SGX1 support
Reply-To: haitao.huang@linux.intel.com
References: <20190417103938.7762-1-jarkko.sakkinen@linux.intel.com>
 <8c5133bc-1301-24ca-418d-7151a6eac0e2@fortanix.com>
 <alpine.DEB.2.21.1904192248550.3174@nanos.tec.linutronix.de>
 <e1478f70-7e44-6e3e-2aaf-1b12a96328ed@fortanix.com>
 <2AE80EA3-799E-4808-BBE4-3872F425BCF8@amacapital.net>
 <49b28ca1-6e66-87d9-2202-84c58f13fb99@fortanix.com>
 <444537E3-4156-41FB-83CA-57C5B660523F@amacapital.net>
 <f9d93291-9b59-7b66-de9f-af92246f1c9c@fortanix.com>
 <alpine.DEB.2.21.1904192337160.3174@nanos.tec.linutronix.de>
 <5854e66a-950e-1b12-5393-d9cdd15367dc@fortanix.com>
 <CALCETrV7CcDnx1hVtmBnDNABG11GuMqyspJMMpV+zHpVeFu3ow@mail.gmail.com>
 <960B34DE67B9E140824F1DCDEC400C0F4E885F9D@ORSMSX116.amr.corp.intel.com>
 <979615a8-fd03-e3fd-fbdb-65c1e51afd93@fortanix.com>
 <8fe520bb-30bd-f246-a3d8-c5443e47a014@intel.com>
 <358e9b36-230f-eb18-efdb-b472be8438b4@fortanix.com>
 <960B34DE67B9E140824F1DCDEC400C0F4E886094@ORSMSX116.amr.corp.intel.com>
 <6da269d8-7ebb-4177-b6a7-50cc5b435cf4@fortanix.com>
 <CALCETrWCZQwg-TUCm58DVG43=xCKRsMe1tVHrR8vdt06hf4fWA@mail.gmail.com>
 <op.z1saqpzxwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <CALCETrXHbRL-pzZ7CG+RrMNGNEPKO9LY=6Bo4tuFzcZ_ZTMQvQ@mail.gmail.com>
Date:   Tue, 14 May 2019 10:30:32 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.z1sdc6m4wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CALCETrXHbRL-pzZ7CG+RrMNGNEPKO9LY=6Bo4tuFzcZ_ZTMQvQ@mail.gmail.com>
User-Agent: Opera Mail/1.0 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019 10:17:29 -0500, Andy Lutomirski <luto@kernel.org>  
wrote:

> On Tue, May 14, 2019 at 7:33 AM Haitao Huang
> <haitao.huang@linux.intel.com> wrote:
>>
>> On Fri, 10 May 2019 14:22:34 -0500, Andy Lutomirski <luto@kernel.org>
>> wrote:
>>
>> > On Fri, May 10, 2019 at 12:04 PM Jethro Beekman <jethro@fortanix.com>
>> > wrote:
>> >>
>> >> On 2019-05-10 11:56, Xing, Cedric wrote:
>> >> > Hi Jethro,
>> >> >
>> >> >> ELF files are explicitly designed such that you can map them (with
>> >> mmap)
>> >> >> in 4096-byte chunks. However, sometimes there's overlap and you  
>> will
>> >> >> sometimes see that a particular offset is mapped twice because the
>> >> first
>> >> >> half of the page in the file belongs to an RX range and the second
>> >> half
>> >> >> to an R-only range. Also, ELF files don't (normally) describe  
>> stack,
>> >> >> heap, etc. which you do need for enclaves.
>> >> >
>> >> > You have probably misread my email. By mmap(), I meant the enclave
>> >> file would be mapped via *multiple* mmap() calls, in the same way as
>> >> what dlopen() would do in loading regular shared object. The  
>> intention
>> >> here is to make the enclave file subject to the same checks as  
>> regular
>> >> shared objects.
>> >>
>> >> No, I didn't misread your email. My original point still stands:
>> >> requiring that an enclave's memory is created from one or more mmap
>> >> calls of a file puts significant restrictions on the enclave's  
>> on-disk
>> >> representation.
>> >>
>> >
>> > For a tiny bit of background, Linux (AFAIK*) makes no effort to ensure
>> > the complete integrity of DSOs.  What Linux *does* do (if so
>> > configured) is to make sure that only approved data is mapped
>> > executable.  So, if you want to have some bytes be executable, those
>> > bytes have to come from a file that passes the relevant LSM and IMA
>> > checks.
>>
>> Given this, I just want to step back a little to understand the exact
>> issue that SGX is causing here for LSM/IMA. Sorry if I missed points
>> discussed earlier.
>>
>> By the time of EADD, enclave file is opened and should have passed IMA  
>> and
>> SELinux policy enforcement gates if any. We really don't need extra  
>> mmaps
>> on the enclave files to be IMA and SELinux compliant.
>
> The problem, as i see it, is that they passed the *wrong* checks,
> because, as you noticed:
>
>> We are loading
>> enclave files as RO and copying those into EPC.
>
> Which is, semantically, a lot like loading a normal file as RO and
> then mprotecting() it to RX, which is disallowed under quite a few LSM
> policies.
>
>> An IMA policy can enforce
>> RO files (or any file). And SELinux policy can say which processes can
>> open the file for what permissions. No extra needed here.
>
> If SELinux says a process may open a file as RO, that does *not* mean
> that it can be opened as RX.
>

But in this case, file itself is mapped as RO treated like data and it is  
not for execution. SGX enclave pages have EPCM enforced permissions. So  
 from SELinux point of view I would think it can treat it as RO and that's  
fine.

>>
>> And sgx enclaves are always signed and integrity protected and verified  
>> at
>> the time of EINIT. So if EINIT passes, we know the content loaded
>> (including permission flags) is matching the sigstruct.  But
>> sigstruct/signature is part of the file, should be accounted for in IMA
>> measurement of the whole file, so it is also verified by IMA during file
>> open, right?
>
> This does work, but only if the kernel parses that file so that the
> kernel can trust that the enclave data actually came from the file as
> intended.  And moving the parsing to the kernel seems like a mess that
> no one really wants to do.

If kernel only needs to know the source bytes are from a file that passed  
IMA integrity and SELinux RO enforcement, then it can just check if the  
source pointer belongs to a VMA with valid fd and no parsing or checking  
permissions needed.
Understood if you want to make enclave file code segment stick to the RX  
semantics mentioned above, then this doesn't qualify.

Thanks

Haitao
