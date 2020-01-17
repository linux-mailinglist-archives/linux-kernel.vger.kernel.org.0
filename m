Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F7A14031D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 05:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgAQEpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 23:45:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46922 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbgAQEpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 23:45:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id z124so11017667pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 20:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MokgjokDaau9PgXyah9t7meHx+Hp5LMTUHDw4uxid9Q=;
        b=BlS6NIK15PEm+eGSVYgfuya7QskELbcfjwOh1z3Jdu1JKvJY+x77K34YboZBqXLnpu
         ukSggBDcAIlckCCzX59yCIqp51vum22WZ5LHagb2zwzDAiqTqL9TtTP8rO4fZAOdTQvD
         rbuR4N2BQf6SeOtFecPN+cI7EorQsbcIB0tOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MokgjokDaau9PgXyah9t7meHx+Hp5LMTUHDw4uxid9Q=;
        b=o+WY/S9fo0+KpP3rpDY/6uAhz4IVtBT2iLJdaKbBzxAWniXAKzJe6w08rd5471Uyf9
         48OPwbSFqYOno/rvisie9vb4Jp9o5IX8ibWEo2djkWR5ZX9ALxIz3Z+TWJ+uwwQWGp/2
         uWROiaJ9KPwh7NhLOCl5cT5AuPRuH2ZGywGVQ+ylUzdJ7fQsj4UU1OxiBSp5XVw2XO0r
         /myyVTKOLaDSaxHUpvck2pP8KT3w8B6N4pd0aJAQrv0gZCluz4kzje4oKZW5f7yn7Wiz
         ytx+bXzHUQoiyxS1ZWuQmTMFTh45zFKOARBdwZau18oFgXo23D+pjtuQKtJ7aOLg5oec
         FHvA==
X-Gm-Message-State: APjAAAXlBtbyT9IhzKww7fvlZieHRoldtcQYuet5fHOKCs0Q+lOnq8g7
        p2ZjTubQRep8tIlWL8Fqtv+93A==
X-Google-Smtp-Source: APXvYqwUdDO5bNxgzt6V8gz6Oa/ENBV9pGGLK7LI4eMh6x+tGOBXjL92+yPMhVTxDrc87pkEz8Fwyw==
X-Received: by 2002:a63:6c82:: with SMTP id h124mr43082388pgc.328.1579236301832;
        Thu, 16 Jan 2020 20:45:01 -0800 (PST)
