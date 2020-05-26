Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A62D519BF0E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 12:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbgDBKGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 06:06:00 -0400
Received: from ozlabs.org ([203.11.71.1]:52063 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgDBKGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 06:06:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48tJc24ckyz9sR4;
        Thu,  2 Apr 2020 21:05:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1585821957;
        bh=VWV5VVYaAJNLZ0qhNZ2vXZ3ZVuH1QjojCUmH4J7cvRM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BIAYcmrKq1LF5D5nT2gJkPD5FXCcgc658kciTx3sX+axQbjk3V2h07eqg6P3sQFtw
         WZH2du4hEAjbq6MucoA118QF1GDycOJONVlClQKdeEOwTgpwMgzHQgHoLHHY/99h8q
         NZF0h2aW+zXmsTl1aZpEs8j7uHhm8YSAZfyiNiNehPYenQ7tc3BaEQkDi/60Fu+agl
         yFbkROHRPHEafu2+ycumDNj9Sn85R4SRDp0JrhXlvEzFZRjbsIjGWgCOkWGnS8Dgxv
         KCEXJZ95U3du4XOtVJMWjWbxkddWIX/CG9xoI/0/E4gWVMxEhV/VNg7slBH7PHXuHY
         fzkz6rZ7j6Jgw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     Alastair D'Silva <alastair@d-silva.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v4 00/25] Add support for OpenCAPI Persistent Memory devices
In-Reply-To: <CAOSf1CHdpFyT_6zetKM6eHDK3AT8-UNTzjdd2y+QqYT2AO9VDw@mail.gmail.com>
References: <20200327071202.2159885-1-alastair@d-silva.org> <CAPcyv4iJYZBVhV1NW7EB6-EwETiUAy6r1iiE+F+HvFXfGZt9Aw@mail.gmail.com> <2d6901d60877$16aa7a90$43ff6fb0$@d-silva.org> <87imiituxm.fsf@mpe.ellerman.id.au> <CAOSf1CHdpFyT_6zetKM6eHDK3AT8-UNTzjdd2y+QqYT2AO9VDw@mail.gmail.com>
Date:   Thu, 02 Apr 2020 21:06:01 +1100
Message-ID: <87bloatd6e.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Oliver O'Halloran" <oohall@gmail.com> writes:
> On Thu, Apr 2, 2020 at 2:42 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> "Alastair D'Silva" <alastair@d-silva.org> writes:
>> >> -----Original Message-----
>> >> From: Dan Williams <dan.j.williams@intel.com>
>> >>
>> >> On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org>
>> >> wrote:
>> >> >
>> >> > *snip*
>> >> Are OPAL calls similar to ACPI DSMs? I.e. methods for the OS to invoke
>> >> platform firmware services? What's Skiboot?
>> >
>> > Yes, OPAL is the interface to firmware for POWER. Skiboot is the open-source (and only) implementation of OPAL.
>>
>>   https://github.com/open-power/skiboot
>>
>> In particular the tokens for calls are defined here:
>>
>>   https://github.com/open-power/skiboot/blob/master/include/opal-api.h#L220
>>
>> And you can grep for the token to find the implementation:
>>
>>   https://github.com/open-power/skiboot/blob/master/hw/npu2-opencapi.c#L2328
>
> I'm not sure I'd encourage anyone to read npu2-opencapi.c. I find it
> hard enough to follow even with access to the workbooks.

Compared to certain firmwares that run on certain other platforms it's
actually pretty readable code ;)

> There's an OPAL call API reference here:
> http://open-power.github.io/skiboot/doc/opal-api/index.html

Even better.

cheers
