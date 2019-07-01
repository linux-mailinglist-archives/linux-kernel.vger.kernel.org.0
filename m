Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04BAD2D848
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 10:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfE2Izn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 04:55:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38423 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfE2Izm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:55:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id g13so2550947edu.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 01:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fX+GYqlsTWpaFs0nnAGyeit/XcaHgQa5Q0k7tK90QNU=;
        b=qLCX73Twkv9fjB2+IFimyospsxUkJ9hFvNOv30PIzq5KNOWu/QkJvyr0WS0ZGuxAIK
         07a5C6vf+EMYyEPcXvpOc+BdlVhe66goS76IiMA5mc8eVUCSFAgd//Lr12r2eN68SoxZ
         7n9xIFFTvD+zqat925G23bXDtb13BYNBiitZ8eerNX5rIaD4jHtbUidTlpQxvGFKrp+c
         GJzfKP7q+/incDRXrUvejAYCenC+MUjA+YycZJXfcQepkhENmWVit2CIcEX8TS4OsMu7
         ukvP7xpgi4geg7pcNF2Z8K/8GQ5Rqx6v4DUiyCxoR1QpSz+VfisP7CAiT/6rdIIb70np
         R+tA==
X-Gm-Message-State: APjAAAVLuQTC4XCp3GMP6CLf2T3OsbjV8c0vrExNYUnDDix+Nc1TGkB1
        plftOLdhLQcH/C3Ab35IwCghgAzObXQ=
X-Google-Smtp-Source: APXvYqxIsd0gKebgKxZy88P8pBC+xSqHhMsP5gxq1oztHkmhmT95gdzySvAIESCLpa1X31IC2fdMbQ==
X-Received: by 2002:a50:b865:: with SMTP id k34mr135578096ede.16.1559120139343;
        Wed, 29 May 2019 01:55:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id g30sm4986273edg.57.2019.05.29.01.55.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 01:55:38 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: asus-wmi: Only Tell EC the OS will handle
 display hotkeys from asus_nb_wmi
To:     =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        acpi4asus-user@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190521062837.3887-1-hdegoede@redhat.com>
 <CAOcMMifdq8PcnwANKxGtAmB+5nNOv-aEW3aFJyfPNngXeYCK5A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1026f860-e961-cefe-3695-aaeaa8896597@redhat.com>
Date:   Wed, 29 May 2019 10:55:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAOcMMifdq8PcnwANKxGtAmB+5nNOv-aEW3aFJyfPNngXeYCK5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi João,

On 5/28/19 11:22 PM, João Paulo Rechi Vita wrote:
> On Mon, May 20, 2019 at 11:28 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Commit 78f3ac76d9e5 ("platform/x86: asus-wmi: Tell the EC the OS will
>> handle the display off hotkey") causes the backlight to be permanently off
>> on various EeePC laptop models using the eeepc-wmi driver (Asus EeePC
>> 1015BX, Asus EeePC 1025C).
>>
>> The asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL) call added
>> by that commit is made conditional in this commit and only enabled in
>> the quirk_entry structs in the asus-nb-wmi driver fixing the broken
>> display / backlight on various EeePC laptop models.
>>
>> Cc: João Paulo Rechi Vita <jprvita@endlessm.com>
>> Fixes: 78f3ac76d9e5 ("platform/x86: asus-wmi: Tell the EC the OS will handle the display off hotkey")
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/platform/x86/asus-nb-wmi.c | 8 ++++++++
>>   drivers/platform/x86/asus-wmi.c    | 2 +-
>>   drivers/platform/x86/asus-wmi.h    | 1 +
>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
>> index b6f2ff95c3ed..59f3a37a44d7 100644
>> --- a/drivers/platform/x86/asus-nb-wmi.c
>> +++ b/drivers/platform/x86/asus-nb-wmi.c
>> @@ -78,10 +78,12 @@ static bool asus_q500a_i8042_filter(unsigned char data, unsigned char str,
>>
>>   static struct quirk_entry quirk_asus_unknown = {
>>          .wapf = 0,
>> +       .wmi_backlight_set_devstate = true,
>>   };
>>
>>   static struct quirk_entry quirk_asus_q500a = {
>>          .i8042_filter = asus_q500a_i8042_filter,
>> +       .wmi_backlight_set_devstate = true,
>>   };
>>
>>   /*
>> @@ -92,26 +94,32 @@ static struct quirk_entry quirk_asus_q500a = {
>>   static struct quirk_entry quirk_asus_x55u = {
>>          .wapf = 4,
>>          .wmi_backlight_power = true,
>> +       .wmi_backlight_set_devstate = true,
>>          .no_display_toggle = true,
>>   };
>>
>>   static struct quirk_entry quirk_asus_wapf4 = {
>>          .wapf = 4,
>> +       .wmi_backlight_set_devstate = true,
>>   };
>>
>>   static struct quirk_entry quirk_asus_x200ca = {
>>          .wapf = 2,
>> +       .wmi_backlight_set_devstate = true,
>>   };
>>
>>   static struct quirk_entry quirk_asus_ux303ub = {
>>          .wmi_backlight_native = true,
>> +       .wmi_backlight_set_devstate = true,
>>   };
>>
>>   static struct quirk_entry quirk_asus_x550lb = {
>> +       .wmi_backlight_set_devstate = true,
>>          .xusb2pr = 0x01D9,
>>   };
>>
>>   static struct quirk_entry quirk_asus_forceals = {
>> +       .wmi_backlight_set_devstate = true,
>>          .wmi_force_als_set = true,
>>   };
>>
>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>> index ee1fa93708ec..a66e99500c12 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -2131,7 +2131,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>>                  err = asus_wmi_backlight_init(asus);
>>                  if (err && err != -ENODEV)
>>                          goto fail_backlight;
>> -       } else
>> +       } else if (asus->driver->quirks->wmi_backlight_set_devstate)
>>                  err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
>>
>>          status = wmi_install_notify_handler(asus->driver->event_guid,
>> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
>> index 6c1311f4b04d..57a79bddb286 100644
>> --- a/drivers/platform/x86/asus-wmi.h
>> +++ b/drivers/platform/x86/asus-wmi.h
>> @@ -44,6 +44,7 @@ struct quirk_entry {
>>          bool store_backlight_power;
>>          bool wmi_backlight_power;
>>          bool wmi_backlight_native;
>> +       bool wmi_backlight_set_devstate;
> 
> Wouldn't it be better to add this field to struct asus_wmi_driver
> instead, and set it in asus_nb_wmi_driver only? This way we wouldn't
> need to make sure it is present in all quirk entries from this driver,
> current and future.
> 
> I've tested both the original patch and my suggestion above and in
> both cases the "turn off backlight" hotkey continued to work fine on a
> machine where asus-nb-wmi is used (I don't have access to any machine
> using the eeepc driver).

I deliberately put in the quirks struct so that if necessary we can
enable / disable it easily on a per model (rather then per driver)
case in the future.

Regards,

Hans
