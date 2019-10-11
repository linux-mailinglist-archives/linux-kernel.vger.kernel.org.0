Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B69A8D34A8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 01:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfJJXwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 19:52:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43427 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfJJXwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 19:52:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so4915568pfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 16:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cCuaMw8m9UN/5q2abRR9qC4VK+02/Hh9rek8kBa5scw=;
        b=LAgwFwzKergbnZXxEXYPb1hXuvSekkTrC7KSzmPpq8N7Tlm/RwZaow6B1x/INdMzEb
         C5hY+EqJPnF+5j4jsbSW1GWM9YdNluPvijodi0lOH5sqI+AWQQx11PduIVqWBJSjL2/o
         beCGM9mc9uU+o3G2HPcp3dtBZUP9hu7IcFIl5SovfeVSPGnabvT1iXqbi/vFEDIwFME1
         Vt01jRmATApNrsO2Q4d46DUnaDLJELIkbzZGDKs6AA+FZjbNTt6AB5RfonnH0H5C24+c
         tsG93YSJfM/GsTQw5Li0P118Ia0EHr9cxWw+kchqsVT99CnLtJflhFFUvY+66wAYvl8i
         1SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cCuaMw8m9UN/5q2abRR9qC4VK+02/Hh9rek8kBa5scw=;
        b=Kumh7odagDkK/zliA0ehx9aRK+DiNzkvhuLG8eTmseOz+Np6Nx5zcOFECYw6JPK+Fo
         2Z9INy2Mcot6s8ABjdMmIvnZDr5OX+4VUXLYSSumUYQoDbkefAOJtsbvWWd770MuWggN
         FBCpNEaxZj/j5Cp32n8TDc1NqU9CC9Px5uZznirLBqo0arumrkBfMAhmbHrILPR7I6Jy
         +ozMVKw8ZH+CyAALRwA73o9QQsoXOOeunzASpgiZtmqBcMQFCNyf+Rvgr6/8APt0z5Z6
         aRSvt8U1MYsiu7MhSlTO1p4KlQCdmQjxwRjrl+UyLHy4wMYhDzvUoNNFGoQC3MAfRABt
         TrbA==
X-Gm-Message-State: APjAAAWPyF68cgFWxW2G8Bob4d7m2gmuDxn6pCgEUQenHJoOxt5awQVy
        5Qv9Ty5dvHmTVTWBPmTJQk8Yxw==
X-Google-Smtp-Source: APXvYqwD95JGqzibrj0+hiJ53FXfYwlzs+Nax94WXn3QiMp2CttxGXrUPGbM/+RXAYcNMz6EYxabWQ==
X-Received: by 2002:a17:90a:b902:: with SMTP id p2mr13370504pjr.62.1570751542284;
        Thu, 10 Oct 2019 16:52:22 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id t68sm6043305pgt.61.2019.10.10.16.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 16:52:21 -0700 (PDT)
Subject: Re: [PATCH] block: account statistics for passthrough requests
To:     Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>
References: <20191010233626.15998-1-logang@deltatee.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <303a3cd8-e95f-651d-83c2-d283a89a8208@kernel.dk>
Date:   Thu, 10 Oct 2019 17:52:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010233626.15998-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/19 5:36 PM, Logan Gunthorpe wrote:
> Presently, passthrough requests are not accounted for because
> blk_do_io_stat() expressly rejects them. Based on some digging
> in the history, this doesn't seem like a concious decision but
> one that evolved from the change from blk_fs_request() to
> blk_rq_is_passthrough().
> 
> To support this, call blk_account_io_start() in blk_execute_rq_nowait()
> and remove the passthrough check in blk_do_io_stat().

Looks good to me, applied.

-- 
Jens Axboe

