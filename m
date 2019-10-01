Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34BC2C36B7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 16:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388894AbfJAOKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 10:10:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41936 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbfJAOKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:10:13 -0400
Received: by mail-io1-f66.google.com with SMTP id n26so19757148ioj.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 07:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3YUx0HE7NiysDC7RZVfxopyCJv9liIb6R89MTahPdRA=;
        b=Am2icvsCpWu9R2jUDF5p07FY8Xh6t9Zk2ZbZUtTvUV4Deh3tXSewk/lOIhmxj7NCVY
         hwoNwW4X4LHYD40xbyrfVyv+6HfcA9SQDcC5KWQ1hs0OQbcz0koawBX9QQr96Nn/QtOz
         Cmp9v8GC5RgZaOd96XvdRc06fphYAjIcRrMkKY+0x/kg5at0EUsSiIKTGAHEURxzXh0r
         knuWvO2YMyL1DMHtoVLR3wW76wouPj+0AJUhbK+/T0U2BqruBULXooT/zjGmLoK+7xh1
         uXQoJI3xiCWXfVwSqoDbLNuzqL4vftHrJvswGMzCX0AgtofFV/sgrWp3pJ/fSxnkHAfq
         Mn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3YUx0HE7NiysDC7RZVfxopyCJv9liIb6R89MTahPdRA=;
        b=HAdm6f6Cn3D3i5UWK24LJgExqnoh1FVtmYaP6gCoHGi8RbWZFOqBaA9Wvs505wPEYz
         +s8PF5J6Mp1seyVQbeymv2ZZSfjJYIkti2pUg35GQdBfFkx1D6yhGcpLHRrkbJg7ZfHT
         MMfhfqIQL2co+S87cs3WpBczPouk9m/Y72/wFTvOhQigr3ZMUPo5SrSD4CNKdljqQcUI
         b9KEOz3P8IIkOkYE5taVUEhQ4l3x1Psb1SaAzb9aqKmmf9VyBeGBWONlfaWcr8+1zfOc
         RN6mC4LLODSGSHwUotKjqCddmrwTHta/x5bGzFYNT+edO2mKKnDGGyqVgr2CP9uKHeRQ
         LXNw==
X-Gm-Message-State: APjAAAWRcWtfkuqdHbpivP4LtS02tDm+Nc+2k1DVzTt6ZIRYKmkyG9us
        G/Uhbf58z7Gi9sd4KWUeEqriaA==
X-Google-Smtp-Source: APXvYqwyQ78cSYCEY59QpZFzt9hWgZe8cTZEsDwwEpX7/UuXo/5xfiD6Z3upSoLEMYx8IRdazyU8mQ==
X-Received: by 2002:a6b:8bd8:: with SMTP id n207mr5770851iod.147.1569939012260;
        Tue, 01 Oct 2019 07:10:12 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c8sm7042439ile.9.2019.10.01.07.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 07:10:11 -0700 (PDT)
Subject: Re: [PATCH v2] loop: change queue block size to match when using DIO.
To:     Martijn Coenen <maco@android.com>, hch@infradead.org,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@android.com,
        narayan@google.com, dariofreni@google.com, ioffe@google.com,
        jiyong@google.com, maco@google.com
References: <20190828103229.191853-1-maco@android.com>
 <20190904194901.165883-1-maco@android.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c65da8b1-755c-57f5-d49d-fb25e8dc809b@kernel.dk>
Date:   Tue, 1 Oct 2019 08:10:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904194901.165883-1-maco@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 1:49 PM, Martijn Coenen wrote:
> The loop driver assumes that if the passed in fd is opened with
> O_DIRECT, the caller wants to use direct I/O on the loop device.
> However, if the underlying block device has a different block size than
> the loop block queue, direct I/O can't be enabled. Instead of requiring
> userspace to manually change the blocksize and re-enable direct I/O,
> just change the queue block sizes to match, as well as the io_min size.

Applied, thanks.

-- 
Jens Axboe

