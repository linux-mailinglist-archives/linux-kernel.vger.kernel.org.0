Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0D50143A6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 04:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfEFCwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 May 2019 22:52:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37089 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfEFCwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 22:52:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id g3so5951451pfi.4;
        Sun, 05 May 2019 19:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CsgcPbm3Dp5JXoSh6cvFY36zj5G0VmTyOZ3CnWwDI0U=;
        b=JO3wJxv7ihXzs3bR3FH/sFfOzk3+azqzgyvUlBgXAbzXnxJ2p4TqNGLH3AUe+wHlPP
         UpDU9Sz+9FYm4VtfkJ0TQziNXcMZDhCGAk8NWRMGM91f2LlEmDBCavjTt4GMvhrCR407
         WjtXli8JR0Tzl9L577vmPz8WkVjRj/LQLoWGsNIFIx+biBxEXTar+iqgd5Neeqru5vP5
         su6S2hOhTUAqVJfI+K4/Xd30QRpy+jCpecfObGyUBtMxufZAm7iX4N51BeOiqxyMIKUY
         I83adWEKVydKz+mjXxpyh86hXy6Ofh7j1CDGLIpQOGXoVmICmb3gocaYIGA6fnftHax7
         a36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CsgcPbm3Dp5JXoSh6cvFY36zj5G0VmTyOZ3CnWwDI0U=;
        b=d+4KXWMbjvUHB1JJH3DyhNRsSaN7bMjpX3fooSn0Rcw19xy9k6kUZZu4d4Z1/4TPwG
         Gvd9VZaTblgX0M+jzIAC/NCUKgzaiqhd8gCodBsTA45V+S9DUGLXvfiEcyvgrLTk6BYh
         ycmA8u8rL4ayVHK4bkgduR6p48WlMCwml5dO5oq3bHzHAsUdyaMq3exFEL8WiIl3jKK8
         W6bAgjEnA2HRRtciByy4h00lfy5pvbTp5bbKdB+q46OtL2alOL2HVTWSr7pdtnfpkckG
         iNpEmatElKmmpXkmYzS9UscHWMmugoGiZveQSH/u5dXIDAilnYQ/eKYxNP/F9nGAPdJZ
         alyw==
X-Gm-Message-State: APjAAAXK5foP/WGNnfooDhak02KZ03EPtDG2PevzwGMZ1oc3YP6bFnbp
        wpOovSfWUcr4dMP2sx1tkR4=
X-Google-Smtp-Source: APXvYqy/Ta/53RuTG1MXgCarkn5vcAY72jk48KgAoascbD1BMXj8NzzrPpyGX4sZAu3WCC4E2NguPA==
X-Received: by 2002:a65:6205:: with SMTP id d5mr29513098pgv.61.1557111153399;
        Sun, 05 May 2019 19:52:33 -0700 (PDT)
Received: from [192.168.1.38] (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id q80sm19364518pfa.66.2019.05.05.19.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 19:52:32 -0700 (PDT)
Subject: Re: [PATCH V9 4/4] USB: serial: f81232: implement break control
To:     Johan Hovold <johan@kernel.org>
Cc:     peter_hong@fintek.com.tw, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
References: <1556587352-19500-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1556587352-19500-4-git-send-email-hpeter+linux_kernel@gmail.com>
 <20190503065917.GA26546@localhost>
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <84cff579-79bd-9456-aa85-cb4510d916ed@gmail.com>
Date:   Mon, 6 May 2019 10:52:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503065917.GA26546@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Johan Hovold 於 2019/5/3 下午 02:59 寫道:
>> @@ -519,6 +530,7 @@ static int f81232_port_disable(struct usb_serial_port *port)
>>   static void f81232_set_termios(struct tty_struct *tty,
>>   		struct usb_serial_port *port, struct ktermios *old_termios)
>>   {
>> +	struct f81232_private *priv = usb_get_serial_port_data(port);
>>   	u8 new_lcr = 0;
>>   	int status = 0;
>>   	speed_t baudrate;
>> @@ -572,11 +584,16 @@ static void f81232_set_termios(struct tty_struct *tty,
>>   		break;
>>   	}
>>   
>> +	mutex_lock(&priv->lock);
>> +
>> +	new_lcr |= (priv->shadow_lcr & UART_LCR_SBC);
>>   	status = f81232_set_register(port, LINE_CONTROL_REGISTER, new_lcr);
>>   	if (status) {
>>   		dev_err(&port->dev, "%s failed to set LCR: %d\n",
>>   			__func__, status);
>>   	}
>> +
>> +	mutex_unlock(&priv->lock);
> 
> You forgot to update shadow_lcr here so the line settings would be
> corrupted (e.g set to 5 bit words) whenever a break is signalled.
> 
> Did you not test this version of the patch?
> 
> I added the missing update, but please test the code that's in my
> usb-next branch in a minute and confirm everything works as expected.
> 

Thanks for mention and patch the lost parts. I had only tested the
break signal and forgot to test full LCR. I'll add it to my test items
and it tested well on new usb-next branch after your fix.

BTW, Should I disable break control when port close ?

Thanks.

-- 
With Best Regards,
Peter Hong
