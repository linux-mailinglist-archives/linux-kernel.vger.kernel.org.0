Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F75714A81B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 17:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgA0Qcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 11:32:46 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39689 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgA0Qcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:32:45 -0500
Received: by mail-io1-f67.google.com with SMTP id c16so10686067ioh.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 08:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yov7ap4biFBzdzvuUJNulONNcHIgznC4VCf+Gem9vsM=;
        b=DDTA9J1CCeDgzLa078hSsNZrE5s+EWQhKdJ2pqw/kyeJPhUdV2fImtaKqWoH0yU2qT
         u+V3r4O9ouTvDVKCkNBs6KL1ZhLd+TSZ2YoubgVTvhqVadU0FvkTkbibF+iXAGhzk+b4
         Gvje+NpQRSk2WLu1xUSn11H2Brc+4tKnly6s7uluSICp9V5HKUQWB+sBmQbvgJbH6yye
         i8bWFFK1bCwjh7UHjnSzHZ0rJ+dA0gF44r+dAL1oF70gJnEw4U4ctfwJTS9ZZC+7thVd
         uFbYCeaccmaIiop1Hmg3wYzQ6J4qgfZwYOL4lcOOPD2ioNKD6JHg+Owwk48k3DS2zfPl
         vCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yov7ap4biFBzdzvuUJNulONNcHIgznC4VCf+Gem9vsM=;
        b=EHTIY43/LPWMHNSyn+7QVCWI4YncdReFOayApswiFb25+6iLmoShdHaoaMM5g+pE4J
         Ym8RcGDPsePIbkMzxyM9Yfi1QHdU9ckO6C0Bh4pCceK8siUhMRbI+Zq1YK9kOcGgRVRc
         +zzEAloBmjb6uqg0Ow/iq5Wn4/1ymJBNxHPi2JwNcBs+rsVnq8AweJfvpi0xDllsUh8J
         OWS7wzQmW7mmfFvIxlzjkzJOviD0Xfbaa/bQ2kLuZOPCG5X+2tXpAbDyK12R2HV1DyUF
         f35QoLOwr1SpQHwlQPeY2zm6ib/F/l1Sw6vHAmoLk4H8OeDCLHN98zw3jTF5FV2XvSop
         R8oA==
X-Gm-Message-State: APjAAAUwb6bCPvbsMwZfLm1H31lun3eB/BsUMViM67RgxrVrFMkxP8Bm
        w0l3LjV0P59B/TmT9/F2q70eHjMic9o=
X-Google-Smtp-Source: APXvYqyMgBh8BeGwDTsAgvsRxyN69Aa0BceylNk8A0OQ2Na89SDXKSpTd/BI6G96G7GcyQnHsYUnjg==
X-Received: by 2002:a02:c942:: with SMTP id u2mr14262871jao.49.1580142764895;
        Mon, 27 Jan 2020 08:32:44 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n207sm2720985iod.55.2020.01.27.08.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 08:32:44 -0800 (PST)
Subject: Re: [PATCH liburing 1/1] test: add epoll test case
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200127161701.153625-1-sgarzare@redhat.com>
 <20200127161701.153625-2-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b1b26e79-507a-b339-2850-d2686661e669@kernel.dk>
Date:   Mon, 27 Jan 2020 09:32:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127161701.153625-2-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/20 9:17 AM, Stefano Garzarella wrote:
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

You're not reaping CQ events, and hence you overflow the ring. Once
overflown, an attempt to submit new IO will returns in a -16/-EBUSY
return value. This is io_uring telling you that it won't submit more
IO until you've emptied the completion ring so io_uring can flush
the overflown entries to the ring.

-- 
Jens Axboe

