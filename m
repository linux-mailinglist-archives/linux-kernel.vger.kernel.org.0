Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6164145AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 18:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgAVRba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 12:31:30 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35289 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgAVRba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:31:30 -0500
Received: by mail-io1-f67.google.com with SMTP id h8so100207iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 09:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QhmytsAHT+fQWKcDzmw1PiTvOkc+/ne5RpL730u18Rk=;
        b=uzh00OvunkHvzy7F38nibq3lJZLQdl+pKhWD9CrDrau675hae2smPZOXnvF6pL6DgZ
         CgW1L1nObjMBGzHlWckZGLL4YZVkU61jGrgndOEH98zcFyjIiWwppXijplKrUadWMHiF
         RMyYJ8rrsvmRhhU/qCPYK/hIIHt1R278L+0UJeuqXLb8Ju+a2tcFK1M1xjlRYSE6Ovvc
         3CYCjMYBNKRU9o86b/fWRabZk5x76sjJUca//+gI//1gLEDMoINXAwwT7J7sA15wQXHk
         6WvnI/7vJNm+HzeLlKH43OhQABCgOiZlEp+63/gtKjObP1kqjCuw+zYzYtJnQHjP/LZc
         k8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QhmytsAHT+fQWKcDzmw1PiTvOkc+/ne5RpL730u18Rk=;
        b=Lht1JyheTJQ+kwXV/jIroUKKVWcBE61X5R/yZlk8XAOTZ5051XakJ4twQ3FbGdVUuM
         co8YcWY8GklEmgEYkJaIOKP257TcXVIOEWMNvmXhVGu909HBEuTZy3zpOQqxZojTMcKM
         0idwljwvVhH++JBR+LcHBKgSROY861qGVDvqkmBeRpcPPXojtpi11pyEJOvpxEj8Nm9M
         XgpDDD03uEJUXH0D62oq38kvYmjb/58ILkFJPxP5ZSkgRl1XJYSoW0RJQsCqRL6XI/cN
         +gy8pu9+olyQNhjsYHZb0Wpbp8SQlEM0+44wNcdqRNMPuQ14n31VqVHMBEQvOyc6A+4J
         zzyg==
X-Gm-Message-State: APjAAAUpk9mcUaQXBQGp097fZbosZG1WqqOWyD4zltbVLirSuS/kPDj0
        IeZ5Avxmsb+99HObd7rJWWFvE3ogMzY=
X-Google-Smtp-Source: APXvYqyYc85e+ep55jcoAbCKz4ESlvKLEz4rjhsH70uEJF6eltTeHdBh2rGUEjG8VIiwrW03GzA5SA==
X-Received: by 2002:a05:6638:76f:: with SMTP id y15mr8152403jad.5.1579714289314;
        Wed, 22 Jan 2020 09:31:29 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f2sm10861732iok.20.2020.01.22.09.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 09:31:28 -0800 (PST)
Subject: Re: [PATCH] block/bfq: remove unused bfq_class_rt which never used
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1579596534-257642-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8e4f68d3-28a3-22f6-ae55-814903d990b9@kernel.dk>
Date:   Wed, 22 Jan 2020 10:31:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579596534-257642-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/20 1:48 AM, Alex Shi wrote:
> This macro is never used after introduced from commit aee69d78dec0
> ("block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler")
> 
> Better to remove it.

Applied, thanks.

-- 
Jens Axboe

