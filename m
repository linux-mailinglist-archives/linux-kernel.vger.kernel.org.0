Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E86A785429
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 21:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389017AbfHGT6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 15:58:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36168 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388425AbfHGT6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 15:58:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so87655056edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 12:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HU7ZgkstmXZP1bAHun5iB3PdzAkgzhK4YGaHvCnORo0=;
        b=FF8B0w3oglIOWDhXv1N3b6J6KYKw3vOq82StQrnIEIe1VFa5gVPTspR3cvTh+29OEN
         iS/OetC/ym8ECBvnucMgS84HwksIA1E2YMmuSReKSKRfN9Jmsnkvmja4Ue7xhGF+gIGZ
         TXVJBxJZD6uRxxnW9F5PsiuOcdIeZI/wIRCZis2LG5asBK6HhE/90orEHkpZqeNJeJVa
         6etzowpiAKSHnDDjs6qM8j4qDqNyjRNMcqkx74TOcStxisPpZv9P0OAHqV5x6bAsmrgp
         mzMr1co2vErK4yvWxC3GPrGDeNIV7mj0xqD8JoSuesZpTsDKmdTxaJCn92aZiDaXgzxZ
         zyEA==
X-Gm-Message-State: APjAAAXXlst6QktaJkDj+/pSuWNIw+kgSjOfje0VNgvKbzih51ZudS5P
        D83jxzhHEtHh3uNI4BexuVR5LA==
X-Google-Smtp-Source: APXvYqyrI+O0kxkz8UkieQzHDZdFhyl7HTtnqiQ32GRTWADtrOA3f80HZQuuwKxWab8Dq8XCx5IRlg==
X-Received: by 2002:a17:906:cd1f:: with SMTP id oz31mr9993124ejb.226.1565207893898;
        Wed, 07 Aug 2019 12:58:13 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id i6sm21515015eda.79.2019.08.07.12.58.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 12:58:13 -0700 (PDT)
Subject: Re: 5.3 boot regression caused by 5.3 TPM changes
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <b20dd437-790a-aad9-0515-061751d46e53@redhat.com>
 <CAKv+Gu8p47SHEtTHQu_3agQJDH2yYjQJ5xUvE+oTiLaY=sZdUA@mail.gmail.com>
 <ff73efc3-1951-2982-3ddf-e77005c5fddb@redhat.com>
 <CAKv+Gu9nEM5D877YD+N8tSN0sON6rR3f+Tc-9bg5u==+9Q2meA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <36a0d34b-bebe-009b-c67e-88005376b983@redhat.com>
