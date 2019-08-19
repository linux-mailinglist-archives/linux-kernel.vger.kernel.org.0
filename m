Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA9AF94D48
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 20:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfHSS4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 14:56:32 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33782 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfHSS4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:56:32 -0400
Received: by mail-oi1-f195.google.com with SMTP id q10so2144241oij.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 11:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tJabmsRw01PznvjuHTMzfnUeC7QEKWTxZb/URwGZ0WQ=;
        b=TlkVvXQSrik5JMI1/MdTN+V4qTg9qHWlwocvCc5g17JE6G3cf0mgRb4BfgEn+hIVRi
         WqOjNt2d45C1cY+eub3gAnXTF8idkBmRHRIqwSCbZrAV8oHihUBFEg0J4XX82SDDgpZW
         Qx8ocGwMSayltn2lAN5+FFFkAPKSyaPFy3SEcETJgRY4J02kq378mSgn7XIzR/BCmSbz
         8cYBIkIT4iMVhPxlFtBguGtKhMNlk6WAaE9AeODAALsdBxpN0ik2FyEXLiZd15exysOO
         KsKtbvzNUen3w/TD/QbX+CunrmlL59yFbs6nfeq7oL6Z6nkJyckdBih+Zt2Aq/EIyn5a
         VohA==
X-Gm-Message-State: APjAAAUiZywJ4FW09e9G36/KlHGlNBST4S2aUkkDXNmgVyDzB9/R7+1H
        jeFxo22S/zA59wrf6WrW7Hc=
X-Google-Smtp-Source: APXvYqx6UzH+ZYpAr3LPh+sJddeZPmFeTiRX5UUvg9/w+dTM7uk2IFNSKk4q9oC2k6K+O2IQln+QrQ==
X-Received: by 2002:aca:5e06:: with SMTP id s6mr14751814oib.171.1566240990991;
        Mon, 19 Aug 2019 11:56:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id n22sm5366303otk.28.2019.08.19.11.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 11:56:30 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: allow 64-bit results in passthru commands
To:     Keith Busch <kbusch@kernel.org>,
        Marta Rybczynska <mrybczyn@kalray.eu>
Cc:     Christoph Hellwig <hch@lst.de>, axboe <axboe@fb.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Samuel Jones <sjones@kalray.eu>,
        Guillaume Missonnier <gmissonnier@kalray.eu>
References: <89520652.56920183.1565948841909.JavaMail.zimbra@kalray.eu>
 <20190816131606.GA26191@lst.de>
 <469829119.56970464.1566198383932.JavaMail.zimbra@kalray.eu>
 <20190819144922.GC6883@localhost.localdomain>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1d7819a9-9504-2dc6-fca4-fbde4f99d92c@grimberg.me>
Date:   Mon, 19 Aug 2019 11:56:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819144922.GC6883@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> ----- On 16 Aug, 2019, at 15:16, Christoph Hellwig hch@lst.de wrote:
>>> Sorry for not replying to the earlier version, and thanks for doing
>>> this work.
>>>
>>> I wonder if instead of using our own structure we'd just use
>>> a full nvme SQE for the input and CQE for that output.  Even if we
>>> reserve a few fields that means we are ready for any newly used
>>> field (at least until the SQE/CQE sizes are expanded..).
>>
>> We could do that, nvme_command and nvme_completion are already UAPI.
>> On the other hand that would mean not filling out certain fields like
>> command_id. Can do an approach like this.
> 
> Well, we need to pass user space addresses and lengths, which isn't
> captured in struct nvme_command.

Isn't simply having a 64 variant simpler?
