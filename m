Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3697B136241
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 22:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgAIVLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 16:11:13 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:46103 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgAIVLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:11:12 -0500
Received: by mail-il1-f193.google.com with SMTP id t17so14772ilm.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 13:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zUBCQgWCCDUWNqjQ7e1ylH7IPRFbX2pIzRfeEunoVEY=;
        b=L2kCzDh3dtI7ByfJ+Iyp+44RV906xEr1b+3KPgGEkqJtCEI/xroyx7duBdJojo9/Fd
         cr36W7zQ7FGIGsbtUwAw2WvYeazIHP+droT6lJ0YI0OR6e8OC73rwYTFF8dJ51oW/HaI
         8Wfy9G5R/bx2U7Nq3Te177yd8asTvo7hOvKTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zUBCQgWCCDUWNqjQ7e1ylH7IPRFbX2pIzRfeEunoVEY=;
        b=reX5POvUzJ/NFPxAxMi6R9BQA9wvX2w29aGQJzBIu3BT8nfgBqiVmd4DIuAN2bHD8A
         ib0q3cQenhH44A8RTtdDaVPB537fBRZoBLM2PKXOyEsaZXUeGjOfz8X3iJ/tu/T1OMBJ
         ysq/Q/gGLHV/geeOCb5CRp1VddRO1LpmKQAm2qXhHG+O+5d9Hk0d3ALCcRT7/JG1W5NK
         WP3nMmnfyxgjeF0wcJvUsmCRYEhp1kRqcpDzvKFgYQ8vGmnFt9WnCkePTO9W0p4J8m4S
         uqAFjJ4GRpeglZ6KgxZTXky+SG0TBvVrWmuhY7HMTKiBQauYX+ZARHp5TlD/kGFqCQoA
         A3nA==
X-Gm-Message-State: APjAAAWnZfIFU9pEpPMnxROw8ZCbBHKtyjXRYs+UCmhagfuJhsHfYF01
        C4Y55dGIj7Qp1W2AEOvXdRIW4w==
X-Google-Smtp-Source: APXvYqx+Vv0BDkJHQMk0Fxpfbbmx5UNiMe5sZssdqg1YaQYc8XzOg++Eh2pJU6po+Oo39/eYa6/Wxg==
X-Received: by 2002:a92:5cc9:: with SMTP id d70mr10329698ilg.210.1578604271855;
        Thu, 09 Jan 2020 13:11:11 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o12sm9635ilo.24.2020.01.09.13.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 13:11:11 -0800 (PST)
Subject: Re: [PATCH 1/1] media: dvb_dummy_tuner: implement driver skeleton
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, mchehab@kernel.org,
        sean@mess.org, tglx@linutronix.de, gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200109152408.919325-1-dwlsalmeida@gmail.com>
 <20200109152408.919325-2-dwlsalmeida@gmail.com>
 <5f296977-6aac-cfd9-9082-ff824f85ab43@linuxfoundation.org>
 <ebec2bb5-8db0-76fe-9c66-0316c1800f7c@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <adb61fd6-fc05-173d-9795-9ef36c4882b3@linuxfoundation.org>
Date:   Thu, 9 Jan 2020 14:11:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ebec2bb5-8db0-76fe-9c66-0316c1800f7c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/20 2:00 PM, Daniel W. S. Almeida wrote:
> Hi Shuah, thank you for you input!
> 
> 
>>
>> Looks like there is more code to be added to register/unregister 
> 
> Just to be clear, attach() is missing, but register / unregister belong 
> in the bridge driver. Is this correct?
> 
> 

Right attach/detach is what I was thinking.

>>
>> Please add more detail here on what this driver does. What this
>> driver is used for and so on.
>>
>>
>> Samehere. Give more details on what this driver does. Add enough detail
>> to help users decide why they should enable it or not.
>> General practice is the following.
>>
>> Copyright (c) 2020 Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> 
>> Please add details about the driver similar to the .c file. 
> 
> OK.
> 

thanks,
-- Shuah
