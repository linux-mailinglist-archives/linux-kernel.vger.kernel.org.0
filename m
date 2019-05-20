Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03F2623BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 17:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389759AbfETPH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 11:07:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38797 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733123AbfETPH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:07:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id t5so12066065wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 08:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3FCkJMun06bDUVWTAvV42COQZNf02FQ8u62uqqJiOUg=;
        b=EzqGCTeHr1mxFc/IIH/eDfjStg8gyhuoN7DpS3KC+9YyD2U5qUFrxigfAPSw4xCK0n
         MbFMfVEOChtVmivqDSSSqSdBP3ZUHRXbQeZnffYrr5TFW05A/RTwj9wSOys1oOBiK7Kn
         756EffHkeyW9iNA3rer9/kTbd0tCHUioS2XLz87ZX+N064+Xf6rkHhwy8KE+y7oEyesr
         R97BQK76VTBbxwl9u0OZEWgkWPOIjjyLF6bYkoAnCkgPenv0vd90n2fkKE9bJX83L0y0
         m+h207nWDlglAG/p4vFzjhXcwihCxdRteNjfqS7l6EO1UZGbWL8o8my6Nr28LXx0tks9
         MGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3FCkJMun06bDUVWTAvV42COQZNf02FQ8u62uqqJiOUg=;
        b=DNwpd9JYwPSQq9AQIZfuAuou4VFZwuZR5vrHeCbrqHEnacDoaiSTCDiq/WMgT7hhEE
         YgI0tpjU0k9m5yELTNLV/3wfkjfDGatEUXUaWJZQi72S4gKz1iPIRkkyxadckihnX1Pc
         1wmsfVr2QTpqlqu/tN/ryUpHq6UA0XVaczaIaj0fVweox1XISmWR3kdGve9+wb4XKu3F
         56X6opq/TWfR5I7cGJXSxlJFmEl9W5t6EnGwU+yjBo9BjAcIomtXoZqaGJV7gRWSg8gs
         0cvGximzEWGLTnqAtlPkJyQ9dmXjZ66MpxdQY0+uc3H6ytg6NTlP2DEkqW+k2hElUx99
         OsNA==
X-Gm-Message-State: APjAAAWOlfxdKayGB1qm3jmwjvaY/LGwluAi6+flKE0WpJl/te9Q2u0f
        IfKu5jnjB6GQk7ltTw3v4k6xXQ==
X-Google-Smtp-Source: APXvYqzjhtWs2ECOpc6DH3Regf74W/w90rqJ9sdZ9gYa3j955AR0Pgj0HE8TQfallTTr07Ejd0Hg2Q==
X-Received: by 2002:a1c:f10f:: with SMTP id p15mr9221577wmh.150.1558364873726;
        Mon, 20 May 2019 08:07:53 -0700 (PDT)
Received: from [192.168.1.7] (139.red-79-146-81.dynamicip.rima-tde.net. [79.146.81.139])
        by smtp.gmail.com with ESMTPSA id l12sm16472733wmj.0.2019.05.20.08.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 08:07:53 -0700 (PDT)
Subject: Re: [PATCH] tty: serial: msm_serial: Fix XON/XOFF
To:     Stephen Boyd <sboyd@kernel.org>, agross@kernel.org,
        david.brown@linaro.org, gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, khasim.mohammed@linaro.org,
        agsumit@qti.qualcomm.com
References: <20190520103435.30850-1-jorge.ramirez-ortiz@linaro.org>
 <20190520145110.7BDAE21721@mail.kernel.org>
 <254704a2-ee20-30cd-8362-6e1bd23ec090@linaro.org>
 <f0c89b84-7c3d-596d-06e1-cb5172e62970@linaro.org>
 <20190520150320.5DBC520856@mail.kernel.org>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <c728b454-1aa5-da93-8ed7-f6e4ad75fc4a@linaro.org>
Date:   Mon, 20 May 2019 17:07:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190520150320.5DBC520856@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/19 17:03, Stephen Boyd wrote:
> Quoting Jorge Ramirez (2019-05-20 07:58:54)
>> On 5/20/19 16:56, Jorge Ramirez wrote:
>>>
>>> yeah, semantically confusing msm_reset_dm_count is what really matters:
>>> it tells the hardware to only take n bytes (in this case only one) so
>>> the others will be ignored
>>
>> um after I said this, maybe iowrite32_rep should only be applied to
>> uartdm ... what do you think?
>>
> 
> Probably. The uartdm hardware typically required words everywhere while
> the pre-dm hardware didn't. It's an if condition so it should be OK.
> 
> It may be time to remove non-uartdm support from this driver
> all-together. From what I recall the only devices that are upstream are
> the uartdm ones, so it may be easier to just remove the legacy stuff
> that nobody has tested in many years.
> 
> 

should this be merged before removing the non-uartdm support or after?

I also have some other changes - in particular with respect to the usage
of fifosize which according to the documentation is in words not in bytes.


