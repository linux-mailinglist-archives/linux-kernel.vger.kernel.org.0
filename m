Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27AFC8F209
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 19:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbfHORWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 13:22:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35510 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731530AbfHORWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:22:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34so3150145qte.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OQP1eUr9wWUBvltOQ9Z8Ub62tAaopiVDYE144Am9PUo=;
        b=HZpXjn+wNo0sYnP8fO/9yi9VvMIl2O1vBqS8Gie0c3FRn6sQcTfP9It56G6JplB5nu
         6VownGa1B8OF7b8irbXNCSR+PzKi7JmcuM4CQfuPlRxhfFejaHkab6ZOdE3AoI32m0ym
         9kJ/FcPddnqe494h+5mJIqpN8bMFl29a2XjmzcKwArH2JCGXbQ9IqvTODG3SBiXDo6OK
         yCF3is3A5wQj8iInyzHqtNlF6mJXcwZY3WY1cZAnr4RFS8A7douZtCnwhELnMFfM1jlj
         QwAOY9+OGQNin1iSiarC/jXnwc6Mrf+qPsKiJHOkejdQmAIyz9D1rE115khKlpbX0f0O
         kg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OQP1eUr9wWUBvltOQ9Z8Ub62tAaopiVDYE144Am9PUo=;
        b=glyyxno/qr/rJL4Cx3P7d1tnbqdm0bu/cftYg2LDn/O20bnQrIAqdG9XTpmCL1d+uY
         G4z1zhhaZI4ioUGc8AlePxMKBieNecTC5Q9PO4BpP/Ge8YrYEN7Omk2OkGQsK8MsiOVD
         T8QTIYIKI8c4cSXxQxfMd9MBk0uOlrcKecGuTq9WQSICcAxKpqFKG/1AOvsJ94aBy1H2
         RlN/bhKnTXIj9Cef1OdqoPv5GBoec0sJGyjDIha5Bnc1K4WT5dkMhuRPbVWHM7ERgmZQ
         mBqDd5LubPno/c1Vmig43Fmwbj+N0eyI4TC5EtIfRr/sM28xXtSMZGC+Qfr02FcEInzE
         pcFg==
X-Gm-Message-State: APjAAAUdbLylRGgAjlbRyWV78L9ZkHSDPbHiw+4jm3Y9Dm5Et6tUKe0h
        smK6BhjpkKGitf2tEAvJAM/0z6/k6j7JJQ==
X-Google-Smtp-Source: APXvYqytVj4F93Lz8NG25cUqyDAsrQnJhJ3dX1TYfOQ21CEln44s8gEqzzxOvwnd/uQdneR7JttTRQ==
X-Received: by 2002:a02:5105:: with SMTP id s5mr6163824jaa.42.1565889730912;
        Thu, 15 Aug 2019 10:22:10 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f9sm4511731ioc.47.2019.08.15.10.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 10:22:10 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix manual setup of iov_iter for fixed buffers
To:     Aleix Roca Nonell <aleix.rocanonell@bsc.es>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190815120322.GA19630@rocks>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ab327769-f18d-61d4-1c71-fb7ad60bb53d@kernel.dk>
Date:   Thu, 15 Aug 2019 11:22:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815120322.GA19630@rocks>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/19 6:03 AM, Aleix Roca Nonell wrote:
> Commit bd11b3a391e3 ("io_uring: don't use iov_iter_advance() for fixed
> buffers") introduced an optimization to avoid using the slow
> iov_iter_advance by manually populating the iov_iter iterator in some
> cases.
> 
> However, the computation of the iterator count field was erroneous: The
> first bvec was always accounted for an extent of page size even if the
> bvec length was smaller.
> 
> In consequence, some I/O operations on fixed buffers were unable to
> operate on the full extent of the buffer, consistently skipping some
> bytes at the end of it.

Applied, thanks.

-- 
Jens Axboe

