Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE254114330
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 16:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfLEPAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 10:00:42 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:36998 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfLEPAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:00:41 -0500
Received: by mail-il1-f195.google.com with SMTP id t9so3260407iln.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 07:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=F5mXGgQfdcX4ulNvMgJjySGQKhJoMGbY4UManmb5rnw=;
        b=IONzYt788nj+bQP2DMnWzbIsVtvCFVv2q6kQwcurdaDuXq17O2n/Dz3sP337r4xXmb
         cCYaeWsw6A6b+gGxworEyXUUjtWh7q+Hd2lIEgPAWiPeNIZ0eIeiHV0h9Kk0dnG9aDSA
         SswE0cfdhCdZ143x1FjVlUplkNtdBbCEA6KKcuXXB+43ZKbXGx4etEdt6tEL0Y3wEhqX
         EJWUhVgFESZKT6os3cMmoYDQ9OD72ahcrPnZP0VTak8sFIvI6Goeq96q8Vk1yzE99e3G
         uoCDSIkKp+/PPwoOO9WAeAxqVNreJMKLHsET3MvKV8DAXrrYjORfeUsMuRnW43otuvGW
         GYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F5mXGgQfdcX4ulNvMgJjySGQKhJoMGbY4UManmb5rnw=;
        b=Que+Gz8LrM9Du1Zu6hqeU/VzmaRl3hX1dTgU3tx9boBmAWQ8hxiNe6nU1YW4Tsg707
         ExL/6xHNRoTMQ/CJFjYIAKUbEr5586Svl2wW2yLxpLWVutTLyfRvPKEKoTBL7/2yFyZR
         RvzSlet+y+tcLAuOhWqNPJpNzTvkKaPzdUuYqw7yhJAN8ps3HGerP3L/4QvsVp63Vqgo
         EswL/H3EKl5pyiYpZWBYCRUZOpfCyTsBD4/jaN4GgPnBQ65F1jMpF3xb3azxz8WUM0tp
         qyTIBPI6gVm9amxgDMqKUMfwLxNh/Wm5Pb0PqgyONXv8ve8YuZuj+VKFl8u+i6OPC4Lw
         BIgQ==
X-Gm-Message-State: APjAAAWxe6/ms5Ac7PAIlLpdLplr9qMWNWUxpTsEToLtrO8gBHMdRKfW
        VsceCBcv9lYgeWq3EeiGn26qX80kYmThMw==
X-Google-Smtp-Source: APXvYqxIYA4JrNV5BxAT0DEq/LbOrIBZ+ExgEHJoa8r5nn9zo9eBUe6YgDO9mP2pcqCfGBRcYrltUQ==
X-Received: by 2002:a92:9885:: with SMTP id a5mr9316849ill.107.1575558040476;
        Thu, 05 Dec 2019 07:00:40 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o83sm2874577ild.13.2019.12.05.07.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 07:00:39 -0800 (PST)
Subject: Re: [PATCH 0/3] blk-mq: optimise plugging
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1574974577.git.asml.silence@gmail.com>
 <da7f8969-b2ee-2bfd-c61c-50f12eb7dc16@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0f7be0b5-1d70-ae41-ad15-2e1ae7c73f09@kernel.dk>
Date:   Thu, 5 Dec 2019 08:00:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <da7f8969-b2ee-2bfd-c61c-50f12eb7dc16@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/19 6:19 AM, Pavel Begunkov wrote:
> On 29/11/2019 00:11, Pavel Begunkov wrote:
>> Clean and optimise blk_mq_flush_plug_list().
>>
> ping

Looks good to me, I've been waiting a bit on this as I'll queue it up
for 5.6.

-- 
Jens Axboe

