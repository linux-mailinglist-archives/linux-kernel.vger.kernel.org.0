Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D102A16621E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 17:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBTQRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 11:17:53 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41426 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgBTQRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:17:52 -0500
Received: by mail-il1-f195.google.com with SMTP id f10so24131672ils.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S6c3vvGnAQCFbq0z7gY3aH6Fvr1DudHmzBNuUcIuv/k=;
        b=iRRWhBa5J4r8uI3vZYQaQMzREfw4F/XbBcmquVcEEyCeuA0UO2IzbTPuAwuwx1HfVC
         6UrWkNWxIrpmQZ2IAgtufUZ/YyaHipT7W4TBop0jszHaqhck3z/si3xuYLWq8oy7ktXn
         01ox6wwyr7hMMdbhdbMfpf2FMtDRMDMtBnrjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S6c3vvGnAQCFbq0z7gY3aH6Fvr1DudHmzBNuUcIuv/k=;
        b=lf028SOMTnhJzeX52LdTz4XhulZEsdND398/nCIcGY/9KZ+slO35EUsy29QoK58GnB
         4kJ4IrCBXUwjKDqRTEXv7tIvVbYO9cvjqc5EZDQB8GG80oY/aFlBolxdzaH8+RExHr8z
         ml1A7E5OczsDcanlj+PkAxNG+CLVV2rfYEdVJ2p+8FZXnLkyKj5rEULDFD6uH9Z9yVVi
         UQibJkkjon4K9b6UgXVpSvh9lKWfmPkY9HyGe8+1ySPThnbeemCVloLNbRMaNVeQWNed
         WK97ZVeNVgoI5osfv7SxWaGJaqcmJzKZQcr+kaO4kb+Zvrg+xjd/blAkq8gX6waR/EUT
         8JEg==
X-Gm-Message-State: APjAAAVOlYmQyAus13bd0SKfYzo1B9qMCPFTqP2ch4WpMkS2kdHvcAs2
        ojUfe2L2UBNzOY5JW3DZgeY4TA==
X-Google-Smtp-Source: APXvYqxfYZRVH3oAiZbI2ULvlZjxw0Hyo+9sCQttMMImqs7IETmH4LkX+X4+qRmQfGTJ7TnUAUcwIg==
X-Received: by 2002:a92:5acd:: with SMTP id b74mr30381503ilg.240.1582215471931;
        Thu, 20 Feb 2020 08:17:51 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 16sm822789ioe.84.2020.02.20.08.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 08:17:51 -0800 (PST)
Subject: Re: [PATCH] selftests/rseq: Fix out-of-tree compilation
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20200220113748.15990-1-mpe@ellerman.id.au>
 <763647628.2256.1582215383750.JavaMail.zimbra@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5c55d7c0-ba0c-8bb8-60c0-203dfaaf1d2b@linuxfoundation.org>
Date:   Thu, 20 Feb 2020 09:17:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <763647628.2256.1582215383750.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/20 9:16 AM, Mathieu Desnoyers wrote:
> ----- On Feb 20, 2020, at 6:37 AM, Michael Ellerman mpe@ellerman.id.au wrote:
> 
>> Currently if you build with O=... the rseq tests don't build:
>>
>>   $ make O=$PWD/output -C tools/testing/selftests/ TARGETS=rseq
>>   make: Entering directory '/linux/tools/testing/selftests'
>>   ...
>>   make[1]: Entering directory '/linux/tools/testing/selftests/rseq'
>>   gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./  -shared
>>   -fPIC rseq.c -lpthread -o /linux/output/rseq/librseq.so
>>   gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./
>>   basic_test.c -lpthread -lrseq -o /linux/output/rseq/basic_test
>>   /usr/bin/ld: cannot find -lrseq
>>   collect2: error: ld returned 1 exit status
>>
>> This is because the library search path points to the source
>> directory, not the output.
>>
>> We can fix it by changing the library search path to $(OUTPUT).
> 
> Good catch!
> 
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Shuah, can you pick this up please ?
> 

I applied it to linux-kselftest fixes just a little while ago.
I will send this in for rc4.

thanks,
-- Shuah