Received: from [10.230.24.186] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id c17sm26857376pfi.104.2020.01.16.20.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 20:45:00 -0800 (PST)
Subject: Re: [PATCH v3 0/3] ata: ahci_brcm: Follow-up changes for BCM7216
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20200107183022.26224-1-f.fainelli@gmail.com>
 <d32d1c1e6f32eeed811fa00e1b5d8ca121eea70f.camel@pengutronix.de>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 mQENBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAG0MEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPokB
 xAQQAQgArgUCXJvPrRcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFrZXktdXNh
 Z2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2RpbmdAcGdw
 LmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29tLmNvbQUb
 AwAAAAMWAgEFHgEAAAAEFQgJCgAKCRCBMbXEKbxmoE4DB/9JySDRt/ArjeOHOwGA2sLR1DV6
 Mv6RuStiefNvJ14BRfMkt9EV/dBp9CsI+slwj9/ZlBotQXlAoGr4uivZvcnQ9dWDjTExXsRJ
 WcBwUlSUPYJc/kPWFnTxF8JFBNMIQSZSR2dBrDqRP0UWYJ5XaiTbVRpd8nka9BQu4QB8d/Bx
 VcEJEth3JF42LSF9DPZlyKUTHOj4l1iZ/Gy3AiP9jxN50qol9OT37adOJXGEbix8zxoCAn2W
 +grt1ickvUo95hYDxE6TSj4b8+b0N/XT5j3ds1wDd/B5ZzL9fgBjNCRzp8McBLM5tXIeTYu9
 mJ1F5OW89WvDTwUXtT19P1r+qRqKuQENBFPAG8EBCACsa+9aKnvtPjGAnO1mn1hHKUBxVML2
 C3HQaDp5iT8Q8A0ab1OS4akj75P8iXYfZOMVA0Lt65taiFtiPT7pOZ/yc/5WbKhsPE9dwysr
 vHjHL2gP4q5vZV/RJduwzx8v9KrMZsVZlKbvcvUvgZmjG9gjPSLssTFhJfa7lhUtowFof0fA
 q3Zy+vsy5OtEe1xs5kiahdPb2DZSegXW7DFg15GFlj+VG9WSRjSUOKk+4PCDdKl8cy0LJs+r
 W4CzBB2ARsfNGwRfAJHU4Xeki4a3gje1ISEf+TVxqqLQGWqNsZQ6SS7jjELaB/VlTbrsUEGR
 1XfIn/sqeskSeQwJiFLeQgj3ABEBAAGJAkEEGAECASsFAlPAG8IFGwwAAADAXSAEGQEIAAYF
 AlPAG8EACgkQk2AGqJgvD1UNFQgAlpN5/qGxQARKeUYOkL7KYvZFl3MAnH2VeNTiGFoVzKHO
 e7LIwmp3eZ6GYvGyoNG8cOKrIPvXDYGdzzfwxVnDSnAE92dv+H05yanSUv/2HBIZa/LhrPmV
 hXKgD27XhQjOHRg0a7qOvSKx38skBsderAnBZazfLw9OukSnrxXqW/5pe3mBHTeUkQC8hHUD
 Cngkn95nnLXaBAhKnRfzFqX1iGENYRH3Zgtis7ZvodzZLfWUC6nN8LDyWZmw/U9HPUaYX8qY
 MP0n039vwh6GFZCqsFCMyOfYrZeS83vkecAwcoVh8dlHdke0rnZk/VytXtMe1u2uc9dUOr68
 7hA+Z0L5IQAKCRCBMbXEKbxmoLoHCACXeRGHuijOmOkbyOk7x6fkIG1OXcb46kokr2ptDLN0
 Ky4nQrWp7XBk9ls/9j5W2apKCcTEHONK2312uMUEryWI9BlqWnawyVL1LtyxLLpwwsXVq5m5
 sBkSqma2ldqBu2BHXZg6jntF5vzcXkqG3DCJZ2hOldFPH+czRwe2OOsiY42E/w7NUyaN6b8H
 rw1j77+q3QXldOw/bON361EusWHdbhcRwu3WWFiY2ZslH+Xr69VtYAoMC1xtDxIvZ96ps9ZX
 pUPJUqHJr8QSrTG1/zioQH7j/4iMJ07MMPeQNkmj4kGQOdTcsFfDhYLDdCE5dj5WeE6fYRxE
 Q3up0ArDSP1L
Message-ID: <33d3589b-accf-04c2-5527-5a0f9c632d0b@broadcom.com>
Date:   Thu, 16 Jan 2020 20:44:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d32d1c1e6f32eeed811fa00e1b5d8ca121eea70f.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/2020 1:25 AM, Philipp Zabel wrote:
> Hi Florian,
> 
> On Tue, 2020-01-07 at 10:30 -0800, Florian Fainelli wrote:
>> Hi Jens, Philipp,
>>
>> These three patches are a follow-up to my previous series titled: ata:
>> ahci_brcm: Fixes and new device support.
>>
>> After submitting the BCM7216 RESCAL reset driver, Philipp the reset
>> controller maintained indicated that the reset line should be self
>> de-asserting and so reset_control_reset() should be used instead.
>>
>> These three patches update the driver in that regard. It would be great if
>> you could apply those and get them queued up for 5.6 since they are
>> directly related to the previous series.
>>
>> Changes in v3:
>> - introduced a preliminary patch making use of the proper reset control
>>   API in order to manage the optional reset controller line
>> - updated patches after introducing that preliminary patch
> 
> The third patch could be simplified by storing the rescal reset control
> in a separate struct member and relying on the optional reset control
> API more. This is just a suggestion though, the series looks fine as-is.
> 
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks! Jens is that good for you?
-- 
Florian
