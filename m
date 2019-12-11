Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF7AF11B464
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 16:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbfLKPrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 10:47:17 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:45768 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732195AbfLKPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:47:15 -0500
Received: by mail-il1-f193.google.com with SMTP id p8so19796090iln.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 07:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K5tV1Nbe1r0pXJnCPxMbOe7kndEwjfC++jBrsJjlTJ4=;
        b=g97qMAEbDugNtjFu0nHCUBg9SghaU0t+zHk415SH3KffcD+76x9KR/wGKzyJlghYjV
         ZqBcIcHDB7QU+L/tIYtHk5SAM09kJoFZGmyGS5Ooifd9ZgOAORfwgmi5ER0zgOt7I63G
         DLic0hIJ0fhlRyD+vF87026NYmQsa9Q+hngCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K5tV1Nbe1r0pXJnCPxMbOe7kndEwjfC++jBrsJjlTJ4=;
        b=U6+E6k634/H7OD07PnyUG5+Wv4iMILxla5lzmeaB2A37MitleR4+3HSeL7xXJuLbM9
         eIjcQQjjOr3xMXnBHM+mKhY6IcaIsDZdtKPdBwXvrQuSuQeuy04tcHUZox/1iPY3rReQ
         QGbO+Ot0io7oqXkcimvJar7vvTfXndDb9RJf0RKTcL/4ErBlVX1uieGlTc4rEqC2qrPB
         AE4f5IwTKollv9/At75T52TagpG7QE5T2UqgAmXT/jJ5Xt6yy/L+JG2dz1+U7DEMyRw4
         JDjuZexN1Eys8n0Y7uO2i8D+QcQ6RTB+v2FesjBrnYMNNkvbPuu0INo92I5D7SY7Gu6G
         0nDw==
X-Gm-Message-State: APjAAAU4UoZTLyD9wMhanlD7BX0PTTeZy5wdJPBxNAb/tAqd+I20vNO8
        0KwHqP4+OOBg75NP/jv0aTMjlg==
X-Google-Smtp-Source: APXvYqwhpn/QF1wbC4mB0ya8wkAJ3m32nxicCLfymqByaY87HWI497bwVXALV2E51FptLj56RfQm5Q==
X-Received: by 2002:a92:d18a:: with SMTP id z10mr3864672ilz.48.1576079234387;
        Wed, 11 Dec 2019 07:47:14 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u23sm808618ila.27.2019.12.11.07.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 07:47:13 -0800 (PST)
Subject: Re: [PATCH for 5.4 0/3] Restartable Sequences Fixes
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190917182959.16333-1-mathieu.desnoyers@efficios.com>
 <211848436.2172.1576078102568.JavaMail.zimbra@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b67930c1-c8e0-124f-9a88-6ecace27317c@linuxfoundation.org>
Date:   Wed, 11 Dec 2019 08:47:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <211848436.2172.1576078102568.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 8:28 AM, Mathieu Desnoyers wrote:
> Hi Thomas,
> 
> I thought those rseq fixes posted in September were in the -tip tree, but it
> seems that they never made it to mainline.
> 
> Now Shuah Khan noticed the issue with gettid() compatibility with glibc
> 2.30+. This series contained that fix.
> 
> Should I re-post it, or is this series on track to get into mainline
> at some point ?
> 

It will be great this can make it into 5.5-rc2 or so.

thanks,
-- Shuah

