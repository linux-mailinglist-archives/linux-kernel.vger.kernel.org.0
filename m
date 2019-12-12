Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215C311CD59
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 13:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfLLMiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 07:38:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28111 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729092AbfLLMiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576154324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HjG13pQnC6z3lipnj2OvOm4bGvR+32WxaKc1DUtleSc=;
        b=O9o4h16DubQc8yT7OjnZbMOS4BPZAUsk2fEdMLTmfPdECdTfr+tnDbiLa1XoDM65y1mkD9
        GL6SYLRC79106CrATCQJe12MNKoAbxco5yP01XGaCTKrzpbYXyeKLFuqeVygMQnNWiSi8E
        1EdP9lThpA0gyHG00gClSMNabQLt+MM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-N9zt1eF6ND-eaFJKNOkRlQ-1; Thu, 12 Dec 2019 07:38:43 -0500
X-MC-Unique: N9zt1eF6ND-eaFJKNOkRlQ-1
Received: by mail-wr1-f70.google.com with SMTP id o6so974035wrp.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 04:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HjG13pQnC6z3lipnj2OvOm4bGvR+32WxaKc1DUtleSc=;
        b=gMeg873wPRIgM42fkO0P7QPYnSK+f0o1xspPay9fbuKHWHyawEvaN3WqttPl6XaJ9o
         v23JPyyFhMERvedS11FhrwXQr6nlqeySvp8ozL6INlWzCn7h0FcdBNSFnUKrLDreRngW
         dDz7l0N57Gm+eJnbNHHSCgV/c2KgZOojw3EggZPsLYJ8wGkAd+WMeekQNymxCxjjfUnf
         GNJuT8KBel4m154kUOi8gYTfmqG6sNY7RQSwxrOntuT/h3KXCk7I6C0r75CMKu8yHl6N
         LB8QGLEX2McVs2/YVEIgBwPs5YcHQG2Zus7uPFh7HDCvdug3lPH9/o41dz/EYjckcTtR
         dUfg==
X-Gm-Message-State: APjAAAXE9C6d/bFSzvHfdEgyJh9xvOT2TxyKkaDzJZ9de2TWXFKk/kJ2
        IMf3cMxLS4BDCD0ANM49IKwYxsYeINNu2tWbktGGSVAA91mxDcH633zonC+DbB81FVokYmflqoW
        yLUVfEMww/2seOWxAJB3bHuIn
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr6672466wml.56.1576154321536;
        Thu, 12 Dec 2019 04:38:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqwwdmZoRBXRAhpV+I2D00L1wp6fAuTvagscxFEYVkPI+ZSRTzsiKfEn/1uAXKqpUma+stMrcA==
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr6672437wml.56.1576154321316;
        Thu, 12 Dec 2019 04:38:41 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id x6sm6440761wmi.44.2019.12.12.04.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 04:38:40 -0800 (PST)
Subject: Re: [PATCH 5.5 regression fix 2/2] efi/libstub/helper: Initialize
 pointer variables to zero for mixed mode
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
References: <20191212103158.4958-1-hdegoede@redhat.com>
 <20191212103158.4958-3-hdegoede@redhat.com>
 <CAKv+Gu9AjYVvLot9+enuwSWfyfzqgCWSuW3ioccm3FJ7KFA8eA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9c5e89d7-7971-a0b4-fa56-fe4832007ca6@redhat.com>
Date:   Thu, 12 Dec 2019 13:38:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9AjYVvLot9+enuwSWfyfzqgCWSuW3ioccm3FJ7KFA8eA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12-12-2019 12:29, Ard Biesheuvel wrote:
> On Thu, 12 Dec 2019 at 11:32, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> When running in EFI mixed mode (running a 64 bit kernel on 32 bit EFI
>> firmware), we _must_ initialize any pointers which are returned by
>> reference by an EFI call to NULL before making the EFI call.
>>
>> In mixed mode pointers are 64 bit, but when running on a 32 bit firmware,
>> EFI calls which return a pointer value by reference only fill the lower
>> 32 bits of the passed pointer, leaving the upper 32 bits uninitialized
>> unless we explicitly set them to 0 before the call.
>>
>> We have had this bug in the efi-stub-helper.c file reading code for
>> a while now, but this has likely not been noticed sofar because
>> this code only gets triggered when LILO style file=... arguments are
>> present on the kernel cmdline.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/firmware/efi/libstub/efi-stub-helper.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
>> index e02579907f2e..6ca7d86743af 100644
>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
>> @@ -365,7 +365,7 @@ static efi_status_t efi_file_size(efi_system_table_t *sys_table_arg, void *__fh,
>>                                    u64 *file_sz)
>>   {
>>          efi_file_handle_t *h, *fh = __fh;
> 
> What about h? Doesn't it suffer from the same problem?
> 
>> -       efi_file_info_t *info;
>> +       efi_file_info_t *info = NULL;
>>          efi_status_t status;
>>          efi_guid_t info_guid = EFI_FILE_INFO_ID;
>>          unsigned long info_sz;
> 
> And info_sz?

You are right in both cases. I only checked allocate_pool and locate_protocol callers as those
are the usual suspects.

Shall I send a v2 of just this patch, or of the entire series, or are you going to
fix this up?

Regards,

Hans


> 
> 
>> @@ -527,7 +527,7 @@ efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
>>                                    unsigned long *load_addr,
>>                                    unsigned long *load_size)
>>   {
>> -       struct file_info *files;
>> +       struct file_info *files = NULL;
>>          unsigned long file_addr;
>>          u64 file_size_total;
>>          efi_file_handle_t *fh = NULL;
>> --
>> 2.23.0
>>
> 

