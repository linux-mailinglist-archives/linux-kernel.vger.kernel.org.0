Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3EB9D22E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 17:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731793AbfHZO76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 10:59:58 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44940 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730725AbfHZO76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:59:58 -0400
Received: by mail-io1-f68.google.com with SMTP id j4so29646973iog.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 07:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ki2gfeocOUFyztYUjbOsFQksape9FnGjll4dZqr6rCg=;
        b=NScmo3MbHxnQqudynmmBQ+SChKqC6xFr4lYmxKNiVfkElM9wdl83Kb12ELkqsgA1/Q
         23Tx2eeGGZKA8m6Dt4AeSv2lEspzJkFtWGo0oL5mr5iCa7m1vCGCIgMN4YxHVkVhWNn6
         1WZ2CHz2mGS37M+7SLDGOALfnahipEM/dSnFLyHgtdH69u9QCYRDEp8NU/RSOPBP7JaG
         wxHO1OJgT7xX36R/BAmRUHovg3HZSyBHtPL/YgjsOICMXH+NCmS9YHDk3uTLxb4ppBOl
         OHpe3hcyYQ1m7lP3CjNapy3Ujr2z+9IlvbVvkrL8Y7VHBPOfQeCGmuRAYtc3n/AqDDwc
         9TaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ki2gfeocOUFyztYUjbOsFQksape9FnGjll4dZqr6rCg=;
        b=FCa9Je/ljFjqa0sVUQ68GzKSNd7Ed4+jE4bFUF+FQNtn2WwiVdC8Ud+WqzOWBzpitr
         lW5+h9HawL9XMCq0Ntd2irxnIQkvJ4IHp5O8hnhNUoS9VCcsY1Mgz0DH3OILIW7p6J3l
         5/4xlKTuOyF2vJhFEHIrxPru8pVmg/Ele8M3ruSwjag2/JuX1+9YZ+SNeZB0pa+XjGgs
         C06AmQ89tbFjEhTHS3lTrDfRTfUJKAlC/76AY236lGB3U1rTF8hEODE37XadEhmZRVjN
         sKuS0GjIL9EaGr2I9QyJjcKlaA5lcNB1GQ4BFQFiUVA5ELpkAjBDKS1AYu4CDN1nG7Z3
         MJfA==
X-Gm-Message-State: APjAAAUjiI06aeGBo3m1G1Khqa2Ea5XOrpX2yBt/DjbEK5YC0dQQimnG
        vesf3rokViVMP8QL71ea2uzuf7E/b6GmtgnQEgxeug==
X-Google-Smtp-Source: APXvYqz2myGSNELFlpgsGdrHu1p0x9MAsRTyFVObH+ENwol+tdu+yz0sL73VsnfquhatrBtVZ7r9Prov3ZFHn65A6jM=
X-Received: by 2002:a5e:c601:: with SMTP id f1mr24223127iok.57.1566831597008;
 Mon, 26 Aug 2019 07:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190822220915.8876-1-mathieu.poirier@linaro.org> <20190824003002.87657-1-yabinc@google.com>
In-Reply-To: <20190824003002.87657-1-yabinc@google.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 26 Aug 2019 08:59:46 -0600
Message-ID: <CANLsYkxC-4UZcVKoTQiJ2PsDxwuriFoAwqdbM39EC1G3nwwAHg@mail.gmail.com>
Subject: Re: [PATCH 0/2] coresight: Add barrier packet when moving offset forward
To:     Yabin Cui <yabinc@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Mike Leach <mike.leach@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yabin,

On Fri, 23 Aug 2019 at 18:30, Yabin Cui <yabinc@google.com> wrote:
>
> Thanks for fixing this problem. I didn't realize it because I usually use a
> buffer size >= the default ETR buffer size, which is harder to reproduce the
> problem.
> The patches LGTM, maybe you also want to fix the problem commented by Leo Yan.

I will look into the issue reported by Leo later today.

> I tested the patches by recording etm data with a buffer size smaller than the
> default ETR buffer size. Then I saw barrier packets when decoding with OpenCSD.
> And I could decode successfully without error message.

Can I add your Tested-by ?
