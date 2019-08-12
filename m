Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0381E8977D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 09:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfHLHDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 03:03:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37440 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfHLHDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:03:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so10786829wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=y1+mXhJUTJgr8gTIPY1u76OpE07CstUIWpVpL4Le1Yo=;
        b=NMdElydd7+7AI99qFFpAF0VqH6rAIONU9OJGbykzAn4lEblUrGn6MVnk60/s2PKd25
         kw7Stparf8eTOB/oNWDwHKudzgT8b7I+/PjB5FcI2ZlPGjd4TciXuENRT0UszwCMhtjy
         gxKLTybMSVmO1KrOZjHMc+3yJmt3Dbj0qZOMdG70mDl8JmOCnZxS473Uj4Yts0xQRkk2
         jvElfdGRkcA0vcSgTCLYJdYyBaVZNR/ajE4zwbKhBiAKqv/h/K8+owfcLKFEa5oi6lWj
         7Xv5rNSEGcY6BFxSUMibivkN0CTDucQeatZ8h9c1O3pCDh6uMvdU8Pacdb2lEipYg/TI
         7IMw==
X-Gm-Message-State: APjAAAWhg3SKsQwEhipwCpczKFABj4GscrUisAIIVNCnlhWGyqjiM8MN
        NifNDeXCE71odyaa2tfkhYc=
X-Google-Smtp-Source: APXvYqwn4WtwSOl/st4NkiKcRqyNv7HjLcws2bNazhvYZnZd7KNPlLtPiBtzO9zg+gW0XaAwGFgYTA==
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr17429735wmn.61.1565593419385;
        Mon, 12 Aug 2019 00:03:39 -0700 (PDT)
Received: from [192.168.1.12] (adsl-dyn53.78-98-69.t-com.sk. [78.98.69.53])
        by smtp.gmail.com with ESMTPSA id r15sm110401477wrj.68.2019.08.12.00.03.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 00:03:38 -0700 (PDT)
Subject: Re: [PATCH] x86/apic: Handle missing global clockevent gracefully
To:     Daniel Drake <drake@endlessm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com>
 <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com>
 <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de>
 <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
 <alpine.DEB.2.21.1908011011250.1788@nanos.tec.linutronix.de>
 <81666b28-d029-56c3-8978-90abc219d1b7@linux.intel.com>
 <alpine.DEB.2.21.1908011054210.1965@nanos.tec.linutronix.de>
 <3d14b0cc-3cca-1874-3521-4ee2ec52141d@amd.com>
 <alpine.DEB.2.21.1908082235590.2882@nanos.tec.linutronix.de>
 <5bf28ba4-b7c1-51de-88ae-feebae2a28db@amd.com>
 <alpine.DEB.2.21.1908082306220.2882@nanos.tec.linutronix.de>
 <75e59ac6-5165-bd0a-aec9-be16d662ece9@amd.com>
 <alpine.DEB.2.21.1908091443030.21433@nanos.tec.linutronix.de>
 <CAD8Lp46FgT6yoW9a4Yt8t=bVWzZbYHjw-Dqdk6Pvd2xzxfGHLQ@mail.gmail.com>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3ca04aaf-c67a-d449-dac9-0fe5bc431009@suse.cz>
Date:   Mon, 12 Aug 2019 09:03:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD8Lp46FgT6yoW9a4Yt8t=bVWzZbYHjw-Dqdk6Pvd2xzxfGHLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 08. 19, 8:16, Daniel Drake wrote:
> On Fri, Aug 9, 2019 at 8:54 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Some newer machines do not advertise legacy timers. The kernel can handle
>> that situation if the TSC and the CPU frequency are enumerated by CPUID or
>> MSRs and the CPU supports TSC deadline timer. If the CPU does not support
>> TSC deadline timer the local APIC timer frequency has to be known as well.
>>
>> Some Ryzens machines do not advertize legacy timers, but there is no
>> reliable way to determine the bus frequency which feeds the local APIC
>> timer when the machine allows overclocking of that frequency.
>>
>> As there is no legacy timer the local APIC timer calibration crashes due to
>> a NULL pointer dereference when accessing the not installed global clock
>> event device.
>>
>> Switch the calibration loop to a non interrupt based one, which polls
>> either TSC (frequency known) or jiffies. The latter requires a global
>> clockevent. As the machines which do not have a global clockevent installed
>> have a known TSC frequency this is a non issue. For older machines where
>> TSC frequency is not known, there is no known case where the legacy timers
>> do not exist as that would have been reported long ago.
> 
> This solves the problem I described in the thread:
>     setup_boot_APIC_clock() NULL dereference during early boot on
> reduced hardware platforms

So it does for the openSUSE user:
http://bugzilla.opensuse.org/show_bug.cgi?id=1142926#c12

=========
After installing that build of the kernel from your OBS home project,
that did
more than just fix the issue with the APIC timer screwing up. I now have
all 4
cores/8 threads available.

I do see some errors from the ACPI layer that do indicate that there are
some
areas of the BIOS from HP that are buggy, but at this time, the machine
seems
to be working without issue.
=========

dmesg here:
http://bugzilla.opensuse.org/attachment.cgi?id=813577

thanks,
-- 
js
suse labs
