Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD741928DB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 13:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCYMuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 08:50:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38217 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgCYMuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:50:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id l20so2487040wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 05:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i3Wlis1DtVgfIXNrnhG2aCoyveLssmu0qcaQ7SUr9Tc=;
        b=Pcd+LU3VwwB1mLDy6eUddgZJNE3Iu/bHzcCfsgWVDElBTU6sE3PofsWwKuATnuV4fF
         MOwyplJ5ZNH/YWtjOdmB0zmrIW6Ut+C+Tt7n+cQf5Rhr2kPp/pLc2gnB7c8ryMyOGphU
         6m+7A9Z7ro/CDi+sjWOBiKGJOFtOdAALNy9uTuC6omX4JFv7yY/diprx0H8UfnbOZ0/l
         PB4Hhhpkuwm8q2dKp8OvtW7coh95y5IMlMvH4Ri6A5ftGj98t0I9Jm7HPhLk9mdvQApI
         xWSsQjPfjidzv2m7tJlr0EtE1DJ2H3dPH1cdjPpJTpDcTnSi9HKGYExysAIDsopvy9Yw
         xiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i3Wlis1DtVgfIXNrnhG2aCoyveLssmu0qcaQ7SUr9Tc=;
        b=JhjYjQ/fnU8UfH7VYTQbvFteQbPhDLKQizQMx9OUSX4lO0XuiC5EXdEktCQ71y2EI1
         EGkSKZVVU0jWKugL9ESu79jWq90xnMR52XwCZbTE1ovxRwR5rffJ6QNEknR0WGUPBw7D
         xintStP644sOL0bYexCpj2y14ZU/qnMkPTJ2jzhEPVslhrY/NAVAu17XNMkgQBTDUyMt
         ZcJVSVeEci2o0KPeE90r/gNdAqTiGnD8RgP7S7vFG9PZoLU+Md5F9/HavT+dq5hsUUKm
         V2gQxht0iDGtwfQgxRfqz+gDS8h23Wef5ZGfXqsW7hj97wYAZdxIaDofUP2ACgA3iL6v
         zmLw==
X-Gm-Message-State: ANhLgQ2rSQf8moYZs5cG0oCXuHX2qGEZEgONZyXV0/Z3kNgSEuRzKPg8
        j3q9/3Gcu+0tHB6lQAyW2uf7rQ==
X-Google-Smtp-Source: ADFU+vvTi5JjSLaq++TK3YKQ73gtL3c467xmoNVDYiw7qIudQrs2ofhGYmZ7EiOwRz3j3NhqGJzl2g==
X-Received: by 2002:a1c:c257:: with SMTP id s84mr3498183wmf.9.1585140618607;
        Wed, 25 Mar 2020 05:50:18 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id b202sm9359825wmd.15.2020.03.25.05.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 05:50:18 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] nvmem: core: use is_bin_visible for permissions
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au
References: <20200325122116.15096-1-srinivas.kandagatla@linaro.org>
 <20200325122116.15096-3-srinivas.kandagatla@linaro.org>
 <20200325124457.GA3511062@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <72780483-ce24-849b-978a-ae013c8ace1e@linaro.org>
Date:   Wed, 25 Mar 2020 12:50:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200325124457.GA3511062@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/03/2020 12:44, Greg KH wrote:
> On Wed, Mar 25, 2020 at 12:21:16PM +0000, Srinivas Kandagatla wrote:
>> By using is_bin_visible callback to set permissions will remove a
>> large list of attribute groups. These group permissions can be
>> dynamically derived in the callback.
>>
>> Also add checks for read/write callbacks and set permissions accordingly.
>>
>> As part of this cleanup it does not make sense to have a separate
>> nvmem-sysfs.c and nvmem.h file anymore, so move all the relevant
>> data structures and functions to core.c
> 
> And because of that move, it's impossible to see the real changes made
> here :(

Yes, I agree will spit this in to two patches.

> 
> Can you do this in two steps, one do the code/logic changes, and the
> other do the "move into one file"?  That way it is actually reviewable,
> as it is, it's impossible to do so.
> 
> I'll go queue up the first patch to make the series smaller :)
thanks,
srini
> 
> thanks,
> 
> greg k-h
> 
