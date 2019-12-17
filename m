Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6675A1230DA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 16:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfLQPuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 10:50:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36087 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLQPuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:50:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so3740501wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 07:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O5GODPP3Q0p560cisTVf4hlzz8+PZk1HEIIOo83zKjI=;
        b=ErX7LsT8vWeRPPKk3e/Z8kRTGYWUXoAhcEUJAF+TLakDMZicAz+bfZHwoYWZaXr6/N
         fNMEBZ0HRRlN+sEWTbtmdTnagFEeRD21jNHrL9wqIcWu3ZSxR7k1+wzXHTmsiznMkw00
         lK2ymIZ/Ul39szT/nnwTotYIdOdM2FG1lYWKrv/1yPKRpnd2oealDZpZxaU26j18KQjW
         VqnOlYBF1Zu9wVTEf0AcTTaD6fwwvEn1meVNjceK8ZYbkd9ovczNaEv4CNYv+VPpwMz/
         NekKGCgVjX3WR1OOGPbjcQXuqP9GQoYfNZFzs+Dh7UUX1zyE/PWHWMDoQOCOSIMvNffd
         uIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O5GODPP3Q0p560cisTVf4hlzz8+PZk1HEIIOo83zKjI=;
        b=VTskLzh2hvmK9xn7ep3S8NQbwn9FaPGhvB1IWuT0TAnyTm0TKrLa44JUJstnRrcU+1
         9/txJ8YX6Js+8AduQ6IhdLPOGLZ4pI3G8ygtcIoHBGkPZd5Aa2RIrGRCqpzGcBJfUQTg
         Jzp6h1ueuMQgUBbNrd+BSx8IXq+W7+n3EsvRCXoBlryAWcoXqkVzYNTBpu+dJL3djkzt
         I1kPux7Vx2nFp6vWIikAUXqkAvwNoYM9LXXGVGw07TnKb9CUegGcbUUSCgIU15cb7xc6
         qmvPW4D2+o5pcMjkYmb8W51Y8FrY4uWRSkFOBnTEw+PYOtomcySWjh/cRHwYjr369q2f
         yA9A==
X-Gm-Message-State: APjAAAU05Mt5w9fA1qbO/ht5SKpSE81Krmz8Xj5qv8rhJJkfFO2N2QWV
        keJstBqxhYalrEgIJW60cDP2Xw==
X-Google-Smtp-Source: APXvYqyL3KQslMZUtCZp1lc+/FSDTAieFKAidKYXOZf7uviRjTak0/OjQXad6Fp/k+j2otbFmfLJ+Q==
X-Received: by 2002:a7b:c1d8:: with SMTP id a24mr6329108wmj.130.1576597848708;
        Tue, 17 Dec 2019 07:50:48 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id d16sm28132770wrg.27.2019.12.17.07.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:50:47 -0800 (PST)
Subject: Re: [PATCH 54/58] serial_core: Remove SUPPORT_SYSRQ ifdeffery
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
References: <20191213000657.931618-1-dima@arista.com>
 <20191213000657.931618-55-dima@arista.com>
 <20191217142732.GA3623513@kroah.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <71f8ea90-96cc-30f1-d13c-cd9c04276c68@arista.com>
Date:   Tue, 17 Dec 2019 15:50:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191217142732.GA3623513@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 2:27 PM, Greg Kroah-Hartman wrote:
> On Fri, Dec 13, 2019 at 12:06:53AM +0000, Dmitry Safonov wrote:
>> No one defines it anymore.
>>
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>  include/linux/serial_core.h | 14 ++++----------
>>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> I've applied this series up to here, skipping the usb-serial driver
> patch that Johan called out.
> 
> Can you rebase your series and resend the remaining based on my tty-next
> tree, after these patches move there (give them 24 hours to get through
> 0-day testing.)

Thanks much, Greg, will do!

Thanks,
          Dmitry