Date:   Wed, 7 Aug 2019 21:58:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9nEM5D877YD+N8tSN0sON6rR3f+Tc-9bg5u==+9Q2meA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05-08-19 18:01, Ard Biesheuvel wrote:
> On Sun, 4 Aug 2019 at 19:12, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 04-08-19 17:33, Ard Biesheuvel wrote:
>>> Hi Hans,
>>>
>>> On Sun, 4 Aug 2019 at 13:00, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi All,
>>>>
>>>> While testing 5.3-rc2 on an Irbis TW90 Intel Cherry Trail based
>>>> tablet I noticed that it does not boot on this device.
>>>>
>>>> A git bisect points to commit 166a2809d65b ("tpm: Don't duplicate
>>>> events from the final event log in the TCG2 log")
>>>>
>>>> And I can confirm that reverting just that single commit makes
>>>> the TW90 boot again.
>>>>
>>>> This machine uses AptIO firmware with base component versions
>>>> of: UEFI 2.4 PI 1.3. I've tried to reproduce the problem on
>>>> a Teclast X80 Pro which is also CHT based and also uses AptIO
>>>> firmware with the same base components. But it does not reproduce
>>>> there. Neither does the problem reproduce on a CHT tablet using
>>>> InsideH20 based firmware.
>>>>
>>>> Note that these devices have a software/firmware TPM-2.0
>>>> implementation, they do not have an actual TPM chip.
>>>>
>>>> Comparing TPM firmware setting between the 2 AptIO based
>>>> tablets the settings are identical, but the troublesome
>>>> TW90 does have some more setting then the X80, it has
>>>> the following settings which are not shown on the X80:
>>>>
>>>> Active PCR banks:           SHA-1         (read only)
>>>> Available PCR banks:        SHA-1,SHA256  (read only)
>>>> TPM2.0 UEFI SPEC version:   TCG_2         (other possible setting: TCG_1_2
>>>> Physical Presence SPEC ver: 1.2           (other possible setting: 1.3)
>>>>
>>>> I have the feeling that at least the first 2 indicate that
>>>> the previous win10 installation has actually used the
>>>> TPM, where as on the X80 the TPM is uninitialized.
>>>> Note this is just a hunch I could be completely wrong.
>>>>
>>>> I would be happy to run any commands to try and debug this
>>>> or to build a kernel with some patches to gather more info.
>>>>
>>>> Note any kernel patches to printk some debug stuff need
>>>> to be based on 5.3 with 166a2809d65b reverted, without that
>>>> reverted the device will not boot, and thus I cannot collect
>>>> logs without it reverted.
>>>>
>>>
>>> Are you booting a 64-bit kernel on 32-bit firmware?
>>
>> Yes you are right, I must say that this is somewhat surprising
>> most Cherry Trail devices do use 64 bit firmware (where as Bay Trail
>> typically uses 32 bit). But I just checked efibootmgr output and it
>> says it is booting: \EFI\FEDORA\SHIMIA32.EFI so yeah 32 bit firmware.
>>
>> Recent Fedora releases take care of this so seamlessly I did not
>> even realize...
>>
> 
> OK, so we'll have to find out how this patch affects 64-bit code
> running on 32-bit firmware.

I was not sure this really is a 32 bit firmware issue, as I believed
I saw 5.3 running fine on other 32 bit firmware devices, so I tried
this on another device with 32 bit UEFI and you're right this is a
32 bit issue.

> The only EFI call in that patch is
> get_config_table(), which is not actually a EFI boot service call but
> a EFI stub helper that parses the config table array in the EFI system
> table.

Well get_efi_config_table() is a new function in 5.3, introduced
specifically for the 166a2809d65b ("tpm: Don't duplicate events from the
final event log in the TCG2 log") commit.

It was introduced in commit 82d736ac56d7 ("Abstract out support for
locating an EFI config table") and after taking a good look at this
commit I'm pretty confident to say that the new get_efi_config_table()
function is the problem, as it is broken in multiple ways.

In itself the new get_efi_config_table() is just factoring out some
code used in drivers/firmware/efi/libstub/fdt.c into a new helper
for reuse and not making any functional changes to the factored out
code.

The problem is that the old code which it factors out contains a number
of assumptions which are true in the get_fdt() context from which it
was called but are not true when used in more generic code as is done
from the 166a2809d65b ("tpm: Don't duplicate events from the
final event log in the TCG2 log") commit.

There are 2 problems with the new get_efi_config_table() function:

1) sys_table->tables contains a physical address, we cannot just
cast that to a pointer and deref it, it needs to be early_memremap-ed
and then we deref the mapping. I'm somewhat amazed that this works
at all for the 64 bit case, but apparently it does.

2) sys_table->tables points to either an array of either
efi_config_table_64_t structd or an array of efi_config_table_32_t
structs.  efi_config_table_t is a generic type for storing information
when parsing it should NOT be used for reading the actual tables
as they come from the firmware when parsing! Now efi_config_table_t
happens to be an exact match for efi_config_table_64_t when building
an x86_64 kernel, so this happens to work for the 64 bit firmware case.

The properway to deal with this would be to use the existing
efi_config_parse_tables() functionality from drivers/firmware/efi/efi.c
by adding entry for the LINUX_EFI_TPM_FINAL_LOG_GUID to the
common_tables[] array in drivers/firmware/efi/efi.c and make that
entry store the table address (if found) in a new efi.final_log
member.

I'm not sure how important this functionality is to have in 5.3.

I will try to come up with a fix for this using efi_config_parse_tables()
but it might be better to just revert for 5.3 .

Regards,

Hans

