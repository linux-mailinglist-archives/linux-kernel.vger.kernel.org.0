Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F881A379F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 15:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfH3NQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 09:16:33 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:33492 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfH3NQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 09:16:32 -0400
Received: by mail-io1-f43.google.com with SMTP id z3so13949055iog.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 06:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ao7Wdofaa1sKJzWGbAawdHt4adOohg/VMTdip0vQIa4=;
        b=lgZ6msSPYo88sZa7ohX40wFMd3R9PsCKmRzFiRBVGvPEXWMUsGmTNK/bJNOMRsj8ZY
         WXeeZfOewC/GXAZFxEMiiN6P/Am+zJTjqZinv1txwUjp8aNd590Kl5fYCgOZ+zUZ0czY
         ZD/aT5v1ON/tS5f5hfu8TujR454GHVSfiTqeZpx2YLxG2WsIntIRy1IrsfGSmLuE/PR1
         anFGybLfMZbEsbMWKi52Lc0Lc4p1TDrpcit8uv+X6hV39EZMs7OJztcsb4aZcufQiAOj
         wJ3LztiUU7V0AIYp8KeRpZaeMl2TjKeRJoy0deDf5vgEa8gM/Tyf5dlQ065BHPCvywVz
         xn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ao7Wdofaa1sKJzWGbAawdHt4adOohg/VMTdip0vQIa4=;
        b=lWY7JaXTfSBuDTkQXY29NMnxOjMBSJxkQuI4YtakH44on6h0ej3m4Go+ttS7KuxwBJ
         Gm5rurkzKJNrsTcH1cuV2eSM0ig1klzRXDRANkZJeyEUwSBdEshexrJ+JYTM6TkyN+Cb
         gF9eDaFQRUAAoTXc8TtG+mJogI2XFol1AVH+xoiDdfApJSwVfkbZkAR+6hsj6Zd0KDR1
         usdCjslwILTZpR4IDSPG7FqA1FbvmScC3+qtc6qbEabKrIVvoexrzY10wBSfxxICZRMg
         W5jBK0VLfM45eZW6e9Yxm3wJ91eCS0k1ExpcR5uxf8es651+V6cIb/MBYctN5/3+/QR0
         QTBQ==
X-Gm-Message-State: APjAAAVHaPilTCz7b/4ZWj62Hvo7WvBd9/NuVVwHMquejZvr6pxo7hh/
        pXTGRjoRzmM25byY1LBGbExQr25oWNP0RQ==
X-Google-Smtp-Source: APXvYqyZwQo3R9eCAX7RKQJl8KgsD+8eb15pZBdtUzfE/XNeCx4wyJxuH9bF237vIg2miKtu62M59g==
X-Received: by 2002:a05:6602:c7:: with SMTP id z7mr18714299ioe.130.1567170991487;
        Fri, 30 Aug 2019 06:16:31 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l13sm5866169iob.73.2019.08.30.06.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 06:16:30 -0700 (PDT)
Subject: Re: [PATCH block/for-next] blkcg: add missing NULL check in
 ioc_cpd_alloc()
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190830131058.GY2263813@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <24a39d46-5c3e-9e45-bfaf-6d92448aea99@kernel.dk>
Date:   Fri, 30 Aug 2019 07:16:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830131058.GY2263813@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/19 7:10 AM, Tejun Heo wrote:
> ioc_cpd_alloc() forgot to check NULL return from kzalloc().  Add it.

Applied, thanks.

-- 
Jens Axboe

