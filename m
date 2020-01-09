Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D8B135179
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 03:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgAIChM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 21:37:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42988 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAIChM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 21:37:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so2583879pfz.9;
        Wed, 08 Jan 2020 18:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zb0XpDdzhr2HSaCU2kbgbQrO7aw5OHk2GOMpmnAv0rw=;
        b=ZWJ0u+DIjR48pCEpu4933sMA128ctTEGce5OoG+LclUFtc8ny1N9d9GkrQN8wz4/j9
         z/2iyrT0vHtDVeVLBYYMuu1waVJbVgQKFim5jMQMx9A1tT31eRpQtC/Fkxyry7jH62KL
         GdQW4PrfmhBdAhqWx23xs6KnKr61vAzJJTCXw8YuqeTGCNZ7F6CmXWqhE/wtmakLUVts
         EInw/HpWzWPNFHp0GHOj1mOsN2yQ2u0+i5HoJZRIDhccZQXDzeXWgiR/Feetsx0zS4NW
         K8jJOZc2SHuYyhluS0ugoN53mtgcTqb96KHHXG7NWBNExA2RCLumcwQKIsDW/5AJNoCg
         u+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zb0XpDdzhr2HSaCU2kbgbQrO7aw5OHk2GOMpmnAv0rw=;
        b=f7Ax4Y8++HKZwNIkiY3Tgk2mUc+iA2/Al5Z9WEw3/G3vcGFkgu4NdOz0TzG+r2uwp3
         LxC1bhJucucZPrsmpmU2qZ/5euU/ineD4RoAgPz4YBg+Bt+PDqxciu/04WL1m41ScdX9
         SO/f0kO/XGmIrBnfNUtuKCSry840thsuIyOTm+TyLuM2gbI5lyCf44FMQk5dnlP0vCir
         korDjsd/SFysHi0vcUsfqk3HRZkn1iD6s4X2V/N31mn9n9UgrKH/kWa+t0fYOYrAmPB6
         bndU4gsnJcIwUTH6yu26otXIQf4hVeXnapk0/NXE4gGalBiSZMeBnFhq/wXAUMB+VMUG
         wAMw==
X-Gm-Message-State: APjAAAWZGDv0IhX58QFT0inOKpOffzEq2v/yMFBEW0Ldq7UyULTY16Se
        fm8OlKcthFu9HFcExfhZoy2Z6vJI
X-Google-Smtp-Source: APXvYqzmsBDRySn86DX3ytKuvHh1LQOPcTi7GJlphbL9+4pdnS2HjV3bAw6dF8BBoqDcxlcoHQHg+g==
X-Received: by 2002:a63:2a8b:: with SMTP id q133mr8478254pgq.72.1578537431296;
        Wed, 08 Jan 2020 18:37:11 -0800 (PST)
Received: from [192.168.1.60] (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id v9sm625959pja.26.2020.01.08.18.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 18:37:10 -0800 (PST)
Subject: Re: [PATCH V2 5/7] USB: serial: f81232: Set F81534A serial port with
 RS232 mode
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
 <20190923022449.10952-6-hpeter+linux_kernel@gmail.com>
 <20191023115300.GU24768@localhost>
 <f3a8b0bd-79f7-3bef-4d07-69774c87873a@gmail.com>
 <20200108143502.GJ30908@localhost>
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <3c79f786-de34-550e-3964-d7fb334f6d56@gmail.com>
Date:   Thu, 9 Jan 2020 10:37:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200108143502.GJ30908@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Johan Hovold 於 2020/1/8 下午 10:35 寫道:
>> Yes, when 1 F81534A connect to Host, it'll report device as following.
>> 	virtual HUB
>> 		GPIO Device.
>> 		serial port 1
>> 		...
>> 		serial port n
> 
> Could you post lsusb -v output for this with a couple of UARTs enabled?

The following lsusb log is F81536 informations
2c42:1608 => HUB
2c42:16f8 => GPIO device
2c42:163x => UART (need driver enable)

*before insmod driver
Bus 002 Device 003: ID 05e3:0620 Genesys Logic, Inc.
Bus 002 Device 002: ID 05e3:0620 Genesys Logic, Inc.
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 007: ID 0603:00f2 Novatek Microelectronics Corp. Keyboard 
(Labtec Ultra Flat Keyboard)
Bus 001 Device 005: ID 046d:c05a Logitech, Inc. M90/M100 Optical Mouse
Bus 001 Device 044: ID 2c42:16f8
Bus 001 Device 043: ID 2c42:1608
Bus 001 Device 003: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
Bus 001 Device 002: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

*after insmod driver and wait for complete
Bus 002 Device 003: ID 05e3:0620 Genesys Logic, Inc.
Bus 002 Device 002: ID 05e3:0620 Genesys Logic, Inc.
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 007: ID 0603:00f2 Novatek Microelectronics Corp. Keyboard 
(Labtec Ultra Flat Keyboard)
Bus 001 Device 005: ID 046d:c05a Logitech, Inc. M90/M100 Optical Mouse
Bus 001 Device 052: ID 2c42:1636
Bus 001 Device 051: ID 2c42:1636
Bus 001 Device 050: ID 2c42:1636
Bus 001 Device 049: ID 2c42:1636
Bus 001 Device 048: ID 2c42:1636
Bus 001 Device 047: ID 2c42:1636
Bus 001 Device 046: ID 2c42:1636
Bus 001 Device 045: ID 2c42:1636
Bus 001 Device 056: ID 2c42:1636
Bus 001 Device 055: ID 2c42:1636
Bus 001 Device 054: ID 2c42:1636
Bus 001 Device 053: ID 2c42:1636
Bus 001 Device 044: ID 2c42:16f8
Bus 001 Device 043: ID 2c42:1608
Bus 001 Device 003: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
Bus 001 Device 002: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

>> The link are F81534A pin-out:
>> 	https://imgur.com/a/AZHqQ1N
> 
> Do you have a datasheet for the device?
> 
> I think I'm starting to get an idea of how this work, but I really don't
> like having to spend this much time on detective work just to understand
> how the hw works.

The following link is F81536 spec:
https://drive.google.com/drive/folders/1oA8DvpevFXoTLCDfPZHzaBWKr32ch5xc?usp=sharing

>> So we can control F81534A series all GPIO pins via GPIO Device.
>> Serial ports are also control MODE0_x,  MODE1_x,  MODE2_x
>> (e.g. UART1 MODE0_1,  MODE1_1,  MODE2_1), but when Serial ports
>> is h/w disabled (DTR pull low), the mode pin will change to GPIO pin.
> 
> So you tie a ports DTR pin, even though it's normally an output, and use
> that at boot to determine whether the UART should be enabled or not?
> 
> And the GPIO device can only control a pin if the corresponding port is
> disabled?
> 
> Can you read back the enable state of each port?

DTR pin of the F81534A series are strap pin on power on, when IC detect
it pulled to low, the UART device can't enable and DTR change to input
mode.

I can read the UART enable state from GPIO Device, so I can do when the
GPIO is associated with UART enabled, change it as output only otherwise
can be set to input/output. Is this OK ??

> What about devices using a different tranceiver? Should the state of the
> mode pins ultimately be tied to VID/PID (can your customers change
> VID/PID)?
> 

Our device VID/PID is changeable, but we assume don't change it.

-- 
With Best Regards,
Peter Hong
