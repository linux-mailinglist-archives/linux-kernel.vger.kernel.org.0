Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E807123C69
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 02:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfLRB2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 20:28:07 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:46129 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLRB2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 20:28:06 -0500
Received: by mail-il1-f195.google.com with SMTP id t17so217968ilm.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 17:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rsdijfwxXIxEdfTf0BJ4NmtNQn2EATypQJ6GWjnlpeA=;
        b=LN64OzUR0PK6WuZ1fEl4fu8/YArhpB0cNXjvLjDyVu4uSbb1wZHaJI8pdSOrfCaAqt
         Je1XxbdQjFviM1dg0yITmdQcncyA9VHiL2PYu9cSm9o5LO1ByfFpaXGx26MECSkeYjef
         C9KJXeSU78bQwI4zGaNwJ6Tq0wCp7Zncnv7esvgYC48tD/qA1k0GF/RiDC94FV+uRlUp
         Mvzyzq6WWkigWT3qBTJFetlWPdXCO2NR4xmIB8dkyRcmivmTtTl6jo39EWNBxI67bFU8
         7mIKH/oIIoCo2Y6j7HdvZ6DH5GkQbIaei8i8njuBAwsfZ7fmNqBKpLgDU55yjpsQ6n87
         f1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rsdijfwxXIxEdfTf0BJ4NmtNQn2EATypQJ6GWjnlpeA=;
        b=ek2mK3VIvx37O/2IzDRuNctwyQDb9bl5Edeg4l+Bo5kebl/v9gN5/yBA/gQdrkGIl6
         Nfr5rhIH8cVMyzZCGGSArndXzi1rxE5xkZtW9iR/+faCnmXH2giUEhxHS6oTRsjpaHXI
         tChe++So765yUPbZOuBCR/N3bXKrFSVpM7rhvrI9qNUdoi/3M08PGfOasZrtP/NLiVum
         AaoT3Pwyn+H61ucs5tuC349H4mxCny1y7Mv/d7w/Q/HvsdZjdK4oO04xEBAjyqfRsKOd
         p5eh8SyynokpyQgKooV/3Q5CDxLkFIjos6Jy1Prk3Ul5yrEXgJtQHXNFnGYVWli6l4sB
         B5rg==
X-Gm-Message-State: APjAAAUWb5YOzFbtMmERuJ67t6ckjFx/BxynSTCVx8KaqLMzfJHk64gP
        yY9+1PbAPJ1JZjXQ/sPJKa6NgmMoTljBIA==
X-Google-Smtp-Source: APXvYqxMoNlpt/TC/axYgAFYjxnhzrkeZChcmx0aIRqCHbKGd9YPVayHYz3Z+3XrRumsEypM7n7L1Q==
X-Received: by 2002:a92:45d2:: with SMTP id z79mr386262ilj.76.1576632485203;
        Tue, 17 Dec 2019 17:28:05 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e5sm146581ilq.77.2019.12.17.17.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 17:28:04 -0800 (PST)
Subject: Re: [PATCH] block: make the io_ticks counter more accurate
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>, xlpang@linux.alibaba.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191217142828.79295-1-wenyang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <658ba1d9-45b3-db85-250d-7a1a9328e9ff@kernel.dk>
Date:   Tue, 17 Dec 2019 18:28:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217142828.79295-1-wenyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 7:28 AM, Wen Yang wrote:
> Instead of the jiffies, we should update the io_ticks counter
> with the passed in parameter 'now'.

But they are not the same clock source...

-- 
Jens Axboe

