Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAEF414F4A6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 23:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgAaWWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 17:22:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41827 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgAaWWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 17:22:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id j9so992263pfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 14:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ym4CATryr3QJbBXCpmH+mWSLbQwwdB6r4IiJNjhJKxM=;
        b=AbeaxiAXSmyiyWHNUbJzYqLQg8oCe/1I9MYoknkNjSSPvw9PWYJllaHHOTXONw12vW
         N7IVuUFhIeoFuznn5PPdckAaTra7JYdCZdxcDpe12Ek/R4Pn7uyMW6bdd2pZ+A7N0lk6
         xfJWkSkh8RSWWOO9Cbdn8cRbOBsWA5bUs8wzjfKvrhOWvDsZnskFKOGLGA731rNjTiiT
         nK5Eyc9z4+Sw0N2W2l1JaNdyXM1uhKMKp0jwX7qgsi7FONnqpsddAwyEyNEJh7/BPI6a
         S88kJycsXPYxc/2R5u+zip6zxGOncmgqexxtkknyJA4KsXGpDfbkrp4f+TVwovCXrjhr
         OF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ym4CATryr3QJbBXCpmH+mWSLbQwwdB6r4IiJNjhJKxM=;
        b=kR2TMxvGTAMp1R84MMfNiulqUeAWoJyYitBtXIdpSfk9I3WSm73ugu5+rJ5XI6dKRv
         zyXhXmqRt9hGS82NpZjb1SKn8kfna9zXZMaJKT/mpQJWbvzevnT7x19Amayn8yLeTaC9
         z7tHQSda/R+uF3d4i2oWPhNJsRU3VGlAFIOU9ij4q6PQwysRDSYJdYgdWPKV59cwCSyV
         MO9Jjjf/MLKEybC4caczOAGl9xCNgarcq5AQIwkO4TJFwu28oYxcb06J8Az2yYeL9i7Y
         BcYaCRcFNw3wyXMy8FhpGzC77ySv3/bthcZUGOzOD0E0KtHtzsYl9vF6m5q0+r78OvMa
         uWxA==
X-Gm-Message-State: APjAAAUU1tUS31I/Paq3ORZlnYy61qxXKIvHgT0TzqlKBjXAdSyEjmlY
        Xhbk+XQf8ifw29e1g2XkizvVyTLvDLM=
X-Google-Smtp-Source: APXvYqxTillDlW/mS8lPlT9SG5wZBL0oehI9eN5JpPJ1IpJJMPh4VPircIzIYcxv85ZTCYsJ2zICWQ==
X-Received: by 2002:aa7:9205:: with SMTP id 5mr12785889pfo.213.1580509350445;
        Fri, 31 Jan 2020 14:22:30 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id l10sm11260963pjy.5.2020.01.31.14.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 14:22:29 -0800 (PST)
Subject: Re: [PATCH v3 0/6] add persistent submission state
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1580508735.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6492ccd2-e829-df13-ab6e-e62590375fd1@kernel.dk>
Date:   Fri, 31 Jan 2020 15:22:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1580508735.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/20 3:15 PM, Pavel Begunkov wrote:
> Apart from unrelated first patch, this persues two goals:
> 
> 1. start preparing io_uring to move resources handling into
> opcode specific functions
> 
> 2. make the first step towards long-standing optimisation ideas
> 
> Basically, it makes struct io_submit_state embedded into ctx, so
> easily accessible and persistent, and then plays a bit around that.

Do you have any perf/latency numbers for this? Just curious if we
see any improvements on that front, cross submit persistence of
alloc caches should be a nice sync win, for example, or even
for peak iops by not having to replenish the pool for each batch.

I can try and run some here too.

-- 
Jens Axboe

