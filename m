Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C71E814A806
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 17:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgA0Q0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 11:26:44 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33008 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgA0Q0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:26:44 -0500
Received: by mail-io1-f66.google.com with SMTP id z8so10676282ioh.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 08:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jnAf2ZCvKeR5KrFg81NL0b/pJXtuUM4gmcIbXki436s=;
        b=J7SvJjKqvJbkbZjUVLEw8HGOfNBzK/t8L3zsFgV2DcjLemtkHVO0yC51wOouTl6oEf
         Ofh4rkV0R9eoXe4W6+fuj+qy/cFtatuRyOVpo94bK68OTcaeWusODpB8MaeJdmWotUv2
         QIJPytxZu+WLTDaG84hSrYfTS6MdYtMc8CoaJY0v6VYwRzGuyeqLtOQl7Gq0232yxgZW
         dQajSdX0danP0r5U0BBJJRmwfIcM0FWO8zGozFIZo1MzEz8fWf47wNlqttuyN6ucCXmD
         krFkQ2K+WX8m0cuiPEctMv+w83MIhGYSEC8qUzT0PE0oC0w4ThEz5cnv961zcFAjHypG
         ngIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jnAf2ZCvKeR5KrFg81NL0b/pJXtuUM4gmcIbXki436s=;
        b=TCVwGoYyf/3WKsLh1gIn9hsvRcRp6mbHhfsgcFqapxgRgmZzfNCL6jYY3E1uegfMcU
         INEF/HwHiB+ycXWN5xefToeZ5I5FpxgyEL6ZcWpVdxaz94m0GHZGjO0PsHtuYgdVRVow
         vuSICAidRtWG32lOCQ6C8QjjhB6Ct0yaaWJJM0DUAB1a+LATpZoAKTkbcToNjuuRWJgE
         rQWyCXrkMPSzOnveTGFjkOGZ6Yw4yUXW73nrYciJ/zuENdQYkh6Zf63jSGOxIpb3tSRr
         mUIwcTs5mFHJjHaCpCs9/iBUpayipGlyg9khr9N6opoBeaeEiMNaQVagh89kTfsF0noJ
         z9tg==
X-Gm-Message-State: APjAAAXGXZOxCn1dH+hro3wFxfMx1KjAUzwVeBe5PpD16DrWdZfGxH6l
        XHk+4wHwgkBlcNu7TtbzoVu4b8ejC4A=
X-Google-Smtp-Source: APXvYqyLeS0OYSK/chuIUny+PebIrVJGaZIYd4dwfdJS/YVsHj5RM6n3ZOjVo+TEeU1SM9jWNE58pA==
X-Received: by 2002:a5d:9805:: with SMTP id a5mr12889195iol.80.1580142403376;
        Mon, 27 Jan 2020 08:26:43 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b6sm1081212ioh.15.2020.01.27.08.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 08:26:42 -0800 (PST)
Subject: Re: [PATCH liburing 0/1] test: add epoll test case
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200127161701.153625-1-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d409ad33-2122-9500-51f4-37e9748f1d73@kernel.dk>
Date:   Mon, 27 Jan 2020 09:26:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127161701.153625-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/20 9:17 AM, Stefano Garzarella wrote:
> Hi Jens,
> I wrote the test case for epoll.
> 
> Since it fails also without sqpoll (Linux 5.4.13-201.fc31.x86_64),
> can you take a look to understand if the test is wrong?
> 
> Tomorrow I'll travel, but on Wednesday I'll try this test with the patch
> that I sent and also with the upstream kernel.

I'll take a look, but your patches are coming through garbled and don't
apply.

-- 
Jens Axboe

