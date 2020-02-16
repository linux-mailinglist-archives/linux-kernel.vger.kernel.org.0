Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7893C1604F4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 18:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgBPRPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 12:15:10 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35074 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgBPRPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 12:15:10 -0500
Received: by mail-pj1-f65.google.com with SMTP id q39so6158218pjc.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 09:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=j6In1ZMqVqL+EXVTCAEgQ5YhGd4Op+E9zTb7k2XCzGk=;
        b=FRpZhnw8jNA6iPn+w5/D3iYi1ElYXNSDUkzmilx+bQ8810Wz0XsMUPWIpRglmBTSft
         p1J0B7NTmshC0/phHwFPgJQONaaLwID7rNe63j4jleW1q4ISIGAVWFdQwOaewQFJ3h05
         RIo0+dYlRtuFjVhme8xF9mRJH4fct1MRY2U8fKI4h1wuOJhbw5hULpeltMvv/cymeJos
         iozthv+J/tGd7RVI0fas8xHdn7wEuHzzY1H6aMB4szGs9E0Oz77YTeYCc0uA1VR0/BxW
         OKuS471grWaedWlOQ6RyjmEM7oCNYR1uj9bf63NEfm7Rcj2JH0abacbGSo86JIRGX7N1
         Q6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j6In1ZMqVqL+EXVTCAEgQ5YhGd4Op+E9zTb7k2XCzGk=;
        b=eJNdSvVMmbOJpaTldEte24qv5JFw6MVqUh3dI3ryP9AM0FUT74tV085Q4Cq27RUsTv
         XTF0GnodyVBQMT9eYcFLe4/ZgIY7+TCRUVEue4Zk+wRvIlduJ4TPKtFdTKejlIdhG/To
         /jvcEtzYILkIaOw1Nc9k9bs2zumFsBaZ7evUFybHEaYsfSHE9mIP9aZBKI3MjcA/dOmc
         RzFBGVUnwB5QjyRFed5TXc2hgTgvVGOuQnMbu7U0/Ta85J8ADv+gelBvlz3VRQd5oNAA
         3zgd2TQDIhggufUrwRIVG6eFr3Aqc/eJEn+XnwkbKwyF1SOCMJLP+XpGaipBcHarK1I/
         lD3g==
X-Gm-Message-State: APjAAAV3Zc9BiURZKm92ww+N585gI9kte8Xq5oazWoaS64/AvF8xUlHK
        peaaPUzEhf5W3tHKMtpGFcpeX4+TsTU=
X-Google-Smtp-Source: APXvYqz/BVLKj4CMP1lu96h4dUcFR62S1Rbi9mYMVUoHqq+uM7szXQCvmpzYtkur9nb8ngHltEpMGQ==
X-Received: by 2002:a17:90a:b010:: with SMTP id x16mr16053385pjq.130.1581873307958;
        Sun, 16 Feb 2020 09:15:07 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:b1fd:20cc:c368:304b? ([2605:e000:100e:8c61:b1fd:20cc:c368:304b])
        by smtp.gmail.com with ESMTPSA id x65sm14255050pfb.171.2020.02.16.09.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 09:15:07 -0800 (PST)
Subject: Re: [PATCH v2 1/5] io_uring: add missing io_req_cancelled()
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1581785642.git.asml.silence@gmail.com>
 <da924cbc76ca1e5b2d1528ffd88bcb180704e531.1581785642.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <879b7984-c45b-6bf5-9e15-ee4b744e47f2@kernel.dk>
Date:   Sun, 16 Feb 2020 09:15:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <da924cbc76ca1e5b2d1528ffd88bcb180704e531.1581785642.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/20 3:01 PM, Pavel Begunkov wrote:
> fallocate_finish() is missing cancellation check. Add it.
> It's safe to do that, as only flags setup and sqe fields copy are done
> before it gets into __io_fallocate().

Thanks, I added this one to the 5.6 mix.

Going to be sporadic this next week, but I hope I can get to your
5.7 material anyway.

-- 
Jens Axboe

