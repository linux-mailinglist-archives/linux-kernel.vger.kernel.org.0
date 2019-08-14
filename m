Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F87D8DDD7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 21:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfHNTWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 15:22:10 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45701 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfHNTWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 15:22:09 -0400
Received: by mail-ot1-f68.google.com with SMTP id m24so516838otp.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 12:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LxqeTUiYUsG0G8NyuG3f0T0v6puXDuhBSbPGymyiyUI=;
        b=DspYso0mGGRBDZoI2K36M1KBrMEtD1kkpjmt7Wwcz84eufDyOzfBXLOHY6ku1QknLz
         7Rc1XIIc61FmwmHmnLiBBSA1t/oaSW05QxqCDFD3QN8KXL3ftpkmKtq2qtk/MexRXA5z
         HKU9wvvVZcK2bnyLY4XSaVYvqvfzypIGLklQhX9SOHzuBcqRuLx35tX7b72rzug8wqLb
         NDXdiOxsmjiqq/zW6PDF9BeCmEOVlKwo4P9EbQHwMKVn5iaWOJPECR5+laWCAUVxbhhg
         9uBFcLQgTLZrmr6BY8AABcXwtUP8jROZm2NAK87z3K1PkEkNElTRfnSshGo7662qoqnU
         wXCg==
X-Gm-Message-State: APjAAAUeenbB9F0st0GIsSgu5Xy8/Jq/g75W79kmyz2amZcMZPnadijd
        RHqJge6uH+vi4qVmF5XZ+i4=
X-Google-Smtp-Source: APXvYqzR74bg7uVqsQDiDikrci1UGS6hqPSxAA1aio8lHCkz7cVBSMDJSGnib2opDOWZSnoRbvxuRQ==
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr575345oto.250.1565810528840;
        Wed, 14 Aug 2019 12:22:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id d27sm185263otf.25.2019.08.14.12.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 12:22:08 -0700 (PDT)
Subject: Re: [PATCH] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
To:     Mario Limonciello <mario.limonciello@dell.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     Crag Wang <Crag.Wang@dell.com>, sjg@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        Ryan Hong <Ryan.Hong@Dell.com>,
        Jared Dominguez <jared.dominguez@dell.com>,
        Charles Hyde <charles.hyde@dellteam.com>,
        Christoph Hellwig <hch@lst.de>
References: <1565798749-15672-1-git-send-email-mario.limonciello@dell.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4352c052-50f6-ed52-deef-69b321c4b61c@grimberg.me>
Date:   Wed, 14 Aug 2019 12:22:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565798749-15672-1-git-send-email-mario.limonciello@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine to me, Keith can we get a review from you?
