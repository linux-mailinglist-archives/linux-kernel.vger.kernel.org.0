Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAC81704F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 07:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfEHFSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 01:18:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41097 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfEHFSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 01:18:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3so5783890pgp.8;
        Tue, 07 May 2019 22:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=73FfoTOLHXtQiSt7oeshvDOGtuYdClBmA7yk/mrEiwo=;
        b=D7R0f/TocA0qPoYPVumdkrnOdVyc2ZYj2FFqPRDQVTfDUiy4cGbdyIfxTVbWdOqxro
         Jrs39xqNhB8VDcxxeTtHTtdflJeMyvSarjUqucbCCe7QaGmioHv0xSRN4jE5T2JAtnzy
         7SwqPXMAhKCoCt7YgC9TieINwi1TuAG6p8/M+egPvdI3ggu98P/hFD+0efaq2hOTFp4t
         p22yOsFSnthmXVvteAS4dWa6p4kK1XBGP7Kfq7GlZToyvpzP9CUJmFdG7U9xZVrl+2Tu
         N0KzfHypRqI2I0q56ReE2wZgfIp7sVDNiJgd0h9Sr3XLvMyrQ9VXJ5XEcX/XmrGZpTWf
         9Hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=73FfoTOLHXtQiSt7oeshvDOGtuYdClBmA7yk/mrEiwo=;
        b=H943MNORnvtlXOqrbVfj1RpyW6YxPpwHSHjT/aQ6qERRyZRrHoJJQTflY6SiORzRBp
         O7ps25yXGVwULnLAsme7vpmcFskTGJ6vIZ+cFWBp1SdO8XlMGFqIt/L2gXOObrhK76hz
         e80EuVJZjS5AD0Je0N7x/pARrvgpiCH6uW8+v4bJRPkmGrmjUOFY4m0e9cxJ3OLurTew
         m/I3e9+u0e6UjOLSzkhSKOebli6MGOQJYAAqJLkEn1Pp+BTHz+ANq6oC4g/8gLRyMkzA
         jKBZoqm9UPQaWS1VESGBaGVZ12MosF31NtFBOGAeoyrl38WLMHdd96qvXpsLItTUFiPG
         F67A==
X-Gm-Message-State: APjAAAXczi/r5/u8lWyPQ1nC1sx79EY4LDDqQkwCsh6abQfay09uhuTs
        VgX2GkLt63rUww8hda5WFnE=
X-Google-Smtp-Source: APXvYqx4i00WnVvDGs+Ho5q6HTAXAM8PqxI7Qw1ECO0zlRwXMqqFWQgJs79Tz3t5MFcbEOWYEkZHdw==
X-Received: by 2002:a63:da14:: with SMTP id c20mr29465723pgh.191.1557292731734;
        Tue, 07 May 2019 22:18:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i15sm20940804pfr.8.2019.05.07.22.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 22:18:50 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] usb: typec: tcpci: Clear the fault status register
To:     Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>
References: <20190508002749.14816-1-angus@akkea.ca>
 <20190508002749.14816-2-angus@akkea.ca>
 <aed487a4-3f7c-55e8-9c84-feaa1c7f583d@roeck-us.net>
 <3fd046562f3bea2cb85354f8d3c420fc@www.akkea.ca>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3918f78b-15ec-9204-b2fc-f371157bc29c@roeck-us.net>
Date:   Tue, 7 May 2019 22:18:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3fd046562f3bea2cb85354f8d3c420fc@www.akkea.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/19 7:49 PM, Angus Ainslie wrote:
> On 2019-05-07 20:03, Guenter Roeck wrote:
>> On 5/7/19 5:27 PM, Angus Ainslie (Purism) wrote:
>>> If the fault status register doesn't get cleared then
>>> the ptn5110 interrupt gets stuck on. As the fault register gets
>>> set everytime the ptn5110 powers on the interrupt is always stuck.
>>>
>>> Fixes: fault status register stuck
>>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>>> ---
>>>   drivers/usb/typec/tcpm/tcpci.c | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
>>> index c1f7073a56de..a5746657b190 100644
>>> --- a/drivers/usb/typec/tcpm/tcpci.c
>>> +++ b/drivers/usb/typec/tcpm/tcpci.c
>>> @@ -463,6 +463,17 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
>>>       else if (status & TCPC_ALERT_TX_FAILED)
>>>           tcpm_pd_transmit_complete(tcpci->port, TCPC_TX_FAILED);
>>>   +    if (status & TCPC_ALERT_FAULT) {
>>
>> Wait - the driver doesn't set TCPC_ALERT_FAULT in the alert mask
>> register. How can the chip report it if fault alerts are not enabled ?
> 
> Well that I didn't check. But I know this code gets executed so something must be turning it on.
> 
> Also if I don't clear it I get an unlimited number of interrupts.
> 
>> What am I missing here ?
> 
> Can the power on fault be masked ?
> 

There is a TCPC_ALERT_FAULT mask bit, so I would think so.
Can you dump register contents in the irq function and at the end of
tcpci_init() ?

Thanks,
Guenter

> Angus
> 
>>
>> Thanks,
>> Guenter
>>
>>> +        u16 fault_status;
>>> +
>>> +        tcpci_read16(tcpci, TCPC_FAULT_STATUS, &fault_status);
>>> +
>>> +        dev_warn(tcpci->dev, "FAULT ALERT status 0x%x\n", fault_status);
>>> +
>>> +        /* clear the fault status */
>>> +        tcpci_write16(tcpci, TCPC_FAULT_STATUS, fault_status);
>>> +    }
>>> +
>>>       return IRQ_HANDLED;
>>>   }
>>>   EXPORT_SYMBOL_GPL(tcpci_irq);
>>>
> 
> 

